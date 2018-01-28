嵌套集模型（樹）
2018-01-28 19:23:03

#### 名詞解釋
##### Nested set model
維基百科對「[Nested set model](https://en.wikipedia.org/wiki/Nested_set_model)」的解釋：

> The nested set model is a particular technique for representing nested sets (also known 
> as [trees](https://en.wikipedia.org/wiki/Tree_(data_structure)) or 
> [hierarchies](https://en.wikipedia.org/wiki/Hierarchy)) in relational databases.

簡單講，即關係型數據庫里的樹形結構。

#### 應用舉例
具體開發里遇到的具有嵌套的層級結構，諸如: `分類表`、`菜單表`、`有歸屬關係的用戶表`，都可以基於樹實現。
  
下面以簡單的分類表作為示例，實現如下圖的結構(1-16為树遍历分配的编号)：

<embed src="assets/images/the-numbering-assigned-by-tree-traversal.svg"
type="image/svg+xml"
width="100%"
pluginspage="http://www.adobe.com/svg/viewer/install/" />

##### 數據表結構
    categories(id, name, _lft, _rgt, parent_id, created_at, updated_at)
    
categories 表大致的字段如上，與樹形結構相關的字段為 `_lft`, `_rgt`, `parent_id`：
*`_lft`* 和  *`_rgt`* 用於存儲節點的編號， *parent_id* 用於存儲父節點的 *`id`*。
  
  
詳細的表結構和示例數據參見*附件* 👉 [categories.sql](assets/attachments/2018/0128/categories.sql)

<style>
.data-table {
    line-height: 1.6;
    border-collapse: collapse;
    width: 80%;
}
.data-table thead {
    background: RGBA(240, 243, 245, 1.00);
}

.data-table th,.data-table td {
    width: 20%;
    text-align: center;
    border-bottom:1px solid #DDD;
}
.data-table tbody tr:nth-child(even) {
    background: RGBA(247, 247, 247, 1.00);
}
.data-table tbody tr:nth-child(odd) {
    background: RGBA(255, 255, 255, 1.00);
}
</style>
<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>name</th>
            <th>_lft</th>
            <th>_rgt</th>
            <th>parent_id</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="id">1</td>
            <td class="name">技術</td>
            <td class="_lft">1</td>
            <td class="_rgt">16</td>
            <td class="pid">NULL</td>
        </tr>
        <tr>
            <td class="id">2</td>
            <td class="name">前端</td>
            <td class="_lft">2</td>
            <td class="_rgt">9</td>
            <td class="pid">1</td>
        </tr>
        <tr>
            <td class="id">3</td>
            <td class="name">JavaScript</td>
            <td class="_lft">3</td>
            <td class="_rgt">4</td>
            <td class="pid">2</td>
        </tr>
        <tr>
            <td class="id">4</td>
            <td class="name">CSS</td>
            <td class="_lft">5</td>
            <td class="_rgt">6</td>
            <td class="pid">2</td>
        </tr>
        <tr>
            <td class="id">5</td>
            <td class="name">HTML</td>
            <td class="_lft">7</td>
            <td class="_rgt">8</td>
            <td class="pid">2</td>
        </tr>
        <tr>
            <td class="id">6</td>
            <td class="name">後端</td>
            <td class="_lft">10</td>
            <td class="_rgt">15</td>
            <td class="pid">1</td>
        </tr>
        <tr>
            <td class="id">7</td>
            <td class="name">SQL</td>
            <td class="_lft">11</td>
            <td class="_rgt">12</td>
            <td class="pid">6</td>
            <td></td>
        </tr>
        <tr>
            <td class="id">8</td>
            <td class="name">PHP</td>
            <td class="_lft">13</td>
            <td class="_rgt">14</td>
            <td class="pid">6</td>
            <td></td>
        </tr>
    </tbody>
</table>
<br>
  
  
#### 查詢 SQL
   
   
##### 插入後代節點
往節點「後段」插入多一個子節點「Linux」：
    
按圖中遍歷順序，在「後端」節點後面才遍歷到的兄弟／父親節點左右編號需要調整，插入最好在一個事務里操作。
    
    update `categories` set  
        `_lft` = case 
            when `_lft` >= 15 then `_lft`+2 
            else `_lft` end, 
        `_rgt` = case 
            when `_rgt` >= 15 then `_rgt`+2 
            else `_rgt` end 
        where 
            (`_lft` >= 15 or `_rgt` >= 15);
            

  
    

    
    insert into `categories` 
        (`name`, `parent_id`, `_lft`, `_rgt`, `created_at`) 
    values 
        ("Linux", 6, 15, 16, "2018-01-28 10:10:00");
        

   
   
##### 查詢後代節點
以節點「後端」為例，查詢子節點：
    
    select * from `categories` 
    where `_lft` between 10 and 17 and id <>6;
    

   
##### 查詢祖先節點
以節點「後端」為例，查詢其祖先節點：
    
    select * from `categories` 
      where 
        (select `_`.`_rgt` from `categories` as `_` 
             where `id` = 6 limit 1) 
        between `_lft` and `_rgt`
      and 
        `id` <> 6;
        

   
##### 樹的深度（分類級別）
記根節點所在的層深度為0，則其子節點深度為1，依次類推。
查詢節點「後端」的深度：
    
    select count(*) from `categories` as `_d` 
      where 
        (10 between `_d`.`_lft` and `_d`.`_rgt`)
      and 
         `_d`.`_lft` <> 10; 
         

   
#### PHP 相關的 PKG
- [etrepat/baum](https://github.com/etrepat/baum)
- [laravel-nestedset](https://github.com/lazychaser/laravel-nestedset)
