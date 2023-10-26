Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6D17D7A84
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpYe-0005s8-4h; Wed, 25 Oct 2023 21:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpYc-0005ri-6D
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:53:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpYZ-0000WR-6m
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:53:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1caa7597af9so2594915ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698285185; x=1698889985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUO8/mTEqJqbnOYPSTCdv2TDkSRrfMlSnYam1RVGXVU=;
 b=cHKB9Y5cY5aF6h0Rt3PxVauvlsNVdAk8ap33RIhcwMLC7Jadj7JfXuO42wGy6v+Hf7
 Rw8pHG2sBVUqeo8o23srLhSbwWu31z8Jcywpx8OuRqxUkuMxkT917Ku3DVVqioDmYuGj
 qxgbarouBx8gzh0SNBjwXAdCeuFIEMDudukEYz7VQC30H9pWJubkXepNIw2DJbWSuIWU
 mSsKevuYnMLq1Plw66WMmhVIOINKIStBNL11RN+qQKfoX9AR5CY9uZticLWRW7tFrr2k
 B4pRlizu/4UUGpiH+uujWL7b5li/FFlsjdhk10NeimT2LS5l2X+yRQYArrN/Oxv4XX2h
 o3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698285185; x=1698889985;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUO8/mTEqJqbnOYPSTCdv2TDkSRrfMlSnYam1RVGXVU=;
 b=gpeABLWR0S5MJhetyiv5qfJZPL5PrZhDtOACves1q/t3OF8YzMiYMAaqMfrFQa09PJ
 zmX8FPZhBHd3nTxPz3Vaz44CFq7K5uq+ZQ4C2gu10EHWMjQh3tQmKE3VnBcV0NgCGGGK
 J+vSBSVhPD1bAzsnjoF9o+b8TPRi29dnyTSggqt/1ltqBysQ4t4bevZluHFwuF/gSfMR
 D1+Aufs+tRfj8LtbCXvxc6HskkQ5lCICdzIr8uXCSlFuvrAkbwrYYtOfUK7EJ7Fvtl/e
 dOa6gK2F5KxRZFsy7RgdsGDb5WUd9ERCJXQiW0ecyTVp1/CZkQSaIIqAFiTlgEMu3s+i
 SloA==
X-Gm-Message-State: AOJu0Yy0ClwyGLeXqosOH6foCo8Ks/O7s6naENC2LNyuH19htQOjBIOX
 ouS6sN1huLGyzig9M2EjeSZsAfB7I9Q1bapPs8o=
X-Google-Smtp-Source: AGHT+IGUXBNIUX8qyRrLKQJ/dkgCXjEwp3EGmPRzlEEvKQ0HQlBNEN4lt66b3MB0VKRy0qDgavk0UA==
X-Received: by 2002:a17:903:247:b0:1c3:64f9:45ad with SMTP id
 j7-20020a170903024700b001c364f945admr19243895plh.48.1698285185315; 
 Wed, 25 Oct 2023 18:53:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170902dac900b001b9c960ffeasm9791580plx.47.2023.10.25.18.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 18:53:04 -0700 (PDT)
Message-ID: <81d1fa61-7d3d-40fc-822d-3253eb6236eb@linaro.org>
Date: Wed, 25 Oct 2023 18:53:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] NOTFORMERGE tcg/i386: Assert sub of immediate has
 been folded
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
 <20231026013945.1152174-5-richard.henderson@linaro.org>
In-Reply-To: <20231026013945.1152174-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/25/23 18:39, Richard Henderson wrote:
> A release build should simply accept and emit the subtract.
> I'm not even sure if this is reasonable to keep for debug.
> 
> Not-Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                 | 49 ++++++++++++++++++++++++++-------------
>   tcg/i386/tcg-target.c.inc | 13 ++++++++---
>   2 files changed, 43 insertions(+), 19 deletions(-)

Oops, accidental merge of two patches.
The tcg.c change *is* required.


r~

> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index a507c111cf..408647af7e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3618,23 +3618,40 @@ liveness_pass_1(TCGContext *s)
>           do_addsub2:
>               nb_iargs = 4;
>               nb_oargs = 2;
> -            /* Test if the high part of the operation is dead, but not
> -               the low part.  The result can be optimized to a simple
> -               add or sub.  This happens often for x86_64 guest when the
> -               cpu mode is set to 32 bit.  */
> -            if (arg_temp(op->args[1])->state == TS_DEAD) {
> -                if (arg_temp(op->args[0])->state == TS_DEAD) {
> -                    goto do_remove;
> -                }
> -                /* Replace the opcode and adjust the args in place,
> -                   leaving 3 unused args at the end.  */
> -                op->opc = opc = opc_new;
> -                op->args[1] = op->args[2];
> -                op->args[2] = op->args[4];
> -                /* Fall through and mark the single-word operation live.  */
> -                nb_iargs = 2;
> -                nb_oargs = 1;
> +            /*
> +             * Test if the high part of the operation is dead, but the low
> +             * part is still live.  The result can be optimized to a simple
> +             * add or sub.
> +             */
> +            if (arg_temp(op->args[1])->state != TS_DEAD) {
> +                goto do_not_remove;
>               }
> +            if (arg_temp(op->args[0])->state == TS_DEAD) {
> +                goto do_remove;
> +            }
> +            /*
> +             * Replace the opcode and adjust the args in place, leaving 3
> +             * unused args at the end.  Canonicalize subi to andi.
> +             */
> +            op->args[1] = op->args[2];
> +            {
> +                TCGTemp *src2 = arg_temp(op->args[4]);
> +                if (src2->kind == TEMP_CONST) {
> +                    if (opc_new == INDEX_op_sub_i32) {
> +                        src2 = tcg_constant_internal(TCG_TYPE_I32,
> +                                                     (int32_t)-src2->val);
> +                        opc_new = INDEX_op_add_i32;
> +                    } else if (opc_new == INDEX_op_sub_i64) {
> +                        src2 = tcg_constant_internal(TCG_TYPE_I64, -src2->val);
> +                        opc_new = INDEX_op_add_i64;
> +                    }
> +                }
> +                op->args[2] = temp_arg(src2);
> +            }
> +            op->opc = opc = opc_new;
> +            /* Mark the single-word operation live.  */
> +            nb_iargs = 2;
> +            nb_oargs = 1;
>               goto do_not_remove;
>   
>           case INDEX_op_mulu2_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 0d97864174..39d03fa698 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2544,8 +2544,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>           c = ARITH_ADD;
>           goto gen_arith;
>       OP_32_64(sub):
> -        c = ARITH_SUB;
> -        goto gen_arith;
> +        /*
> +         * Should have canonicalized all constants to add.
> +         * Keep the constraint allowing any constant so that we catch this
> +         * case without register allocation loading the constant first.
> +         */
> +        tcg_debug_assert(!const_a2);
> +        tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
> +        break;
>       OP_32_64(and):
>           c = ARITH_AND;
>           goto gen_arith;
> @@ -3325,7 +3331,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>           return C_O1_I2(r, r, re);
>   
>       case INDEX_op_sub_i32:
> -    case INDEX_op_sub_i64:
>       case INDEX_op_mul_i32:
>       case INDEX_op_mul_i64:
>       case INDEX_op_or_i32:
> @@ -3333,6 +3338,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_xor_i32:
>       case INDEX_op_xor_i64:
>           return C_O1_I2(r, 0, re);
> +    case INDEX_op_sub_i64:
> +        return C_O1_I2(r, 0, ri);
>   
>       case INDEX_op_and_i32:
>       case INDEX_op_and_i64:


