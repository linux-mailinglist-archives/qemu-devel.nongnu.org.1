Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54B7CBB2E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNv-0003bQ-5U; Tue, 17 Oct 2023 02:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNm-0003Kw-U8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-0004kC-Hf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2952910b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523397; x=1698128197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rhHwfmKZohtuDPT+hhaSHxZrrHX/JjVGE+L8S3fWgM=;
 b=boFXvLtf9JRMd9Vokt9cUO+PVNzoykYmSrfxMsWFHkRe+BkCjY7tQuGIuFk1XnKFvA
 2hBB0ExC5k3wdxpkEkM+iqecSbClR6QxuHn963mcT+qFZrjPEKygrxm5orWjUdlhInRF
 AngZ7VhnzaU6G3VWVDKiLXNXRl8ZOuUaB1RoFZ7e6MI2CifgbE55URF1c5ed2R2N7qtD
 LXK2cDXGnr/l4fy/W7sCsji0J4jfjoz4M5Ub/wpi6L4RVD69ntHjzfHTXumJPCSBdUhS
 q3c/JdsbmZUhs56MVbw/tJ1tLNcMWE6TVQqPuTZZGs54/4SKWOm8daGCUShhSzayAnDQ
 mH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523397; x=1698128197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rhHwfmKZohtuDPT+hhaSHxZrrHX/JjVGE+L8S3fWgM=;
 b=gM2jACJqsqUMomcOlFvQDAeUvG3ksUzMK2hRmAXnRwfjGjVMLUMiVxalMpj53GAy9p
 uelI994etWlneZL/ym+P8w2587UkHPPH0MAf8k3UXqd4OGPfdRKELfb4nhDQu6I7saHN
 y6p2R3QG8jnlbmfTCueFlKWYUSuHVsFk8WDdp+qerpe3Dv9dmR6vso4yWNtpkYHIRiK6
 fSFdw5K4Pdzu3D4Y9Ghd607b54yJ2YN+eUpbc9FgVmDN2ESMPksg/4+8g05TFGXi99wF
 M6C8q+9bnwtIpDfPdgINrGfG13kylPdtHcVXBLGHQWjq9RQswmc3d6fVUsP3G3Z04Oox
 onGw==
X-Gm-Message-State: AOJu0YwmqMg++1rNGuxaYrCwHF1BtROLEJU71qnIFk5KN6Wcf4dJ6PDB
 sNnFwDKhqJKVSnFRuUcZj/2E2AFEw4iJRDbA4BE=
X-Google-Smtp-Source: AGHT+IEgWZ2Vf5smHKtzS+/kRPaf7yq6YME5sU+qdREJG9pPgTgWa9bPpTJ+6Rzxwh2gAWFNQ6PG2Q==
X-Received: by 2002:a05:6a00:13a1:b0:6be:265:1bf7 with SMTP id
 t33-20020a056a0013a100b006be02651bf7mr1375577pfg.34.1697523396813; 
 Mon, 16 Oct 2023 23:16:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 61/90] target/sparc: Move ADDRALIGN* to decodetree
Date: Mon, 16 Oct 2023 23:12:15 -0700
Message-Id: <20231017061244.681584-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 07a84b109c..8bd57f620a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -245,6 +245,9 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
+
+    ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
+    ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 87f3ab27b1..dab3e83c27 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2685,18 +2685,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
     }
 }
 
-static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-{
-    TCGv tmp = tcg_temp_new();
-
-    tcg_gen_add_tl(tmp, s1, s2);
-    tcg_gen_andi_tl(dst, tmp, -8);
-    if (left) {
-        tcg_gen_neg_tl(tmp, tmp);
-    }
-    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
-}
-
 static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 {
     TCGv t1, t2, shift;
@@ -4334,6 +4322,36 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_neg_tl(tmp, tmp);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
+TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5234,21 +5252,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x010: /* VIS I array8 */
                 case 0x012: /* VIS I array16 */
                 case 0x014: /* VIS I array32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x01a: /* VIS I alignaddrl */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
                     CHECK_FPU_FEATURE(dc, VIS2);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


