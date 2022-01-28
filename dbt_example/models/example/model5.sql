
-- Use the `ref` function to select from other models

select m3.id as m3_id, 
      m4.id as m4_id

from {{ ref('model3') }} as m3
    inner join {{ ref('model4') }} as m4 
    on m3.id=m4.id

