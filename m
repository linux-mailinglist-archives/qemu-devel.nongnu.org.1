Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF637D1B1C
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:45:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4hs-0007Se-HV; Sat, 21 Oct 2023 01:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hi-0007EY-Bd
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:20 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hg-0001Yc-74
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:17 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3573fa82923so6080565ab.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866755; x=1698471555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HXRF77ypBGYaTatyquMGFrTMLlLpCipd1xIO1RgxiY=;
 b=Z+LlaflVxJGIY2U7UewIoDijg62Qoy4CzKEkcNId/QRCGcyaS3xpGPtqXm2qkn0jxM
 pdMtAigltttu08T+2rGZ3TQn8uhsoAY9K20WenfUop+pjBmmZSPXntqYskGdk3uZb1+T
 apSJovNeiVUO2bQKynY6+MSuMxnjRpmQ9vu82eORpHqlXYwKFXRF6886IkRCcjnIqgfo
 MceKjMjxRVUE0pabuq25kD1OJ+F28nIYGyCjSYjlomV8k5IsgNu1v96tpUnfmqvNaWLE
 LtCws30dwlr8V6pQuxPhQZbRpsJ95V3+drXiVUgDHeJxtSZTNyxYktNytySvvT93Zru6
 UHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866755; x=1698471555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HXRF77ypBGYaTatyquMGFrTMLlLpCipd1xIO1RgxiY=;
 b=teftX3m9IBEfRC7EDjgpE88yHW5wcVGtjGYo59H1PXpSU5ldeP4bROlH8mxlVE6cQd
 +Ar7yeWpb9Wra/2MWvjRmeYhwWBXOmn/5a1YwKAAh7kv5KCrq3Cp4544q3L9c+HzeJ8m
 qOO3Qu1aQDywH6Z5uLWF+i2XfK1LR1KHSyB6Y1cg6nBMMwp+d5Ea8FqZsw/um36aTIZD
 YrkYeiM9kyAQrzrgHWR7JbNvYpjTaMTVjWwJscx4zLXgyKDBL5dB0qlFOoEQLrA5E/VT
 ggY1zL7SDV06VK8VHGNKjhnMCf7dAaKKLKiNVb3OYvYKmg2moDbGX7Y3UqTfhsP1Ve1Y
 yn5A==
X-Gm-Message-State: AOJu0YxazL4EhqNhNPkvc5zHmkdo1A6oTy6emTwNUogtr6WL2otaBIxH
 BwQ9mCKLLwxCBq/obUI6ZNvEDGw0cBAttYrCMVk=
X-Google-Smtp-Source: AGHT+IEYOqwXMNhjT+nQYwx9fYMqUdHgiotefR7n2DnYlj4rwrnjcLBYM0fEBjZ6wk8fU8tpqetkjQ==
X-Received: by 2002:a05:6e02:1bac:b0:352:6251:2364 with SMTP id
 n12-20020a056e021bac00b0035262512364mr5442845ili.11.1697866755072; 
 Fri, 20 Oct 2023 22:39:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 88/90] target/sparc: Move FPACK16, FPACKFIX to decodetree
Date: Fri, 20 Oct 2023 22:31:56 -0700
Message-Id: <20231021053158.278135-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
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
 target/sparc/translate.c  | 55 ++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f557371e56..d03bddc689 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -344,6 +344,8 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
     FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
+    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_r2
+    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_r2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cf70837e05..39cdcba56e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -752,6 +752,24 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_shli_tl(dst, dst, 2);
 }
 
+static void gen_op_fpack16(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpack16(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_fpackfix(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpackfix(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -4706,6 +4724,26 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_fd(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i32, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FPACK16, VIS1, do_fd, a, gen_op_fpack16)
+TRANS(FPACKFIX, VIS1, do_fd, a, gen_op_fpackfix)
+
 static bool do_env_ff(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
@@ -5385,10 +5423,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_src1_64, cpu_dst_64;
+                TCGv_i64 cpu_dst_64;
                 TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rs2 = GET_FIELD(insn, 27, 31);
                 int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
@@ -5471,21 +5508,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x02a: /* VIS I fcmpeq16 */
                 case 0x02c: /* VIS I fcmpgt32 */
                 case 0x02e: /* VIS I fcmpeq32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x03b: /* VIS I fpack16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpack16(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
                 case 0x03d: /* VIS I fpackfix */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


