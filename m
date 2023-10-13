Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390927C7F6A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4g-0001kw-0o; Fri, 13 Oct 2023 03:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4X-00010j-Iq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4T-0006w8-CQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40651a72807so18841885e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183934; x=1697788734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gfslYJ4F1Who76ChLxfqYGvbV8UVuDlWQQYCkYUvXI=;
 b=fVYcRnvpSoOjoGILNSeyGJY/4r6shyEPFX4iP2+0KPXrYnq6Lcrt2UrHxlNZO4OQ+N
 b3LUxCm2d1lbukxqBi3wd6OGRtl5IOQh0RdzVG3F4rSCKJbw/Ix0rh1pk9WaXgGoaNDX
 6195MMfXiAG9v75/5zu+AFh2quMoRQbsT2hDgs7vfx/zfRbpvQsHuyetox2slnL8Z5nX
 DeYqRZ4IgmOQ4KoRmA5yyZvwlh/FbDQbvV3sIjbNe6U7vG46/QUxCbKjz3ypnLVyEwqh
 wa7OkxdTmpDpKKXj1w70Qmzh58XankWPo75v5IgtpE+OqiK3nFOOrTBLGf5bbYtDyfKC
 RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183934; x=1697788734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gfslYJ4F1Who76ChLxfqYGvbV8UVuDlWQQYCkYUvXI=;
 b=PEh+okYvKOdV3EstaB3m6xnXtuDaYO62mcjMmceuFAYPNS8Gdv5fkbivM+CcRi+i87
 l5jj//zUu8rc7a8GlDNq4bW3XcZYJBE604Py/+u13vXYME01ulC8rBdO4MuZr3aApGIm
 KcDIbnlMIGY+oETWAB+05HdH3SrL30jGuLq+jWc4skiIsB8tP8x6eNWEMYxtWsv43p1n
 HYkNTtw7+m//5mwtRTWcyaarBNJKYEF+7vjPIDHfn1UMOlcN7PAHj7IutJva2rVD5pJQ
 fyj5Ow8cvMldd4sGaOgJkmEjIcEhst5VkrfPF/LaFnb9cN0Wll81UmRdl7AYeUGN1/E7
 nqIw==
X-Gm-Message-State: AOJu0YzliUYsQDk85IJrNnO7y5Jo7UZK4EwUjOhn4sZN1N7Sr1AlefWJ
 DxIVcrDlhqH7Hbissmh5N6YjBnwyfixM7RtIAfc=
X-Google-Smtp-Source: AGHT+IHNQD2qt9kYWho2MuWzJQ7XKUc5PicriduI4Dbq6WT+aXCLLi+hFcsv7qhuKCwJK9vLI5O67A==
X-Received: by 2002:a1c:6a07:0:b0:405:4f78:e128 with SMTP id
 f7-20020a1c6a07000000b004054f78e128mr24097201wmc.4.1697183933714; 
 Fri, 13 Oct 2023 00:58:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:53 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v2 32/78] target/m68k: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:59 +0300
Message-Id: <5b7440c1d602e363ec20ef448418ee0c236537bb.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/m68k/op_helper.c |  3 ++-
 target/m68k/translate.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..65058b9e2f 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -285,147 +285,147 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
 static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = env_cpu(env);
     uint32_t sp;
     uint32_t vector;
     uint16_t sr, oldsr;
 
     if (!is_hw) {
         switch (cs->exception_index) {
         case EXCP_RTE:
             /* Return from an exception.  */
             m68k_rte(env);
             return;
         }
     }
 
     vector = cs->exception_index << 2;
 
     sr = env->sr | cpu_m68k_get_ccr(env);
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         qemu_log("INT %6d: %s(%#x) pc=%08x sp=%08x sr=%04x\n",
                  ++count, m68k_exception_name(cs->exception_index),
                  vector, env->pc, env->aregs[7], sr);
     }
 
     /*
      * MC68040UM/AD,  chapter 9.3.10
      */
 
     /* "the processor first make an internal copy" */
     oldsr = sr;
     /* "set the mode to supervisor" */
     sr |= SR_S;
     /* "suppress tracing" */
     sr &= ~SR_T;
     /* "sets the processor interrupt mask" */
     if (is_hw) {
         sr |= (env->sr & ~SR_I) | (env->pending_level << SR_I_SHIFT);
     }
     cpu_m68k_set_sr(env, sr);
     sp = env->aregs[7];
 
     if (!m68k_feature(env, M68K_FEATURE_UNALIGNED_DATA)) {
         sp &= ~1;
     }
 
     switch (cs->exception_index) {
     case EXCP_ACCESS:
         if (env->mmu.fault) {
             cpu_abort(cs, "DOUBLE MMU FAULT\n");
         }
         env->mmu.fault = true;
         /* push data 3 */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* push data 2 */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* push data 1 */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 1 / push data 0 */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 1 address */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 data */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 address */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 data */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 address */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
         /* fault address */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
         /* write back 1 status */
         sp -= 2;
         cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 2 status */
         sp -= 2;
         cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* write back 3 status */
         sp -= 2;
         cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
         /* special status word */
         sp -= 2;
         cpu_stw_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
         /* effective address */
         sp -= 4;
         cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
 
         do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
         env->mmu.fault = false;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
             qemu_log("            "
                      "ssw:  %08x ea:   %08x sfc:  %d    dfc: %d\n",
                      env->mmu.ssw, env->mmu.ar, env->sfc, env->dfc);
         }
         break;
 
     case EXCP_ILLEGAL:
         do_stack_frame(env, &sp, 0, oldsr, 0, env->pc);
         break;
 
     case EXCP_ADDRESS:
         do_stack_frame(env, &sp, 2, oldsr, 0, env->pc);
         break;
 
     case EXCP_CHK:
     case EXCP_DIV0:
     case EXCP_TRACE:
     case EXCP_TRAPCC:
         do_stack_frame(env, &sp, 2, oldsr, env->mmu.ar, env->pc);
         break;
 
     case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
         if (is_hw && (oldsr & SR_M)) {
             do_stack_frame(env, &sp, 0, oldsr, 0, env->pc);
             oldsr = sr;
             env->aregs[7] = sp;
             cpu_m68k_set_sr(env, sr & ~SR_M);
             sp = env->aregs[7];
             if (!m68k_feature(env, M68K_FEATURE_UNALIGNED_DATA)) {
                 sp &= ~1;
             }
             do_stack_frame(env, &sp, 1, oldsr, 0, env->pc);
             break;
         }
-        /* fall through */
+        fallthrough;
 
     default:
         do_stack_frame(env, &sp, 0, oldsr, 0, env->pc);
         break;
     }
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 }
@@ -880,60 +880,61 @@ struct bf_data {
 static struct bf_data bf_prep(uint32_t addr, int32_t ofs, uint32_t len)
 {
     int bofs, blen;
 
     /* Bound length; map 0 to 32.  */
     len = ((len - 1) & 31) + 1;
 
     /* Note that ofs is signed.  */
     addr += ofs / 8;
     bofs = ofs % 8;
     if (bofs < 0) {
         bofs += 8;
         addr -= 1;
     }
 
     /*
      * Compute the number of bytes required (minus one) to
      * satisfy the bitfield.
      */
     blen = (bofs + len - 1) / 8;
 
     /*
      * Canonicalize the bit offset for data loaded into a 64-bit big-endian
      * word.  For the cases where BLEN is not a power of 2, adjust ADDR so
      * that we can use the next power of two sized load without crossing a
      * page boundary, unless the field itself crosses the boundary.
      */
     switch (blen) {
     case 0:
         bofs += 56;
         break;
     case 1:
         bofs += 48;
         break;
     case 2:
         if (addr & 1) {
             bofs += 8;
             addr -= 1;
         }
         /* fallthru */
+        fallthrough;
     case 3:
         bofs += 32;
         break;
     case 4:
         if (addr & 3) {
             bofs += 8 * (addr & 3);
             addr &= -4;
         }
         break;
     default:
         g_assert_not_reached();
     }
 
     return (struct bf_data){
         .addr = addr,
         .bofs = bofs,
         .blen = blen,
         .len = len,
     };
 }
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4d0110de95..ce102dc585 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -715,67 +715,67 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
 /*
  * Generate code for an "effective address".  Does not adjust the base
  * register for autoincrement addressing modes.
  */
 static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
                          int mode, int reg0, int opsize)
 {
     TCGv reg;
     TCGv tmp;
     uint16_t ext;
     uint32_t offset;
 
     switch (mode) {
     case 0: /* Data register direct.  */
     case 1: /* Address register direct.  */
         return NULL_QREG;
     case 3: /* Indirect postincrement.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
         }
-        /* fallthru */
+        fallthrough;
     case 2: /* Indirect register */
         return get_areg(s, reg0);
     case 4: /* Indirect predecrememnt.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
         }
         reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
         if (reg0 == 7 && opsize == OS_BYTE &&
             m68k_feature(s->env, M68K_FEATURE_M68K)) {
             tcg_gen_subi_i32(tmp, reg, 2);
         } else {
             tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
         }
         return tmp;
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
         ext = read_im16(env, s);
         tcg_gen_addi_i32(tmp, reg, (int16_t)ext);
         return tmp;
     case 6: /* Indirect index + displacement.  */
         reg = get_areg(s, reg0);
         return gen_lea_indexed(env, s, reg);
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
             return tcg_constant_i32(offset);
         case 1: /* Absolute long.  */
             offset = read_im32(env, s);
             return tcg_constant_i32(offset);
         case 2: /* pc displacement  */
             offset = s->pc;
             offset += (int16_t)read_im16(env, s);
             return tcg_constant_i32(offset);
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(env, s, NULL_QREG);
         case 4: /* Immediate.  */
         default:
             return NULL_QREG;
         }
     }
     /* Should never happen.  */
     return NULL_QREG;
 }
@@ -1195,171 +1195,171 @@ typedef struct {
 static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
 {
     TCGv tmp, tmp2;
     TCGCond tcond;
     CCOp op = s->cc_op;
 
     /* The CC_OP_CMP form can handle most normal comparisons directly.  */
     if (op == CC_OP_CMPB || op == CC_OP_CMPW || op == CC_OP_CMPL) {
         c->v1 = QREG_CC_N;
         c->v2 = QREG_CC_V;
         switch (cond) {
         case 2: /* HI */
         case 3: /* LS */
             tcond = TCG_COND_LEU;
             goto done;
         case 4: /* CC */
         case 5: /* CS */
             tcond = TCG_COND_LTU;
             goto done;
         case 6: /* NE */
         case 7: /* EQ */
             tcond = TCG_COND_EQ;
             goto done;
         case 10: /* PL */
         case 11: /* MI */
             c->v2 = tcg_constant_i32(0);
             c->v1 = tmp = tcg_temp_new();
             tcg_gen_sub_i32(tmp, QREG_CC_N, QREG_CC_V);
             gen_ext(tmp, tmp, op - CC_OP_CMPB, 1);
-            /* fallthru */
+            fallthrough;
         case 12: /* GE */
         case 13: /* LT */
             tcond = TCG_COND_LT;
             goto done;
         case 14: /* GT */
         case 15: /* LE */
             tcond = TCG_COND_LE;
             goto done;
         }
     }
 
     c->v2 = tcg_constant_i32(0);
 
     switch (cond) {
     case 0: /* T */
     case 1: /* F */
         c->v1 = c->v2;
         tcond = TCG_COND_NEVER;
         goto done;
     case 14: /* GT (!(Z || (N ^ V))) */
     case 15: /* LE (Z || (N ^ V)) */
         /*
          * Logic operations clear V, which simplifies LE to (Z || N),
          * and since Z and N are co-located, this becomes a normal
          * comparison vs N.
          */
         if (op == CC_OP_LOGIC) {
             c->v1 = QREG_CC_N;
             tcond = TCG_COND_LE;
             goto done;
         }
         break;
     case 12: /* GE (!(N ^ V)) */
     case 13: /* LT (N ^ V) */
         /* Logic operations clear V, which simplifies this to N.  */
         if (op != CC_OP_LOGIC) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     case 10: /* PL (!N) */
     case 11: /* MI (N) */
         /* Several cases represent N normally.  */
         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
             op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL ||
             op == CC_OP_LOGIC) {
             c->v1 = QREG_CC_N;
             tcond = TCG_COND_LT;
             goto done;
         }
         break;
     case 6: /* NE (!Z) */
     case 7: /* EQ (Z) */
         /* Some cases fold Z into N.  */
         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
             op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL ||
             op == CC_OP_LOGIC) {
             tcond = TCG_COND_EQ;
             c->v1 = QREG_CC_N;
             goto done;
         }
         break;
     case 4: /* CC (!C) */
     case 5: /* CS (C) */
         /* Some cases fold C into X.  */
         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
             op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL) {
             tcond = TCG_COND_NE;
             c->v1 = QREG_CC_X;
             goto done;
         }
-        /* fallthru */
+        fallthrough;
     case 8: /* VC (!V) */
     case 9: /* VS (V) */
         /* Logic operations clear V and C.  */
         if (op == CC_OP_LOGIC) {
             tcond = TCG_COND_NEVER;
             c->v1 = c->v2;
             goto done;
         }
         break;
     }
 
     /* Otherwise, flush flag state to CC_OP_FLAGS.  */
     gen_flush_flags(s);
 
     switch (cond) {
     case 0: /* T */
     case 1: /* F */
     default:
         /* Invalid, or handled above.  */
         abort();
     case 2: /* HI (!C && !Z) -> !(C || Z)*/
     case 3: /* LS (C || Z) */
         c->v1 = tmp = tcg_temp_new();
         tcg_gen_setcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
         tcg_gen_or_i32(tmp, tmp, QREG_CC_C);
         tcond = TCG_COND_NE;
         break;
     case 4: /* CC (!C) */
     case 5: /* CS (C) */
         c->v1 = QREG_CC_C;
         tcond = TCG_COND_NE;
         break;
     case 6: /* NE (!Z) */
     case 7: /* EQ (Z) */
         c->v1 = QREG_CC_Z;
         tcond = TCG_COND_EQ;
         break;
     case 8: /* VC (!V) */
     case 9: /* VS (V) */
         c->v1 = QREG_CC_V;
         tcond = TCG_COND_LT;
         break;
     case 10: /* PL (!N) */
     case 11: /* MI (N) */
         c->v1 = QREG_CC_N;
         tcond = TCG_COND_LT;
         break;
     case 12: /* GE (!(N ^ V)) */
     case 13: /* LT (N ^ V) */
         c->v1 = tmp = tcg_temp_new();
         tcg_gen_xor_i32(tmp, QREG_CC_N, QREG_CC_V);
         tcond = TCG_COND_LT;
         break;
     case 14: /* GT (!(Z || (N ^ V))) */
     case 15: /* LE (Z || (N ^ V)) */
         c->v1 = tmp = tcg_temp_new();
         tcg_gen_negsetcond_i32(TCG_COND_EQ, tmp, QREG_CC_Z, c->v2);
         tmp2 = tcg_temp_new();
         tcg_gen_xor_i32(tmp2, QREG_CC_N, QREG_CC_V);
         tcg_gen_or_i32(tmp, tmp, tmp2);
         tcond = TCG_COND_LT;
         break;
     }
 
  done:
     if ((cond & 1) == 0) {
         tcond = tcg_invert_cond(tcond);
     }
     c->tcond = tcond;
 }
@@ -4223,25 +4223,25 @@ DISAS_INSN(ff1)
 DISAS_INSN(chk)
 {
     TCGv src, reg;
     int opsize;
 
     switch ((insn >> 7) & 3) {
     case 3:
         opsize = OS_WORD;
         break;
     case 2:
         if (m68k_feature(env, M68K_FEATURE_CHK2)) {
             opsize = OS_LONG;
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
         return;
     }
     SRC_EA(env, src, opsize, 1, NULL);
     reg = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_flush_flags(s);
     gen_helper_chk(tcg_env, reg, src);
 }
-- 
2.39.2


