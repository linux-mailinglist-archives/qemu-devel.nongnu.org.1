Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BAA82725E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrHL-00013Z-Sb; Mon, 08 Jan 2024 10:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMrHB-00010N-Ig
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:10:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMrH6-0007kI-IG
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:10:51 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408F5kKH025336; Mon, 8 Jan 2024 15:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=T4bDj8pr4zvAa8IoXSojRHKGw9qR10IC4Am5NtP6Ozg=;
 b=So4rc+QUTalbvWFNkobGqmjt0qnHjs+NEB53kqa9caj2yVpb6N8JHt3mU5p+DgCQpK7S
 VKk7oKnAP8Yqnr/qGuZX3UJxrYLgdI0a3XNFQIi+Xu1xDXt/fMj4DqkA6OHU9xGMAG49
 3jsfA3jNl81IBFx6IMgqWeYggdj3GsuU0O8IZXr67tqI8ET/5kTQ2CRrPKRg9Nfi+XU4
 dMHEcvLsFx6kUjY0SayC4HffS23BLBIQJExIoHjTb5MD4bxtjlIvvOx/pUOLxDx3fADG
 73q4Gl+9KpQqHnRmubc2qTSS+hfe3ahsh8Nd9AnWC7EJeEtGaP7Z8nXHvmro4fD7sJED 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgkcx80b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 15:10:38 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 408EhUOi035136; Mon, 8 Jan 2024 15:10:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuu316g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 15:10:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408FAX6O024665;
 Mon, 8 Jan 2024 15:10:36 GMT
Received: from linux-3.us.oracle.com (dhcp-10-154-155-225.vpn.oracle.com
 [10.154.155.225])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vfuu316bm-3; Mon, 08 Jan 2024 15:10:36 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com
Subject: [PATCH v1 2/2] oslib-posix: initialize backend memory objects in
 parallel
Date: Mon,  8 Jan 2024 09:10:41 -0600
Message-Id: <20240108151041.529716-3-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108151041.529716-1-mark.kanda@oracle.com>
References: <20240108151041.529716-1-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_06,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080130
X-Proofpoint-GUID: wM_di7bos4co6voKuOppZLGqxbGARK75
X-Proofpoint-ORIG-GUID: wM_di7bos4co6voKuOppZLGqxbGARK75
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
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

QEMU initializes preallocated backend memory as the objects are parsed from
the command line. This is not optimal in some cases (e.g. memory spanning
multiple numa nodes) because the memory objects are initialized in series.

Allow the initialization to occur in parallel. The performance increase is
significant and scales with the number of objects. On a 2 socket Skylake VM
with 128GB and 2 init threads per socket (256GB total), the memory init time
decreases from ~27 seconds to ~14 seconds.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
---
 include/qemu/osdep.h |  6 ++++++
 system/vl.c          |  2 ++
 util/oslib-posix.c   | 46 +++++++++++++++++++++++++++++++++-----------
 util/oslib-win32.c   |  5 +++++
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index d30ba73eda..57185e6309 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -682,6 +682,12 @@ typedef struct ThreadContext ThreadContext;
 void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
                        ThreadContext *tc, Error **errp);
 
+/**
+ * Wait for any outstanding memory prealloc initialization
+ * to complete.
+ */
+void wait_mem_prealloc_init(void);
+
 /**
  * qemu_get_pid_name:
  * @pid: pid of a process
diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..9e04acbb2c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2010,6 +2010,8 @@ static void qemu_create_late_backends(void)
 
     object_option_foreach_add(object_create_late);
 
+    wait_mem_prealloc_init();
+
     if (tpm_init() < 0) {
         exit(1);
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 293297ac6c..667d2d960c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -91,6 +91,7 @@ static QemuMutex sigbus_mutex;
 
 static QemuMutex page_mutex;
 static QemuCond page_cond;
+static bool prealloc_init;
 
 int qemu_get_thread_id(void)
 {
@@ -487,6 +488,12 @@ static int wait_mem_prealloc(void)
 {
     int i, ret = 0;
     MemsetContext *context, *next_context;
+
+    /* Return if memory prealloc isn't enabled or active */
+    if (QLIST_EMPTY(&memset_contexts) || !prealloc_init) {
+        return 0;
+    }
+
     qemu_mutex_lock(&page_mutex);
     QLIST_FOREACH(context, &memset_contexts, next) {
         context->all_threads_created = true;
@@ -553,21 +560,23 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
         }
 
         qemu_mutex_lock(&sigbus_mutex);
-        memset(&act, 0, sizeof(act));
+        if (!sigbus_oldact.sa_handler) {
+            memset(&act, 0, sizeof(act));
 #ifdef CONFIG_LINUX
-        act.sa_sigaction = &sigbus_handler;
-        act.sa_flags = SA_SIGINFO;
+            act.sa_sigaction = &sigbus_handler;
+            act.sa_flags = SA_SIGINFO;
 #else /* CONFIG_LINUX */
-        act.sa_handler = &sigbus_handler;
-        act.sa_flags = 0;
+            act.sa_handler = &sigbus_handler;
+            act.sa_flags = 0;
 #endif /* CONFIG_LINUX */
 
-        ret = sigaction(SIGBUS, &act, &sigbus_oldact);
-        if (ret) {
-            qemu_mutex_unlock(&sigbus_mutex);
-            error_setg_errno(errp, errno,
-                "qemu_prealloc_mem: failed to install signal handler");
-            return;
+            ret = sigaction(SIGBUS, &act, &sigbus_oldact);
+            if (ret) {
+                qemu_mutex_unlock(&sigbus_mutex);
+                error_setg_errno(errp, errno,
+                    "qemu_prealloc_mem: failed to install signal handler");
+                return;
+            }
         }
     }
 
@@ -589,6 +598,21 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     }
 }
 
+void wait_mem_prealloc_init(void)
+{
+    /*
+     * Set prealloc_init true to make wait_mem_prealloc() wait for the
+     * initialization to complete.
+     */
+    prealloc_init = true;
+
+    /* Wait for any outstanding init to complete */
+    if (wait_mem_prealloc()) {
+        perror("wait_mem_prealloc_init: failed waiting for memory prealloc");
+        exit(1);
+    }
+}
+
 char *qemu_get_pid_name(pid_t pid)
 {
     char *name = NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 55b0189dc3..72e050bee1 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -276,6 +276,11 @@ void qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     }
 }
 
+void wait_mem_prealloc_init(void)
+{
+    /* not supported */
+}
+
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
2.39.3


