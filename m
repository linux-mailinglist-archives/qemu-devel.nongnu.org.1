Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E419C733E69
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 07:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAOcW-0003OC-8n; Sat, 17 Jun 2023 01:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOcU-0003Nh-2M
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:37:06 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qAOcS-0006Xe-8U
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 01:37:05 -0400
X-QQ-mid: bizesmtp73t1686980193tu7g7u6w
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 17 Jun 2023 13:36:32 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: rZJGTgY0+YOT3oQmERRSL+DXWsKs2Jcv63KNGwgGy65bHQCMbDNI5X4MYzei9
 p5eWKVFGrxJBR+BhLzCExe7hqX7hGdVrJ1OoCx6NQxsUoY4m56F1O9bUZmKKMMSzU5tUaTE
 7yKL+/MAYSaZ3s7E57uglnL0+H8AcY34D0kaDjlEqo+B0envreyzLRtCanqRbtjZo+wB2R+
 NXJX3RYs+j/Wqk9QhhemKshbU0uPO997tAGHSznNC/uvHujBNiBriQaZyDaSNpPk0W65msX
 nIQKOZaqoa2AszbrNZYuvoJKpomVCfcOTIJ0uPjyGPWWijobI6ZdIfiHh3MmvQ2NMPFutHh
 SVchiRmR7fXk55Vu6V5bwXJOLXPqVLHQS2zupR9DwTJMBkIx0U=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8674422273484162088
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 3/6] util/async-teardown: Fall back to close fds one by one
Date: Sat, 17 Jun 2023 13:36:18 +0800
Message-Id: <20230617053621.50359-4-bmeng@tinylab.org>
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

When opening /proc/self/fd fails, current codes just return directly,
but we can fall back to close fds one by one.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

(no changes since v2)

Changes in v2:
- new patch: "util/async-teardown: Fall back to close fds one by one"

 util/async-teardown.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async-teardown.c b/util/async-teardown.c
index 3ab19c8740..7e0177a8da 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -48,7 +48,11 @@ static void close_all_open_fd(void)
 
     dir = opendir("/proc/self/fd");
     if (!dir) {
-        /* If /proc is not mounted, there is nothing that can be done. */
+        /* If /proc is not mounted, close fds one by one. */
+        int open_max = sysconf(_SC_OPEN_MAX), i;
+        for (i = 0; i < open_max; i++) {
+                close(i);
+        }
         return;
     }
     /* Avoid closing the directory. */
-- 
2.34.1


