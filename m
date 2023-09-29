Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A67B2EB9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dg-0005Ca-KL; Fri, 29 Sep 2023 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DU-00051z-M4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bz-QJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fo3sgQUoq1v/rXQDfdnS796xPwOPol/7CVX97Dogeq8=;
 b=TibOjdtLQUTBIiTTXeUOv4sI7jAwuvLNUuJlCg2byizpKYo5fBWwUGTfGDpA0dDzKszwDR
 p0dCh3YQ6wJWwTQa4+1CcJ7EBtauvYs1iLsBXyIq9l3BldqY2PXqkbdpbiJ/dej7Mfly78
 xonO0MGdbuEvWIuOsGkP+JlCGjG3zr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-trWVRLUMOdCuyehyScSo0A-1; Fri, 29 Sep 2023 04:50:56 -0400
X-MC-Unique: trWVRLUMOdCuyehyScSo0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABEC3811E7E;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DDF810F1BE7;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F4FD21E6914; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/56] target/mips: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:08 +0200
Message-ID: <20230929085053.2789105-12-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  target/mips/tcg/nanomips_translate.c.inc:4410:33: error: declaration shadows a local variable [-Werror,-Wshadow]
                        int32_t imm = extract32(ctx->opcode, 1, 13) |
                                ^
  target/mips/tcg/nanomips_translate.c.inc:3577:9: note: previous declaration is here
    int imm;
        ^
  target/mips/tcg/translate.c:15578:19: error: declaration shadows a local variable [-Werror,-Wshadow]
    for (unsigned i = 1; i < 32; i++) {
                  ^
  target/mips/tcg/translate.c:15567:9: note: previous declaration is here
    int i;
        ^
  target/mips/tcg/msa_helper.c:7478:13: error: declaration shadows a local variable [-Werror,-Wshadow]
            MSA_FLOAT_MAXOP(pwx->w[0], min, pws->w[0], pws->w[0], 32);
            ^
  target/mips/tcg/msa_helper.c:7434:23: note: expanded from macro 'MSA_FLOAT_MAXOP'
        float_status *status = &env->active_tc.msa_fp_status;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-5-philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/mips/tcg/msa_helper.c             | 8 ++++----
 target/mips/tcg/translate.c              | 8 +++-----
 target/mips/tcg/nanomips_translate.c.inc | 6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index c314a74397..7a8dbada5d 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -7432,15 +7432,15 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
 #define MSA_FLOAT_MAXOP(DEST, OP, ARG1, ARG2, BITS)                         \
     do {                                                                    \
-        float_status *status = &env->active_tc.msa_fp_status;               \
+        float_status *status_ = &env->active_tc.msa_fp_status;              \
         int c;                                                              \
                                                                             \
-        set_float_exception_flags(0, status);                               \
-        DEST = float ## BITS ## _ ## OP(ARG1, ARG2, status);                \
+        set_float_exception_flags(0, status_);                              \
+        DEST = float ## BITS ## _ ## OP(ARG1, ARG2, status_);               \
         c = update_msacsr(env, 0, 0);                                       \
                                                                             \
         if (get_enabled_exceptions(env, c)) {                               \
-            DEST = ((FLOAT_SNAN ## BITS(status) >> 6) << 6) | c;            \
+            DEST = ((FLOAT_SNAN ## BITS(status_) >> 6) << 6) | c;           \
         }                                                                   \
     } while (0)
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9bb40f1849..26d741d960 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15564,10 +15564,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
 void mips_tcg_init(void)
 {
-    int i;
-
     cpu_gpr[0] = NULL;
-    for (i = 1; i < 32; i++)
+    for (unsigned i = 1; i < 32; i++)
         cpu_gpr[i] = tcg_global_mem_new(cpu_env,
                                         offsetof(CPUMIPSState,
                                                  active_tc.gpr[i]),
@@ -15584,7 +15582,7 @@ void mips_tcg_init(void)
                                                rname);
     }
 #endif /* !TARGET_MIPS64 */
-    for (i = 0; i < 32; i++) {
+    for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
 
         fpu_f64[i] = tcg_global_mem_new_i64(cpu_env, off, fregnames[i]);
@@ -15592,7 +15590,7 @@ void mips_tcg_init(void)
     msa_translate_init();
     cpu_PC = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUMIPSState, active_tc.PC), "PC");
-    for (i = 0; i < MIPS_DSP_ACC; i++) {
+    for (unsigned i = 0; i < MIPS_DSP_ACC; i++) {
         cpu_HI[i] = tcg_global_mem_new(cpu_env,
                                        offsetof(CPUMIPSState, active_tc.HI[i]),
                                        regnames_HI[i]);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index a98dde0d2e..d81a7c2d11 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4407,8 +4407,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_BPOSGE32C:
                     check_dsp_r3(ctx);
                     {
-                        int32_t imm = extract32(ctx->opcode, 1, 13) |
-                                      extract32(ctx->opcode, 0, 1) << 13;
+                        imm = extract32(ctx->opcode, 1, 13)
+                            | extract32(ctx->opcode, 0, 1) << 13;
 
                         gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2,
                                               imm << 1);
@@ -4635,7 +4635,7 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_LI16:
         {
-            int imm = extract32(ctx->opcode, 0, 7);
+            imm = extract32(ctx->opcode, 0, 7);
             imm = (imm == 0x7f ? -1 : imm);
             if (rt != 0) {
                 tcg_gen_movi_tl(cpu_gpr[rt], imm);
-- 
2.41.0


