Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B837178090F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwBf-0003u2-Om; Fri, 18 Aug 2023 05:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBd-0003ti-Tl
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:34 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBZ-0007QQ-T4
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352469; x=1723888469;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7gGdSp4ev12s6bR5E/T1eJyblLlpcPwtfw9eau/oKu0=;
 b=MZ11WzQodGOTQWlhcCqlqvFNWAscLTa+dfOJCdrOQbdGdjLJjuXTeXpm
 sMt6CXn62Isgs91r5KEIZXSCT9dPWse2uM+9t2fPDps9Ozhyfj3ZvSWjR
 0DHgaVqmispHfrZlTwc7mOEaZB3BCguAs2+4t5QX40jzp33Y5dfc93NVR
 9EO/fjHywWsfBTxFHVkJHoNVGFXhx5IgFxj6K3L5cLmzTNXC3mhjuki5H
 uLTtouKfbA6q1HiVa9+VtNDTnPufiGGKumGvQo5drMFjWzvCSzkO9g45V
 d3BZj0gF+zh+tzh9QSzvR5ZSfTD5GTj4gOv/uNEtj/89K7SC31ZHTQjTx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965531"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234764"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234764"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:54:19 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 00/58] TDX QEMU support 
Date: Fri, 18 Aug 2023 05:49:43 -0400
Message-Id: <20230818095041.1973309-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is v2 series of adding TDX suppot in QEMU.

This patch series aims to enable TDX support to allow creating and booting a
TD (TDX VM) with QEMU. It needs to work with corresponding KVM v15 patch [1].
TDX related documents can be found in [2].

This series is based on QEMU gmem implemntation, which is posted at [3].
And This series is also available in github:
https://github.com/intel/qemu-tdx/tree/tdx-qemu-upstream-v2

This version aims to update the TDX QEMU side to match with latest TDX
KVM side implementation, which expose gmem for private memory. This
version is not targeted as the final version because how to support KVM
gmem in QEMU is not finalized yet. Though, any review comment is
welcomed.


[1] KVM TDX basic feature support v15
https://lore.kernel.org/kvm/cover.1690322424.git.isaku.yamahata@intel.com/

[2] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html

[3] https://lore.kernel.org/all/20230731162201.271114-1-xiaoyao.li@intel.com/


== Limitation and future work ==
- Readonly memslot

  TDX only support readonly (write protection) memslot for shared memory, but
  not for private memory. For simplicity, just mark readonly memslot not
  supported entirely for TDX.

- CPU model

  We cannot create a TD with arbitrary CPU model like what for non-TDX VMs,
  because only a subset of features can be configured for TD.

  - It's recommended to use '-cpu host' to create TD;
  - '+feature/-feature' might not work as expected;

  future work: To introduce specific CPU model for TDs and enhance +/-features
               for TDs.

- gdb suppport

  gdb support to debug a TD of off-debug mode is future work.


== Change history ==
Changes from v1:
[v1] https://lore.kernel.org/qemu-devel/20220802074750.2581308-1-xiaoyao.li@intel.com/

- Switch to KVM gmem interface for private memory;
- Add TDVMCALL and its sub leaves support;
- mark LMCE as unsupported for TD VM;
- bing back the support of mrconfigid/mrowner/mrownerconfig;
- update documentation;

Changes from RFC v4:
[RFC v4] https://lore.kernel.org/qemu-devel/20220512031803.3315890-1-xiaoyao.li@intel.com/

- Add 3 more patches(9, 10, 11) to improve the tdx_get_supported_cpuid();
- make attributes of object tdx-guest not settable by user;
- improve get_tdx_capabilities() by using a known starting value and
  limiting the loop with a known size;
- clarify why isa.bios needs to be skipped;
- remove the MMIO hob setup since OVMF sets them up itself;

Changes from RFC v3:
[RFC v3] https://lore.kernel.org/qemu-devel/20220317135913.2166202-1-xiaoyao.li@intel.com/

- Load TDVF with -bios interface;
- Adapt to KVM API changes;
	- KVM_TDX_CAPABILITIES changes back to KVM-scope;
	- struct kvm_tdx_init_vm changes;
- Define TDX_SUPPORTED_KVM_FEATURES;
- Drop the patch of introducing property sept-ve-disable since it's not
  public yet;
- some misc cleanups

Changes from RFC v2:
[RFC v2] https://lore.kernel.org/qemu-devel/cover.1625704980.git.isaku.yamahata@intel.com/

- Get vm-type from confidential-guest-support object type;
- Drop machine_init_done_late_notifiers;
- Refactor tdx_ioctl implementation;
- re-use existing pflash interface to load TDVF (i.e., OVMF binaries);
- introduce new date structure to track memory type instead of changing
  e820 table;
- Force smm to off for TDX VM;
- Drop the patches that suppress level-trigger/SMI/INIT/SIPI since KVM
  will ingore them;
- Add documentation;

Changes from RFC v1:
[RFC v1] https://lore.kernel.org/qemu-devel/cover.1613188118.git.isaku.yamahata@intel.com/

- suppress level trigger/SMI/INIT/SIPI related to IOAPIC.
- add VM attribute sha384 to TD measurement.
- guest TSC Hz specification



Chao Peng (1):
  i386/tdx: register TDVF as private memory

Chenyi Qiang (2):
  i386/tdx: register the fd read callback with the main loop to read the
    quote data
  i386/tdx: setup a timer for the qio channel

Isaku Yamahata (14):
  i386/tdx: Make sept_ve_disable set by default
  qom: implement property helper for sha384
  i386/tdx: Allows mrconfigid/mrowner/mrownerconfig for TDX_INIT_VM
  i386/tdx: Create kvm gmem for TD
  kvm/tdx: Don't complain when converting vMMIO region to shared
  kvm/tdx: Ignore memory conversion to shared of unassigned region
  i386/tdvf: Introduce function to parse TDVF metadata
  i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
  i386/tdx: handle TDG.VP.VMCALL<SetupEventNotifyInterrupt>
  i386/tdx: handle TDG.VP.VMCALL<GetQuote>
  i386/tdx: handle TDG.VP.VMCALL<MapGPA> hypercall
  i386/tdx: Limit the range size for MapGPA
  hw/i386: add option to forcibly report edge trigger in acpi tables
  i386/tdx: Don't synchronize guest tsc for TDs

Sean Christopherson (2):
  i386/kvm: Move architectural CPUID leaf generation to separate helper
  i386/tdx: Don't get/put guest state for TDX VMs

Xiaoyao Li (39):
  *** HACK *** linux-headers: Update headers to pull in TDX API changes
  i386: Introduce tdx-guest object
  target/i386: Parse TDX vm type
  target/i386: Introduce kvm_confidential_guest_init()
  i386/tdx: Implement tdx_kvm_init() to initialize TDX VM context
  i386/tdx: Get tdx_capabilities via KVM_TDX_CAPABILITIES
  i386/tdx: Introduce is_tdx_vm() helper and cache tdx_guest object
  i386/tdx: Adjust the supported CPUID based on TDX restrictions
  i386/tdx: Update tdx_cpuid_lookup[].tdx_fixed0/1 by
    tdx_caps.cpuid_config[]
  i386/tdx: Integrate tdx_caps->xfam_fixed0/1 into tdx_cpuid_lookup
  i386/tdx: Integrate tdx_caps->attrs_fixed0/1 to tdx_cpuid_lookup
  kvm: Introduce kvm_arch_pre_create_vcpu()
  i386/tdx: Initialize TDX before creating TD vcpus
  i386/tdx: Add property sept-ve-disable for tdx-guest object
  i386/tdx: Wire CPU features up with attributes of TD guest
  i386/tdx: Validate TD attributes
  i386/tdx: Implement user specified tsc frequency
  i386/tdx: Set kvm_readonly_mem_enabled to false for TDX VM
  i386/tdx: Make memory type private by default
  i386/tdx: Parse TDVF metadata for TDX VM
  i386/tdx: Skip BIOS shadowing setup
  i386/tdx: Don't initialize pc.rom for TDX VMs
  i386/tdx: Track mem_ptr for each firmware entry of TDVF
  i386/tdx: Track RAM entries for TDX VM
  headers: Add definitions from UEFI spec for volumes, resources, etc...
  i386/tdx: Setup the TD HOB list
  memory: Introduce memory_region_init_ram_gmem()
  i386/tdx: Call KVM_TDX_INIT_VCPU to initialize TDX vcpu
  i386/tdx: Finalize TDX VM
  i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>
  i386/tdx: Wire REPORT_FATAL_ERROR with GuestPanic facility
  i386/tdx: Disable SMM for TDX VMs
  i386/tdx: Disable PIC for TDX VMs
  i386/tdx: Don't allow system reset for TDX VMs
  i386/tdx: LMCE is not supported for TDX
  hw/i386: add eoi_intercept_unsupported member to X86MachineState
  i386/tdx: Only configure MSR_IA32_UCODE_REV in kvm_init_msrs() for TDs
  i386/tdx: Skip kvm_put_apicbase() for TDs
  docs: Add TDX documentation

 accel/kvm/kvm-all.c                        |   55 +-
 configs/devices/i386-softmmu/default.mak   |    1 +
 docs/system/confidential-guest-support.rst |    1 +
 docs/system/i386/tdx.rst                   |  114 ++
 docs/system/target-i386.rst                |    1 +
 hw/i386/Kconfig                            |    6 +
 hw/i386/acpi-build.c                       |   99 +-
 hw/i386/acpi-common.c                      |   50 +-
 hw/i386/meson.build                        |    1 +
 hw/i386/pc.c                               |   21 +-
 hw/i386/pc_sysfw.c                         |    7 +
 hw/i386/tdvf-hob.c                         |  147 ++
 hw/i386/tdvf-hob.h                         |   24 +
 hw/i386/tdvf.c                             |  200 +++
 hw/i386/x86.c                              |   38 +-
 include/exec/memory.h                      |    6 +
 include/hw/i386/tdvf.h                     |   58 +
 include/hw/i386/x86.h                      |    1 +
 include/qom/object.h                       |   17 +
 include/standard-headers/uefi/uefi.h       |  198 +++
 include/sysemu/kvm.h                       |    3 +
 linux-headers/asm-x86/kvm.h                |   90 ++
 linux-headers/linux/kvm.h                  |   87 ++
 qapi/qom.json                              |   26 +
 qapi/run-state.json                        |   17 +-
 qom/object.c                               |   76 +
 softmmu/memory.c                           |   52 +
 softmmu/runstate.c                         |   49 +
 target/i386/cpu-internal.h                 |    9 +
 target/i386/cpu.c                          |   12 -
 target/i386/cpu.h                          |   21 +
 target/i386/kvm/kvm-cpu.c                  |    5 +
 target/i386/kvm/kvm.c                      |  586 ++++----
 target/i386/kvm/kvm_i386.h                 |    5 +
 target/i386/kvm/meson.build                |    2 +
 target/i386/kvm/tdx-stub.c                 |   22 +
 target/i386/kvm/tdx.c                      | 1543 ++++++++++++++++++++
 target/i386/kvm/tdx.h                      |   73 +
 target/i386/sev.c                          |    1 -
 target/i386/sev.h                          |    2 +
 40 files changed, 3382 insertions(+), 344 deletions(-)
 create mode 100644 docs/system/i386/tdx.rst
 create mode 100644 hw/i386/tdvf-hob.c
 create mode 100644 hw/i386/tdvf-hob.h
 create mode 100644 hw/i386/tdvf.c
 create mode 100644 include/hw/i386/tdvf.h
 create mode 100644 include/standard-headers/uefi/uefi.h
 create mode 100644 target/i386/kvm/tdx-stub.c
 create mode 100644 target/i386/kvm/tdx.c
 create mode 100644 target/i386/kvm/tdx.h

-- 
2.34.1


