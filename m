Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D987D217F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRax-00043Q-Mq; Sun, 22 Oct 2023 02:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa9-0001GS-Lz
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:01 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa3-0002Gx-Sa
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:01 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b3e13fc1f7so1677771b6e.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954692; x=1698559492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SN7hYFcaRqlSL/9M4b670NiRTGmh+kO+P3lyFpCaU7c=;
 b=psPMcWVdVdcYYMZrRrFpuaSOB0FmQhzR/75sdUsDpvPoy4DkixE8vqygidrcZL3Myg
 Y6F2L3Vu09M2FDOYX26J1EASSNnYHuR1KxpKwDd5+OXQthhm6Cyt5ZUBCxYUTal2gZ38
 +y+Z9ugZ0DD1Is9eQhJ2qnruAjmMI2bKzRPMKhqdyl+6q6IdbhPEFGiHZLZ/Poqn1vru
 s9fk3YwaNO1SxNagYoGliAgan09qshJxGLtAroy/aAYej2iwtt+nzd2osEpxjhF+yKY5
 mM2dVkKpZhTxSq6i2cNHUdb1gLOkpKPmE1Qs/5VZIS5MsYqD+sKEk/Yl+d6IQ/rgN2BO
 PIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954692; x=1698559492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SN7hYFcaRqlSL/9M4b670NiRTGmh+kO+P3lyFpCaU7c=;
 b=lHItovN8ctheCs+JPWmGdYeu5VQ9sGZDJvV+pxWPYZpijN9dYE6+JUPf6xQZj7vTi/
 a9Jq9HuOGmCznpOJ/WyVazi4xdpjrwWX4uVoYKCBFvQ1ABzj4koCTOpRJXL41gSHsbL5
 L+Onu/xpg/qstxw3H8iWR46eF6/9hXAExbZ+6IpEDcZQZoaKp9UV1r1dGn7Rw/NOsTk4
 Xetphngd8O0SpwighJ0rDDBvxoxQYp0Id/qqBTbbLTbIls0tbVqpfQIKUl2lpZmSHgd9
 ZbhQM5S5NtrY/Rt0qUsOmrRzp3JRnTTloyI++nx1sIJYaRAb5u3kgqIV9h/wM+s7o3wt
 sQIQ==
X-Gm-Message-State: AOJu0Yzq8b6EKYF3H7cZj9Ib5ZS5k+aPgWHmCNCxQiRlJ32YLgoj01zs
 LJxgJm9w4GhI/K4/dOafZoa1ibqmtrS34j3wwMI=
X-Google-Smtp-Source: AGHT+IFz3Bmcl58eVdHwLPmOOwI1rNoprZkBRVtSzN0dq3sn49lJsTproAWx6MMPTGS/qBpxrfj94g==
X-Received: by 2002:a05:6358:339f:b0:14d:bad5:6adf with SMTP id
 i31-20020a056358339f00b0014dbad56adfmr8597850rwd.21.1697954691917; 
 Sat, 21 Oct 2023 23:04:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 60/90] target/sparc: Move ARRAY* to decodetree
Date: Sat, 21 Oct 2023 23:00:01 -0700
Message-Id: <20231022060031.490251-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 ++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a9630509bd..b15ede5fd4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,10 @@ RETRY       10 00001 111110 00000 0 0000000000000
     EDGE32N     10 ..... 110110 ..... 0 0000 1001 .....    @r_r_r
     EDGE32Lcc   10 ..... 110110 ..... 0 0000 1010 .....    @r_r_r
     EDGE32LN    10 ..... 110110 ..... 0 0000 1011 .....    @r_r_r
+
+    ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
+    ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
+    ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eeb22d64c9..794e997a58 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,6 +72,10 @@ static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
     g_assert_not_reached();
 }
 # endif
+static void gen_helper_array8(TCGv r, TCGv a, TCGv b)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -721,6 +725,18 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+static void gen_op_array16(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 1);
+}
+
+static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4363,6 +4379,22 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv, TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src1 = gen_load_gpr(dc, a->rs1);
+    TCGv src2 = gen_load_gpr(dc, a->rs2);
+
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
+TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
+TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5273,30 +5305,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x009: /* VIS II edge32n */
                 case 0x00a: /* VIS I edge32lcc */
                 case 0x00b: /* VIS II edge32ln */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x010: /* VIS I array8 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x012: /* VIS I array16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x014: /* VIS I array32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


