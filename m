Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE02C8CFA2A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 09:30:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUjN-0007z9-QU; Mon, 27 May 2024 03:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUiq-0007fM-AY; Mon, 27 May 2024 03:24:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUin-0006Ap-OT; Mon, 27 May 2024 03:24:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F240C6A4BF;
 Mon, 27 May 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2F89FD845C;
 Mon, 27 May 2024 10:24:35 +0300 (MSK)
Received: (nullmailer pid 52875 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 02/21] target/sparc: Fix FEXPAND
Date: Mon, 27 May 2024 10:24:12 +0300
Message-Id: <20240527072435.52812-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a 2-operand instruction, not 3-operand.
Worse, we took the source from the wrong operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-3-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit 7b616f36de0bde126e1ba6b0793ed26fc414a1ff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..6e718da8ca 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -125,7 +125,7 @@ DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2d26404cb2..e2d8a07dc4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -352,7 +352,7 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
-    FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
+    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_r2
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..6c204da2ae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4589,6 +4589,25 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_df(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i64, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = tcg_temp_new_i64();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FEXPAND, VIS1, do_df, a, gen_helper_fexpand)
+
 static bool do_env_df(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
@@ -4848,7 +4867,6 @@ TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
-TRANS(FEXPAND, VIS1, do_ddd, a, gen_helper_fexpand)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7763b16c24..db2e6dd6c1 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -260,13 +260,13 @@ uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fexpand(uint64_t src1, uint64_t src2)
+uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
     VIS64 d;
 
-    s.l = (uint32_t)src1;
-    d.ll = src2;
+    s.l = src2;
+    d.ll = 0;
     d.VIS_W64(0) = s.VIS_B32(0) << 4;
     d.VIS_W64(1) = s.VIS_B32(1) << 4;
     d.VIS_W64(2) = s.VIS_B32(2) << 4;
-- 
2.39.2


