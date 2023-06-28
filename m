Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A437414F2
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX6A-0004QP-U4; Wed, 28 Jun 2023 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX69-0004PT-4m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:28:49 -0400
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX67-0005A7-6d
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:28:48 -0400
X-QQ-mid: bizesmtp72t1687966069tmqlnmkx
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:27:48 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: hvKw+PyJ8U7RjaySGGyFw+oMJe+/6zgEDwZMqVXUjA1W39vtXjC1xN2WiE9J5
 2flQK+Q45p9P2HSK22klOny9VuMZ51HSGfh1qTBjIDSfqZgVVWzv5WFJL4H/YsS+2D1tuBC
 vo3CW+f+ST36LV5bXE+mQciSUWVgmnpPpl+t4Z43RI+1njXU0HkzEU48i8Ph5fkKGdfkS8P
 dNp75uieNUwLwfyavhrs+8hmaHpUFxEpSbrDInjysJ5/xQCTqasB+q9th3CkZI0GmXaEr1m
 AqxvGXR67qCjU/+S3Z5e0Op+ZRjkO/z4AGRFO8JiKKKald7SYLzug6qYyj09lZT/UfRuY3Z
 JnX4i0C8dsnoofqAHjbqEdm0+NQYVF3ESWPIgFbl3vzx6lhUp3svwD6XIJAa+uf30ue8CEi
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13845974076954433580
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 6/6] net: tap: Use qemu_close_range() to close fds
Date: Wed, 28 Jun 2023 23:27:26 +0800
Message-Id: <20230628152726.110295-7-bmeng@tinylab.org>
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

Current codes using a brute-force traversal of all file descriptors
do not scale on a system where the maximum number of file descriptors
is set to a very large value (e.g.: in a Docker container of Manjaro
distribution it is set to 1073741816). QEMU just looks frozen during
start-up.

The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
doesn't need to manually close the fds for child process as the proper
O_CLOEXEC flag should have been set properly on files with its own
codes, QEMU uses a huge number of 3rd party libraries and we don't
trust them to reliably be using O_CLOEXEC on everything they open.

Modern Linux and BSDs have the close_range() call we can use to do the
job, and on Linux we have one more way to walk through /proc/self/fd
to complete the task efficiently, which is what qemu_close_range() does.

Reported-by: Zhangjin Wu <falcon@tinylab.org>
Co-developed-by: Bin Meng <bmeng@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---

Changes in v4:
- put fd on its own line

Changes in v2:
- Change to use qemu_close_range() to close fds for child process efficiently
- v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng@tinylab.org/

 net/tap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 1bf085d422..9f080215f0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -446,13 +446,13 @@ static void launch_script(const char *setup_script, const char *ifname,
         return;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
+        unsigned int last_fd = sysconf(_SC_OPEN_MAX) - 1;
+
+        /* skip stdin, stdout and stderr */
+        qemu_close_range(3, fd - 1);
+        /* skip the currently used fd */
+        qemu_close_range(fd + 1, last_fd);
 
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
         parg = args;
         *parg++ = (char *)setup_script;
         *parg++ = (char *)ifname;
@@ -536,16 +536,16 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         return -1;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
+        unsigned int last_fd = sysconf(_SC_OPEN_MAX) - 1;
+        unsigned int fd = sv[1];
         char *fd_buf = NULL;
         char *br_buf = NULL;
         char *helper_cmd = NULL;
 
-        for (i = 3; i < open_max; i++) {
-            if (i != sv[1]) {
-                close(i);
-            }
-        }
+        /* skip stdin, stdout and stderr */
+        qemu_close_range(3, fd - 1);
+        /* skip the currently used fd */
+        qemu_close_range(fd + 1, last_fd);
 
         fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
 
-- 
2.34.1


