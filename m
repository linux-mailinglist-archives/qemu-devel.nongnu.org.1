Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 981307C9406
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTJ-0002dI-Fv; Sat, 14 Oct 2023 06:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT7-0002aV-IZ
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT4-00041m-9F
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nhn1J+V0Lp+hXlSmkE2LXj8IpgJGlbfgLmItrRofT44=;
 b=UYwnnqG1mc/mXtPvV7MKYDe6XKxCLfxu10taX51o3/9p+oVt2xlLPhB13KuMuLV27crrM4
 5aNUTOFEvA1neEVziJJft4xKcq4A0AEMwW3NMp/tbSgWpvIlkMApI7xw1ZZt5XIYroi9FX
 kFxYgKpdsM3rAFh0W5Fx+z8gvL7B/P4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-UDCFdVFtMsaiEBjWGlmktQ-1; Sat, 14 Oct 2023 06:01:55 -0400
X-MC-Unique: UDCFdVFtMsaiEBjWGlmktQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso221761066b.1
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277713; x=1697882513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nhn1J+V0Lp+hXlSmkE2LXj8IpgJGlbfgLmItrRofT44=;
 b=bkT6hh13o3R/tIgfEmHobC7WiHg65RgHYTfflayrENAnX8hPJvfzhJ7DEi9ug7adxb
 HRy1qGpc+1KE0rlvRRbBEwkGJuPE27CkCpZn3BPSN1cskZPJqyyZ15DBMXbR9B3ch08L
 pN1Xb8Z72fjhUwfJ+HE4OyUv6cfKXGslVIXWUCXc58kVtcJpD1xEEUzjHhRrW9f7IpBR
 Zk55fAlF5xZUqVp945lDfFn6TT1hW9gxW1hYrdiU3GFb+YifKJdFnnERM80OHSvj9bmE
 2CBI6WE4roUk1Ro8sZRu2IfTuyrwnrfLPWy8Ul9QDXhuVHZlKkodYYxOsscsCy51rCik
 ihEg==
X-Gm-Message-State: AOJu0Yy2UDjJBxBdlsrONfE+i8kIXfLKF/uh7SBtsFzgmi10M0FFkAL5
 /uKjG5NoNUWrnYMrVNy8WQ2W1CHsS/USlpuE0GgmLnzVG/XUGeGsrX+xh5YuQAdTyd87vnZ0H7l
 7PXkzGtURGjOfslByJ8CQRNPjfiFtQj3LEByztsMZ2mq09xW9Ge1MUvUZcXgk8lci/c+jdMFGw3
 4=
X-Received: by 2002:a17:906:5396:b0:9ae:4f13:e581 with SMTP id
 g22-20020a170906539600b009ae4f13e581mr24744515ejo.59.1697277713498; 
 Sat, 14 Oct 2023 03:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqgx2AgJSdR3tarEU728MqqxrcyT+KJVB/bP9tb2TdJSXfNv/qRxqPo9QlKcPZAFzS8fRlIQ==
X-Received: by 2002:a17:906:5396:b0:9ae:4f13:e581 with SMTP id
 g22-20020a170906539600b009ae4f13e581mr24744495ejo.59.1697277712779; 
 Sat, 14 Oct 2023 03:01:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a170906535b00b009b27d4153cfsm739937ejo.176.2023.10.14.03.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/18] target/i386: remove now converted opcodes from old
 decoder
Date: Sat, 14 Oct 2023 12:01:19 +0200
Message-ID: <20231014100121.109817-18-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 705 +-----------------------------------
 1 file changed, 4 insertions(+), 701 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1f3cc6361c0..6e091fdb7f6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3176,7 +3176,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && b <= 0xbf) {
+        if (use_new && 0) {
             disas_insn_new(s, cpu, b);
             return true;
         }
@@ -3186,9 +3186,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new &&
-	    ((b >= 0x140 && b <= 0x14f) ||
-	     (b >= 0x180 && b <= 0x19f))) {
+        if (use_new && 0) {
             disas_insn_new(s, cpu, b);
             return true;
         }
@@ -3289,119 +3287,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     switch (b) {
         /**************************/
         /* arith & logic */
-    case 0x00 ... 0x05:
-    case 0x08 ... 0x0d:
-    case 0x10 ... 0x15:
-    case 0x18 ... 0x1d:
-    case 0x20 ... 0x25:
-    case 0x28 ... 0x2d:
-    case 0x30 ... 0x35:
-    case 0x38 ... 0x3d:
-        {
-            int f;
-            op = (b >> 3) & 7;
-            f = (b >> 1) & 3;
-
-            ot = mo_b_d(b, dflag);
-
-            switch(f) {
-            case 0: /* OP Ev, Gv */
-                modrm = x86_ldub_code(env, s);
-                reg = ((modrm >> 3) & 7) | REX_R(s);
-                mod = (modrm >> 6) & 3;
-                rm = (modrm & 7) | REX_B(s);
-                if (mod != 3) {
-                    gen_lea_modrm(env, s, modrm);
-                    opreg = OR_TMP0;
-                } else if (op == OP_XORL && rm == reg) {
-                xor_zero:
-                    /* xor reg, reg optimisation */
-                    set_cc_op(s, CC_OP_CLR);
-                    tcg_gen_movi_tl(s->T0, 0);
-                    gen_op_mov_reg_v(s, ot, reg, s->T0);
-                    break;
-                } else {
-                    opreg = rm;
-                }
-                gen_op_mov_v_reg(s, ot, s->T1, reg);
-                gen_op(s, op, ot, opreg);
-                break;
-            case 1: /* OP Gv, Ev */
-                modrm = x86_ldub_code(env, s);
-                mod = (modrm >> 6) & 3;
-                reg = ((modrm >> 3) & 7) | REX_R(s);
-                rm = (modrm & 7) | REX_B(s);
-                if (mod != 3) {
-                    gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, s->T1, s->A0);
-                } else if (op == OP_XORL && rm == reg) {
-                    goto xor_zero;
-                } else {
-                    gen_op_mov_v_reg(s, ot, s->T1, rm);
-                }
-                gen_op(s, op, ot, reg);
-                break;
-            case 2: /* OP A, Iv */
-                val = insn_get(env, s, ot);
-                tcg_gen_movi_tl(s->T1, val);
-                gen_op(s, op, ot, OR_EAX);
-                break;
-            }
-        }
-        break;
-
-    case 0x82:
-        if (CODE64(s))
-            goto illegal_op;
-        /* fall through */
-    case 0x80: /* GRP1 */
-    case 0x81:
-    case 0x83:
-        {
-            ot = mo_b_d(b, dflag);
-
-            modrm = x86_ldub_code(env, s);
-            mod = (modrm >> 6) & 3;
-            rm = (modrm & 7) | REX_B(s);
-            op = (modrm >> 3) & 7;
-
-            if (mod != 3) {
-                if (b == 0x83)
-                    s->rip_offset = 1;
-                else
-                    s->rip_offset = insn_const_size(ot);
-                gen_lea_modrm(env, s, modrm);
-                opreg = OR_TMP0;
-            } else {
-                opreg = rm;
-            }
-
-            switch(b) {
-            default:
-            case 0x80:
-            case 0x81:
-            case 0x82:
-                val = insn_get(env, s, ot);
-                break;
-            case 0x83:
-                val = (int8_t)insn_get(env, s, MO_8);
-                break;
-            }
-            tcg_gen_movi_tl(s->T1, val);
-            gen_op(s, op, ot, opreg);
-        }
-        break;
-
-        /**************************/
-        /* inc, dec, and other misc arith */
-    case 0x40 ... 0x47: /* inc Gv */
-        ot = dflag;
-        gen_inc(s, ot, OR_EAX + (b & 7), 1);
-        break;
-    case 0x48 ... 0x4f: /* dec Gv */
-        ot = dflag;
-        gen_inc(s, ot, OR_EAX + (b & 7), -1);
-        break;
     case 0xf6: /* GRP3 */
     case 0xf7:
         ot = mo_b_d(b, dflag);
@@ -3725,81 +3610,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 
-    case 0x84: /* test Ev, Gv */
-    case 0x85:
-        ot = mo_b_d(b, dflag);
-
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_op_mov_v_reg(s, ot, s->T1, reg);
-        gen_op_testl_T0_T1_cc(s);
-        set_cc_op(s, CC_OP_LOGICB + ot);
-        break;
-
-    case 0xa8: /* test eAX, Iv */
-    case 0xa9:
-        ot = mo_b_d(b, dflag);
-        val = insn_get(env, s, ot);
-
-        gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
-        tcg_gen_movi_tl(s->T1, val);
-        gen_op_testl_T0_T1_cc(s);
-        set_cc_op(s, CC_OP_LOGICB + ot);
-        break;
-
-    case 0x98: /* CWDE/CBW */
-        switch (dflag) {
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-            tcg_gen_ext32s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
-            break;
-#endif
-        case MO_32:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
-            tcg_gen_ext16s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
-            break;
-        case MO_16:
-            gen_op_mov_v_reg(s, MO_8, s->T0, R_EAX);
-            tcg_gen_ext8s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 0x99: /* CDQ/CWD */
-        switch (dflag) {
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
-            tcg_gen_sari_tl(s->T0, s->T0, 63);
-            gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
-            break;
-#endif
-        case MO_32:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-            tcg_gen_ext32s_tl(s->T0, s->T0);
-            tcg_gen_sari_tl(s->T0, s->T0, 31);
-            gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
-            break;
-        case MO_16:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
-            tcg_gen_ext16s_tl(s->T0, s->T0);
-            tcg_gen_sari_tl(s->T0, s->T0, 15);
-            gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
     case 0x1af: /* imul Gv, Ev */
-    case 0x69: /* imul Gv, Ev, I */
-    case 0x6b:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
@@ -4008,53 +3819,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
         /**************************/
         /* push/pop */
-    case 0x50 ... 0x57: /* push */
-        gen_op_mov_v_reg(s, MO_32, s->T0, (b & 7) | REX_B(s));
-        gen_push_v(s, s->T0);
-        break;
-    case 0x58 ... 0x5f: /* pop */
-        ot = gen_pop_T0(s);
-        /* NOTE: order is important for pop %sp */
-        gen_pop_update(s, ot);
-        gen_op_mov_reg_v(s, ot, (b & 7) | REX_B(s), s->T0);
-        break;
-    case 0x60: /* pusha */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_pusha(s);
-        break;
-    case 0x61: /* popa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_popa(s);
-        break;
-    case 0x68: /* push Iv */
-    case 0x6a:
-        ot = mo_pushpop(s, dflag);
-        if (b == 0x68)
-            val = insn_get(env, s, ot);
-        else
-            val = (int8_t)insn_get(env, s, MO_8);
-        tcg_gen_movi_tl(s->T0, val);
-        gen_push_v(s, s->T0);
-        break;
-    case 0x8f: /* pop Ev */
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        ot = gen_pop_T0(s);
-        if (mod == 3) {
-            /* NOTE: order is important for pop %sp */
-            gen_pop_update(s, ot);
-            rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        } else {
-            /* NOTE: order is important too for MMU exceptions */
-            s->popl_esp_hack = 1 << ot;
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
-            s->popl_esp_hack = 0;
-            gen_pop_update(s, ot);
-        }
-        break;
     case 0xc8: /* enter */
         {
             int level;
@@ -4066,30 +3830,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xc9: /* leave */
         gen_leave(s);
         break;
-    case 0x06: /* push es */
-    case 0x0e: /* push cs */
-    case 0x16: /* push ss */
-    case 0x1e: /* push ds */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_op_movl_T0_seg(s, b >> 3);
-        gen_push_v(s, s->T0);
-        break;
     case 0x1a0: /* push fs */
     case 0x1a8: /* push gs */
         gen_op_movl_T0_seg(s, (b >> 3) & 7);
         gen_push_v(s, s->T0);
         break;
-    case 0x07: /* pop es */
-    case 0x17: /* pop ss */
-    case 0x1f: /* pop ds */
-        if (CODE64(s))
-            goto illegal_op;
-        reg = b >> 3;
-        ot = gen_pop_T0(s);
-        gen_movl_seg_T0(s, reg);
-        gen_pop_update(s, ot);
-        break;
     case 0x1a1: /* pop fs */
     case 0x1a9: /* pop gs */
         ot = gen_pop_T0(s);
@@ -4099,15 +3844,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
         /**************************/
         /* mov */
-    case 0x88:
-    case 0x89: /* mov Gv, Ev */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        /* generate a generic store */
-        gen_ldst_modrm(env, s, modrm, ot, reg, 1);
-        break;
     case 0xc6:
     case 0xc7: /* mov Ev, Iv */
         ot = mo_b_d(b, dflag);
@@ -4125,33 +3861,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_mov_reg_v(s, ot, (modrm & 7) | REX_B(s), s->T0);
         }
         break;
-    case 0x8a:
-    case 0x8b: /* mov Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-        break;
-    case 0x8e: /* mov seg, Gv */
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        if (reg >= 6 || reg == R_CS)
-            goto illegal_op;
-        gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-        gen_movl_seg_T0(s, reg);
-        break;
-    case 0x8c: /* mov Gv, seg */
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        mod = (modrm >> 6) & 3;
-        if (reg >= 6)
-            goto illegal_op;
-        gen_op_movl_T0_seg(s, reg);
-        ot = mod == 3 ? dflag : MO_16;
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
-        break;
 
     case 0x1b6: /* movzbS Gv, Eb */
     case 0x1b7: /* movzwS Gv, Eb */
@@ -4203,40 +3912,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 
-    case 0x8d: /* lea */
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
-            TCGv ea = gen_lea_modrm_1(s, a, false);
-            gen_lea_v_seg(s, s->aflag, ea, -1, -1);
-            gen_op_mov_reg_v(s, dflag, reg, s->A0);
-        }
-        break;
-
-    case 0xa0: /* mov EAX, Ov */
-    case 0xa1:
-    case 0xa2: /* mov Ov, EAX */
-    case 0xa3:
-        {
-            target_ulong offset_addr;
-
-            ot = mo_b_d(b, dflag);
-            offset_addr = insn_get_addr(env, s, s->aflag);
-            tcg_gen_movi_tl(s->A0, offset_addr);
-            gen_add_A0_ds_seg(s);
-            if ((b & 2) == 0) {
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-                gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
-            } else {
-                gen_op_mov_v_reg(s, ot, s->T0, R_EAX);
-                gen_op_st_v(s, ot, s->T0, s->A0);
-            }
-        }
-        break;
     case 0xd7: /* xlat */
         tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
         tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
@@ -4246,59 +3921,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_ld_v(s, MO_8, s->T0, s->A0);
         gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
         break;
-    case 0xb0 ... 0xb7: /* mov R, Ib */
-        val = insn_get(env, s, MO_8);
-        tcg_gen_movi_tl(s->T0, val);
-        gen_op_mov_reg_v(s, MO_8, (b & 7) | REX_B(s), s->T0);
-        break;
-    case 0xb8 ... 0xbf: /* mov R, Iv */
-#ifdef TARGET_X86_64
-        if (dflag == MO_64) {
-            uint64_t tmp;
-            /* 64 bit case */
-            tmp = x86_ldq_code(env, s);
-            reg = (b & 7) | REX_B(s);
-            tcg_gen_movi_tl(s->T0, tmp);
-            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
-        } else
-#endif
-        {
-            ot = dflag;
-            val = insn_get(env, s, ot);
-            reg = (b & 7) | REX_B(s);
-            tcg_gen_movi_tl(s->T0, val);
-            gen_op_mov_reg_v(s, ot, reg, s->T0);
-        }
-        break;
-
-    case 0x91 ... 0x97: /* xchg R, EAX */
-    do_xchg_reg_eax:
-        ot = dflag;
-        reg = (b & 7) | REX_B(s);
-        rm = R_EAX;
-        goto do_xchg_reg;
-    case 0x86:
-    case 0x87: /* xchg Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3) {
-            rm = (modrm & 7) | REX_B(s);
-        do_xchg_reg:
-            gen_op_mov_v_reg(s, ot, s->T0, reg);
-            gen_op_mov_v_reg(s, ot, s->T1, rm);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        } else {
-            gen_lea_modrm(env, s, modrm);
-            gen_op_mov_v_reg(s, ot, s->T0, reg);
-            /* for xchg, lock is implicit */
-            tcg_gen_atomic_xchg_tl(s->T1, s->A0, s->T0,
-                                   s->mem_index, ot | MO_LE);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        }
-        break;
     case 0xc4: /* les Gv */
         /* In CODE64 this is VEX3; see above.  */
         op = R_ES;
@@ -4973,91 +4595,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             }
         }
         break;
-        /************************/
-        /* string ops */
-
-    case 0xa4: /* movsS */
-    case 0xa5:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_movs(s, ot);
-        } else {
-            gen_movs(s, ot);
-        }
-        break;
-
-    case 0xaa: /* stosS */
-    case 0xab:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_stos(s, ot);
-        } else {
-            gen_stos(s, ot);
-        }
-        break;
-    case 0xac: /* lodsS */
-    case 0xad:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_lods(s, ot);
-        } else {
-            gen_lods(s, ot);
-        }
-        break;
-    case 0xae: /* scasS */
-    case 0xaf:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & PREFIX_REPNZ) {
-            gen_repz_scas(s, ot, 1);
-        } else if (prefixes & PREFIX_REPZ) {
-            gen_repz_scas(s, ot, 0);
-        } else {
-            gen_scas(s, ot);
-        }
-        break;
-
-    case 0xa6: /* cmpsS */
-    case 0xa7:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & PREFIX_REPNZ) {
-            gen_repz_cmps(s, ot, 1);
-        } else if (prefixes & PREFIX_REPZ) {
-            gen_repz_cmps(s, ot, 0);
-        } else {
-            gen_cmps(s, ot);
-        }
-        break;
-    case 0x6c: /* insS */
-    case 0x6d:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32,
-                          SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_ins(s, ot);
-        } else {
-            gen_ins(s, ot);
-        }
-        break;
-    case 0x6e: /* outsS */
-    case 0x6f:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_STR_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_outs(s, ot);
-        } else {
-            gen_outs(s, ot);
-        }
-        break;
 
         /************************/
         /* port I/O */
@@ -5188,21 +4725,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
-    case 0x9a: /* lcall im */
-        {
-            unsigned int selector, offset;
-
-            if (CODE64(s))
-                goto illegal_op;
-            ot = dflag;
-            offset = insn_get(env, s, ot);
-            selector = insn_get(env, s, MO_16);
-
-            tcg_gen_movi_tl(s->T0, selector);
-            tcg_gen_movi_tl(s->T1, offset);
-        }
-        gen_far_call(s);
-        break;
     case 0xe9: /* jmp im */
         {
             int diff = (dflag != MO_16
@@ -5232,89 +4754,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
-    case 0x70 ... 0x7f: /* jcc Jb */
-        {
-            int diff = (int8_t)insn_get(env, s, MO_8);
-            gen_bnd_jmp(s);
-            gen_jcc(s, b, diff);
-        }
-        break;
-    case 0x180 ... 0x18f: /* jcc Jv */
-        {
-            int diff = (dflag != MO_16
-                        ? (int32_t)insn_get(env, s, MO_32)
-                        : (int16_t)insn_get(env, s, MO_16));
-            gen_bnd_jmp(s);
-            gen_jcc(s, b, diff);
-        }
-        break;
-
-    case 0x190 ... 0x19f: /* setcc Gv */
-        modrm = x86_ldub_code(env, s);
-        gen_setcc1(s, b, s->T0);
-        gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
-        break;
-    case 0x140 ... 0x14f: /* cmov Gv, Ev */
-        if (!(s->cpuid_features & CPUID_CMOV)) {
-            goto illegal_op;
-        }
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_cmovcc1(s, b ^ 1, s->T0, cpu_regs[reg]);
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-        break;
 
         /************************/
         /* flags */
-    case 0x9c: /* pushf */
-        gen_svm_check_intercept(s, SVM_EXIT_PUSHF);
-        if (check_vm86_iopl(s)) {
-            gen_update_cc_op(s);
-            gen_helper_read_eflags(s->T0, tcg_env);
-            gen_push_v(s, s->T0);
-        }
-        break;
-    case 0x9d: /* popf */
-        gen_svm_check_intercept(s, SVM_EXIT_POPF);
-        if (check_vm86_iopl(s)) {
-            int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
-
-            if (CPL(s) == 0) {
-                mask |= IF_MASK | IOPL_MASK;
-            } else if (CPL(s) <= IOPL(s)) {
-                mask |= IF_MASK;
-            }
-            if (dflag == MO_16) {
-                mask &= 0xffff;
-            }
-
-            ot = gen_pop_T0(s);
-            gen_helper_write_eflags(tcg_env, s->T0, tcg_constant_i32(mask));
-            gen_pop_update(s, ot);
-            set_cc_op(s, CC_OP_EFLAGS);
-            /* abort translation because TF/AC flag may change */
-            s->base.is_jmp = DISAS_EOB_NEXT;
-        }
-        break;
-    case 0x9e: /* sahf */
-        if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
-            goto illegal_op;
-        tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-        gen_compute_eflags(s);
-        tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
-        tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
-        tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
-        break;
-    case 0x9f: /* lahf */
-        if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
-            goto illegal_op;
-        gen_compute_eflags(s);
-        /* Note: gen_compute_eflags() only gives the condition codes */
-        tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
-        tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
-        break;
     case 0xf5: /* cmc */
         gen_compute_eflags(s);
         tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
@@ -5527,34 +4969,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
         /************************/
         /* bcd */
-    case 0x27: /* daa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_daa(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x2f: /* das */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_das(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x37: /* aaa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_aaa(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x3f: /* aas */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_aas(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
     case 0xd4: /* aam */
         if (CODE64(s))
             goto illegal_op;
@@ -5575,32 +4989,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
         /************************/
         /* misc */
-    case 0x90: /* nop */
-        /* XXX: correct lock test for all insn */
-        if (prefixes & PREFIX_LOCK) {
-            goto illegal_op;
-        }
-        /* If REX_B is set, then this is xchg eax, r8d, not a nop.  */
-        if (REX_B(s)) {
-            goto do_xchg_reg_eax;
-        }
-        if (prefixes & PREFIX_REPZ) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
-        }
-        break;
-    case 0x9b: /* fwait */
-        if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) ==
-            (HF_MP_MASK | HF_TS_MASK)) {
-            gen_exception(s, EXCP07_PREX);
-        } else {
-            /* needs to be treated as I/O because of ferr_irq */
-            translator_io_start(&s->base);
-            gen_helper_fwait(tcg_env);
-        }
-        break;
     case 0xcc: /* int3 */
         gen_interrupt(s, EXCP03_INT3);
         break;
@@ -5636,24 +5024,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_eob_inhibit_irq(s, true);
         }
         break;
-    case 0x62: /* bound */
-        if (CODE64(s))
-            goto illegal_op;
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        gen_op_mov_v_reg(s, ot, s->T0, reg);
-        gen_lea_modrm(env, s, modrm);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        if (ot == MO_16) {
-            gen_helper_boundw(tcg_env, s->A0, s->tmp2_i32);
-        } else {
-            gen_helper_boundl(tcg_env, s->A0, s->tmp2_i32);
-        }
-        break;
     case 0x1c8 ... 0x1cf: /* bswap reg */
         reg = (b & 7) | REX_B(s);
 #ifdef TARGET_X86_64
@@ -6205,72 +5575,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* nothing to do */
         }
         break;
-    case 0x63: /* arpl or movslS (x86_64) */
-#ifdef TARGET_X86_64
-        if (CODE64(s)) {
-            int d_ot;
-            /* d_ot is the size of destination */
-            d_ot = dflag;
-
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            mod = (modrm >> 6) & 3;
-            rm = (modrm & 7) | REX_B(s);
-
-            if (mod == 3) {
-                gen_op_mov_v_reg(s, MO_32, s->T0, rm);
-                /* sign extend */
-                if (d_ot == MO_64) {
-                    tcg_gen_ext32s_tl(s->T0, s->T0);
-                }
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            } else {
-                gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            }
-        } else
-#endif
-        {
-            TCGLabel *label1;
-            TCGv t0, t1, t2;
-
-            if (!PE(s) || VM86(s))
-                goto illegal_op;
-            t0 = tcg_temp_new();
-            t1 = tcg_temp_new();
-            t2 = tcg_temp_new();
-            ot = MO_16;
-            modrm = x86_ldub_code(env, s);
-            reg = (modrm >> 3) & 7;
-            mod = (modrm >> 6) & 3;
-            rm = modrm & 7;
-            if (mod != 3) {
-                gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, ot, t0, s->A0);
-            } else {
-                gen_op_mov_v_reg(s, ot, t0, rm);
-            }
-            gen_op_mov_v_reg(s, ot, t1, reg);
-            tcg_gen_andi_tl(s->tmp0, t0, 3);
-            tcg_gen_andi_tl(t1, t1, 3);
-            tcg_gen_movi_tl(t2, 0);
-            label1 = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GE, s->tmp0, t1, label1);
-            tcg_gen_andi_tl(t0, t0, ~3);
-            tcg_gen_or_tl(t0, t0, t1);
-            tcg_gen_movi_tl(t2, CC_Z);
-            gen_set_label(label1);
-            if (mod != 3) {
-                gen_op_st_v(s, ot, t0, s->A0);
-           } else {
-                gen_op_mov_reg_v(s, ot, rm, t0);
-            }
-            gen_compute_eflags(s);
-            tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_Z);
-            tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, t2);
-        }
-        break;
     case 0x102: /* lar */
     case 0x103: /* lsl */
         {
@@ -6851,11 +6155,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
         set_cc_op(s, CC_OP_POPCNT);
         break;
+    case 0     ... 0xbf:
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
-    case 0x138 ... 0x13a:
-    case 0x150 ... 0x179:
-    case 0x17c ... 0x17f:
+    case 0x138 ... 0x19f:
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-- 
2.41.0


