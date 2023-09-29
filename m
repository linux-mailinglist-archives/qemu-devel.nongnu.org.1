Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 634577B3BE0
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKtD-0008M7-Ev; Fri, 29 Sep 2023 17:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKtA-0008Lk-OF
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:19:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKt8-0004Ha-6G
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:19:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-692ada71d79so10623350b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022344; x=1696627144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pp8QehhXbiqXgFo/MMhbHSZshIVWUG4RyifQnxaNxyI=;
 b=WCV9CAZkYQiwqimCKYrClSYMDg+pVo69vAzrlr2aldGJOGgMCYeC+EXdvKJ8QndJRb
 UlTLicZW3pQKdS7HynNLgCb0Fclq/9ZMIazd8n1o3sxDxXbdo9LCqBKoGZngil68Xd5d
 fI7SvOeOpS1KaNRXyvfF1GjcIOYCRGNVF5H0rHZB2cgsJhlW7/vmuayHWv9kOAW4W1K/
 FZyhscLB3V9I5xjttSlXEKb2xjoA3zvkaiqsB7EXatAfePIXYDx+99do2BLvXp8pLGJX
 CallyeGch/N6pCDJdRRLQvyv4mE7Hdu497JpxVTqv8nXEB2jlZoqd7YgyVHpdt4PGSM1
 m25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022344; x=1696627144;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pp8QehhXbiqXgFo/MMhbHSZshIVWUG4RyifQnxaNxyI=;
 b=ObO7gOJTYKRyZxCr8y6IpKyd5PndXzxF0rDVtj5cmJ8NFc5KZdcSZuf7AAujGbZCLL
 Eve2S/r4SF8H8sikN38/rThJL3jI43ZvEikr3P7kh1uVfmEgqBhyEMllqyGuKxixF38y
 /5CEcTXF5oBF0wM8xX52oiVPh9EY6DYpGJmtU/gsHVPbkd2W9u9X6Axu5xYQquBchGGx
 bpIlTKzYIHs/S8j1Cg6gplrBUZPeuza9Wv8dlBKmmMkY51TlruBvrDkwjYStaBOq1rUn
 8JOfpUFcPKrG2r54BhVvmWafARIYU2BKKJM2KVhj5bfPDq7pPOQFGrMNiMT+6ulib7hA
 TZsA==
X-Gm-Message-State: AOJu0YzJIhjEAWKqnLuZLPi23Xgkha5RmQClTRFidEtbo+N784mRRMuA
 YCtr6JFZWpZ2dwJZkNu5X2jEUK9c0ISriL5N/74=
X-Google-Smtp-Source: AGHT+IHcwi7iKX9pKwEMMhOGSdFGNvZ5eoG7+kuFVaK0zEIAPjNyPYDKHeFEGcl4PCZ4Lh/62bdtiQ==
X-Received: by 2002:a05:6a20:6a10:b0:159:b7dc:2295 with SMTP id
 p16-20020a056a206a1000b00159b7dc2295mr6153524pzk.9.1696022344584; 
 Fri, 29 Sep 2023 14:19:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a63b006000000b0056b6d1ac949sm14752062pgf.13.2023.09.29.14.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:19:04 -0700 (PDT)
Message-ID: <6fc3d330-4824-0fec-f4b0-9fa453448263@linaro.org>
Date: Fri, 29 Sep 2023 14:19:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/22] target/hppa: Create timer *after* accelerator vCPU
 is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Architecture specific hardware doesn't have a particular dependency
> on the accelerator vCPU (created with cpu_exec_realizefn), and can
> be initialized *after* the vCPU is realized. Doing so allows further
> generic API simplification (in few commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 49082bd2ba..b0d106b6c7 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -131,8 +131,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    acc->parent_realize(dev, errp);
> -
>   #ifndef CONFIG_USER_ONLY
>       {
>           HPPACPU *cpu = HPPA_CPU(cs);
> @@ -140,6 +138,8 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>                                           hppa_cpu_alarm_timer, cpu);
>       }
>   #endif
> +
> +    acc->parent_realize(dev, errp);
>   }
>   
>   static void hppa_cpu_initfn(Object *obj)

This appears to delay final realization of the vcpu, not advance it...


r~

