Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D99B926E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 14:49:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s12-0004EG-38; Fri, 01 Nov 2024 09:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0x-000492-Kp
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s0v-0002Gz-TN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1DfegV010310;
 Fri, 1 Nov 2024 13:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=jPMk7MCI/w6pg3ewTl45pooOG+03vx9ydl0E4fEeRBA=; b=
 UJ5dUk0LcE0yY1X/4fCUx9Cc4wYrVY5Ruaa3BZlL6k38RZ3h8VyOddcSaau5QYTu
 Bmfy2ppll8pVE/EZvWUQGn5ZAWKFbmNtS0lB4Zs2IWgYy/kuOmSf+eASsnaXB/0M
 zh9hZofNuBwxcpp/KRe8DHsqowTADXE7/bcU0++C4YIsfQx/I3WVG/W1uxxAPrzJ
 877kW7+vuvl6o10RraGLoZJcJeNuy7NUS6gzhvQq+rUj9uHslV+k3MERFfpxvHlH
 s6K/nzZ0xK/W7sexMrHzZJ1YsVkiMlfNTprHSPtGwaG3cYmO3WDVRfz+nRKvA10r
 oazbXvcb/DkJyY2PX0Mdjg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc247gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1AnKHP010118; Fri, 1 Nov 2024 13:48:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOA006031;
 Fri, 1 Nov 2024 13:48:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-6; Fri, 01 Nov 2024 13:48:29 +0000
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
Subject: [PATCH V3 05/16] migration: SCM_RIGHTS for QEMUFile
Date: Fri,  1 Nov 2024 06:47:44 -0700
Message-Id: <1730468875-249970-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: 3hL5kCsFG5tfyk3bo-lcgskGwUjyhsRe
X-Proofpoint-ORIG-GUID: 3hL5kCsFG5tfyk3bo-lcgskGwUjyhsRe
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Define functions to put/get file descriptors to/from a QEMUFile, for qio
channels that support SCM_RIGHTS.  Maintain ordering such that
  put(A), put(fd), put(B)
followed by
  get(A), get(fd), get(B)
always succeeds.  Other get orderings may succeed but are not guaranteed.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
 migration/qemu-file.h  |  2 ++
 migration/trace-events |  2 ++
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6d2f58..7f951ab 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -37,6 +37,11 @@
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
 
+typedef struct FdEntry {
+    QTAILQ_ENTRY(FdEntry) entry;
+    int fd;
+} FdEntry;
+
 struct QEMUFile {
     QIOChannel *ioc;
     bool is_writable;
@@ -51,6 +56,9 @@ struct QEMUFile {
 
     int last_error;
     Error *last_error_obj;
+
+    bool fd_pass;
+    QTAILQ_HEAD(, FdEntry) fds;
 };
 
 /*
@@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
     object_ref(ioc);
     f->ioc = ioc;
     f->is_writable = is_writable;
+    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
+    QTAILQ_INIT(&f->fds);
 
     return f;
 }
@@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     int len;
     int pending;
     Error *local_error = NULL;
+    g_autofree int *fds = NULL;
+    size_t nfd = 0;
+    int **pfds = f->fd_pass ? &fds : NULL;
+    size_t *pnfd = f->fd_pass ? &nfd : NULL;
 
     assert(!qemu_file_is_writable(f));
 
@@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     }
 
     do {
-        len = qio_channel_read(f->ioc,
-                               (char *)f->buf + pending,
-                               IO_BUF_SIZE - pending,
-                               &local_error);
+        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+                                     &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(f->ioc, G_IO_IN);
@@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         qemu_file_set_error_obj(f, len, local_error);
     }
 
+    for (int i = 0; i < nfd; i++) {
+        FdEntry *fde = g_new0(FdEntry, 1);
+        fde->fd = fds[i];
+        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
+    }
+
     return len;
 }
 
+int qemu_file_put_fd(QEMUFile *f, int fd)
+{
+    int ret = 0;
+    QIOChannel *ioc = qemu_file_get_ioc(f);
+    Error *err = NULL;
+    struct iovec iov = { (void *)" ", 1 };
+
+    /*
+     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
+     * fail with a len=0 error.  Flush first to maintain ordering wrt other
+     * data.
+     */
+
+    qemu_fflush(f);
+    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        ret = -1;
+    }
+    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
+    return ret;
+}
+
+int qemu_file_get_fd(QEMUFile *f)
+{
+    int fd = -1;
+    FdEntry *fde;
+
+    if (!f->fd_pass) {
+        Error *err = NULL;
+        error_setg(&err, "%s does not support fd passing", f->ioc->name);
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        goto out;
+    }
+
+    /* Force the dummy byte and its fd passenger to appear. */
+    qemu_peek_byte(f, 0);
+
+    fde = QTAILQ_FIRST(&f->fds);
+    if (fde) {
+        qemu_get_byte(f);       /* Drop the dummy byte */
+        fd = fde->fd;
+        QTAILQ_REMOVE(&f->fds, fde, entry);
+    }
+out:
+    trace_qemu_file_get_fd(f->ioc->name, fd);
+    return fd;
+}
+
 /** Closes the file
  *
  * Returns negative error value if any error happened on previous operations or
@@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
  */
 int qemu_fclose(QEMUFile *f)
 {
+    FdEntry *fde, *next;
     int ret = qemu_fflush(f);
     int ret2 = qio_channel_close(f->ioc, NULL);
     if (ret >= 0) {
         ret = ret2;
     }
+    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
+        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
+        close(fde->fd);
+        g_free(fde);
+    }
     g_clear_pointer(&f->ioc, object_unref);
     error_free(f->last_error_obj);
     g_free(f);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 11c2120..3e47a20 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
+int qemu_file_put_fd(QEMUFile *f, int fd);
+int qemu_file_get_fd(QEMUFile *f);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 5356fb5..345506b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 
 # qemu-file.c
 qemu_file_fclose(void) ""
+qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
+qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
 
 # ram.c
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
-- 
1.8.3.1


