Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AF7708CB
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IS-0000OR-1y; Fri, 04 Aug 2023 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IP-0000No-H2; Fri, 04 Aug 2023 15:17:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IO-0006xN-0S; Fri, 04 Aug 2023 15:17:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 659FE1845A;
 Fri,  4 Aug 2023 22:17:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EA7741B89D;
 Fri,  4 Aug 2023 22:16:50 +0300 (MSK)
Received: (nullmailer pid 1875711 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 40/63] target/arm: Avoid writing to constant TCGv in
 trans_CSEL()
Date: Fri,  4 Aug 2023 22:16:23 +0300
Message-Id: <20230804191647.1875608-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 0b188ea05acb5 we changed the implementation of
trans_CSEL() to use tcg_constant_i32(). However, this change
was incorrect, because the implementation of the function
sets up the TCGv_i32 rn and rm to be either zero or else
a TCG temp created in load_reg(), and these TCG temps are
then in both cases written to by the emitted TCG ops.
The result is that we hit a TCG assertion:

qemu-system-arm: ../../tcg/tcg.c:4455: tcg_reg_alloc_mov: Assertion `!temp_readonly(ots)' failed.

(or on a non-debug build, just produce a garbage result)

Adjust the code so that rn and rm are always writeable
temporaries whether the instruction is using the special
case "0" or a normal register as input.

Cc: qemu-stable@nongnu.org
Fixes: 0b188ea05acb5 ("target/arm: Use tcg_constant in trans_CSEL")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230727103906.2641264-1-peter.maydell@linaro.org
(cherry picked from commit 2b0d656ab6484cae7f174e194215a6d50343ecd2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..1e4d94e58a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8814,7 +8814,7 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 /* v8.1M CSEL/CSINC/CSNEG/CSINV */
 static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    TCGv_i32 rn, rm, zero;
+    TCGv_i32 rn, rm;
     DisasCompare c;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
@@ -8832,16 +8832,17 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     /* In this insn input reg fields of 0b1111 mean "zero", not "PC" */
-    zero = tcg_constant_i32(0);
+    rn = tcg_temp_new_i32();
+    rm = tcg_temp_new_i32();
     if (a->rn == 15) {
-        rn = zero;
+        tcg_gen_movi_i32(rn, 0);
     } else {
-        rn = load_reg(s, a->rn);
+        load_reg_var(s, rn, a->rn);
     }
     if (a->rm == 15) {
-        rm = zero;
+        tcg_gen_movi_i32(rm, 0);
     } else {
-        rm = load_reg(s, a->rm);
+        load_reg_var(s, rm, a->rm);
     }
 
     switch (a->op) {
@@ -8861,7 +8862,7 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     arm_test_cc(&c, a->fcond);
-    tcg_gen_movcond_i32(c.cond, rn, c.value, zero, rn, rm);
+    tcg_gen_movcond_i32(c.cond, rn, c.value, tcg_constant_i32(0), rn, rm);
 
     store_reg(s, a->rd, rn);
     return true;
-- 
2.39.2


