Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEBA7D1B33
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4hu-0007bW-1S; Sat, 21 Oct 2023 01:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4he-0007AR-Cz
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:17 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hc-0001WU-DY
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:14 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2ea7cc821so1100826b6e.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866751; x=1698471551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEqVu0Hj0xGJHwQ4jxavqV52VeJx1CP8Hc3sSSbMfq0=;
 b=IFtjrwEfGtyoVgWHQI+PZwIWg8AvFNLK7SwOOthgRNBd7SZmEIZWDLLjcou7zW6Raa
 TiIjOr8MmlVKpY7b2rZMVgkZYkyfW/ZHofh0SJHzah2dMKg8zli/9dV1Kq+htMik7rEr
 uP0aph2FkM8RL2OD6PlHU8D2B4U4n8NV6cREKFFn2AgW/3EISSg9VprZJSz7txI+YtUT
 S7tmANk84zoNfxppJvAOnxZ/JLdn36IDQ3t+dnvX4xzXe9c5xCvAs6p7cw46YCiElrJX
 TKl48Vg0IyByudgtHW8v2s5Lj1PcTl4pZ/A2prezLHX6d7v66Ghykef1t5ZZ5i3SO4BT
 w5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866751; x=1698471551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEqVu0Hj0xGJHwQ4jxavqV52VeJx1CP8Hc3sSSbMfq0=;
 b=Wnvixd929SZEhETengD9nHwlU0GYEu/pVqC0NaCq+xI1q1hIUfve96dvDB51RnhZv/
 P2WrChsEqGA4o0jqzcyxhWrurLYA45FAt8ALLzseChWT0oqnAHVWFGzeiQdE8SASu/GO
 dUSCypkjxJ0XqU/unq36S2QPvp1yAmObyJjECabXHQ9T+sUQoYHJDQBInEUkv937dE/+
 o/TRW84PMMZBtGDyXDFb9aEU1BgdTzDXmfnEEMN1O5/LGNCz/j1Mo9eWCDHXBYUpfEG/
 03vnQkHZLaOokMsWYk4arP2ATjSmWIWiQuUBHGv4BvxyU1esqTjXKuZTB3IvwlSqPWbT
 JiJA==
X-Gm-Message-State: AOJu0YyeEqC0o6Oxb7IJp66V+eHYz62otzA2dbh+lR41sV8fStsFg6fl
 ikWNuRTuorlIPQXC7dNN16Ps1nnEB5kYv5ie0iE=
X-Google-Smtp-Source: AGHT+IGMUrILDfXfKKcEtSoRcMw6fN77mVz9pHFGWF314FbsNxilBlgH7bI3aZleEGm5onmoqkWd9w==
X-Received: by 2002:a05:6808:181:b0:3ab:8574:e8ab with SMTP id
 w1-20020a056808018100b003ab8574e8abmr4159043oic.21.1697866751172; 
 Fri, 20 Oct 2023 22:39:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 84/90] target/sparc: Move FMOVq, FNEGq, FABSq to decodetree
Date: Fri, 20 Oct 2023 22:31:52 -0700
Message-Id: <20231021053158.278135-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 target/sparc/translate.c  | 140 +++++++++++++-------------------------
 2 files changed, 50 insertions(+), 93 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 41bf7a2a33..1b14a49850 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -241,10 +241,13 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
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
index 05887f37d1..1e506e8366 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -59,6 +59,8 @@
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fabsq                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fnegq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -271,18 +273,6 @@ static void gen_op_store_QT0_fpr(unsigned int dst)
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
@@ -1657,19 +1647,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
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
@@ -4827,6 +4804,50 @@ TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
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
+    gen_op_clear_ieee_excp_and_FTT();
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
+    gen_op_clear_ieee_excp_and_FTT();
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
@@ -5181,74 +5202,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


