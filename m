Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0A7D0355
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZw8-0007NG-Hx; Thu, 19 Oct 2023 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvx-0007F7-Bf
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvt-0003SH-3T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKigFH019248; Thu, 19 Oct 2023 20:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=EeLS0knyndViJ2fyxcNsjRT5McE9V6nIPhfcBe0C4tk=;
 b=l1d9g339asQwSeYhSuswkyHfdllOOyIcctI7TM5IdtLm8X8JHvLvG4W4WRLrQEsNNgRJ
 LvJag78KOjj0MOt+eLAU8kCktDLblJTuody5Phxwmoy7Ih4N9iqupI+2GX5r5fcyipyv
 214/T7+MFavUTMURH04L1Ngh2dSDiZ6+KRx2pLQSlscmm4/vAclD9ljpdrgdySBxCVKY
 5CLfEr34NUVo2sms3+NTaVi3H6QFqt9VCnUyNfeza4oD0xincdYRKKEQvGVg7S4VZHND
 OZu9ubiy73wzKd1Db5OJ+ysEBGnT+/dXHXAOqYK0fbliWn+jXvY5sRBm1Mz4NeHp0Tzk AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bukc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JJUXZ7040437; Thu, 19 Oct 2023 20:47:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyqqagu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKllWG014514;
 Thu, 19 Oct 2023 20:47:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyqqafy-1; Thu, 19 Oct 2023 20:47:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/4] Live Update reboot mode
Date: Thu, 19 Oct 2023 13:47:42 -0700
Message-Id: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190176
X-Proofpoint-GUID: aAErt1S6ZjJP2h33CVBrWYP07cznXdp6
X-Proofpoint-ORIG-GUID: aAErt1S6ZjJP2h33CVBrWYP07cznXdp6
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

Provide the cpr-reboot migration mode for live update, which saves state to
a file.  This allows one to quit qemu, reboot to an updated kernel, install
an updated version of qemu, and resume via the migrate-incoming command.
The caller must specify a migration URI that writes to and reads from a file,
and must set the mode parameter before invoking the migrate or migrate-incoming
commands.

Unlike normal mode, the use of certain local storage options does not block
cpr-reboot mode, but the caller must not modify guest block devices between
the quit and restart.  The guest RAM memory-backend must be shared, and the
@x-ignore-shared migration capability must be set, to avoid saving RAM to the
file.  Guest RAM must be non-volatile across reboot, which can be achieved by
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

Steve Sistare (4):
  migration: mode parameter
  migration: per-mode blockers
  cpr: relax some blockers
  cpr: reboot mode

 backends/tpm/tpm_emulator.c         |  2 +-
 block/parallels.c                   |  2 +-
 block/qcow.c                        |  2 +-
 block/vdi.c                         |  2 +-
 block/vhdx.c                        |  2 +-
 block/vmdk.c                        |  2 +-
 block/vpc.c                         |  2 +-
 block/vvfat.c                       |  2 +-
 hw/9pfs/9p.c                        |  2 +-
 hw/core/qdev-properties-system.c    | 12 +++++
 hw/scsi/vhost-scsi.c                |  2 +-
 hw/virtio/vhost.c                   |  2 +-
 include/hw/qdev-properties-system.h |  4 ++
 include/migration/blocker.h         | 44 +++++++++++++++--
 include/migration/misc.h            |  1 +
 migration/migration-hmp-cmds.c      |  8 ++++
 migration/migration.c               | 95 ++++++++++++++++++++++++++++++++-----
 migration/options.c                 | 21 ++++++++
 migration/options.h                 |  1 +
 qapi/migration.json                 | 41 ++++++++++++++--
 stubs/migr-blocker.c                | 10 ++++
 target/i386/nvmm/nvmm-all.c         |  3 +-
 22 files changed, 230 insertions(+), 32 deletions(-)

-- 
1.8.3.1


