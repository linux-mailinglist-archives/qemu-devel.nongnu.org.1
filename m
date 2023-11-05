Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE87E1650
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:15:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUE-0003Sd-Dg; Sun, 05 Nov 2023 15:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjUB-0003RI-RT
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:43 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjUA-0002BF-6b
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:43 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5b92b852390so2993371a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215160; x=1699819960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A78suQY9V9iQl5jBJ+5kjMF55wPobXhyeLKa16NEwCk=;
 b=gdhf2TTKcxEUD1++rP5SwjRo468jGxgzzRie/SXFFvjPXeuyZ6ZNEAy2dJyETw6Lij
 rJTPgZpMaHYcuNUmFlSMeN6dCGH/iUmuNXYMzgQ66dSvx8nT6TtJHWp4mbPGaM8Bw5gZ
 Qvir7em33NKTw7TcXM2eaO3y301cw0Q3TPEBfoWlJuUqLgy+Ewa/JMfZaEgD6ArjU2qs
 iSN4j5ziVYyev3lXSPBVuqiUOdAvc+o1SscMU/R6Xsy0v12oHeVNFuN4O/PQe6u0usC+
 JaqA78PNKcq11hcAGV4kFmxkDu9qXZySW5GNExQGpOAMFGr5+aJObnqlfEuJ/c1c5WWv
 mjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215160; x=1699819960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A78suQY9V9iQl5jBJ+5kjMF55wPobXhyeLKa16NEwCk=;
 b=MIjpIErBf0Sfio3Dlased8E2omijB61FE1/7hbo5rtRbgUZjswImerX/Z89NzTN3gb
 DJKUV7feEDpBjwec+m2k4RYzbNnZvxWkaXRcLqQVPR/3cH4wwGw4rvLfI+Hv6dnaGkcC
 6MvJeRmtxea7zI5mt4oz6eohEKX8mf3O9DlqmHxa2D+XAxcZzJ0x/ONmUeVXPfWejB6k
 VDSmE0D4iQEk998YJWzF3DUi/P85cx7/MSpNb4JlkEoX9MKo9BwvYxjZ2kKy43tu+gfz
 eP+KlmEGJLv+M76NNe8eSHMQF5UTYJqWcyeTiVC1lfLWe46JLrxI3KCSlyFPK1q7wQ10
 BQNQ==
X-Gm-Message-State: AOJu0YyY+TpG14qhajL3egDdz2IJS1eBGW0VBmI/C0KO+kxDgBG+Nndj
 J9maAFQ+DaMuRNIdlboI3Ye4w0jv7djMT75mqA0=
X-Google-Smtp-Source: AGHT+IFbAskkbgPgtWnrutcqyoQfbOwyiDYF/Ak/7jf77+0BApoIKGyKIi8UDBS0lhXVcLnaqT6G/A==
X-Received: by 2002:a05:6a21:a597:b0:161:76a4:4f74 with SMTP id
 gd23-20020a056a21a59700b0016176a44f74mr38581984pzc.1.1699215160687; 
 Sun, 05 Nov 2023 12:12:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 20/21] target/sparc: Implement UDIV inline
Date: Sun,  5 Nov 2023 12:12:21 -0800
Message-Id: <20231105201222.202395-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/insns.decode |  3 +-
 target/sparc/translate.c  | 67 +++++++++++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 52f54b87cc..2d26404cb2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -184,7 +184,8 @@ MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
-UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
+UDIV        10 ..... 001110 ..... . .............          @r_r_ri
+UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri_cc1
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
 TADDcc      10 ..... 100000 ..... . .............          @r_r_ri_cc1
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 95cc4c71f4..4b7d943bae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -577,18 +577,6 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
-static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
-{
-#ifdef TARGET_SPARC64
-    gen_helper_udiv(dst, tcg_env, src1, src2);
-    tcg_gen_ext32u_tl(dst, dst);
-#else
-    TCGv_i64 t64 = tcg_temp_new_i64();
-    gen_helper_udiv(t64, tcg_env, src1, src2);
-    tcg_gen_trunc_i64_tl(dst, t64);
-#endif
-}
-
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3568,7 +3556,7 @@ TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 TRANS(MULScc, ALL, do_arith, a, NULL, NULL, gen_op_mulscc)
 
-TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(UDIVcc, DIV, do_arith, a, NULL, NULL, gen_op_udivcc)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
@@ -3591,6 +3579,59 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_logic(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
 }
 
+static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv_i64 t1, t2;
+    TCGv dst;
+
+    if (!avail_DIV(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    if (a->imm) {
+        t2 = tcg_constant_i64((uint32_t)a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+        TCGv_i32 n2;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        n2 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(n2, cpu_regs[a->rs2_or_imm]);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, n2, 0, lab);
+
+        t2 = tcg_temp_new_i64();
+#ifdef TARGET_SPARC64
+        tcg_gen_ext32u_i64(t2, cpu_regs[a->rs2_or_imm]);
+#else
+        tcg_gen_extu_i32_i64(t2, cpu_regs[a->rs2_or_imm]);
+#endif
+    }
+
+    t1 = tcg_temp_new_i64();
+    tcg_gen_concat_tl_i64(t1, gen_load_gpr(dc, a->rs1), cpu_y);
+
+    tcg_gen_divu_i64(t1, t1, t2);
+    tcg_gen_umin_i64(t1, t1, tcg_constant_i64(UINT32_MAX));
+
+    dst = gen_dest_gpr(dc, a->rd);
+    tcg_gen_trunc_i64_tl(dst, t1);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
 {
     TCGv dst, src1, src2;
-- 
2.34.1


