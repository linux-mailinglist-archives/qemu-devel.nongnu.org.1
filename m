Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8615B26D6D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 19:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umba6-0005TD-Fv; Thu, 14 Aug 2025 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba3-0005SU-UL
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba0-0002p3-AU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgEMA002381;
 Thu, 14 Aug 2025 17:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=zLxPi1C1UwPvksw5eo899vW+RJq5qlI4mRosWJfckaI=; b=
 dQwUwG/aoTJOVtzo//O3D83ZZwm2G2iNmR+3R9wC3IGcnDaO8b1QhV4YoYvECMXs
 il8kqy1IjjiMFC7aQxENeog5Qj07PbA7NhWkS9MqqC/DLCebRwZj5bwhJqbX2Gs3
 zn6MAvjbKH1K6Sl1Ey7EqDcSQWGeQRvoqJ27skbVzyKjTxDvQ9ryqYDyc4XH56Hv
 vVsa8GkuXxPDGa7DMslLij+uQ92hSvBXuqIw77yG0hvpwNjBn5j7BGxntZiw23fl
 TW9/kmvDsQvXm2NocRVNEdzVCEByiH+luwwMAmG+MClzV58mhdEgUyLnq3fdmfdi
 6XeQBdpZUbcSMJ0aBwVltg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48h7rmsnk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EFU31N010436; Thu, 14 Aug 2025 17:17:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbry9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwu8038225;
 Thu, 14 Aug 2025 17:17:26 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-2; Thu, 14 Aug 2025 17:17:26 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/9] migration: multi-mode notifier
Date: Thu, 14 Aug 2025 10:17:15 -0700
Message-Id: <1755191843-283480-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0NiBTYWx0ZWRfX5WPbWpJKPRoi
 njDwUQ0Bep+Ipq1A+EJjxPS3pRuaQZ3I6fu6urcBXcW6tjSaRXGntsuLKhVhHaVO8tWD9qohtub
 91ALL14w0QZk1uvJIHb/HQAiK6mrHDii1J4/0bcHQSAzhVJ+W2eHqc5/kA/8geOkDbmseZwSHmR
 UTQeRgnELRbXHKoe6Wlakpp50B6Qt1dYv85T1sAGpEpNsDjqDHBZ1KfwmQB+4iUzOwDcfXIEhAd
 P36nEIm/YMjuZIkbkQe1A/o3DJJ1gGPCqZI/S97ieF62w7/CI8O0zsDY21OzUUCBnffQaqS2e74
 a8ucaiOJx5YegCdMZdr+vzRA1Ta7vKuPz1XO65OBpjaTRcW91FeBhSbGIT28byZ8Fpb/WPFlauG
 3S3nislXjFoUzZXDuv2hF9FIrXnEGCYPnzlSNIKuSMlN5mC6XDOB5Y/6Cdf4NUPs/H/cfRWq
X-Proofpoint-ORIG-GUID: VxfUQirKQpifkvol28RZ7KJlsGVsA7Je
X-Authority-Analysis: v=2.4 cv=UN3dHDfy c=1 sm=1 tr=0 ts=689e1a27 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=5EBYLqYaYwAzse22UuoA:9 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: VxfUQirKQpifkvol28RZ7KJlsGVsA7Je
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow a notifier to be added for multiple migration modes.
To allow a notifier to appear on multiple per-node lists, use
a generic list type.  We can no longer use NotifierWithReturnList,
because it shoe horns the notifier onto a single list.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h | 12 ++++++++++
 migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a261f99..592b930 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
+/*
+ * Same as migration_add_notifier, but applies to all @mode in the argument
+ * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
+ * the notifier is added for all modes.
+ */
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...);
+
+/*
+ * Remove a notifier from all modes.
+ */
 void migration_remove_notifier(NotifierWithReturn *notify);
+
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/migration/migration.c b/migration/migration.c
index 49d1e7d..271c521 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -74,11 +74,7 @@
 
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
-static NotifierWithReturnList migration_state_notifiers[] = {
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
-};
+static GSList *migration_state_notifiers[MIG_MODE__MAX];
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1666,23 +1662,51 @@ void migration_cancel(void)
     }
 }
 
+static int get_modes(MigMode mode, va_list ap);
+
+static void add_notifiers(NotifierWithReturn *notify, int modes)
+{
+    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (modes & BIT(mode)) {
+            migration_state_notifiers[mode] =
+                g_slist_prepend(migration_state_notifiers[mode], notify);
+        }
+    }
+}
+
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...)
+{
+    int modes;
+    va_list ap;
+
+    va_start(ap, mode);
+    modes = get_modes(mode, ap);
+    va_end(ap);
+
+    notify->notify = (NotifierWithReturnFunc)func;
+    add_notifiers(notify, modes);
+}
+
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+    migration_add_notifier_modes(notify, func, mode, -1);
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
+    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
-        notifier_with_return_remove(notify);
+        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+            migration_blockers[mode] =
+                g_slist_remove(migration_state_notifiers[mode], notify);
+        }
         notify->notify = NULL;
     }
 }
@@ -1692,13 +1716,23 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
+    NotifierWithReturn *notifier;
+    GSList *elem, *next;
     int ret;
 
     e.type = type;
-    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
-                                           &e, errp);
-    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
-    return ret;
+
+    for (elem = migration_state_notifiers[mode]; elem; elem = next) {
+        next = elem->next;
+        notifier = (NotifierWithReturn *)elem->data;
+        ret = notifier->notify(notifier, &e, errp);
+        if (ret) {
+            assert(type == MIG_EVENT_PRECOPY_SETUP);
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 bool migration_has_failed(MigrationState *s)
-- 
1.8.3.1


