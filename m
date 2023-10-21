Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA747D1B41
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ed-0003Mw-6V; Sat, 21 Oct 2023 01:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eY-0003KE-Ps
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:02 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eW-0001AW-BS
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:02 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3af609c4dfeso1054178b6e.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866558; x=1698471358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9RlYjd39ntouf7hPUOdyU/Qywc9Z9jeRpzjr/dBnsc=;
 b=MYWhB/fJfXEiRMpfby7j2V6ECBEMxV3MT4rQU+zgKRQx2XvjdanKY1Murkk/UnflhP
 bvdi5odMObkjR1hzjjcNptqp0EvIjaO9hbadnw4LlqAxva4uUO7XX/ZmT6H0N6XNh5/a
 +hd+qxPWLsdo59LPT8NyiSz/zvtd773uveUah9w2EMa9xxIWx3DWnxMR0LHVxWA8QEuQ
 tIyr7WiBefwAwWYJQQFxXsnj/49R927zaplv8uYa8x5Fq//rPnStdSdwlBppcqPkNNJ9
 o9q9e0A8erCCdkKe3HkEjBfnTtU5GCMYpt/IFXJewNOHIL27c7h7Qg0+DDx+di9HvGu9
 uBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866558; x=1698471358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9RlYjd39ntouf7hPUOdyU/Qywc9Z9jeRpzjr/dBnsc=;
 b=M8fLoZtb6LN4sgfmNXtVrZgHLtAiI7KVHDmnM9ZA7kdWEYHZyAlwcTYYEPGZFNO4p0
 GE1L0E/fmLE5HVtLgST4h6l5jo4iN5OtuStDoZV5W/9TNHnoIEk235qIlqFAXpnO3r2k
 gPGneXpSYjHK5VboHobU5SiwRtEJAstJYa6GgDtvB0eAUOWoxGSxuJ9/ONnGpxTX+8Vt
 P2OTRDj3sXnIcIqahGatrk4e2mrPyb07HAK/EMkhgzZaDmkxlY5HUKD4nvGpN9AOkeR3
 S8zIwNtoIM0xyzIEcHqPqZ2CnqLNICRp68WU8tWzzLYnP1b71Cl3gQLRypmY0RZTjOBa
 9LWQ==
X-Gm-Message-State: AOJu0Yz8LPuqDgPHO6X2r0dAG5b87sgKFXHNCAAY9vZSkDsqtH86Omyq
 rEjrCEsjAfYmbrRQfz6J38rEhjEQWa63qbJeDko=
X-Google-Smtp-Source: AGHT+IEvGKMKZy5NepfWXSqIdN0f1AueqqIiKb6ZWTwlkj7WA3hVTYnYmjP5EVBqM3xklfUo0NLj3w==
X-Received: by 2002:a05:6808:1141:b0:3ab:870d:2d49 with SMTP id
 u1-20020a056808114100b003ab870d2d49mr5342120oiu.8.1697866557976; 
 Fri, 20 Oct 2023 22:35:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 70/90] target/sparc: Move gen_fop_FF insns to decodetree
Date: Fri, 20 Oct 2023 22:31:38 -0700
Message-Id: <20231021053158.278135-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move FSQRTs, FiTOs, FsTOi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 47 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4e15bfacfb..76186bddf0 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -245,6 +245,9 @@ FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index fccfe1d53e..f6d6e8b746 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1650,20 +1650,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_FF(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4923,6 +4909,27 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_env_ff(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tcg_env, tmp);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
+TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
+TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -5084,10 +5091,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2: /* V9 fmovd */
                 case 0x6: /* V9 fnegd */
                 case 0xa: /* V9 fabsd */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
-                    break;
+                case 0xc4: /* fitos */
+                case 0xd1: /* fstoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
                     gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
                     break;
@@ -5143,9 +5150,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
                     break;
-                case 0xc4: /* fitos */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fitos);
-                    break;
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
@@ -5175,9 +5179,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd1: /* fstoi */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fstoi);
-                    break;
                 case 0xd2: /* fdtoi */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
                     break;
-- 
2.34.1


