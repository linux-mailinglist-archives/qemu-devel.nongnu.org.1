Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C370C96E918
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 07:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRLb-0004DY-5H; Fri, 06 Sep 2024 01:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRL3-0003uU-Uk; Fri, 06 Sep 2024 01:16:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRKy-0007jg-Tm; Fri, 06 Sep 2024 01:16:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 547938C117;
 Fri,  6 Sep 2024 08:15:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0240713335D;
 Fri,  6 Sep 2024 08:16:34 +0300 (MSK)
Received: (nullmailer pid 10393 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniyal Khan <danikhan632@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 03/40] target/arm: Use FPST_F16 for SME FMOPA
 (widening)
Date: Fri,  6 Sep 2024 08:15:51 +0300
Message-Id: <20240906051633.10288-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
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

This operation has float16 inputs and thus must use
the FZ16 control not the FZ control.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reported-by: Daniyal Khan <danikhan632@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240717060149.204788-3-richard.henderson@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2374
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 207d30b5fdb5b45a36f26eefcf52fe2c1714dd4f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate-sme.c b/target/arm/translate-sme.c
index 65f8495bdd..8cce34e117 100644
--- a/target/arm/translate-sme.c
+++ b/target/arm/translate-sme.c
@@ -340,6 +340,7 @@ static bool do_outprod(DisasContext *s, arg_op *a, MemOp esz,
 }
 
 static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
+                            ARMFPStatusFlavour e_fpst,
                             gen_helper_gvec_5_ptr *fn)
 {
     int svl = streaming_vec_reg_size(s);
@@ -355,7 +356,7 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
     pm = pred_full_reg_ptr(s, a->pm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(e_fpst);
 
     fn(za, zn, zm, pn, pm, fpst, tcg_constant_i32(desc));
 
@@ -367,9 +368,12 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a, MO_32, gen_helper_sme_fmopa_h)
-TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, gen_helper_sme_fmopa_s)
-TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a, MO_64, gen_helper_sme_fmopa_d)
+TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a,
+           MO_32, FPST_FPCR_F16, gen_helper_sme_fmopa_h)
+TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
+           MO_32, FPST_FPCR, gen_helper_sme_fmopa_s)
+TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
+           MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
 /* TODO: FEAT_EBF16 */
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_bfmopa)
-- 
2.39.2


