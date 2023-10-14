Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED37C9404
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTK-0002dQ-51; Sat, 14 Oct 2023 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbTG-0002c7-Sa
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbTF-00043C-0f
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpdWFUP0vMGhbrH5/Yc8WKNagHY+QCFuagQ4DnKD+Uw=;
 b=KtA4QRsc+ctRv+UJUWPJcQDEoI1gsoFE9Exc1qRhSXrnkW3G3hwomvJO4UMxwx6M8nEl8V
 1xBtp6jQoIIAry9Q6thmSEhucR+Qd/rcl7+fsEJqutIozBrsZNC5J9uimYK2wgQaknYJEo
 LPKko37U3qIgQm6KDEW0CKgJB1y9vcM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-LW49qxm8PsGcBZboSOGNNA-1; Sat, 14 Oct 2023 06:01:56 -0400
X-MC-Unique: LW49qxm8PsGcBZboSOGNNA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53dd901c9c3so2299101a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277715; x=1697882515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpdWFUP0vMGhbrH5/Yc8WKNagHY+QCFuagQ4DnKD+Uw=;
 b=fgp1ReVRzLtTxNKflztLe1/jLQO6X7SPKIfY9gEH202nD6lenBc/YWqii77HVJNCX9
 U0R4EoPTL4OzYk2ZOvaB7aN7TutCPSyspPYj1/lDra91R2856EBz62ViwUcF0XWqyKqc
 toV5pWR1I3+UzD9q+OYVwuzOysXDNtNjeeO1+AkBrxcOBSGZT2jmlQrrlC82t5D72ncy
 HjGE6uP08on5tEojXyvLwXtr0Z95PYTv0vXNT3Zk9EjV9OuvtPRjY+1GquG2fe0U2OcS
 /bwVwhxY+dn3ZlG2K333laQZGwpTf1buxeNe644Ibbd9uczFarB7oTvtG00+pdjEGy5n
 ut0Q==
X-Gm-Message-State: AOJu0YzJPXSGj/pPyv6ZpyhhAuXixUlH2GRzYnU+AoW8wSstR+U4YV4Q
 vVumhoS1an3+3N/au2T0KzqytXa6oHIxEBdlI9YliOYaeU4tg1Hr+HhF2OO8yl3Sb7+pp3yORWp
 JAhMF3qgo1G2Fc1YVD358WShTGviyjPKWc4EP/aKxOb8q4e/sTjEwD+Zwa5nR0kgODwwoAN3v68
 U=
X-Received: by 2002:aa7:cfc8:0:b0:538:7678:44e4 with SMTP id
 r8-20020aa7cfc8000000b00538767844e4mr24553614edy.2.1697277714693; 
 Sat, 14 Oct 2023 03:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsTRVMno3ycO2oilVrUYa1TzCRHiqGaxkeztLUDNV4l26Pmd9sqAoans5oq9LzbgL5G+NUGg==
X-Received: by 2002:aa7:cfc8:0:b0:538:7678:44e4 with SMTP id
 r8-20020aa7cfc8000000b00538767844e4mr24553599edy.2.1697277714269; 
 Sat, 14 Oct 2023 03:01:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 ec22-20020a0564020d5600b0053defc8c15asm3942995edb.51.2023.10.14.03.01.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] target/i386: remove gen_op
Date: Sat, 14 Oct 2023 12:01:20 +0200
Message-ID: <20231014100121.109817-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used anymore by the old decoder, inline the CMP case into CMPS and SCAS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 145 +++---------------------------------
 1 file changed, 12 insertions(+), 133 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6e091fdb7f6..3d5cdf4d29a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -238,21 +238,8 @@ static void gen_eob(DisasContext *s);
 static void gen_jr(DisasContext *s);
 static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num);
 static void gen_jmp_rel_csize(DisasContext *s, int diff, int tb_num);
-static void gen_op(DisasContext *s1, int op, MemOp ot, int d);
 static void gen_exception_gpf(DisasContext *s);
 
-/* i386 arith/logic operations */
-enum {
-    OP_ADDL,
-    OP_ORL,
-    OP_ADCL,
-    OP_SBBL,
-    OP_ANDL,
-    OP_SUBL,
-    OP_XORL,
-    OP_CMPL,
-};
-
 /* i386 shift ops */
 enum {
     OP_ROL,
@@ -853,13 +840,6 @@ static void gen_op_update2_cc(DisasContext *s)
     tcg_gen_mov_tl(cpu_cc_dst, s->T0);
 }
 
-static void gen_op_update3_cc(DisasContext *s, TCGv reg)
-{
-    tcg_gen_mov_tl(cpu_cc_src2, reg);
-    tcg_gen_mov_tl(cpu_cc_src, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-}
-
 static inline void gen_op_testl_T0_T1_cc(DisasContext *s)
 {
     tcg_gen_and_tl(cpu_cc_dst, s->T0, s->T1);
@@ -1288,7 +1268,12 @@ static void gen_scas(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
-    gen_op(s, OP_CMPL, ot, R_EAX);
+    gen_op_mov_v_reg(s, ot, s->T0, R_EAX);
+    tcg_gen_mov_tl(cpu_cc_src, s->T1);
+    tcg_gen_mov_tl(s->cc_srcT, s->T0);
+    tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
+    set_cc_op(s, CC_OP_SUBB + ot);
+
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
 }
@@ -1298,7 +1283,12 @@ static void gen_cmps(DisasContext *s, MemOp ot)
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
-    gen_op(s, OP_CMPL, ot, OR_TMP0);
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    tcg_gen_mov_tl(cpu_cc_src, s->T1);
+    tcg_gen_mov_tl(s->cc_srcT, s->T0);
+    tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
+    set_cc_op(s, CC_OP_SUBB + ot);
+
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_ESI);
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
@@ -1506,117 +1496,6 @@ static bool check_iopl(DisasContext *s)
     return false;
 }
 
-/* if d == OR_TMP0, it means memory operand (address in A0) */
-static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
-{
-    if (d != OR_TMP0) {
-        if (s1->prefix & PREFIX_LOCK) {
-            /* Lock prefix when destination is not memory.  */
-            gen_illegal_opcode(s1);
-            return;
-        }
-        gen_op_mov_v_reg(s1, ot, s1->T0, d);
-    } else if (!(s1->prefix & PREFIX_LOCK)) {
-        gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-    }
-    switch(op) {
-    case OP_ADCL:
-        gen_compute_eflags_c(s1, s1->tmp4);
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, s1->tmp4, s1->T1);
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->tmp4);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update3_cc(s1, s1->tmp4);
-        set_cc_op(s1, CC_OP_ADCB + ot);
-        break;
-    case OP_SBBL:
-        gen_compute_eflags_c(s1, s1->tmp4);
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, s1->T1, s1->tmp4);
-            tcg_gen_neg_tl(s1->T0, s1->T0);
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->tmp4);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update3_cc(s1, s1->tmp4);
-        set_cc_op(s1, CC_OP_SBBB + ot);
-        break;
-    case OP_ADDL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update2_cc(s1);
-        set_cc_op(s1, CC_OP_ADDB + ot);
-        break;
-    case OP_SUBL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_neg_tl(s1->T0, s1->T1);
-            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-            tcg_gen_sub_tl(s1->T0, s1->cc_srcT, s1->T1);
-        } else {
-            tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update2_cc(s1);
-        set_cc_op(s1, CC_OP_SUBB + ot);
-        break;
-    default:
-    case OP_ANDL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_and_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_and_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_ORL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_or_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                       s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_or_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_XORL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_xor_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_xor_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_CMPL:
-        tcg_gen_mov_tl(cpu_cc_src, s1->T1);
-        tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
-        tcg_gen_sub_tl(cpu_cc_dst, s1->T0, s1->T1);
-        set_cc_op(s1, CC_OP_SUBB + ot);
-        break;
-    }
-}
-
 /* if d == OR_TMP0, it means memory operand (address in A0) */
 static void gen_inc(DisasContext *s1, MemOp ot, int d, int c)
 {
-- 
2.41.0


