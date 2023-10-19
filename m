Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737F7D0353
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZw8-0007MN-4X; Thu, 19 Oct 2023 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvz-0007Ft-44
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvu-0003UH-R6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKi2x3018410; Thu, 19 Oct 2023 20:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Z+8UkLXHCexLBhyfXs689DSS20WcqOi1euY/xjYqLm8=;
 b=o3OGZevt4kKqquCNb6jLXkXuvzTTHknz64phkFUem8FJjWT6fmKdJUNwa7EPcsK+Xd7w
 mV13SL2vToa77gP1ZUUkIpr02IcNcD6muZ07YdPnXrOSHBoU/lf1xis9+wpdttXoLK4D
 zV9S64d3neJCA7pE9zzDCqxhudR/Cl37SQ2/QLf0/O8NFp7b9uDLBVzTPz/OEX6PgMTD
 54zE2TDEZVJqwa6i8AV9WRX/EMZsNIxOiglNY5SEdrwgWFhKKr9nj8nbBfDMgLvyWlMP
 g8SXTQXODmA8QT9tvc3xId+EFp/lkE3MFHUNIA/+qoMzkdo7utR9Z9NG8d+KPHHEZBlq rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bukcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:53 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JJiVAU040584; Thu, 19 Oct 2023 20:47:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyqqakg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKllWM014514;
 Thu, 19 Oct 2023 20:47:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyqqafy-4; Thu, 19 Oct 2023 20:47:52 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 3/4] cpr: relax some blockers
Date: Thu, 19 Oct 2023 13:47:45 -0700
Message-Id: <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190176
X-Proofpoint-GUID: B5DWqqBRlkM8LI8lC05VXd5rrfLpeKKa
X-Proofpoint-ORIG-GUID: B5DWqqBRlkM8LI8lC05VXd5rrfLpeKKa
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

Some devices block migration because they rely on local state that
is not migrated to the target host, such as for local filesystems.
These need not block cpr, which will restart qemu on the same host.
Narrow the scope of these blockers so they only apply to normal mode.
They will not block cpr modes when they are added in subsequent patches.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/tpm/tpm_emulator.c | 2 +-
 block/parallels.c           | 2 +-
 block/qcow.c                | 2 +-
 block/vdi.c                 | 2 +-
 block/vhdx.c                | 2 +-
 block/vmdk.c                | 2 +-
 block/vpc.c                 | 2 +-
 block/vvfat.c               | 2 +-
 hw/9pfs/9p.c                | 2 +-
 hw/scsi/vhost-scsi.c        | 2 +-
 hw/virtio/vhost.c           | 2 +-
 target/i386/nvmm/nvmm-all.c | 3 ++-
 12 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index bf1a90f..ac66aee 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -534,7 +534,7 @@ static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
         error_setg(&tpm_emu->migration_blocker,
                    "Migration disabled: TPM emulator does not support "
                    "migration");
-        if (migrate_add_blocker(&tpm_emu->migration_blocker, &err) < 0) {
+        if (migrate_add_blocker_normal(&tpm_emu->migration_blocker, &err) < 0) {
             error_report_err(err);
             return -1;
         }
diff --git a/block/parallels.c b/block/parallels.c
index 1697a2e..8a520db 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1369,7 +1369,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         error_setg(errp, "Migration blocker error");
         goto fail;
diff --git a/block/qcow.c b/block/qcow.c
index fdd4c83..eab68e3 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -307,7 +307,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vdi.c b/block/vdi.c
index fd7e365..c647d72 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -498,7 +498,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail_free_bmap;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index e37f8c0..a9d0874 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1096,7 +1096,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 1335d39..85864b8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1386,7 +1386,7 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vpc.c b/block/vpc.c
index c30cf86..aa1a48a 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -452,7 +452,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index 266e036..9d050ba 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1268,7 +1268,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                    "The vvfat (rw) format used by node '%s' "
                    "does not support live migration",
                    bdrv_get_device_or_node_name(bs));
-        ret = migrate_add_blocker(&s->migration_blocker, errp);
+        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
         if (ret < 0) {
             goto fail;
         }
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index af636cf..369dfc8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1501,7 +1501,7 @@ static void coroutine_fn v9fs_attach(void *opaque)
         error_setg(&s->migration_blocker,
                    "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
                    s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
-        err = migrate_add_blocker(&s->migration_blocker, NULL);
+        err = migrate_add_blocker_normal(&s->migration_blocker, NULL);
         if (err < 0) {
             clunk_fid(s, fid);
             goto out;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 14e23cc..bf528d5 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
                 "When external environment supports it (Orchestrator migrates "
                 "target SCSI device state or use shared storage over network), "
                 "set 'migratable' property to true to enable migration.");
-        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
+        if (migrate_add_blocker_normal(&vsc->migration_blocker, errp) < 0) {
             goto free_virtio;
         }
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d737671..f5e9625 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1527,7 +1527,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     if (hdev->migration_blocker != NULL) {
-        r = migrate_add_blocker(&hdev->migration_blocker, errp);
+        r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
             goto fail_busyloop;
         }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 7d752bc..0cfcdac 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -929,7 +929,8 @@ nvmm_init_vcpu(CPUState *cpu)
         error_setg(&nvmm_migration_blocker,
             "NVMM: Migration not supported");
 
-        if (migrate_add_blocker(&nvmm_migration_blocker, &local_error) < 0) {
+        ret = migrate_add_blocker_normal(&nvmm_migration_blocker, &local_error);
+        if (ret < 0) {
             error_report_err(local_error);
             return -EINVAL;
         }
-- 
1.8.3.1


