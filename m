Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C693107A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 10:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL3-0004AJ-En; Mon, 15 Jul 2024 04:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTHL1-00043V-1O; Mon, 15 Jul 2024 04:45:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTHKx-0003zw-Or; Mon, 15 Jul 2024 04:45:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WMwjR02Jjz6JBRF;
 Mon, 15 Jul 2024 16:44:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CDF3140A87;
 Mon, 15 Jul 2024 16:45:23 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 09:45:22 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 15 Jul 2024 09:45:22 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHa1VIYzbBqk8ub30G0ZXbYzNwFGLH3QCEAgAA7avA=
Date: Mon, 15 Jul 2024 08:45:22 +0000
Message-ID: <1261c2cb286545c6818242c82de3e966@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <ZpS9duIyGVWoH9NC@intel.com>
In-Reply-To: <ZpS9duIyGVWoH9NC@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.92]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Zhao,

>  From: Zhao Liu <zhao1.liu@intel.com>
>  Sent: Monday, July 15, 2024 7:11 AM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  Hi Salil,
> =20
>  I ran the unit tests again on x86 platform, and everything looks good.
> =20
>  Please feel free to keep my tested-by tag.


Many thanks for confirming this. Appreciate this.

Best Wishes
Salil.

> =20
>  Regards,
>  Zhao
> =20
>  On Sat, Jul 13, 2024 at 07:25:09PM +0100, Salil Mehta via wrote:
>  > Date: Sat, 13 Jul 2024 19:25:09 +0100
>  > From: Salil Mehta via <qemu-devel@nongnu.org>
>  > Subject: [PATCH V15 0/7] Add architecture agnostic code to support
>  > vCPU  Hotplug
>  > X-Mailer: git-send-email 2.34.1
>  >
>  > [Note: References are present at the last after the revision history]
>  >
>  > Virtual CPU hotplug support is being added across various architecture=
s
>  [1][3].
>  > This series adds various code bits common across all architectures:
>  >
>  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Update ACPI
>  > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CPUs AML
>  > code change [Patch 4,5] 4. Helper functions to support unrealization
>  > of CPU objects [Patch 6,7]
>  >
>  > Repository:
>  >
>  > [*] Architecture *Agnostic* Patch-set (This series)
>  >    V14: https://github.com/salil-mehta/qemu.git
>  > virt-cpuhp-armv8/rfc-v3.arch.agnostic.v15
>  >
>  >    NOTE: This series is meant to work in conjunction with the architec=
ture-
>  specific
>  >    patch-set. For ARM, a combined patch-set (architecture agnostic +
>  specific) was
>  >    earlier pushed as RFC V2 [1]. Later, RFC V2 was split into the ARM
>  Architecture
>  >    specific patch-set RFC V3 [4] (a subset of RFC V2) and the architec=
ture
>  agnostic
>  >    patch-set. Patch-set V14 is the latest version in that series. This=
 series
>  >    works in conjunction with RFC V4-rc2, present at the following link=
.
>  >
>  > [*] ARM Architecture *Specific* Patch-set
>  >    RFC V3 [4]: https://github.com/salil-mehta/qemu.git virt-cpuhp-
>  armv8/rfc-v3
>  >    RFC V4-rc2: https://github.com/salil-mehta/qemu.git
>  > virt-cpuhp-armv8/rfc-v4-rc2 (combined)
>  >
>  >
>  > Revision History:
>  >
>  > Patch-set V14 -> V15
>  > 1. Addressed commnet from Igor Mammedov's on [PATCH V14 4/7]
>  >    - Removed ACPI_CPU_SCAN_METHOD
>  >    - Introduced AML_GED_EVT_CPU_SCAN_METHOD
>  ("\\_SB.GED.CPSCN") macro
>  > 2. Fix the stray change of "assert (" in "PATCH V14 3/7"
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20240712134201.214699-4-salil.mehta
>  > @huawei.com/
>  >
>  > Patch-set V13 -> V14
>  > 1. Addressed Igor Mammedov's following review comments
>  >    - Mentioned abput new external APIs in the header note of [PATCH 1/=
7]
>  >    - Merged Doc [PATCH V13 8/8] with [PATCH V14 3/7]
>  >    - Introduced GED realize function for various CPU Hotplug regions
>  initializations
>  >    - Added back event handler method to indirectly expose
>  \\_SB.CPUS.CSCN to GED
>  >      _EVT. Like for ARM, it would be through \\_SB.GED.CSCN event hand=
ler
>  method
>  >    - Collected the Ack given for [Patch V13 6/8]
>  >    - Added back the gfree'ing of GDB regs in common finalize and made =
it
>  conditional
>  >    - Updated the header notes of [PATCH V13 3/8,4/8,5/8] to reflect
>  > the changes
>  >
>  > Patch-set  V12 -> V13
>  > 1. Added Reviewed-by Tag of Harsh Prateek Bora's (IBM) [PATCH V12 1/8]
>  > 2. Moved the kvm_{create,park,unpark}_vcpu prototypes from
>  accel/kvm/kvm-cpus.h
>  >    to include/sysemu/kvm.h. These can later be exported through
>  AccelOps.
>  > Link:
>  > https://lore.kernel.org/qemu-devel/62f55169-1796-4d8e-a35d-
>  7f003a17275
>  > 0@linux.ibm.com/
>  >
>  > Patch-set  V11 -> V12
>  > 1. Addressed Harsh Prateek Bora's (IBM) comment
>  >    - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype
>  header/
>  > 2. Added Zhao Liu's (Intel) Tested-by for whole series
>  >    - Qtest does not breaks on Intel platforms now.
>  > 3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
>  > Link: https://lore.kernel.org/qemu-
>  devel/ZlRSPuJGBgyEUW6w@intel.com/
>  > Link:
>  > https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-
>  e3e78fa5ede
>  > e@linux.ibm.com/
>  >
>  > Patch-set  V10 -> V11
>  > 1. Addressed Nicholas Piggin's (IBM) comment
>  >    - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the
>  end
>  >    - Added the Reviewed-by Tag for [PATCH V10 1/8] 2.  Addressed Alex
>  > Benn=E9e's (Linaro) comments
>  >    - Added a note explaining dependency of the [PATCH V10 7/8] on Arch
>  > specific patch-set
>  > Link:
>  > https://lore.kernel.org/qemu-
>  devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.co
>  > m/
>  > Link:
>  > https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/
>  >
>  > Patch-set  V9 -> V10
>  > 1. Addressed Nicholas Piggin's (IBM) & Philippe Mathieu-Daud=E9 (Linar=
o)
>  comments
>  >    - carved out kvm_unpark_vcpu and added its trace
>  >    - Widened the scope of the kvm_unpark_vcpu so that it can be used b=
y
>  generic framework
>  >      being thought out
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta
>  > @huawei.com/
>  > Link:
>  > https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-
>  08382a36b63
>  > a@linaro.org/
>  >
>  > Patch-set  V8 -> V9
>  > 1. Addressed Vishnu Pajjuri's (Ampere) comments
>  >    - Added kvm_fd to trace in kvm_create_vcpu
>  >    - Some clean ups: arch vcpu-id and sbd variable
>  >    - Added the missed initialization of cpu->gdb_num_regs 2. Addressed
>  > the commnet from Zhao Liu (Intel)
>  >    - Make initialization of CPU Hotplug state conditional
>  > (possible_cpu_arch_ids!=3DNULL)
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20240312020000.12992-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > Patch-set V7 -> V8
>  > 1. Rebased and Fixed the conflicts
>  >
>  > Patch-set  V6 -> V7
>  > 1. Addressed Alex Benn=E9e's comments
>  >    - Updated the docs
>  > 2. Addressed Igor Mammedov's comments
>  >    - Merged patches [Patch V6 3/9] & [Patch V6 7/9] with [Patch V6 4/9=
]
>  >    - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]
>  > 3. Added Shaoqin Huang's Reviewed-by tags for whole series.
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20231013105129.25648-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > Patch-set  V5 -> V6
>  > 1. Addressed Gavin Shan's comments
>  >    - Fixed the assert() ranges of address spaces
>  >    - Rebased the patch-set to latest changes in the qemu.git
>  >    - Added Reviewed-by tags for patches {8,9} 2. Addressed Jonathan
>  > Cameron's comments
>  >    - Updated commit-log for [Patch V5 1/9] with mention of trace event=
s
>  >    - Added Reviewed-by tags for patches {1,5} 3. Added Tested-by tags
>  > from Xianglai Li 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch
>  > V5 1/9]
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20231011194355.15628-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > Patch-set  V4 -> V5
>  > 1. Addressed Gavin Shan's comments
>  >    - Fixed the trace events print string for
>  kvm_{create,get,park,destroy}_vcpu
>  >    - Added Reviewed-by tag for patch {1} 2. Added Shaoqin Huang's
>  > Reviewed-by tags for Patches {2,3} 3. Added Tested-by Tag from Vishnu
>  > Pajjuri to the patch-set 4. Dropped the ARM specific [Patch V4 10/10]
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20231009203601.17584-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > Patch-set  V3 -> V4
>  > 1. Addressed David Hilderbrand's comments
>  >    - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>  >    - Added Reviewed-by tags for patches {2,4}
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20231009112812.10612-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > Patch-set  V2 -> V3
>  > 1. Addressed Jonathan Cameron's comments
>  >    - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'int=
eger'
>  >    - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>  >    - Updated [Patch V2 3/10] commit-log with details of
>  ACPI_CPU_SCAN_METHOD macro
>  >    - Updated [Patch V2 5/10] commit-log with details of conditional ev=
ent
>  handler method
>  >    - Added Reviewed-by tags for patches {2,3,4,6,7} 2. Addressed Gavin
>  > Shan's comments
>  >    - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>  >    - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>  >    - Reset the value of 'gdb_num_g_regs' in
>  gdb_unregister_coprocessor_all
>  >    - Fixed the kvm_{create,park}_vcpu prototypes docs
>  >    - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10} 3.
>  > Addressed one earlier missed comment by Alex Benn=E9e in RFC V1
>  >    - Added traces instead of DPRINTF in the newly added and some
>  > existing functions
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20230930001933.2660-1-
>  salil.mehta@h
>  > uawei.com/
>  >
>  > Patch-set V1 -> V2
>  > 1. Addressed Alex Benn=E9e's comments
>  >    - Refactored the kvm_create_vcpu logic to get rid of goto
>  >    - Added the docs for kvm_{create,park}_vcpu prototypes
>  >    - Splitted the gdbstub and AddressSpace destruction change into
>  separate patches
>  >    - Added Reviewed-by tags for patches {2,10}
>  > Link:
>  > https://lore.kernel.org/qemu-devel/20230929124304.13672-1-
>  salil.mehta@
>  > huawei.com/
>  >
>  > References:
>  >
>  > [1]
>  > https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
>  salil.mehta@
>  > huawei.com/ [2]
>  > https://lore.kernel.org/all/20230913163823.7880-1-
>  james.morse@arm.com/
>  > [3]
>  > https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loo
>  > ngson.cn/ [4]
>  > https://lore.kernel.org/qemu-devel/20240613233639.202896-2-salil.mehta
>  > @huawei.com/
>  >
>  > Salil Mehta (7):
>  >   accel/kvm: Extract common KVM vCPU {creation,parking} code
>  >   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header
>  file
>  >   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>  >   hw/acpi: Update GED _EVT method AML with CPU scan
>  >   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>  >   physmem: Add helper function to destroy CPU AddressSpace
>  >   gdbstub: Add helper function to unregister GDB register space
>  >
>  >  accel/kvm/kvm-all.c                    | 95 +++++++++++++++++--------=
-
>  >  accel/kvm/kvm-cpus.h                   |  1 -
>  >  accel/kvm/trace-events                 |  5 +-
>  >  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
>  >  gdbstub/gdbstub.c                      | 13 ++++
>  >  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
>  >  hw/acpi/cpu.c                          | 18 +++--
>  >  hw/acpi/generic_event_device.c         | 27 ++++++++
>  >  hw/core/cpu-common.c                   |  4 +-
>  >  hw/i386/acpi-build.c                   |  3 +-
>  >  include/exec/cpu-common.h              |  8 +++
>  >  include/exec/gdbstub.h                 |  6 ++
>  >  include/hw/acpi/cpu.h                  |  7 +-
>  >  include/hw/acpi/generic_event_device.h |  5 ++
>  >  include/hw/core/cpu.h                  |  1 +
>  >  include/sysemu/kvm.h                   | 25 +++++++
>  >  system/physmem.c                       | 29 ++++++++
>  >  17 files changed, 212 insertions(+), 44 deletions(-)
>  >
>  > --
>  > 2.34.1
>  >
>  >


