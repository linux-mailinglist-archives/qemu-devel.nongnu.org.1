Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817237E7516
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ENw-0000nD-6V; Thu, 09 Nov 2023 18:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1ENt-0000me-A9
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:24:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1ENr-0007jb-Ls
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:24:25 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso1393751b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699572262; x=1700177062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z0J/6DHP2X8a1wCtKJDIFetqab1BTX7su+f2YOz1nrc=;
 b=cLvOoatq0p2eZV3bvApRzPM+cgzPrFQuJNUr1FOT3AoxWETdQPm8IUuNfGcWY+Jaqo
 4hqOJtaq85jV84MzFmLUQxLn+iHHCxDg5mtxV4oHZnJqELRrSCTaW7bTCX7a1LKWbKjn
 slhymobOw9nk8fxuMIkZ4x9dHvfGIWw1y9stuI6rXPf+vy8W9wvJ36uzCTCG9Fffd/uR
 cspkiILvu4/xqa+eVHBJ1UAL9jfNnWmwI4SwURTFUIIoQnzBncDYNVApKLL7T259+dBb
 aVWxKNP84/epnQVxO9QemNDiITwcbPzh8WefsPHI/qfOnT7cisY8dsRTKWTSzhRfRGuA
 ZMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699572262; x=1700177062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0J/6DHP2X8a1wCtKJDIFetqab1BTX7su+f2YOz1nrc=;
 b=mq6C5b36JrajTdNhNMfZRR6WLgszuSVfdP0ROK8NlbfzlYOHPUoPg+tyLX7ZT0VA/H
 aGu5N7i77EWld/G+cwFU5CHs5NAqn+kdjqr9Qi5fjfgTwCN7clqoG2as1M9yaCEZJhHo
 I5LXdmyMjwTLWP968Ocnd22oUXAapKpgEy8umhu2kEQQTxLYxMY2FqmczjLTBCe+5e0x
 hWPg/Y1UJEohn7gwMalXYFeSu+bBbTKM0XZkpW9/25g6ldCTHjeGBogqbN7aHofv9giU
 yHlwxfHl9HYig4xsg7777wppyarETzq8V1rHZhY68AQpUeRTvT3VMZPloehM8Tdls583
 dDjA==
X-Gm-Message-State: AOJu0YxX/oqfvysMGKObEg1k3bezc2nm0Ev5p2xcelmdaTQwMRf+8NG2
 nFa/byOmQgZAgfoOnTjw+vAHrg==
X-Google-Smtp-Source: AGHT+IE7G4uZmkjJPFeELy9K52AKxjbJ6slSAa4SrJTsTOeystgUWLk79O/YZ9Yt4/rN7ApQoEvQQQ==
X-Received: by 2002:a05:6a00:1a8b:b0:68e:46d2:e331 with SMTP id
 e11-20020a056a001a8b00b0068e46d2e331mr6115120pfv.23.1699572261936; 
 Thu, 09 Nov 2023 15:24:21 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ee6:29b:6626:64c4:1b48:c565?
 ([2607:fb91:1ee6:29b:6626:64c4:1b48:c565])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a056a00138800b0068be4ce33easm11584419pfg.96.2023.11.09.15.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:24:21 -0800 (PST)
Message-ID: <45ef60fe-dcb6-461d-97e1-d19e5174075d@linaro.org>
Date: Thu, 9 Nov 2023 15:24:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 09/10] hw/char/pl011: Add transmit FIFO to
 PL011State
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109192814.95977-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
> @@ -436,6 +438,24 @@ static const VMStateDescription vmstate_pl011_clock = {
>       }
>   };
>   
> +static bool pl011_xmit_fifo_state_needed(void *opaque)
> +{
> +    PL011State* s = opaque;
> +
> +    return !fifo8_is_empty(&s->xmit_fifo);
> +}
> +
> +static const VMStateDescription vmstate_pl011_xmit_fifo = {
> +    .name = "pl011/xmit_fifo",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pl011_xmit_fifo_state_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_FIFO8(xmit_fifo, PL011State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static int pl011_post_load(void *opaque, int version_id)
>   {
>       PL011State* s = opaque;
> @@ -487,7 +507,11 @@ static const VMStateDescription vmstate_pl011 = {
>       .subsections = (const VMStateDescription * []) {
>           &vmstate_pl011_clock,
>           NULL
> -    }
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_pl011_xmit_fifo,
> +        NULL
> +    },
>   };

It just occurred to me that you may need a vmstate_pl011 pre_load() to empty the FIFO, 
which will then be filled if and only if the saved vmstate_pl011_xmit_fifo subsection is 
present.

Juan, have I got this correct about how migration would or should handle a missing subsection?


r~

