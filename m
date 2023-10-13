Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0397C8F6A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmr-0004El-Ft; Fri, 13 Oct 2023 17:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmK-0002rW-LU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmH-0001ba-5o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6969b391791so2080066b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232780; x=1697837580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLNfNkw+Z2wdWrOMGPUyB0Wzmu+N8SNCBRCuHbAzhbU=;
 b=auin6Jv+zu6ocFm/XcmzmJJikRoa6x8knnI6WbWnKCLn4nMvOz1MKy6B4ADiUxCF3B
 FoKgOz3OUMn4yLImzT0tmZ7M7dU4h6nrB8n2mOaTwOc0N6fQrRTEBfXtLGy1W0K6m0t/
 zfX6t1yP+Mm3GinUhy2hcNgugfvcSSbMWaTLwwtTwfSSk2Z8eWfQvapqEMMEejPSPpTr
 E7GAP3/MA+6LoxaaFWKzY1KtdXbyfMTvM3jukUpmZCwTghZ8EoGNNI/0HChPEjW455Ni
 s1jKQglR99WhWacH4fIgtVSK8r2bjrwq8Kf6kAuogrWhXsH53Rom2wwkhgHf7rUHFu6B
 xLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232780; x=1697837580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLNfNkw+Z2wdWrOMGPUyB0Wzmu+N8SNCBRCuHbAzhbU=;
 b=nix7S8pXZ69Z3I3N4W582v99OxXoL0vHL+7CuGV5H6bxNv4W2XZqQOyBY+9GCO75dl
 ilsoY85FyB2iagSsNfFRg8uSExTcnTcGtynY0wQfFmPcZFJKRS0eWDMtH6j0o4VFcKJg
 duY035Yf/YThQTTCM120ta4IlOGMM4MZtwCvIYm1G8pvg2p/o1dSgqoYZhqzz+UhwGc3
 seNw14JuBdrbj/tTvYtp2syuQvuZhEyYq7q4cmJh5beBkANuaUpVzAIhWX9jlRV688xc
 fiQBQ/UaqLCx0xx34bvSHMDxIJ+Itdmu+KrTyeOB/JJpCo0NZjyedqV4izSpkMObEdM4
 9yDg==
X-Gm-Message-State: AOJu0YyWBzAnQHlEvkfyNjbvVxOKHjC1en1GHKyYTs3k14AWna32jh4u
 blL3m8QQZK5qvBmPpz/KYH/V9jMlg/xOEFZ76jQ=
X-Google-Smtp-Source: AGHT+IF0TaAFWLjmQGD7BG7Q8fYnNKEQFXDp4TQQfZHutzHJvgE4bMMP3TFrsLBbpo7sCfSabZr79g==
X-Received: by 2002:a05:6a00:39a2:b0:691:2d4:23b2 with SMTP id
 fi34-20020a056a0039a200b0069102d423b2mr29110094pfb.15.1697232779810; 
 Fri, 13 Oct 2023 14:32:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 79/85] target/sparc: Move FMOVq, FNEGq, FABSq to decodetree
Date: Fri, 13 Oct 2023 14:28:40 -0700
Message-Id: <20231013212846.165724-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   3 +
 target/sparc/translate.c  | 138 +++++++++++++-------------------------
 2 files changed, 48 insertions(+), 93 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f749e23ae6..8f953a6af6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -235,10 +235,13 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
 FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
 FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @r_r2
+FMOVq       10 ..... 110100 00000 0 0000 0011 .....        @r_r2
 FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
+FNEGq       10 ..... 110100 00000 0 0000 0111 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FABSq       10 ..... 110100 00000 0 0000 1011 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 22a1a13ef8..c16d572c88 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -54,7 +54,9 @@
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fnegq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fabsq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
@@ -261,18 +263,6 @@ static void gen_op_store_QT0_fpr(unsigned int dst)
                    offsetof(CPU_QuadU, ll.lower));
 }
 
-#ifdef TARGET_SPARC64
-static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
-{
-    rd = QFPREG(rd);
-    rs = QFPREG(rs);
-
-    tcg_gen_mov_i64(cpu_fpr[rd / 2], cpu_fpr[rs / 2]);
-    tcg_gen_mov_i64(cpu_fpr[rd / 2 + 1], cpu_fpr[rs / 2 + 1]);
-    gen_update_fprs_dirty(dc, rd);
-}
-#endif
-
 /* moves */
 #ifdef CONFIG_USER_ONLY
 #define supervisor(dc) 0
@@ -1530,19 +1520,6 @@ static void gen_op_clear_ieee_excp_and_FTT(void)
     tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr))
-{
-    gen_op_load_fpr_QT1(QFPREG(rs));
-
-    gen(tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-#endif
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4694,6 +4671,48 @@ TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
 TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
 TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
 
+static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
+{
+    int rd, rs;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    rd = QFPREG(a->rd);
+    rs = QFPREG(a->rs);
+    tcg_gen_mov_i64(cpu_fpr[rd / 2], cpu_fpr[rs / 2]);
+    tcg_gen_mov_i64(cpu_fpr[rd / 2 + 1], cpu_fpr[rs / 2 + 1]);
+    gen_update_fprs_dirty(dc, rd);
+    return advance_pc(dc);
+}
+
+static bool do_qq(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_env))
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    func(tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FNEGq, 64, do_qq, a, gen_helper_fnegq)
+TRANS(FABSq, 64, do_qq, a, gen_helper_fabsq)
+
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
 {
@@ -5048,74 +5067,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
 
             if (xop == 0x34) {   /* FPU Operations */
-                if (gen_trap_ifnofpu(dc)) {
-                    goto jmp_insn;
-                }
-                gen_op_clear_ieee_excp_and_FTT();
-                rs1 = GET_FIELD(insn, 13, 17);
-                rs2 = GET_FIELD(insn, 27, 31);
-                xop = GET_FIELD(insn, 18, 26);
-
-                switch (xop) {
-                case 0x1: /* fmovs */
-                case 0x5: /* fnegs */
-                case 0x9: /* fabss */
-                case 0x2: /* V9 fmovd */
-                case 0x6: /* V9 fnegd */
-                case 0xa: /* V9 fabsd */
-                case 0x29: /* fsqrts */
-                case 0xc4: /* fitos */
-                case 0xd1: /* fstoi */
-                case 0x2a: /* fsqrtd */
-                case 0x82: /* V9 fdtox */
-                case 0x88: /* V9 fxtod */
-                case 0x2b: /* fsqrtq */
-                case 0x41: /* fadds */
-                case 0x45: /* fsubs */
-                case 0x49: /* fmuls */
-                case 0x4d: /* fdivs */
-                case 0x42: /* faddd */
-                case 0x46: /* fsubd */
-                case 0x4a: /* fmuld */
-                case 0x4e: /* fdivd */
-                case 0x43: /* faddq */
-                case 0x47: /* fsubq */
-                case 0x4b: /* fmulq */
-                case 0x4f: /* fdivq */
-                case 0x69: /* fsmuld */
-                case 0x6e: /* fdmulq */
-                case 0xc6: /* fdtos */
-                case 0xd2: /* fdtoi */
-                case 0x84: /* V9 fxtos */
-                case 0xc8: /* fitod */
-                case 0xc9: /* fstod */
-                case 0x81: /* V9 fstox */
-                case 0xc7: /* fqtos */
-                case 0xd3: /* fqtoi */
-                case 0xcb: /* fqtod */
-                case 0x83: /* V9 fqtox */
-                case 0xcc: /* fitoq */
-                case 0xcd: /* fstoq */
-                case 0xce: /* fdtoq */
-                case 0x8c: /* V9 fxtoq */
-                    g_assert_not_reached(); /* in decodetree */
-#ifdef TARGET_SPARC64
-                case 0x3: /* V9 fmovq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_move_Q(dc, rd, rs2);
-                    break;
-                case 0x7: /* V9 fnegq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fnegq);
-                    break;
-                case 0xb: /* V9 fabsq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
-                    break;
-#endif
-                default:
-                    goto illegal_insn;
-                }
+                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x35) {   /* FPU Operations */
 #ifdef TARGET_SPARC64
                 int cond;
-- 
2.34.1


