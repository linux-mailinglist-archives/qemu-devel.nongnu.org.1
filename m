Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BCC7718F0
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 06:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSrY9-0003eh-84; Mon, 07 Aug 2023 00:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrXi-0003eL-Hq; Mon, 07 Aug 2023 00:08:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qSrXg-00065g-Pz; Mon, 07 Aug 2023 00:08:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so623260166b.1; 
 Sun, 06 Aug 2023 21:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691381306; x=1691986106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjw3ETJuBOfIUZIN/0Qk53AFYMIagMqIFYPgn6NZdQw=;
 b=dGTEOeD4w+IuHK26zY9ylO5XW3O4uS/Oro5DjYffQQPKXg5jP3yi7igUuwBqwN/LAD
 Yrv/8LH0iGPhToNmbk8cl3mpaBa6hGtbvBnGMpalTbHQvYqRzU/VC7YelRU/XYkXhIsj
 cI5zub8cNib2Er/sS70XmE1Cfyxw/H6UCYY24GEyGlNNmf2Hm3Wmxft01dGebTWAEYsE
 hIDJxFB7H7CuCoXjKbwtkuPovJpGfaL/Oqsh0RQiv9WDAnAQmHXHxkfjPVGCLe1fjTht
 P45PuYX/tPI8gMrgvO8zzqvHY+Hmd8Fa62u3HWNu5+1Cq3Tvn+ZQi6g6QI7mDL1YA2li
 Rvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691381306; x=1691986106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjw3ETJuBOfIUZIN/0Qk53AFYMIagMqIFYPgn6NZdQw=;
 b=FArZMH1Hw1Y2OBm5lPL3PVIdznC93egVL7fcghb0uWg8qGfnFHfShOB+ACJb0cC9Za
 L99mlg8VzmLNHAyCvEyAOWNR/bvn0Ok76moRVpcvVyk01TC1a4NJ9Qkx7RPHyQ9nbmrK
 IBiaFew+xgC9sQkuAHI0Q9hDM2eaIrevnlfQGX7Ww8mY8vfizriYekPeawfue8gx+tQU
 831tdBhSpmatfInk7KRh+ZiJCNPjO3dmaxeKaDEL1vsOWlB8u0vgVutCxsPNXG7Hx62D
 zxkNtR9MnuSkbBhDSktG7ZXJJa5cwEj7rOplNUhpnjMjCNjpzx/U0aW5F51T63PrzpUr
 WDrA==
X-Gm-Message-State: AOJu0Yx22PvSp2NzxyQrt3oIWSJWCyt7fqIqLcPiUgjzSyR687EHdBCa
 3ER0hTqO0LQcik5Em99khzxDXERkuNIEq2gL3AEO2dwn6ozWXw==
X-Google-Smtp-Source: AGHT+IE1k3cWC1I0xqEo6gUtgamedMcrw/iMMlnXeV9x+b/Vaen3y+9SpWOWALf3QdfqZTEz6EcMqZ9Q9QuztAApqOM=
X-Received: by 2002:a17:906:5dc1:b0:98d:fc51:b3dd with SMTP id
 p1-20020a1709065dc100b0098dfc51b3ddmr6573506ejv.41.1691381306429; Sun, 06 Aug
 2023 21:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-8-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Mon, 7 Aug 2023 14:08:15 +1000
Message-ID: <CACzsE9qBMP-w1gSBEbjpoBrJB6LmVtH+DJjpv=NukASkT2qEeA@mail.gmail.com>
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bgray@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=jniethe5@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Aug 5, 2023 at 7:34=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When a direct branch is out of range, we can load the destination for
> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
> the TranslationBlock for everything larger.
>
> This means the patch affects exactly one instruction: B (plus filler),
> PLA or PLD.  Which means we can update and execute the patch atomically.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++----------
>  1 file changed, 58 insertions(+), 18 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 5b243b2353..47c71bb5f2 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, int wh=
ich)
>      uintptr_t ptr =3D get_jmp_target_addr(s, which);
>
>      if (USE_REG_TB) {
> +        /*
> +         * With REG_TB, we must always use indirect branching,
> +         * so that the branch destination and TCG_REG_TB match.
> +         */
>          ptrdiff_t offset =3D tcg_tbrel_diff(s, (void *)ptr);
>          tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
> -
> -        /* TODO: Use direct branches when possible. */
> -        set_jmp_insn_offset(s, which);
>          tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
> -
>          tcg_out32(s, BCCTR | BO_ALWAYS);
>
>          /* For the unlinked case, need to reset TCG_REG_TB.  */
>          set_jmp_reset_offset(s, which);
>          tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
>                           -tcg_current_code_size(s));
> +        return;
> +    }
> +
> +    if (have_isa_3_10) {
> +        /* Align, so that we can patch 8 bytes atomically. */
> +        if ((uintptr_t)s->code_ptr & 7) {
> +            tcg_out32(s, NOP);
> +        }
> +        set_jmp_insn_offset(s, which);
> +        /* Direct branch will be patched by tb_target_set_jmp_target. */
> +        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
>      } else {
>          /* Direct branch will be patched by tb_target_set_jmp_target. */
> -        set_jmp_insn_offset(s, which);

It looks like 32bit loses its set_jmp_insn_offset(), is that intended?

> -        tcg_out32(s, NOP);
> -
> +        tcg_out32(s, B);
>          /* When branch is out of range, fall through to indirect. */
>          tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
>          tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t=
)ptr);
> -        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> -        tcg_out32(s, BCCTR | BO_ALWAYS);
> -        set_jmp_reset_offset(s, which);
>      }
> +
> +    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
> +    tcg_out32(s, BCCTR | BO_ALWAYS);
> +    set_jmp_reset_offset(s, which);
>  }
>
>  void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const TranslationBl=
ock *tb, int n,
>  {
>      uintptr_t addr =3D tb->jmp_target_addr[n];
>      intptr_t diff =3D addr - jmp_rx;
> -    tcg_insn_unit insn;
>
>      if (USE_REG_TB) {
>          return;
>      }
>
> -    if (in_range_b(diff)) {
> -        insn =3D B | (diff & 0x3fffffc);
> -    } else {
> -        insn =3D NOP;
> -    }
> +    if (have_isa_3_10) {
> +        tcg_insn_unit insn1, insn2;
> +        uint64_t pair;
>
> -    qatomic_set((uint32_t *)jmp_rw, insn);
> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
> +        if (in_range_b(diff)) {
> +            insn1 =3D B | (diff & 0x3fffffc);
> +            insn2 =3D NOP;
> +        } else if (diff =3D=3D sextract64(diff, 0, 34)) {
> +            /* PLA tmp1, diff */
> +            insn1 =3D OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16) & =
0x3ffff);
> +            insn2 =3D ADDI | TAI(TCG_REG_TMP1, 0, diff);
> +        } else {
> +            addr =3D (uintptr_t)&tb->jmp_target_addr[n];
> +            diff =3D addr - jmp_rx;
> +            tcg_debug_assert(diff =3D=3D sextract64(diff, 0, 34));
> +            /* PLD tmp1, diff */
> +            insn1 =3D OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
> +            insn2 =3D PLD | TAI(TCG_REG_TMP1, 0, diff);
> +        }
> +
> +        if (HOST_BIG_ENDIAN) {
> +            pair =3D ((uint64_t)insn1) << 32 | insn2;
> +        } else {
> +            pair =3D ((uint64_t)insn2) << 32 | insn1;
> +        }
> +
> +        qatomic_set((uint64_t *)jmp_rw, pair);
> +        flush_idcache_range(jmp_rx, jmp_rw, 8);
> +    } else {
> +        tcg_insn_unit insn;
> +
> +        if (in_range_b(diff)) {
> +            insn =3D B | (diff & 0x3fffffc);
> +        } else {
> +            insn =3D NOP;
> +        }
> +        qatomic_set((uint32_t *)jmp_rw, insn);
> +        flush_idcache_range(jmp_rx, jmp_rw, 4);
> +    }
>  }
>
>  static void tcg_out_op(TCGContext *s, TCGOpcode opc,
> --
> 2.34.1
>

