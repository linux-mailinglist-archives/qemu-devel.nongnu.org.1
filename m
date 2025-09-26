Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AFDBA3B61
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 14:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27u0-00047c-2u; Fri, 26 Sep 2025 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27ts-0003px-SM; Fri, 26 Sep 2025 08:50:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27tf-0007KU-RU; Fri, 26 Sep 2025 08:50:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50FF6157F62;
 Fri, 26 Sep 2025 15:45:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AB5E2290F20;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 26/38] target/sparc: Loosen decode of STBAR for v8
Date: Fri, 26 Sep 2025 15:45:26 +0300
Message-ID: <20250926124540.2221746-26-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR
instructions when booting a freshly installed image. According
to the SPARC v8 architecture manual, whilst bits 13 and bits 12-0
of the "Read State Register Instructions" are notionally zero,
they are marked as unused (i.e. ignored).

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit b6cdd6c6050567c02a3b3cd428f85bb79d7455aa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9e39d23273..1b1b85e9c2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,7 +88,7 @@ CALL    01 i:s30
 
 {
   [
-    STBAR           10 00000 101000 01111 0 0000000000000
+    STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
     RDCCR           10 rd:5  101000 00010 0 0000000000000
@@ -107,6 +107,17 @@ CALL    01 i:s30
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
     RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
   ]
+
+  # The v8 manual, section B.30 STBAR instruction, says
+  # bits [12:0] are ignored, but bit 13 must be 0.
+  # However, section B.28 Read State Register Instruction has a
+  # comment that RDASR with rs1 = 15, rd = 0 is STBAR.  Here,
+  # bit 13 is also ignored and rd != 0 is merely reserved.
+  #
+  # Solaris 8 executes v9 MEMBAR instruction 0x8143e008 during boot.
+  # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
+  STBAR_v8          10 ----- 101000 01111 - -------------
+
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ddc4154ee3..53183dc609 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2824,12 +2824,15 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
-static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+static bool do_stbar(DisasContext *dc)
 {
     tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
     return advance_pc(dc);
 }
 
+TRANS(STBAR_v8, 32, do_stbar)
+TRANS(STBAR_v9, 64, do_stbar)
+
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
-- 
2.47.3


