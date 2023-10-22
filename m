Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB87D2142
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRX5-0001uQ-Ae; Sun, 22 Oct 2023 02:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWt-00017Y-7f
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWq-0001iV-7A
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso1766943b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954494; x=1698559294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pB9Vhm2yWNKoG9Y3BvzSobyBZzPNG8Ki0Uham9/uwZs=;
 b=N34AHRdTJtAYFmFahK9fo9/ESZcWHJ7IqW1MyuFDACs/wH1Qkd8BeQqNroDTlrRiMF
 31BYMYN6JilfpvTDXcese/NY7RZKkpgfmTFKEkFA9iFFAl2dMt7cgOvG2FNytQQxUnfw
 cRWoEKUePzlrzOqH2lykNyjhkYl3ymRAXjXCqAmlEnYgR329pHQ2n5ZiEmDjrCeKvXcy
 mEqmxabad2KeMOp2VTCrxh9tu9/a47gCBiN51UTx7UH77WblR+UK4MQqKa+5Ij14Ck2i
 k25S04nPu0la6CB9tnaOYoBErEm9mbDf5sHq71iiJr9uSxfDAo9/krBEiLMP2TjbpaIr
 W4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954494; x=1698559294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pB9Vhm2yWNKoG9Y3BvzSobyBZzPNG8Ki0Uham9/uwZs=;
 b=VgAEipDc5AtQRdaGtwGNxSIO7PDQiNKvpG9/19fymdr8+L288DKhFBNva5/L/Gn0UM
 Scx9ykkAyMi0ysdLf5sCGsMYMbQk1y6SQowmjVv9vxn9h9C0HBn77npN2+G0PitMeIRu
 UyD1xZvqtBJN5s93KMsSrg3A6I0Sakyx06r1o26E6bVCmbKU8pALJJSin0/VRGmmXaSy
 8IhyhaFxJyHjn9/EWAJY33wauIkgwK/uB5oJ61v+v3zoRnt5bxtwQcO3LeDxJNgHf6wq
 OMB7N0qCfZavbp1i1PRSqwrM2RuG7PJumW2pwOx49NGRmDuCO3VQpwk8ymB00ySecsaD
 hafQ==
X-Gm-Message-State: AOJu0YxKwlBMgLFuAWuSl/3MJP3ZitCL5f6d5TG2fItemROGCw1jexMn
 RsujwBmHMBl4d0duq/SPD1gDqhiXzUU+FUzvJbs=
X-Google-Smtp-Source: AGHT+IEmWsS4dV1k/5aHRbUnficCSVn/c9DDROELh1g/eFtbSUByy0iYlSMFc1yE5HZnbH80D/0Ohg==
X-Received: by 2002:a05:6300:8089:b0:171:4921:f1b7 with SMTP id
 ap9-20020a056300808900b001714921f1b7mr4895231pzc.41.1697954493936; 
 Sat, 21 Oct 2023 23:01:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:01:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 38/90] target/sparc: Move MOVcc, MOVR to decodetree
Date: Sat, 21 Oct 2023 22:59:39 -0700
Message-Id: <20231022060031.490251-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/sparc/insns.decode |   4 ++
 target/sparc/translate.c  | 116 ++++++++++++++++++++------------------
 2 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 51cddc826d..cb21405e1a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -209,3 +209,7 @@ Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
   # Bits [10:8] are reserved and the OSA2011 manual says they must be 0.
   Tcc_i_v9  10 0 cond:4 111010 rs1:5 1 cc:1 0 000 i:8
 }
+
+MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
+MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
+MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3785728e66..b907873359 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4468,6 +4468,64 @@ TRANS(SLL_i, ALL, do_shift_i, a, true, true)
 TRANS(SRL_i, ALL, do_shift_i, a, false, true)
 TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
+static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
+{
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!imm && rs2_or_imm & ~0x1f) {
+        return NULL;
+    }
+    if (imm || rs2_or_imm == 0) {
+        return tcg_constant_tl(rs2_or_imm);
+    } else {
+        return cpu_regs[rs2_or_imm];
+    }
+}
+
+static bool do_mov_cond(DisasContext *dc, DisasCompare *cmp, int rd, TCGv src2)
+{
+    TCGv dst = gen_load_gpr(dc, rd);
+
+    tcg_gen_movcond_tl(cmp->cond, dst, cmp->c1, cmp->c2, src2, dst);
+    gen_store_gpr(dc, rd, dst);
+    return advance_pc(dc);
+}
+
+static bool trans_MOVcc(DisasContext *dc, arg_MOVcc *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
+static bool trans_MOVfcc(DisasContext *dc, arg_MOVfcc *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_fcompare(&cmp, a->cc, a->cond);
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
+static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4840,66 +4898,12 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                         goto illegal_insn;  /* WRTBR, WRHPR in decodetree */
 #ifdef TARGET_SPARC64
                     case 0x2c: /* V9 movcc */
-                        {
-                            int cc = GET_FIELD_SP(insn, 11, 12);
-                            int cond = GET_FIELD_SP(insn, 14, 17);
-                            DisasCompare cmp;
-                            TCGv dst;
-
-                            if (insn & (1 << 18)) {
-                                if (cc == 0) {
-                                    gen_compare(&cmp, 0, cond, dc);
-                                } else if (cc == 2) {
-                                    gen_compare(&cmp, 1, cond, dc);
-                                } else {
-                                    goto illegal_insn;
-                                }
-                            } else {
-                                gen_fcompare(&cmp, cc, cond);
-                            }
-
-                            /* The get_src2 above loaded the normal 13-bit
-                               immediate field, not the 11-bit field we have
-                               in movcc.  But it did handle the reg case.  */
-                            if (IS_IMM) {
-                                simm = GET_FIELD_SPs(insn, 0, 10);
-                                tcg_gen_movi_tl(cpu_src2, simm);
-                            }
-
-                            dst = gen_load_gpr(dc, rd);
-                            tcg_gen_movcond_tl(cmp.cond, dst,
-                                               cmp.c1, cmp.c2,
-                                               cpu_src2, dst);
-                            gen_store_gpr(dc, rd, dst);
-                            break;
-                        }
+                    case 0x2f: /* V9 movr */
+                        goto illegal_insn;  /* in decodetree */
                     case 0x2e: /* V9 popc */
                         tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
                         gen_store_gpr(dc, rd, cpu_dst);
                         break;
-                    case 0x2f: /* V9 movr */
-                        {
-                            int cond = GET_FIELD_SP(insn, 10, 12);
-                            DisasCompare cmp;
-                            TCGv dst;
-
-                            gen_compare_reg(&cmp, cond, cpu_src1);
-
-                            /* The get_src2 above loaded the normal 13-bit
-                               immediate field, not the 10-bit field we have
-                               in movr.  But it did handle the reg case.  */
-                            if (IS_IMM) {
-                                simm = GET_FIELD_SPs(insn, 0, 9);
-                                tcg_gen_movi_tl(cpu_src2, simm);
-                            }
-
-                            dst = gen_load_gpr(dc, rd);
-                            tcg_gen_movcond_tl(cmp.cond, dst,
-                                               cmp.c1, cmp.c2,
-                                               cpu_src2, dst);
-                            gen_store_gpr(dc, rd, dst);
-                            break;
-                        }
 #endif
                     default:
                         goto illegal_insn;
-- 
2.34.1


