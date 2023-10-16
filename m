Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B407CB2C0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:43:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSXQ-0007zy-5B; Mon, 16 Oct 2023 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSX8-0007wJ-B2; Mon, 16 Oct 2023 14:41:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWn-0006Ic-Eq; Mon, 16 Oct 2023 14:41:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GIbHfs008463; Mon, 16 Oct 2023 18:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Je63NYtRvzr8grIKdpbydCQ9w93Gq4fLwYflc25q4AA=;
 b=JYUJyE430ncZ1HCMPgw0cdvIK7VQCEzKUxSQ9ebots/2hQQ92uNWMvgE+n2hdrwavU+v
 yx14LQy862iwTQ3tUzyVR1fLZoKGgEd+vxmzqgd5Xvp5/zm3WygKoC8FAuVRcC2GBELD
 FY5IivOSlD+IHn9iLDDJVRPC++1VI3W7iMmmRG9+Er7xfS3qsbbWJGfR7jOCfyqzD1dC
 1jpP5Pq09oIfHXMNsTU3Ix+JvcAh+rkngMwp3lSfj1smCxIr62MAJThYIRn5aSCqaVXL
 aolkdaXrIQ7R6MCHTCYhsVrfKzxMp68gPPlohQnFBb6/KFUbTyyoptAkOushK1+C+YTD Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsam687wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:34 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GIbY5I009489;
 Mon, 16 Oct 2023 18:40:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsam68754-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GIKwRH027190; Mon, 16 Oct 2023 18:39:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tk2mhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:39:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GIdQNY44827252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 18:39:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BED222004B;
 Mon, 16 Oct 2023 18:39:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4588D20040;
 Mon, 16 Oct 2023 18:39:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:39:26 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v26 00/21] s390x: CPU Topology
Date: Mon, 16 Oct 2023 20:39:04 +0200
Message-Id: <20231016183925.2384704-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: abvEB4Ar0kyyDJo6eWh1pF86mhBxHWc_
X-Proofpoint-GUID: bbLtkVWvzpxAgFCVC36PVdP8FMUOCT__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Changes since v25 (see range-diff below):
* documentation changes (thanks Markus)
* picked up tags (thanks Thomas, Markus)
* rebased onto master

Changes since v24 (thanks Thomas):
* add machine-common.json to MAINTAINERS
* rename s390_topology_id
* move topology list cleanup due to s390_cpu_virt_mem_handle_exc on tcg
* pick up tags
* fix nits

Changes since v23:
* qapi documentation changes (thanks Markus)
* avoid compiler warning about multiplication in bool expression

Changes since v22:
* fix compile issues (thanks Thomas, Cédric)
* incorporate feedback (thanks Thomas!), most notably
 * forbid books and drawers in older machine types
 * changed implementation of TLE entry ordering
* also got rid of another ERRP_GUARD in s390_change_topology
* pick up R-b's (thanks Thomas)
* misc minor stuff

Changes since v21:

* fix ordering of entries in topology list
* don't leak topology list on error condition in insert_stsi_15_1_x
* make entitlement, dedication optional in query-cpu-info-fast
* rename query-cpu-polarization to query-s390x-cpu-polarization
* documentation changes
* add tests of guest view to avocado tests
* require KVM in avocado tests
* increase timeout in tests
* bump version in comments documenting availability to 8.2
* rename some symbols
* picked up R-b's (thanks Thomas)
* minor stuff, typos

Implementation discussions
==========================

CPU models
----------

Since the facility 11, S390_FEAT_CONFIGURATION_TOPOLOGY is already
in the CPU model for old QEMU we could not activate it as usual from
KVM but needed a KVM capability: KVM_CAP_S390_CPU_TOPOLOGY.
Checking and enabling this capability enables facility 11,
S390_FEAT_CONFIGURATION_TOPOLOGY.

It is the responsibility of the admin to ensure the same CPU
model for source and target host in a migration.

Migration
---------

When the target guest is started, the Multi-processor Topology Change
Report (MTCR) bit is set during the creation of the vCPU by KVM.
We do not need to migrate its state, in the worst case, the target
guest will see the MTCR and actualize its view of the topology
without necessity, but this will be done only one time.

Reset
-----

Reseting the topology is done during subsystem reset, the
polarization is reset to horizontal polarization.

Topology attributes
-------------------

The topology attributes are carried by the CPU object and defined
on object creation.
In the case the new attributes, socket, book, drawer, dedicated,
entitlement are not provided QEMU provides defaults values.

- Geometry defaults
  The geometry default are based on the core-id of the core to
  fill the geometry in a monotone way starting with drawer 0,
  book 0, and filling socket 0 with the number of cores per socket,
  then filling socket 1, socket 2 ... etc until the book is complete
  and all books until the first drawer is complete before starting with
  the next drawer.

  This allows to keep existing start scripts and Libvirt existing
  interface until it is extended.

- Modifiers defaults
  Default entitlement is medium
  Default dedication is not dedicated.

- Machine polarization default to horizontal

Dynamic topology modification
-----------------------------

QAPI interface is extended with:
- a command: 'set-cpu-topology'
- a query: 'query-cpu-polarization'
- a query: extension of qmp 'query-cpus-fast'
- a query: extension of hmp 'hotpluggable-cpus'
- an event: 'CPU_POLARITY_CHANGE'

New command and interface are specified as unstable.

The admin may use query-cpus-fast to verify the topology provided
to the guest and set-cpu-topology to modify it.

The event CPU_POLARITY_CHANGE is sent when the guest successfuly
uses the PTF(2) instruction to request a polarization change.
In that case, the admin is supposed to modify the CPU provisioning
accordingly.

Testing
=======

To use the QEMU patches, you will need Linux V6-rc1 or newer,
or use the following Linux mainline patches:

f5ecfee94493 2022-07-20 KVM: s390: resetting the Topology-Change-Report
24fe0195bc19 2022-07-20 KVM: s390: guest support for topology function
0130337ec45b 2022-07-20 KVM: s390: Cleanup ipte lock access and SIIF fac..

Currently this code is for KVM only, I have no idea if it is interesting
to provide a TCG patch. If ever it will be done in another series.

This series provide 12 avocado tests using Fedora-35 kernel and initrd
image.

Documentation
=============

To have a better understanding of the S390x CPU Topology and its
implementation in QEMU you can have a look at the documentation in the
last patch of this series.

The admin will want to match the host and the guest topology, taking
into account that the guest does not recognize multithreading.
Consequently, two vCPU assigned to threads of the same real CPU should
preferably be assigned to the same socket of the guest machine.

Previous changes:
Since v20:

- changed name of target/s390/kvm/cpu_topology to
  target/s390/kvm/stsi-topology
  (Thomas, Cedric)

- moved the TLE list head from a global to a local in
  insert_stsi_15_1_x()
  (Nina)

- cleaning and merging some of the avocado tests
  (Nina)

- Several cleanings
  (Cedric, Thomas, Nina)

- moved setting of entitlement and dedicated from disapeared
  cpustate_to_cpuinfo_s390() to new s390_query_cpu_fast()

- small changes to documentation to reflect last changes using
  enum instead of int for polarization.
  0 -> horizontal and 1 -> vertical

Since v19:

- use enum to specify the entitlement
  (Nina)

- Change default entitlement to "auto"

- suppress skip_basis in avocado tests
  (after comment from Cedric)

- Correction of the documentation
  (Cedric)

- better code organization for s390_topology_add_core_to_socket
  and s390_socket_nb
  (Cedric)

- Changed Copyright to respect IBM policy
  (Nina)

- set vertical_polarization back into s390_topology
  (Nina)

Since v18:

- Changed default entitlement to S390_CPU_ENTITLEMENT__MAX
  because no default can be correct.

- added polarization entry to the S390CcwMachineState
  which allow to suppress shadow entitlement

- Suppress shadow entitlement
  (Nina)

- Added query-cpu-polarization

- Added more avocado tests

- modified cpu_hierarchy_to_string to look better
  (Nina)

Since v17:

- bug correction in handling PTF

- added avocado tests
  (Thomas)

- Change comments on QEMU machine to 8.1

Since v16:

- documentation, split, bug correction and rephrasing
  (Nina, Thomas)

- create machine-common.json

- use of entitlement_shadow to keep track of the entitlement

- adding drawers and books to query-hotpluggable-cpus

- keep hmp interface for set-cpu-topology for a future series

Since v15:

- Use Enum for polarity and entitlement
  (Nina)

- move kvm_vm_enable_cap(KVM_CAP_S390_CPU_TOPOLOGY) to
  kvm_arch_init()
  (Thomas)

- Make all CPU attributes optional for set-cpu-topology monitor
  command
  (Thomas, Nina)

- Change use of the prefix "x-" to the use of feature unstable
  to declare set-cpu-topology as unstable.
  (Nina)

- Make CPU_POLARITY_CHANGE even as unstable
  (Nina)

- Documentation update
  (Thomas, Nina)

Since v14:

- move the ordering of TLE to just before filling the SYSIB,
  optimize TLE ordering to be done on need only.
  (Cedric in previous series)

- remove 'query-topology' and instead extend 'query-cpus-fast'
  (Daniel)

- rename POLARITY_CHANGE to CPU_POLARITY_CHANGE
  (Thomas)

- Divers bugs correction and doc changes
  (Thomas, Nina)

- Separate topology and entitlement, simplify pft handling
  (Nina)

- add the resetting of all CPU to horizontal polarity
  once implementing PTF interpretation

Since v13:

- Suppress the topology device to simplify the code
  (Cedric)

- moved reset of MTCR from device reset into subsystem
  reset and removed previous reviewed-by from Nico and
  Janis

- No need for Migration

- No need for machine dependencies
  (Christian, Thomas)

- Adding all features, drawer/book and dynamic
  (Cedric)

- since v12

- suppress new CPU flag "disable-topology" just use ctop

- no use of special fields in CCW machine or in CPU

- modifications in documentation

- insert documentation in tree
  (Cedric)

- moved cpu-topology.c from target/s390 to target/s390/kvm
  to compile smoothly (without topology) for TCG
  (Cedric)

- since v11

- new CPU flag "disable-topology"
  I would have take "topology" if I was able to have
  it false on default.
  (Christian, Thomas)

- Build the topology during the interception of the
  STSI instruction.
  (Cedric)

- return CC3 in case the calculated SYSIB length is
  greater than 4096.
  (Janis)

- minor corections on documentation

- since v10

- change machine attribute "topology-disable" to "topology"
  (Cedric)
- Add preliminary patch for machine properties
  (Cedric)
- Use next machine as 7.2
  (Cedric / Connie)
- Remove unecessary mutex
  (Thomas)
- use ENOTSUP return value for kvm_s390_topology_set_mtcr()
  (Cedric)
- Add explanation on container and cpu TLEs
  (Thomas)
- use again cpu and socket count in topology structure
  (Cedric)
- Suppress the S390TopoTLE structure and integrate
  the TLE masks to the socket structure.
  (-)
- the STSI instruction now finds the topology from the machine
  (Cedric)

- since v9

- remove books and drawers

- remove thread denying and replace with a merge
  of cores * threads to specify the CPUs available
  to the guest

- add a class option to avoid topology on older
  machines
  (Cedric)

- Allocate a SYSIB buffer of the maximal length to
  avoid overflow.
  (Nico, Janis)

- suppress redundancy of smp parameters in topology
  and use directly the machine smp structure

- Early check for topology support
  (Cedric)

- since v8

- Linux patches are now mainline

- simplification of the implementation
  (Janis)

- Migration, new machine definition
  (Thomas)

- Documentation

- since v7

- Coherence with the Linux patch series changes for MTCR get
  (Pierre)

- check return values during new CPU creation
  (Thomas)

- Improving codding style and argument usages
  (Thomas)

- since v6

- Changes on smp args in qemu-options
  (Daniel)

- changed comments in machine.jason
  (Daniel)

- Added reset
  (Janosch)

- since v5

- rebasing on newer QEMU version

- reworked most lines above 80 characters.

- since v4

- Added drawer and books to topology

- Added numa topology

- Added documentation

- since v3

- Added migration
  (Thomas)

- Separated STSI instruction from KVM to prepare TCG
  (Thomas)

- Take care of endianess to prepare TCG
  (Thomas)

- Added comments on STSI CPU container and PFT instruction
  (Thomas)

- Moved enabling the instructions as the last patch
  (Thomas)

Nina Schoetterl-Glausch (1):
  qapi: machine.json: change docs regarding CPU topology

Pierre Morel (20):
  CPU topology: extend with s390 specifics
  s390x/cpu topology: add topology entries on CPU hotplug
  target/s390x/cpu topology: handle STSI(15) and build the SYSIB
  s390x/sclp: reporting the maximum nested topology entries
  s390x/cpu topology: resetting the Topology-Change-Report
  s390x/cpu topology: interception of PTF instruction
  target/s390x/cpu topology: activate CPU topology
  qapi/s390x/cpu topology: set-cpu-topology qmp command
  machine: adding s390 topology to query-cpu-fast
  machine: adding s390 topology to info hotpluggable-cpus
  qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE QAPI event
  qapi/s390x/cpu topology: add query-s390x-cpu-polarization command
  docs/s390x/cpu topology: document s390x cpu topology
  tests/avocado: s390x cpu topology core
  tests/avocado: s390x cpu topology polarization
  tests/avocado: s390x cpu topology entitlement tests
  tests/avocado: s390x cpu topology test dedicated CPU
  tests/avocado: s390x cpu topology test socket full
  tests/avocado: s390x cpu topology dedicated errors
  tests/avocado: s390x cpu topology bad move

 MAINTAINERS                         |  11 +
 docs/devel/index-internals.rst      |   1 +
 docs/devel/s390-cpu-topology.rst    | 170 ++++++++++
 docs/system/s390x/cpu-topology.rst  | 244 +++++++++++++++
 docs/system/target-s390x.rst        |   1 +
 qapi/machine-common.json            |  21 ++
 qapi/machine-target.json            | 121 +++++++
 qapi/machine.json                   |  86 +++--
 qapi/qapi-schema.json               |   1 +
 include/hw/boards.h                 |  10 +-
 include/hw/qdev-properties-system.h |   4 +
 include/hw/s390x/cpu-topology.h     |  78 +++++
 include/hw/s390x/s390-virtio-ccw.h  |   6 +
 include/hw/s390x/sclp.h             |   4 +-
 target/s390x/cpu.h                  |  82 +++++
 target/s390x/kvm/kvm_s390x.h        |   1 +
 hw/core/machine-hmp-cmds.c          |   6 +
 hw/core/machine-smp.c               |  48 ++-
 hw/core/machine.c                   |   4 +
 hw/core/qdev-properties-system.c    |  13 +
 hw/s390x/cpu-topology.c             | 469 ++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          |  29 +-
 hw/s390x/sclp.c                     |   5 +
 system/vl.c                         |   6 +
 target/s390x/cpu-sysemu.c           |  13 +
 target/s390x/cpu.c                  |  16 +
 target/s390x/cpu_models.c           |   1 +
 target/s390x/kvm/kvm.c              |  42 ++-
 target/s390x/kvm/stsi-topology.c    | 334 ++++++++++++++++++++
 hw/s390x/meson.build                |   1 +
 qapi/meson.build                    |   1 +
 qemu-options.hx                     |   7 +-
 target/s390x/kvm/meson.build        |   3 +-
 tests/avocado/s390_topology.py      | 439 ++++++++++++++++++++++++++
 34 files changed, 2241 insertions(+), 37 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py

Range-diff against v25:
 1:  578a12c6e9 !  1:  cd428e36e1 qapi: machine.json: change docs regarding CpuInstanceProperties
    @@ Metadata
     Author: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## Commit message ##
    -    qapi: machine.json: change docs regarding CpuInstanceProperties
    +    qapi: machine.json: change docs regarding CPU topology
     
         Clarify roles of different architectures.
         Also change things a bit in anticipation of additional members being
    @@ qapi/machine.json
      # should be passed by management with device_add command when a CPU is
      # being hotplugged.
      #
    -+# Which members are optional and which mandatory depends on the architecture
    -+# and board.
    ++# Which members are optional and which mandatory depends on the
    ++# architecture and board.
    ++#
    ++# The ids other than the node-id specify the position of the CPU
    ++# within the CPU topology as defined by @SMPConfiguration.
     +#
      # @node-id: NUMA node ID the CPU belongs to
      #
    - # @socket-id: socket number within node/board the CPU belongs to
    -@@
    +-# @socket-id: socket number within node/board the CPU belongs to
    ++# @socket-id: socket number within CPU topology the CPU belongs to
    + #
    +-# @die-id: die number within socket the CPU belongs to (since 4.1)
    ++# @die-id: die number within the parent container the CPU belongs to
    ++#    (since 4.1)
    + #
    +-# @cluster-id: cluster number within die the CPU belongs to (since
    +-#     7.1)
    ++# @cluster-id: cluster number within the parent container the CPU
    ++#     belongs to (since 7.1)
    + #
    +-# @core-id: core number within cluster the CPU belongs to
    ++# @core-id: core number within the parent container the CPU
    ++#     belongs to
      #
    - # @thread-id: thread number within core the CPU belongs to
    +-# @thread-id: thread number within core the CPU belongs to
    ++# @thread-id: thread number within the core the CPU  belongs to
      #
     -# Note: currently there are 6 properties that could be present but
     -#     management should be prepared to pass through other properties
    @@ qapi/machine.json
     -#     This also requires the filed names to be kept in sync with the
     -#     properties passed to -device/device_add.
     +# Note: management should be prepared to pass through additional
    -+# properties with device_add.
    ++#     properties with device_add.
      #
      # Since: 2.7
      ##
    @@ qapi/machine.json
        'data': { '*node-id': 'int',
                  '*socket-id': 'int',
                  '*die-id': 'int',
    +@@
    + # Schema for CPU topology configuration.  A missing value lets QEMU
    + # figure out a suitable value based on the ones that are provided.
    + #
    ++# The members other than @cpus and @maxcpus define topology
    ++# containers.
    ++#
    ++# The ordering from highest/coarsest to lowest/finest is:
    ++# @sockets, @dies, @clusters, @cores, @threads.
    ++#
    ++# Different architectures support different subsets of topology
    ++# containers.
    ++#
    ++# For examples, s390x does not have clusters and dies, the socket
    ++# is the parent container of cores.
    ++#
    + # @cpus: number of virtual CPUs in the virtual machine
    + #
    ++# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
    ++#     machine
    ++#
    + # @sockets: number of sockets in the CPU topology
    + #
    +-# @dies: number of dies per socket in the CPU topology
    ++# @dies: number of dies per parent container
    + #
    +-# @clusters: number of clusters per die in the CPU topology (since
    ++# @clusters: number of clusters per parent container (since
    + #     7.0)
    + #
    +-# @cores: number of cores per cluster in the CPU topology
    ++# @cores: number of cores per parent container
    + #
    +-# @threads: number of threads per core in the CPU topology
    +-#
    +-# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
    +-#     machine
    ++# @threads: number of threads per core
    + #
    + # Since: 6.1
    + ##
 2:  4a6314be55 !  2:  b6e60f0118 CPU topology: extend with s390 specifics
    @@ Commit message
         entitlement. These indicate to the guest information on host
         vCPU scheduling and help the guest make better scheduling decisions.
     
    -    Let us provide the SMP properties with books and drawers levels
    -    and S390 CPU with dedication and entitlement,
    -
    -    Add machine-common.json so we can later include it in
    +    Add the new levels to the relevant QAPI structs.
    +    Add all the supported topology levels, dedication and entitlement
    +    as properties to S390 CPUs.
    +    Create machine-common.json so we can later include it in
         machine-target.json also.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    @@ qapi/machine.json
      #
      # @node-id: NUMA node ID the CPU belongs to
      #
    --# @socket-id: socket number within node/board the CPU belongs to
    -+# @drawer-id: drawer number within node/board the CPU belongs to
    +-# @socket-id: socket number within CPU topology the CPU belongs to
    ++# @drawer-id: drawer number within CPU topology the CPU belongs to
     +#     (since 8.2)
     +#
    -+# @book-id: book number within drawer/node/board the CPU belongs to
    ++# @book-id: book number within parent container the CPU belongs to
     +#     (since 8.2)
     +#
    -+# @socket-id: socket number within book/node/board the CPU belongs to
    - #
    - # @die-id: die number within socket the CPU belongs to (since 4.1)
    ++# @socket-id: socket number within parent container the CPU belongs to
      #
    + # @die-id: die number within the parent container the CPU belongs to
    + #    (since 4.1)
     @@
      { 'struct': 'CpuInstanceProperties',
        # Keep these in sync with the properties device_add accepts
    @@ qapi/machine.json
                  '*die-id': 'int',
                  '*cluster-id': 'int',
     @@
    + # containers.
      #
    - # @cpus: number of virtual CPUs in the virtual machine
    + # The ordering from highest/coarsest to lowest/finest is:
    +-# @sockets, @dies, @clusters, @cores, @threads.
    ++# @drawers, @books, @sockets, @dies, @clusters, @cores, @threads.
      #
    + # Different architectures support different subsets of topology
    + # containers.
    +@@
    + # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
    + #     machine
    + #
    +-# @sockets: number of sockets in the CPU topology
     +# @drawers: number of drawers in the CPU topology (since 8.2)
     +#
     +# @books: number of books in the CPU topology (since 8.2)
     +#
    - # @sockets: number of sockets in the CPU topology
    ++# @sockets: number of sockets per parent container
    + #
    + # @dies: number of dies per parent container
      #
    - # @dies: number of dies per socket in the CPU topology
     @@
      ##
      { 'struct': 'SMPConfiguration', 'data': {
    @@ hw/s390x/s390-virtio-ccw.c: static void ccw_machine_8_1_class_options(MachineCla
      DEFINE_CCW_MACHINE(8_1, "8.1", false);
      
     
    - ## softmmu/vl.c ##
    -@@ softmmu/vl.c: static QemuOptsList qemu_smp_opts = {
    + ## system/vl.c ##
    +@@ system/vl.c: static QemuOptsList qemu_smp_opts = {
              {
                  .name = "cpus",
                  .type = QEMU_OPT_NUMBER,
    @@ target/s390x/cpu.c
      #include "fpu/softfloat-helpers.h"
      #include "disas/capstone.h"
      #include "sysemu/tcg.h"
    -@@ target/s390x/cpu.c: static gchar *s390_gdb_arch_name(CPUState *cs)
    +@@ target/s390x/cpu.c: static const gchar *s390_gdb_arch_name(CPUState *cs)
      static Property s390x_cpu_properties[] = {
      #if !defined(CONFIG_USER_ONLY)
          DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
 3:  a9e88599a3 =  3:  59d4c18344 s390x/cpu topology: add topology entries on CPU hotplug
 4:  27d8da8b17 !  4:  7be532d29a target/s390x/cpu topology: handle STSI(15) and build the SYSIB
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Acked-by: Markus Armbruster <armbru@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
 5:  5d1128773c =  5:  53bcdae9d1 s390x/sclp: reporting the maximum nested topology entries
 6:  82b4423958 =  6:  8b16d5b656 s390x/cpu topology: resetting the Topology-Change-Report
 7:  20cc1ec693 =  7:  1f7c1dbeb9 s390x/cpu topology: interception of PTF instruction
 8:  6ea320af67 =  8:  732786e6c8 target/s390x/cpu topology: activate CPU topology
 9:  7b1f5de930 !  9:  c9b91fac30 qapi/s390x/cpu topology: set-cpu-topology qmp command
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
    @@ qapi/machine-target.json
     +##
     +# @set-cpu-topology:
     +#
    -+# Modifies the topology by moving the CPU inside the topology
    -+# tree or by changing a modifier attribute of a CPU.
    ++# Modify the topology by moving the CPU inside the topology tree,
    ++# or by changing a modifier attribute of a CPU.
     +# Absent values will not be modified.
     +#
     +# @core-id: the vCPU ID to be moved
    @@ qapi/machine-target.json
     +#
     +# Features:
     +#
    -+# @unstable: This command may still be modified.
    ++# @unstable: This command is experimental.
     +#
    -+# Returns: Nothing on success, the reason on failure.
    ++# Returns: Nothing on success.
     +#
     +# Since: 8.2
     +##
10:  97713ece9a ! 10:  bfb5ffe34c machine: adding s390 topology to query-cpu-fast
    @@ Commit message
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Acked-by: Markus Armbruster <armbru@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine.json ##
    @@ qapi/machine.json
     +{ 'struct': 'CpuInfoS390',
     +  'data': { 'cpu-state': 'CpuS390State',
     +            '*dedicated': 'bool',
    -+            '*entitlement': 'CpuS390Entitlement'
    -+  }
    -+}
    ++            '*entitlement': 'CpuS390Entitlement' } }
      
      ##
      # @CpuInfoFast:
11:  ac238a12cc = 11:  ea8c39954f machine: adding s390 topology to info hotpluggable-cpus
12:  0c4056fe8e ! 12:  ade403ce73 qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
    @@ Metadata
     Author: Pierre Morel <pmorel@linux.ibm.com>
     
      ## Commit message ##
    -    qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
    +    qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE QAPI event
     
         When the guest asks to change the polarization this change
         is forwarded to the upper layer using QAPI.
    @@ Commit message
         Reviewed-by: Thomas Huth <thuth@redhat.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Acked-by: Markus Armbruster <armbru@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
    @@ qapi/machine-target.json
     +#
     +# On horizontal polarization the host is expected to provision all vCPUs
     +# equally.
    ++#
     +# On vertical polarization the host can provision each vCPU differently.
     +# The guest will get information on the details of the provisioning
     +# the next time it uses the STSI(15) instruction.
13:  bc7d0dafca ! 13:  7b8039171c qapi/s390x/cpu topology: add query-s390x-cpu-polarization command
    @@ Commit message
         Reviewed-by: Thomas Huth <thuth@redhat.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Acked-by: Markus Armbruster <armbru@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
14:  f2b1dbf34e ! 14:  90beef205a docs/s390x/cpu topology: document s390x cpu topology
    @@ docs/system/target-s390x.rst: Architectural features
     
      ## qapi/machine.json ##
     @@
    - # Which members are optional and which mandatory depends on the architecture
    - # and board.
    + # Which members are optional and which mandatory depends on the
    + # architecture and board.
      #
     +# For s390x see :ref:`cpu-topology-s390x`.
     +#
    - # @node-id: NUMA node ID the CPU belongs to
    + # The ids other than the node-id specify the position of the CPU
    + # within the CPU topology as defined by @SMPConfiguration.
      #
    - # @drawer-id: drawer number within node/board the CPU belongs to
15:  9feb5107c2 = 15:  a0eeb09e1d tests/avocado: s390x cpu topology core
16:  973ad2b9ce = 16:  1ec69857f5 tests/avocado: s390x cpu topology polarization
17:  bbcfd9219a = 17:  0c70dc28b9 tests/avocado: s390x cpu topology entitlement tests
18:  142a6e6f7d = 18:  cb1d0be224 tests/avocado: s390x cpu topology test dedicated CPU
19:  8c71a5dd64 = 19:  2b2561fb11 tests/avocado: s390x cpu topology test socket full
20:  96051b8457 = 20:  0e778dde3f tests/avocado: s390x cpu topology dedicated errors
21:  c5ad16cf5e = 21:  45f15cd82c tests/avocado: s390x cpu topology bad move

base-commit: 63011373ad22c794a013da69663c03f1297a5c56
-- 
2.39.2


