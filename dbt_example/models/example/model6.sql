
-- Use the `ref` function to select from other models




select m3.id as m3_id, 
      m4.m4_id as m4_id

from {{ ref('model2') }} as m3
    inner join {{ ref('model5') }} as m4 
    on m3.id=m4.m4_id

