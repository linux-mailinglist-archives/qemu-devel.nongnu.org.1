Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A40823622
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:07:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7W4-0005Jw-M5; Wed, 03 Jan 2024 15:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VP-00057g-7P
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VM-0002ID-NH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:22 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JXJuX017171; Wed, 3 Jan 2024 20:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Mihr5Jscizpg8a8FDyULvmE7P2qbwqkKtvgvSdWyiBc=;
 b=iLueuJt5TpHdebtOkH3EvCKhCeLYTUch2v1oKgWWkuvlDkwTM5oSS02LITx7hpMH7Mj6
 rQiXfNADm9YzPDUUk50MWuCIgLRefVIIdqJIaEMEbWlJb7LbF12eVZzG7PMD36pQH1+K
 LSyy/wgXWetLjP/EnnDvgq5VuX6XI8JKIKCWg1XvtVgjukGe2/ulLpsXh+ebZV7oropj
 N3QHjb3NGvwA8zV4JqMgql5ifwryffUSAkv3qGg0uuwPNYtaKJQOtS3MwekJj0NI5e/V
 lO5AZQxXdiMXRgpVAxe2RyHHjXDJk+E1K05SfSHUoN22sw4j8hcwSZg9MacKYp3eXL4T ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa03wt2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K23WB013830; Wed, 3 Jan 2024 20:05:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZl020511;
 Wed, 3 Jan 2024 20:05:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-6; Wed, 03 Jan 2024 20:05:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 05/12] migration: propagate suspended runstate
Date: Wed,  3 Jan 2024 12:05:34 -0800
Message-Id: <1704312341-66640-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-ORIG-GUID: geF1ZIgjUlyfAIWcrwFDwe5Zpa516rhY
X-Proofpoint-GUID: geF1ZIgjUlyfAIWcrwFDwe5Zpa516rhY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If the outgoing machine was previously suspended, propagate that to the
incoming side via global_state, so a subsequent vm_start restores the
suspended state.  To maintain backward and forward compatibility, reclaim
some space from the runstate member.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/global_state.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8..64a573c 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -22,7 +22,16 @@
 
 typedef struct {
     uint32_t size;
-    uint8_t runstate[100];
+
+    /*
+     * runstate was 100 bytes, zero padded, but we trimmed it to add a
+     * few fields and maintain backwards compatibility.
+     */
+    uint8_t runstate[32];
+    uint8_t has_vm_was_suspended;
+    uint8_t vm_was_suspended;
+    uint8_t unused[66];
+
     RunState state;
     bool received;
 } GlobalState;
@@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
     assert(strlen(state_str) < sizeof(global_state.runstate));
     strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
               state_str, '\0');
+    global_state.has_vm_was_suspended = true;
+    global_state.vm_was_suspended = vm_get_suspended();
+
+    memset(global_state.unused, 0, sizeof(global_state.unused));
 }
 
 void global_state_store(void)
@@ -59,24 +72,7 @@ RunState global_state_get_runstate(void)
 
 static bool global_state_needed(void *opaque)
 {
-    GlobalState *s = opaque;
-    char *runstate = (char *)s->runstate;
-
-    /* If it is not optional, it is mandatory */
-
-    if (migrate_get_current()->store_global_state) {
-        return true;
-    }
-
-    /* If state is running or paused, it is not needed */
-
-    if (strcmp(runstate, "running") == 0 ||
-        strcmp(runstate, "paused") == 0) {
-        return false;
-    }
-
-    /* for any other state it is needed */
-    return true;
+    return migrate_get_current()->store_global_state;
 }
 
 static int global_state_post_load(void *opaque, int version_id)
@@ -93,7 +89,7 @@ static int global_state_post_load(void *opaque, int version_id)
                 sizeof(s->runstate)) == sizeof(s->runstate)) {
         /*
          * This condition should never happen during migration, because
-         * all runstate names are shorter than 100 bytes (the size of
+         * all runstate names are shorter than 32 bytes (the size of
          * s->runstate). However, a malicious stream could overflow
          * the qapi_enum_parse() call, so we force the last character
          * to a NUL byte.
@@ -110,6 +106,14 @@ static int global_state_post_load(void *opaque, int version_id)
     }
     s->state = r;
 
+    /*
+     * global_state is saved on the outgoing side before forcing a stopped
+     * state, so it may have saved state=suspended and vm_was_suspended=0.
+     * Now we are in a paused state, and when we later call vm_start, it must
+     * restore the suspended state, so we must set vm_was_suspended=1 here.
+     */
+    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
+
     return 0;
 }
 
@@ -134,6 +138,9 @@ static const VMStateDescription vmstate_globalstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(size, GlobalState),
         VMSTATE_BUFFER(runstate, GlobalState),
+        VMSTATE_UINT8(has_vm_was_suspended, GlobalState),
+        VMSTATE_UINT8(vm_was_suspended, GlobalState),
+        VMSTATE_BUFFER(unused, GlobalState),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
1.8.3.1


