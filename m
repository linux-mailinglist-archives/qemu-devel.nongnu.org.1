Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A0F830146
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:27:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1GP-0001nM-IY; Wed, 17 Jan 2024 03:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1GL-0001ll-HX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:27:05 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1GG-00071F-4s
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:27:05 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-559de6145c3so233037a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705480017; x=1706084817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8DaUk1LbsrblLWQY9X26OhW+zcR95ROQzt2lwFvWkM=;
 b=ialoCEohYo3RkujDHHMYxSBRMnkEN51kH1oBYsysXEUuxlY8mpiSRVry4RSLE1BT7A
 qGGcMISCyxLMckTcNkefLORXcSYuMVuUeSmxPAODAiXPWiswTz1RflIDSnsui3dGov0j
 hAb9TPmYquTgSntIjNtl7ZSza/4PQROhXYnV2zzB3cO3yqrmg/rEnUiz6MEuoUAVBSU7
 IIaJY4m7RP2pFnTKzarFhT4zNTlZy4sdExHowRevCNHg8CmvENTrMkwttKKC7MOBoJxf
 WA1KK9EfChLTSNXv2Vga43mv4Qp3BP5cm9ZOO9LjpZIqLVoLgpirgvZYOfQ+0SJkPVBP
 nejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480017; x=1706084817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8DaUk1LbsrblLWQY9X26OhW+zcR95ROQzt2lwFvWkM=;
 b=ptDuTxSLppLxhH5gGtV3yh8Yq53LqIbViBkqrXZ3JsGCJKPozpxhauzBVKmEJPwezQ
 1TQvvIfo/GLT9rhMFYR6XJ0c/ntF2Ox5On3qsthTkBGgj3zUAhKA7FATxkz86z4zv5x6
 LKT+2u0zSwzt4aNb8DFcZWA1Omh7wCy/iAjwjYwE5qakCvmV0/DbykkXlpV0F0mwZSWd
 APE9sI9GBAKzLFjegt7JwfidJNc8byH5eQS+HdmV263xyIX9FM924aCtKGYwxWoJgt2S
 j/hsDUYCxyJA6KZqiY1iCXuqAsDROBCqJeU3TcHbSlxCJXkw3KSxBX6dVkqMdKQOsGQU
 ZjDw==
X-Gm-Message-State: AOJu0YxtuHtgRqYwtKOY4vNrapSwMxN9UCwcMCvptCzTlTocgTCmxtWg
 se+iKufzIAPWJ/FmrxWxnsvt2OyYs4Ggkw==
X-Google-Smtp-Source: AGHT+IG+i4G99yteLtKdOqDqcvYr1Rsdy3mvAvvOSNObdbhQOOv8oDhQm4K9+MSUOE3FCaX9KNcwfg==
X-Received: by 2002:a17:907:d510:b0:a2e:df35:dcac with SMTP id
 wb16-20020a170907d51000b00a2edf35dcacmr252150ejc.114.1705480017050; 
 Wed, 17 Jan 2024 00:26:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a2ea1bffed7sm1074173ejc.97.2024.01.17.00.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:26:56 -0800 (PST)
Message-ID: <f0a0eee0-48c7-4019-b767-9de31f663b1e@linaro.org>
Date: Wed, 17 Jan 2024 09:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/hpet: Convert DPRINTF to trace events
Content-Language: en-US
To: Daniel Hoffman <dhoff749@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231118231129.2840388-1-dhoff749@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231118231129.2840388-1-dhoff749@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 19/11/23 00:11, Daniel Hoffman wrote:
> This conversion is pretty straight-forward. Standardized some formatting
> so the +0 and +4 offset cases can recycle the same message.
> 
> Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> ---
>   hw/timer/hpet.c       | 55 +++++++++++++++++--------------------------
>   hw/timer/trace-events | 16 +++++++++++++
>   2 files changed, 38 insertions(+), 33 deletions(-)


> @@ -643,24 +636,20 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>               break;
>           case HPET_COUNTER:
>               if (hpet_enabled(s)) {
> -                DPRINTF("qemu: Writing counter while HPET enabled!\n");
> +                trace_hpet_ram_write_counter_write_while_enabled();

Better would be to call qemu_log_mask(LOG_GUEST_ERROR) here IMO.

>               }
>               s->hpet_counter =
>                   (s->hpet_counter & 0xffffffff00000000ULL) | value;
> -            DPRINTF("qemu: HPET counter written. ctr = 0x%" PRIx64 " -> "
> -                    "%" PRIx64 "\n", value, s->hpet_counter);
> +            trace_hpet_ram_write_counter_written(0, value, s->hpet_counter);
>               break;
>           case HPET_COUNTER + 4:
> -            if (hpet_enabled(s)) {
> -                DPRINTF("qemu: Writing counter while HPET enabled!\n");
> -            }
> +            trace_hpet_ram_write_counter_write_while_enabled();

Ditto.

Can be done on top in another patch, so meanwhile:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And patch queued, thanks!

>               s->hpet_counter =
>                   (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
> -            DPRINTF("qemu: HPET counter + 4 written. ctr = 0x%" PRIx64 " -> "
> -                    "%" PRIx64 "\n", value, s->hpet_counter);
> +            trace_hpet_ram_write_counter_written(4, value, s->hpet_counter);
>               break;
>           default:
> -            DPRINTF("qemu: invalid hpet_ram_writel\n");
> +            trace_hpet_ram_write_invalid();
>               break;
>           }
>       }


