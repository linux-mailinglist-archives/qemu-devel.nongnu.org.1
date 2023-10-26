Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E30157D79A2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA1-0004BZ-Oc; Wed, 25 Oct 2023 20:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9U-0001dg-Nr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Q-0008Cr-Im
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:08 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d0251d305so222028a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279782; x=1698884582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zT14RAopyAvl8kuzSxXdtDC5GmRV87HsUcPsxZmEC3k=;
 b=vog200oOhjhocjie4tU2iE3vgfMcV/+86er6GmFE8FJaoatqBO6z3xdLifWmVJUQip
 lGu2O4E+7yBBcJaQ9biXIK5hw00CjbjhqHycJ43hX0gZwlyL0P0NdVul08IBgfc2gTeB
 TXVfEACbYV4vQfQTuZ4fhSG1GKwCDd6pfhYWRasPa3IPkni0udk+S3YHQElK8ZtQGth6
 ao0nrHrLJiEUZbG1A9kTuu4S5wl9ZJ/9+XKjld07KWsC6EG3WcP+RNfF05TRSsPHKbhY
 R2z/SjINg18Yf56LX1jwQlftMFFnDtIerMi29j7Jumh3dzJqZgzjCBVz6k5BUgntJC3E
 fA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279782; x=1698884582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zT14RAopyAvl8kuzSxXdtDC5GmRV87HsUcPsxZmEC3k=;
 b=R3COay3o8HZrRURtkea6JZuJdSONzOtZeDWIqipDLPsDl/cxskz6wIplOdNwdLrWL0
 o6h8h9P6CrVh6bUnuPV70bsozbIDyOatfldxltIUswsA6u4MvqhEeYWlP+is2QuhDF/A
 6HCmv4eGAja5CWdmfnP9kesTJ9KNSQHYq6end+JB5xLzBAgqpp3RQLGsqBLthSLsSQBx
 KoKvgpmfvf/fLdH1XD4iJqpOCpH85YF2i4LvdK8atCmx3uxAWArjXj54r+qjY+Hw7wSz
 00tILJQEU177vUkTPmf9OIZjgdyOrpGzp2RnZ7TlMHQq642EOBFlHuMLruWEHCqyyIxR
 z3iw==
X-Gm-Message-State: AOJu0YwJPZpQHGdEywY1BC0zqSrYuayUlCJr+NPWKfIFrY6ygWbwPlvU
 2x5cxa8LDkD4t5LK75HVteOrWL8NuwZVrSKlU+o=
X-Google-Smtp-Source: AGHT+IFzFIC3fu/ri4Gfr+0bpOQWHk4Nkp5Jxy6UJrLHrIOJGibv4M+O9Cmjn3bGRol5Ywof0pMjFg==
X-Received: by 2002:a17:90b:2b85:b0:27d:1339:9176 with SMTP id
 rs5-20020a17090b2b8500b0027d13399176mr14652551pjb.25.1698279782019; 
 Wed, 25 Oct 2023 17:23:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 66/94] target/sparc: Move BMASK to decodetree
Date: Wed, 25 Oct 2023 17:15:14 -0700
Message-Id: <20231026001542.1141412-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 target/sparc/translate.c  | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f70423895e..db372573a2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -255,6 +255,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
+
+    BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5d2be34135..ee0c263a99 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4264,6 +4264,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
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
@@ -4803,7 +4815,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5168,15 +5179,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


