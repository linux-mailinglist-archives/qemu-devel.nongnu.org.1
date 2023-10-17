Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F337CBB10
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNx-0003oC-0N; Tue, 17 Oct 2023 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNm-0003Kg-SC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-0004kM-HS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1640915b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523398; x=1698128198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHo4SeyS7aw5ijTjoJ0VnbYoHhU1uLzmuWbYypfMjeM=;
 b=Re2a7pFgrlR3ZBIXDCWDh3jIEbhT3ornTpCIH+uPHQvxXEUsdHYoaTsbtrGpCyL9Ns
 brN7MHbefbpL7uGK7l/m12aavAgxJ0eOuColn0dE5XLL9AclDCv3LnT+Wmac/g7RJqvG
 tPaTpmLnqx0YLelpghLibk/1Kr68IDCvuqGmwQUVlyQ4VxsoDiTDhPmZ6lSe69Gm46S4
 7XaxVVGVfTxqyzjHKALlqnvGJ5E3gK7e6epVOIrQDCf65XhLBkCdkG6IgEzd9bCzV1oW
 /B1Wuxk11dXZBfK7fzpqfjyzF2eMXIwGZRRSt+l5QG/7Dq6TdFVvuzZ3FSUoffPaHgHE
 k3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523398; x=1698128198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHo4SeyS7aw5ijTjoJ0VnbYoHhU1uLzmuWbYypfMjeM=;
 b=nD0Q9YfDDEfGwXcWyyLImIdbtyExP5N/Xw1AmShGsi3JDoP3tyXFjP5lQ3SBF6VBb3
 /Zf7aUzXe2pdIkHLHCoBlf5qU3W6TKvQvmopmSDSg6zxxtGvA4pubH+CYjBkTP5NASMj
 MFXhvYabC8khQmSsIz9T9a3I674XLjqNMreprLxCKEkSel8tcMkZSixOVvQgHLTsAG2w
 CLM00dre+cBIzsRQ6lsc3u8GwGGSmrTwsMJOg8kdRDjlYGmZgosTKTqPsXFKsX6qx3J5
 RSZvok+ZXaDmKXLlgtRMhHIrL2jwKw8JdWqWgKUhxUfipGluPR/dZNVJP7ZhEn7O0wMC
 BEKQ==
X-Gm-Message-State: AOJu0YwCH4sNENBbCVz4N678aoLWRKzvbKPHbhs8BvNb8MQmb3tuVq4z
 0r112Rt4pua/UV8vsC6RBG0jM+XnXwuHz/EJyNk=
X-Google-Smtp-Source: AGHT+IG8B5GEUuNX9Py87r947mB+8OqWcxrWEBhVE78GEBkNRM/vwGPywfQFIyL/R7goOVB3hhAYEQ==
X-Received: by 2002:a05:6a00:1353:b0:68f:b5a3:5ec6 with SMTP id
 k19-20020a056a00135300b0068fb5a35ec6mr1500386pfu.0.1697523397912; 
 Mon, 16 Oct 2023 23:16:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 62/90] target/sparc: Move BMASK to decodetree
Date: Mon, 16 Oct 2023 23:12:16 -0700
Message-Id: <20231017061244.681584-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/sparc/translate.c  | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8bd57f620a..6f136e0602 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
+
+    BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dab3e83c27..64f1999cba 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4352,6 +4352,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
 TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
 TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
 
+static void gen_op_bmask(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_add_tl(dst, s1, s2);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, dst, 32, 32);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(BMASK, VIS2, do_rrr, a, gen_op_bmask)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -4889,7 +4901,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5254,15 +5265,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x014: /* VIS I array32 */
                 case 0x018: /* VIS I alignaddr */
                 case 0x01a: /* VIS I alignaddrl */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    tcg_gen_add_tl(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, cpu_dst, 32, 32);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-- 
2.34.1


