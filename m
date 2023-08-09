Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7216775C2F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qThIj-0008I5-Cz; Wed, 09 Aug 2023 07:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThId-0008He-02; Wed, 09 Aug 2023 07:24:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThIb-0002ky-FX; Wed, 09 Aug 2023 07:24:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so6369194b3a.2; 
 Wed, 09 Aug 2023 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691580259; x=1692185059;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJp/5OHFBfZLnaM74CzAWAR7M9SwTyhjIAxC1QSKtbw=;
 b=NLGaBEFyaPMy8wWpIowOs18fpgPC/OWNef1lOIE8HgVKX1IpIHlNTziyRDAvqO/Qo7
 m+DeTBTf5JqiwAbCv0omhj1dGEkt756QmyhdNuwFvdrXADiwaMZ77VJVMK6zuBJFUOMZ
 25YMiGNBgVaYaR017PRDmYeWmPLRpSZh3RENqoZnZ/614IcsV/etljlMvpXzXo8vPyZ8
 XRFS/vZosPavutTfBv4awEElVixg05P4W7S+kmNHLoXcClw49Y0OigqRZ1Zseu7L24rG
 QAQJDQ9UxdvjNIfpZS1UMugJrY8YjPxwaWxE1dLA1BQmPnwuEmPBpHrUFAMz9wr6eepk
 PouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691580259; x=1692185059;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJp/5OHFBfZLnaM74CzAWAR7M9SwTyhjIAxC1QSKtbw=;
 b=b25k/8wLLnV2K2FadP5Rdkym9ER9o1XjEXGaTNFALqQoYzQ48Vzn6coSPfCO37neQv
 1Ldk/HvRVtrUS+2H1bnh+jbW6jkIN+0/HcESwCTNYpe+5LAoBwnozVFdSEryOjVdov71
 zHyM7cfHkMcoLuzh8jcY3A2MM3zm2YQtQCFNeRYE7wA1BRtyCF4MNlqrNmjVh2+EAz4L
 1lPGdUNwBMNEMWZWxqT1ftUt/7PdCLrdHrWVK5ZUf1TTkgtDN/VAxep5kLZ4dJeTKKCl
 g57REwF0fPmE+lDliECR5rgV+cM6nSVTsS+WsoF3Pa4x2U2T4iWERW7mJk/7EMv6oIDA
 gMrQ==
X-Gm-Message-State: AOJu0YxhPhbWX/5achevGXmpIHBg4yWf062shq201YsOb/WTN6DuhPQS
 gKjw7OA7RtN+wjrmnp9kkv+FIt+AmZA=
X-Google-Smtp-Source: AGHT+IHP0Xr/ocS6oJbdL0aokzf0XIi0FdFKFdAaMgAFK6mETz+NgpGqEOREegh9/e7gYwI7faK6fg==
X-Received: by 2002:a05:6a20:d5:b0:137:74f8:62ee with SMTP id
 21-20020a056a2000d500b0013774f862eemr2333454pzh.18.1691580258936; 
 Wed, 09 Aug 2023 04:24:18 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 bm2-20020a056a00320200b00682a8e600f0sm9813364pfb.35.2023.08.09.04.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 04:24:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 21:24:14 +1000
Message-Id: <CUNZ5KZ50C7Q.B6VB3EOMEFH1@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 7/7] tcg/ppc: Use prefixed instructions for
 tcg_out_goto_tb
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-8-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-8-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Tue Aug 8, 2023 at 1:02 PM AEST, Richard Henderson wrote:
> When a direct branch is out of range, we can load the destination for
> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
> the TranslationBlock for everything larger.
>
> This means the patch affects exactly one instruction: B (plus filler),
> PLA or PLD.  Which means we can update and execute the patch atomically.
>

Aside from changelog that Jordan pointed out,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

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
> -    } else {
> -        /* Direct branch will be patched by tb_target_set_jmp_target. */
> -        set_jmp_insn_offset(s, which);
> -        tcg_out32(s, NOP);
> +        return;
> +    }
> =20
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
> =20
>  void tb_target_set_jmp_target(const TranslationBlock *tb, int n,


