Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2081CE58
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4t-00019H-1v; Fri, 22 Dec 2023 13:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4i-000131-TK
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4f-0006Di-P7
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrczuoSSHdg9ifBogSmmIOzEe01wTYB7FQsssBQIDFc=;
 b=BFcVVD+d0Xt+kFsuamPjUrz6vtOpYc9o2HLh4qQAuOdJOIy91GPrZeJfjSC0yV6WhHHoDa
 MofNeRVW68rq45KOmXhDmFVdzElHFXnMPhoq+H17hc6+D07YuzDQtygBNZWNlG/DoVsP4t
 WJPntR8oIT7VXT/VBBdxACrJox0O5nA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-fnVk5_29PNiC5YpSKVWfqQ-1; Fri, 22 Dec 2023 13:16:39 -0500
X-MC-Unique: fnVk5_29PNiC5YpSKVWfqQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2336591d48so101850266b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268998; x=1703873798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrczuoSSHdg9ifBogSmmIOzEe01wTYB7FQsssBQIDFc=;
 b=qTAmF+BPrQXhKVnXcHqp9T/SyQMA/dSarfqKg99lveriegWQtM+L1U3dLYumWx5apz
 CNvO/y3WRRgrUTVWO5wbe+VIYLrskIdRgM/dWxx1xOPqTSkL25l1UFuF4/yEptJE9oBd
 GW9hMEW/XbpIOwAKY2ffpkIiTMVTKRVeTxZ8vZRagjk23fqgTkjscJ+fjlJ3faoF6qFD
 UwBEL4493MCgqAUHgMcBh2KzbL2ktCr0BzJdhkRhtj9V2ykBJLQedGqSM1qguDagFVGw
 oUrANTMbSqzUlIvUTjoomuQr7YwsHo5u6HNQo60goR7gCQjoLu9sq79b5GKbusWJbOB3
 Alcw==
X-Gm-Message-State: AOJu0Ywvpl/iOkZFArf15D8blEXwWJWetuRef1Bn9yn9XqAiv7ffP/0r
 EAN1zKEniSTv+Jtzgrt7fwW4ESx3E8IDMFhc5z4M332o0qUSRU9Uk6LqciEydC0rCJlZnibTu3t
 FRzIdP0hF7NkFIXME2vsthQBs2ybtjdte3lS+hi5kCODe9yixQZbcnuG1cEAAriX562eKSCg0YO
 xHxSeXDFo=
X-Received: by 2002:a17:907:1b1c:b0:a23:46df:f449 with SMTP id
 mp28-20020a1709071b1c00b00a2346dff449mr1235286ejc.55.1703268997906; 
 Fri, 22 Dec 2023 10:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhcTYtbgGUF8PKf67GlNt2WAdnFfdrVytuoY4//get9r0GzcDR4IIxW93wYfddF0yN86ySSA==
X-Received: by 2002:a17:907:1b1c:b0:a23:46df:f449 with SMTP id
 mp28-20020a1709071b1c00b00a2346dff449mr1235282ejc.55.1703268997604; 
 Fri, 22 Dec 2023 10:16:37 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 az15-20020a170907904f00b00a26aa734349sm1780713ejc.39.2023.12.22.10.16.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/22] target/i386: extract gen_far_call/jmp,
 reordering temporaries
Date: Fri, 22 Dec 2023 19:15:58 +0100
Message-ID: <20231222181603.174137-18-pbonzini@redhat.com>
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

Extract the code into new functions, and swap T0/T1 so that T0 corresponds
to the first immediate in the instruction stream.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 90 ++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e5f71170967..edbad0ad746 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2525,12 +2525,12 @@ static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
                      offsetof(CPUX86State,segs[seg_reg].selector));
 }
 
-static inline void gen_op_movl_seg_T0_vm(DisasContext *s, X86Seg seg_reg)
+static inline void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 {
-    tcg_gen_ext16u_tl(s->T0, s->T0);
-    tcg_gen_st32_tl(s->T0, tcg_env,
+    tcg_gen_ext16u_tl(seg, seg);
+    tcg_gen_st32_tl(seg, tcg_env,
                     offsetof(CPUX86State,segs[seg_reg].selector));
-    tcg_gen_shli_tl(cpu_seg_base[seg_reg], s->T0, 4);
+    tcg_gen_shli_tl(cpu_seg_base[seg_reg], seg, 4);
 }
 
 /* move T0 to seg_reg and compute if the CPU state may change. Never
@@ -2550,13 +2550,43 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-        gen_op_movl_seg_T0_vm(s, seg_reg);
+        gen_op_movl_seg_real(s, seg_reg, s->T0);
         if (seg_reg == R_SS) {
             s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
         }
     }
 }
 
+static void gen_far_call(DisasContext *s)
+{
+    if (PE(s) && !VM86(s)) {
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
+        gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T0,
+                                   tcg_constant_i32(s->dflag - 1),
+                                   eip_next_tl(s));
+    } else {
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        gen_helper_lcall_real(tcg_env, s->tmp3_i32, s->tmp2_i32,
+                              tcg_constant_i32(s->dflag - 1),
+                              eip_next_i32(s));
+    }
+    s->base.is_jmp = DISAS_JUMP;
+}
+
+static void gen_far_jmp(DisasContext *s)
+{
+    if (PE(s) && !VM86(s)) {
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
+        gen_helper_ljmp_protected(tcg_env, s->tmp2_i32, s->T0,
+                                  eip_next_tl(s));
+    } else {
+        gen_op_movl_seg_real(s, R_CS, s->T1);
+        gen_op_jmp_v(s, s->T0);
+    }
+    s->base.is_jmp = DISAS_JUMP;
+}
+
 static void gen_svm_check_intercept(DisasContext *s, uint32_t type)
 {
     /* no SVM activated; fast case */
@@ -3637,23 +3667,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             if (mod == 3) {
                 goto illegal_op;
             }
-            gen_op_ld_v(s, ot, s->T1, s->A0);
+            gen_op_ld_v(s, ot, s->T0, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        do_lcall:
-            if (PE(s) && !VM86(s)) {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T1,
-                                           tcg_constant_i32(dflag - 1),
-                                           eip_next_tl(s));
-            } else {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-                gen_helper_lcall_real(tcg_env, s->tmp2_i32, s->tmp3_i32,
-                                      tcg_constant_i32(dflag - 1),
-                                      eip_next_i32(s));
-            }
-            s->base.is_jmp = DISAS_JUMP;
+            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_far_call(s);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -3667,19 +3684,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             if (mod == 3) {
                 goto illegal_op;
             }
-            gen_op_ld_v(s, ot, s->T1, s->A0);
+            gen_op_ld_v(s, ot, s->T0, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        do_ljmp:
-            if (PE(s) && !VM86(s)) {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_ljmp_protected(tcg_env, s->tmp2_i32, s->T1,
-                                          eip_next_tl(s));
-            } else {
-                gen_op_movl_seg_T0_vm(s, R_CS);
-                gen_op_jmp_v(s, s->T1);
-            }
-            s->base.is_jmp = DISAS_JUMP;
+            gen_op_ld_v(s, MO_16, s->T1, s->A0);
+            gen_far_jmp(s);
             break;
         case 6: /* push Ev */
             gen_push_v(s, s->T0);
@@ -5117,7 +5125,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
             gen_op_ld_v(s, dflag, s->T0, s->A0);
-            gen_op_movl_seg_T0_vm(s, R_CS);
+            gen_op_movl_seg_real(s, R_CS, s->T0);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
         }
@@ -5161,10 +5169,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
-            tcg_gen_movi_tl(s->T0, selector);
-            tcg_gen_movi_tl(s->T1, offset);
+            tcg_gen_movi_tl(s->T0, offset);
+            tcg_gen_movi_tl(s->T1, selector);
         }
-        goto do_lcall;
+        gen_far_call(s);
+        break;
     case 0xe9: /* jmp im */
         {
             int diff = (dflag != MO_16
@@ -5184,10 +5193,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
-            tcg_gen_movi_tl(s->T0, selector);
-            tcg_gen_movi_tl(s->T1, offset);
+            tcg_gen_movi_tl(s->T0, offset);
+            tcg_gen_movi_tl(s->T1, selector);
         }
-        goto do_ljmp;
+        gen_far_jmp(s);
+        break;
     case 0xeb: /* jmp Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
-- 
2.43.0


