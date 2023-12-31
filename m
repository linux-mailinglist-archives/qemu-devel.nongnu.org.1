Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B756820A85
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:49:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSG-0004Fp-JH; Sun, 31 Dec 2023 03:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSE-0004Ev-GD
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrS8-0000k6-0t
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKnarzPge3T7gBJR8Oe4meLzv57xBhU4WI8tmjyo7zo=;
 b=N+zEEplQ27pz86Z2RyCQANrLpdek7UJ6DvnwWfpkeVfX79VgYXePm3fmvSG2k5EhnANtY7
 2PkB9ye8Lp39rzFwOuEK8xLEuSKUSFtIX288dcGc4J5g/XGDG4IHeXxxwYopzazmkq9aUM
 3SbWZpeeFpzP3fvipxRtWh4kWm4QExk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-HcnPLzNwOkODGvI9QxznAw-1; Sun, 31 Dec 2023 03:45:45 -0500
X-MC-Unique: HcnPLzNwOkODGvI9QxznAw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a27c3388fb7so37792266b.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012343; x=1704617143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKnarzPge3T7gBJR8Oe4meLzv57xBhU4WI8tmjyo7zo=;
 b=N2sLHK9x6lliPGSc70UfXcs+XivYoczgaR/21Jv7wCyFUKYjD8yPLJ0EDfBhzSGrIr
 zvk70+od9UQtxSFWpyKV7cWs3VrYzBuakiXh0YKU3VCnfyIhvqAXo4WcRHiilBVtmgUR
 dBhnNJq8PblVYaOLa80tRO69KehTI7owFPjqMfxzlmzAcI4/o4KG+sCgj0/swKftumTr
 avAlMLNMvOs5CaaTZLHAcDAfy1U/uWq9kJNGCGLJmfF6mqbvgcPQi1SV1nWL340CIIHm
 FOjzNo5i+xyIqjok1QGKY2Pp0aBUw4qEm4H8evBH90Y7ZONaAWT2RVIqcWyTIYDtzEZn
 OAcQ==
X-Gm-Message-State: AOJu0Yy2BcfPzQBCFZIbqXczDKFnff010DVUNfPGkxevNI+u8pbll8AH
 CSPuWZs16tWZCzxsQcY70I/3E58NM+DHU2gWJ5dKll9gDIVzuOSAaK/J7inhSaJr9n3h1OXfJZL
 8fc7GI9WP7GGpGaIvaWLRyy+ntRaPXen+pxwkoRHd2k48fFTm30haYPPr2v3FmVU/c15MOv/ntZ
 OadODXrSU=
X-Received: by 2002:a05:6402:373:b0:556:a33:2a87 with SMTP id
 s19-20020a056402037300b005560a332a87mr797971edw.77.1704012343474; 
 Sun, 31 Dec 2023 00:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuRNrzD4usshUf5y5WL6pnj6WXBgMs6B37z+sja+ZwIAewBu1GpXbjqYsz9HzsKLEaPJclgw==
X-Received: by 2002:a05:6402:373:b0:556:a33:2a87 with SMTP id
 s19-20020a056402037300b005560a332a87mr797967edw.77.1704012343190; 
 Sun, 31 Dec 2023 00:45:43 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 cf26-20020a0564020b9a00b00554af5ec62asm9401648edb.8.2023.12.31.00.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/46] target/i386: do not clobber T0 on string operations
Date: Sun, 31 Dec 2023 09:44:30 +0100
Message-ID: <20231231084502.235366-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The new decoder would rather have the operand in T0 when expanding SCAS, rather
than use R_EAX directly as gen_scas currently does.  This makes SCAS more similar
to CMP and SUB, in that CC_DST = T0 - T1.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 45 ++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index efef4e74d4c..00ed0cc9a31 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -522,9 +522,9 @@ void gen_op_add_reg_im(DisasContext *s, MemOp size, int reg, int32_t val)
     gen_op_mov_reg_v(s, size, reg, s->tmp0);
 }
 
-static inline void gen_op_add_reg_T0(DisasContext *s, MemOp size, int reg)
+static inline void gen_op_add_reg(DisasContext *s, MemOp size, int reg, TCGv val)
 {
-    tcg_gen_add_tl(s->tmp0, cpu_regs[reg], s->T0);
+    tcg_gen_add_tl(s->tmp0, cpu_regs[reg], val);
     gen_op_mov_reg_v(s, size, reg, s->tmp0);
 }
 
@@ -707,10 +707,12 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
     gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);
 }
 
-static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
+static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
 {
-    tcg_gen_ld32s_tl(s->T0, tcg_env, offsetof(CPUX86State, df));
-    tcg_gen_shli_tl(s->T0, s->T0, ot);
+    TCGv dshift = tcg_temp_new();
+    tcg_gen_ld32s_tl(dshift, tcg_env, offsetof(CPUX86State, df));
+    tcg_gen_shli_tl(dshift, dshift, ot);
+    return dshift;
 };
 
 static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
@@ -818,13 +820,16 @@ static bool gen_check_io(DisasContext *s, MemOp ot, TCGv_i32 port,
 
 static void gen_movs(DisasContext *s, MemOp ot)
 {
+    TCGv dshift;
+
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_ESI);
-    gen_op_add_reg_T0(s, s->aflag, R_EDI);
+
+    dshift = gen_compute_Dshift(s, ot);
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
 static void gen_op_update1_cc(DisasContext *s)
@@ -1249,8 +1254,7 @@ static void gen_stos(DisasContext *s, MemOp ot)
     gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_EDI);
+    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
 }
 
 static void gen_lods(DisasContext *s, MemOp ot)
@@ -1258,8 +1262,7 @@ static void gen_lods(DisasContext *s, MemOp ot)
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_ESI);
+    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
 }
 
 static void gen_scas(DisasContext *s, MemOp ot)
@@ -1267,19 +1270,21 @@ static void gen_scas(DisasContext *s, MemOp ot)
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_op(s, OP_CMPL, ot, R_EAX);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_EDI);
+    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
 }
 
 static void gen_cmps(DisasContext *s, MemOp ot)
 {
+    TCGv dshift;
+
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
     gen_op(s, OP_CMPL, ot, OR_TMP0);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_ESI);
-    gen_op_add_reg_T0(s, s->aflag, R_EDI);
+
+    dshift = gen_compute_Dshift(s, ot);
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
 static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
@@ -1307,8 +1312,7 @@ static void gen_ins(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     gen_helper_in_func(ot, s->T0, s->tmp2_i32);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_EDI);
+    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
@@ -1321,8 +1325,7 @@ static void gen_outs(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
     gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
-    gen_op_movl_T0_Dshift(s, ot);
-    gen_op_add_reg_T0(s, s->aflag, R_ESI);
+    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
-- 
2.43.0


