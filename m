Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7F7A443B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9Mm-0004z7-S0; Mon, 18 Sep 2023 04:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi9Mi-0004yH-UD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:12:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi9Me-0000r2-2Y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:12:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so45231275e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695024729; x=1695629529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nkd3qpwck0LDNROvE/OJkUIISIhUvWbBfAD4l2lWxj4=;
 b=s+YvdM1DfBz1qCHF1usQgxRu2+CvPEbaExP9wCoP8iS/6NBGHeqf9dIEvS+e2R9+lC
 AFDQIodbgRdolDR6/bbua7VJoHndEn/r5ympz4owjWpJdRY072SQyvvy1zpKIJRMDQ8Y
 oFntJCXP59upVrkpx/w4ebeL4OgoZcrNUtmIR2X0gbwJvBlkkpNf/t7UJLu1Q9hn/s1r
 XeyU7BxCNnbDj05ZZCljqPqZWq0TFUEeJ9ODLvoDF6yL2iR640jK6nOc0Cy5uDMrRvw6
 3dE3hpGpmCxSL5wAe/8+pgDFD7pqi9B605BRH+3vRIXmzgEeGqxpK1AaVmho9WwVDSyg
 mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695024729; x=1695629529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nkd3qpwck0LDNROvE/OJkUIISIhUvWbBfAD4l2lWxj4=;
 b=Hpal4GuPLe9FepeaAE7TNVlInoiX6/ezm4keFnNgnDVHes7krafJff4YWdd8tnBglN
 2D+a3B+WcytW82E4PE6WWqdHZovHPFq081pLDsfODIOjAhJhXZBksc6jeyFEUJ41f9pj
 7ch4nJFx039nqu2Z2A49dRg6Yy81rQANJDwttr+a4kPX7DOrjz2dkcpH47CuHa2i9TF3
 ufjYfTyAwYiiKGJyTaG9VVZohZJcE4g+LBRi70BHhFLpFkMvpuA+0JcfOOyoOsAT+FLy
 yo/x3omyi3pvcNYor5jfWUz3xjmHNgF2UJmAEmZ3WUNP2/3nHdWvYf/XNKTWEUxt/bNn
 7k0g==
X-Gm-Message-State: AOJu0Yw+puLIonCX/GujeS3BpgEpYr8uVOvDwUFRepDFYEr5uoiKDIy/
 T3Y50sFNyMZlqeHJ91dh0W0l2Q==
X-Google-Smtp-Source: AGHT+IGluRbaJMdYbdKK54LkR260Wk19Z7BKGkSrXB+nHNltN6IAN8GTCVbtGOaRssFdhvzaFnqw0w==
X-Received: by 2002:a7b:cbcf:0:b0:401:cf0d:25cd with SMTP id
 n15-20020a7bcbcf000000b00401cf0d25cdmr6875694wmi.22.1695024729254; 
 Mon, 18 Sep 2023 01:12:09 -0700 (PDT)
Received: from [192.168.152.175] (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c020700b003fe2de3f94fsm11558961wmi.12.2023.09.18.01.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:12:08 -0700 (PDT)
Message-ID: <3f3434b3-a958-54f6-f698-a15461953a36@linaro.org>
Date: Mon, 18 Sep 2023 10:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 36/39] accel: Introduce accel_cpu_unrealize() stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20230916214123.525796-1-richard.henderson@linaro.org>
 <20230916214123.525796-37-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230916214123.525796-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 16/9/23 23:41, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Prepare the stub for parity with accel_cpu_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20230915190009.68404-3-philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/accel.h | 6 ++++++
>   accel/accel-target.c | 4 ++++
>   cpu-target.c         | 3 ++-
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index cb64a07b84..7b02cb40e5 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -96,6 +96,12 @@ void accel_cpu_instance_init(CPUState *cpu);
>    */
>   bool accel_cpu_realize(CPUState *cpu, Error **errp);
>   
> +/**
> + * accel_cpu_unrealize:

Thanks for fixing the typo :)

> + * @cpu: The CPU that needs to call accel-specific cpu unrealization.
> + */
> +void accel_cpu_unrealize(CPUState *cpu);
> +


