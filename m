Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A978420E
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRQB-0006Gd-14; Tue, 22 Aug 2023 09:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRQ8-0006Dz-SM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:27:44 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRQ6-0003rf-Lc
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:27:44 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so69045491fa.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692710860; x=1693315660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ozuFv8lCpy0mpEsPtSSvgbJVAb/9yHPf0N0cz/ES51c=;
 b=UUrC/xxCCPm9U9Ld1yAZwZJRupcTvSxYfOazlG4SZzW+EARBzjqDVbg3y23JyhLE7/
 rIu9scH6CSPauHK6rfoK5Hg+M4T1wsmSP0tpCtbvWathe+Wr8M0twjUM/AyN/WXWnh2x
 0kNfP90O+ydOSVh1q41w4jimLzTL+mC58JOqmXjySnxz8RsX3VPrLcGMuvyw65xkhed1
 SC4OdZXYfQuy9KKWEPhA+j92ki8Ndve4RyT8qbiVWIDxnEFf3UWC4JFmmaTerBO9+IyD
 eMSdlvMgMb3q6q1QW6xWvrRMo4i370oBOJaMm8csYdKNam1pUGDx+Ks4ZfesF16ZLK1i
 1haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710860; x=1693315660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ozuFv8lCpy0mpEsPtSSvgbJVAb/9yHPf0N0cz/ES51c=;
 b=DTZU+cTga1WXPceaRtGruAR9tp+G9v3D5de1X3XKVMBHiM2Cxy2+CGpaV/oU8zKRLJ
 6phdbYDtGQLiFMGD1eszx/lBnzMECkvT+XG0DwY+8tl2+zL8ikZVHjnvfxIsTVH2qbDN
 AysN4sNlmCli4l80Gjmu2oLF9lh4RHyL1f9cfupANCj5TUqqFyoF7Z0U4bZQnlLu9oEI
 r6erUxAnHsDBMOs4y3be+Y78KrU/WTEHIYyrPuFWLVQN8xS45bZzWIgcL1bJAMw7lyXD
 U2obUduc+SCRqsMXaDPtfamzKRu+NZdk0GDUdrzAFUjOeryIl+6M8MKys3cd3SmeTvr2
 s9Pg==
X-Gm-Message-State: AOJu0YwT0hGP4A8Krfuy8YHRCWN8UvbGvL9oT106wF8z/pRlXIx6ZRzz
 +/PitR3Z4LZqbRq5zzgXUVhQDmmdCM2l2kjWCdZ7Bw==
X-Google-Smtp-Source: AGHT+IGwaHrhBgopgoH/K0yv23tp2mqEtPP38scbmlrxX1CoBHZ2m/H2yXax8NkCsx7y+oWcrZ02sA==
X-Received: by 2002:a2e:4952:0:b0:2b8:39e4:2e2c with SMTP id
 b18-20020a2e4952000000b002b839e42e2cmr6696000ljd.1.1692710860254; 
 Tue, 22 Aug 2023 06:27:40 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fefd46df47sm846555wma.29.2023.08.22.06.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:27:39 -0700 (PDT)
Message-ID: <072819ba-18d9-ef0a-ed23-0d08c2536299@linaro.org>
Date: Tue, 22 Aug 2023 15:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 03/12] target/cris: Use generic hrev32_i32() in SWAPB
 opcode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz
 <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822124042.54739-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822124042.54739-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/8/23 14:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/cris/translate.c         | 20 +-------------------
>   target/cris/translate_v10.c.inc |  2 +-
>   2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 925ed2c6f6..00bbe6c645 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -381,24 +381,6 @@ static inline void t_gen_subx_carry(DisasContext *dc, TCGv d)
>       }
>   }
>   
> -/* Swap the two bytes within each half word of the s operand.
> -   T0 = ((T0 << 8) & 0xff00ff00) | ((T0 >> 8) & 0x00ff00ff)  */
> -static inline void t_gen_swapb(TCGv d, TCGv s)
> -{
> -    TCGv t, org_s;
> -
> -    t = tcg_temp_new();
> -    org_s = tcg_temp_new();
> -
> -    /* d and s may refer to the same object.  */
> -    tcg_gen_mov_tl(org_s, s);
> -    tcg_gen_shli_tl(t, org_s, 8);
> -    tcg_gen_andi_tl(d, t, 0xff00ff00);
> -    tcg_gen_shri_tl(t, org_s, 8);
> -    tcg_gen_andi_tl(t, t, 0x00ff00ff);
> -    tcg_gen_or_tl(d, d, t);
> -}
> -
>   /*
>    * Reverse the bits within each byte.
>    *
> @@ -1666,7 +1648,7 @@ static int dec_swap_r(CPUCRISState *env, DisasContext *dc)
>           tcg_gen_hswap_i32(t0, t0);
>       }
>       if (dc->op2 & 2) {
> -        t_gen_swapb(t0, t0);
> +        tcg_gen_hrev32_i32(t0, t0);

Here we should use tcg_gen_hrev32_tl (added later in this series).

>       }


