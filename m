Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3E7D218D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdX-0006tI-It; Sun, 22 Oct 2023 02:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdR-0006O9-FN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdN-000386-7j
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so1591571b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954896; x=1698559696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCRY2J/deckmDlj0QfEqXFX5UP12wnEnJ1cgBJhM2hU=;
 b=WULRPvLrkDWxaAgM84dg4lkATz25RybACs1zq1Z55X9XKQvt6hYpWuHWDi7NjTotwK
 CRaU685ft7xwnRcT2qE2AzT13Km21fWrFUtImEdfXuXOt7d22DTwZY4jBQ3QUaaJESxz
 GOPawGQY0Y4hJUcOxf3Jc+8LhckTng1esRam5hmssO15QxdjMBifDtZn6PAmemPofzyI
 5gYxJBkkyq0j+S3eiXvUIGZAQimP0bEErGAS1TmPcJfIuU3InilImzt75uterNfs4p/5
 wpLOqEsZTGwwRstS92GWbrLq6q27XsCRHzb6/RZ78DbZIPyU/e68BM1080X2TKFyAbJX
 wuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954896; x=1698559696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCRY2J/deckmDlj0QfEqXFX5UP12wnEnJ1cgBJhM2hU=;
 b=FKlEOLGs3Gsg2Vb+S+aeyfVpZkYjiv82UiEYJT1qTOM4X3XPiDd/gZXQfD1CdJJL+H
 4pcsXOoP7Y5oMQKUTVoUD1Z19Cbn9Bz7nUEKk5kph/FOhOP9HWnVADRLt3AoHGmvLRnF
 rEbult8VbLbShaaerKGKA+f+Pir7CWkRrpdOh6dVys4umwDiG2MQLldFwY/6rVVUsrlQ
 l9OBa0iObd3VtSLhAXHyXY3E2RynbzhIBSKmNPbfrtCdB/xUzI2mO92RMODKZQRLxEFm
 8daPHrjGtRlFjZsZFX1mu5fr3OruO1J5ni0iKKTxh9fS+rYCOneTW1LuPHhW4w8enr59
 XWFA==
X-Gm-Message-State: AOJu0YyiN4LG8REOPLMataa0HPaDv02AlkghDAb8Fhb4mbyRUF1ih7pi
 FNs9/86d1lm6xfpgYb/w+YbWzT4TUis+GeSJ3c4=
X-Google-Smtp-Source: AGHT+IEOrTuvYd2KjJm9Q43p7C+qnLRbwR1xpG6iQsaY+Jk9wUUP5p9vuHpYhE1I+7ZASolAR0M7ew==
X-Received: by 2002:a05:6a21:8188:b0:14d:abc:73dc with SMTP id
 pd8-20020a056a21818800b0014d0abc73dcmr4193611pzb.32.1697954896109; 
 Sat, 21 Oct 2023 23:08:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 88/90] target/sparc: Move FPACK16, FPACKFIX to decodetree
Date: Sat, 21 Oct 2023 23:00:29 -0700
Message-Id: <20231022060031.490251-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index ff849f33e4..286ae7fd42 100644
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
@@ -4749,6 +4767,26 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
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
@@ -5428,10 +5466,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5514,21 +5551,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


