Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC17D8986
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6ev-0004EW-U1; Thu, 26 Oct 2023 16:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6eq-000481-6s
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6el-0008SE-40
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsVph003943; Thu, 26 Oct 2023 20:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=6IngbwvX5QRx2Ju6S7ksW7OMH5fcan0CqFrRSV+XBCM=;
 b=wCt8fylQshFRG8AiNzHNp+peqQFR+fvC/Ahkjxg4J61E+fLY+bL40h3y69TkJhuuGq0L
 SkINDd60EonPJOjW4e7TbAdMQtRmLv1TIhsPJ/fq2cVNB+wCbPFqLi/pj2baaYOXtJ60
 ryMMyU0AP7TW8EbIt65CgRwMG27jrHKBq3II+CVCemRaH2BdrSSRiric9KQ7+jJBW3Ci
 BYuGH4o3ITT/v4v8bycgs2tRVImKeT40B3E5CdiVr7q8eO+TS04ZZymPPiMbFKpdtsFW
 TJQaKk6DWTV4AqVB7K5zaSErW0hz2TivGXCn7Hgk1RZUAM/yMgxd9WGSCXVFd9QEJ6Jt Ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx4tg35p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:36 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImnCf009247; Thu, 26 Oct 2023 20:08:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhtyn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:36 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QK8YLr036361;
 Thu, 26 Oct 2023 20:08:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tywqhtykn-4; Thu, 26 Oct 2023 20:08:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/6] cpr: relax blockdev migration blockers
Date: Thu, 26 Oct 2023 13:08:30 -0700
Message-Id: <1698350913-415926-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
References: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=766 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-GUID: vMkXvOf6Cp-h63VksiU2tlxx90APD7zY
X-Proofpoint-ORIG-GUID: vMkXvOf6Cp-h63VksiU2tlxx90APD7zY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Some blockdevs block migration because they do not support sharing across
hosts and/or do not support dirty bitmaps.  These prohibitions do not apply
if the old and new qemu processes do not run concurrently, and if new qemu
starts on the same host as old, which is the case for cpr.  Narrow the scope
of these blockers so they only apply to normal mode.  They will not block
cpr modes when they are added in subsequent patches.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 block/parallels.c | 2 +-
 block/qcow.c      | 2 +-
 block/vdi.c       | 2 +-
 block/vhdx.c      | 2 +-
 block/vmdk.c      | 2 +-
 block/vpc.c       | 2 +-
 block/vvfat.c     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

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
-- 
1.8.3.1


