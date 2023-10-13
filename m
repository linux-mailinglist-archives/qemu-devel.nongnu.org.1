Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE17C8F35
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmC-0001vq-Ka; Fri, 13 Oct 2023 17:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm8-0001TF-7X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:52 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm6-0001Xb-6D
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:51 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c7bbfb7a73so1610678a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232769; x=1697837569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bSA2//wrqrp9x+dBDbiScNjiAckPEW5NolyefyLY70=;
 b=qYDpdYyyPlS06mURkFHcd6vzGLPffh3i+ejZ0oJiwwgS406hozRlWwX3tUkXKNotx+
 g7O3vVMpIQYGKRsg2KTFw/xlVGZik3c4nhrtyIPG0fxDB31Ucwx4TJ2nSSEDqShOAIJy
 GnnMludsC/4tK85NLOPkp+rle74bBDqove9WOdLh+/o3c9YmBHn/8o+sKibkQ18fKd8C
 OTCLdLXXNmO/4bj3nOi8+pBgopBf1o3LLpYXBSc/hGr2tyVYvhMntDQIBkhggp91EMNL
 SX77brZtY5faOrRW6E1uGjcqIst2DVsB8GJWBmKESjQzt6kqspK9jg5DatV9HU745nWE
 31iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232769; x=1697837569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bSA2//wrqrp9x+dBDbiScNjiAckPEW5NolyefyLY70=;
 b=NwalGAp1fFRpw6rhj3dlGUNv3JbhAQy54PlEhCQhM1qGre0WuqupQ4qSeT37hVVx1Y
 oHdqlfaTWdHgLz9qz9BYkS7s9UO99ROhFLPRJOHiNzLK4K19O6uHXRnpLI7V9Pd0HwqP
 37DeyOw+0ATZWQjp6BS5/+r7VYIkwtrtAUZcnFKIJrkHnJN+sKNe8kKGfNT7oUlbBCOP
 1vp1EEz71t+xCtyMGF4mvbzs44sgb1C+kjT8MGvEKFobBs1D4UVCpzSybhlr2tL8Vkpw
 HTx9L74pjrKwo2JV+6KkZFW4d+15lvJmw9lIC0k9IAqE8PL7LMlnnotSACDJ9fLBjzmb
 AAgg==
X-Gm-Message-State: AOJu0YzwTFiDu0yXLIgEsl46zPolJk58ovOu+6b8SYJGOQoTN7rq9dEz
 wphMKDcuoojENyY2RNSyTaq55AkbJCt6lr5r2mU=
X-Google-Smtp-Source: AGHT+IH5LaP7iJrBxZApawzE02eMn/4Uw/Y+CBBbHP6UkJA37Y0M9f4+1qMxRkYM/dEcvz2ynWCQ1A==
X-Received: by 2002:a05:6830:1d94:b0:6bf:21d3:2de5 with SMTP id
 y20-20020a0568301d9400b006bf21d32de5mr29297347oti.17.1697232768999; 
 Fri, 13 Oct 2023 14:32:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 66/85] target/sparc: Move gen_fop_DD insns to decodetree
Date: Fri, 13 Oct 2023 14:28:27 -0700
Message-Id: <20231013212846.165724-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Move FSQRTd, FxTOd, FdTOx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 50 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5dd05bb211..d3badc6db3 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -240,6 +240,9 @@ FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bad929d2da..23b287cd38 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,8 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
@@ -1538,20 +1540,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static void gen_fop_DD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 dst, src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4819,6 +4807,28 @@ TRANS(FABSd, 64, do_dd, a, gen_helper_fabsd)
 TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
 TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
 
+static bool do_env_dd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+{
+    TCGv_i64 dst, src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
+TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
+TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -4961,10 +4971,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x29: /* fsqrts */
                 case 0xc4: /* fitos */
                 case 0xd1: /* fstoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
-                    break;
+                case 0x82: /* V9 fdtox */
+                case 0x88: /* V9 fxtod */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
@@ -5069,9 +5079,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                     gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
                     break;
-                case 0x82: /* V9 fdtox */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fdtox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
@@ -5079,9 +5086,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x84: /* V9 fxtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
                     break;
-                case 0x88: /* V9 fxtod */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fxtod);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


