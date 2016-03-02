use strict;
use Linux::MemInfo;
my %mem;
my $count;
# Starting values
%mem = get_mem_info;
printf("%-20s\t%s\n","Active(file)",$mem{"Active(file)"});
printf("%-20s\t%s\n","Active(anon)",$mem{"Active(anon)"});

while() {
	sleep 1;
	$count++;
	# Create a 10MB file full of zeros and then read it to fill the Active(file) cache from /proc/meminfo
	my $retval=system("/bin/dd if=/dev/zero of=/tmp/file.${count} count=20480 > /dev/null 2>&1");
	open(my $fh, "</tmp/${count}");
	while ( <$fh>){}

	# Get memory statistics after creating and reading a 5MB file, watch Active(file) grow until it is 5MB
	%mem = get_mem_info;
	my $time = localtime;
	printf("%s\n",$time);
	printf("%-20s\t%s\n","Active(file)",$mem{"Active(file)"});
	printf("%-20s\t%s\n","Inactive(file)",$mem{"Inactive(file)"});
	printf("%-20s\t%s\n\n","MemFree",$mem{"MemFree"});
}
	

