Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA1733E6A
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 07:38:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAOd6-0003gC-8f; Sat, 17 Jun 2023 01:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOd2-0003cc-8z
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:37:40 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOd0-0006bP-Gp
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:37:40 -0400
X-QQ-mid: bizesmtp73t1686980196t9zrj4qw
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 17 Jun 2023 13:36:35 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: zT6n3Y95oi2EiXqmYRonV2F7ggvWOR3fbksb22QYth0Uiiy96y9ja5+IbqwE0
 KoRXvzRVjpLWZSEmEujgLtrRtv5Cgn1KV5XpC8iPcrye4wbEebHi3Oy5YlwmnYx/7hK1vwr
 4Iy/ePuSTcCVkM5YSw9EgMHaxU6LQmamfnDmZOWWn+nF0O7eVRxhJ7IARGi7eVUTlF/6+Ub
 Kc2Dh0vcL4ExbI9vALVqRqQOQmhPhYXRZfHAVuk0kcR5aTAqfMP9LRem+YVV7fWlTFLAuiN
 2sFzjWKC9PNzmSzNlaRhiP+BKAFByIqrGw3WOIWVC5RxCadSzCWFLmgCmopBU8Y1OzegfeY
 UDKJWEUoQzKPzgrHL706po3wQehPIlBGT+LVPJ5IWiZq9k2ngXry3xeMrVMig==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9052436690627796296
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, Alberto Faria <afaria@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: [PATCH v3 4/6] util/osdep: Introduce qemu_close_range()
Date: Sat, 17 Jun 2023 13:36:19 +0800
Message-Id: <20230617053621.50359-5-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617053621.50359-1-bmeng@tinylab.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
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

Changes in v3:
- fix win32 build failure

Changes in v2:
- new patch: "util/osdep: Introduce qemu_close_range()"

 include/qemu/osdep.h |  1 +
 util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
index e996c4744a..91275e70f8 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -30,6 +30,7 @@
 #include "qemu/mprotect.h"
 #include "qemu/hw-version.h"
 #include "monitor/monitor.h"
+#include <dirent.h>
 
 static const char *hw_version = QEMU_HW_VERSION;
 
@@ -411,6 +412,53 @@ int qemu_close(int fd)
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


