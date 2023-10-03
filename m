Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B07B7295
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnm6B-0002YC-7s; Tue, 03 Oct 2023 16:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm68-0002XW-0O
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:34:28 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm66-0002ZK-HR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:34:27 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3add37de892so834711b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696365265; x=1696970065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEPFvK/4H2zkKiFHbM6EwkQb/E+J3Ru3FBPIoIKrZnw=;
 b=L2GcmkKG5HcmQZ4axXg9hYgs6J0QB2DNmn5g0wfyoZB+ne2gyyJEkAo/syhMkrR2Qm
 dgp/M+Z3qTRURpgGCKHn3oGql9/kxguifmLzq1ylaeUiCbsGwXX/GfoTgVgsICJeRTcs
 6UthyGFekkVCU1wX+a3jUpse4trPd8CMn1S2IlPnjNnjhRrmfNrGuhtNDhnltWl5cna4
 9T8VZ+oTbLpyw4dEPx/xHzEdz31Kk48veBXQ4dGSXFoQmf4fJc4JMKwrOlUVn9JuK2Tv
 5Ws3aftzf88lBzoHm7bQWwga3xvwomadN37TvztUYCDO8QWNBlOsN2N7nugqXiA1B7j8
 4ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365265; x=1696970065;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEPFvK/4H2zkKiFHbM6EwkQb/E+J3Ru3FBPIoIKrZnw=;
 b=TNfChI/LDDn2JwmeFAz8V+9OWGv/fjfRwREx/86hGfA2xnSQNa8vWml/ulAcbnhTHI
 KBWsHzIat+YsyC/n4HQsBROoGG04Znl4oPNQEZcbLcmVlfRQHq0fABxhy4hg2YDJjnXO
 Le+tSV7DIH3Wa6S7QXI2ZaGhwE2horHQ+JPXvsxRnRG7hhpimgPhVNF6azrsZZ8Kqpuv
 AMajAM9sqZezOYKx9OvNw5MGRmyEPAXI7fG89qJO5PaV5Nd3IEjoH1iObHeEsQwcquKu
 3l5wlu/ecwNFPLVE9rMjcwfNNtMlhZjttBmNeW3y3qyRBa5l5aiCw0IonpHuATJXUQbh
 G2hw==
X-Gm-Message-State: AOJu0YzCT7/fucbIOdTbae0TP+2i8mxeeqgPetMzqquysz5cqrUuAcP1
 WXC2jgvDykLBhwrSrf9DThGtOQ==
X-Google-Smtp-Source: AGHT+IGy0r8RbK4snN49Vr4DK9CB0PwwB+fHfvGxI27cNYRrJA6Xq4hrU+7a6N8Ngv+K7KOsGbehLg==
X-Received: by 2002:a05:6808:159c:b0:3a8:512a:41b8 with SMTP id
 t28-20020a056808159c00b003a8512a41b8mr797398oiw.21.1696365264837; 
 Tue, 03 Oct 2023 13:34:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 gz4-20020a17090b0ec400b002790ded9c6dsm1818100pjb.31.2023.10.03.13.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 13:34:24 -0700 (PDT)
Message-ID: <97fbe6a6-79fd-d2aa-91ed-a1c0444cb209@linaro.org>
Date: Tue, 3 Oct 2023 13:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user/elfload: Enable LSX/LASX in HWCAP for LoongArch
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name, Laurent Vivier <laurent@vivier.eu>
References: <20231001085315.1692667-1-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231001085315.1692667-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/1/23 01:53, Jiajie Chen wrote:
> Since support for LSX and LASX is landed in QEMU recently, we can update
> HWCAPS accordingly.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   linux-user/elfload.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index db75cd4b33..f11f25309e 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1237,6 +1237,14 @@ static uint32_t get_elf_hwcap(void)
>           hwcaps |= HWCAP_LOONGARCH_LAM;
>       }
>   
> +    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
> +        hwcaps |= HWCAP_LOONGARCH_LSX;
> +    }
> +
> +    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
> +        hwcaps |= HWCAP_LOONGARCH_LASX;
> +    }
> +
>       return hwcaps;
>   }
>   

Queued to linux-user-next.


r~

