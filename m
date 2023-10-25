Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA87D749D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjo2-0002wg-7u; Wed, 25 Oct 2023 15:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qvjnw-0002sw-OI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:44:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qvjnt-000744-RJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:44:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PEwHnW026203; Wed, 25 Oct 2023 19:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=Id7o2gxtwrhMgbJ56TJfp4F8gdrOfMwZsRTL7YNUTDw=;
 b=dAvIbfxQB1uho7mwUBJBxHP6lfXpWk5m8A1pC63xhEaRyyHfRkOTbR8tJU6tPTLLmdhf
 JQLnLf9UldZ1z2Kwdu6Mq1z5vpNZeaQ6zM13SaOauiZb6W05WWTcvsWTbBjln7Guz0Tw
 v+fA8vBQ/dn7ufk/i1eX+7ZJO+a1fhtNK9NOUPJZVYqLzy2jOFFO78Nv1eskwiQHM7a7
 ZIfMLWj/7rCCEM3AOQbQfDO0sT/ASV4g4cwwUNUN31FXGTlxE7V7a37XRXI9psdCnQKm
 oni1ssBfw5N5d+4fbKqNse6Pmq4JQguQ6/LcDjTmVGBaeK+nmkeeTXGAeNJSMGhkydT5 Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52e0p3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 19:44:31 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39PI7NTe034526; Wed, 25 Oct 2023 19:44:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv5374br8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 19:44:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PJiUNL037154;
 Wed, 25 Oct 2023 19:44:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tv5374bqp-1; Wed, 25 Oct 2023 19:44:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/6] Live Update reboot mode
Date: Wed, 25 Oct 2023 12:44:23 -0700
Message-Id: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_09,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250169
X-Proofpoint-ORIG-GUID: _ZGxt1aQ4NVlgHaBDmx8yBU8kEvFbzPi
X-Proofpoint-GUID: _ZGxt1aQ4NVlgHaBDmx8yBU8kEvFbzPi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a mode migration parameter that can be used to select alternate
migration algorithms.  The default mode is normal, representing the
current migration algorithm, and does not need to be explicitly set.

Provide the cpr-reboot (CheckPoint and Restart) migration mode for live
update, which saves state to a file.  This allows one to quit qemu, reboot
to an updated kernel, install an updated version of qemu, and resume via
the migrate-incoming command.  The caller must specify a migration URI
that writes to and reads from a file, and must set the mode parameter
before invoking the migrate or migrate-incoming commands.

Unlike normal mode, the use of certain local storage options does not block
cpr-reboot mode, but the caller must not modify guest block devices between
the quit and restart.  To avoid saving guest RAM to the state file, the memory
backend must be shared, and the @x-ignore-shared migration capability must
be set.

Guest RAM must be non-volatile across reboot, which can be achieved by
backing it with a dax device, or /dev/shm PKRAM as proposed in
https://lore.kernel.org/lkml/1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com
but this is not enforced.  The restarted qemu arguments must match those used
to initially start qemu, plus the -incoming option.

This patch series contains minimal functionality.  Future patches will enhance
reboot mode by preserving vfio devices for suspended guests.  They will also
add a new mode for updating qemu using the exec system call, which will keep
vfio devices and certain character devices alive.

Here is an example of updating the host kernel using reboot mode.

window 1                                        | window 2
                                                |
# qemu-system-$arch -monitor stdio              |
  mem-path=/dev/dax0.0 ...                      |
QEMU 8.1.50 monitor - type 'help' for more info |
(qemu) info status                              |
VM status: running                              |
                                                | # yum update kernel-uek
(qemu) migrate_set_capability x-ignore-shared on|
(qemu) migrate_set_parameter mode cpr-reboot    |
(qemu) migrate -d file:vm.state                 |
(qemu) info status                              |
VM status: paused (postmigrate)                 |
(qemu) quit                                     |
                                                |
# systemctl kexec                               |
kexec_core: Starting new kernel                 |
...                                             |
                                                |
# qemu-system-$arch -monitor stdio              |
  mem-path=/dev/dax0.0 -incoming defer ...      |
QEMU 8.1.50 monitor - type 'help' for more info |
(qemu) info status                              |
VM status: paused (inmigrate)                   |
(qemu) migrate_set_capability x-ignore-shared on|
(qemu) migrate_set_parameter mode cpr-reboot    |
(qemu) migrate_incoming file:vm.state           |
(qemu) info status                              |
VM status: running                              |

Changes in V2:
  - moved "migration mode" code and comments to more appropriate places
  - clarified the behavior of non-shared-memory backends
  - split blocker patches and reverted some blockers
  - added a test

Steve Sistare (6):
  migration: mode parameter
  migration: per-mode blockers
  cpr: relax blockdev migration blockers
  cpr: relax vhost migration blockers
  cpr: reboot mode
  tests/qtest: migration: add reboot mode test

 block/parallels.c                   |  2 +-
 block/qcow.c                        |  2 +-
 block/vdi.c                         |  2 +-
 block/vhdx.c                        |  2 +-
 block/vmdk.c                        |  2 +-
 block/vpc.c                         |  2 +-
 block/vvfat.c                       |  2 +-
 hw/core/qdev-properties-system.c    | 14 ++++++
 hw/scsi/vhost-scsi.c                |  2 +-
 hw/virtio/vhost.c                   |  2 +-
 include/hw/qdev-properties-system.h |  4 ++
 include/migration/blocker.h         | 44 +++++++++++++++--
 include/migration/misc.h            |  1 +
 migration/migration-hmp-cmds.c      |  9 ++++
 migration/migration.c               | 95 ++++++++++++++++++++++++++++++++-----
 migration/options.c                 | 21 ++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 40 ++++++++++++++--
 stubs/migr-blocker.c                | 10 ++++
 tests/qtest/migration-test.c        | 27 +++++++++++
 20 files changed, 255 insertions(+), 29 deletions(-)

-- 
1.8.3.1


