Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 025407414EE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX5o-0003PY-Eh; Wed, 28 Jun 2023 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX5j-0003Ow-Gb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:28:23 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX5h-00054W-Jg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:28:23 -0400
X-QQ-mid: bizesmtp72t1687966063txy5lbs1
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:27:41 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: uGhnJwy6xZL0JhD88Z/CAM3kvUKefY+l+7qT39yqnAoGg2KyjtsuqtdiiyEXg
 NbaU3YDPwBOnvebkI2I40saDZ1P5ev98mAnRTD3eg2/1CVNTjnxsP2oArsM35WkpsQWs/iB
 moa4+rLFzbKM5Ak00xAYVmjLYjCdC7/JJtbI/qQFzFoBUYt5jrArFoqOt/2TkAgYvi7EUVJ
 dscsaEoKn+uiXIeuP93q3YPnxcEXC9i657Z7DyJD8yuWE+01DjfDDSPIV1szndqPBL4OFLk
 SXV17au1j4Hus4ormNqgbGmofAERGuWoOZR3L9v9zYouIRnVboNNsk6gGVGDnzUiLpeIVw1
 qZKRTXiA3b7jZTRTXmZG4Z0gwNG93l0yxtkkq92iXiiF+gfK+/7SdZqc/jGxQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1278064396760589535
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xuzhou Cheng <xuzhou.cheng@windriver.com>
Subject: [PATCH v4 4/6] util/osdep: Introduce qemu_close_range()
Date: Wed, 28 Jun 2023 23:27:24 +0800
Message-Id: <20230628152726.110295-5-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628152726.110295-1-bmeng@tinylab.org>
References: <20230628152726.110295-1-bmeng@tinylab.org>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Changes in v4:
- add 'first > last' check logic
- reorder the ifdefs logic
- change i to unsigned int type
- use qemu_strtoi() instead of atoi()
- limit last upper value to sysconf(_SC_OPEN_MAX) - 1

Changes in v3:
- fix win32 build failure

Changes in v2:
- new patch: "util/osdep: Introduce qemu_close_range()"

 include/qemu/osdep.h |  1 +
 util/osdep.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index e996c4744a..1d8c719b3f 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -411,6 +411,66 @@ int qemu_close(int fd)
     return close(fd);
 }
 
+int qemu_close_range(unsigned int first, unsigned int last)
+{
+    if (first > last) {
+        errno = EINVAL;
+        return -1;
+    }
+
+#ifndef _WIN32
+    if (last >= sysconf(_SC_OPEN_MAX)) {
+        last = sysconf(_SC_OPEN_MAX) - 1;
+    }
+#endif
+
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(first, last, 0);
+    if (!r) {
+        /* Success, no need to try other ways */
+        return 0;
+    }
+#endif
+
+#ifdef __linux__
+    DIR *dir = opendir("/proc/self/fd");
+    if (dir) {
+        /* Avoid closing the directory */
+        int dfd = dirfd(dir);
+
+        for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
+            int fd, ret;
+
+            ret = qemu_strtoi(de->d_name, NULL, 10, &fd);
+            if (ret) {
+                /* skip "." and ".." */
+                continue;
+            }
+            if (fd < first || fd > last) {
+                /* Exclude the fds outside the target range */
+                continue;
+            }
+            if (fd != dfd) {
+                close(fd);
+            }
+        }
+        closedir(dir);
+
+        return 0;
+    }
+#endif
+
+    /*
+     * If /proc is not mounted or /proc/self/fd is not supported,
+     * try close() from first to last.
+     */
+    for (unsigned int i = first; i <= last; i++) {
+        close(i);
+    }
+
+    return 0;
+}
+
 /*
  * Delete a file from the filesystem, unless the filename is /dev/fdset/...
  *
-- 
2.34.1


