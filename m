Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD644808973
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 14:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBEi1-0004fa-N5; Thu, 07 Dec 2023 08:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEhz-0004et-OW
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:46:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEhy-0003Ul-1b
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:46:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332d5c852a0so965636f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 05:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701956788; x=1702561588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oaZ5nDYpjxQtDB/23IKcJrwnii9ylShZs36Zhq2EIRM=;
 b=AyGjdZ9SAB2Tghmip5ZOsdFL6r4289anQmmRZS58vxIAuyf8pyE7VL58g/Lj9gEJ+Z
 e+f8Wrdp7WaLpd28aOOnq46TCavbPNhk4eLEDTqfGI2E6GubjLFkFlKjmUUfhu/B+LMR
 0i0OxoGoKo+b5BS8HKFQW+SiskvRjVlS2/yMPzahlMLBm9B4+eo7eGPL1fypm7N3lOfA
 KhVZHKzupssTrRPE5raMmGgL17ZYUgb7V9EHzFqqhgIykZs4IpBO+izLraRYw3W9I10y
 2JI5wrcBd3Yg18zJmt2zNHa8aK5VMCIOG7J2peubw/DmwDN3ctWZ31Uv7G7RYVnAbzDn
 LSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701956788; x=1702561588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oaZ5nDYpjxQtDB/23IKcJrwnii9ylShZs36Zhq2EIRM=;
 b=Iq9dvgk2q+Lh3Z6v8cBE19Qfcu3aSxqqZRxHKdtnzRPpW9320UJOWMcErB/WNvIDH0
 Y+BDRbpAWaQflIdViaB7FJHMu7mG+RvptV38HpieVmGyhBufZlC+9Y2T22Zg1i8E5Eb5
 wjppQ+/DpSpOvJ0OhfWu6ExHqvE9MQ6ri+88zZzpqoX2o3QSJjzVylFQ1P39EmKgXnTm
 VtgoWn1Tg7M1QsOzMwgYqsudf7SRIkz7X/zDBc6LHBrQmoQyRlUBxDT4lMoIfffX7F7n
 LtvFJEEgNrFfAUbV6+fNWi94Z35fb1YI7Dxhwkgud2NpxCN2lhFhI21T/wDitzE1gMtC
 XXBw==
X-Gm-Message-State: AOJu0Yylb0RECcaTUXQRPSXLDyXM35Y6tGeM6VuMheZVg7NBUmjdaiOX
 pyfEcvzXimmMavBvUU1faZv5Dbn3WaVA7EvGwv0=
X-Google-Smtp-Source: AGHT+IHrlN2TGyfudYob+dEdie/FVKpbjtvDbKT1S6gm2463rTk8ZNfoPunGVbry9v7BWhlUNo9Sug==
X-Received: by 2002:a5d:67c8:0:b0:333:2fd2:5d1c with SMTP id
 n8-20020a5d67c8000000b003332fd25d1cmr1739050wrw.78.1701956787827; 
 Thu, 07 Dec 2023 05:46:27 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d5148000000b0033331f83907sm1480222wrt.65.2023.12.07.05.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 05:46:27 -0800 (PST)
Message-ID: <41f23b62-15ae-4e1e-98ee-a3cbcf0f7789@linaro.org>
Date: Thu, 7 Dec 2023 14:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sysemu/replay: Restrict icount to system emulation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231207102632.33634-1-philmd@linaro.org>
 <20231207102632.33634-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231207102632.33634-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 7/12/23 11:26, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/cpu-timers.h |  2 +-
>   include/sysemu/replay.h     |  9 ++++++---
>   stubs/icount.c              | 19 -------------------
>   3 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
> index 2e786fe7fb..188f67ee90 100644
> --- a/include/sysemu/cpu-timers.h
> +++ b/include/sysemu/cpu-timers.h
> @@ -24,7 +24,7 @@ void cpu_timers_init(void);
>    * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
>    * 2 = Enabled - Runtime adaptive algorithm to compute shift
>    */
> -#ifdef CONFIG_TCG
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>   extern int use_icount;
>   #define icount_enabled() (use_icount)
>   #else
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 02fa75c783..8102fa54f0 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -1,6 +1,3 @@
> -#ifndef SYSEMU_REPLAY_H
> -#define SYSEMU_REPLAY_H
> -
>   /*
>    * QEMU replay (system interface)
>    *
> @@ -11,6 +8,12 @@
>    * See the COPYING file in the top-level directory.
>    *
>    */
> +#ifndef SYSEMU_REPLAY_H
> +#define SYSEMU_REPLAY_H
> +
> +#ifdef CONFIG_USER_ONLY
> +#error Cannot include this header from user emulation
> +#endif
>   
>   #include "exec/replay-core.h"
>   #include "qapi/qapi-types-misc.h"
> diff --git a/stubs/icount.c b/stubs/icount.c
> index c39a65da92..ec8d150069 100644
> --- a/stubs/icount.c
> +++ b/stubs/icount.c
> @@ -5,30 +5,11 @@
>   
>   int use_icount;
>   
> -void icount_update(CPUState *cpu)
> -{
> -    abort();
> -}
>   int64_t icount_get_raw(void)
>   {
>       abort();
>       return 0;
>   }
> -int64_t icount_get(void)
> -{
> -    abort();
> -    return 0;
> -}
> -int64_t icount_to_ns(int64_t icount)
> -{
> -    abort();
> -    return 0;
> -}

Build failure on HVF due to:

   pmu_init()
    -> pm_events[]
     -> INST_RETIRED
      -> instructions_ns_per()
       -> icount_to_ns()

So we need to keep the icount_to_ns() stub until we restrict
ARM PMU code to TCG.



