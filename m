Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5727D797C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoCk-0003io-Kn; Wed, 25 Oct 2023 20:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCf-0003bX-Vs
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCe-0000Zn-5y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5b856d73a12so301590a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279982; x=1698884782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQF3etiI8esxPvJgRU7maR5kYUtpFP3hIg8XqhuROnM=;
 b=NB6BpZhnyT4ljfbyrFS1szRwoQScY6lDcDvRuabPfrOhznxhNPtd8XmKJB1uQBx0wG
 Id7EpL2bbvUmE3Q4QgcL8Yv670axoSfRIXdxRyERPRGDKOHEWayNoRZZ0CpmnAzs/41w
 Cxg9FnPh+RJjlmSdFri7JqajyRMPWOzBHbCoUZd2b0kBcYPDCAk9ZWLG4BZGjEldSfod
 NAcCyi8c3cv+/a9Uux+8wJS/H5ihZR7K1f0iu5DoOglmsenMbJyTz6qaoSIc3L6r7Nwb
 E7s3Q9DliiTKOMJKbu7T7Ku7ZyII1MkdHYOaDrtu6cXLyCFzOYykv2U1B3PC4Scj8Mjs
 GQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279982; x=1698884782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQF3etiI8esxPvJgRU7maR5kYUtpFP3hIg8XqhuROnM=;
 b=A+PovdGxOROni3YQF1taVdPhzQOacRHhiJKRiwDQVGl/Q7veP2dzG5L4cZnkvB3AxC
 lvkaWkLb9kJVRwD//f9dCu/0bxO/k5RokCuWI2wCA7zvnw/8hssLz2C+FzYHIPrLT3Mn
 ofvYuy0HUY0ZxRQLuOHvrI9el8Ir/kzJP2GsQ98pLSkI/SRBRXj7UO4habcznn4yzZH/
 RZzvQSwVC/s2sgXWdmUN3kANxlv7kAglhxt1ibgPgNhBwGgowkNadiNW5Or+EYM20yy/
 84dTzQTWmMHN4xBbuY5WBZN+ypFUaPNXhbXcJcehQ8Ekjb+cYV9dwu0dPbv9wD5x5SJ2
 P8OA==
X-Gm-Message-State: AOJu0YxvDPI9X4AWeI+WCv68LW6U78NJLbmaPIb8PGtKq0FWgmDWpL/B
 WOQlB4Af5jykURGp4E8ll7gXAjo00nX2wi/GjHw=
X-Google-Smtp-Source: AGHT+IE7dEFJRr3PRC53k67Ey+kzI0hbm2eTDDLeLfyx0RXDyBiOb10vIU0Eqgp0x380ONVvPW2AHA==
X-Received: by 2002:a17:90b:3812:b0:27d:3f08:cc21 with SMTP id
 mq18-20020a17090b381200b0027d3f08cc21mr17856206pjb.5.1698279982626; 
 Wed, 25 Oct 2023 17:26:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gv24-20020a17090b11d800b00262ca945cecsm438134pjb.54.2023.10.25.17.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 92/94] target/sparc: Move FPACK16, FPACKFIX to decodetree
Date: Wed, 25 Oct 2023 17:15:40 -0700
Message-Id: <20231026001542.1141412-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 target/sparc/translate.c  | 55 ++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 781c3cd7f7..18a840709f 100644
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
index 3ee1015cc4..15c91c6caa 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -756,6 +756,24 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4589,6 +4607,26 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
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
@@ -5265,10 +5303,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5351,21 +5388,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


