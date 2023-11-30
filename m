Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAE7FFC5C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 21:18:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8nT4-0002er-LF; Thu, 30 Nov 2023 15:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8nT1-0002dG-LN
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:16:59 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8nT0-0004EX-0L
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:16:59 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so192023366b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375416; x=1701980216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lS3aLZ0zIWdXiaISMQ/RtOasorHUAcvYTG4xZ5Za+a8=;
 b=CI49e5c66LKusBKZclHMVxDfUpyj6lAF0ytoSX/yCpM8MjFJZgpJTzjQJPCrhAwnkR
 3o949sRckdbFtQtC1QyazIved7+clNyWKu53kAFINyYaHWUzr5en56Y9HBwKl3nkOsbc
 SGSFJx/NvIqmxY1YfPFDgAB5W1pmkdiZdG+BHzM8eCVPWAIyMb1uU+l7NiUCBZO2dVk2
 fY2LilTvRnaSLoMAcnnrJae5r9oxUrK3DDjkviHA82j5JL44F2rtjmJ5KcSMjFzMZLGp
 3VUv7AIQWBiY76wKpTmS5CHIvVAWFUp4fDRvSIQfkuM9fMgkNCeCFMdIH5dJNpklWdqH
 hJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375416; x=1701980216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lS3aLZ0zIWdXiaISMQ/RtOasorHUAcvYTG4xZ5Za+a8=;
 b=b229WULeXb73162ev+YRm4e1Wwt47WtIQQWqOIRE7Rkk2CABmVll89Zi06u+PYrAZ5
 lU7KQ5EDpQW1GiWPRcjUKl8RGeF2OWwah/EJxN3P7KddwrFMogEC7xqGaHubQyCywdoy
 V2Ipotb+PUTJfml7wMKLp/WMzt4Q4dAhHxfAxzXt0gEOMYjJxOMIF7pLzExshKbQAarp
 dppB9o1Dm0aUcLLOEoOtURGDjfRWCc/PRPOV7k6V9ds7x+GiYN3+2TDPbtABaT2eC8Kl
 AqYmTo4im01+XZG/yH0yn0bIvQMe2ptrchu+QdcP6kqNnodNKR9XgnZZLXdpmNuUtI7T
 9pQw==
X-Gm-Message-State: AOJu0YxI97l0o+AO9deyBIgZGzT3+HyaFIPuaNVuZE15NXjiwA3nlIr8
 t5T/+qKOTTlOo5AInqYwoTMpmw==
X-Google-Smtp-Source: AGHT+IGoHe0VnRFJcVpIpprWW/pTC8xVEHm0G6y11BmSQBtpZjkHtJwHtwU2Tno1cZN7XJtlk8beIA==
X-Received: by 2002:a17:906:2259:b0:a04:bc39:c1c7 with SMTP id
 25-20020a170906225900b00a04bc39c1c7mr105699ejr.36.1701375416295; 
 Thu, 30 Nov 2023 12:16:56 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 hd37-20020a17090796a500b009c503bf61c9sm1029032ejc.165.2023.11.30.12.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 12:16:55 -0800 (PST)
Message-ID: <36fe2c1d-4db6-498e-a7ce-da74410b4a03@linaro.org>
Date: Thu, 30 Nov 2023 21:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng
References: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 30/11/23 19:39, Taylor Simpson wrote:
> Adding -Werror=shadow=compatible-local causes Hexagon not to build
> when idef-parser is off.  The "label" variable in CHECK_NOSHUF_PRED
> shadows a variable in the surrounding code.
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/macros.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 9a51b5709b..f99390e2a8 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -93,13 +93,13 @@
>   
>   #define CHECK_NOSHUF_PRED(GET_EA, SIZE, PRED) \
>       do { \
> -        TCGLabel *label = gen_new_label(); \
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, label); \
> +        TCGLabel *noshuf_label = gen_new_label(); \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \

Fragile, but sufficient.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


