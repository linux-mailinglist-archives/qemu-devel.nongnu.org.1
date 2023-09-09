Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677E79976E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevDl-0002oH-8f; Sat, 09 Sep 2023 06:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevDg-0002F5-AO; Sat, 09 Sep 2023 06:29:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevDb-0004aN-Vt; Sat, 09 Sep 2023 06:29:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EAD63204A8;
 Sat,  9 Sep 2023 13:29:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 009AA26D06;
 Sat,  9 Sep 2023 13:28:18 +0300 (MSK)
Received: (nullmailer pid 346702 invoked by uid 1000);
 Sat, 09 Sep 2023 10:28:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Ivan Warren <ivan@vmfacility.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 21/34] target/ppc: Fix LQ,
 STQ register-pair order for big-endian
Date: Sat,  9 Sep 2023 13:27:14 +0300
Message-Id: <20230909102747.346522-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

LQ, STQ have the same register-pair ordering as LQARX/STQARX., which is
the even (lower) register contains the most significant bits. This is
not implemented correctly for big-endian.

do_ldst_quad() has variables low_addr_gpr and high_addr_gpr which is
confusing because they are low and high addresses, whereas LQARX/STQARX.
and most such things use the low and high values for lo/hi variables.
The conversion to native 128-bit memory access functions missed this
strangeness.

Fix this by changing the if condition, and change the variable names to
hi/lo to match convention.

Cc: qemu-stable@nongnu.org
Reported-by: Ivan Warren <ivan@vmfacility.fr>
Fixes: 57b38ffd0c6f ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1836
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 718209358f2e4f231cbacf974c3299c4fe7beb83)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index f47f1a50e8..b423c09c26 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -71,7 +71,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 {
 #if defined(TARGET_PPC64)
     TCGv ea;
-    TCGv_i64 low_addr_gpr, high_addr_gpr;
+    TCGv_i64 lo, hi;
     TCGv_i128 t16;
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
@@ -94,21 +94,21 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
     gen_set_access_type(ctx, ACCESS_INT);
     ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
 
-    if (prefixed || !ctx->le_mode) {
-        low_addr_gpr = cpu_gpr[a->rt];
-        high_addr_gpr = cpu_gpr[a->rt + 1];
+    if (ctx->le_mode && prefixed) {
+        lo = cpu_gpr[a->rt];
+        hi = cpu_gpr[a->rt + 1];
     } else {
-        low_addr_gpr = cpu_gpr[a->rt + 1];
-        high_addr_gpr = cpu_gpr[a->rt];
+        lo = cpu_gpr[a->rt + 1];
+        hi = cpu_gpr[a->rt];
     }
     t16 = tcg_temp_new_i128();
 
     if (store) {
-        tcg_gen_concat_i64_i128(t16, low_addr_gpr, high_addr_gpr);
+        tcg_gen_concat_i64_i128(t16, lo, hi);
         tcg_gen_qemu_st_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
     } else {
         tcg_gen_qemu_ld_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
-        tcg_gen_extr_i128_i64(low_addr_gpr, high_addr_gpr, t16);
+        tcg_gen_extr_i128_i64(lo, hi, t16);
     }
 #else
     qemu_build_not_reached();
-- 
2.39.2


