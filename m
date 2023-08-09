Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7677510D
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZN5-0006fo-1k; Tue, 08 Aug 2023 22:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qTZN2-0006fH-OG; Tue, 08 Aug 2023 22:56:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qTZN1-0000E6-1R; Tue, 08 Aug 2023 22:56:24 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe1c285690so9831265e87.3; 
 Tue, 08 Aug 2023 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691549780; x=1692154580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JhG3doUv2sU30Un4/dF1r3NUqlGzjFQIP9GMdSnMCA=;
 b=IjobB+1lz+gVOX0EsmFEWnwr0NEfBd8ACzHsr2/eCvfPdsofclO3JPe9Azkc7cJka0
 F7fSqJO2B0Sk7ChMG7R2juiV7Lukr6AsIeH8Q+chmcwTWv4dTzayhywkIIqpwqhMHus0
 MYQxnNRmwaBXojB36++zYE2IejjThZ6KJbUWWho2VqBQAEEeFEdx47WwAln8MOURlxte
 P+BTNcGFttZwrnJYK3piDdYjkWKa+2aXWXo4+y0CESWJhcttHy1zSmJrHSKzOHAVTA6v
 BcxH3mTn/vgUbj9pJyraEssO7Y94OseCfFxTohwLU9ckRENqcS/dAzTh5evMqBdqxmUs
 BsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691549780; x=1692154580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JhG3doUv2sU30Un4/dF1r3NUqlGzjFQIP9GMdSnMCA=;
 b=HXawPf41nBEm5pXzUUbCqrLS3y5HEgIbFiXK+IuR0st6y6IK4qHhsaNaL2HXZ9zZjU
 wQJPkiB62SuPXDcotsyWrBchihA2kLS3LgwSLQdy4D/fgjp7kaInB6WwNAhyFUGbYPXB
 aOCGYFS1j43El31a8GLrYBGQXK1mImXUjrjRZJm9B1znwUrR+lWN0Us0eFGzpyR4b4tR
 GfqGW9U6yMQsIrxnn72WNik6xzseh2ycO6C54L9bsvSLgfC/KCmcZOInPpzzgXRXU12x
 PRzxc1qMahxFUGFlpI/XBgKyiQmbWZyLdEC1kEylwBoWZqMoaMYVS+m1ohp+V3BJcAV6
 rBGQ==
X-Gm-Message-State: AOJu0YwsBJ1sEXwZSN8GVsFG75zziCWULfMPOr4QLy7gXUbRLtlwT882
 99uZt3t8FK/9l0Kf5S5GYRn+Rr8aX5qp08lozf5znY9M4Fo=
X-Google-Smtp-Source: AGHT+IE1kjzaNhxGuojj8A7Ly8+4u8IZMUfHAWYNmU3IkqDT5El2ofEm10joFVjbYSh3Ks1r+4xTyRXZz6XpEdgAWW0=
X-Received: by 2002:a05:6512:3a86:b0:4fd:d6ba:73c2 with SMTP id
 q6-20020a0565123a8600b004fdd6ba73c2mr1039078lfu.54.1691549780053; Tue, 08 Aug
 2023 19:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-8-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-8-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 9 Aug 2023 12:56:08 +1000
Message-ID: <CACzsE9qw6QQLPT7uyE+x6LfqMUZo54+CixRZQs-AqP1KoCCMuw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tcg/ppc: Use prefixed instructions for
 tcg_out_goto_tb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=jniethe5@gmail.com; helo=mail-lf1-x136.google.com
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

On Tue, Aug 8, 2023 at 1:02=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When a direct branch is out of range, we can load the destination for
> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
> the TranslationBlock for everything larger.
>
> This means the patch affects exactly one instruction: B (plus filler),
> PLA or PLD.  Which means we can update and execute the patch atomically.

I think the commit message needs to be updated for Nick's changes.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 63fe4ef995..b686a68247 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2646,31 +2646,38 @@ static void tcg_out_goto_tb(TCGContext *s, int wh=
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
> -    } else {
> -        /* Direct branch will be patched by tb_target_set_jmp_target. */
> -        set_jmp_insn_offset(s, which);
> -        tcg_out32(s, NOP);
> +        return;
> +    }
>
> -        /* When branch is out of range, fall through to indirect. */
> +    /* Direct branch will be patched by tb_target_set_jmp_target. */
> +    set_jmp_insn_offset(s, which);
> +    tcg_out32(s, NOP);
> +
> +    /* When branch is out of range, fall through to indirect. */
> +    if (have_isa_3_10) {
> +        ptrdiff_t offset =3D tcg_pcrel_diff_for_prefix(s, (void *)ptr);
> +        tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
> +    } else {
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
> --
> 2.34.1
>

Thank you for implementing this Richard.

I was able to boot mttcg guests on P9 and P10 hosts.

Tested-by: Jordan Niethe <jniethe5@gmail.com>
Reviewed-by: Jordan Niethe <jniethe5@gmail.com>

