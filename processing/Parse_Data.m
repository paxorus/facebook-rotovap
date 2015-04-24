function data = Parse_Data (file)
   vec=importdata(file);
   n=size(vec);
   n=n(1);
   data=cell(n/3,1);
   for i=1:n/3
      str1=vec{3*i-2};
      str1=str1(1:end-1);
      str2=vec{3*i-1};
      str2=str2(2:end-1);
      str3=vec{3*i};
      str3=str3(2:end);
      str=[str1 ',' str2 ',' str3];
      data{i}=parse_json(str);
   end
end