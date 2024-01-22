Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A05836855
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:33:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwHe-00010m-6T; Mon, 22 Jan 2024 10:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHZ-0000z0-BS
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHV-0006sS-9S
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MAZEaY029125; Mon, 22 Jan 2024 15:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=IynG/NBuY4d9L1p27cCjnKQsiQ5xcJ4D+hGyS0isUog=;
 b=C/qNxMei17KLzQhctCu0wISC4SZizrKSbeo77et/C4nFeTRt/xVUAA4oADG1nRCTwrdA
 2qRCzz4ujGHXSsRZ2SAAyT30z4R2qjRIXkj+2u4qG1koq4SBf8QbqG8cIpaLmgGUkpnv
 mHKheYo1IGcPi3Kqw5yzvbqNP1uzId3X3HMsqlxYYa5uz346/Ard52kijlQUSHG327KW
 3qXdzL9hqNj01k2Z2ZDpmlrLVHkuzwrOlVELyHeDYjIa/QpH8cbLIDa8jamIHHbEfTRG
 PMwo5br/F8HU+7bLIJXudUTo9iJp+hsJnF6MriwfMQyfTLm95oxXgI3JBn0jbNqCzNDc PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ankukx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:10 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40MFCX7X004194; Mon, 22 Jan 2024 15:32:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs32paysd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MFRHlN010298;
 Mon, 22 Jan 2024 15:32:08 GMT
Received: from linux-3.us.oracle.com (dhcp-10-154-125-89.vpn.oracle.com
 [10.154.125.89])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vs32payn2-2; Mon, 22 Jan 2024 15:32:08 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v2 1/2] oslib-posix: refactor memory prealloc threads
Date: Mon, 22 Jan 2024 09:32:18 -0600
Message-Id: <20240122153219.2885749-2-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122153219.2885749-1-mark.kanda@oracle.com>
References: <20240122153219.2885749-1-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220106
X-Proofpoint-GUID: wddP5tB0A_c8uv0Bf4wDPc4yCuBNkCIj
X-Proofpoint-ORIG-GUID: wddP5tB0A_c8uv0Bf4wDPc4yCuBNkCIj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Refactor the memory prealloc threads support:
- Make memset context a global qlist
- Move the memset thread join/cleanup code to a separate routine

This is functionally equivalent and facilitates multiple memset contexts
(used in a subsequent patch).

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
---
 util/oslib-posix.c | 90 ++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7c297003b9..26bf2f2883 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -63,11 +63,15 @@
 
 struct MemsetThread;
 
+static QLIST_HEAD(, MemsetContext) memset_contexts =
+    QLIST_HEAD_INITIALIZER(memset_contexts);
+
 typedef struct MemsetContext {
     bool all_threads_created;
     bool any_thread_failed;
     struct MemsetThread *threads;
     int num_threads;
+    QLIST_ENTRY(MemsetContext) next;
 } MemsetContext;
 
 struct MemsetThread {
@@ -417,14 +421,15 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
                            bool use_madv_populate_write)
 {
     static gsize initialized = 0;
-    MemsetContext context = {
-        .num_threads = get_memset_num_threads(hpagesize, numpages, max_threads),
-    };
+    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
     size_t numpages_per_thread, leftover;
     void *(*touch_fn)(void *);
-    int ret = 0, i = 0;
+    int i = 0;
     char *addr = area;
 
+    context->num_threads =
+        get_memset_num_threads(hpagesize, numpages, max_threads);
+
     if (g_once_init_enter(&initialized)) {
         qemu_mutex_init(&page_mutex);
         qemu_cond_init(&page_cond);
@@ -433,7 +438,7 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
 
     if (use_madv_populate_write) {
         /* Avoid creating a single thread for MADV_POPULATE_WRITE */
-        if (context.num_threads == 1) {
+        if (context->num_threads == 1) {
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
                 return -errno;
@@ -445,49 +450,65 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         touch_fn = do_touch_pages;
     }
 
-    context.threads = g_new0(MemsetThread, context.num_threads);
-    numpages_per_thread = numpages / context.num_threads;
-    leftover = numpages % context.num_threads;
-    for (i = 0; i < context.num_threads; i++) {
-        context.threads[i].addr = addr;
-        context.threads[i].numpages = numpages_per_thread + (i < leftover);
-        context.threads[i].hpagesize = hpagesize;
-        context.threads[i].context = &context;
+    context->threads = g_new0(MemsetThread, context->num_threads);
+    numpages_per_thread = numpages / context->num_threads;
+    leftover = numpages % context->num_threads;
+    for (i = 0; i < context->num_threads; i++) {
+        context->threads[i].addr = addr;
+        context->threads[i].numpages = numpages_per_thread + (i < leftover);
+        context->threads[i].hpagesize = hpagesize;
+        context->threads[i].context = context;
         if (tc) {
-            thread_context_create_thread(tc, &context.threads[i].pgthread,
+            thread_context_create_thread(tc, &context->threads[i].pgthread,
                                          "touch_pages",
-                                         touch_fn, &context.threads[i],
+                                         touch_fn, &context->threads[i],
                                          QEMU_THREAD_JOINABLE);
         } else {
-            qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
-                               touch_fn, &context.threads[i],
+            qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
+                               touch_fn, &context->threads[i],
                                QEMU_THREAD_JOINABLE);
         }
-        addr += context.threads[i].numpages * hpagesize;
+        addr += context->threads[i].numpages * hpagesize;
     }
 
     if (!use_madv_populate_write) {
-        sigbus_memset_context = &context;
+        sigbus_memset_context = context;
+    }
+
+    QLIST_INSERT_HEAD(&memset_contexts, context, next);
+
+    return 0;
+}
+
+static int wait_mem_prealloc(void)
+{
+    int i, ret = 0;
+    MemsetContext *context, *next_context;
+
+    if (QLIST_EMPTY(&memset_contexts)) {
+        return ret;
     }
 
     qemu_mutex_lock(&page_mutex);
-    context.all_threads_created = true;
+    QLIST_FOREACH(context, &memset_contexts, next) {
+        context->all_threads_created = true;
+    }
     qemu_cond_broadcast(&page_cond);
     qemu_mutex_unlock(&page_mutex);
 
-    for (i = 0; i < context.num_threads; i++) {
-        int tmp = (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
+    QLIST_FOREACH_SAFE(context, &memset_contexts, next, next_context) {
+        for (i = 0; i < context->num_threads; i++) {
+            int tmp =
+                (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
 
-        if (tmp) {
-            ret = tmp;
+            if (tmp) {
+                ret = tmp;
+            }
         }
+        QLIST_REMOVE(context, next);
+        g_free(context->threads);
+        g_free(context);
     }
-
-    if (!use_madv_populate_write) {
-        sigbus_memset_context = NULL;
-    }
-    g_free(context.threads);
-
     return ret;
 }
 
@@ -546,8 +567,16 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
         error_setg_errno(errp, -ret,
                          "qemu_prealloc_mem: preallocating memory failed");
         rv = false;
+        goto err;
     }
 
+    ret = wait_mem_prealloc();
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "qemu_prealloc_mem: failed waiting for memory prealloc");
+        rv = false;
+    }
+err:
     if (!use_madv_populate_write) {
         ret = sigaction(SIGBUS, &sigbus_oldact, NULL);
         if (ret) {
@@ -556,6 +585,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
             exit(1);
         }
         qemu_mutex_unlock(&sigbus_mutex);
+        sigbus_memset_context = NULL;
     }
     return rv;
 }
-- 
2.39.3


