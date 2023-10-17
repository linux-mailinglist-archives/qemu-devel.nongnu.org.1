Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500BD7CBAB5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKS-0000kR-VC; Tue, 17 Oct 2023 02:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKN-0000gQ-CE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:15 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKL-0003wA-MR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so3978351a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523191; x=1698127991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONi4sz4FYrpfXMHk9bqTEXz7CTlBpGmmezfxI4F92Y8=;
 b=DMq9Y7B8OEkm5tlbIUmiBTbGML+2yiWriQrU0EE2OFbQcdnqjDar0kJpuAuqFdAy4p
 UpeBDGNODdk/msnaLCujrpT/H4pR1ok0CK8oKHEeeSoM7IKweabZDzAM5u9hgDIdfhL5
 twZ5rMZho71QuwBMqDB9t7Z++Ywmknh2wYNi0r8nv80tTKafgkzUANyPrSgkkFTaSABy
 lIqMdlGd73b/CkZ7vx3L97Njq0rfPbQOX+CxMlWA+PDnRkE8DLhfQk52dwSiqDXK2QvS
 SQxW3HjYimRfQ5HkyETtRTVZZDurFMowm3+e447PKPUmLotc1dhh/a7EjPmY5HwM5y8b
 NPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523191; x=1698127991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONi4sz4FYrpfXMHk9bqTEXz7CTlBpGmmezfxI4F92Y8=;
 b=E0x0LotgZAGqg7zVu2dU1WjQacK574FgVUVtvX3kcffH6QlTMwyyqKCkuCjoTI3Vet
 IlKyxuitq9zWM25+VKOLG4Lez8+wTTllAmwnH2POBeOH15/ecA6l0/XnUN8LNXQ5CMCj
 AcBqDLVwGQjYpcf950UDbTI8EwlykEpSHd2Z3EzOHUDMKqo1iLUitJMIisRZPvcsstCd
 blDXfPBs5Lit15276M63gXXMePtAwBvF3MylNIrjn5uDP5vmA7VHUsO8mMLwQ0GCrZsr
 5jlOIthya7ezteHxb3MOKfoN4GfJzH6eHNA6wI0gwGRW7GCIHiQ9eLmtLbT8rTd5u00a
 tA2Q==
X-Gm-Message-State: AOJu0YxwzCvDOZXYdNjy+8EUwRcByYelJybOpncfzRCo0Mg5/RKSmE/Y
 vfW3Iw+IMQaRq2j6wYKoBNnlSYb/4rFfk52cXUk=
X-Google-Smtp-Source: AGHT+IEYsUMTUDvyYvziPNO+2EkYsJ5yqO3Fi7RNjkwayqIKcrgENJUNuALpHCTJQHw3ALBl5JVcag==
X-Received: by 2002:a05:6a21:71c7:b0:16b:afc2:3b68 with SMTP id
 ay7-20020a056a2171c700b0016bafc23b68mr1174341pzc.25.1697523191165; 
 Mon, 16 Oct 2023 23:13:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 30/90] target/sparc: Move ADDC to decodetree
Date: Mon, 16 Oct 2023 23:11:44 -0700
Message-Id: <20231017061244.681584-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 41 +++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4005ce3df7..abcee27fd4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -169,5 +169,7 @@ ORN         10 ..... 000110 ..... . .............          @r_r_ri
 ORNcc       10 ..... 010110 ..... . .............          @r_r_ri
 XORN        10 ..... 000111 ..... . .............          @r_r_ri
 XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
+ADDC        10 ..... 001000 ..... . .............          @r_r_ri
+ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 368bafc99a..27375c74ec 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4193,6 +4193,43 @@ TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 
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
+static bool trans_ADDC(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, false);
+    return advance_pc(dc);
+}
+
+static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, true);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4617,10 +4654,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0x8: /* addx, V9 addc */
-                        gen_op_addx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0x9: /* V9 mulx */
                         tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-- 
2.34.1


