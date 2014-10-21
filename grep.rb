#!/usr/bin/env ruby


case ARGV[0]
when '-A'
	opt=1
when '-e'
	opt=2
when '-R'
	opt=3
when '-z'
	opt=4
else opt=-1
end

k=0
arg=0
if opt==1 then
	arg=ARGV[1].to_i
	k=1
elsif opt==-1 then k=-1
end
dir=[]
s=ARGV[1+k]
dir_count=0
while ARGV[2+dir_count+k]!=nil
	dir[dir_count]=ARGV[2+k+dir_count]
	dir_count+=1
end
b=[]
if opt==3 
	then b=Dir.entries('./')
	dir_count=1
end	


for i in 1..dir_count
	a=[]
	c=0
	if opt!=3 then 
		f=File.open(dir[i-1])
		f.each {|line| a<<line; c+=1}
	end	
	num=[]

	case opt
	when -1 							
		a.each do |str|
			if str.include? s then puts str
			end
		end
	when 1 								#option = -A
		l=0
		a.each do |str|
			#puts str
			if str.include? s then num<<l
			end
			l+=1
		end
		
		num.each do |j|
			a1=j-arg
			a2=j+arg
			if a1<0 then a1=0
			end
			if a2>(l-1) then a2=l-1
			end
			for i in a1..a2
				puts a[i]
			end
			
		end
	when 2								#option = -e
		str=''	
		flag=0
		if s.index('[')==0 
			then flag=1
		end
		s1=s[s.index('^')+1...s.index(']')]
		
		str=s.delete(s[s.index('[')..s.index(']')])
		count=0
		a.each do |l|
			st=l
			p=0
			st=st.chomp		
			while st.include?(str) 
				#puts p
				a1=st.index(str,p)
				if a1==nil || p>st.length then break
				end
				
				if flag==0 && st[a1+str.length]!=s1 && (a1+str.length)<=(st.length-1)
					then puts st
						 p=a1+1
					elsif flag==1 && (a1-1)>=0 && st[a1-1]!=s1
						then puts st
							 p=a1+1
				end
				if p!=0 then break
				end
				p=a1+1;
				#puts st
				count+=1
			end
		end 
	when 3
		#puts b
		b.each do |i|
			if i!='.' && i!='..' then
				f=File.open(i)
				f.each do |line| 
					if line.include? s then puts line
					end
				end
			end
		end 
	end

end
