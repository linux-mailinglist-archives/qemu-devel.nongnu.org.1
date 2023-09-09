Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D0799A4D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 19:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf1zW-0006YQ-Fw; Sat, 09 Sep 2023 13:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1zU-0006Xp-Bv
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:43:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1zS-0004SM-4X
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:43:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso28249995ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694281404; x=1694886204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ZZn2/2agRlL7TVUXyFt0PCX86vH0sbbC5R6Ram/MFE=;
 b=EOPlgQHUy0yegM8mou0lGk7Od+Ta0rrmpfozzp/rv2yyj4bhF2Zelt2ZzKALlLJQ3B
 e5FSEY30n6N6vrcbeABEUWrJOHJXNUMIVgijbvGc3Dlh1avJPJXKGNtmwybfDMquOLR0
 v9bIz2JfHz74eTpVKloC228xQ5XxUdnehf9GDT1KEUJ93navSepIY5rgyxD9ZRrPqunf
 dZA/uI1oXxVs83N0PlWlKZzCP1h/8bg9L7MWI9+HWlrZOW8ObOhRMG8kmWutbYW0Tv1H
 0Gnr/nqVV/c88t/FxNpbLZURdRn99S5X3KuYhbt67RxdgeesKysfRQWMyIhWIuZIHjXC
 tlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694281404; x=1694886204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZZn2/2agRlL7TVUXyFt0PCX86vH0sbbC5R6Ram/MFE=;
 b=aKBTLfIzIS2AGo6weT1MOpInDhhUD4WoaHdNZmANBW8TrUcMaB1Sd4va23SGenkTwE
 o6q29X2M4HBJtdNsrDGNnP0Y7RevesKpLtVSJ0AJV1zBWwbtyJIDtnP76jorSPpfjOov
 cZwxpozy9LwvfWUwRHdRYc4ENdRs7h9D1UPBYNQ9CUIqdVHrdAtez+2+bfLz2VM1Bu1A
 QxZNMxqOp8aFtL3xmsBegpwq2CrTq9+931K6hlAjGBC0c9fcehIb9lbQ1mXPHaqOwCsX
 ZhlI+6//22t7yWN2H6jGr7AHZkJKOJqQBoGuV+/hHhTufCH/ffPZLZ/4qI+LzwKdIDxf
 dNiA==
X-Gm-Message-State: AOJu0Yz5sB0kBKC4ToDaKlZW6I/Hzmro41u/QDXPpqDrPh7UQyJrVc7O
 Rz5nZEYE/6wPqUtETWN+KdJ5iQ==
X-Google-Smtp-Source: AGHT+IEzgFefjU7UB8UIbwL7edtzeMNJGxiYvklxp1uulYw+KlqPnkAgHW/dGdIo0nyavaH0UWuQPA==
X-Received: by 2002:a17:902:a504:b0:1b8:76fc:5bf6 with SMTP id
 s4-20020a170902a50400b001b876fc5bf6mr5198151plq.43.1694281404542; 
 Sat, 09 Sep 2023 10:43:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b001bb7a736b4csm3477212ple.77.2023.09.09.10.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 10:43:23 -0700 (PDT)
Message-ID: <7dcb92db-b3c6-7236-cccd-fb6dc9d388a9@linaro.org>
Date: Sat, 9 Sep 2023 10:43:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] qemu/timer: Add host ticks function for RISC-V
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, LIU Zhiwei <lzw194868@alibaba-inc.com>
References: <20230908032300.646-1-zhiwei_liu@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908032300.646-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/7/23 20:23, LIU Zhiwei wrote:
> From: LIU Zhiwei <lzw194868@alibaba-inc.com>
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   include/qemu/timer.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9a91cb1248..ce0b66d122 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -979,6 +979,25 @@ static inline int64_t cpu_get_host_ticks(void)
>       return cur - ofs;
>   }
>   
> +#elif defined(__riscv) && defined(__riscv_xlen) && __riscv_xlen == 32
> +static inline int64_t cpu_get_host_ticks(void)
> +{
> +    uint32_t lo, hi;
> +    asm volatile("RDCYCLE %0\n\t"
> +                 "RDCYCLEH %1"
> +                 : "=r"(lo), "=r"(hi));
> +    return lo | (uint64_t)hi << 32;
> +}
> +
> +#elif defined(__riscv) && defined(__riscv_xlen) && __riscv_xlen > 32
> +static inline int64_t cpu_get_host_ticks(void)
> +{
> +    int64_t val;
> +
> +    asm volatile("RDCYCLE %0" : "=r"(cc));
> +    return val;
> +}

__riscv_xlen should never be undefined.

Don't you need a loop for RDCYCLEH to avoid time going backward?

     do {
         asm("rdcycleh %0\n\t"
             "rdcycle %1\n\t"
             "rdcycleh %2\n\t"
             : "=r"(hi), "=r"(lo), "=r"(tmph));
     } while (unlikely(tmph != hi));


r~

