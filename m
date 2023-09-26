Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D17AEC44
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6zd-0000iM-9F; Tue, 26 Sep 2023 08:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z4-0000Vz-Cm; Tue, 26 Sep 2023 08:16:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z0-0001Q9-QO; Tue, 26 Sep 2023 08:16:10 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QCC2ou022025; Tue, 26 Sep 2023 12:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=YDdGWFAAKwYy1h/aKESEvbgJjkjkne10zLSGgEupqHo=;
 b=MaRFtti7GL6PT53R/Su6xPYfTSOZigOEdl13LTKE6kbz3Pqi6fveGb7py7phCl2x3898
 2vPx1g9P/ZFcxTv5GhlpJd7D+YX2HEajP+/YN5HM5TddRDppelKfsKCT+C+fmQ1iiVY8
 zma8PhHdKHgATZLfXbQvbITqNsb262jAU/0otU2NfvomXu2/sX3XA+OFfXT8/WUUm7Js
 5MhhUHLvkdOq29N4H61b/fjQfy7liayPP3q0LR8EOreJLL9Aa0g1BKQPNRZgcPag10ZN
 HgAu44Dm9FiVWDLBJgxlTWXz5xpHXHYqd16t/81biL9wHZSbW3giatTkZuSTkuZ/sF0A Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:52 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QBjFrs032032;
 Tue, 26 Sep 2023 12:15:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QATdCe030735; Tue, 26 Sep 2023 12:15:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjtwmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFmrN14221838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 052332004B;
 Tue, 26 Sep 2023 12:15:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CC4C20043;
 Tue, 26 Sep 2023 12:15:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:47 +0000 (GMT)
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
Subject: [PATCH v24 00/21] s390x: CPU Topology
Date: Tue, 26 Sep 2023 14:15:13 +0200
Message-Id: <20230926121534.406035-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2LV0TNWdY8lqfUvnZ_qVCTX9HRDWMAtc
X-Proofpoint-ORIG-GUID: mSFuW4ToUvlFgQl2nd6ERXPIf3tF4P-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
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

Changes since v23 (range-diff below):
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

 MAINTAINERS                         |  10 +
 docs/devel/index-internals.rst      |   1 +
 docs/devel/s390-cpu-topology.rst    | 170 ++++++++++
 docs/system/s390x/cpu-topology.rst  | 244 +++++++++++++++
 docs/system/target-s390x.rst        |   1 +
 qapi/machine-common.json            |  21 ++
 qapi/machine-target.json            | 120 +++++++
 qapi/machine.json                   |  47 ++-
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
 target/s390x/kvm/stsi-topology.c    | 339 ++++++++++++++++++++
 hw/s390x/meson.build                |   1 +
 qapi/meson.build                    |   1 +
 qemu-options.hx                     |   7 +-
 target/s390x/kvm/meson.build        |   3 +-
 tests/avocado/s390_topology.py      | 439 ++++++++++++++++++++++++++
 34 files changed, 2217 insertions(+), 25 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py

Range-diff against v23:
 -:  ---------- >  1:  2c7552ab60 qapi: machine.json: change docs regarding CpuInstanceProperties
 1:  f2219b7583 !  2:  3ea5ee1016 CPU topology: extend with s390 specifics
    @@ Commit message
         Let us provide the SMP properties with books and drawers levels
         and S390 CPU with dedication and entitlement,
     
    +    Add machine-common.json so we can later include it in
    +    machine-target.json also.
    +
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
         Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
         Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
    @@ qapi/machine-common.json (new)
     +##
     +# @CpuS390Entitlement:
     +#
    -+# An enumeration of cpu entitlements that can be assumed by a virtual
    ++# An enumeration of CPU entitlements that can be assumed by a virtual
     +# S390 CPU
     +#
     +# Since: 8.2
    @@ qapi/machine.json
      
      ##
      # @SysEmuTarget:
    -@@
    - #
    - # @thread-id: ID of the underlying host thread
    - #
    --# @props: properties describing to which node/socket/core/thread
    -+# @props: properties describing to which node/drawer/book/socket/core/thread
    - #     virtual CPU belongs to, provided if supported by board
    - #
    - # @target: the QEMU system emulation target, which determines which
     @@
      #
      # @node-id: NUMA node ID the CPU belongs to
      #
     -# @socket-id: socket number within node/board the CPU belongs to
    -+# @drawer-id: drawer number within node/board the CPU belongs to (since 8.2)
    ++# @drawer-id: drawer number within node/board the CPU belongs to
    ++#     (since 8.2)
     +#
    -+# @book-id: book number within drawer/node/board the CPU belongs to (since 8.2)
    ++# @book-id: book number within drawer/node/board the CPU belongs to
    ++#     (since 8.2)
     +#
     +# @socket-id: socket number within book/node/board the CPU belongs to
      #
      # @die-id: die number within socket the CPU belongs to (since 4.1)
      #
     @@
    - #
    - # @thread-id: thread number within core the CPU belongs to
    - #
    --# Note: currently there are 6 properties that could be present but
    -+# Note: currently there are 8 properties that could be present but
    - #     management should be prepared to pass through other properties
    - #     with device_add command to allow for future interface extension.
    - #     This also requires the filed names to be kept in sync with the
    -@@
    - ##
      { 'struct': 'CpuInstanceProperties',
    +   # Keep these in sync with the properties device_add accepts
        'data': { '*node-id': 'int',
     +            '*drawer-id': 'int',
     +            '*book-id': 'int',
    @@ qapi/machine.json
           '*dies': 'int',
           '*clusters': 'int',
     
    + ## qapi/qapi-schema.json ##
    +@@
    + { 'include': 'introspect.json' }
    + { 'include': 'qom.json' }
    + { 'include': 'qdev.json' }
    ++{ 'include': 'machine-common.json' }
    + { 'include': 'machine.json' }
    + { 'include': 'machine-target.json' }
    + { 'include': 'replay.json' }
    +
      ## include/hw/boards.h ##
     @@ include/hw/boards.h: typedef struct {
       * @clusters_supported - whether clusters are supported by the machine
 2:  5fae55e5a1 =  3:  1f259b26b3 s390x/cpu topology: add topology entries on CPU hotplug
 3:  c775d90904 !  4:  703a097c30 target/s390x/cpu topology: handle STSI(15) and build the SYSIB
    @@ qapi/machine-target.json
     +##
     +# @CpuS390Polarization:
     +#
    -+# An enumeration of cpu polarization that can be assumed by a virtual
    ++# An enumeration of CPU polarization that can be assumed by a virtual
     +# S390 CPU
     +#
     +# Since: 8.2
    @@ qapi/machine-target.json
     +{ 'enum': 'CpuS390Polarization',
     +  'prefix': 'S390_CPU_POLARIZATION',
     +  'data': [ 'horizontal', 'vertical' ],
    -+    'if': 'TARGET_S390X'
    ++  'if': 'TARGET_S390X'
     +}
     
      ## include/hw/s390x/cpu-topology.h ##
    @@ target/s390x/kvm/stsi-topology.c (new)
     +           l->book - r->book ?:
     +           l->socket - r->socket ?:
     +           l->type - r->type ?:
    -+           -1 * (l->vertical - r->vertical) ?:
    -+           -1 * (l->entitlement - r->entitlement) ?:
    -+           -1 * (l->dedicated - r->dedicated) ?:
    ++           /* logic is inverted for the next three */
    ++           r->vertical - l->vertical ?:
    ++           r->entitlement - l->entitlement ?:
    ++           r->dedicated - l->dedicated ?:
     +           l->origin - r->origin;
     +}
     +
 4:  7c68edeb44 =  5:  052b96b1fb s390x/sclp: reporting the maximum nested topology entries
 5:  78d0a953c9 =  6:  4229524ab7 s390x/cpu topology: resetting the Topology-Change-Report
 6:  f15c30a1b9 =  7:  036699b7e3 s390x/cpu topology: interception of PTF instruction
 7:  837eb0924f =  8:  9c35dd0a1b target/s390x/cpu topology: activate CPU topology
 8:  394e0ae6c0 !  9:  e7eb324d8b qapi/s390x/cpu topology: set-cpu-topology qmp command
    @@ qapi/machine-target.json
      #
     @@
        'data': [ 'horizontal', 'vertical' ],
    -     'if': 'TARGET_S390X'
    +   'if': 'TARGET_S390X'
      }
     +
     +##
     +# @set-cpu-topology:
     +#
    ++# Modifies the topology by moving the CPU inside the topology
    ++# tree or by changing a modifier attribute of a CPU.
    ++# Absent values will not be modified.
    ++#
     +# @core-id: the vCPU ID to be moved
    -+# @socket-id: optional destination socket where to move the vCPU
    -+# @book-id: optional destination book where to move the vCPU
    -+# @drawer-id: optional destination drawer where to move the vCPU
    -+# @entitlement: optional entitlement
    -+# @dedicated: optional, if the vCPU is dedicated to a real CPU
    ++#
    ++# @socket-id: destination socket to move the vCPU to
    ++#
    ++# @book-id: destination book to move the vCPU to
    ++#
    ++# @drawer-id: destination drawer to move the vCPU to
    ++#
    ++# @entitlement: entitlement to set
    ++#
    ++# @dedicated: whether the provisioning of real to virtual CPU is dedicated
     +#
     +# Features:
    -+# @unstable: This command may still be modified.
     +#
    -+# Modifies the topology by moving the CPU inside the topology
    -+# tree or by changing a modifier attribute of a CPU.
    -+# Default value for optional parameter is the current value
    -+# used by the CPU.
    ++# @unstable: This command may still be modified.
     +#
     +# Returns: Nothing on success, the reason on failure.
     +#
 9:  a4b6738536 ! 10:  f05505e76e machine: adding s390 topology to query-cpu-fast
    @@ Commit message
     
      ## qapi/machine.json ##
     @@
    - # Additional information about a virtual S390 CPU
      #
      # @cpu-state: the virtual CPU's state
    + #
     +# @dedicated: the virtual CPU's dedication (since 8.2)
    ++#
     +# @entitlement: the virtual CPU's entitlement (since 8.2)
    - #
    ++#
      # Since: 2.12
      ##
     -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
10:  c74f719b43 = 11:  9ce080ffa3 machine: adding s390 topology to info hotpluggable-cpus
11:  a2bf4b54b3 ! 12:  7711f4f253 qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE qapi event
    @@ qapi/machine-target.json
     +#
     +# Emitted when the guest asks to change the polarization.
     +#
    -+# @polarization: polarization specified by the guest
    -+#
    -+# Features:
    -+# @unstable: This command may still be modified.
    -+#
     +# The guest can tell the host (via the PTF instruction) whether the
     +# CPUs should be provisioned using horizontal or vertical polarization.
     +#
    @@ qapi/machine-target.json
     +# The guest will get information on the details of the provisioning
     +# the next time it uses the STSI(15) instruction.
     +#
    ++# @polarization: polarization specified by the guest
    ++#
    ++# Features:
    ++#
    ++# @unstable: This event is experimental.
    ++#
     +# Since: 8.2
     +#
     +# Example:
12:  6a9e834176 ! 13:  67eb5092ac qapi/s390x/cpu topology: query-cpu-polarization qmp command
    @@ Metadata
     Author: Pierre Morel <pmorel@linux.ibm.com>
     
      ## Commit message ##
    -    qapi/s390x/cpu topology: query-cpu-polarization qmp command
    +    qapi/s390x/cpu topology: add query-s390x-cpu-polarization command
     
    -    The query-cpu-polarization qmp command returns the current
    +    The query-s390x-cpu-polarization qmp command returns the current
         CPU polarization of the machine.
     
         Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
    @@ qapi/machine-target.json
     +##
     +# @CpuPolarizationInfo:
     +#
    -+# The result of a cpu polarization
    ++# The result of a CPU polarization query.
     +#
     +# @polarization: the CPU polarization
     +#
    @@ qapi/machine-target.json
     +# @query-s390x-cpu-polarization:
     +#
     +# Features:
    -+# @unstable: This command may still be modified.
     +#
    -+# Returns: the machine polarization
    ++# @unstable: This command is experimental.
    ++#
    ++# Returns: the machine's CPU polarization
     +#
     +# Since: 8.2
     +##
13:  24d2a3507b ! 14:  b8ccd9d6de docs/s390x/cpu topology: document s390x cpu topology
    @@ docs/devel/s390-cpu-topology.rst (new)
     
      ## docs/system/s390x/cpu-topology.rst (new) ##
     @@
    ++.. _cpu-topology-s390x:
    ++
     +CPU topology on s390x
     +=====================
     +
    @@ docs/system/target-s390x.rst: Architectural features
         s390x/bootdevices
         s390x/protvirt
     +   s390x/cpu-topology
    +
    + ## qapi/machine.json ##
    +@@
    + # Which members are optional and which mandatory depends on the architecture
    + # and board.
    + #
    ++# For s390x see :ref:`cpu-topology-s390x`.
    ++#
    + # @node-id: NUMA node ID the CPU belongs to
    + #
    + # @drawer-id: drawer number within node/board the CPU belongs to
14:  bc1adfbdb7 = 15:  2599bb2b9e tests/avocado: s390x cpu topology core
15:  d2be50e3a7 = 16:  e6903afc76 tests/avocado: s390x cpu topology polarization
16:  4ba53284b1 = 17:  243aeb9174 tests/avocado: s390x cpu topology entitlement tests
17:  bfabe0aaf1 = 18:  20fabad2d3 tests/avocado: s390x cpu topology test dedicated CPU
18:  32009fe084 = 19:  4ed8f0883b tests/avocado: s390x cpu topology test socket full
19:  e607efc139 = 20:  6787f49dfd tests/avocado: s390x cpu topology dedicated errors
20:  e600011277 = 21:  01d7083d75 tests/avocado: s390x cpu topology bad move

base-commit: 494a6a2cf7f775d2c20fd6df9601e30606cc2014
-- 
2.39.2


