Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CCA90BDA
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Apr 2025 21:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u580y-0005sL-7N; Wed, 16 Apr 2025 15:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u580o-0005ku-NW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:01:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u580l-0003mF-Qh
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:01:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so7083901b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830086; x=1745434886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4idGtTzsQTx1O8uFg+g8pdEHsuBdULcTiygXpcaQs5U=;
 b=nx+aQ5lNcNrR6Hmguzr8mQy+XHBFVEJfTN8Sf9VNiblvgBLbyNSse5t8GPkqYhIpgl
 4u3QjrKuoNvowCdIXbxlz45yyttcDjUb/ifg4Q7kv11suMEQW69R9tJNyI7kaU4sAQot
 gDjE0iNGziczL0iFUfur3RSXs6LeFWbisRtvRdJd2euCAtF/USVcHxJcw6acWlgtWVU2
 2dVrVrYorkgQr2P51H5NEz0VWnVQq5ZF0kMBrIDQQ0ZYEt0ju8bpXSNI5IT1BkgLRbsw
 DTZltYk7fGPxle93+ZZFgy60Zf0ExyI4CscG5GuAG4z0QK1i9qdV/Wd2hU1FPmo/rPRP
 juOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830086; x=1745434886;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4idGtTzsQTx1O8uFg+g8pdEHsuBdULcTiygXpcaQs5U=;
 b=XgC5a5njhj/5uNCdMfj4g5/EvSSuX1455+Tx89OaTY+oy9EL13LEkFNdmNA+XP9g2h
 497lNlZIas6XCHyqTCUHpLicYt3PYi5tPBIQlqyMj/LOtP0Zf2RgDNBG9Y49P27QeRLs
 KE2u+UatT8/nzsPYZc5+9jvHJIDtORe48yrqx4dJ745w7oj/6tomuH28PGBzqL6S7OqD
 sALNVs+ofo7tl+aWmMeFaUrbX0h7WR75jOihUXuIn/Pv5s4LlsoLGSDxAfXSYUJy0RVO
 GRNOAKsUZOgW4PFVOQIPPZ8kupgUa1128WCrwirwhBJhIkNdv1UW1/QOdvr4DenyhgOR
 6M8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBAngKxQaJLtbD4A9ESsxdL8hB8OlUF2etP/jEYYgDB1TvtC8RxN9nvGSE4bd1hB8ol0MQg+YTED9J@nongnu.org
X-Gm-Message-State: AOJu0YyuYmya1yiyddg5+YjOFub+tSr+xVECxLxl0a7xsWwEyJbufXzr
 h4/zX6k00S51e9TDTjPBSsXHF/TGcVT8s1Vap3QhhZ0HLXRco80Gp1dGTHzad2o=
X-Gm-Gg: ASbGncsQeAoWKE+8e2I31Ztb6KuN8dX1BaGqPFHDdIdSWrk/b1vVyiOGJoIA7P6m0bc
 EPthADQbF0rBEFWVe5dRhgvtbXW8z49YLPtyyTM4Tvc8a9PNAbvXVzCKfb4lUvqGlzuGTrPUDMA
 a6oBlLPstAwCvJSE+8aTevP02bfq34+ZpxWNSo0Uq7NTOAD5eJb4uzPqEUDDU/NU9Gso+9oXxBK
 6EoQiUF5vAmsU5Q83B2shIKolv5IIM+jxXyxWcZeuPjs0/KaVOYk86bvu2cz3RmWGCeYBTU8a7P
 hEssVyVUzxITH+xWlGw69vDwj7Yzpup3KkUzorF/ZAw86La9SxISWA==
X-Google-Smtp-Source: AGHT+IHiiub6y9yUfRJPumJixXHuHS3TOYLdyilr0V5dgg7aYnuIg2JqOrEMkQ6LYdPAhtGi6qdg2g==
X-Received: by 2002:a05:6a21:6d91:b0:1f5:6a1a:3284 with SMTP id
 adf61e73a8af0-203b400b43emr4668116637.40.1744830085999; 
 Wed, 16 Apr 2025 12:01:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b22217f8csm1619181a12.69.2025.04.16.12.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:01:25 -0700 (PDT)
Message-ID: <caa2823a-055b-4b10-92e0-8d28cc3d5f44@linaro.org>
Date: Wed, 16 Apr 2025 12:01:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 113/163] tcg: Add add/sub with carry opcodes and
 infrastructure
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-114-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-114-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Liveness needs to track carry-live state in order to
> determine if the (hidden) output of the opcode is used.
> Code generation needs to track carry-live state in order
> to avoid clobbering cpu flags when loading constants.
> 
> So far, output routines and backends are unchanged.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h  |  10 +++
>   include/tcg/tcg.h      |  13 +++-
>   tcg/optimize.c         |  11 +++
>   tcg/tcg.c              | 148 ++++++++++++++++++++++++++++++++++++++---
>   docs/devel/tcg-ops.rst |  61 +++++++++++++++++
>   5 files changed, 233 insertions(+), 10 deletions(-)
> 
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 1f995c54be..9cc20cd62c 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -82,6 +82,16 @@ DEF(shr, 1, 2, 0, TCG_OPF_INT)
>   DEF(sub, 1, 2, 0, TCG_OPF_INT)
>   DEF(xor, 1, 2, 0, TCG_OPF_INT)
>   
> +DEF(addco, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
> +DEF(addc1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
> +DEF(addci, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
> +DEF(addcio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
> +
> +DEF(subbo, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
> +DEF(subb1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
> +DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
> +DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
> +
>   /* load/store */
>   DEF(ld8u_i32, 1, 1, 1, 0)
>   DEF(ld8s_i32, 1, 1, 1, 0)
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index c6b50b5226..aa300a2f8b 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -418,6 +418,11 @@ struct TCGContext {
>       MemOp riscv_cur_vsew;
>       TCGType riscv_cur_type;
>   #endif
> +    /*
> +     * During the tcg_reg_alloc_op loop, we are within a sequence of
> +     * carry-using opcodes like addco+addci.
> +     */
> +    bool carry_live;
>   
>       GHashTable *const_table[TCG_TYPE_COUNT];
>       TCGTempSet free_temps[TCG_TYPE_COUNT];
> @@ -749,13 +754,17 @@ enum {
>       /* Instruction operands are vectors.  */
>       TCG_OPF_VECTOR       = 0x40,
>       /* Instruction is a conditional branch. */
> -    TCG_OPF_COND_BRANCH  = 0x80
> +    TCG_OPF_COND_BRANCH  = 0x80,
> +    /* Instruction produces carry out. */
> +    TCG_OPF_CARRY_OUT    = 0x100,
> +    /* Instruction consumes carry in. */
> +    TCG_OPF_CARRY_IN     = 0x200,
>   };
>   
>   typedef struct TCGOpDef {
>       const char *name;
>       uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
> -    uint8_t flags;
> +    uint16_t flags;
>   } TCGOpDef;
>   
>   extern const TCGOpDef tcg_op_defs[];
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 9595b32d54..5a21f8bfd9 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1214,6 +1214,12 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
>       return finish_folding(ctx, op);
>   }
>   
> +static bool fold_add_carry(OptContext *ctx, TCGOp *op)
> +{
> +    fold_commutative(ctx, op);
> +    return finish_folding(ctx, op);
> +}
> +
>   static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
>   {
>       bool a_const = arg_is_const(op->args[2]) && arg_is_const(op->args[3]);
> @@ -2817,6 +2823,11 @@ void tcg_optimize(TCGContext *s)
>           case INDEX_op_add_vec:
>               done = fold_add_vec(&ctx, op);
>               break;
> +        case INDEX_op_addci:
> +        case INDEX_op_addco:
> +        case INDEX_op_addcio:
> +            done = fold_add_carry(&ctx, op);
> +            break;
>           CASE_OP_32_64(add2):
>               done = fold_add2(&ctx, op);
>               break;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 381e76cfc8..c6a49f5648 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3914,6 +3914,17 @@ liveness_pass_0(TCGContext *s)
>       }
>   }
>   
> +static void assert_carry_dead(TCGContext *s)
> +{
> +    /*
> +     * Carry operations can be separated by a few insns like mov,
> +     * load or store, but they should always be "close", and
> +     * carry-out operations should always be paired with carry-in.
> +     * At various boundaries, carry must have been consumed.
> +     */
> +    tcg_debug_assert(!s->carry_live);
> +}
> +
>   /* Liveness analysis : update the opc_arg_life array to tell if a
>      given input arguments is dead. Instructions updating dead
>      temporaries are removed. */
> @@ -3933,17 +3944,19 @@ liveness_pass_1(TCGContext *s)
>       /* ??? Should be redundant with the exit_tb that ends the TB.  */
>       la_func_end(s, nb_globals, nb_temps);
>   
> +    s->carry_live = false;
>       QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, link, op_prev) {
>           int nb_iargs, nb_oargs;
>           TCGOpcode opc_new, opc_new2;
>           TCGLifeData arg_life = 0;
>           TCGTemp *ts;
>           TCGOpcode opc = op->opc;
> -        const TCGOpDef *def = &tcg_op_defs[opc];
> +        const TCGOpDef *def;
>           const TCGArgConstraint *args_ct;
>   
>           switch (opc) {
>           case INDEX_op_call:
> +            assert_carry_dead(s);
>               {
>                   const TCGHelperInfo *info = tcg_call_info(op);
>                   int call_flags = tcg_call_flags(op);
> @@ -4055,6 +4068,7 @@ liveness_pass_1(TCGContext *s)
>               }
>               break;
>           case INDEX_op_insn_start:
> +            assert_carry_dead(s);
>               break;
>           case INDEX_op_discard:
>               /* mark the temporary as dead */
> @@ -4071,6 +4085,7 @@ liveness_pass_1(TCGContext *s)
>           case INDEX_op_sub2_i64:
>               opc_new = INDEX_op_sub;
>           do_addsub2:
> +            assert_carry_dead(s);
>               /* Test if the high part of the operation is dead, but not
>                  the low part.  The result can be optimized to a simple
>                  add or sub.  This happens often for x86_64 guest when the
> @@ -4096,6 +4111,7 @@ liveness_pass_1(TCGContext *s)
>               opc_new = INDEX_op_mul;
>               opc_new2 = INDEX_op_muluh;
>           do_mul2:
> +            assert_carry_dead(s);
>               if (arg_temp(op->args[1])->state == TS_DEAD) {
>                   if (arg_temp(op->args[0])->state == TS_DEAD) {
>                       /* Both parts of the operation are dead.  */
> @@ -4118,10 +4134,87 @@ liveness_pass_1(TCGContext *s)
>               /* Mark the single-word operation live.  */
>               goto do_not_remove;
>   
> +        case INDEX_op_addco:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            op->opc = opc = INDEX_op_add;
> +            goto do_default;
> +
> +        case INDEX_op_addcio:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            op->opc = opc = INDEX_op_addci;
> +            goto do_default;
> +
> +        case INDEX_op_subbo:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            /* Lower to sub, but this may also require canonicalization. */
> +            op->opc = opc = INDEX_op_sub;
> +            ts = arg_temp(op->args[2]);
> +            if (ts->kind == TEMP_CONST) {
> +                ts = tcg_constant_internal(ts->type, -ts->val);
> +                if (ts->state_ptr == NULL) {
> +                    tcg_debug_assert(temp_idx(ts) == nb_temps);
> +                    nb_temps++;
> +                    ts->state_ptr = tcg_malloc(sizeof(TCGRegSet));
> +                    ts->state = TS_DEAD;
> +                    la_reset_pref(ts);
> +                }
> +                op->args[2] = temp_arg(ts);
> +                op->opc = opc = INDEX_op_add;
> +            }
> +            goto do_default;
> +
> +        case INDEX_op_subbio:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            op->opc = opc = INDEX_op_subbi;
> +            goto do_default;
> +
> +        case INDEX_op_addc1o:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            /* Lower to add, add +1. */
> +            op_prev = tcg_op_insert_before(s, op, INDEX_op_add, 3);
> +            op_prev->args[0] = op->args[0];
> +            op_prev->args[1] = op->args[1];
> +            op_prev->args[2] = op->args[2];
> +            op->opc = opc = INDEX_op_add;
> +            op->args[1] = op->args[0];
> +            ts = arg_temp(op->args[0]);
> +            ts = tcg_constant_internal(ts->type, 1);
> +            op->args[2] = temp_arg(ts);
> +            goto do_default;
> +
> +        case INDEX_op_subb1o:
> +            if (s->carry_live) {
> +                goto do_not_remove;
> +            }
> +            /* Lower to sub, add -1. */
> +            op_prev = tcg_op_insert_before(s, op, INDEX_op_sub, 3);
> +            op_prev->args[0] = op->args[0];
> +            op_prev->args[1] = op->args[1];
> +            op_prev->args[2] = op->args[2];
> +            op->opc = opc = INDEX_op_add;
> +            op->args[1] = op->args[0];
> +            ts = arg_temp(op->args[0]);
> +            ts = tcg_constant_internal(ts->type, -1);
> +            op->args[2] = temp_arg(ts);
> +            goto do_default;
> +
>           default:
> -            /* Test if the operation can be removed because all
> -               its outputs are dead. We assume that nb_oargs == 0
> -               implies side effects */
> +        do_default:
> +            /*
> +             * Test if the operation can be removed because all
> +             * its outputs are dead. We assume that nb_oargs == 0
> +             * implies side effects.
> +             */
>               def = &tcg_op_defs[opc];
>               if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && def->nb_oargs != 0) {
>                   for (int i = def->nb_oargs - 1; i >= 0; i--) {
> @@ -4163,12 +4256,16 @@ liveness_pass_1(TCGContext *s)
>   
>               /* If end of basic block, update.  */
>               if (def->flags & TCG_OPF_BB_EXIT) {
> +                assert_carry_dead(s);
>                   la_func_end(s, nb_globals, nb_temps);
>               } else if (def->flags & TCG_OPF_COND_BRANCH) {
> +                assert_carry_dead(s);
>                   la_bb_sync(s, nb_globals, nb_temps);
>               } else if (def->flags & TCG_OPF_BB_END) {
> +                assert_carry_dead(s);
>                   la_bb_end(s, nb_globals, nb_temps);
>               } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
> +                assert_carry_dead(s);
>                   la_global_sync(s, nb_globals);
>                   if (def->flags & TCG_OPF_CALL_CLOBBER) {
>                       la_cross_call(s, nb_temps);
> @@ -4182,6 +4279,9 @@ liveness_pass_1(TCGContext *s)
>                       arg_life |= DEAD_ARG << i;
>                   }
>               }
> +            if (def->flags & TCG_OPF_CARRY_OUT) {
> +                s->carry_live = false;
> +            }
>   
>               /* Input arguments are live for preceding opcodes.  */
>               for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
> @@ -4193,6 +4293,9 @@ liveness_pass_1(TCGContext *s)
>                       ts->state &= ~TS_DEAD;
>                   }
>               }
> +            if (def->flags & TCG_OPF_CARRY_IN) {
> +                s->carry_live = true;
> +            }
>   
>               /* Incorporate constraints for this operand.  */
>               switch (opc) {
> @@ -4232,6 +4335,7 @@ liveness_pass_1(TCGContext *s)
>           }
>           op->life = arg_life;
>       }
> +    assert_carry_dead(s);
>   }
>   
>   /* Liveness analysis: Convert indirect regs to direct temporaries.  */
> @@ -4817,9 +4921,8 @@ static void sync_globals(TCGContext *s, TCGRegSet allocated_regs)
>      all globals are stored at their canonical location. */
>   static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
>   {
> -    int i;
> -
> -    for (i = s->nb_globals; i < s->nb_temps; i++) {
> +    assert_carry_dead(s);
> +    for (int i = s->nb_globals; i < s->nb_temps; i++) {
>           TCGTemp *ts = &s->temps[i];
>   
>           switch (ts->kind) {
> @@ -4850,6 +4953,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
>    */
>   static void tcg_reg_alloc_cbranch(TCGContext *s, TCGRegSet allocated_regs)
>   {
> +    assert_carry_dead(s);
>       sync_globals(s, allocated_regs);
>   
>       for (int i = s->nb_globals; i < s->nb_temps; i++) {
> @@ -5121,6 +5225,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       int const_args[TCG_MAX_OP_ARGS];
>       TCGCond op_cond;
>   
> +    if (def->flags & TCG_OPF_CARRY_IN) {
> +        tcg_debug_assert(s->carry_live);
> +    }
> +
>       nb_oargs = def->nb_oargs;
>       nb_iargs = def->nb_iargs;
>   
> @@ -5377,6 +5485,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           tcg_reg_alloc_bb_end(s, i_allocated_regs);
>       } else {
>           if (def->flags & TCG_OPF_CALL_CLOBBER) {
> +            assert_carry_dead(s);
>               /* XXX: permit generic clobber register list ? */
>               for (i = 0; i < TCG_TARGET_NB_REGS; i++) {
>                   if (tcg_regset_test_reg(tcg_target_call_clobber_regs, i)) {
> @@ -5494,7 +5603,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>   
>       case INDEX_op_sub:
>           {
> -            const TCGOutOpSubtract *out = &outop_sub;
> +            const TCGOutOpSubtract *out =
> +                container_of(all_outop[op->opc], TCGOutOpSubtract, base);
>   
>               /*
>                * Constants should never appear in the second source operand.
> @@ -5509,6 +5619,16 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> +    case INDEX_op_addco:
> +    case INDEX_op_subbo:
> +    case INDEX_op_addci:
> +    case INDEX_op_subbi:
> +    case INDEX_op_addcio:
> +    case INDEX_op_subbio:
> +    case INDEX_op_addc1o:
> +    case INDEX_op_subb1o:
> +        g_assert_not_reached();
> +
>       case INDEX_op_bswap64:
>       case INDEX_op_ext_i32_i64:
>       case INDEX_op_extu_i32_i64:
> @@ -5697,6 +5817,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           break;
>       }
>   
> +    if (def->flags & TCG_OPF_CARRY_IN) {
> +        s->carry_live = false;
> +    }
> +    if (def->flags & TCG_OPF_CARRY_OUT) {
> +        s->carry_live = true;
> +    }
> +
>       /* move the outputs in the correct register if needed */
>       for(i = 0; i < nb_oargs; i++) {
>           ts = arg_temp(op->args[i]);
> @@ -6699,6 +6826,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>       tcg_out_tb_start(s);
>   
>       num_insns = -1;
> +    s->carry_live = false;
>       QTAILQ_FOREACH(op, &s->ops, link) {
>           TCGOpcode opc = op->opc;
>   
> @@ -6727,6 +6855,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>               tcg_reg_alloc_dup(s, op);
>               break;
>           case INDEX_op_insn_start:
> +            assert_carry_dead(s);
>               if (num_insns >= 0) {
>                   size_t off = tcg_current_code_size(s);
>                   s->gen_insn_end_off[num_insns] = off;
> @@ -6747,6 +6876,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>               tcg_out_label(s, arg_label(op->args[0]));
>               break;
>           case INDEX_op_call:
> +            assert_carry_dead(s);
>               tcg_reg_alloc_call(s, op);
>               break;
>           case INDEX_op_exit_tb:
> @@ -6783,6 +6913,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>               return -2;
>           }
>       }
> +    assert_carry_dead(s);
> +
>       tcg_debug_assert(num_insns + 1 == s->gen_tb->icount);
>       s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
>   
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 9392d88069..93bcc70639 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -593,6 +593,67 @@ Multiword arithmetic support
>   
>   .. list-table::
>   
> +   * - addco *t0*, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* + *t2* and in addition output to the
> +         carry bit provided by the host architecture.
> +
> +   * - addci *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
> +         input carry bit provided by the host architecture.
> +         The output carry bit need not be computed.
> +
> +   * - addcio *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
> +         input carry bit provided by the host architecture,
> +         and also compute the output carry bit.
> +
> +   * - addc1o *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* + *t2* + 1, and in addition output to the
> +         carry bit provided by the host architecture.  This is akin to
> +         *addcio* with a fixed carry-in value of 1.
> +       | This is intended to be used by the optimization pass,
> +         intermediate to complete folding of the addition chain.
> +         In some cases complete folding is not possible and this
> +         opcode will remain until output.  If this happens, the
> +         code generator will use ``tcg_out_set_carry`` and then
> +         the output routine for *addcio*.
> +
> +   * - subbo *t0*, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* - *t2* and in addition output to the
> +         borrow bit provided by the host architecture.
> +       | Depending on the host architecture, the carry bit may or may not be
> +         identical to the borrow bit.  Thus the addc\* and subb\*
> +         opcodes must not be mixed.
> +
> +   * - subbi *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
> +         input borrow bit provided by the host architecture.
> +         The output borrow bit need not be computed.
> +
> +   * - subbio *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
> +         input borrow bit provided by the host architecture,
> +         and also compute the output borrow bit.
> +
> +   * - subb1o *t0, *t1*, *t2*
> +
> +     - | Compute *t0* = *t1* - *t2* - 1, and in addition output to the
> +         borrow bit provided by the host architecture.  This is akin to
> +         *subbio* with a fixed borrow-in value of 1.
> +       | This is intended to be used by the optimization pass,
> +         intermediate to complete folding of the subtraction chain.
> +         In some cases complete folding is not possible and this
> +         opcode will remain until output.  If this happens, the
> +         code generator will use ``tcg_out_set_borrow`` and then
> +         the output routine for *subbio*.
> +
>      * - add2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, *t2_high*
>   
>          sub2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, *t2_high*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


