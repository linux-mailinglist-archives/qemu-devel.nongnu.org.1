Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA97414ED
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX5J-0003JK-Gp; Wed, 28 Jun 2023 11:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX59-0003H9-UN
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:27:48 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qEX57-0004z4-MU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:27:47 -0400
X-QQ-mid: bizesmtp72t1687966056teq41a0n
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Jun 2023 23:27:35 +0800 (CST)
X-QQ-SSF: 00200000000000F0G000000A0000000
X-QQ-FEAT: +ynUkgUhZJlHv263HMmQjaNSQYOpeqA2KWbXdM1LY1fnpjS+VRDXhX3BgyEra
 iXoo0fHNjirvCCsIclcS8NbNRihttc+41zZGAm8vFCep34VMtt2EqcWr8Yv0jU0MyiZX2vv
 IK1/xFTfcYFXwxQudpUfDXySXBcjMpIZAdz221ShcRxCz9HIstMqyIf3Ne7jeMhpmc3LH6Y
 2QYVJUxa9rycgPCw8znGi9F+ndfakSLNDPn+IAU7UNTN0+/VrseOT7VSiubYzJ6kvEaRGi6
 XlmvKM98MFCVvLI9XanAmWA5XSkKmp90529UCzgMfKquPHO69o+Gxjp6HgihVrm7QpjysPJ
 yNC7xClFBWAEBlnI3E7abpWQehGGVa+C1UUk5SI4hDCNr3jQgE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8344174067842687383
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v4 2/6] tests/tcg/cris: Correct the off-by-one error
Date: Wed, 28 Jun 2023 23:27:22 +0800
Message-Id: <20230628152726.110295-3-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628152726.110295-1-bmeng@tinylab.org>
References: <20230628152726.110295-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

sysconf(_SC_OPEN_MAX) returns the maximum number of files that
a process can have open at any time, which means the fd should
not be larger than or equal to the return value.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---

(no changes since v2)

Changes in v2:
- new patch: "tests/tcg/cris: Correct the off-by-one error"

 tests/tcg/cris/libc/check_openpf5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/cris/libc/check_openpf5.c b/tests/tcg/cris/libc/check_openpf5.c
index 0037fbca4c..7f585c6d37 100644
--- a/tests/tcg/cris/libc/check_openpf5.c
+++ b/tests/tcg/cris/libc/check_openpf5.c
@@ -31,10 +31,10 @@ int main(int argc, char *argv[])
     strcpy(fn, "/");
     strcat(fn, argv[0]);
 
-    for (i = 0; i < filemax + 1; i++) {
+    for (i = 0; i < filemax; i++) {
         if (open(fn, O_RDONLY) < 0) {
             /* Shouldn't happen too early.  */
-            if (i < filemax - 3 - 1) {
+            if (i < filemax - 3) {
                 fprintf(stderr, "i: %d\n", i);
                 abort();
             }
-- 
2.34.1


