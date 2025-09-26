Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC7BA3BEA
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 15:02:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27uP-0004z6-FU; Fri, 26 Sep 2025 08:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27uG-0004st-WE; Fri, 26 Sep 2025 08:50:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27u5-0007bJ-GT; Fri, 26 Sep 2025 08:50:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 909C3157F65;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 006C0290F23;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 29/38] target/sparc: Loosen decode of RDWIM for v7
Date: Fri, 26 Sep 2025 15:45:29 +0300
Message-ID: <20250926124540.2221746-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 5d617bfba07 ("target/sparc: Move RDWIM, RDPR to decodetree")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit dc9678cc9725d6c3053c6f110f162d956eb9d48f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1c6403ad8a..77b2f54fdf 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -180,26 +180,28 @@ RESTORED            10 00001 110001 00000 0 0000000000000
 # UA2005 INVALW
 
 {
-  RDWIM             10 rd:5  101010 00000 0 0000000000000
-  RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
+  [
+    RDPR_tpc            10 rd:5  101010 00000 0 0000000000000
+    RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
+    RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
+    RDPR_tt             10 rd:5  101010 00011 0 0000000000000
+    RDPR_tick           10 rd:5  101010 00100 0 0000000000000
+    RDPR_tba            10 rd:5  101010 00101 0 0000000000000
+    RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
+    RDPR_tl             10 rd:5  101010 00111 0 0000000000000
+    RDPR_pil            10 rd:5  101010 01000 0 0000000000000
+    RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
+    RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
+    RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
+    RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
+    RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
+    RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
+    RDPR_gl             10 rd:5  101010 10000 0 0000000000000
+    RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
+    RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+  ]
+  RDWIM                 10 rd:5  101010 ----- - -------------
 }
-RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
-RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
-RDPR_tt             10 rd:5  101010 00011 0 0000000000000
-RDPR_tick           10 rd:5  101010 00100 0 0000000000000
-RDPR_tba            10 rd:5  101010 00101 0 0000000000000
-RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
-RDPR_tl             10 rd:5  101010 00111 0 0000000000000
-RDPR_pil            10 rd:5  101010 01000 0 0000000000000
-RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
-RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
-RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
-RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
-RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
-RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
-RDPR_gl             10 rd:5  101010 10000 0 0000000000000
-RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
-RDPR_ver            10 rd:5  101010 11111 0 0000000000000
 
 {
   WRWIM             10 00000 110010 ..... . .............  @n_r_ri
-- 
2.47.3


