Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125557334C8
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABO5-0006Zv-7w; Fri, 16 Jun 2023 11:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABO0-0006VD-Fz
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:16 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qABNy-0000wJ-JB
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:29:16 -0400
X-QQ-mid: bizesmtp84t1686929274t65mp03n
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 16 Jun 2023 23:27:53 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: Gq6/1HjPYVXPLR78nFrOrxm64n8pk9C0+/IzNIXgNqYxTRkuX3ntcB4RxIqsJ
 XOq2cfkCwMtaaYQ6vcS3P+R6rx4IpjylcnjrCvfN0kanPkk0oif7oX9Ia1ri+PyKLd7mSB9
 fNyQCKND3krFrO4qKNY12ps398Ftm+bjO1INDyuSFRL5n5WgnCDZSZQi0AJTpbu4HPE0FNN
 rbXnKfCr1DNQ6TiXFytbCuceogjcz1ymZjng0+7jZqwiexl+Ez7DsCeh7mSV83k3fsstgZA
 OVZgsifN3Lg4T6qWMJKsC3Own8NRvXRj1qf2AxRFHi0KnK0a7eo6Si5gjGvST22oNvkay6y
 qKIwqCgI/XjhdtWLyGSIyCuAEDq+SuY83p4O9xEbEJEOm/L83w=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4659172374281023283
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, David Hildenbrand <david@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: [PATCH v2 4/6] utils/osdep: Introduce qemu_close_range()
Date: Fri, 16 Jun 2023 23:27:35 +0800
Message-Id: <20230616152737.23545-5-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616152737.23545-1-bmeng@tinylab.org>
References: <20230616152737.23545-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This introduces a new QEMU API qemu_close_range() that closes all
open file descriptors from first to last (included).

This API will try a more efficient call to close_range(), or walk
through of /proc/self/fd whenever these are possible, otherwise it
falls back to a plain close loop.

Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 include/qemu/osdep.h |  1 +
 util/osdep.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..e22434ce10 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -560,6 +560,7 @@ int qemu_open_old(const char *name, int flags, ...);
 int qemu_open(const char *name, int flags, Error **errp);
 int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
 int qemu_close(int fd);
+int qemu_close_range(unsigned int first, unsigned int last);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup_flags(int fd, int flags);
diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..fd7dd2dbdf 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -411,6 +411,53 @@ int qemu_close(int fd)
     return close(fd);
 }
 
+int qemu_close_range(unsigned int first, unsigned int last)
+{
+    DIR *dir = NULL;
+
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(first, last, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return 0;
+    }
+#endif
+
+#ifdef __linux__
+    dir = opendir("/proc/self/fd");
+#endif
+    if (!dir) {
+        /*
+         * If /proc is not mounted or /proc/self/fd is not supported,
+         * try close() from first to last.
+         */
+        for (int i = first; i <= last; i++) {
+            close(i);
+        }
+
+        return 0;
+    }
+
+#ifndef _WIN32
+    /* Avoid closing the directory */
+    int dfd = dirfd(dir);
+
+    for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
+        int fd = atoi(de->d_name);
+        if (fd < first || fd > last) {
+            /* Exclude the fds outside the target range */
+            continue;
+        }
+        if (fd != dfd) {
+            close(fd);
+        }
+    }
+    closedir(dir);
+#endif /* _WIN32 */
+
+    return 0;
+}
+
 /*
  * Delete a file from the filesystem, unless the filename is /dev/fdset/...
  *
-- 
2.34.1


