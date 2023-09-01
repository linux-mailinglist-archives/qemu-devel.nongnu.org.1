Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08F790050
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 18:00:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6Xv-0004PR-23; Fri, 01 Sep 2023 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qc6Xr-0004PB-BI; Fri, 01 Sep 2023 11:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qc6Xm-0000eF-4a; Fri, 01 Sep 2023 11:58:51 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381Fb7MV006445; Fri, 1 Sep 2023 15:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7omLhlaqcTEJomSe8/FVSCyUQFu48JCTWxjTTMUy5i4=;
 b=kYoMwbWL16hFMzlV3llbIIFjqf8wjC0rAEvg0iZPv6QBBjgDIruH8pMLGPvM/pqu9fxl
 4pZrKI7hjyO821DOGYKiMyPGebcGHL29sJLvoWSsn//ByCRL++ojXYc0jZir3/VcNEhe
 oeOtgMv3eKpE7If4dftGL/k2EeHhbvuJBkZT/mXwF24C5pII05ymvplY2ctLy3fwH+Ne
 4UvVZ1xx8YwXmoJz3MEVTBjbB9zeMER4LTAE6ZOX6GA4tPQGVeIYqBtmCZ91kPrhVjIL
 YwZr24aRrxka1IcwPzLFRU208EpI+KomKfntGRPFBWhSp33sq3burpecjkEkZaNYziDz Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sujnj0um6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:58:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381FbAXC006831;
 Fri, 1 Sep 2023 15:58:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sujnj0ukm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:58:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 381EatdL014416; Fri, 1 Sep 2023 15:58:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqnx14f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:58:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 381FwK4518940450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Sep 2023 15:58:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9303B20043;
 Fri,  1 Sep 2023 15:58:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A5A82004B;
 Fri,  1 Sep 2023 15:58:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Sep 2023 15:58:19 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v22 00/20] s390x: CPU Topology
Date: Fri,  1 Sep 2023 17:57:52 +0200
Message-Id: <20230901155812.2696560-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OsWNRsIi9KGpo_Uno4yNK4TfewtTJ7HO
X-Proofpoint-ORIG-GUID: 0HZDBx1eCBgKAMK1MttuXAF7-rOhMqqL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010145
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

Changes since v21 (range-diff below):

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
  qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
  qapi/s390x/cpu topology: query-cpu-polarization qmp command
  docs/s390x/cpu topology: document s390x cpu topology
  tests/avocado: s390x cpu topology core
  tests/avocado: s390x cpu topology polarization
  tests/avocado: s390x cpu topology entitlement tests
  tests/avocado: s390x cpu topology test dedicated CPU
  tests/avocado: s390x cpu topology test socket full
  tests/avocado: s390x cpu topology dedicated errors
  tests/avocado: s390x cpu topology bad move

 MAINTAINERS                         |  10 +
 docs/devel/index-internals.rst      |   1 +
 docs/devel/s390-cpu-topology.rst    | 171 ++++++++++
 docs/system/s390x/cpu-topology.rst  | 242 ++++++++++++++
 docs/system/target-s390x.rst        |   1 +
 qapi/machine-common.json            |  21 ++
 qapi/machine-target.json            | 113 +++++++
 qapi/machine.json                   |  30 +-
 include/hw/boards.h                 |  10 +-
 include/hw/qdev-properties-system.h |   4 +
 include/hw/s390x/cpu-topology.h     |  80 +++++
 include/hw/s390x/s390-virtio-ccw.h  |   6 +
 include/hw/s390x/sclp.h             |   4 +-
 target/s390x/cpu.h                  |  83 +++++
 target/s390x/kvm/kvm_s390x.h        |   1 +
 hw/core/machine-hmp-cmds.c          |   6 +
 hw/core/machine-smp.c               |  48 ++-
 hw/core/machine.c                   |   4 +
 hw/core/qdev-properties-system.c    |  13 +
 hw/s390x/cpu-topology.c             | 475 ++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          |  27 +-
 hw/s390x/sclp.c                     |   5 +
 softmmu/vl.c                        |   6 +
 target/s390x/cpu-sysemu.c           |  13 +
 target/s390x/cpu.c                  |  16 +
 target/s390x/cpu_models.c           |   1 +
 target/s390x/kvm/kvm.c              |  42 ++-
 target/s390x/kvm/stsi-topology.c    | 296 +++++++++++++++++
 hw/s390x/meson.build                |   1 +
 qapi/meson.build                    |   1 +
 qemu-options.hx                     |   7 +-
 target/s390x/kvm/meson.build        |   3 +-
 tests/avocado/s390_topology.py      | 432 +++++++++++++++++++++++++
 33 files changed, 2153 insertions(+), 20 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py

Range-diff against v21:
 1:  890004859f !  1:  c26d3df9f9 s390x/cpu topology: add s390 specifics to CPU topology
    @@ Metadata
     Author: Pierre Morel <pmorel@linux.ibm.com>
     
      ## Commit message ##
    -    s390x/cpu topology: add s390 specifics to CPU topology
    +    CPU topology: extend with s390 specifics
     
         S390 adds two new SMP levels, drawers and books to the CPU
         topology.
    -    The S390 CPU have specific topology features like dedication
    -    and entitlement to give to the guest indications on the host
    -    vCPUs scheduling and help the guest take the best decisions
    -    on the scheduling of threads on the vCPUs.
    +    S390 CPUs have specific topology features like dedication and
    +    entitlement. These indicate to the guest information on host
    +    vCPU scheduling and help the guest make better scheduling decisions.
     
         Let us provide the SMP properties with books and drawers levels
         and S390 CPU with dedication and entitlement,
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-common.json (new) ##
     @@
    @@ qapi/machine-common.json (new)
     +# An enumeration of cpu entitlements that can be assumed by a virtual
     +# S390 CPU
     +#
    -+# Since: 8.1
    ++# Since: 8.2
     +##
     +{ 'enum': 'CpuS390Entitlement',
     +  'prefix': 'S390_CPU_ENTITLEMENT',
     +  'data': [ 'auto', 'low', 'medium', 'high' ] }
    -+
     
      ## qapi/machine.json ##
     @@
    @@ qapi/machine.json
      # @thread-id: ID of the underlying host thread
      #
     -# @props: properties describing to which node/socket/core/thread
    +-#     virtual CPU belongs to, provided if supported by board
     +# @props: properties describing to which node/drawer/book/socket/core/thread
    - #         virtual CPU belongs to, provided if supported by board
    ++#         virtual CPU belongs to, provided if supported by board
      #
      # @target: the QEMU system emulation target, which determines which
    + #     additional fields will be listed (since 3.0)
     @@
    - # a CPU is being hotplugged.
      #
      # @node-id: NUMA node ID the CPU belongs to
    + #
     -# @socket-id: socket number within node/board the CPU belongs to
    -+# @drawer-id: drawer number within node/board the CPU belongs to (since 8.1)
    -+# @book-id: book number within drawer/node/board the CPU belongs to (since 8.1)
    ++# @drawer-id: drawer number within node/board the CPU belongs to (since 8.2)
    ++#
    ++# @book-id: book number within drawer/node/board the CPU belongs to (since 8.2)
    ++#
     +# @socket-id: socket number within book/node/board the CPU belongs to
    + #
      # @die-id: die number within socket the CPU belongs to (since 4.1)
    - # @cluster-id: cluster number within die the CPU belongs to (since 7.1)
    - # @core-id: core number within cluster the CPU belongs to
    + #
    +@@
    + #
      # @thread-id: thread number within core the CPU belongs to
      #
    --# Note: currently there are 6 properties that could be present
    -+# Note: currently there are 8 properties that could be present
    - #       but management should be prepared to pass through other
    - #       properties with device_add command to allow for future
    - #       interface extension. This also requires the filed names to be kept in
    +-# Note: currently there are 6 properties that could be present but
    ++# Note: currently there are 8 properties that could be present but
    + #     management should be prepared to pass through other properties
    + #     with device_add command to allow for future interface extension.
    + #     This also requires the filed names to be kept in sync with the
     @@
      ##
      { 'struct': 'CpuInstanceProperties',
    @@ qapi/machine.json
      #
      # @cpus: number of virtual CPUs in the virtual machine
      #
    -+# @drawers: number of drawers in the CPU topology (since 8.1)
    ++# @drawers: number of drawers in the CPU topology (since 8.2)
     +#
    -+# @books: number of books in the CPU topology (since 8.1)
    ++# @books: number of books in the CPU topology (since 8.2)
     +#
      # @sockets: number of sockets in the CPU topology
      #
    @@ include/hw/qdev-properties-system.h: extern const PropertyInfo qdev_prop_pcie_li
     
      ## target/s390x/cpu.h ##
     @@
    - #include "cpu_models.h"
      #include "exec/cpu-defs.h"
      #include "qemu/cpu-float.h"
    + #include "tcg/tcg_s390x.h"
     +#include "qapi/qapi-types-machine-common.h"
      
      #define ELF_MACHINE_UNAME "S390X"
 2:  282bd17cab !  2:  6d32f1e3d4 s390x/cpu topology: add topology entries on CPU hotplug
    @@ Commit message
         still get some advantage of the CPU topology.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: F: hw/s390x/event-facility.c
    @@ MAINTAINERS: F: hw/s390x/event-facility.c
      L: qemu-s390x@nongnu.org
      
     +S390 CPU topology
    -+M: Pierre Morel <pmorel@linux.ibm.com>
    ++M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     +S: Supported
     +F: include/hw/s390x/cpu-topology.h
     +F: hw/s390x/cpu-topology.c
    @@ include/hw/s390x/cpu-topology.h (new)
     +/*
     + * CPU Topology
     + *
    -+ * Copyright IBM Corp. 2022,2023
    ++ * Copyright IBM Corp. 2022, 2023
     + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
     + *
     + */
    @@ hw/s390x/cpu-topology.c (new)
     +/*
     + * CPU Topology
     + *
    -+ * Copyright IBM Corp. 2022,2023
    ++ * Copyright IBM Corp. 2022, 2023
     + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
     + *
     + * S390 topology handling can be divided in two parts:
    @@ hw/s390x/cpu-topology.c (new)
     + * s390_topology is used to keep the topology information.
     + * .cores_per_socket: tracks information on the count of cores
     + *                    per socket.
    -+ * .smp: keeps track of the machine topology.
    -+ *
     + */
     +S390Topology s390_topology = {
    -+    /* will be initialized after the cpu model is realized */
    ++    /* will be initialized after the CPU model is realized */
     +    .cores_per_socket = NULL,
     +};
     +
    @@ hw/s390x/cpu-topology.c (new)
     + * Returns the socket number used inside the cores_per_socket array
     + * for a topology tree entry
     + */
    -+static int __s390_socket_nb(int drawer_id, int book_id, int socket_id)
    ++static int s390_socket_nb_from_ids(int drawer_id, int book_id, int socket_id)
     +{
     +    return (drawer_id * current_machine->smp.books + book_id) *
     +           current_machine->smp.sockets + socket_id;
    @@ hw/s390x/cpu-topology.c (new)
     + */
     +static int s390_socket_nb(S390CPU *cpu)
     +{
    -+    return __s390_socket_nb(cpu->env.drawer_id, cpu->env.book_id,
    -+                            cpu->env.socket_id);
    ++    return s390_socket_nb_from_ids(cpu->env.drawer_id, cpu->env.book_id,
    ++                                   cpu->env.socket_id);
     +}
     +
     +/**
     + * s390_has_topology:
     + *
    -+ * Return value: if the topology is supported by the machine.
    ++ * Return: true if the topology is supported by the machine.
     + */
     +bool s390_has_topology(void)
     +{
    @@ hw/s390x/cpu-topology.c (new)
     +
     +    /*
     +     * When the user specifies the entitlement as 'auto' on the command line,
    -+     * qemu will set the entitlement as:
    ++     * QEMU will set the entitlement as:
     +     * Medium when the CPU is not dedicated.
     +     * High when dedicated is true.
     +     */
    @@ hw/s390x/cpu-topology.c (new)
     +    }
     +    if (dedicated && (entitlement == S390_CPU_ENTITLEMENT_LOW ||
     +                      entitlement == S390_CPU_ENTITLEMENT_MEDIUM)) {
    -+        error_setg(errp, "A dedicated cpu implies high entitlement");
    ++        error_setg(errp, "A dedicated CPU implies high entitlement");
     +        return false;
     +    }
     +    return true;
    @@ hw/s390x/cpu-topology.c (new)
     +    int entry;
     +
     +    /*
    -+     * We do not want to initialize the topology if the cpu model
    ++     * We do not want to initialize the topology if the CPU model
     +     * does not support topology, consequently, we have to wait for
     +     * the first CPU to be realized, which realizes the CPU model
     +     * to initialize the topology structures.
     +     *
    -+     * s390_topology_setup_cpu() is called from the cpu hotplug.
    ++     * s390_topology_setup_cpu() is called from the CPU hotplug.
     +     */
     +    if (!s390_topology.cores_per_socket) {
     +        s390_topology_init(ms);
    @@ hw/s390x/cpu-topology.c (new)
     
      ## hw/s390x/s390-virtio-ccw.c ##
     @@
    - #include "hw/s390x/pv.h"
    + #include "target/s390x/kvm/pv.h"
      #include "migration/blocker.h"
      #include "qapi/visitor.h"
     +#include "hw/s390x/cpu-topology.h"
    @@ hw/s390x/s390-virtio-ccw.c: static const CPUArchIdList *s390_possible_cpu_arch_i
     
      ## hw/s390x/meson.build ##
     @@ hw/s390x/meson.build: s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
    +   's390-skeys-kvm.c',
        's390-stattrib-kvm.c',
    -   'pv.c',
        's390-pci-kvm.c',
     +  'cpu-topology.c',
      ))
 3:  1952150e75 !  3:  ab54bb7881 target/s390x/cpu topology: handle STSI(15) and build the SYSIB
    @@ Commit message
         (SYSIB) is built from the list of pre-ordered topology entries.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
    -@@ MAINTAINERS: M: Pierre Morel <pmorel@linux.ibm.com>
    +@@ MAINTAINERS: M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
      S: Supported
      F: include/hw/s390x/cpu-topology.h
      F: hw/s390x/cpu-topology.c
    @@ MAINTAINERS: M: Pierre Morel <pmorel@linux.ibm.com>
      X86 Machines
      ------------
     
    + ## qapi/machine-target.json ##
    +@@
    +                    'TARGET_MIPS',
    +                    'TARGET_LOONGARCH64',
    +                    'TARGET_RISCV' ] } }
    ++
    ++##
    ++# @CpuS390Polarization:
    ++#
    ++# An enumeration of cpu polarization that can be assumed by a virtual
    ++# S390 CPU
    ++#
    ++# Since: 8.2
    ++##
    ++{ 'enum': 'CpuS390Polarization',
    ++  'prefix': 'S390_CPU_POLARIZATION',
    ++  'data': [ 'horizontal', 'vertical' ],
    ++    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
    ++}
    +
      ## include/hw/s390x/cpu-topology.h ##
     @@
      #include "hw/boards.h"
    @@ include/hw/s390x/cpu-topology.h
     +typedef union s390_topology_id {
     +    uint64_t id;
     +    struct {
    -+        uint8_t sentinel;
    ++        uint8_t _reserved0;
     +        uint8_t drawer;
     +        uint8_t book;
     +        uint8_t socket;
    -+        uint8_t dedicated;
    -+        uint8_t entitlement;
     +        uint8_t type;
    ++        uint8_t inv_polarization;
    ++        uint8_t not_dedicated;
     +        uint8_t origin;
     +    };
     +} s390_topology_id;
    @@ include/hw/s390x/cpu-topology.h
     +
      typedef struct S390Topology {
          uint8_t *cores_per_socket;
    -+    bool vertical_polarization;
    ++    CpuS390Polarization polarization;
      } S390Topology;
      
     +typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
    @@ target/s390x/cpu.h: typedef union SysIB {
     + *
     + */
     +/* Container type Topology List Entry */
    -+typedef struct SysIBTl_container {
    ++typedef struct SYSIBContainerListEntry {
     +        uint8_t nl;
     +        uint8_t reserved[6];
     +        uint8_t id;
    -+} SysIBTl_container;
    -+QEMU_BUILD_BUG_ON(sizeof(SysIBTl_container) != 8);
    ++} SYSIBContainerListEntry;
    ++QEMU_BUILD_BUG_ON(sizeof(SYSIBContainerListEntry) != 8);
     +
     +/* CPU type Topology List Entry */
    -+typedef struct SysIBTl_cpu {
    ++typedef struct SysIBCPUListEntry {
     +        uint8_t nl;
     +        uint8_t reserved0[3];
     +#define SYSIB_TLE_POLARITY_MASK 0x03
    @@ target/s390x/cpu.h: typedef union SysIB {
     +        uint8_t type;
     +        uint16_t origin;
     +        uint64_t mask;
    -+} SysIBTl_cpu;
    -+QEMU_BUILD_BUG_ON(sizeof(SysIBTl_cpu) != 16);
    ++} SysIBCPUListEntry;
    ++QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
     +
    -+void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar);
    ++void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
     +
      /* MMU defines */
      #define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
    @@ target/s390x/cpu.h: typedef union SysIB {
     
      ## hw/s390x/cpu-topology.c ##
     @@
    +  * s390_topology is used to keep the topology information.
       * .cores_per_socket: tracks information on the count of cores
       *                    per socket.
    -  * .smp: keeps track of the machine topology.
    -- *
    -+ * .list: queue the topology entries inside which
    -+ *        we keep the information on the CPU topology.
    ++ * .polarization: tracks machine polarization.
       */
      S390Topology s390_topology = {
    -     /* will be initialized after the cpu model is realized */
    +     /* will be initialized after the CPU model is realized */
          .cores_per_socket = NULL,
    -+    .vertical_polarization = false,
    ++    .polarization = S390_CPU_POLARIZATION_HORIZONTAL,
      };
      
      /**
    @@ target/s390x/kvm/kvm.c: static int handle_stsi(S390CPU *cpu)
              return 0;
     +    case 15:
     +        insert_stsi_15_1_x(cpu, run->s390_stsi.sel2, run->s390_stsi.addr,
    -+                           run->s390_stsi.ar);
    ++                           run->s390_stsi.ar, RA_IGNORED);
     +        return 0;
          default:
              return 0;
    @@ target/s390x/kvm/stsi-topology.c (new)
     +/*
     + * QEMU S390x CPU Topology
     + *
    -+ * Copyright IBM Corp. 2022,2023
    ++ * Copyright IBM Corp. 2022, 2023
     + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
     + *
     + */
     +#include "qemu/osdep.h"
     +#include "cpu.h"
    -+#include "hw/s390x/pv.h"
    -+#include "hw/sysbus.h"
     +#include "hw/s390x/sclp.h"
     +#include "hw/s390x/cpu-topology.h"
     +
    ++QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_LOW != 1);
    ++QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_MEDIUM != 2);
    ++QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_HIGH != 3);
    ++
     +/**
     + * fill_container:
     + * @p: The address of the container TLE to fill
    @@ target/s390x/kvm/stsi-topology.c (new)
     + */
     +static char *fill_container(char *p, int level, int id)
     +{
    -+    SysIBTl_container *tle = (SysIBTl_container *)p;
    ++    SYSIBContainerListEntry *tle = (SYSIBContainerListEntry *)p;
     +
     +    tle->nl = level;
     +    tle->id = id;
    @@ target/s390x/kvm/stsi-topology.c (new)
     + */
     +static char *fill_tle_cpu(char *p, S390TopologyEntry *entry)
     +{
    -+    SysIBTl_cpu *tle = (SysIBTl_cpu *)p;
    ++    SysIBCPUListEntry *tle = (SysIBCPUListEntry *)p;
     +    s390_topology_id topology_id = entry->id;
     +
     +    tle->nl = 0;
    -+    if (topology_id.dedicated) {
    -+        tle->flags = SYSIB_TLE_DEDICATED;
    ++    tle->flags = 3 - topology_id.inv_polarization;
    ++    if (!topology_id.not_dedicated) {
    ++        tle->flags |= SYSIB_TLE_DEDICATED;
     +    }
    -+    tle->flags |= topology_id.entitlement;
     +    tle->type = topology_id.type;
     +    tle->origin = cpu_to_be16(topology_id.origin * 64);
     +    tle->mask = cpu_to_be64(entry->mask);
    @@ target/s390x/kvm/stsi-topology.c (new)
     + */
     +#define SYSIB_GUARD(data, x) do {       \
     +        data += x;                      \
    -+        if (data > sizeof(SysIB)) {    \
    ++        if (data > sizeof(SysIB)) {     \
     +            return 0;                   \
     +        }                               \
     +    } while (0)
    @@ target/s390x/kvm/stsi-topology.c (new)
     +        bool book_change = drawer_change || last_book != entry->id.book;
     +        bool socket_change = book_change || last_socket != entry->id.socket;
     +
    -+        /* If we reach the sentinel get out */
    -+        if (entry->id.sentinel) {
    -+            break;
    -+        }
    -+
     +        if (level > 3 && drawer_change) {
    -+            SYSIB_GUARD(n, sizeof(SysIBTl_container));
    ++            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
     +            p = fill_container(p, 3, drawer_id++);
     +            book_id = 0;
     +        }
     +        if (level > 2 && book_change) {
    -+            SYSIB_GUARD(n, sizeof(SysIBTl_container));
    ++            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
     +            p = fill_container(p, 2, book_id++);
     +            socket_id = 0;
     +        }
     +        if (socket_change) {
    -+            SYSIB_GUARD(n, sizeof(SysIBTl_container));
    ++            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
     +            p = fill_container(p, 1, socket_id++);
     +        }
     +
    -+        SYSIB_GUARD(n, sizeof(SysIBTl_cpu));
    ++        SYSIB_GUARD(n, sizeof(SysIBCPUListEntry));
     +        p = fill_tle_cpu(p, entry);
     +        last_drawer = entry->id.drawer;
     +        last_book = entry->id.book;
    @@ target/s390x/kvm/stsi-topology.c (new)
     + * @entry: Topology entry to setup
     + * @cpu: the S390CPU to add
     + *
    -+ * Set the core bit inside the topology mask and
    -+ * increments the number of cores for the socket.
    ++ * Set the core bit inside the topology mask.
     + */
     +static void s390_topology_add_cpu_to_entry(S390TopologyEntry *entry,
     +                                           S390CPU *cpu)
    @@ target/s390x/kvm/stsi-topology.c (new)
     +
     +/**
     + * s390_topology_from_cpu:
    -+ * @cpu: The S390CPU
    ++ * @cpu: S390CPU to calculate the topology id
     + *
     + * Initialize the topology id from the CPU environment.
     + */
    @@ target/s390x/kvm/stsi-topology.c (new)
     +    topology_id.drawer = cpu->env.drawer_id;
     +    topology_id.book = cpu->env.book_id;
     +    topology_id.socket = cpu->env.socket_id;
    -+    topology_id.origin = cpu->env.core_id / 64;
     +    topology_id.type = S390_TOPOLOGY_CPU_IFL;
    -+    topology_id.dedicated = cpu->env.dedicated;
    ++    topology_id.not_dedicated = !cpu->env.dedicated;
     +
    -+    if (s390_topology.vertical_polarization) {
    -+        topology_id.entitlement = cpu->env.entitlement;
    ++    topology_id.inv_polarization = 3;
    ++    if (s390_topology.polarization == S390_CPU_POLARIZATION_VERTICAL) {
    ++        topology_id.inv_polarization -= cpu->env.entitlement;
     +    }
     +
    -+    return topology_id;
    -+}
    -+
    -+/**
    -+ * s390_topology_insert:
    -+ * @cpu: s390CPU insert.
    -+ *
    -+ * Parse the topology list to find if the entry already
    -+ * exist and add the core in it.
    -+ * If it does not exist, allocate a new entry and insert
    -+ * it in the queue from lower id to greater id.
    -+ */
    -+static void s390_topology_insert(S390TopologyList *topology_list, S390CPU *cpu)
    -+{
    -+    s390_topology_id id = s390_topology_from_cpu(cpu);
    -+    S390TopologyEntry *entry = NULL;
    -+    S390TopologyEntry *tmp = NULL;
    ++    topology_id.origin = cpu->env.core_id / 64;
     +
    -+    QTAILQ_FOREACH(tmp, topology_list, next) {
    -+        if (id.id == tmp->id.id) {
    -+            s390_topology_add_cpu_to_entry(tmp, cpu);
    -+            return;
    -+        } else if (id.id < tmp->id.id) {
    -+            entry = g_malloc0(sizeof(S390TopologyEntry));
    -+            entry->id.id = id.id;
    -+            s390_topology_add_cpu_to_entry(entry, cpu);
    -+            QTAILQ_INSERT_BEFORE(tmp, entry, next);
    -+            return;
    -+        }
    -+    }
    ++    return topology_id;
     +}
     +
     +/**
    @@ target/s390x/kvm/stsi-topology.c (new)
     +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
     +{
     +    CPUState *cs;
    ++    S390TopologyEntry sentinel;
    ++
    ++    QTAILQ_INIT(topology_list);
    ++
    ++    sentinel.id.id = cpu_to_be64(UINT64_MAX);
    ++    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
     +
     +    CPU_FOREACH(cs) {
    -+        s390_topology_insert(topology_list, S390_CPU(cs));
    ++        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
    ++        S390TopologyEntry *entry, *tmp;
    ++
    ++        QTAILQ_FOREACH(tmp, topology_list, next) {
    ++            if (id.id == tmp->id.id) {
    ++                entry = tmp;
    ++                break;
    ++            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id)) {
    ++                entry = g_malloc0(sizeof(*entry));
    ++                entry->id.id = id.id;
    ++                QTAILQ_INSERT_BEFORE(tmp, entry, next);
    ++                break;
    ++            }
    ++        }
    ++        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
     +    }
    ++
    ++    QTAILQ_REMOVE(topology_list, &sentinel, next);
     +}
     +
     +/**
     + * s390_topology_empty_list:
     + *
    -+ * Clear all entries in the S390Topology list except the sentinel.
    ++ * Clear all entries in the S390Topology list.
     + */
     +static void s390_topology_empty_list(S390TopologyList *topology_list)
     +{
    @@ target/s390x/kvm/stsi-topology.c (new)
     + * addr: Guest logical address of the guest SysIB
     + * ar: the access register number
     + *
    -+ * Create a list head for the Topology entries and initialize it.
    -+ * Insert the first entry as a sentinelle.
    -+ *
     + * Emulate STSI 15.1.x, that is, perform all necessary checks and
     + * fill the SYSIB.
     + * In case the topology description is too long to fit into the SYSIB,
     + * set CC=3 and abort without writing the SYSIB.
     + */
    -+void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar)
    ++void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra)
     +{
     +    S390TopologyList topology_list;
    -+    S390TopologyEntry *entry;
     +    SysIB sysib = {0};
     +    int length;
     +
    @@ target/s390x/kvm/stsi-topology.c (new)
     +        return;
     +    }
     +
    -+    QTAILQ_INIT(&topology_list);
    -+    entry = g_malloc0(sizeof(S390TopologyEntry));
    -+    entry->id.sentinel = 0xff;
    -+    QTAILQ_INSERT_HEAD(&topology_list, entry, next);
    -+
     +    s390_topology_fill_list_sorted(&topology_list);
     +
     +    length = setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
     +
     +    if (!length) {
    ++        s390_topology_empty_list(&topology_list);
     +        setcc(cpu, 3);
     +        return;
     +    }
     +
     +    sysib.sysib_151x.length = cpu_to_be16(length);
    -+    s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length);
    -+    setcc(cpu, 0);
    ++    if (!s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length)) {
    ++        setcc(cpu, 0);
    ++    } else {
    ++        s390_cpu_virt_mem_handle_exc(cpu, ra);
    ++    }
     +
     +    s390_topology_empty_list(&topology_list);
     +}
    @@ target/s390x/kvm/meson.build
     @@
      
      s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
    +   'pv.c',
     -  'kvm.c'
     +  'kvm.c',
     +  'stsi-topology.c'
 4:  8864107e23 =  4:  67278aa3a0 s390x/sclp: reporting the maximum nested topology entries
 5:  35aac0c335 !  5:  ce87494fd1 s390x/cpu topology: resetting the Topology-Change-Report
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## include/hw/s390x/cpu-topology.h ##
     @@ include/hw/s390x/cpu-topology.h: static inline void s390_topology_setup_cpu(MachineState *ms,
    @@ include/hw/s390x/cpu-topology.h: static inline void s390_topology_setup_cpu(Mach
      {
     
      ## target/s390x/cpu.h ##
    -@@ target/s390x/cpu.h: typedef struct SysIBTl_cpu {
    - QEMU_BUILD_BUG_ON(sizeof(SysIBTl_cpu) != 16);
    +@@ target/s390x/cpu.h: typedef struct SysIBCPUListEntry {
    + QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
      
    - void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar);
    + void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
     +void s390_cpu_topology_set_changed(bool changed);
      
      /* MMU defines */
 6:  b64ec041ba !  6:  c56178005a s390x/cpu topology: interception of PTF instruction
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    -
    - ## qapi/machine-target.json ##
    -@@
    -                    'TARGET_S390X',
    -                    'TARGET_MIPS',
    -                    'TARGET_LOONGARCH64' ] } }
    -+
    -+##
    -+# @CpuS390Polarization:
    -+#
    -+# An enumeration of cpu polarization that can be assumed by a virtual
    -+# S390 CPU
    -+#
    -+# Since: 8.1
    -+##
    -+{ 'enum': 'CpuS390Polarization',
    -+  'prefix': 'S390_CPU_POLARIZATION',
    -+  'data': [ 'horizontal', 'vertical' ],
    -+    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
    -+}
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## include/hw/s390x/s390-virtio-ccw.h ##
     @@ include/hw/s390x/s390-virtio-ccw.h: struct S390CcwMachineState {
    @@ hw/s390x/cpu-topology.c: static void s390_topology_init(MachineState *ms)
     + */
     +void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
     +{
    -+    CpuS390Polarization polarization = S390_CPU_POLARIZATION_HORIZONTAL;
    ++    CpuS390Polarization polarization;
     +    CPUS390XState *env = &cpu->env;
     +    uint64_t reg = env->regs[r1];
     +    int fc = reg & S390_TOPO_FC_MASK;
    @@ hw/s390x/cpu-topology.c: static void s390_topology_init(MachineState *ms)
     +        return;
     +    }
     +
    ++    polarization = S390_CPU_POLARIZATION_VERTICAL;
     +    switch (fc) {
    -+    case S390_CPU_POLARIZATION_VERTICAL:
    -+        polarization = S390_CPU_POLARIZATION_VERTICAL;
    ++    case 0:
    ++        polarization = S390_CPU_POLARIZATION_HORIZONTAL;
     +        /* fallthrough */
    -+    case S390_CPU_POLARIZATION_HORIZONTAL:
    -+        if (s390_topology.vertical_polarization == polarization) {
    ++    case 1:
    ++        if (s390_topology.polarization == polarization) {
     +            env->regs[r1] |= S390_PTF_REASON_DONE;
     +            setcc(cpu, 2);
     +        } else {
    -+            s390_topology.vertical_polarization = polarization;
    ++            s390_topology.polarization = polarization;
     +            s390_cpu_topology_set_changed(true);
     +            setcc(cpu, 0);
     +        }
    @@ hw/s390x/cpu-topology.c: static void s390_topology_init(MachineState *ms)
      void s390_topology_reset(void)
      {
          s390_cpu_topology_set_changed(false);
    -+    s390_topology.vertical_polarization = false;
    ++    s390_topology.polarization = S390_CPU_POLARIZATION_HORIZONTAL;
      }
      
      /**
 7:  bf42e59614 =  7:  e56149e34f target/s390x/cpu topology: activate CPU topology
 8:  f584523eff !  8:  c94943deef qapi/s390x/cpu topology: set-cpu-topology qmp command
    @@ Commit message
         The command has a feature unstable for the moment.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
     @@
    @@ qapi/machine-target.json
     +#
     +# Returns: Nothing on success, the reason on failure.
     +#
    -+# Since: 8.1
    ++# Since: 8.2
     +##
     +{ 'command': 'set-cpu-topology',
     +  'data': {
    @@ hw/s390x/cpu-topology.c: void s390_topology_setup_cpu(MachineState *ms, S390CPU
     +    }
     +
     +    if (!s390_topology_check(socket_id, book_id, drawer_id,
    -+                             entitlement, dedicated, errp))
    ++                             entitlement, dedicated, errp)) {
     +        return;
    ++    }
     +
     +    /* Check for space on new socket */
     +    old_socket_entry = s390_socket_nb(cpu);
    -+    new_socket_entry = __s390_socket_nb(drawer_id, book_id, socket_id);
    ++    new_socket_entry = s390_socket_nb_from_ids(drawer_id, book_id, socket_id);
     +
     +    if (new_socket_entry != old_socket_entry) {
     +        if (s390_topology.cores_per_socket[new_socket_entry] >=
 9:  11da1041a7 !  9:  516a727ef5 machine: adding s390 topology to query-cpu-fast
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    -    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine.json ##
     @@
      # Additional information about a virtual S390 CPU
      #
      # @cpu-state: the virtual CPU's state
    -+# @dedicated: the virtual CPU's dedication (since 8.1)
    -+# @entitlement: the virtual CPU's entitlement (since 8.1)
    ++# @dedicated: the virtual CPU's dedication (since 8.2)
    ++# @entitlement: the virtual CPU's entitlement (since 8.2)
      #
      # Since: 2.12
      ##
     -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
     +{ 'struct': 'CpuInfoS390',
     +  'data': { 'cpu-state': 'CpuS390State',
    -+            'dedicated': 'bool',
    -+            'entitlement': 'CpuS390Entitlement'
    ++            '*dedicated': 'bool',
    ++            '*entitlement': 'CpuS390Entitlement'
     +  }
     +}
      
      ##
      # @CpuInfoFast:
     
    - ## hw/core/machine-qmp-cmds.c ##
    -@@ hw/core/machine-qmp-cmds.c: static void cpustate_to_cpuinfo_s390(CpuInfoS390 *info, const CPUState *cpu)
    -     CPUS390XState *env = &s390_cpu->env;
    + ## target/s390x/cpu.c ##
    +@@
    + #ifndef CONFIG_USER_ONLY
    + #include "sysemu/reset.h"
    + #endif
    ++#include "hw/s390x/cpu-topology.h"
    + 
    + #define CR0_RESET       0xE0UL
    + #define CR14_RESET      0xC2000000UL;
    +@@ target/s390x/cpu.c: static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
    +     S390CPU *s390_cpu = S390_CPU(cpu);
      
    -     info->cpu_state = env->cpu_state;
    +     value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
     +#if !defined(CONFIG_USER_ONLY)
    -+    info->dedicated = env->dedicated;
    -+    info->entitlement = env->entitlement;
    -+#endif /* !defined(CONFIG_USER_ONLY) */
    - #else
    -     abort();
    - #endif
    ++    if (s390_has_topology()) {
    ++        value->u.s390x.has_dedicated = true;
    ++        value->u.s390x.dedicated = s390_cpu->env.dedicated;
    ++        value->u.s390x.has_entitlement = true;
    ++        value->u.s390x.entitlement = s390_cpu->env.entitlement;
    ++    }
    ++#endif
    + }
    + 
    + /* S390CPUClass::reset() */
10:  46e2545116 ! 10:  4b8bfddea9 machine: adding s390 topology to info hotpluggable-cpus
    @@ hw/core/machine-hmp-cmds.c: void hmp_hotpluggable_cpus(Monitor *mon, const QDict
     +            monitor_printf(mon, "    drawer-id: \"%" PRIu64 "\"\n", c->drawer_id);
     +        }
     +        if (c->has_book_id) {
    -+            monitor_printf(mon, "      book-id: \"%" PRIu64 "\"\n", c->book_id);
    ++            monitor_printf(mon, "    book-id: \"%" PRIu64 "\"\n", c->book_id);
     +        }
              if (c->has_socket_id) {
                  monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
11:  f893efcf54 ! 11:  6584a655e9 qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
    @@ Commit message
         CPU provisioning.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
     @@
    @@ qapi/machine-target.json
     +# The guest will get information on the details of the provisioning
     +# the next time it uses the STSI(15) instruction.
     +#
    -+# Since: 8.1
    ++# Since: 8.2
     +#
     +# Example:
     +#
     +# <- { "event": "CPU_POLARIZATION_CHANGE",
    -+#      "data": { "polarization": 0 },
    ++#      "data": { "polarization": "horizontal" },
     +#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
     +##
     +{ 'event': 'CPU_POLARIZATION_CHANGE',
    @@ hw/s390x/cpu-topology.c
       * s390_topology is used to keep the topology information.
     @@ hw/s390x/cpu-topology.c: void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
              } else {
    -             s390_topology.vertical_polarization = polarization;
    +             s390_topology.polarization = polarization;
                  s390_cpu_topology_set_changed(true);
    -+            qapi_event_send_cpu_polarization_change(fc);
    ++            qapi_event_send_cpu_polarization_change(polarization);
                  setcc(cpu, 0);
              }
              break;
12:  02b4452443 ! 12:  7e18ccdbcc qapi/s390x/cpu topology: query-cpu-polarization qmp command
    @@ Commit message
         CPU polarization of the machine.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine-target.json ##
     @@
    @@ qapi/machine-target.json
     +#
     +# @polarization: the CPU polarization
     +#
    -+# Since: 2.8
    ++# Since: 8.2
     +##
     +{ 'struct': 'CpuPolarizationInfo',
     +  'data': { 'polarization': 'CpuS390Polarization' },
    @@ qapi/machine-target.json
     +}
     +
     +##
    -+# @query-cpu-polarization:
    ++# @query-s390x-cpu-polarization:
     +#
     +# Features:
     +# @unstable: This command may still be modified.
     +#
     +# Returns: the machine polarization
     +#
    -+# Since: 8.1
    ++# Since: 8.2
     +##
    -+{ 'command': 'query-cpu-polarization', 'returns': 'CpuPolarizationInfo',
    ++{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
     +  'features': [ 'unstable' ],
     +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
     +}
    @@ hw/s390x/cpu-topology.c: void qmp_set_cpu_topology(uint16_t core,
                               has_dedicated, dedicated, errp);
      }
     +
    -+CpuPolarizationInfo *qmp_query_cpu_polarization(Error **errp)
    ++CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp)
     +{
     +    CpuPolarizationInfo *info = g_new0(CpuPolarizationInfo, 1);
     +
    -+    if (s390_topology.vertical_polarization) {
    -+        info->polarization = S390_CPU_POLARIZATION_VERTICAL;
    -+    } else {
    -+        info->polarization = S390_CPU_POLARIZATION_HORIZONTAL;
    -+    }
    -+
    ++    info->polarization = s390_topology.polarization;
     +    return info;
     +}
13:  743fd027f0 ! 13:  810118478c docs/s390x/cpu topology: document s390x cpu topology
    @@ Commit message
         in s390x.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: S: Supported
    @@ docs/devel/s390-cpu-topology.rst (new)
     +QAPI interface for S390 CPU topology
     +====================================
     +
    -+Let's start QEMU with the following command defining 4 CPUs,
    -+CPU[0] defined by the -smp argument will have default values:
    ++The following sections will explain the QAPI interface for S390 CPU topology
    ++with the help of exemplary output.
    ++For this, let's assume that QEMU has been started with the following
    ++command, defining 4 CPUs, where CPU[0] is defined by the -smp argument and will
    ++have default values:
     +
     +.. code-block:: bash
     +
    @@ docs/devel/s390-cpu-topology.rst (new)
     +    -device z14-s390x-cpu,core-id=112,entitlement=high \
     +   ...
     +
    -+and see the result when using the QAPI interface.
    ++Additions to query-cpus-fast
    ++----------------------------
     +
    -+Addons to query-cpus-fast
    -+-------------------------
    -+
    -+The command query-cpus-fast allows to query the topology tree and
    ++The command query-cpus-fast allows querying the topology tree and
     +modifiers for all configured vCPUs.
     +
     +.. code-block:: QMP
    @@ docs/devel/s390-cpu-topology.rst (new)
     +QAPI command: set-cpu-topology
     +------------------------------
     +
    -+The command set-cpu-topology allows to modify the topology tree
    ++The command set-cpu-topology allows modifying the topology tree
     +or the topology modifiers of a vCPU in the configuration.
     +
     +.. code-block:: QMP
    @@ docs/devel/s390-cpu-topology.rst (new)
     +    }
     +    {"return": {}}
     +
    -+The core-id parameter is the only non optional parameter and every
    ++The core-id parameter is the only mandatory parameter and every
     +unspecified parameter keeps its previous value.
     +
     +QAPI event CPU_POLARIZATION_CHANGE
     +----------------------------------
     +
    -+When a guest is requests a modification of the polarization,
    ++When a guest requests a modification of the polarization,
     +QEMU sends a CPU_POLARIZATION_CHANGE event.
     +
     +When requesting the change, the guest only specifies horizontal or
     +vertical polarization.
    -+It is the job of the upper layer to set the dedication and fine grained
    -+vertical entitlement in response to this event.
    ++It is the job of the entity administrating QEMU to set the dedication and fine
    ++grained vertical entitlement in response to this event.
     +
     +Note that a vertical polarized dedicated vCPU can only have a high
    -+entitlement, this gives 6 possibilities for vCPU entitlement:
    ++entitlement, giving 6 possibilities for vCPU polarization:
     +
     +- Horizontal
     +- Horizontal dedicated
    @@ docs/devel/s390-cpu-topology.rst (new)
     +    }
     +  }
     +
    -+QAPI query command: query-cpu-polarization
    -+------------------------------------------
    ++QAPI query command: query-s390x-cpu-polarization
    ++------------------------------------------------
     +
    -+The query command query-cpu-polarization returns the current
    ++The query command query-s390x-cpu-polarization returns the current
     +CPU polarization of the machine.
    -+In the case the guest issued a PTF(1) to request a vertical polarization:
    ++In this case the guest previously issued a PTF(1) to request vertical polarization:
     +
     +.. code-block:: QMP
     +
    -+    { "execute": "query-cpu-polarization" }
    ++    { "execute": "query-s390x-cpu-polarization" }
     +    {
     +        "return": {
     +          "polarization": "vertical"
    @@ docs/system/s390x/cpu-topology.rst (new)
     +CPU topology on s390x
     +=====================
     +
    -+Since QEMU 8.1, CPU topology on s390x provides up to 3 levels of
    -+topology containers: drawers, books, sockets, defining a tree shaped
    -+hierarchy.
    ++Since QEMU 8.2, CPU topology on s390x provides up to 3 levels of
    ++topology containers: drawers, books and sockets. They define a
    ++tree-shaped hierarchy.
     +
    -+The socket container contains one or more CPU entries.
    ++The socket container has one or more CPU entries.
     +Each of these CPU entries consists of a bitmap and three CPU attributes:
     +
     +- CPU type
     +- entitlement
     +- dedication
     +
    -+Each bit set in the bitmap correspond to the core-id of a vCPU with
    -+matching the three attribute.
    ++Each bit set in the bitmap correspond to a core-id of a vCPU with matching
    ++attributes.
     +
    -+This documentation provide general information on S390 CPU topology,
    -+how to enable it and on the new CPU attributes.
    -+For information on how to modify the S390 CPU topology and on how to
    -+monitor the polarization change see ``Developer Information``.
    ++This documentation provides general information on S390 CPU topology,
    ++how to enable it and explains the new CPU attributes.
    ++For information on how to modify the S390 CPU topology and how to
    ++monitor polarization changes, see ``docs/devel/s390-cpu-topology.rst``.
     +
     +Prerequisites
     +-------------
    @@ docs/system/s390x/cpu-topology.rst (new)
     +Currently, CPU topology is only enabled in the host model by default.
     +
     +Enabling CPU topology in a CPU model is done by setting the CPU flag
    -+``ctop`` to ``on`` like in:
    ++``ctop`` to ``on`` as in:
     +
     +.. code-block:: bash
     +
    @@ docs/system/s390x/cpu-topology.rst (new)
     +
     +If none of the containers attributes (drawers, books, sockets) are
     +specified for the ``-smp`` flag, the number of these containers
    -+is ``1`` .
    ++is 1.
    ++
    ++Thus the following two options will result in the same topology:
     +
     +.. code-block:: bash
     +
     +    -smp cpus=5,drawer=1,books=1,sockets=8,cores=4,maxcpus=32
     +
    -+or
    ++and
     +
     +.. code-block:: bash
     +
    @@ docs/system/s390x/cpu-topology.rst (new)
     +When a CPU is defined by the ``-smp`` command argument, its position
     +inside the topology is calculated by adding the CPUs to the topology
     +based on the core-id starting with core-0 at position 0 of socket-0,
    -+book-0, drawer-0 and filling all CPUs of socket-0 before to fill socket-1
    ++book-0, drawer-0 and filling all CPUs of socket-0 before filling socket-1
     +of book-0 and so on up to the last socket of the last book of the last
     +drawer.
     +
     +When a CPU is defined by the ``-device`` command argument, the
    -+tree topology attributes must be all defined or all not defined.
    ++tree topology attributes must all be defined or all not defined.
     +
     +.. code-block:: bash
     +
    @@ docs/system/s390x/cpu-topology.rst (new)
     +    -device gen16b-s390x-cpu,core-id=1,dedicated=true
     +
     +If none of the tree attributes (drawer, book, sockets), are specified
    -+for the ``-device`` argument, as for all CPUs defined with the ``-smp``
    ++for the ``-device`` argument, like for all CPUs defined with the ``-smp``
     +command argument the topology tree attributes will be set by simply
    -+adding the CPUs to the topology based on the core-id starting with
    -+core-0 at position 0 of socket-0, book-0, drawer-0.
    ++adding the CPUs to the topology based on the core-id.
     +
    -+QEMU will not try to solve collisions and will report an error if the
    -+CPU topology, explicitly or implicitly defined on a ``-device``
    -+argument collides with the definition of a CPU implicitely defined
    ++QEMU will not try to resolve collisions and will report an error if the
    ++CPU topology defined explicitly or implicitly on a ``-device``
    ++argument collides with the definition of a CPU implicitly defined
     +on the ``-smp`` argument.
     +
     +When the topology modifier attributes are not defined for the
    @@ docs/system/s390x/cpu-topology.rst (new)
     +
     +  (qemu) device_add gen16b-s390x-cpu,core-id=9
     +
    -+The same placement of the CPU is derived from the core-id as described above.
    ++The placement of the CPU is derived from the core-id as described above.
     +
    -+The topology can of course be fully defined:
    ++The topology can of course also be fully defined:
     +
     +.. code-block:: bash
     +
    @@ docs/system/s390x/cpu-topology.rst (new)
     +Polarization
     +++++++++++++
     +
    -+The polarization is an indication given by the ``guest`` to the host
    -+that it is able to make use of CPU provisioning information.
    -+The guest indicates the polarization by using the PTF instruction.
    ++The polarization affects how the CPUs of a shared host are utilized/distributed
    ++among guests.
    ++The guest determines the polarization by using the PTF instruction.
     +
    -+Polarization is define two models of CPU provisioning: horizontal
    ++Polarization defines two models of CPU provisioning: horizontal
     +and vertical.
     +
     +The horizontal polarization is the default model on boot and after
    -+subsystem reset in which the guest considers all vCPUs being having
    -+an equal provisioning of CPUs by the host.
    ++subsystem reset. When horizontal polarization is in effect all vCPUs should
    ++have about equal resource provisioning.
     +
    -+In the vertical polarization model the guest can make use of the
    -+vCPU entitlement information provided by the host to optimize
    -+kernel thread scheduling.
    ++In the vertical polarization model vCPUs are unequal, but overall more resources
    ++might be available.
    ++The guest can make use of the vCPU entitlement information provided by the host
    ++to optimize kernel thread scheduling.
     +
     +A subsystem reset puts all vCPU of the configuration into the
     +horizontal polarization.
    @@ docs/system/s390x/cpu-topology.rst (new)
     ++++++++++++
     +
     +The vertical polarization specifies that the guest's vCPU can get
    -+different real CPU provisions:
    ++different real CPU provisioning:
     +
     +- a vCPU with vertical high entitlement specifies that this
     +  vCPU gets 100% of the real CPU provisioning.
    @@ docs/system/s390x/cpu-topology.rst (new)
     +the real CPU, the unused "slack" can be dispatched to other vCPU
     +with medium or low entitlement.
     +
    -+The upper level specifies a vCPU as ``dedicated`` when the vCPU is
    -+fully dedicated to a single real CPU.
    ++A vCPU can be "dedicated" in which case the vCPU is fully dedicated to a single
    ++real CPU.
     +
     +The dedicated bit is an indication of affinity of a vCPU for a real CPU
     +while the entitlement indicates the sharing or exclusivity of use.
     +
    -+Defining the topology on command line
    -+-------------------------------------
    ++Defining the topology on the command line
    ++-----------------------------------------
     +
     +The topology can entirely be defined using -device cpu statements,
     +with the exception of CPU 0 which must be defined with the -smp
    @@ docs/system/s390x/cpu-topology.rst (new)
     +For example, here we set the position of the cores 1,2,3 to
     +drawer 1, book 1, socket 2 and cores 0,9 and 14 to drawer 0,
     +book 0, socket 0 without defining entitlement or dedication.
    -+The core 4, will be set on its default position on socket 1
    ++Core 4 will be set on its default position on socket 1
     +(since we have 4 core per socket) and we define it as dedicated and
     +with vertical high entitlement.
     +
    @@ docs/system/s390x/cpu-topology.rst (new)
     +    \
     +    -device gen16b-s390x-cpu,core-id=4,dedicated=on,entitlement=high
     +
    -+The entitlement defined for the CPU 4, will only be used after the guest
    ++The entitlement defined for the CPU 4 will only be used after the guest
     +successfully enables vertical polarization by using the PTF instruction.
     
      ## docs/system/target-s390x.rst ##
14:  d24ddf00ce ! 14:  717f901bb0 tests/avocado: s390x cpu topology core
    @@ Commit message
         Introduction of the s390x cpu topology core functions and
         basic tests.
     
    -    We test the corelation between the command line and
    +    We test the correlation between the command line and
         the QMP results in query-cpus-fast for various CPU topology.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    @@ tests/avocado/s390_topology.py (new)
     +
     +class S390CPUTopology(QemuSystemTest):
     +    """
    -+    S390x CPU topology consist of 4 topology layers, from bottom to top,
    ++    S390x CPU topology consists of 4 topology layers, from bottom to top,
     +    the cores, sockets, books and drawers and 2 modifiers attributes,
     +    the entitlement and the dedication.
     +    See: docs/system/s390x/cpu-topology.rst.
     +
     +    S390x CPU topology is setup in different ways:
    -+    - implicitely from the '-smp' argument by completing each topology
    -+      level one after the other begining with drawer 0, book 0 and socket 0.
    -+    - explicitely from the '-device' argument on the QEMU command line
    -+    - explicitely by hotplug of a new CPU using QMP or HMP
    ++    - implicitly from the '-smp' argument by completing each topology
    ++      level one after the other beginning with drawer 0, book 0 and
    ++      socket 0.
    ++    - explicitly from the '-device' argument on the QEMU command line
    ++    - explicitly by hotplug of a new CPU using QMP or HMP
     +    - it is modified by using QMP 'set-cpu-topology'
     +
     +    The S390x modifier attribute entitlement depends on the machine
    @@ tests/avocado/s390_topology.py (new)
     +            socket = cpu['props']['socket-id']
     +            book = cpu['props']['book-id']
     +            drawer = cpu['props']['drawer-id']
    -+            entitlement = cpu['entitlement']
    -+            dedicated = cpu['dedicated']
    ++            entitlement = cpu.get('entitlement')
    ++            dedicated = cpu.get('dedicated')
     +            if core == c:
     +                self.assertEqual(drawer, d)
     +                self.assertEqual(book, b)
    @@ tests/avocado/s390_topology.py (new)
     +
     +    def kernel_init(self):
     +        """
    ++        We need a VM that supports CPU topology,
    ++        currently this only the case when using KVM, not TCG.
     +        We need a kernel supporting the CPU topology.
     +        We need a minimal root filesystem with a shell.
     +        """
    ++        self.require_accelerator("kvm")
     +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
     +                      '/fedora-secondary/releases/35/Server/s390x/os'
     +                      '/images/kernel.img')
15:  4bee9fa1af ! 15:  7c5793cf9b tests/avocado: s390x cpu topology polarisation
    @@ Metadata
     Author: Pierre Morel <pmorel@linux.ibm.com>
     
      ## Commit message ##
    -    tests/avocado: s390x cpu topology polarisation
    +    tests/avocado: s390x cpu topology polarization
     
         Polarization is changed on a request from the guest.
         Let's verify the polarization is accordingly set by QEMU.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
     @@ tests/avocado/s390_topology.py: class S390CPUTopology(QemuSystemTest):
          The polarization is changed on a request from the guest.
          """
          timeout = 90
    -+    event_timeout = 1
    ++    event_timeout = 10
      
          KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
                                        'root=/dev/ram '
    @@ tests/avocado/s390_topology.py: def kernel_init(self):
      
     +    def system_init(self):
     +        self.log.info("System init")
    -+        exec_command(self, 'mount proc -t proc /proc')
    -+        time.sleep(0.2)
    -+        exec_command(self, 'mount sys -t sysfs /sys')
    -+        time.sleep(0.2)
     +        exec_command_and_wait_for_pattern(self,
    -+                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
    ++                """ mount proc -t proc /proc;
    ++                    mount sys -t sysfs /sys;
    ++                    /bin/cat /sys/devices/system/cpu/dispatching """,
    ++                    '0')
     +
          def test_single(self):
              """
    @@ tests/avocado/s390_topology.py: def test_hotplug_full(self):
     +                '/bin/cat /sys/devices/system/cpu/dispatching', dispatching)
     +
     +
    -+    def test_polarisation(self):
    ++    def test_polarization(self):
     +        """
     +        This test verifies that QEMU modifies the entitlement change after
     +        several guest polarization change requests.
    @@ tests/avocado/s390_topology.py: def test_hotplug_full(self):
     +        self.wait_until_booted()
     +
     +        self.system_init()
    -+        res = self.vm.qmp('query-cpu-polarization')
    ++        res = self.vm.qmp('query-s390x-cpu-polarization')
     +        self.assertEqual(res['return']['polarization'], 'horizontal')
     +        self.check_topology(0, 0, 0, 0, 'medium', False)
     +
     +        self.guest_set_dispatching('1');
    -+        res = self.vm.qmp('query-cpu-polarization')
    ++        res = self.vm.qmp('query-s390x-cpu-polarization')
     +        self.assertEqual(res['return']['polarization'], 'vertical')
     +        self.check_topology(0, 0, 0, 0, 'medium', False)
     +
     +        self.guest_set_dispatching('0');
    -+        res = self.vm.qmp('query-cpu-polarization')
    ++        res = self.vm.qmp('query-s390x-cpu-polarization')
     +        self.assertEqual(res['return']['polarization'], 'horizontal')
     +        self.check_topology(0, 0, 0, 0, 'medium', False)
16:  dfadecd4eb ! 16:  f1aa5e3d91 tests/avocado: s390x cpu topology entitlement tests
    @@ Metadata
      ## Commit message ##
         tests/avocado: s390x cpu topology entitlement tests
     
    -    This test takes care to check the changes on different entitlements
    -    when the guest requests a polarization change.
    +    Test changes in the entitlement from both a guest and a host point of
    +    view, depending on the polarization.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
    -@@ tests/avocado/s390_topology.py: def test_polarisation(self):
    -         res = self.vm.qmp('query-cpu-polarization')
    +@@ tests/avocado/s390_topology.py: def test_polarization(self):
    +         res = self.vm.qmp('query-s390x-cpu-polarization')
              self.assertEqual(res['return']['polarization'], 'horizontal')
              self.check_topology(0, 0, 0, 0, 'medium', False)
     +
    ++
    ++    def check_polarization(self, polarization):
    ++        """
    ++        We need the polarization change to get stabilized in kernel
    ++        before we check it through the sysfs.
    ++        """
    ++        exec_command_and_wait_for_pattern(self,
    ++                """ sleep 1 ;
    ++                    /bin/cat /sys/devices/system/cpu/cpu0/polarization """,
    ++                polarization)
    ++
    ++
     +    def test_entitlement(self):
     +        """
    -+        This test verifies that QEMU modifies the polarization
    -+        after a guest request.
    ++        This test verifies that QEMU modifies the entitlement
    ++        after a guest request and that the guest sees the change.
     +
     +        :avocado: tags=arch:s390x
     +        :avocado: tags=machine:s390-ccw-virtio
     +        """
     +        self.kernel_init()
    -+        self.vm.add_args('-smp',
    -+                         '4,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
     +        self.vm.launch()
     +        self.wait_until_booted()
     +
     +        self.system_init()
     +
    ++        self.check_polarization('horizontal')
    ++        self.check_topology(0, 0, 0, 0, 'medium', False)
    ++
    ++        self.guest_set_dispatching('1')
    ++        self.check_polarization('vertical:medium')
    ++        self.check_topology(0, 0, 0, 0, 'medium', False)
    ++
     +        res = self.vm.qmp('set-cpu-topology',
     +                          {'core-id': 0, 'entitlement': 'low'})
     +        self.assertEqual(res['return'], {})
    ++        self.check_polarization('vertical:low')
    ++        self.check_topology(0, 0, 0, 0, 'low', False)
    ++
     +        res = self.vm.qmp('set-cpu-topology',
    -+                          {'core-id': 1, 'entitlement': 'medium'})
    -+        self.assertEqual(res['return'], {})
    -+        res = self.vm.qmp('set-cpu-topology',
    -+                          {'core-id': 2, 'entitlement': 'high'})
    ++                          {'core-id': 0, 'entitlement': 'medium'})
     +        self.assertEqual(res['return'], {})
    ++        self.check_polarization('vertical:medium')
    ++        self.check_topology(0, 0, 0, 0, 'medium', False)
    ++
     +        res = self.vm.qmp('set-cpu-topology',
    -+                          {'core-id': 3, 'entitlement': 'high'})
    ++                          {'core-id': 0, 'entitlement': 'high'})
     +        self.assertEqual(res['return'], {})
    -+        self.check_topology(0, 0, 0, 0, 'low', False)
    -+        self.check_topology(1, 0, 0, 0, 'medium', False)
    -+        self.check_topology(2, 1, 0, 0, 'high', False)
    -+        self.check_topology(3, 1, 0, 0, 'high', False)
    -+
    -+        self.guest_set_dispatching('1');
    -+
    -+        self.check_topology(0, 0, 0, 0, 'low', False)
    -+        self.check_topology(1, 0, 0, 0, 'medium', False)
    -+        self.check_topology(2, 1, 0, 0, 'high', False)
    -+        self.check_topology(3, 1, 0, 0, 'high', False)
    ++        self.check_polarization('vertical:high')
    ++        self.check_topology(0, 0, 0, 0, 'high', False)
     +
     +        self.guest_set_dispatching('0');
    -+
    -+        self.check_topology(0, 0, 0, 0, 'low', False)
    -+        self.check_topology(1, 0, 0, 0, 'medium', False)
    -+        self.check_topology(2, 1, 0, 0, 'high', False)
    -+        self.check_topology(3, 1, 0, 0, 'high', False)
    ++        self.check_polarization("horizontal")
    ++        self.check_topology(0, 0, 0, 0, 'high', False)
17:  59457e4e40 ! 17:  820481f18c tests/avocado: s390x cpu topology test dedicated CPU
    @@ Commit message
     
         A dedicated CPU in vertical polarization can only have
         a high entitlement.
    -    Let's check this.
    +    Let's check this from both host and guest point of view.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
     @@ tests/avocado/s390_topology.py: def test_entitlement(self):
    -         self.check_topology(1, 0, 0, 0, 'medium', False)
    -         self.check_topology(2, 1, 0, 0, 'high', False)
    -         self.check_topology(3, 1, 0, 0, 'high', False)
    +         self.guest_set_dispatching('0');
    +         self.check_polarization("horizontal")
    +         self.check_topology(0, 0, 0, 0, 'high', False)
    ++
     +
     +    def test_dedicated(self):
     +        """
    -+        This test verifies that QEMU modifies the entitlement change correctly
    -+        for a dedicated CPU after several guest polarization change requests.
    ++        This test verifies that QEMU adjusts the entitlement correctly when a
    ++        CPU is made dedicated.
    ++        QEMU retains the entitlement value when horizontal polarization is in effect.
    ++        For the guest, the field shows the effective value of the entitlement.
     +
     +        :avocado: tags=arch:s390x
     +        :avocado: tags=machine:s390-ccw-virtio
    @@ tests/avocado/s390_topology.py: def test_entitlement(self):
     +
     +        self.system_init()
     +
    ++        self.check_polarization("horizontal")
    ++
     +        res = self.vm.qmp('set-cpu-topology',
     +                          {'core-id': 0, 'dedicated': True})
     +        self.assertEqual(res['return'], {})
    -+
     +        self.check_topology(0, 0, 0, 0, 'high', True)
    ++        self.check_polarization("horizontal")
     +
     +        self.guest_set_dispatching('1');
    -+
     +        self.check_topology(0, 0, 0, 0, 'high', True)
    ++        self.check_polarization("vertical:high")
     +
     +        self.guest_set_dispatching('0');
    -+
     +        self.check_topology(0, 0, 0, 0, 'high', True)
    ++        self.check_polarization("horizontal")
18:  a2ebb1be4c ! 18:  d1efe180f3 tests/avocado: s390x cpu topology test socket full
    @@ Commit message
         to overload a socket.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tests/avocado/s390_topology.py ##
     @@ tests/avocado/s390_topology.py: def test_dedicated(self):
              self.guest_set_dispatching('0');
    - 
              self.check_topology(0, 0, 0, 0, 'high', True)
    +         self.check_polarization("horizontal")
    ++
     +
     +    def test_socket_full(self):
     +        """
19:  aa692304a4 ! 19:  568de9fef9 tests/avocado: s390x cpu topology dedicated errors
    @@ Commit message
         low or medium entitlement.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tests/avocado/s390_topology.py ##
     @@ tests/avocado/s390_topology.py: def test_socket_full(self):
20:  59580e0a42 ! 20:  9f9672adc2 tests/avocado: s390x cpu topology bad move
    @@ Commit message
         tests/avocado: s390x cpu topology bad move
     
         This test verifies that QEMU refuses to move a CPU to an
    -    unexistant location.
    +    nonexistent location.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## tests/avocado/s390_topology.py ##
     @@ tests/avocado/s390_topology.py: def test_dedicated_error(self):
    @@ tests/avocado/s390_topology.py: def test_dedicated_error(self):
     +    def test_move_error(self):
     +        """
     +        This test verifies that QEMU refuses to move a CPU to an
    -+        unexistant location
    ++        nonexistent location
     +
     +        :avocado: tags=arch:s390x
     +        :avocado: tags=machine:s390-ccw-virtio

base-commit: 17780edd81d27fcfdb7a802efc870a99788bd2fc
-- 
2.39.2


