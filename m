Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88097AE9ED
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4wp-00040C-UO; Tue, 26 Sep 2023 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4wm-0003wq-QY; Tue, 26 Sep 2023 06:05:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4wg-0003xy-Tp; Tue, 26 Sep 2023 06:05:40 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwGk1RZsz6J7pv;
 Tue, 26 Sep 2023 18:00:30 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:05:10 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Date: Tue, 26 Sep 2023 11:03:59 +0100
Message-ID: <20230926100436.28284-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

[ *REPEAT: Sent patches got held at internal server yesterday* ]

PROLOGUE
========

To assist in review and set the right expectations from this RFC, please first
read below sections *APPENDED AT THE END* of this cover letter,

1. Important *DISCLAIMER* [Section (X)]
2. Work presented at KVMForum Conference (slides available) [Section (V)F]
3. Organization of patches [Section (XI)]
4. References [Section (XII)]
5. Detailed TODO list of the leftover work or work-in-progress [Section (IX)]

NOTE: There has been an interest shown by other organizations in adapting
this series for their architecture. I am planning to split this RFC into
architecture *agnostic* and *specific* patch-sets in subsequent releases. ARM
specific patch-set will continue as RFC V3 and architecture agnostic patch-set
will be floated without RFC tag and can be consumed in this Qemu cycle if
MAINTAINERs ack it.

[Please check section (XI)B for details of architecture agnostic patches]


SECTIONS [I - XIII] are as follows :

(I) Key Changes (RFC V1 -> RFC V2)
    ==================================

    RFC V1: https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/

1. ACPI MADT Table GIC CPU Interface can now be presented [6] as ACPI
   *online-capable* or *enabled* to the Guest OS at the boot time. This means
   associated CPUs can have ACPI _STA as *enabled* or *disabled* even after boot
   See, UEFI ACPI 6.5 Spec, Section 05, Table 5.37 GICC CPU Interface Flags[20]
2. SMCC/HVC Hypercall exit handling in userspace/Qemu for PSCI CPU_{ON,OFF}
   request. This is required to {dis}allow online'ing a vCPU.
3. Always presenting unplugged vCPUs in CPUs ACPI AML code as ACPI _STA.PRESENT 
   to the Guest OS. Toggling ACPI _STA.Enabled to give an effect of the
   hot{un}plug.
4. Live Migration works (some issues are still there)
5. TCG/HVF/qtest does not support Hotplug and falls back to default.
6. Code for TCG support do exists in this release (it is a work-in-progress)
7. ACPI _OSC method can now be used by OSPM to negotiate Qemu VM platform
   hotplug capability (_OSC Query support still pending)
8. Misc. Bug fixes

(II) Summary
     =======

This patch-set introduces the virtual CPU hotplug support for ARMv8 architecture
in QEMU. Idea is to be able to hotplug and hot-unplug the vCPUs while guest VM
is running and no reboot is required. This does *not* makes any assumption of
the physical CPU hotplug availability within the host system but rather tries to
solve the problem at virtualizer/QEMU layer. Introduces ACPI CPU hotplug hooks
and event handling to interface with the guest kernel, code to initialize, plug
and unplug CPUs. No changes are required within the host kernel/KVM except the
support of hypercall exit handling in the user-space/Qemu which has recently
been added to the kernel. Its corresponding Guest kernel changes have been
posted on the mailing-list [3] [4] by James Morse.

(III) Motivation
      ==========

This allows scaling the guest VM compute capacity on-demand which would be
useful for the following example scenarios,

1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestration
   framework which could adjust resource requests (CPU and Mem requests) for
   the containers in a pod, based on usage.
2. Pay-as-you-grow Business Model: Infrastructure provider could allocate and
   restrict the total number of compute resources available to the guest VM
   according to the SLA (Service Level Agreement). VM owner could request for
   more compute to be hot-plugged for some cost.

For example, Kata Container VM starts with a minimum amount of resources (i.e.
hotplug everything approach). why?

1. Allowing faster *boot time* and
2. Reduction in *memory footprint*

Kata Container VM can boot with just 1 vCPU and then later more vCPUs can be
hot-plugged as per requirement.

(IV) Terminology
     ===========

(*) Posssible CPUs: Total vCPUs which could ever exist in VM. This includes
                    any cold booted CPUs plus any CPUs which could be later
                    hot-plugged.
                    - Qemu parameter(-smp maxcpus=N)
(*) Present CPUs:   Possible CPUs which are ACPI 'present'. These might or might
                    not be ACPI 'enabled'. 
                    - Present vCPUs = Possible vCPUs (Always on ARM Arch)
(*) Enabled CPUs:   Possible CPUs which are ACPI ‘present’ and 'enabled' and can
                    now be ‘onlined’ (PSCI) for use by Guest Kernel. All cold
                    booted vCPUs are ACPI 'enabled' at boot. Later, using
                    device_add more vCPUs can be hotplugged and be made ACPI
                    'enabled.
                    - Qemu parameter(-smp cpus=N). Can be used to specify some
		      cold booted vCPUs during VM init. Some can be added using
		      '-device' option.

(V) Constraints Due To ARMv8 CPU Architecture [+] Other Impediments
    ===============================================================

A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
   1. ARMv8 CPU architecture does not support the concept of the physical CPU
      hotplug. 
      a. There are many per-CPU components like PMU, SVE, MTE, Arch timers etc.
         whose behaviour need to be clearly defined when CPU is hot(un)plugged.
         There is no specification for this.

   2. Other ARM components like GIC etc. have not been designed to realize
      physical CPU hotplug capability as of now. For example,
      a. Every physical CPU has a unique GICC (GIC CPU Interface) by construct.
         Architecture does not specifies what CPU hot(un)plug would mean in
         context to any of these.
      b. CPUs/GICC are physically connected to unique GICR (GIC Redistributor).
         GIC Redistributors are always part of always-on power domain. Hence,
         cannot be powered-off as per specification.

B. Impediments in Firmware/ACPI (Architectural Constraint)

   1. Firmware has to expose GICC, GICR and other per-CPU features like PMU,
      SVE, MTE, Arch Timers etc. to the OS. Due to architectural constraint
      stated in above section A1(a),  all interrupt controller structures of
      MADT describing GIC CPU Interfaces and the GIC Redistibutors MUST be
      presented by firmware to the OSPM during the boot time. 
   2. Architectures that support CPU hotplug can evaluate ACPI _MAT method to
      get this kind of information from the firmware even after boot and the
      OSPM has capability to process these. ARM kernel uses information in MADT
      interrupt controller structures to identify number of Present CPUs during
      boot and hence does not allow to change these after boot. Number of
      present CPUs cannot be changed. It is an architectural constraint!

C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Constraint)

   1. KVM VGIC:
       a. Sizing of various VGIC resources like memory regions etc. related to
          the redistributor happens only once and is fixed at the VM init time
          and cannot be changed later after initialization has happened.
          KVM statically configures these resources based on the number of vCPUs
          and the number/size of redistributor ranges.
       b. Association between vCPU and its VGIC redistributor is fixed at the
          VM init time within the KVM i.e. when redistributor iodevs gets
          registered. VGIC does not allows to setup/change this association
          after VM initialization has happened. Physically, every CPU/GICC is
          uniquely connected with its redistributor and there is no
          architectural way to set this up.
   2. KVM vCPUs:
       a. Lack of specification means destruction of KVM vCPUs does not exist as
          there is no reference to tell what to do with other per-vCPU
          components like redistributors, arch timer etc.
       b. Infact, KVM does not implements destruction of vCPUs for any
          architecture. This is independent of the fact whether architecture
          actually supports CPU Hotplug feature. For example, even for x86 KVM
          does not implements destruction of vCPUs.

D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints->Arch)

   1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCPUs to
      overcome the KVM constraint. KVM vCPUs are created, initialized when Qemu
      CPU Objects are realized. But keepinsg the QOM CPU objects realized for
      'yet-to-be-plugged' vCPUs can create problems when these new vCPUs shall
      be plugged using device_add and a new QOM CPU object shall be created.
   2. GICV3State and GICV3CPUState objects MUST be sized over *possible vCPUs*
      during VM init time while QOM GICV3 Object is realized. This is because
      KVM VGIC can only be initialized once during init time. But every
      GICV3CPUState has an associated QOM CPU Object. Later might corresponds to
      vCPU which are 'yet-to-be-plugged'(unplugged at init).
   3. How should new QOM CPU objects be connected back to the GICV3CPUState
      objects and disconnected from it in case CPU is being hot(un)plugged?
   4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented in the
      QOM for which KVM vCPU already exists? For example, whether to keep,
       a. No QOM CPU objects Or
       b. Unrealized CPU Objects
   5. How should vCPU state be exposed via ACPI to the Guest? Especially for
      the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not exists
      within the QOM but the Guest always expects all possible vCPUs to be
      identified as ACPI *present* during boot.
   6. How should Qemu expose GIC CPU interfaces for the unplugged or
      yet-to-beplugged vCPUs using ACPI MADT Table to the Guest?

E. Summary of Approach ([+] Workarounds to problems in sections A, B, C & D)

   1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e. even
      for the vCPUs which are yet-to-be-plugged in Qemu but keep them in the
      powered-off state.
   2. After the KVM vCPUs have been initialized in the Host, the KVM vCPU
      objects corresponding to the unplugged/yet-to-be-plugged vCPUs are parked
      at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar to x86)
   3. GICV3State and GICV3CPUState objects are sized over possible vCPUs during
      VM init time i.e. when Qemu GIC is realized. This in turn sizes KVM VGIC
      resources like memory regions etc. related to the redistributors with the
      number of possible KVM vCPUs. This never changes after VM has initialized.
   4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged vCPUs are
      released post Host KVM CPU and GIC/VGIC initialization.
   5. Build ACPI MADT Table with below updates 
      a. Number of GIC CPU interface entries (=possible vCPUs)
      b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable) 
      c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1  
         - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
	 - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy) 
	 - Some issues with above (details in later sections)
   6. Expose below ACPI Status to Guest kernel
      a. Always _STA.Present=1 (all possible vCPUs)
      b. _STA.Enabled=1 (plugged vCPUs)
      c. _STA.Enabled=0 (unplugged vCPUs)
   7. vCPU hotplug *realizes* new QOM CPU object. Following happens,
      a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread
      b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list)
         - Attaches to QOM CPU object.
      c. Reinitializes KVM vCPU in the Host
         - Resets the core and sys regs, sets defaults etc.
      d. Runs KVM vCPU (created with "start-powered-off")
	 - vCPU thread sleeps (waits for vCPU reset via PSCI) 
      e. Updates Qemu GIC
         - Wires back IRQs related to this vCPU.
         - GICV3CPUState association with QOM CPU Object.
      f. Updates [6] ACPI _STA.Enabled=1
      g. Notifies Guest about new vCPU (via ACPI GED interface)
	 - Guest checks _STA.Enabled=1
	 - Guest adds processor (registers CPU with LDM) [3]
      h. Plugs the QOM CPU object in the slot.
         - slot-number = cpu-index{socket,cluster,core,thread}
      i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC)
         - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
         - Qemu powers-on KVM vCPU in the Host
   8. vCPU hot-unplug *unrealizes* QOM CPU Object. Following happens,
      a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event
         - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC) 
      b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
         - Qemu powers-off the KVM vCPU in the Host
      c Guest signals *Eject* vCPU to Qemu
      d. Qemu updates [6] ACPI _STA.Enabled=0
      e. Updates GIC
         - Un-wires IRQs related to this vCPU
         - GICV3CPUState association with new QOM CPU Object is updated.
      f. Unplugs the vCPU
	 - Removes from slot
         - Parks KVM vCPU ("kvm_parked_vcpus" list)
         - Unrealizes QOM CPU Object & joins back Qemu vCPU thread
	 - Destroys QOM CPU object 
      g. Guest checks ACPI _STA.Enabled=0
         - Removes processor (unregisters CPU with LDM) [3]

F. Work Presented at KVM Forum Conferences:
   Details of above work has been presented at KVMForum2020 and KVMForum2023
   conferences. Slides are available at below links,
   a. KVMForum 2023
      - Challenges Revisited in Supporting Virt CPU Hotplug on architectures that don't Support CPU Hotplug (like ARM64)
        https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
   b. KVMForum 2020
      - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (like ARM64) - Salil Mehta, Huawei
        https://sched.co/eE4m

(VI) Commands Used
     =============

    A. Qemu launch commands to init the machine

    $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
    -cpu host -smp cpus=4,maxcpus=6 \
    -m 300M \
    -kernel Image \
    -initrd rootfs.cpio.gz \
    -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
    -nographic \
    -bios  QEMU_EFI.fd \

    B. Hot-(un)plug related commands

    # Hotplug a host vCPU(accel=kvm)
    $ device_add host-arm-cpu,id=core4,core-id=4

    # Hotplug a vCPU(accel=tcg)
    $ device_add cortex-a57-arm-cpu,id=core4,core-id=4

    # Delete the vCPU
    $ device_del core4

    Sample output on guest after boot:

    $ cat /sys/devices/system/cpu/possible
    0-5
    $ cat /sys/devices/system/cpu/present
    0-5
    $ cat /sys/devices/system/cpu/enabled
    0-3
    $ cat /sys/devices/system/cpu/online
    0-1
    $ cat /sys/devices/system/cpu/offline
    2-5

    Sample output on guest after hotplug of vCPU=4:

    $ cat /sys/devices/system/cpu/possible
    0-5
    $ cat /sys/devices/system/cpu/present
    0-5
    $ cat /sys/devices/system/cpu/enabled
    0-4
    $ cat /sys/devices/system/cpu/online
    0-1,4
    $ cat /sys/devices/system/cpu/offline
    2-3,5

    Note: vCPU=4 was explicitly 'onlined' after hot-plug
    $ echo 1 > /sys/devices/system/cpu/cpu4/online

(VII) Repository
      ==========

 (*) QEMU changes for vCPU hotplug could be cloned from below site,
     https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
 (*) Guest Kernel changes (by James Morse, ARM) are available here:
     https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2


(VIII) KNOWN ISSUES
       ============

1. Migration has been lightly tested. Below are some of the known issues:
   - Ocassional CPU stall (not always repeatable)
   - Negative test case like asymmetric source/destination VM config causes dump.
   - Migration with TCG is not working properly.
2. TCG with Single threaded mode is broken.
3. HVF and qtest support is broken. 
4. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-capable are
   mutually exclusive i.e. as per the change [6] a vCPU cannot be both
   GICC.Enabled and GICC.online-capable. This means,
      [ Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706 ]
   a. If we have to support hot-unplug of the cold-booted vCPUs then these MUST
      be specified as GICC.online-capable in the MADT Table during boot by the
      firmware/Qemu. But this requirement conflicts with the requirement to
      support new Qemu changes with legacy OS which dont understand
      MADT.GICC.online-capable Bit. Legacy OS during boot time will ignore this
      bit and hence these vCPUs will not appear on such OS. This is unexpected
      behaviour.
   b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to unplug
      these cold-booted vCPUs from OS (which in actual should be blocked by
      returning error at Qemu) then features like 'kexec' will break.
   c. As I understand, removal of the cold-booted vCPUs is a required feature
      and x86 world allows it.
   d. Hence, either we need a specification change to make the MADT.GICC.Enabled
      and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT support
      removal of cold-booted vCPUs. In the later case, a check can be introduced
      to bar the users from unplugging vCPUs, which were cold-booted, using QMP
      commands. (Needs discussion!)
      Please check below patch part of this patch-set:
          [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled]
5. Code related to the notification to GICV3 about hot(un)plug of a vCPU event
   might need further discussion.


(IX) THINGS TO DO
     ============

1. Fix the Migration Issues
2. Fix issues related to TCG/Emulation support.
3. Comprehensive Testing. Current testing is very basic.
   a. Negative Test cases
4. Qemu Documentation(.rst) need to be updated.
5. Fix qtest, HVF Support
6. Fix the design issue related to ACPI MADT.GICC flags discussed in known
   issues. This might require UEFI ACPI specification change!
7. Add ACPI _OSC 'Query' support. Only part of _OSC support exists now.

 Above is *not* a complete list. Will update later!

Best regards
Salil.

(X) DISCLAIMER
    ==========

This work is an attempt to present a proof-of-concept of the ARM64 vCPU hotplug
implementation to the community. This is *not* a production level code and might
have bugs. Only a basic testing has been done on HiSilicon Kunpeng920 SoC for
servers. Once the design and core idea behind the implementation has been
verified more efforts can be put to harden the code.

This work is *mostly* in the lines of the discussions which have happened in the
previous years[see refs below] across different channels like mailing-list,
Linaro Open Discussions platform, various conferences like KVMFourm etc. This
RFC is being used as a way to verify the idea mentioned in this cover-letter and
to get community views. Once this has been agreed, a formal patch shall be
posted to the mailing-list for review.

[The concept being presented has been found to work!]

(XI) ORGANIZATION OF PATCHES
     =======================
 
 A. All patches [Architecture 'agnostic' + 'specific']:

   [Patch 1-9, 23, 36] logic required during machine init
    (*) Some validation checks
    (*) Introduces core-id property and some util functions required later.
    (*) Refactors Parking logic of vCPUs    
    (*) Logic to pre-create vCPUs
    (*) GIC initialization pre-sized with possible vCPUs.
    (*) Some refactoring to have common hot and cold plug logic together.
    (*) Release of disable QOM CPU objects in post_cpu_init()
    (*) Support of ACPI _OSC method to negotiate platform hotplug capabilities
   [Patch 10-22] logic related to ACPI at machine init time
    (*) Changes required to Enable ACPI for cpu hotplug
    (*) Initialization ACPI GED framework to cater CPU Hotplug Events
    (*) Build ACPI AML related to CPU control dev 
    (*) ACPI MADT/MAT changes
   [Patch 24-35] Logic required during vCPU hot-(un)plug
    (*) Basic framework changes to suppport vCPU hot-(un)plug
    (*) ACPI GED changes for hot-(un)plug hooks.
    (*) wire-unwire the IRQs
    (*) GIC notification logic
    (*) ARMCPU unrealize logic
    (*) Handling of SMCC Hypercall Exits by KVM to Qemu  
   
 B. Architecture *agnostic* patches part of patch-set:

   [Patch 5,9,11,13,16,20,24,31,33] Common logic to support hotplug 
    (*) Refactors Parking logic of vCPUs
    (*) Introduces ACPI GED Support for vCPU Hotplug Events
    (*) Introduces ACPI AML change for CPU Control Device     

(XII) REFERENCES
      ==========

[1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
[2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.com/
[3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
[4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
[5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/
[6] https://bugzilla.tianocore.org/show_bug.cgi?id=3706
[7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
[8] https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
[9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
[10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html
[11] https://lkml.org/lkml/2019/7/10/235
[12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
[13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
[14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
[15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
[16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
[17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
[18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/
[19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/ 
[20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags

(XIII) ACKNOWLEDGEMENTS
       ================

I would like to take this opportunity to thank below people for various
discussions with me over different channels during the development:

Marc Zyngier (Google)               Catalin Marinas (ARM),         
James Morse(ARM),                   Will Deacon (Google), 
Jean-Phillipe Brucker (Linaro),     Sudeep Holla (ARM),
Lorenzo Pieralisi (Linaro),         Gavin Shan (Redhat), 
Jonathan Cameron (Huawei),          Darren Hart (Ampere),
Igor Mamedov (Redhat),              Ilkka Koskinen (Ampere),
Andrew Jones (Redhat),              Karl Heubaum (Oracle),
Keqian Zhu (Huawei),                Miguel Luis (Oracle),
Xiongfeng Wang (Huawei),            Vishnu Pajjuri (Ampere),
Shameerali Kolothum (Huawei)        Russell King (Oracle)
Xuwei/Joy (Huawei),                 Peter Maydel (Linaro)
Zengtao/Prime (Huawei),             And all those whom I have missed! 

Many thanks to below people for their current or past contributions:

1. James Morse (ARM)
   (Current Kernel part of vCPU Hotplug Support on AARCH64)
2. Jean-Philippe Brucker (Linaro)
   (Protoyped one of the earlier PSCI based POC [17][18] based on RFC V1)
3. Keqian Zhu (Huawei)
   (Co-developed Qemu prototype)
4. Xiongfeng Wang (Huawei)
   (Co-developed earlier kernel prototype)
5. Vishnu Pajjuri (Ampere)
   (Verification on Ampere ARM64 Platforms + fixes)
6. Miguel Luis (Oracle)
   (Verification on Oracle ARM64 Platforms + fixes)


Author Salil Mehta (1):
  target/arm/kvm,tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu

Jean-Philippe Brucker (2):
  hw/acpi: Make _MAT method optional
  target/arm/kvm: Write CPU state back to KVM on reset

Miguel Luis (1):
  tcg/mttcg: enable threads to unregister in tcg_ctxs[]

Salil Mehta (33):
  arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id property
  cpus-common: Add common CPU utility for possible vCPUs
  hw/arm/virt: Move setting of common CPU properties in a function
  arm/virt,target/arm: Machine init time change common to vCPU {cold|hot}-plug
  accel/kvm: Extract common KVM vCPU {creation,parking} code
  arm/virt,kvm: Pre-create disabled possible vCPUs @machine init
  arm/virt,gicv3: Changes to pre-size GIC with possible vcpus @machine init
  arm/virt: Init PMU at host for all possible vcpus
  hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
  arm/acpi: Enable ACPI support for vcpu hotplug
  hw/acpi: Add ACPI CPU hotplug init stub
  hw/acpi: Use qemu_present_cpu() API in ACPI CPU hotplug init
  hw/acpi: Init GED framework with cpu hotplug events
  arm/virt: Add cpu hotplug events to GED during creation
  arm/virt: Create GED dev before *disabled* CPU Objs are destroyed
  hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
  arm/virt/acpi: Build CPUs AML with CPU Hotplug support
  arm/virt: Make ARM vCPU *present* status ACPI *persistent*
  hw/acpi: ACPI/AML Changes to reflect the correct _STA.{PRES,ENA} Bits to Guest
  hw/acpi: Update GED _EVT method AML with cpu scan
  hw/arm: MADT Tbl change to size the guest with possible vCPUs
  arm/virt: Release objects for *disabled* possible vCPUs after init
  hw/acpi: Update ACPI GED framework to support vCPU Hotplug
  arm/virt: Add/update basic hot-(un)plug framework
  arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
  hw/arm,gicv3: Changes to update GIC with vCPU hot-plug notification
  hw/intc/arm-gicv3*: Changes required to (re)init the vCPU register info
  arm/virt: Update the guest(via GED) about CPU hot-(un)plug events
  hw/arm: Changes required for reset and to support next boot
  physmem,gdbstub: Common helping funcs/changes to *unrealize* vCPU
  target/arm: Add support of *unrealize* ARMCPU during vCPU Hot-unplug
  hw/arm: Support hotplug capability check using _OSC method
  hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled

 accel/kvm/kvm-all.c                    |  61 +-
 accel/tcg/tcg-accel-ops-mttcg.c        |   1 +
 cpus-common.c                          |  37 ++
 gdbstub/gdbstub.c                      |  13 +
 hw/acpi/acpi-cpu-hotplug-stub.c        |   6 +
 hw/acpi/cpu.c                          |  91 ++-
 hw/acpi/generic_event_device.c         |  33 +
 hw/arm/Kconfig                         |   1 +
 hw/arm/boot.c                          |   2 +-
 hw/arm/virt-acpi-build.c               | 110 +++-
 hw/arm/virt.c                          | 863 ++++++++++++++++++++-----
 hw/core/gpio.c                         |   2 +-
 hw/i386/acpi-build.c                   |   2 +-
 hw/intc/arm_gicv3.c                    |   1 +
 hw/intc/arm_gicv3_common.c             |  66 +-
 hw/intc/arm_gicv3_cpuif.c              | 265 ++++----
 hw/intc/arm_gicv3_cpuif_common.c       |   5 +
 hw/intc/arm_gicv3_kvm.c                |  39 +-
 hw/intc/gicv3_internal.h               |   2 +
 include/exec/cpu-common.h              |   8 +
 include/exec/gdbstub.h                 |   1 +
 include/hw/acpi/cpu.h                  |   7 +-
 include/hw/acpi/cpu_hotplug.h          |   4 +
 include/hw/acpi/generic_event_device.h |   5 +
 include/hw/arm/boot.h                  |   2 +
 include/hw/arm/virt.h                  |  10 +-
 include/hw/core/cpu.h                  |  77 +++
 include/hw/intc/arm_gicv3_common.h     |  23 +
 include/hw/qdev-core.h                 |   2 +
 include/sysemu/kvm.h                   |   2 +
 include/tcg/tcg.h                      |   1 +
 softmmu/physmem.c                      |  25 +
 target/arm/arm-powerctl.c              |  51 +-
 target/arm/cpu-qom.h                   |   3 +
 target/arm/cpu.c                       | 112 ++++
 target/arm/cpu.h                       |  17 +
 target/arm/cpu64.c                     |  15 +
 target/arm/gdbstub.c                   |   6 +
 target/arm/helper.c                    |  27 +-
 target/arm/internals.h                 |  12 +-
 target/arm/kvm.c                       |  93 ++-
 target/arm/kvm64.c                     |  59 +-
 target/arm/kvm_arm.h                   |  24 +
 target/arm/meson.build                 |   1 +
 target/arm/{tcg => }/psci.c            |   8 +
 target/arm/tcg/meson.build             |   4 -
 tcg/tcg.c                              |  23 +
 47 files changed, 1873 insertions(+), 349 deletions(-)
 rename target/arm/{tcg => }/psci.c (97%)

-- 
2.34.1


