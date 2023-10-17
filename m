Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51C7CBAF2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKa-0000q4-RO; Tue, 17 Oct 2023 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKT-0000mh-MV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0003yP-Rs
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso35620895ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523197; x=1698127997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSGLwNkfnTjcUB7m1SPZtJgpMDDDcjvL4Bd28I/2We4=;
 b=Z6EbMx1W+y5tAGXiXCWqQnm1Cq9z0CHaET0VxlbB9YLgncoa/3YX6vglIAkfFNQdz6
 1zociU9XqmcOlI6ry0SQx/J6VvmWxlRKYDWVCgbu5gvgYmoRTGtwyUbltZI9xsjJB+Pu
 L5lZm060AIT8wWnWs1elIH2mRtFXhoEPU2TjZTCpbQq8j8PZMS94xPaR5TETiQZbwTLS
 7+92obU9cS3Lw1R6M915evioGbN1+KFAq2s3b5lQkcy5OkryzX/6oC9q6Q+3xavhg0od
 acsugFslJUO39Ti7zocdZT5mma6yYgVhMaVUchpG/mnKtDO770cYAwo8xKNwcw4DX53L
 LS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523197; x=1698127997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSGLwNkfnTjcUB7m1SPZtJgpMDDDcjvL4Bd28I/2We4=;
 b=Fvb76faB+lciBgNTu3U8po1HLCjvOXTuWx4wgOCtejtUK3Rnc8R3lvXxUc59bgoGLe
 DxsIjBR50ZBNIZn24MFAvJrV5MK8NZVw1/X6AVehEKsjF/zIfKj5ta476Lj8xheXzOn5
 G6dkShY02kOOCL6un3BoEVLdezw+K0qJhZ/8xT0Hg0g4OLryYvUmWQgopK3K9GPyCUM2
 x55GF2xQ3Y0LdErOPjtd1b3NV6vw44ePUNoLx2Rmv7jl3g03dHCno6AK2rCo/xtg3h/6
 1yOBHSq2iDHbSp9QmOQNX+64dfxbCs+GFqOuXeo2NCGXxY9PZI5ZD3uWIKie2bTHffa8
 iN+A==
X-Gm-Message-State: AOJu0YyUvuVVTzAKPHpUvpN5/z9IZqcElZQj4i2RvX7YvzbV8JnF1TS7
 fQnMvTe8pAUWujh6aP000aHrtCLb/DIK9jLnmks=
X-Google-Smtp-Source: AGHT+IHIzj3z2OazqvevqDSpgn0Lf03LdEJCSXQpuxCCOnyjvBtr8jIQiuUpLfZBZStcZIFYn+WpXg==
X-Received: by 2002:a17:903:5cf:b0:1b5:674d:2aa5 with SMTP id
 kf15-20020a17090305cf00b001b5674d2aa5mr1155153plb.13.1697523197538; 
 Mon, 16 Oct 2023 23:13:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 38/90] target/sparc: Move MOVcc, MOVR to decodetree
Date: Mon, 16 Oct 2023 23:11:52 -0700
Message-Id: <20231017061244.681584-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/sparc/translate.c  | 103 +++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fe0eacd779..a61d10be5a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -205,3 +205,7 @@ SRL_i       10 ..... 100110 ..... 1 .   000000 ......      @shifti
 SRA_i       10 ..... 100111 ..... 1 .   000000 ......      @shifti
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
+
+MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
+MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
+MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index deea3015b1..0b0b9aa8d3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4407,6 +4407,51 @@ TRANS(SLL_i, ALL, do_shift_i, a, true, true)
 TRANS(SRL_i, ALL, do_shift_i, a, false, true)
 TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
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
@@ -4779,66 +4824,12 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


