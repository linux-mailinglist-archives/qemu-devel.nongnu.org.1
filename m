Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42D7A040A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglbW-0007BW-O0; Thu, 14 Sep 2023 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qglbN-000713-Kn; Thu, 14 Sep 2023 08:37:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qglbJ-0000hV-Nv; Thu, 14 Sep 2023 08:37:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38ECLioX027208; Thu, 14 Sep 2023 12:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=vOR2YQldXjfPVODr+Ibu/T2jyy0iuHsnOSDdHDypLNA=;
 b=BhrCDtzI5Y4dADV4PHWPjjEHl7Rh0hGiA5R5osHYbJom7mjImrTNFGFjphW4sMV4qKa8
 tai1i+N0PqcHMmP+B2BtFpGD5gnwZU5gnulNseMEL+1rWko3/GgIV5evhc3o1K0eQwhJ
 L0jVtTyut+2pzbPJKQyEN8JBTD1dYGTn6EJ/SL+RAeaWIYme/PlCy1uMnyi3H1cXjKMB
 oFqkTn3EZn/QUqIyfrX+1yD1B/oajS3ivsFbbBSIlGn4QGzct7ePo0/bAZSV0LnaGZJK
 F9mseUrBnVM667x+u0+BpMEQ2QiMu4sJoQ61TBrKmARa+v1fw6sDYs+e9j9KE1AfaP6+ VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4244gpt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:37:30 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38ECLrP1027716;
 Thu, 14 Sep 2023 12:37:29 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4244gkkw-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:37:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EBPjqL002410; Thu, 14 Sep 2023 12:06:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158kjb1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:06:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38EC6sKv16581136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 12:06:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F7D82006C;
 Thu, 14 Sep 2023 12:06:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF86A2005A;
 Thu, 14 Sep 2023 12:06:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Sep 2023 12:06:53 +0000 (GMT)
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
Subject: [PATCH v23 00/20] s390x: CPU Topology
Date: Thu, 14 Sep 2023 14:06:30 +0200
Message-Id: <20230914120650.1318932-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SDMgzHRO7Fp6WCkC4OZsW7HTaVkaotpX
X-Proofpoint-ORIG-GUID: _8te63p8xTkfYafcy59zvIEvTvjScy3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309140108
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

Changes since v22 (range-diff below):

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
 docs/devel/s390-cpu-topology.rst    | 170 ++++++++++
 docs/system/s390x/cpu-topology.rst  | 242 ++++++++++++++
 docs/system/target-s390x.rst        |   1 +
 qapi/machine-common.json            |  21 ++
 qapi/machine-target.json            | 113 +++++++
 qapi/machine.json                   |  28 +-
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
 target/s390x/kvm/stsi-topology.c    | 338 ++++++++++++++++++++
 hw/s390x/meson.build                |   1 +
 qapi/meson.build                    |   1 +
 qemu-options.hx                     |   7 +-
 target/s390x/kvm/meson.build        |   3 +-
 tests/avocado/s390_topology.py      | 439 ++++++++++++++++++++++++++
 33 files changed, 2193 insertions(+), 19 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py

Range-diff against v22:
 1:  c26d3df9f9 !  1:  f2219b7583 CPU topology: extend with s390 specifics
    @@ qapi/machine.json
      # @thread-id: ID of the underlying host thread
      #
     -# @props: properties describing to which node/socket/core/thread
    --#     virtual CPU belongs to, provided if supported by board
     +# @props: properties describing to which node/drawer/book/socket/core/thread
    -+#         virtual CPU belongs to, provided if supported by board
    + #     virtual CPU belongs to, provided if supported by board
      #
      # @target: the QEMU system emulation target, which determines which
    - #     additional fields will be listed (since 3.0)
     @@
      #
      # @node-id: NUMA node ID the CPU belongs to
    @@ hw/s390x/s390-virtio-ccw.c: static void ccw_machine_class_init(ObjectClass *oc,
          assert(!mc->get_hotplug_handler);
          mc->get_hotplug_handler = s390_get_hotplug_handler;
          mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
    +@@ hw/s390x/s390-virtio-ccw.c: static void ccw_machine_8_1_class_options(MachineClass *mc)
    + {
    +     ccw_machine_8_2_class_options(mc);
    +     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
    ++    mc->smp_props.drawers_supported = false;
    ++    mc->smp_props.books_supported = false;
    + }
    + DEFINE_CCW_MACHINE(8_1, "8.1", false);
    + 
     
      ## softmmu/vl.c ##
     @@ softmmu/vl.c: static QemuOptsList qemu_smp_opts = {
 2:  6d32f1e3d4 !  2:  5fae55e5a1 s390x/cpu topology: add topology entries on CPU hotplug
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
    @@ hw/s390x/cpu-topology.c (new)
     +        return false;
     +    }
     +
    -+    /* Check if one of the geometry topology is unset */
    ++    /* If one value is unset all are unset -> calculate defaults */
     +    if (env->socket_id < 0) {
    -+        /* Calculate default geometry topology attributes */
     +        env->socket_id = s390_std_socket(env->core_id, smp);
     +        env->book_id = s390_std_book(env->core_id, smp);
     +        env->drawer_id = s390_std_drawer(env->core_id, smp);
    @@ hw/s390x/cpu-topology.c (new)
     +                                bool dedicated, Error **errp)
     +{
     +    CpuTopology *smp = &current_machine->smp;
    -+    ERRP_GUARD();
     +
     +    if (socket_id >= smp->sockets) {
     +        error_setg(errp, "Unavailable socket: %d", socket_id);
    @@ hw/s390x/cpu-topology.c (new)
     + */
     +void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
     +{
    -+    ERRP_GUARD();
     +    int entry;
     +
     +    /*
 3:  ab54bb7881 !  3:  c775d90904 target/s390x/cpu topology: handle STSI(15) and build the SYSIB
    @@ Commit message
         (SYSIB) is built from the list of pre-ordered topology entries.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
    @@ qapi/machine-target.json
     +{ 'enum': 'CpuS390Polarization',
     +  'prefix': 'S390_CPU_POLARIZATION',
     +  'data': [ 'horizontal', 'vertical' ],
    -+    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
    ++    'if': 'TARGET_S390X'
     +}
     
      ## include/hw/s390x/cpu-topology.h ##
    @@ include/hw/s390x/cpu-topology.h
      
     +#define S390_TOPOLOGY_CPU_IFL   0x03
     +
    -+typedef union s390_topology_id {
    -+    uint64_t id;
    -+    struct {
    -+        uint8_t _reserved0;
    -+        uint8_t drawer;
    -+        uint8_t book;
    -+        uint8_t socket;
    -+        uint8_t type;
    -+        uint8_t inv_polarization;
    -+        uint8_t not_dedicated;
    -+        uint8_t origin;
    -+    };
    ++typedef struct s390_topology_id {
    ++    uint8_t sentinel;
    ++    uint8_t drawer;
    ++    uint8_t book;
    ++    uint8_t socket;
    ++    uint8_t type;
    ++    uint8_t vertical:1;
    ++    uint8_t entitlement:2;
    ++    uint8_t dedicated;
    ++    uint8_t origin;
     +} s390_topology_id;
     +
     +typedef struct S390TopologyEntry {
    @@ target/s390x/cpu.h: typedef union SysIB {
     + *
     + * The CPU TLE defines the position of the CPUs of identical qualities
     + * using a 64bits mask which first bit has its offset defined by
    -+ * the CPU address orgin field of the CPU TLE like in:
    ++ * the CPU address origin field of the CPU TLE like in:
     + * CPU address = origin * 64 + bit position within the mask
    -+ *
     + */
     +/* Container type Topology List Entry */
     +typedef struct SYSIBContainerListEntry {
    @@ target/s390x/kvm/stsi-topology.c (new)
     +    s390_topology_id topology_id = entry->id;
     +
     +    tle->nl = 0;
    -+    tle->flags = 3 - topology_id.inv_polarization;
    -+    if (!topology_id.not_dedicated) {
    ++    tle->flags = 0;
    ++    if (topology_id.vertical) {
    ++        tle->flags |= topology_id.entitlement;
    ++    }
    ++    if (topology_id.dedicated) {
     +        tle->flags |= SYSIB_TLE_DEDICATED;
     +    }
     +    tle->type = topology_id.type;
    @@ target/s390x/kvm/stsi-topology.c (new)
     +
     +/**
     + * setup_stsi:
    -+ * sysib: pointer to a SysIB to be filled with SysIB_151x data
    -+ * level: Nested level specified by the guest
    ++ * @topology_list: ordered list of groups of CPUs with same properties
    ++ * @sysib: pointer to a SysIB to be filled with SysIB_151x data
    ++ * @level: Nested level specified by the guest
     + *
     + * Setup the SYSIB for STSI 15.1, the header as well as the description
     + * of the topology.
    @@ target/s390x/kvm/stsi-topology.c (new)
     + */
     +static s390_topology_id s390_topology_from_cpu(S390CPU *cpu)
     +{
    -+    s390_topology_id topology_id = {0};
    ++    s390_topology_id topology_id = {
    ++        .drawer = cpu->env.drawer_id,
    ++        .book = cpu->env.book_id,
    ++        .socket = cpu->env.socket_id,
    ++        .type = S390_TOPOLOGY_CPU_IFL,
    ++        .vertical = s390_topology.polarization == S390_CPU_POLARIZATION_VERTICAL,
    ++        .entitlement = cpu->env.entitlement,
    ++        .dedicated = cpu->env.dedicated,
    ++        .origin = cpu->env.core_id / 64,
    ++    };
     +
    -+    topology_id.drawer = cpu->env.drawer_id;
    -+    topology_id.book = cpu->env.book_id;
    -+    topology_id.socket = cpu->env.socket_id;
    -+    topology_id.type = S390_TOPOLOGY_CPU_IFL;
    -+    topology_id.not_dedicated = !cpu->env.dedicated;
    ++    return topology_id;
    ++}
     +
    -+    topology_id.inv_polarization = 3;
    -+    if (s390_topology.polarization == S390_CPU_POLARIZATION_VERTICAL) {
    -+        topology_id.inv_polarization -= cpu->env.entitlement;
    -+    }
    ++/**
    ++ * s390_topology_id_cmp:
    ++ * @l: first s390_topology_id
    ++ * @r: second s390_topology_id
    ++ *
    ++ * Compare two topology ids according to the sorting order specified by the PoP.
    ++ *
    ++ * Returns a negative number if the first id is less than, 0 if it is equal to
    ++ *     and positive if it is larger than the second id.
    ++ */
    ++static int s390_topology_id_cmp(const s390_topology_id *l,
    ++                                const s390_topology_id *r)
    ++{
    ++    /*
    ++     * lexical order, compare less significant values only if more significant
    ++     * ones are equal
    ++     */
    ++    return l->sentinel - r->sentinel ?:
    ++           l->drawer - r->drawer ?:
    ++           l->book - r->book ?:
    ++           l->socket - r->socket ?:
    ++           l->type - r->type ?:
    ++           -1 * (l->vertical - r->vertical) ?:
    ++           -1 * (l->entitlement - r->entitlement) ?:
    ++           -1 * (l->dedicated - r->dedicated) ?:
    ++           l->origin - r->origin;
    ++}
     +
    -+    topology_id.origin = cpu->env.core_id / 64;
    ++static bool s390_topology_id_eq(const s390_topology_id *l,
    ++                               const s390_topology_id *r)
    ++{
    ++    return !s390_topology_id_cmp(l, r);
    ++}
     +
    -+    return topology_id;
    ++static bool s390_topology_id_lt(const s390_topology_id *l,
    ++                                const s390_topology_id *r)
    ++{
    ++    return s390_topology_id_cmp(l, r) < 0;
     +}
     +
     +/**
     + * s390_topology_fill_list_sorted:
    ++ * @topology_list: list to fill
     + *
     + * Loop over all CPU and insert it at the right place
     + * inside the TLE entry list.
    @@ target/s390x/kvm/stsi-topology.c (new)
     +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
     +{
     +    CPUState *cs;
    -+    S390TopologyEntry sentinel;
    ++    S390TopologyEntry sentinel = { .id.sentinel = 1 };
     +
     +    QTAILQ_INIT(topology_list);
     +
    -+    sentinel.id.id = cpu_to_be64(UINT64_MAX);
     +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
     +
     +    CPU_FOREACH(cs) {
     +        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
    -+        S390TopologyEntry *entry, *tmp;
    ++        S390TopologyEntry *entry = NULL, *tmp;
     +
     +        QTAILQ_FOREACH(tmp, topology_list, next) {
    -+            if (id.id == tmp->id.id) {
    ++            if (s390_topology_id_eq(&id, &tmp->id)) {
     +                entry = tmp;
     +                break;
    -+            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id)) {
    ++            } else if (s390_topology_id_lt(&id, &tmp->id)) {
     +                entry = g_malloc0(sizeof(*entry));
    -+                entry->id.id = id.id;
    ++                entry->id = id;
     +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
     +                break;
     +            }
     +        }
    ++        assert(entry);
     +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
     +    }
     +
    @@ target/s390x/kvm/stsi-topology.c (new)
     +
     +/**
     + * insert_stsi_15_1_x:
    -+ * cpu: the CPU doing the call for which we set CC
    -+ * sel2: the selector 2, containing the nested level
    -+ * addr: Guest logical address of the guest SysIB
    -+ * ar: the access register number
    ++ * @cpu: the CPU doing the call for which we set CC
    ++ * @sel2: the selector 2, containing the nested level
    ++ * @addr: Guest logical address of the guest SysIB
    ++ * @ar: the access register number
    ++ * @ra: the return address
     + *
     + * Emulate STSI 15.1.x, that is, perform all necessary checks and
     + * fill the SYSIB.
 4:  67278aa3a0 =  4:  7c68edeb44 s390x/sclp: reporting the maximum nested topology entries
 5:  ce87494fd1 =  5:  78d0a953c9 s390x/cpu topology: resetting the Topology-Change-Report
 6:  c56178005a =  6:  f15c30a1b9 s390x/cpu topology: interception of PTF instruction
 7:  e56149e34f =  7:  837eb0924f target/s390x/cpu topology: activate CPU topology
 8:  c94943deef !  8:  394e0ae6c0 qapi/s390x/cpu topology: set-cpu-topology qmp command
    @@ qapi/machine-target.json
      #
     @@
        'data': [ 'horizontal', 'vertical' ],
    -     'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
    +     'if': 'TARGET_S390X'
      }
     +
     +##
    @@ hw/s390x/cpu-topology.c: static bool s390_topology_check(uint16_t socket_id, uin
     + * tree or the topology attributes change.
     + */
     +static bool s390_topology_need_report(S390CPU *cpu, int drawer_id,
    -+                                   int book_id, int socket_id,
    -+                                   uint16_t entitlement, bool dedicated)
    ++                                      int book_id, int socket_id,
    ++                                      uint16_t entitlement, bool dedicated)
     +{
     +    return cpu->env.drawer_id != drawer_id ||
     +           cpu->env.book_id != book_id ||
    @@ hw/s390x/cpu-topology.c: void s390_topology_setup_cpu(MachineState *ms, S390CPU
     +    int new_socket_entry;
     +    bool report_needed;
     +    S390CPU *cpu;
    -+    ERRP_GUARD();
     +
     +    cpu = s390_cpu_addr2state(core_id);
     +    if (!cpu) {
    @@ hw/s390x/cpu-topology.c: void s390_topology_setup_cpu(MachineState *ms, S390CPU
     +
     +    /*
     +     * When the user specifies the entitlement as 'auto' on the command line,
    -+     * qemu will set the entitlement as:
    ++     * QEMU will set the entitlement as:
     +     * Medium when the CPU is not dedicated.
     +     * High when dedicated is true.
     +     */
    -+    if (!has_entitlement || (entitlement == S390_CPU_ENTITLEMENT_AUTO)) {
    ++    if (!has_entitlement || entitlement == S390_CPU_ENTITLEMENT_AUTO) {
     +        if (dedicated) {
     +            entitlement = S390_CPU_ENTITLEMENT_HIGH;
     +        } else {
    @@ hw/s390x/cpu-topology.c: void s390_topology_setup_cpu(MachineState *ms, S390CPU
     +                         bool has_dedicated, bool dedicated,
     +                         Error **errp)
     +{
    -+    ERRP_GUARD();
    -+
     +    if (!s390_has_topology()) {
     +        error_setg(errp, "This machine doesn't support topology");
     +        return;
 9:  516a727ef5 !  9:  a4b6738536 machine: adding s390 topology to query-cpu-fast
    @@ Commit message
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## qapi/machine.json ##
10:  4b8bfddea9 ! 10:  c74f719b43 machine: adding s390 topology to info hotpluggable-cpus
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
     
      ## hw/core/machine-hmp-cmds.c ##
     @@ hw/core/machine-hmp-cmds.c: void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
11:  6584a655e9 = 11:  a2bf4b54b3 qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
12:  7e18ccdbcc ! 12:  6a9e834176 qapi/s390x/cpu topology: query-cpu-polarization qmp command
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
13:  810118478c ! 13:  24d2a3507b docs/s390x/cpu topology: document s390x cpu topology
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
    @@ docs/devel/s390-cpu-topology.rst (new)
     +    -enable-kvm \
     +    -cpu z14,ctop=on \
     +    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
    -+    \
     +    -device z14-s390x-cpu,core-id=19,entitlement=high \
     +    -device z14-s390x-cpu,core-id=11,entitlement=low \
     +    -device z14-s390x-cpu,core-id=112,entitlement=high \
    @@ docs/system/s390x/cpu-topology.rst (new)
     +  They will take the core-ids 0,1,2,3,4
     +  As we have 4 cores in a socket, we have 4 CPUs provided
     +  to the guest in socket 0, with core-ids 0,1,2,3.
    -+  The last cpu, with core-id 4, will be on socket 1.
    ++  The last CPU, with core-id 4, will be on socket 1.
     +
     +* the core with ID 14 provided by the ``-device`` command line will
     +  be placed in socket 3, with core-id 14
14:  717f901bb0 ! 14:  bc1adfbdb7 tests/avocado: s390x cpu topology core
    @@ Commit message
         the QMP results in query-cpus-fast for various CPU topology.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: F: hw/s390x/cpu-topology.c
    @@ tests/avocado/s390_topology.py (new)
     +        self.assertEqual(res['return'], {})
     +        self.check_topology(0, 2, 0, 0, 'low', False)
     +
    -+    def test_hotplug_full(self):
    ++    def test_dash_device(self):
     +        """
    -+        This test verifies that a hotplugged defined with '-device'
    -+        command line argument finds its right place inside the topology.
    ++        This test verifies that a CPU defined with the '-device'
    ++        command line option finds its right place inside the topology.
     +
     +        :avocado: tags=arch:s390x
     +        :avocado: tags=machine:s390-ccw-virtio
15:  7c5793cf9b ! 15:  d2be50e3a7 tests/avocado: s390x cpu topology polarization
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
    @@ tests/avocado/s390_topology.py: def kernel_init(self):
     +        exec_command_and_wait_for_pattern(self,
     +                """ mount proc -t proc /proc;
     +                    mount sys -t sysfs /sys;
    -+                    /bin/cat /sys/devices/system/cpu/dispatching """,
    ++                    cat /sys/devices/system/cpu/dispatching """,
     +                    '0')
     +
          def test_single(self):
              """
              This test checks the simplest topology with a single CPU.
    -@@ tests/avocado/s390_topology.py: def test_hotplug_full(self):
    +@@ tests/avocado/s390_topology.py: def test_dash_device(self):
              self.check_topology(3, 1, 1, 1, 'high', False)
              self.check_topology(4, 1, 1, 1, 'medium', False)
              self.check_topology(5, 2, 1, 1, 'high', True)
    @@ tests/avocado/s390_topology.py: def test_hotplug_full(self):
     +                f'echo {dispatching} > /sys/devices/system/cpu/dispatching')
     +        self.vm.event_wait('CPU_POLARIZATION_CHANGE', self.event_timeout)
     +        exec_command_and_wait_for_pattern(self,
    -+                '/bin/cat /sys/devices/system/cpu/dispatching', dispatching)
    ++                'cat /sys/devices/system/cpu/dispatching', dispatching)
     +
     +
     +    def test_polarization(self):
16:  f1aa5e3d91 ! 16:  4ba53284b1 tests/avocado: s390x cpu topology entitlement tests
    @@ Commit message
         view, depending on the polarization.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
    @@ tests/avocado/s390_topology.py: def test_polarization(self):
     +
     +
     +    def check_polarization(self, polarization):
    -+        """
    -+        We need the polarization change to get stabilized in kernel
    -+        before we check it through the sysfs.
    -+        """
    ++        #We need to wait for the change to have been propagated to the kernel
     +        exec_command_and_wait_for_pattern(self,
    -+                """ sleep 1 ;
    -+                    /bin/cat /sys/devices/system/cpu/cpu0/polarization """,
    -+                polarization)
    ++            "\n".join([
    ++                "timeout 1 sh -c 'while true",
    ++                'do',
    ++                '    syspath="/sys/devices/system/cpu/cpu0/polarization"',
    ++                '    polarization="$(cat "$syspath")" || exit',
    ++               f'    if [ "$polarization" = "{polarization}" ]; then',
    ++                '        exit 0',
    ++                '    fi',
    ++                '    sleep 0.01',
    ++                #searched for strings mustn't show up in command, '' to obfuscate
    ++                "done' && echo succ''ess || echo fail''ure",
    ++            ]),
    ++            "success", "failure")
     +
     +
     +    def test_entitlement(self):
17:  820481f18c ! 17:  bfabe0aaf1 tests/avocado: s390x cpu topology test dedicated CPU
    @@ Commit message
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    +    Reviewed-by: Thomas Huth <thuth@redhat.com>
    +    Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
     
      ## tests/avocado/s390_topology.py ##
18:  d1efe180f3 = 18:  32009fe084 tests/avocado: s390x cpu topology test socket full
19:  568de9fef9 = 19:  e607efc139 tests/avocado: s390x cpu topology dedicated errors
20:  9f9672adc2 = 20:  e600011277 tests/avocado: s390x cpu topology bad move

base-commit: 9ef497755afc252fb8e060c9ea6b0987abfd20b6
-- 
2.39.2


