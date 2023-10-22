Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB57D270F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhto-0007KO-5c; Sun, 22 Oct 2023 19:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtY-0007HB-Cf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtW-00071g-JN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:08 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso2599179b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017405; x=1698622205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFbnrYzrB/swLT6tCiPD88pzrfn3ZIxHWDDHK3GKFig=;
 b=uzcJYt7TQXO+fBUD4a7lykoRyTf8HFxS50Ae9fo0G/foE0f17kUyo88Lahp2CV462G
 t0jXTpyeoxECtfhLBTS9Xc+5UA+Ww0SLqns0QwGWE5tIFAXUzNN4Z05AcRlcCdzXMTea
 hvHXMJu+A8j3XduuHFJ/gsnUbewCWI+/CzkOeLnCn27zItJP/GSwrZ5bcTdqMwEuaauO
 Nh2Y7ucOQkuZJSvn1JBtOJRT3eqr1nXWdt6aoxtnsXiEUju0T5LD7wQvJdTZRBitb3CG
 ob/B7iIo7cDWp52SGZuLiw7PXpKuEZLxKS1baPk4qMLGX0HzIzM5CTPHCiyDMWX3T4cT
 IJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017405; x=1698622205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFbnrYzrB/swLT6tCiPD88pzrfn3ZIxHWDDHK3GKFig=;
 b=JdxdYz4Uxbvqsi6l/B2LCLtkdpdCYh4ItR8IcND19Kar3L5SjBONOog2jtdu6A6IuH
 Z2cqlXoq7Dq7CLmG6NaW7qGxmK/PsprGVLbXJHcGwgB5ppG+tFIh0ay/ldDWd09DDqyy
 xznMUuqm38TVh5D9yODJoNX5s1e4l1/wCI6CFW/V1lEoTubiiuEigwqYyaK1Dju2BDBX
 XuVWpQs0VPnydk+K/qDQxwL0TGjmU3hJXKezM+Re/ybXL6SpJKHv1PaglSVjqRq4KSoA
 dWVGVPFgTZaADRy2znT8AqJULXdGLM04etLaks1SQNTs221fY3ETTfuKnAj5zKI11flj
 kRyA==
X-Gm-Message-State: AOJu0YwPAnUm38goq5TrHZR6DLg5vNKIjuwbzhFf6nYQgfwAv97WHIGK
 USTolg4cXulaRHVDwrWCURdy5+C75yv3Z4pk0rs=
X-Google-Smtp-Source: AGHT+IFhLYDhOAkzK6cYw7Wbqqc5diGSsLvMyfka0JdFHkKcaSpwIyVoc6ikf9bgR6SyDEwHxBiVaw==
X-Received: by 2002:a05:6300:8088:b0:161:7a0c:3c37 with SMTP id
 ap8-20020a056300808800b001617a0c3c37mr8012756pzc.5.1698017404982; 
 Sun, 22 Oct 2023 16:30:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 36/94] target/sparc: Move UMUL, SMUL to decodetree
Date: Sun, 22 Oct 2023 16:28:34 -0700
Message-Id: <20231022232932.80507-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 22 ++++------------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1a04a8e229..d6a7256e71 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -167,6 +167,8 @@ XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
+UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
+SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 20c59b6aaf..14e79f1c87 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2888,6 +2888,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #ifdef TARGET_SPARC64
 # define avail_32(C)      false
 # define avail_ASR17(C)   false
+# define avail_MUL(C)     true
 # define avail_POWERDOWN(C) false
 # define avail_64(C)      true
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
@@ -2895,6 +2896,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
+# define avail_MUL(C)     ((C)->def->features & CPU_FEATURE_MUL)
 # define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 # define avail_64(C)      false
 # define avail_GL(C)      false
@@ -4092,6 +4094,8 @@ TRANS(ANDN, ALL, do_logic, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_logic, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
+TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
+TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4563,24 +4567,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xa: /* umul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0xb: /* smul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0xc: /* subx, V9 subc */
                         gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1


