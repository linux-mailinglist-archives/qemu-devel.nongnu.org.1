Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F97E3A3A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:49:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JdR-0001aK-6p; Tue, 07 Nov 2023 05:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r0JdO-0001Zx-VU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:48:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r0JdK-0001SZ-02
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:48:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84D4D33788;
 Tue,  7 Nov 2023 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699354112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwTP81A2nTzlf94ZabuDWAHxAiFNbYsgdfLSlY/BFIQ=;
 b=fNS1yYBlJ3GNw1QnK0JeloI6yeg/ZaJTQaVUSDEpz1SYY1PHVN0uZkRkKgdjf6vsZ1UWqy
 SpPgxh/e1aA2DtIu966r9vco5qLKbrTIS3/YySL4SFLv1Ja4NqhuP9BF+/wFviSRCb2/a2
 gHKg+6RwcDKsKlX5BiSDrpdIymF727k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699354112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwTP81A2nTzlf94ZabuDWAHxAiFNbYsgdfLSlY/BFIQ=;
 b=w48ED4h+ycuczSTH3u0ZW5MARMVcamrQyIgFPlyE9fVEJq2yoPqkxlFRZDvV4jxUAI2a0K
 K+kTYObsTpUVNrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1395D13907;
 Tue,  7 Nov 2023 10:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xmWPAgAWSmWdEwAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 07 Nov 2023 10:48:32 +0000
Message-ID: <8aa3d259-6dd5-ebf7-8989-66b967434773@suse.de>
Date: Tue, 7 Nov 2023 11:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PULL 4/6] seabios: update binaries to git snapshot
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Jim Fehlig <jfehlig@suse.com>
References: <20231010112610.2618091-1-kraxel@redhat.com>
 <20231010112610.2618091-5-kraxel@redhat.com>
 <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
 <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/7/23 11:35, Gerd Hoffmann wrote:
>   Hi,
> 
>> Trying to install a simple centos7 iso for testing as in:
>>
>> IMAGESDIR=/images
>> ISO=${IMAGESDIR}/CentOS-7-x86_64-Minimal-2009.iso
> 
> Oh, you are running a software museum ;)
> 
>> ================================================================================
>> Probing storage...
>> Installation Destination
> 
> If you came that far the linux kernel has been booted.
> Do you have a kernel log for me?
> 
> Also, what does "lscpu | grep -i address" print (on the host)?
> 
> take care,
>   Gerd
> 

Hi, thanks for the response,

just to be sure, this is a regression (it worked fine prior to the seabios update).

====
Host lscpu:
====

# lscpu | grep -i address
Address sizes:                      43 bits physical, 48 bits virtual

====
Full guest log:
====

Formatting '/gehc/centos7.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=32212254720 lazy_refcounts=off refcount_bits=16

Starting install...
Retrieving 'vmlinuz'                                                                                                 |    0 B  00:00:00 ... 
Retrieving 'initrd.img'                                                                                              |    0 B  00:00:00 ... 
Creating domain...                                                                                                   |    0 B  00:00:00     
Running text console command: virsh --connect qemu:///system console centos7
Connected to domain 'centos7'
Escape character is ^] (Ctrl + ])
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.0-1160.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC) ) #1 SMP Mon Oct 19 16:18:59 UTC 2020
[    0.000000] Command line: console=ttyS0
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffdc000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207fffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: last_pfn = 0x2080000 max_arch_pfn = 0x400000000
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- UC  
[    0.000000] e820: last_pfn = 0x7ffdc max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f5460-0x000f546f] mapped at [ffffffffff200460]
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x7cb3c000-0x7ffcffff]
[    0.000000] Early table checksum verification disabled
[    0.000000] ACPI: RSDP 00000000000f5420 00014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 000000007ffe28c6 00034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 000000007ffe26ee 000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 000000007ffdfcc0 02A2E (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 000000007ffdfc80 00040
[    0.000000] ACPI: APIC 000000007ffe27e2 00080 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 000000007ffe2862 0003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: WAET 000000007ffe289e 00028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000207fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x207ffd9000-0x207fffffff]
[    0.000000] kvm-clock: cpu 0, msr 20:7ff88001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 377492173 cycles
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x207fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x7ffdbfff]
[    0.000000]   node   0: [mem 0x100000000-0x207fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x207fffffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ffdc000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xafffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xb0000000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfeffbfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] Detected CPU family 19h model 1
[    0.000000] Warning: AMD Processor - this hardware has not undergone upstream testing. Please consult http://wiki.centos.org/FAQ for more information
[    0.000000] setup_percpu: NR_CPUS:5120 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 38 pages/cpu s118784 r8192 d28672 u1048576
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 207fc1c040
[    0.000000] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 33029989
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyS0
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] x86/fpu: xstate_offset[2]: 0240, xstate_sizes[2]: 0100
[    0.000000] x86/fpu: xstate_offset[3]: 0000, xstate_sizes[3]: 0000
[    0.000000] x86/fpu: xstate_offset[4]: 0000, xstate_sizes[4]: 0000
[    0.000000] x86/fpu: xstate_offset[5]: 0000, xstate_sizes[5]: 0000
[    0.000000] x86/fpu: xstate_offset[6]: 0000, xstate_sizes[6]: 0000
[    0.000000] x86/fpu: xstate_offset[7]: 0000, xstate_sizes[7]: 0000
[    0.000000] x86/fpu: xstate_offset[8]: 0000, xstate_sizes[8]: 0000
[    0.000000] x86/fpu: xstate_offset[9]: 0980, xstate_sizes[9]: 0008
[    0.000000] xsave: enabled xstate_bv 0x207, cntxt size 0x988 using standard form
[    0.000000] Memory: 4074276k/136314880k available (7788k kernel code, 2097688k absent, 2237188k reserved, 5954k data, 1984k init)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=5120 to nr_cpu_ids=2.
[    0.000000] NR_IRQS:327936 nr_irqs:440 0
[    0.000000] Console: colour *CGA 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] allocated 3489660928 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] tsc: Detected 2794.750 MHz processor
[    0.000000] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.003000] Calibrating delay loop (skipped) preset value.. 5589.50 BogoMIPS (lpj=2794750)
[    0.004004] pid_max: default: 32768 minimum: 301
[    0.004751] Security Framework initialized
[    0.005007] SELinux:  Initializing.
[    0.006009] Yama: becoming mindful.
[    0.011533] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.025609] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.032063] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.033077] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.034399] Initializing cgroup subsys memory
[    0.035006] Initializing cgroup subsys devices
[    0.036004] Initializing cgroup subsys freezer
[    0.036708] Initializing cgroup subsys net_cls
[    0.037003] Initializing cgroup subsys blkio
[    0.038003] Initializing cgroup subsys perf_event
[    0.039004] Initializing cgroup subsys hugetlb
[    0.039709] Initializing cgroup subsys pids
[    0.040003] Initializing cgroup subsys net_prio
[    0.041138] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.042305] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.043003] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.044003] tlb_flushall_shift: 6
[    0.045069] FEATURE SPEC_CTRL Present
[    0.045655] FEATURE IBPB_SUPPORT Present
[    0.046003] Spectre V1 : Mitigation: Load fences, usercopy/swapgs barriers and __user pointer sanitization
[    0.047003] Spectre V2 : Enabling Indirect Branch Prediction Barrier
[    0.049202] Spectre V2 : Mitigation: Full retpoline
[    0.050026] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.055088] Freeing SMP alternatives: 28k freed
[    0.067731] ACPI: Core revision 20130517
[    0.068508] ACPI: All ACPI Tables successfully acquired
[    0.069605] ftrace: allocating 29651 entries in 116 pages
[    0.083305] Enabling x2apic
[    0.083778] Enabled x2apic
[    0.084004] Switched APIC routing to physical x2apic.
[    0.087293] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.088001] smpboot: CPU0: AMD EPYC 7543 32-Core Processor (fam: 19, model: 01, stepping: 01)
[    0.089571] Performance Events: 
[    0.090000] core perfctr but no constraints; unknown hardware!
[    0.090005] no PMU driver, software events only.
[    0.090724] KVM setup paravirtual spinlock
[    0.091943] smpboot: Booting Node   0, Processors  #1 OK
[    0.091881] kvm-clock: cpu 1, msr 20:7ff88041, secondary cpu clock
[    0.091881] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.095247] Brought up 2 CPUs
[    0.095226] KVM setup async PF for cpu 1
[    0.095226] kvm-stealtime: cpu 1, msr 207fd1c040
[    0.096713] smpboot: Max logical packages: 2
[    0.097004] smpboot: Total of 2 processors activated (11179.00 BogoMIPS)
[    0.455470] node 0 initialised, 31419376 pages in 357ms
[    0.456115] devtmpfs: initialized
[    0.457048] x86/mm: Memory block size: 2048MB
[    0.458692] EVM: security.selinux
[    0.459005] EVM: security.ima
[    0.459465] EVM: security.capability
[    0.460745] atomic64 test passed for x86-64 platform with CX8 and with SSE
[    0.461012] pinctrl core: initialized pinctrl subsystem
[    0.461944] RTC time: 10:38:44, date: 11/07/23
[    0.462060] NET: Registered protocol family 16
[    0.462822] cpuidle: using governor haltpoll
[    0.464008] ACPI: bus type PCI registered
[    0.464638] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.465121] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000-0xbfffffff] (base 0xb0000000)
[    0.466005] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E820
[    0.467009] PCI: Using configuration type 1 for base access
[    0.471067] ACPI: Added _OSI(Module Device)
[    0.472011] ACPI: Added _OSI(Processor Device)
[    0.472681] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.473004] ACPI: Added _OSI(Processor Aggregator Device)
[    0.473829] ACPI: Added _OSI(Linux-Dell-Video)
[    0.476075] ACPI: Interpreter enabled
[    0.476652] ACPI: (supports S0 S5)
[    0.477005] ACPI: Using IOAPIC for interrupt routing
[    0.477781] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.478055] ACPI: Enabled 2 GPEs in block 00 to 3F
[    0.480222] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.481008] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.482054] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug]
[    0.483041] acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
[    0.484251] PCI host bridge to bus 0000:00
[    0.484883] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.485007] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.486004] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.487004] pci_bus 0000:00: root bus resource [mem 0x80000000-0xafffffff window]
[    0.488003] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.489004] pci_bus 0000:00: root bus resource [mem 0xe00000000000-0xe1bfffffffff window]
[    0.490005] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.610897] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    0.637226] acpiphp: Slot [0] registered
[    0.652719] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.653235] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.656194] acpiphp: Slot [0-2] registered
[    0.664447] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.1 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.665231] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.668174] acpiphp: Slot [0-3] registered
[    0.683717] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.2 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.684229] pci 0000:00:01.2: PCI bridge to [bus 03]
[    0.686221] acpiphp: Slot [0-4] registered
[    0.702360] pci 0000:04:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.3 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.703231] pci 0000:00:01.3: PCI bridge to [bus 04]
[    0.706164] acpiphp: Slot [0-5] registered
[    0.714690] pci 0000:05:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.4 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.715229] pci 0000:00:01.4: PCI bridge to [bus 05]
[    0.718162] acpiphp: Slot [0-6] registered
[    0.731709] pci 0000:06:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.5 (capable of 7.876 Gb/s with 8 GT/s x1 link)
[    0.732230] pci 0000:00:01.5: PCI bridge to [bus 06]
[    0.735143] acpiphp: Slot [0-7] registered
[    0.735791] pci 0000:00:01.6: PCI bridge to [bus 07]
[    0.737206] acpiphp: Slot [0-8] registered
[    0.737854] pci 0000:00:01.7: PCI bridge to [bus 08]
[    0.740095] acpiphp: Slot [0-9] registered
[    0.740746] pci 0000:00:02.0: PCI bridge to [bus 09]
[    0.742200] acpiphp: Slot [0-10] registered
[    0.742869] pci 0000:00:02.1: PCI bridge to [bus 0a]
[    0.744200] acpiphp: Slot [0-11] registered
[    0.744861] pci 0000:00:02.2: PCI bridge to [bus 0b]
[    0.748202] acpiphp: Slot [0-12] registered
[    0.748864] pci 0000:00:02.3: PCI bridge to [bus 0c]
[    0.750198] acpiphp: Slot [0-13] registered
[    0.750867] pci 0000:00:02.4: PCI bridge to [bus 0d]
[    0.752203] acpiphp: Slot [0-14] registered
[    0.752870] pci 0000:00:02.5: PCI bridge to [bus 0e]
[    0.771019] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.772034] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.773042] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.774073] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.775490] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    0.776310] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    0.777310] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    0.778309] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    0.779279] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    0.780082] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    0.780925] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    0.781149] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    0.781994] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    0.782149] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    0.783005] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    0.783851] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    0.784328] vgaarb: loaded
[    0.784826] SCSI subsystem initialized
[    0.785033] ACPI: bus type USB registered
[    0.785683] usbcore: registered new interface driver usbfs
[    0.786011] usbcore: registered new interface driver hub
[    0.786850] usbcore: registered new device driver usb
[    0.787066] EDAC MC: Ver: 3.0.0
[    0.788151] PCI: Using ACPI for IRQ routing
[    0.853280] NetLabel: Initializing
[    0.853815] NetLabel:  domain hash size = 128
[    0.854006] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.854780] NetLabel:  unlabeled traffic allowed by default
[    0.855048] amd_nb: Cannot enumerate AMD northbridges
[    0.855857] Switched to clocksource kvm-clock
[    0.858792] pnp: PnP ACPI init
[    0.859292] ACPI: bus type PNP registered
[    0.860101] system 00:04: [mem 0xb0000000-0xbfffffff window] has been reserved
[    0.861357] pnp: PnP ACPI: found 5 devices
[    0.862015] ACPI: bus type PNP unregistered
[    0.868054] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.868994] pci 0000:00:01.1: BAR 13: assigned [io  0x2000-0x2fff]
[    0.869946] pci 0000:00:01.2: BAR 13: assigned [io  0x3000-0x3fff]
[    0.870904] pci 0000:00:01.3: BAR 13: assigned [io  0x4000-0x4fff]
[    0.871865] pci 0000:00:01.4: BAR 13: assigned [io  0x5000-0x5fff]
[    0.872825] pci 0000:00:01.5: BAR 13: assigned [io  0x6000-0x6fff]
[    0.873792] pci 0000:00:01.6: BAR 13: assigned [io  0x7000-0x7fff]
[    0.874751] pci 0000:00:01.7: BAR 13: assigned [io  0x8000-0x8fff]
[    0.875710] pci 0000:00:02.0: BAR 13: assigned [io  0x9000-0x9fff]
[    0.876667] pci 0000:00:02.1: BAR 13: assigned [io  0xa000-0xafff]
[    0.877625] pci 0000:00:02.2: BAR 13: assigned [io  0xb000-0xbfff]
[    0.878594] pci 0000:00:02.3: BAR 13: assigned [io  0xd000-0xdfff]
[    0.879554] pci 0000:00:02.4: BAR 13: assigned [io  0xe000-0xefff]
[    0.880511] pci 0000:00:02.5: BAR 13: assigned [io  0xf000-0xffff]
[    0.881472] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.882262] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
[    0.886991] pci 0000:00:01.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    0.890308] pci 0000:00:01.0:   bridge window [mem 0xe1a000000000-0xe1bfffffffff 64bit pref]
[    0.896063] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.896830] pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
[    0.901169] pci 0000:00:01.1:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.904952] pci 0000:00:01.1:   bridge window [mem 0xe18000000000-0xe19fffffffff 64bit pref]
[    0.911449] pci 0000:00:01.2: PCI bridge to [bus 03]
[    0.912226] pci 0000:00:01.2:   bridge window [io  0x3000-0x3fff]
[    0.916035] pci 0000:00:01.2:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.921135] pci 0000:00:01.2:   bridge window [mem 0xe16000000000-0xe17fffffffff 64bit pref]
[    0.925990] pci 0000:00:01.3: PCI bridge to [bus 04]
[    0.926776] pci 0000:00:01.3:   bridge window [io  0x4000-0x4fff]
[    0.930542] pci 0000:00:01.3:   bridge window [mem 0xfe200000-0xfe3fffff]
[    0.933661] pci 0000:00:01.3:   bridge window [mem 0xe14000000000-0xe15fffffffff 64bit pref]
[    0.939421] pci 0000:00:01.4: PCI bridge to [bus 05]
[    0.941987] pci 0000:00:01.4:   bridge window [io  0x5000-0x5fff]
[    0.945840] pci 0000:00:01.4:   bridge window [mem 0xfe000000-0xfe1fffff]
[    0.948686] pci 0000:00:01.4:   bridge window [mem 0xe12000000000-0xe13fffffffff 64bit pref]
[    0.956345] pci 0000:00:01.5: PCI bridge to [bus 06]
[    0.957118] pci 0000:00:01.5:   bridge window [io  0x6000-0x6fff]
[    0.960734] pci 0000:00:01.5:   bridge window [mem 0xfde00000-0xfdffffff]
[    0.963547] pci 0000:00:01.5:   bridge window [mem 0xe10000000000-0xe11fffffffff 64bit pref]
[    0.970183] pci 0000:00:01.6: PCI bridge to [bus 07]
[    0.970955] pci 0000:00:01.6:   bridge window [io  0x7000-0x7fff]
[    0.974541] pci 0000:00:01.6:   bridge window [mem 0xfdc00000-0xfddfffff]
[    0.977405] pci 0000:00:01.6:   bridge window [mem 0xe0e000000000-0xe0ffffffffff 64bit pref]
[    0.982580] pci 0000:00:01.7: PCI bridge to [bus 08]
[    0.983361] pci 0000:00:01.7:   bridge window [io  0x8000-0x8fff]
[    0.989589] pci 0000:00:01.7:   bridge window [mem 0xfda00000-0xfdbfffff]
[    0.992463] pci 0000:00:01.7:   bridge window [mem 0xe0c000000000-0xe0dfffffffff 64bit pref]
[    0.997289] pci 0000:00:02.0: PCI bridge to [bus 09]
[    1.000038] pci 0000:00:02.0:   bridge window [io  0x9000-0x9fff]
[    1.004562] pci 0000:00:02.0:   bridge window [mem 0xfd800000-0xfd9fffff]
[    1.007359] pci 0000:00:02.0:   bridge window [mem 0xe0a000000000-0xe0bfffffffff 64bit pref]
[    1.012242] pci 0000:00:02.1: PCI bridge to [bus 0a]
[    1.013015] pci 0000:00:02.1:   bridge window [io  0xa000-0xafff]
[    1.016699] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd7fffff]
[    1.019550] pci 0000:00:02.1:   bridge window [mem 0xe08000000000-0xe09fffffffff 64bit pref]
[    1.027379] pci 0000:00:02.2: PCI bridge to [bus 0b]
[    1.028149] pci 0000:00:02.2:   bridge window [io  0xb000-0xbfff]
[    1.031744] pci 0000:00:02.2:   bridge window [mem 0xfd400000-0xfd5fffff]
[    1.037440] pci 0000:00:02.2:   bridge window [mem 0xe06000000000-0xe07fffffffff 64bit pref]
[    1.042387] pci 0000:00:02.3: PCI bridge to [bus 0c]
[    1.043167] pci 0000:00:02.3:   bridge window [io  0xd000-0xdfff]
[    1.046843] pci 0000:00:02.3:   bridge window [mem 0xfd200000-0xfd3fffff]
[    1.049699] pci 0000:00:02.3:   bridge window [mem 0xe04000000000-0xe05fffffffff 64bit pref]
[    1.054743] pci 0000:00:02.4: PCI bridge to [bus 0d]
[    1.057677] pci 0000:00:02.4:   bridge window [io  0xe000-0xefff]
[    1.061944] pci 0000:00:02.4:   bridge window [mem 0xfd000000-0xfd1fffff]
[    1.064754] pci 0000:00:02.4:   bridge window [mem 0xe02000000000-0xe03fffffffff 64bit pref]
[    1.072233] pci 0000:00:02.5: PCI bridge to [bus 0e]
[    1.073012] pci 0000:00:02.5:   bridge window [io  0xf000-0xffff]
[    1.076672] pci 0000:00:02.5:   bridge window [mem 0xfce00000-0xfcffffff]
[    1.079559] pci 0000:00:02.5:   bridge window [mem 0xe00000000000-0xe01fffffffff 64bit pref]
[    1.084407] NET: Registered protocol family 2
[    1.085416] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.087972] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.091102] TCP: Hash tables configured (established 524288 bind 65536)
[    1.092143] TCP: reno registered
[    1.092727] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    1.094798] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    1.096885] NET: Registered protocol family 1
[    1.097935] ACPI: PCI Interrupt Link [GSIF] enabled at IRQ 21
[    1.102290] Unpacking initramfs...
[    4.224046] Freeing initrd memory: 53840k freed
[    4.229058] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.230085] software IO TLB [mem 0x78b3c000-0x7cb3c000] (64MB) mapped at [ffffa09238b3c000-ffffa0923cb3bfff]
[    4.232037] sha1_ssse3: Using SHA-NI optimized SHA-1 implementation
[    4.233105] sha256_ssse3: Using SHA-256-NI optimized SHA-256 implementation
[    4.234486] futex hash table entries: 512 (order: 3, 32768 bytes)
[    4.235467] Initialise system trusted keyring
[    4.236177] audit: initializing netlink socket (disabled)
[    4.237038] type=2000 audit(1699353527.573:1): initialized
[    4.255668] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    4.256661] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.258552] zpool: loaded
[    4.258977] zbud: loaded
[    4.259566] VFS: Disk quotas dquot_6.5.2
[    4.260216] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.261355] Key type big_key registered
[    4.262940] NET: Registered protocol family 38
[    4.263660] Key type asymmetric registered
[    4.264314] Asymmetric key parser 'x509' registered
[    4.265107] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    4.266326] io scheduler noop registered
[    4.266944] io scheduler deadline registered (default)
[    4.267776] io scheduler cfq registered
[    4.268393] io scheduler mq-deadline registered
[    4.269112] io scheduler kyber registered
[    4.300099] ACPI: PCI Interrupt Link [GSIG] enabled at IRQ 22
[    4.328544] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    4.329618] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    4.330715] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    4.331803] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    4.332875] pcieport 0000:00:01.2: Signaling PME through PCIe PME interrupt
[    4.333973] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    4.335057] pcieport 0000:00:01.3: Signaling PME through PCIe PME interrupt
[    4.336144] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    4.337217] pcieport 0000:00:01.4: Signaling PME through PCIe PME interrupt
[    4.338338] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    4.339417] pcieport 0000:00:01.5: Signaling PME through PCIe PME interrupt
[    4.340504] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    4.341579] pcieport 0000:00:01.6: Signaling PME through PCIe PME interrupt
[    4.342733] pcieport 0000:00:01.7: Signaling PME through PCIe PME interrupt
[    4.343877] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    4.345026] pcieport 0000:00:02.1: Signaling PME through PCIe PME interrupt
[    4.346178] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    4.347318] pcieport 0000:00:02.3: Signaling PME through PCIe PME interrupt
[    4.348459] pcieport 0000:00:02.4: Signaling PME through PCIe PME interrupt
[    4.349597] pcieport 0000:00:02.5: Signaling PME through PCIe PME interrupt
[    4.350726] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.351605] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    4.352646] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.353801] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    4.354961] ACPI: Power Button [PWRF]
[    4.355664] GHES: HEST is not enabled!
[    4.356346] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.382645] 00:00: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.383790] Non-volatile memory driver v1.3
[    4.384475] Linux agpgart interface v0.103
[    4.385225] crash memory driver: version 1.1
[    4.385934] rdac: device handler registered
[    4.386646] hp_sw: device handler registered
[    4.387323] emc: device handler registered
[    4.388020] alua: device handler registered
[    4.388723] libphy: Fixed MDIO Bus: probed
[    4.389399] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.390567] ehci-pci: EHCI PCI platform driver
[    4.391443] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.392458] ohci-pci: OHCI PCI platform driver
[    4.393157] uhci_hcd: USB Universal Host Controller Interface driver
[    4.395845] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    4.396687] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
[    4.398139] xhci_hcd 0000:02:00.0: hcc params 0x00087001 hci version 0x100 quirks 0x0000000000000010
[    4.400144] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 3.10
[    4.401418] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.402551] usb usb1: Product: xHCI Host Controller
[    4.403310] usb usb1: Manufacturer: Linux 3.10.0-1160.el7.x86_64 xhci-hcd
[    4.404357] usb usb1: SerialNumber: 0000:02:00.0
[    4.405142] hub 1-0:1.0: USB hub found
[    4.405833] hub 1-0:1.0: 15 ports detected
[    4.407036] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    4.407863] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    4.409011] xhci_hcd 0000:02:00.0: Host supports USB 3.0  SuperSpeed
[    4.410040] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.411298] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 3.10
[    4.412577] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.413690] usb usb2: Product: xHCI Host Controller
[    4.414471] usb usb2: Manufacturer: Linux 3.10.0-1160.el7.x86_64 xhci-hcd
[    4.415517] usb usb2: SerialNumber: 0000:02:00.0
[    4.416289] hub 2-0:1.0: USB hub found
[    4.416954] hub 2-0:1.0: 15 ports detected
[    4.418176] usbcore: registered new interface driver usbserial_generic
[    4.419197] usbserial: USB Serial support registered for generic
[    4.420156] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    4.422171] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.422940] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.423787] mousedev: PS/2 mouse device common for all mice
[    4.424988] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    4.426560] rtc_cmos 00:03: RTC can wake from S4
[    4.427462] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input2
[    4.427927] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    4.430828] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    4.431907] rtc_cmos 00:03: alarms up to one day, y3k, 242 bytes nvram
[    4.433575] hidraw: raw HID events driver (C) Jiri Kosina
[    4.434552] usbcore: registered new interface driver usbhid
[    4.435430] usbhid: USB HID core driver
[    4.436127] drop_monitor: Initializing network drop monitor service
[    4.437184] TCP: cubic registered
[    4.437701] Initializing XFRM netlink socket
[    4.438460] NET: Registered protocol family 10
[    4.439330] NET: Registered protocol family 17
[    4.440059] mpls_gso: MPLS GSO support
[    4.440780] mce: Using 10 MCE banks
[    4.441525] Loading compiled-in X.509 certificates
[    4.442343] Loaded X.509 cert 'CentOS Linux kpatch signing key: ea0413152cde1d98ebdca3fe6f0230904c9ef717'
[    4.443828] Loaded X.509 cert 'CentOS Linux Driver update signing key: 7f421ee0ab69461574bb358861dbe77762a4201b'
[    4.445670] Loaded X.509 cert 'CentOS Linux kernel signing key: e1fdb0e2a7e861a1d1ca80a23dcf0dba3aa4adf5'
[    4.447275] registered taskstats version 1
[    4.447943] page_owner is disabled
[    4.450511] Key type trusted registered
[    4.453048] Key type encrypted registered
[    4.453687] IMA: No TPM chip found, activating TPM-bypass! (rc=-19)
[    4.455527] BERT: Boot Error Record Table support is disabled. Enable it by using bert_enable as kernel parameter.
[    4.457211]   Magic number: 15:197:628
[    4.457834] pci_bus 0000:0a: hash matches
[    4.458564] rtc_cmos 00:03: setting system clock to 2023-11-07 10:38:48 UTC (1699353528)
[    4.460614] Freeing unused kernel memory: 1984k freed
[    4.461708] Write protecting the kernel read-only data: 12288k
[    4.463097] Freeing unused kernel memory: 392k freed
[    4.464403] Freeing unused kernel memory: 536k freed
[    4.467615] random: systemd: uninitialized urandom read (16 bytes read)
[    4.469188] random: systemd: uninitialized urandom read (16 bytes read)
[    4.470276] random: systemd: uninitialized urandom read (16 bytes read)
[    4.472377] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    4.475159] systemd[1]: Detected virtualization kvm.
[    4.475928] systemd[1]: Detected architecture x86-64.
[    4.476715] systemd[1]: Running in initial RAM disk.

Welcome to CentOS Linux 7 (Core) dracut-033-572.el7 (Initramfs)!

[    4.478897] systemd[1]: No hostname configured.
[    4.479622] systemd[1]: Set hostname to <localhost>.
[    4.480456] systemd[1]: Initializing machine ID from KVM UUID.
[    4.484288] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
[    4.497437] random: systemd: uninitialized urandom read (16 bytes read)
[    4.498506] random: systemd: uninitialized urandom read (16 bytes read)
[    4.499542] random: systemd: uninitialized urandom read (16 bytes read)
[    4.500591] random: systemd: uninitialized urandom read (16 bytes read)
[    4.502054] random: systemd: uninitialized urandom read (16 bytes read)
[    4.503162] random: systemd: uninitialized urandom read (16 bytes read)
[    4.506905] systemd[1]: Cannot add dependency job for unit blk-availability.service, ignoring: Unit not found.
[    4.508598] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[    4.510300] systemd[1]: Reached target Local Encrypted Volumes.
[  OK  ] Reached target Local Encrypted Volumes.
[    4.512408] systemd[1]: Reached target Local File Systems.
[  OK  ] Reached target Local File Systems.
[    4.514409] systemd[1]: Reached target Timers.
[  OK  ] Reached target Timers.
[    4.516187] systemd[1]: Created slice Root Slice.
[  OK  ] Created slice Root Slice.
[    4.518382] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[    4.520179] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[    4.521881] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    4.523816] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    4.525821] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    4.528039] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[    4.530616] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Starting Create list of required st... nodes for the current kernel...
[    4.533926] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[    4.536081] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    4.538109] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    4.540213] systemd[1]: Started Setup Virtual Console.
[  OK  ] Started Setup Virtual Console.
[    4.542826] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[    4.545904] systemd[1]: Started Apply Kernel Variables.
[  OK  ] Started Apply Kernel Variables.
[    4.548485] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[    4.559568] systemd[1]: Started Create Static Device Nodes in /dev.
[  OK  ] Started Create Static Device Nodes in /dev.[    4.561633] random: fast init done

[    4.589962] systemd[1]: Started Journal Service.
[    4.590780] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[  OK  ] Started Journal Service.
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[    4.772669] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    4.783494] Loading iSCSI transport class v2.0-870.
[    4.789659] iscsi: registered transport (tcp)
[    7.816227] floppy0: no floppy controllers found
[    7.817428] work still pending
[    7.823441] dracut-pre-udev[334]: modprobe: ERROR: could not insert 'floppy': No such device
[    7.837039] No iBFT detected.
[    7.859150] async_tx: api initialized (async)
[    7.860810] xor: automatically using best checksumming function:
[    7.871007]    avx       : 15920.000 MB/sec
[    7.896017] raid6: sse2x1   gen()  5777 MB/s
[    7.913005] raid6: sse2x2   gen() 11308 MB/s
[    7.930008] raid6: sse2x4   gen() 18390 MB/s
[    7.947012] raid6: avx2x1   gen() 12316 MB/s
[    7.964006] raid6: avx2x2   gen() 25769 MB/s
[    7.981004] raid6: avx2x4   gen() 26167 MB/s
[    7.981652] raid6: using algorithm avx2x4 gen() (26167 MB/s)
[    7.982563] raid6: using avx2x2 recovery algorithm
[    8.030498] device-mapper: uevent: version 1.0.3
[    8.031315] device-mapper: ioctl: 4.37.1-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    8.071169] device-mapper: multipath round-robin: version 1.2.0 loaded
[    8.131120] RPC: Registered named UNIX socket transport module.
[    8.132043] RPC: Registered udp transport module.
[    8.132788] RPC: Registered tcp transport module.
[    8.133518] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting dracut pre-trigger hook...
[  OK  ] Started dracut pre-trigger hook.
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[    8.331290] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
[    8.332666] virtio-pci 0000:01:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
[    8.334166] virtio-pci: probe of 0000:01:00.0 failed with error -22
[    8.335935] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
[    8.337319] virtio-pci 0000:03:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
[    8.338749] virtio-pci: probe of 0000:03:00.0 failed with error -22
[    8.340555] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
[    8.341969] virtio-pci 0000:04:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
[    8.344927] virtio-pci: probe of 0000:04:00.0 failed with error -22
[    8.347960] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
[    8.349335] virtio-pci 0000:05:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
[    8.350633] cryptd: max_cpu_qlen set to 1000
[    8.350817] virtio-pci: probe of 0000:05:00.0 failed with error -22
[    8.353053] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
[    8.353056] virtio-pci 0000:06:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
[    8.353196] virtio-pci: probe of 0000:06:00.0 failed with error -22
[  OK  ] Started udev Coldplug all Devices.
         Starting Device-Mapper Multipath Device Controller...
[    8.369769] AVX2 version of gcm_enc/dec engaged.
[    8.370515] AES CTR mode by8 optimization enabled
         Starting Show Plymouth Boot Screen...
[    8.382181] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    8.383372] alg: No test for __generic-gcm-aes-aesni (__driver-generic-gcm-aes-aesni)
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Started Device-Mapper Multipath Device Controller.
         Starting Open-iSCSI...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[    8.410333] ACPI: PCI Interrupt Link [GSIA] enabled at IRQ 16
[    8.412360] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    8.413706] ahci 0000:00:1f.2: flags: 64bit ncq only 
[    8.415665] scsi host0: ahci
[    8.416253] scsi host1: ahci
[    8.416774] scsi host2: ahci
[    8.417468] scsi host3: ahci
[    8.418082] scsi host4: ahci
[    8.418608] scsi host5: ahci
[    8.419125] ata1: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e100 irq 41
[    8.420282] ata2: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e180 irq 41
[    8.421433] ata3: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e200 irq 41
[    8.422596] ata4: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e280 irq 41
[    8.423750] ata5: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e300 irq 41
[    8.424901] ata6: SATA max UDMA/133 abar m4096@0xfea0e000 port 0xfea0e380 irq 41
[  OK  ] Started Open-iSCSI.
         Starting dracut initqueue hook...
[    8.731234] ata3: SATA link down (SStatus 0 SControl 300)
[    8.733017] ata4: SATA link down (SStatus 0 SControl 300)
[    8.733997] ata6: SATA link down (SStatus 0 SControl 300)
[    8.734981] ata5: SATA link down (SStatus 0 SControl 300)
[    8.735968] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.737121] ata2: SATA link down (SStatus 0 SControl 300)
[    8.738040] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    8.738908] ata1.00: applying bridge limits
[    8.739681] ata1.00: configured for UDMA/100
[    8.740685] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    8.756158] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    8.757195] cdrom: Uniform CD-ROM driver Revision: 3.20
[    8.845628] dracut-initqueue[741]: mount: /dev/sr0 is write-protected, mounting read-only
[    8.904027] loop: module loaded
[  OK  ] Started dracut initqueue hook.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
         Starting dracut pre-mount hook...
[  OK  ] Started dracut pre-mount hook.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
         Starting dracut mount hook...
[  OK  ] Reached target Initrd File Systems.
[    9.109434] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Started dracut mount hook.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Cleaning Up and Shutting Down Daemons...
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
         Starting Plymouth switch root service...
[  OK  ] Stopped target Timers.
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped dracut mount hook.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Slices.
[  OK  ] Stopped dracut pre-mount hook.
[  OK  ] Stopped dracut initqueue hook.
         Stopping Open-iSCSI...
[  OK  ] Closed Open-iSCSI iscsiuio Socket.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped target Local Encrypted Volumes.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped Open-iSCSI.
         Stopping Device-Mapper Multipath Device Controller...
[  OK  ] Started Cleaning Up and Shutting Down Daemons.
[  OK  ] Stopped Device-Mapper Multipath Device Controller.
[  OK  ] Stopped udev Coldplug all Devices.
[  OK  ] Stopped dracut pre-trigger hook.
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Started Plymouth switch root service.
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
[  OK  ] Stopped dracut pre-udev hook.
[  OK  ] Stopped dracut cmdline hook.
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[    9.383316] systemd-journald[88]: Received SIGTERM from PID 1 (systemd).
[    9.767315] type=1403 audit(1699353533.808:2): policy loaded auid=4294967295 ses=4294967295
[    9.780745] systemd[1]: Successfully loaded SELinux policy in 174.683ms.
[    9.883861] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 22.749ms.

Welcome to CentOS Linux 7 (Core)!

[    9.926789] random: crng init done
[  OK  ] Stopped Switch Root.
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
         Starting Remount Root and Kernel File Systems...
[  OK  ] Stopped target Switch Root.
[  OK  ] Listening on LVM2 poll daemon socket.
[  OK  ] Created slice User and Session Slice.
         Starting Availability of block devices...
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[  OK  ] Reached target Slices.
         Starting Read and set NIS domainname from /etc/sysconfig/network...
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
         Mounting Huge Pages File System...
         Starting Create list of required st... nodes for the current kernel...
         Mounting POSIX Message Queue File System...
[  OK  ] Reached target Swap.
[  OK  ] Listening on LVM2 metadata daemon socket.
         Mounting Debug File System...
[  OK  ] Reached target Paths.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Reached target Timers.
[  OK  ] Listening on Delayed Shutdown Socket.
[  OK  ] Listening on udev Control Socket.
         Mounting Temporary Directory...
[  OK  ] Stopped target Initrd Root File System.
         Starting Apply Kernel Variables...
[  OK  ] Created slice system-selinux\x2dpol...grate\x2dlocal\x2dchanges.slice.
[  OK  ] Created slice system-anaconda\x2dtmux.slice.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Availability of block devices.
[  OK  ] Started Read and set NIS domainname from /etc/sysconfig/network.
         Starting Configure read-only root support...
         Starting Rebuild Hardware Database...
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Journal Service.
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Configure read-only root support.
         Starting Load/Save Random Seed...
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Started Load/Save Random Seed.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Rebuild Hardware Database.
         Starting udev Coldplug all Devices...
[  OK  ] Started udev Coldplug all Devices.
         Starting Device-Mapper Multipath Device Controller...
Starting installer, one moment...
anaconda 21.48.22.159-1 for CentOS 7 started.
 * installation log files are stored in /tmp during the installation
 * shell is available on TTY2
 * when reporting a bug add logs from /tmp as separate text/plain attachments
10:39:09 Not asking for VNC because we don't have a network
================================================================================
================================================================================
Installation

 1) [x] Language settings                 2) [!] Time settings
        (English (United States))                (Timezone is not set.)
 3) [!] Installation source               4) [!] Software selection
        (Processing...)                          (Processing...)
 5) [!] Installation Destination          6) [x] Kdump
        (No disks selected)                      (Kdump is enabled)
 7) [ ] Network configuration             8) [!] Root password
        (No network devices available)           (Password is not set.)
 9) [!] User creation
        (No user will be created)
  Please make your choice from above ['q' to quit | 'b' to begin installation |
  'r' to refresh]: 5
================================================================================
================================================================================
Probing storage...
Installation Destination

No disks detected.  Please shut down the computer, connect at least one disk,
and restart to complete installation.


