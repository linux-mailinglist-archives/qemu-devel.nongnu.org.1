Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4273EA95
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrMS-0001zj-76; Mon, 26 Jun 2023 14:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrKq-0000n2-Qp; Mon, 26 Jun 2023 14:53:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrKo-0005L6-Gd; Mon, 26 Jun 2023 14:53:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BCF46EF36;
 Mon, 26 Jun 2023 21:50:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0000CF7C5;
 Mon, 26 Jun 2023 21:50:22 +0300 (MSK)
Received: (nullmailer pid 1574052 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Yanwu Shen <ywsPlz@gmail.com>, Jietao Xiao <shawtao1125@gmail.com>,
 Jinku Li <jkli@xidian.edu.cn>, Wenbo Shen <shenwenbo@zju.edu.cn>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 31/54] 9pfs: prevent opening special files
 (CVE-2023-2861)
Date: Mon, 26 Jun 2023 21:49:38 +0300
Message-Id: <20230626185002.1573836-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

The 9p protocol does not specifically define how server shall behave when
client tries to open a special file, however from security POV it does
make sense for 9p server to prohibit opening any special file on host side
in general. A sane Linux 9p client for instance would never attempt to
open a special file on host side, it would always handle those exclusively
on its guest side. A malicious client however could potentially escape
from the exported 9p tree by creating and opening a device file on host
side.

With QEMU this could only be exploited in the following unsafe setups:

  - Running QEMU binary as root AND 9p 'local' fs driver AND 'passthrough'
    security model.

or

  - Using 9p 'proxy' fs driver (which is running its helper daemon as
    root).

These setups were already discouraged for safety reasons before,
however for obvious reasons we are now tightening behaviour on this.

Fixes: CVE-2023-2861
Reported-by: Yanwu Shen <ywsPlz@gmail.com>
Reported-by: Jietao Xiao <shawtao1125@gmail.com>
Reported-by: Jinku Li <jkli@xidian.edu.cn>
Reported-by: Wenbo Shen <shenwenbo@zju.edu.cn>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <E1q6w7r-0000Q0-NM@lizzy.crudebyte.com>
(cherry picked from commit f6b0de53fb87ddefed348a39284c8e2f28dc4eda)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 5cafcd7703..d9511f429c 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -26,6 +26,7 @@
 #include "qemu/xattr.h"
 #include "9p-iov-marshal.h"
 #include "hw/9pfs/9p-proxy.h"
+#include "hw/9pfs/9p-util.h"
 #include "fsdev/9p-iov-marshal.h"
 
 #define PROGNAME "virtfs-proxy-helper"
@@ -338,6 +339,28 @@ static void resetugid(int suid, int sgid)
     }
 }
 
+/*
+ * Open regular file or directory. Attempts to open any special file are
+ * rejected.
+ *
+ * returns file descriptor or -1 on error
+ */
+static int open_regular(const char *pathname, int flags, mode_t mode)
+{
+    int fd;
+
+    fd = open(pathname, flags, mode);
+    if (fd < 0) {
+        return fd;
+    }
+
+    if (close_if_special_file(fd) < 0) {
+        return -1;
+    }
+
+    return fd;
+}
+
 /*
  * send response in two parts
  * 1) ProxyHeader
@@ -682,7 +705,7 @@ static int do_create(struct iovec *iovec)
     if (ret < 0) {
         goto unmarshal_err_out;
     }
-    ret = open(path.data, flags, mode);
+    ret = open_regular(path.data, flags, mode);
     if (ret < 0) {
         ret = -errno;
     }
@@ -707,7 +730,7 @@ static int do_open(struct iovec *iovec)
     if (ret < 0) {
         goto err_out;
     }
-    ret = open(path.data, flags);
+    ret = open_regular(path.data, flags, 0);
     if (ret < 0) {
         ret = -errno;
     }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index c314cf381d..df1b583a5e 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_9P_UTIL_H
 #define QEMU_9P_UTIL_H
 
+#include "qemu/error-report.h"
+
 #ifdef O_PATH
 #define O_PATH_9P_UTIL O_PATH
 #else
@@ -95,6 +97,7 @@ static inline int errno_to_dotl(int err) {
 #endif
 
 #define qemu_openat     openat
+#define qemu_fstat      fstat
 #define qemu_fstatat    fstatat
 #define qemu_mkdirat    mkdirat
 #define qemu_renameat   renameat
@@ -108,6 +111,38 @@ static inline void close_preserve_errno(int fd)
     errno = serrno;
 }
 
+/**
+ * close_if_special_file() - Close @fd if neither regular file nor directory.
+ *
+ * @fd: file descriptor of open file
+ * Return: 0 on regular file or directory, -1 otherwise
+ *
+ * CVE-2023-2861: Prohibit opening any special file directly on host
+ * (especially device files), as a compromised client could potentially gain
+ * access outside exported tree under certain, unsafe setups. We expect
+ * client to handle I/O on special files exclusively on guest side.
+ */
+static inline int close_if_special_file(int fd)
+{
+    struct stat stbuf;
+
+    if (qemu_fstat(fd, &stbuf) < 0) {
+        close_preserve_errno(fd);
+        return -1;
+    }
+    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
+        error_report_once(
+            "9p: broken or compromised client detected; attempt to open "
+            "special file (i.e. neither regular file, nor directory)"
+        );
+        close(fd);
+        errno = ENXIO;
+        return -1;
+    }
+
+    return 0;
+}
+
 static inline int openat_dir(int dirfd, const char *name)
 {
     return qemu_openat(dirfd, name,
@@ -142,6 +177,10 @@ again:
         return -1;
     }
 
+    if (close_if_special_file(fd) < 0) {
+        return -1;
+    }
+
     serrno = errno;
     /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
      * do that with O_PATH since fcntl(F_SETFL) isn't supported, and openat()
-- 
2.39.2


