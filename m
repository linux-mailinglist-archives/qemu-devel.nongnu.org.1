Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B775377151C
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSdI3-0003l9-GV; Sun, 06 Aug 2023 08:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSdI1-0003kq-B2; Sun, 06 Aug 2023 08:55:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qSdHy-0005aT-4P; Sun, 06 Aug 2023 08:55:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so23424455ad.1; 
 Sun, 06 Aug 2023 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691326515; x=1691931315;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZN5DOLb8GDjhib6CRujxV/fZxesKjvo2QqELlvuuw8=;
 b=LgVaaZbmKnxayAxynneiTKHd0UaCFIDRM5beFEXO6/3gOrQKU2QgZ8uN6qeS+wB2sK
 J+DYiX7pi3kdChvmGFUQWl/hNTWjcBKZVgf2DGzueCpClwTy2iMsD2qy4g/h6vkFmt+h
 N/qiFfvuihBY4widk7fMTBNdumZDE2SPBmI8SiiyeuN/Hp2oNCpyiJ302o6aJdszC3DR
 k0tLtu6AmKcZdFf7fO6pbP2Qc7xzqdfG8LOsurVLI4E+6DnfreDp8XDkuf7Q4M31y+nn
 VguaOGkjljbECSO5iRDXT9KsQzRVIBfHp4NvEIMU7NRlMn8ocEjjlznuByUndKdre/s3
 jsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691326515; x=1691931315;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xZN5DOLb8GDjhib6CRujxV/fZxesKjvo2QqELlvuuw8=;
 b=BhNAYUoLFprxotoDBlPmH4032uDjPjLHMT8Fa6vN4Lzs1bE2YL5QdRiymgBTdqOwoG
 kXl4AuuFT++RQQDKBbH21ygOyAPV1ztwaoexlU8UP6XtK5HPrPCHWY0PMz4iSZo7VZa5
 cfdABUMr1RCDd8u3KmhzwbrVj/e/BDpsHXjO/UL1unM+tmhNSe5FuhItWmfKl2L+Jmym
 PAx66fHQBP0g4R8gEsbAP0C21g8G+oaIBFbZjypV2EUMIOwuL0mOPQugdAAtIPWVCImK
 UwJEotZ51sCfmXoEEf+IWmJ10N28Nw2QVQaZeNZhX0Fa6VqqDiop5St0M8I23I5/vpbA
 vZBA==
X-Gm-Message-State: AOJu0YzFeIGb8r6jGxayamoCreoNy+oiTGs5RuYa5hvOAkD56waCuMUf
 q8/iK6FUAHEgRWmlMJG5/VI=
X-Google-Smtp-Source: AGHT+IGFrJuJHa4dwPSa4YsEaC/bx4OOaI6doXsHTjkZSSVNEsZmD+i3J/KfFQxEFiDCshuFYK9AAg==
X-Received: by 2002:a17:902:f547:b0:1b8:c580:5fb9 with SMTP id
 h7-20020a170902f54700b001b8c5805fb9mr6175124plf.14.1691326515139; 
 Sun, 06 Aug 2023 05:55:15 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a170902b49700b001bb4f9d86ebsm4904545plr.23.2023.08.06.05.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 05:55:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Aug 2023 22:55:09 +1000
Message-Id: <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-8-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
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
> =20
>      if (USE_REG_TB) {
> +        /*
> +         * With REG_TB, we must always use indirect branching,
> +         * so that the branch destination and TCG_REG_TB match.
> +         */
>          ptrdiff_t offset =3D tcg_tbrel_diff(s, (void *)ptr);
>          tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
> -   =20
> -        /* TODO: Use direct branches when possible. */
> -        set_jmp_insn_offset(s, which);
>          tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
> -
>          tcg_out32(s, BCCTR | BO_ALWAYS);
> =20
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
> =20
>  void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const TranslationBl=
ock *tb, int n,
>  {
>      uintptr_t addr =3D tb->jmp_target_addr[n];
>      intptr_t diff =3D addr - jmp_rx;
> -    tcg_insn_unit insn;
> =20
>      if (USE_REG_TB) {
>          return;
>      }
> =20
> -    if (in_range_b(diff)) {
> -        insn =3D B | (diff & 0x3fffffc);
> -    } else {
> -        insn =3D NOP;
> -    }
> +    if (have_isa_3_10) {
> +        tcg_insn_unit insn1, insn2;
> +        uint64_t pair;
> =20
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

B is a "patch class" word instruction as per CMODX in the ISA, which may
be patched to/from other instructions without a flush+isync sequence
betwen. So that part is okay, at least if you were just patching the B
word. But patching between the PLA and PLD I don't think is kosher per
ISA.

I struggle a bit with this part of the ISA, particularly with prefix
instructions (it only talks about patching 4 bytes at a time).

If we patch something it has to go through a patch instruction, which
is a direct branch, trap, or nop. I think that makes this non-trivial.

It could work if you only patched between B and PLD. B->PLD would have
to patch the suffix word first, possibly with an interleaving sync, and
then the prefix. PLD->B could just patch the B word.

How much would losing the PLA hurt?

Thanks,
Nick

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
> =20
>  static void tcg_out_op(TCGContext *s, TCGOpcode opc,


