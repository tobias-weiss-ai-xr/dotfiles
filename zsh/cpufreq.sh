powersave()
{
#set powersave mode to CPUs
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        do
                [ -f $CPUFREQ ] || continue
                sudo sh -c "echo -n 'powersave' > $CPUFREQ"
done
		echo "Switched to powersave mode"
}

performance()
{
#set powersave mode to CPUs
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        do
                [ -f $CPUFREQ ] || continue
                sudo sh -c "echo -n 'performance' > $CPUFREQ"
	done
		echo "Switched to performance mode"
}
