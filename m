Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D007414F3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX6d-0005rk-Hg; Wed, 28 Jun 2023 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX6b-0005jj-SH
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:17 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX6Z-0005Kx-J2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:17 -0400
X-QQ-mid: bizesmtp72t1687966059twph72m8
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:27:38 +0800 (CST)
X-QQ-SSF: 01200000000000F0G000000A0000000
X-QQ-FEAT: eSZ1CZgv+JCZ8G2fmkeRtne/bwO71AkfsFqcRzVwtOLT9g+ZQA+dZbEkgRLYs
 MQD/YyUBXGaQ/3Dbop11VZd62CDIz3rIIy37+8d/SturWFUK1S3pjyWNC4GUSnNU8v4JQJH
 OgQI/GMFAg/esvHyaxkrEHLjiigUy7DgMW9jmy6PJYygZUCmi7ShvldH04kar2uij+jtnm9
 ZUi22QJgY25TBV1NfWakwYAkoY0UUrouzDks7RQU8BipUNpHB7YFghdLzTelPsQXklQ5kae
 Lw0r+vviS03W/IdGx5pJDpdFSUHvCwBWcrE3XbK/Bj3kKy17N4oxy+/aVZelmSFuwldX1Ce
 vrUafgNAijTjRiQdaXZII821tpr66SJoQ+aEO20lo2nK3DJSTriJNfJ1KJnNw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2859246573490842033
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 3/6] util/async-teardown: Fall back to close fds one by one
Date: Wed, 28 Jun 2023 23:27:23 +0800
Message-Id: <20230628152726.110295-4-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628152726.110295-1-bmeng@tinylab.org>
References: <20230628152726.110295-1-bmeng@tinylab.org>
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

When opening /proc/self/fd fails, current codes just return directly,
but we can fall back to close fds one by one.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---
- feel free to drop this patch if it does not make too much sense

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


