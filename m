Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4C7BA404
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQpF-0005Y7-OO; Thu, 05 Oct 2023 12:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoQp1-0005Ow-BZ; Thu, 05 Oct 2023 12:03:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoQow-0007fh-W5; Thu, 05 Oct 2023 12:03:31 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395G1hG8009599; Thu, 5 Oct 2023 16:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=9/C0G6Q4wt14quTOECTiyvR2zaExqMnzoCzTyWuumRQ=;
 b=qf5dbxCv8qSKomz4q64wQOZMbQKGqqxcyO8MUkU3kd3vAZL5C3ZadKpmEeJUzP/8sYGt
 6r554S1Gg4W8yPZFNu7jc5sbPt0k65W9MnqAyl09m8EggRmaiRPel2DuOQQGa7Ol34Zd
 MvFF4zFuIbGfyok41nkBtINOAyXh5oZOn/21ysL/CnlFwQ97SzbN7mDuUAdP7NHmstO0
 8VePw7LHOVxgTelalcG1zEfOb3Hqul3R1gWSbCq9XXPUIx6xXi/lqALb1BK9vpI42fXN
 ViVbyrvpOdMGL73axMTMUwc87/HXsKUUveIWjLOHsk6SJzSvUqr2yiRciVQI53aMlSV3 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj09s83vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:03:15 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395G1v5L010797;
 Thu, 5 Oct 2023 16:02:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj09s82dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FIfZv017676; Thu, 5 Oct 2023 16:02:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0nwcgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G1uJ815139398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:01:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEEFF20040;
 Thu,  5 Oct 2023 16:01:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 553C42004B;
 Thu,  5 Oct 2023 16:01:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 16:01:56 +0000 (GMT)
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
Subject: [PATCH v25 00/21] s390x: CPU Topology
Date: Thu,  5 Oct 2023 18:01:34 +0200
Message-Id: <20231005160155.1945588-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U-Z8yXwgv-ynnInO3ud5atNqWGECcVdW
X-Proofpoint-GUID: n3tG1pjLqlO-3s3SmVkyLdcTttr69CDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_10,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
  qapi: machine.json: change docs regarding CpuInstanceProperties

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
 qapi/machine-target.json            | 120 +++++++
 qapi/machine.json                   |  45 ++-
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
 softmmu/vl.c                        |   6 +
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
 34 files changed, 2212 insertions(+), 24 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py

Range-diff against v24:
 1:  2c7552ab60 !  1:  578a12c6e9 qapi: machine.json: change docs regarding CpuInstanceProperties
    @@ Commit message
     
      ## qapi/machine.json ##
     @@
    - # @qom-path: path to the CPU object in the QOM tree
      #
      # @thread-id: ID of the underlying host thread
    --#
    + #
     -# @props: properties describing to which node/socket/core/thread
     -#     virtual CPU belongs to, provided if supported by board
    -+
     +# @props: properties of type CpuInstanceProperties associated with a
     +#     virtual CPU, e.g. the socket id
      #
 2:  3ea5ee1016 !  2:  4a6314be55 CPU topology: extend with s390 specifics
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
    + ## MAINTAINERS ##
    +@@ MAINTAINERS: F: hw/core/null-machine.c
    + F: hw/core/numa.c
    + F: hw/cpu/cluster.c
    + F: qapi/machine.json
    ++F: qapi/machine-common.json
    + F: qapi/machine-target.json
    + F: include/hw/boards.h
    + F: include/hw/core/cpu.h
    +
      ## qapi/machine-common.json (new) ##
     @@
     +# -*- Mode: Python -*-
 3:  1f259b26b3 !  3:  a9e88599a3 s390x/cpu topology: add topology entries on CPU hotplug
    @@ hw/s390x/cpu-topology.c (new)
     +
     +    /* Do we still have space in the socket */
     +    entry = s390_socket_nb(cpu);
    -+    if (s390_topology.cores_per_socket[entry] >= current_machine->smp.cores) {
    ++    if (s390_topology.cores_per_socket[entry] >= ms->smp.cores) {
     +        error_setg(errp, "No more space on this socket");
     +        return;
     +    }
 4:  703a097c30 !  4:  27d8da8b17 target/s390x/cpu topology: handle STSI(15) and build the SYSIB
    @@ include/hw/s390x/cpu-topology.h
      
     +#define S390_TOPOLOGY_CPU_IFL   0x03
     +
    -+typedef struct s390_topology_id {
    ++typedef struct S390TopologyId {
     +    uint8_t sentinel;
     +    uint8_t drawer;
     +    uint8_t book;
    @@ include/hw/s390x/cpu-topology.h
     +    uint8_t entitlement:2;
     +    uint8_t dedicated;
     +    uint8_t origin;
    -+} s390_topology_id;
    ++} S390TopologyId;
     +
     +typedef struct S390TopologyEntry {
     +    QTAILQ_ENTRY(S390TopologyEntry) next;
    -+    s390_topology_id id;
    ++    S390TopologyId id;
     +    uint64_t mask;
     +} S390TopologyEntry;
     +
    @@ target/s390x/cpu.h: typedef union SysIB {
     + *   of any type, nested containers or CPU.
     + * - CPU Topology List Entry
     + *   Specifies the CPUs position, type, entitlement and polarization
    -+ *   of the CPUs contained in the last Container TLE.
    ++ *   of the CPUs contained in the last container TLE.
     + *
     + * There can be theoretically up to five levels of containers, QEMU
     + * uses only three levels, the drawer's, book's and socket's level.
    @@ target/s390x/kvm/stsi-topology.c (new)
     +static char *fill_tle_cpu(char *p, S390TopologyEntry *entry)
     +{
     +    SysIBCPUListEntry *tle = (SysIBCPUListEntry *)p;
    -+    s390_topology_id topology_id = entry->id;
    ++    S390TopologyId topology_id = entry->id;
     +
     +    tle->nl = 0;
     +    tle->flags = 0;
    @@ target/s390x/kvm/stsi-topology.c (new)
     + *
     + * Initialize the topology id from the CPU environment.
     + */
    -+static s390_topology_id s390_topology_from_cpu(S390CPU *cpu)
    ++static S390TopologyId s390_topology_from_cpu(S390CPU *cpu)
     +{
    -+    s390_topology_id topology_id = {
    ++    S390TopologyId topology_id = {
     +        .drawer = cpu->env.drawer_id,
     +        .book = cpu->env.book_id,
     +        .socket = cpu->env.socket_id,
    @@ target/s390x/kvm/stsi-topology.c (new)
     +
     +/**
     + * s390_topology_id_cmp:
    -+ * @l: first s390_topology_id
    -+ * @r: second s390_topology_id
    ++ * @l: first S390TopologyId
    ++ * @r: second S390TopologyId
     + *
     + * Compare two topology ids according to the sorting order specified by the PoP.
     + *
     + * Returns a negative number if the first id is less than, 0 if it is equal to
     + *     and positive if it is larger than the second id.
     + */
    -+static int s390_topology_id_cmp(const s390_topology_id *l,
    -+                                const s390_topology_id *r)
    ++static int s390_topology_id_cmp(const S390TopologyId *l,
    ++                                const S390TopologyId *r)
     +{
     +    /*
     +     * lexical order, compare less significant values only if more significant
    @@ target/s390x/kvm/stsi-topology.c (new)
     +           l->origin - r->origin;
     +}
     +
    -+static bool s390_topology_id_eq(const s390_topology_id *l,
    -+                               const s390_topology_id *r)
    ++static bool s390_topology_id_eq(const S390TopologyId *l,
    ++                                const S390TopologyId *r)
     +{
     +    return !s390_topology_id_cmp(l, r);
     +}
     +
    -+static bool s390_topology_id_lt(const s390_topology_id *l,
    -+                                const s390_topology_id *r)
    ++static bool s390_topology_id_lt(const S390TopologyId *l,
    ++                                const S390TopologyId *r)
     +{
     +    return s390_topology_id_cmp(l, r) < 0;
     +}
    @@ target/s390x/kvm/stsi-topology.c (new)
     + * s390_topology_fill_list_sorted:
     + * @topology_list: list to fill
     + *
    -+ * Loop over all CPU and insert it at the right place
    -+ * inside the TLE entry list.
    -+ * Fill the S390Topology list with entries according to the order
    -+ * specified by the PoP.
    ++ * Create S390TopologyEntrys as appropriate from all CPUs and fill the
    ++ * topology_list with the entries according to the order specified by the PoP.
     + */
     +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
     +{
    @@ target/s390x/kvm/stsi-topology.c (new)
     +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
     +
     +    CPU_FOREACH(cs) {
    -+        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
    ++        S390TopologyId id = s390_topology_from_cpu(S390_CPU(cs));
     +        S390TopologyEntry *entry = NULL, *tmp;
     +
     +        QTAILQ_FOREACH(tmp, topology_list, next) {
    @@ target/s390x/kvm/stsi-topology.c (new)
     +    }
     +
     +    s390_topology_fill_list_sorted(&topology_list);
    -+
     +    length = setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
    ++    s390_topology_empty_list(&topology_list);
     +
     +    if (!length) {
    -+        s390_topology_empty_list(&topology_list);
     +        setcc(cpu, 3);
     +        return;
     +    }
    @@ target/s390x/kvm/stsi-topology.c (new)
     +    } else {
     +        s390_cpu_virt_mem_handle_exc(cpu, ra);
     +    }
    -+
    -+    s390_topology_empty_list(&topology_list);
     +}
     
      ## target/s390x/kvm/meson.build ##
 5:  052b96b1fb =  5:  5d1128773c s390x/sclp: reporting the maximum nested topology entries
 6:  4229524ab7 =  6:  82b4423958 s390x/cpu topology: resetting the Topology-Change-Report
 7:  036699b7e3 =  7:  20cc1ec693 s390x/cpu topology: interception of PTF instruction
 8:  9c35dd0a1b =  8:  6ea320af67 target/s390x/cpu topology: activate CPU topology
 9:  e7eb324d8b !  9:  7b1f5de930 qapi/s390x/cpu topology: set-cpu-topology qmp command
    @@ hw/s390x/cpu-topology.c: void s390_topology_setup_cpu(MachineState *ms, S390CPU
     +}
     +
     +void qmp_set_cpu_topology(uint16_t core,
    -+                         bool has_socket, uint16_t socket,
    -+                         bool has_book, uint16_t book,
    -+                         bool has_drawer, uint16_t drawer,
    -+                         bool has_entitlement, CpuS390Entitlement entitlement,
    -+                         bool has_dedicated, bool dedicated,
    -+                         Error **errp)
    ++                          bool has_socket, uint16_t socket,
    ++                          bool has_book, uint16_t book,
    ++                          bool has_drawer, uint16_t drawer,
    ++                          bool has_entitlement, CpuS390Entitlement entitlement,
    ++                          bool has_dedicated, bool dedicated,
    ++                          Error **errp)
     +{
     +    if (!s390_has_topology()) {
     +        error_setg(errp, "This machine doesn't support topology");
10:  f05505e76e = 10:  97713ece9a machine: adding s390 topology to query-cpu-fast
11:  9ce080ffa3 = 11:  ac238a12cc machine: adding s390 topology to info hotpluggable-cpus
12:  7711f4f253 = 12:  0c4056fe8e qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
13:  67eb5092ac = 13:  bc7d0dafca qapi/s390x/cpu topology: add query-s390x-cpu-polarization command
14:  b8ccd9d6de = 14:  f2b1dbf34e docs/s390x/cpu topology: document s390x cpu topology
15:  2599bb2b9e ! 15:  9feb5107c2 tests/avocado: s390x cpu topology core
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Tested-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
16:  e6903afc76 = 16:  973ad2b9ce tests/avocado: s390x cpu topology polarization
17:  243aeb9174 ! 17:  bbcfd9219a tests/avocado: s390x cpu topology entitlement tests
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Tested-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
18:  20fabad2d3 = 18:  142a6e6f7d tests/avocado: s390x cpu topology test dedicated CPU
19:  4ed8f0883b = 19:  8c71a5dd64 tests/avocado: s390x cpu topology test socket full
20:  6787f49dfd = 20:  96051b8457 tests/avocado: s390x cpu topology dedicated errors
21:  01d7083d75 = 21:  c5ad16cf5e tests/avocado: s390x cpu topology bad move

base-commit: da1034094d375afe9e3d8ec8980550ea0f06f7e0
-- 
2.39.2


