Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E339972669C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wTw-00020P-UY; Wed, 07 Jun 2023 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cd66eebe393958cf2f111e98de69c4802faa58a9@lizzy.crudebyte.com>)
 id 1q6wTu-0001we-Pr
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cd66eebe393958cf2f111e98de69c4802faa58a9@lizzy.crudebyte.com>)
 id 1q6wTs-0001lr-Mi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=uhr/QmtZd9O1Z9jieerdnbSge6I2pe0tO4skmJxCtEE=; b=J4zqr
 et5yGN/f1JrfpfR3MkyQ+084ncEGlN1BzPPHLTNd7/z2dlwAmSEriimR0ZXboAMn+kJCEkvLbBVt2
 9ag7FBcylOAdRqQxckUURUSR6BIGBx8WW7dejT+plNaLmIzOoRIgAESHsDu+8mI/wrM6PZeQxspah
 KklURU7o1sqHfg7kT4W3eRsx9C7pkXKTQCggOlyr+yVDcup0viqh62SeBdesluwEHHgjx2jjfdnhZ
 9EPCYWTcwvIRdOrkL46FgsGFN2B+LRsHngqNyJ8SPRJ79BgQWpE9sMMchrBebB8fy7jqBOztwrRVt
 w7KXsyS5KNiyOcfmEh5tF47s5dgFg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 7 Jun 2023 18:29:33 +0200
Subject: [PATCH v4] 9pfs: prevent opening special files (CVE-2023-2861)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn, Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <E1q6w7r-0000Q0-NM@lizzy.crudebyte.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=cd66eebe393958cf2f111e98de69c4802faa58a9@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 v3 -> v4:
 - Rename function check_is_regular_file_or_dir() ->
   close_if_special_file() and add detailed API comment.
 - Minor code style fix on open_regular().

 fsdev/virtfs-proxy-helper.c | 27 +++++++++++++++++++++++--
 hw/9pfs/9p-util.h           | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

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
2.30.2


