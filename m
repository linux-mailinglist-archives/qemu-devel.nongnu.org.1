Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05493A10DA1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 18:26:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkeE-0004k5-3a; Tue, 14 Jan 2025 12:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXke8-0004jx-Ku
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXke5-0004NH-5P
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:08 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0pKE020614;
 Tue, 14 Jan 2025 17:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=ezf7QWCr
 PGPgSwKdFNt8FVcmLRcwH89Hx3kWuDdBsw0=; b=WMdvohv8jEtccXztUa8bQ5RV
 +Nw+/H2Jum0ufqwlRdaUkm9TAI62zn5itgk8wGM5x96LCHj2NZzB7a+zJk0zVxiZ
 1W1cKsu0Xlhr7/rDNESix4v5Zcmbdys38twd/NFH5T8diDBnub26MYmNHSObNpXP
 Ta6o4onS4z0/gUJNkqG4rrRtC2N7Y8OY6fV3WLvynrkByIMbxz7Z6yY0+lIcExN3
 kYQt3XB+ZdCa6OnEYBq393zBE5qzmwd1AjXX3n0awivz57TRpfQtpFpvxr5viTnK
 6YCmfckcQHcQzgVpHBsJ0Y7kYxt6QdRqKJPo7UTI1brBOgBUypn4dlTg80w0Cw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f2bx8dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:23:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EH1iZN020425; Tue, 14 Jan 2025 17:23:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq5wb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:23:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtXU013352;
 Tue, 14 Jan 2025 17:23:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-1; Tue, 14 Jan 2025 17:23:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 00/24] Live update: cpr-transfer
Date: Tue, 14 Jan 2025 09:23:30 -0800
Message-Id: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-ORIG-GUID: BJ2GRLWCukmd-OQ9w0rs3TFAyRmQrMvq
X-Proofpoint-GUID: BJ2GRLWCukmd-OQ9w0rs3TFAyRmQrMvq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

What?

This patch series adds the live migration cpr-transfer mode, which
allows the user to transfer a guest to a new QEMU instance on the same
host with minimal guest pause time, by preserving guest RAM in place,
albeit with new virtual addresses in new QEMU, and by preserving device
file descriptors.

The new user-visible interfaces are:
  * cpr-transfer (MigMode migration parameter)
  * cpr (MigrationChannelType)
  * incoming MigrationChannel (command-line argument)
  * aux-ram-share (machine option)

The user sets the mode parameter before invoking the migrate command.
In this mode, the user starts new QEMU on the same host as old QEMU, with
the same arguments as old QEMU, plus two -incoming options; one for the main
channel, and one for the CPR channel.  The user issues the migrate command to
old QEMU, which stops the VM, saves state to the migration channels, and
enters the postmigrate state.  Execution resumes in new QEMU.

Memory-backend objects must have the share=on attribute, but memory-backend-epc
is not supported.  The VM must be started with the '-machine aux-ram-share=on'
option, which allows auxilliary guest memory to be transferred in place to the
new process.

This mode requires a second migration channel of type "cpr", in the channel
arguments on the outgoing side, and in a second -incoming command-line
parameter on the incoming side.  This CPR channel must support file descriptor
transfer with SCM_RIGHTS, i.e. it must be a UNIX domain socket.

Why?

This mode has less impact on the guest than any other method of updating
in place.  The pause time is much lower, because devices need not be torn
down and recreated, DMA does not need to be drained and quiesced, and minimal
state is copied to new QEMU.  Further, there are no constraints on the guest.
By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
and suspending plus resuming vfio devices adds multiple seconds to the
guest pause time.

These benefits all derive from the core design principle of this mode,
which is preserving open descriptors.  This approach is very general and
can be used to support a wide variety of devices that do not have hardware
support for live migration, including but not limited to: vfio, chardev,
vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
to allow a descriptor to be used in a process that did not originally open it.

How?

All memory that is mapped by the guest is preserved in place.  Indeed,
it must be, because it may be the target of DMA requests, which are not
quiesced during cpr-transfer.  All such memory must be mmap'able in new QEMU.
This is easy for named memory-backend objects, as long as they are mapped
shared, because they are visible in the file system in both old and new QEMU.
Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
so the memfd's can be sent to new QEMU.  Pages that were locked in memory
for DMA in old QEMU remain locked in new QEMU, because the descriptor of
the device that locked them remains open.

cpr-transfer preserves descriptors by sending them to new QEMU via the CPR
channel, which must support SCM_RIGHTS, and by sending the unique name of
each descriptor to new QEMU via CPR state.

For device descriptors, new QEMU reuses the descriptor when creating the
device, rather than opening it again.  For memfd descriptors, new QEMU
mmap's the preserved memfd when a ramblock is created.

CPR state cannot be sent over the normal migration channel, because devices
and backends are created prior to reading the channel, so this mode sends
CPR state over a second "cpr" migration channel.  New QEMU reads the second
channel prior to creating devices or backends.

Example:

In this example, we simply restart the same version of QEMU, but in
a real scenario one would use a new QEMU binary path in terminal 2.

  Terminal 1: start old QEMU
  # qemu-kvm -qmp stdio -object
  memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
  -m 4G -machine aux-ram-share=on ...

  Terminal 2: start new QEMU
  # qemu-kvm -monitor stdio ... -incoming tcp:0:44444
    -incoming '{"channel-type": "cpr",
                "addr": { "transport": "socket", "type": "unix",
                          "path": "cpr.sock"}}'

  Terminal 1:
  {"execute":"qmp_capabilities"}

  {"execute": "query-status"}
  {"return": {"status": "running",
              "running": true}}

  {"execute":"migrate-set-parameters",
   "arguments":{"mode":"cpr-transfer"}}

  {"execute": "migrate", "arguments": { "channels": [
    {"channel-type": "main",
     "addr": { "transport": "socket", "type": "inet",
               "host": "0", "port": "44444" }},
    {"channel-type": "cpr",
     "addr": { "transport": "socket", "type": "unix",
               "path": "cpr.sock" }}]}}

  {"execute": "query-status"}
  {"return": {"status": "postmigrate",
              "running": false}}

  Terminal 2:
  QEMU 10.0.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running

This patch series implements a minimal version of cpr-transfer.  Additional
series are ready to be posted to deliver the complete vision described
above, including
  * vfio
  * chardev
  * vhost and tap
  * blockers
  * cpr-exec mode
  * iommufd

Changes in V2:
  * cpr-transfer is the first new mode proposed, and cpr-exec is deferred
  * anon-alloc does not apply to memory-backend-object
  * replaced hack with proper synchronization between source and target
  * defined QEMU_CPR_FILE_MAGIC
  * addressed misc review comments

Changes in V3:
  * added cpr-transfer to migration-test
  * documented cpr-transfer in CPR.rst
  * fix size_t trace format for 32-bit build
  * drop explicit fd value in VMSTATE_FD
  * defer cpr_walk_fd() and cpr_resave_fd() to later series
  * drop "migration: save cpr mode".
    delete mode from cpr state, and use cpr_uri to infer transfer mode.
  * drop "migration: stop vm earlier for cpr"
  * dropped cpr helpers, to be re-added later when needed
  * fixed an unreported bug for cpr-transfer and migrate cancel
  * documented cpr-transfer restrictions in qapi
  * added trace for cpr_state_save and cpr_state_load
  * added ftruncate to "preserve ram blocks"

Changes in V4:
  * cleaned up qtest deferred connection code
  * renamed pass_fd -> can_pass_fd
  * squashed patch "split qmp_migrate"
  * deleted cpr-uri and its patches
  * added cpr channel and its patches
  * added patch "hostmem-shm: preserve for cpr"
  * added patch "fd-based shared memory"
  * added patch "factor out allocation of anonymous shared memory"
  * added RAM_PRIVATE and its patch
  * added aux-ram-share and its patch

Changes in V5:
  * added patch 'enhance migrate_uri_parse'
  * supported dotted keys for -incoming channel,
    and rewrote incoming_option_parse
  * moved migrate_fd_cancel -> vm_resume to "stop vm earlier for cpr"
    in a future series.
  * updated command-line definition for aux-ram-share
  * added patch "resizable qemu_ram_alloc_from_fd"
  * rewrote patch "fd-based shared memory"
  * fixed error message in qemu_shm_alloc
  * added patch 'tests/qtest: optimize migrate_set_ports'
  * added patch 'tests/qtest: enhance migration channels'
  * added patch 'tests/qtest: assert qmp_ready'
  * modified patch 'migration-test: cpr-transfer'
  * polished the documentation in CPR.rst, qapi, and the
    cpr-transfer mode commit message
  * updated to master, and resolved massive context diffs for migration tests

Changes in V6:
  * added RB's and Acks.
  * in patch "assert qmp_ready", deleted qmp_ready and checked qmp_fd instead.
    renamed patch to ""assert qmp connected"
  * factored out fix into new patch
    "fix qemu_ram_alloc_from_fd size calculation"
  * deleted a redundant call to migrate_hup_delete
  * added commit message to "migration: cpr-transfer documentation"
  * polished the text of cpr-transfer mode in qapi

The first 10 patches below are foundational and are needed for both cpr-transfer
mode and the proposed cpr-exec mode.  The next 6 patches are specific to
cpr-transfer and implement the mechanisms for sharing state across a socket
using SCM_RIGHTS.  The last 8 patches supply tests and documentation.

Steve Sistare (24):
  backends/hostmem-shm: factor out allocation of "anonymous shared
    memory with an fd"
  physmem: fix qemu_ram_alloc_from_fd size calculation
  physmem: qemu_ram_alloc_from_fd extensions
  physmem: fd-based shared memory
  memory: add RAM_PRIVATE
  machine: aux-ram-share option
  migration: cpr-state
  physmem: preserve ram blocks for cpr
  hostmem-memfd: preserve for cpr
  hostmem-shm: preserve for cpr
  migration: enhance migrate_uri_parse
  migration: incoming channel
  migration: SCM_RIGHTS for QEMUFile
  migration: VMSTATE_FD
  migration: cpr-transfer save and load
  migration: cpr-transfer mode
  migration-test: memory_backend
  tests/qtest: optimize migrate_set_ports
  tests/qtest: defer connection
  migration-test: defer connection
  tests/qtest: enhance migration channels
  tests/qtest: assert qmp connected
  migration-test: cpr-transfer
  migration: cpr-transfer documentation

 backends/hostmem-epc.c                 |   2 +-
 backends/hostmem-file.c                |   2 +-
 backends/hostmem-memfd.c               |  14 ++-
 backends/hostmem-ram.c                 |   2 +-
 backends/hostmem-shm.c                 |  51 ++------
 docs/devel/migration/CPR.rst           | 182 ++++++++++++++++++++++++++-
 hw/core/machine.c                      |  20 +++
 include/exec/memory.h                  |  10 ++
 include/exec/ram_addr.h                |  13 +-
 include/hw/boards.h                    |   1 +
 include/migration/cpr.h                |  33 +++++
 include/migration/misc.h               |   7 ++
 include/migration/vmstate.h            |   9 ++
 include/qemu/osdep.h                   |   1 +
 meson.build                            |   8 +-
 migration/cpr-transfer.c               |  76 +++++++++++
 migration/cpr.c                        | 224 +++++++++++++++++++++++++++++++++
 migration/meson.build                  |   2 +
 migration/migration.c                  | 139 +++++++++++++++++++-
 migration/migration.h                  |   4 +-
 migration/options.c                    |   8 +-
 migration/qemu-file.c                  |  83 +++++++++++-
 migration/qemu-file.h                  |   2 +
 migration/ram.c                        |   2 +
 migration/trace-events                 |  11 ++
 migration/vmstate-types.c              |  24 ++++
 qapi/migration.json                    |  44 ++++++-
 qemu-options.hx                        |  34 +++++
 stubs/vmstate.c                        |   7 ++
 system/memory.c                        |   4 +-
 system/physmem.c                       | 150 ++++++++++++++++++----
 system/trace-events                    |   1 +
 system/vl.c                            |  43 ++++++-
 tests/qtest/libqtest.c                 |  86 ++++++++-----
 tests/qtest/libqtest.h                 |  19 ++-
 tests/qtest/migration/cpr-tests.c      |  60 +++++++++
 tests/qtest/migration/framework.c      |  74 +++++++++--
 tests/qtest/migration/framework.h      |  11 ++
 tests/qtest/migration/migration-qmp.c  |  53 ++++++--
 tests/qtest/migration/migration-qmp.h  |  10 +-
 tests/qtest/migration/migration-util.c |  23 ++--
 tests/qtest/migration/misc-tests.c     |   9 +-
 tests/qtest/migration/precopy-tests.c  |   6 +-
 tests/qtest/virtio-net-failover.c      |   8 +-
 util/memfd.c                           |  16 ++-
 util/oslib-posix.c                     |  53 ++++++++
 util/oslib-win32.c                     |   6 +
 47 files changed, 1473 insertions(+), 174 deletions(-)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr-transfer.c
 create mode 100644 migration/cpr.c

base-commit: e8aa7fdcddfc8589bdc7c973a052e76e8f999455

-- 
1.8.3.1


