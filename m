Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C12D7D24AB
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 18:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubjF-0001ak-0s; Sun, 22 Oct 2023 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubj6-0001R2-Rt
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:54:57 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubj5-00035n-FO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:54:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso1384280a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697993694; x=1698598494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AaVA7FlHxMw4bqhGIA3t8y5F0TB2H9BOmAqHzpClhtk=;
 b=HJgOpMW4weiAbiiGuOYXIumTf9HgoaG3YpL3T9+FD2OXmda+D7G1urL3widh1sH3Aq
 CAcraW8DWPLdsjxj1mKQ75Mk/qWLf0KCLnaBt1WqiQLX5//brAuZEuheL8xIEKjzfzzA
 /A8XBCYGe+gzQt8WPX61kG7O5/VIWSX6D+RxYh1K5O4cDAfj/xtrvRr/AnAD4cidOAZp
 Bd9/5HCM7cW1A9w5ukWtTnOJEIo/0FIF2iWyC1owwvAlriAG260LFzRklz43aTES4j2C
 IwrwB9NQ67wrDFMi+GjeWaZZ9PoNtjOU5uA5DZeD2BK4uDmr+PGB5ZLOuJh5OLfLkTpQ
 8gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697993694; x=1698598494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AaVA7FlHxMw4bqhGIA3t8y5F0TB2H9BOmAqHzpClhtk=;
 b=lMJ02RPB19nxXQWzS72d5nBe1yyaWxzN5TzAxBbq9eLHcMKlzte/yvQEsaVWHy9cHS
 GZ1mhAMWLYX2W2PT4Bi5iAKxTDy3EDtCGTGxzLOiAtSBjTUsntNGKH04S7SAcDGzP9/f
 sz6auk8LBGbOV+TgoNhbGOQfZB9/II4XnAo9LmIWzprKzhBKCm3OPP2jTNYLNVcGZWno
 r7ktT81fvnWcVgNfPI1ct2c7x7Q1S+INRrMtYNIRc+S8KfI/eff64MaWpTtfh0M11LtW
 lALKtDQdLzUKzQQSYl8JiORGCz8ATE7cAlfZqQ4YUGNpEr7kWcewNR44cLcem/h3cZYD
 yVNA==
X-Gm-Message-State: AOJu0YzVbdoz8jhW6Ok7bMwSk/ieyRIB8nyoJMPSiYl3EdzxrSZ1J2KQ
 JXEKa9g5/SWIeJTgyAD+VgtDfw==
X-Google-Smtp-Source: AGHT+IFiVKFtkf5wRrafC8DNuMTU9tb6guhPAAZ5nf5L1QaTX2mzbCBUq3+nBQ9OwKswVIhB9oMGRA==
X-Received: by 2002:a17:90a:b903:b0:27d:5504:4cc8 with SMTP id
 p3-20020a17090ab90300b0027d55044cc8mr5255340pjr.9.1697993694211; 
 Sun, 22 Oct 2023 09:54:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a17090a2a4a00b002790ded9c6dsm4934130pjg.31.2023.10.22.09.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 09:54:53 -0700 (PDT)
Message-ID: <225e4c3c-2d44-4f2a-b398-60e57a002434@linaro.org>
Date: Sun, 22 Oct 2023 09:54:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/char/stm32f2xx_usart: Add more definitions for
 CR1 register
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020170009.86870-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 10/20/23 10:00, Philippe Mathieu-Daudé wrote:
> From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> 
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> [PMD: Split from bigger patch]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Useful if unused?
> ---
>   include/hw/char/stm32f2xx_usart.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
> index 65bcc85470..fdfa7424a7 100644
> --- a/include/hw/char/stm32f2xx_usart.h
> +++ b/include/hw/char/stm32f2xx_usart.h
> @@ -48,10 +48,12 @@
>   #define USART_SR_TC   (1 << 6)
>   #define USART_SR_RXNE (1 << 5)
>   
> -#define USART_CR1_UE  (1 << 13)
> -#define USART_CR1_RXNEIE  (1 << 5)
> -#define USART_CR1_TE  (1 << 3)
> -#define USART_CR1_RE  (1 << 2)
> +#define USART_CR1_UE     (1 << 13)
> +#define USART_CR1_TXEIE  (1 << 7)
> +#define USART_CR1_TCEIE  (1 << 6)
> +#define USART_CR1_RXNEIE (1 << 5)
> +#define USART_CR1_TE     (1 << 3)
> +#define USART_CR1_RE     (1 << 2)
>   
>   #define TYPE_STM32F2XX_USART "stm32f2xx-usart"
>   OBJECT_DECLARE_SIMPLE_TYPE(STM32F2XXUsartState, STM32F2XX_USART)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

