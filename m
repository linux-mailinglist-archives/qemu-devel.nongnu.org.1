Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963373535C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCM5-0001By-T7; Mon, 19 Jun 2023 06:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBCM2-0001BN-Q1
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:43:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBCM1-00047w-9f
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:43:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31129591288so1640098f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687171403; x=1689763403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5l4ohaSyf61v7E4vEv5iL4Sdh8KtOCyaAQ/pnwCKEf8=;
 b=AfdZv7yh0tr1JZSFa8n3s63KGPIiriBQGKE+TGQEflip4MBcqEM/FiV5X7CEr1kO/c
 X96FYfPRZJHYSgk/GqW49YnfP9UT90XL0DKJgK+MnRInwQMVPgi1m00/QvoS/FjZZZBv
 CfhquEYeX5awuFv6VcEyTyHVmXkoPvLhsdKoz8lQP1O0uWZ+H07U9UZQhX/09DqAyJCc
 Vaj5LPtcbazdlNj6xY5WCbK+Sr8xOhv6qiaXJ0Q37/ybzHrjvxODjSDxZj/fWbD1fuh3
 vsadL47dIy0X66OeJTjR9r5dmomaGTTGFA8WDnGXFDc8fMyBgCamY81WlXwwX1e4aBRv
 zoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687171403; x=1689763403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5l4ohaSyf61v7E4vEv5iL4Sdh8KtOCyaAQ/pnwCKEf8=;
 b=cJMkebYh9DXLXcyzDiv3foS7YtJN9CeNQ+yDXSSbEzKHclCqerapuDxAgSVRVVm+7x
 4coLqOIhJ7Roq79WJdRYOmsEdJOUraua13pHoQmn7v5qWdZDBRFmJwEE4ZA3S2Iiiqho
 /BjTblyLsztREcYP1HsHzISM2HF06kD3vyR0l1SuIa29BVHnXQWcTCE0fPz6HXYHSpJK
 zfRsQUtBKGWv8Ic312k5uwSiIZN9qupYsb47iWQ2azoBbrVGPhrYA4et9aI5v25lktxI
 NuKM2htjOE3uPIB2D8Zo7D3gPI8657oPHqsiS5zVS7UnSmoeIDTWiQd8I/BvHObIY3Tg
 4yVQ==
X-Gm-Message-State: AC+VfDw4UeVA6j5f9/vjFTBtA0yQpi0pjdNUGcfPGcP5jy+ZtvlosyTW
 4TGJ6cLcQeUbrop6N6CFQY+zTQ==
X-Google-Smtp-Source: ACHHUZ7IXqPm5cEvzR8hpEtfzV7b183/xgtGNBHCLxKTvN61zKDR4wW2PdeAqg1f+njXr3pKHP5kLQ==
X-Received: by 2002:a5d:6884:0:b0:311:1101:abb7 with SMTP id
 h4-20020a5d6884000000b003111101abb7mr5148051wru.65.1687171403395; 
 Mon, 19 Jun 2023 03:43:23 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k6-20020adff5c6000000b0031122bd3c82sm8687253wrp.17.2023.06.19.03.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 03:43:22 -0700 (PDT)
Message-ID: <1e32947f-7498-9db3-1912-dd3847f4aa0a@linaro.org>
Date: Mon, 19 Jun 2023 12:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/38] target/i386: Use aesenc_SB_SR_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609022401.684157-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 9/6/23 04:23, Richard Henderson wrote:
> This implements the AESENCLAST instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)


>   void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
>   {
> -    int i;
> -    Reg st = *v;
> -    Reg rk = *s;
> +    for (int i = 0; i < SHIFT; i++) {
> +        AESState *ad = (AESState *)&d->ZMM_X(i);
> +        AESState *st = (AESState *)&v->ZMM_X(i);
> +        AESState *rk = (AESState *)&s->ZMM_X(i);
>   
> -    for (i = 0; i < 8 << SHIFT; i++) {
> -        d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
> +        aesenc_SB_SR_AK(ad, st, rk, false);

Why not use aesenc_SB_SR_AK_gen(ad, st, rk)?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }
>   }
>   


