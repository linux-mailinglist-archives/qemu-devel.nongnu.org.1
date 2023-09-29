Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E82717B3BFD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:32:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmL5e-0006kS-BP; Fri, 29 Sep 2023 17:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmL5c-0006k8-QZ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:32:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmL5X-0008AA-Ab
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:32:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so119920575ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696023114; x=1696627914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPUmCJBrJ1161EV/4J8QOVquGJUVfb06/bW7X5cLb1o=;
 b=rqChb2M7hjpuw7HahbX9hYgbD/uQMCajb/JusR0Kr17/s1SzEoksEu4n2sl/d7GTMa
 fR4dO8KuEV9+1TZyVT+tlbWcngHKTR0Uk193/OvSbsMPzjgqxSygXpDYvNdqoD/W3kx1
 HCwcVYkEUJ2sGhDOmidhXJQv8ghlOP2YlTJy7F8hF43UaVkEq4/NeHWqCqy9JE+hvYA1
 RYQr1FxhtP9Mj1H3vQS4UKPO+IgW+boYKhjkAMrVecvZ/EmQ5HUxi7xiUnxfd/ztNJgm
 WqMJwABm3/+AckctqM2mK/LV9g7PlG5dtzBAsN0jidL+y6u1bwlUKAajC4PT5a30FdTE
 13/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696023114; x=1696627914;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPUmCJBrJ1161EV/4J8QOVquGJUVfb06/bW7X5cLb1o=;
 b=h5IS8VO5W9oKAAXj3yV6KtJ8i6rAFIg1KneJkQ/fxjbN46oRofuIWQ5YJ8m1DbbPW8
 nLIVqMwxpsapZ87nOjgxdMkmCktR6HQNCKJyrEA/BmqSGbv9QYm19cX0dzDgHjpTlj4l
 Anadn3xHvrMd+QXP6QwhE6t3GYUhhV6yrJySJ76W8PRd44+KffGFor9I1/47tRIPg8hP
 RDlBxkbVX/doR+sa52WaMjUwhHJLD2u7RJV+0/FHCm4bRE1KocuTycvwcSkxR2EijL8z
 bGVDmVqqyvOiQWkknJwB488U5vnz6cwFWhsPUfEwItL/RxBCGyDiAch7e69IGY5yDbPU
 OCtw==
X-Gm-Message-State: AOJu0Ywu4yQA9JdzKcvcpxxW3Lu7Jc0i+apYLUFZPT+/e6hhuHqDFChU
 PUnkfEaKhCdU4bh/7TX87MjKu092ENRke8bYxxI=
X-Google-Smtp-Source: AGHT+IF9QDplfE2KqAad9ulihQJNxXKG5oriM/V9oSzahsoy5TXsasbRebgS3Zy/8MVkgt4cxGrhCQ==
X-Received: by 2002:a17:902:cecb:b0:1b2:5d5b:e871 with SMTP id
 d11-20020a170902cecb00b001b25d5be871mr6559970plg.59.1696023113696; 
 Fri, 29 Sep 2023 14:31:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a170903018d00b001bf044dc1a6sm17288935plg.39.2023.09.29.14.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:31:53 -0700 (PDT)
Message-ID: <760e75f4-2378-758e-9b8b-a63a00d16dfe@linaro.org>
Date: Fri, 29 Sep 2023 14:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 22/22] exec/cpu: Call cpu_exec_realizefn() once in
 cpu_common_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> +++ b/target/hppa/cpu.c
> @@ -121,22 +121,11 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>   
>   static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
> -    CPUState *cs = CPU(dev);
>       HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
> -    Error *local_err = NULL;
> -
> -    cpu_exec_realizefn(cs, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
>   
>   #ifndef CONFIG_USER_ONLY
> -    {
> -        HPPACPU *cpu = HPPA_CPU(cs);
> -        cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                        hppa_cpu_alarm_timer, cpu);
> -    }
> +    cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                    hppa_cpu_alarm_timer, HPPA_CPU(dev));
>   #endif
>   
>       acc->parent_realize(dev, errp);

Quoting one example.

In a previous patch you moved cpu_exec_realizefn() earlier, now you're moving it later, 
into parent_realize().  I think the previous patch needs adjustment.


r~

