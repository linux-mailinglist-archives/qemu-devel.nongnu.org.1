Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411981CE5D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4o-000167-Vq; Fri, 22 Dec 2023 13:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4f-00011p-U9
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4b-0006D5-UN
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrtIswxIr6pTTxrk/G5OGghEcqNmtA1ORfqbcyj/2WY=;
 b=KuPwqM2L8xzjsZeirtkkjYwwv0EOa3sl/zgwCNeAG5gLNHry7BYjiZVcUqt51BNAqbFGVL
 I7QS2eYjcCqnbIfG0q1rwE62w5WW6D4yqu+f2laGNUnbxFAGX5N7FGVqqS57XAogjWkub7
 z/Z5y9HzUNha6/3E/7YfeKNmcG52PYU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-z6R4hkfMM2KAsVilSU4aZQ-1; Fri, 22 Dec 2023 13:16:32 -0500
X-MC-Unique: z6R4hkfMM2KAsVilSU4aZQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5545aa32c47so937865a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268991; x=1703873791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrtIswxIr6pTTxrk/G5OGghEcqNmtA1ORfqbcyj/2WY=;
 b=YPEJqPTnNFUPCVwZSuGFgl8lvwV6s0JzMOAYzY4V7w/eXHDKdvHYcA4FBc+Pe+1MNy
 ckhzYS68AxzMvts6YQxjJW4/yPRD5GdZz4PX4lRbcaudOF09AZsSLcvMhcjgZQckx45O
 TbFBhNqMh0Ye6SuVeC5llvVwnwokn0bf03tINeFsTpmkQiAruVCdbs4pYF8uWEx4E3vX
 2wW8r/hjBMBmzNeavuge2gk86Vt6ohA+yrU5peB+XuaO4bFq2kJVkzUhDsL/kvCXun1l
 drR4J0yly537Wa6sQzh8XedDCReYaWBGsLFwiFLgcqF7bad6f8mHfM51FrsOfgip46b7
 DEug==
X-Gm-Message-State: AOJu0YxQ673Td82PWzyLjEh41WjBx/XxT0b1/QkLSAnbu1uPYtI7TAPy
 0zZ2ab3gHj2gTB3ECHx4p+5HqejFAWZT4kYpda0AYhxemvxJBNsI/DSv7EiCMmLmsQeUVZLb+EB
 W4/2sdmsp/AjxYdYwmbx9PIVdX6oAfdjAtCyc6dz1A+IW3sZxJSOijmPBktMj+XmWzpAD7zrlN2
 MwWYO7sIc=
X-Received: by 2002:a50:9f28:0:b0:553:98f0:a495 with SMTP id
 b37-20020a509f28000000b0055398f0a495mr1695209edf.3.1703268991108; 
 Fri, 22 Dec 2023 10:16:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnTumEnNbtlOjJuASqGn7Eix/X0Z9tAXK/ZlHGGIZN/SnxfH2OBMEDDzd5VOA2cfElYt/9uw==
X-Received: by 2002:a50:9f28:0:b0:553:98f0:a495 with SMTP id
 b37-20020a509f28000000b0055398f0a495mr1695199edf.3.1703268990823; 
 Fri, 22 Dec 2023 10:16:30 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05640207d100b005538d504793sm2844560edy.23.2023.12.22.10.16.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/22] target/i386: do not clobber T0 on string operations
Date: Fri, 22 Dec 2023 19:15:54 +0100
Message-ID: <20231222181603.174137-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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


