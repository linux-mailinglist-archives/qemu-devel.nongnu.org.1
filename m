Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044B7D24AC
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 18:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubj9-0001O5-P7; Sun, 22 Oct 2023 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubiz-0001Iz-1t
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:54:49 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubiw-000343-GX
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:54:48 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1e9d3cc6e7aso1819533fac.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697993673; x=1698598473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VxWQazrEGhsusWLqLyeXUS1YYRaKS7zeGPdscQID2fQ=;
 b=GXdX7GXaE6Y7B80TWEhTK8R7PgmwMivp28q+KP+I4IM8OnyKPY3/ISe7ipjEQJUxb+
 5iOy6APVoLdBLwGtMoHkathy531jF7VVm4wKozkLS0G49nLpTPaA7ajZcWEmxKScLI4/
 8yfsNOA5NuXw99noVcuCsiLku+KZtna0M+Vtr5fbak10TeKBTJ6e3larLUFjgwM+n1Lh
 OgE4Rne+/Y+gDk7efWgL0AzYdnrii2jCYmxYpqthlpo67WlxJRiJtoHHaqqkAMLaX8KY
 NtDbyw6GPPb7u5HWGLHgVKugLrQxqFM3yIC9FDdL+3VJsywOHkjZcyz7otE0Huq+3NKa
 E9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697993673; x=1698598473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VxWQazrEGhsusWLqLyeXUS1YYRaKS7zeGPdscQID2fQ=;
 b=aYBadCmSpgR573wwsvVG6WZy70gjpujQzYdV5651tsExqewywFozXn5UrZXSMncy36
 mpcCjJ/g1C+Mf5N5pxzRtOZC4rlXEzTPW8mkClbboJApE+5WJ8boWOBpnfz66OReBl+R
 YgtURrvVzdHDphpBo+rA9ghaL0lHZoRDkTB7tOH8db0SqPuR7AUTQezZLpw8ftbGz2mt
 czS3bqIHRo3nVDK0Lt3q+6loHXCFVBiDSqhjAy0LuVmMc7j8hz4Wr6mjFgjQynrYpaDm
 l8oSumaio5BYRjMul5jxfvSbmn2Gc6NohcbP67jWhjsmimQGxh/Mt5EuSsGGQDInLk3D
 EnRw==
X-Gm-Message-State: AOJu0Yz50sGVQuZrh3dMRxltZgJJro/UEveXn7MLFXbN5tEpKfXEvV9P
 YOkbULV450dUwqFOgR0mzfCDoA==
X-Google-Smtp-Source: AGHT+IENwvHaIfpzOEBXehPYks/i8u3TmmMKOBlGJpmkIwusV6STM4YgQK/iy1anvAk7aMN58R/9ew==
X-Received: by 2002:a05:6870:9f8a:b0:1dc:33a:40d8 with SMTP id
 xm10-20020a0568709f8a00b001dc033a40d8mr10001768oab.4.1697993673576; 
 Sun, 22 Oct 2023 09:54:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a17090a2a4a00b002790ded9c6dsm4934130pjg.31.2023.10.22.09.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 09:54:33 -0700 (PDT)
Message-ID: <45a219a8-d2e7-4df3-a393-5a5407f1ab00@linaro.org>
Date: Sun, 22 Oct 2023 09:54:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/char/stm32f2xx_usart: Update IRQ when SR is read
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020170009.86870-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/20/23 10:00, Philippe Mathieu-Daudé wrote:
> From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> 
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> [PMD: Split from bigger patch]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Is this required?
> ---
>   hw/char/stm32f2xx_usart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 519d3461a3..46e29089bc 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -109,6 +109,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
>       case USART_SR:
>           retvalue = s->usart_sr;
>           qemu_chr_fe_accept_input(&s->chr);
> +        stm32f2xx_update_irq(s);
>           return retvalue;
>       case USART_DR:
>           DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);

Is there a status bit change missing?  There doesn't seem to be anything to update here.


r~

