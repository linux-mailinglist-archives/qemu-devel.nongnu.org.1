Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADE7D799C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6n-0002Fl-Tb; Wed, 25 Oct 2023 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6I-0001Ew-1Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo68-0006eQ-Ak
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2036785ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279578; x=1698884378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72s8HqffwPu4WrB9To1B78GgLRzIoL8cOwTuhEiKsh4=;
 b=osrR7jiK8VV9mAwnptytgb4SAqhjEs+j/8TP1PK3YSuShfBdc5VXCXP6D4uzUBHfDn
 9Hpq68g3OhgqkOkdryYslmQ1/JArXIhnuF+hzDW/ZLCvewPcHJkUi5cyrjCdIbM3mqKF
 ug1IBbz0iLV8hf8gafSAhrG9cNULcQc0acH+UaeX2+3RMILU9rrweYRxUgAEXYnEObRm
 PVma5X6clsZJL4tbMUecfS6rDrtjt8A5hwfXTk6/9K7Dreaa8vnueKLMDBVucyEdBNzH
 YD+B/Jd2qGL+U9l+WSgavi4htJbuXrzpgijnxkLDrdOokR2g4/wVJpuqBSLluSDVoTpN
 LJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279578; x=1698884378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72s8HqffwPu4WrB9To1B78GgLRzIoL8cOwTuhEiKsh4=;
 b=RxTvuwZTaP6q9IrDLUo491TZZddewvCrQhXYABcGDhiQD9f6OSz8PCSLvzR5aIGb7o
 S6bxOA2pgnWS+lGAwkJvCRDVExvo3HJIuUq5V3l095d2WhINbk1vamsRig/z1Ifl8vw1
 yIW8hJns8zh0hP5Mkb028GFx6D1Aji5uc1+d+7zM6mpdEk2oV+G7jVEyUPO42AoeX+uI
 iSF3ht9QukgCBZkYc7u4p/UMaw1IuRvKobvSbX7t8LV96uU+s14Zd6sAefjfTx2A5MAo
 sKjCKNqLEJsmFnLINMJKlLtj697DofFr4cuTg2gDQa5dEmg2Eck3Lmx2xSjfJDsSP7SQ
 uXgw==
X-Gm-Message-State: AOJu0Yz1A15HQETcsCCa6HhusAliqVKb04GP6FR1JOnJeEV7JyktJWqp
 8BSpupmUdhK7qalGKjCjaepxQsp4gY33UWkGELk=
X-Google-Smtp-Source: AGHT+IHUVeAKkYTCxmlkiNTW8AXklYpjK/bi3IDe/0STXXZNNM990TfMftFFufW7UpUH/lkJYqWBmA==
X-Received: by 2002:a17:902:db0b:b0:1ca:79b6:ce42 with SMTP id
 m11-20020a170902db0b00b001ca79b6ce42mr14636107plx.47.1698279577829; 
 Wed, 25 Oct 2023 17:19:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 36/94] target/sparc: Move UMUL, SMUL to decodetree
Date: Wed, 25 Oct 2023 17:14:44 -0700
Message-Id: <20231026001542.1141412-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 2ecd9edb33..e7c3c68402 100644
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
@@ -4098,6 +4100,8 @@ TRANS(ORN, ALL, do_logic, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
 
 TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
+TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
+TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4564,24 +4568,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


