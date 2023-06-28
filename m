Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71687414F8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX78-0007ef-Gn; Wed, 28 Jun 2023 11:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX76-0007Wy-7B
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:48 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX74-0005SO-8Q
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:47 -0400
X-QQ-mid: bizesmtp72t1687966066twpgsy9m
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:27:45 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: 5q30pvLz2icAGFkF82a5M/N8UMRBKLiaGF0AAETKyxVxLH0r8oR/LEEqUoh3d
 7wBLICrGCN1GC2PEGPl7rfq62a7Hhz9aJaN5S47mBJIzswVE1XgYQmxkOIZXAwS2fQQ19TE
 ODzxTBzNJ8d8MTCkzK1G4V1yY/kqmrOymiKEpvVOQhywngiLzMpbN0z2Y7O3wabqDCPCAKf
 s2VJNmidFWeF4iMTppwxtCOubGCYQCyqDh1vv9tiLFYUF1cTeZTjl7teQIpAt6r1Q40ILOA
 NhgOZgHElF/so8qQVv8syAXLFwB8FWOIIY0PI/ziO3b/QjhilxHpLUyL0dUovNpWsC6yx65
 xQIn3cTEgg7ntARjyzA6arUsbf3+lhaO5SOjDxmNZRBUOPxuRMZhgF29MFL5A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11925419786260877323
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 5/6] util/async-teardown: Use qemu_close_range() to close
 fds
Date: Wed, 28 Jun 2023 23:27:25 +0800
Message-Id: <20230628152726.110295-6-bmeng@tinylab.org>
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

From: Zhangjin Wu <falcon@tinylab.org>

Based on the old close_all_open_fd() of util/async-teardown.c, a new
generic qemu_close_range() has been added in osdep.c.

Now, let's switch over to use the generic qemu_close_range().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

Changes in v4:
- call sysconf directly instead of using a variable

Changes in v3:
- limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)

Changes in v2:
- new patch: "util/async-teardown: Use qemu_close_range() to close fds"

 util/async-teardown.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/util/async-teardown.c b/util/async-teardown.c
index 7e0177a8da..a038a255ff 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -29,44 +29,6 @@
 
 static pid_t the_ppid;
 
-/*
- * Close all open file descriptors.
- */
-static void close_all_open_fd(void)
-{
-    struct dirent *de;
-    int fd, dfd;
-    DIR *dir;
-
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
-    dir = opendir("/proc/self/fd");
-    if (!dir) {
-        /* If /proc is not mounted, close fds one by one. */
-        int open_max = sysconf(_SC_OPEN_MAX), i;
-        for (i = 0; i < open_max; i++) {
-                close(i);
-        }
-        return;
-    }
-    /* Avoid closing the directory. */
-    dfd = dirfd(dir);
-
-    for (de = readdir(dir); de; de = readdir(dir)) {
-        fd = atoi(de->d_name);
-        if (fd != dfd) {
-            close(fd);
-        }
-    }
-    closedir(dir);
-}
-
 static void hup_handler(int signal)
 {
     /* Check every second if this process has been reparented. */
@@ -92,9 +54,8 @@ static int async_teardown_fn(void *arg)
     /*
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
-     * Not using close_range for increased compatibility with older kernels.
      */
-    close_all_open_fd();
+    qemu_close_range(0, sysconf(_SC_OPEN_MAX) - 1);
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
-- 
2.34.1


