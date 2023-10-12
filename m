Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4737C720C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyCY-0002f5-OT; Thu, 12 Oct 2023 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqyCW-0002eb-9p
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:06:16 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqyCT-0005gZ-0n
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:06:15 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3af6cd01323so653594b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697126770; x=1697731570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSWJYs438bV/TsZGh6kvdz0K2DButEn4zC20UHYpY04=;
 b=hZKO+Ru5m9D9Bg0A7ttw5UwrYmpV2fsUt6T5qlyP7GEpvb1XyzZsaERbyAf4MZy0y/
 wH53D9kFiYemmH9sUy6xGdAoVkb0LGQGEAZi+65/X8Xf0FFMot77iU6cGgPbphkVR3aO
 BfC6HX1jf6jd23O16AMJ32AmTPKDE4sLm0kw3xBCZa5oMnYI6292RZBbZlHmu5MydCgP
 moAdCg9YiKzzF9huUhM5Qd3Bq3acb5lfunnTsK92WRxSyFBrXhqmEfmLSt6NWL0xioLG
 Q2pJspjkFVdyQv7OwRJmxapXw3uur5tiwaI+xw2MUv4JbJ3bIeMG2c/tRqmj1XmZ4a8A
 hMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697126770; x=1697731570;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSWJYs438bV/TsZGh6kvdz0K2DButEn4zC20UHYpY04=;
 b=a8pvuzZzsiceklPfhr83sDklANuyYY8F1zdeDHKQAcXGZE7VDiLLn9kUc/wMM8p/yB
 aS8KDN6BuhjuRSZNGRGAXU36YVtS7F3zYZKQ6jbCpTkblhhZCIRA6FWTCYxkBwiPmvla
 Pv2JXigRAvn7PFBopfGqthoax5jutDfjFIdp8nwBtITNpYj75crcvwoGTLLMzbzetR28
 o794lA6OXkKOlR//QB0UqpwrhKQTUOOXM2yrAIW6nTmxLUrJhoJxOx5Al5V8Q0kAFlB7
 zYdVKYedIbADEe1DKBHtobhIL/rRHEKPYjluVdOzPgvUP6ZPVD97Y2VCz2W0wgQ0rEYp
 Y2pA==
X-Gm-Message-State: AOJu0Yy5DokMxwms2spk5IZyLkENflXCjBA2o02cu/X5XI3BospUp8xk
 2IvC5jHoodFZtSy1xMxI40Q5jg==
X-Google-Smtp-Source: AGHT+IEE4MkHnPjUpdbYyiyEgwxSu/ykQrUM976QmWj1sCBpdYs7R0rn4H8umg7gfgqVxn6wzdZo6A==
X-Received: by 2002:a05:6358:9d82:b0:164:a045:e459 with SMTP id
 d2-20020a0563589d8200b00164a045e459mr10859871rwo.16.1697126770607; 
 Thu, 12 Oct 2023 09:06:10 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1eea:522e:cd6b:212d:2658:903e?
 ([2607:fb91:1eea:522e:cd6b:212d:2658:903e])
 by smtp.gmail.com with ESMTPSA id
 c12-20020aa78e0c000000b006933866fd21sm12057450pfr.117.2023.10.12.09.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 09:06:10 -0700 (PDT)
Message-ID: <ffd5b4ea-6535-45a5-bc74-fffdc04fce68@linaro.org>
Date: Thu, 12 Oct 2023 09:06:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/riscv: Use env_archcpu() in [check_]nanbox()
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-3-philmd@linaro.org>
 <8e8b6cef-efbf-42ac-975c-b523dc24a531@linux.alibaba.com>
 <58838379-60bf-4af4-980b-cff8ee49bfc2@linaro.org>
 <4a7e39f4-4302-4dfd-9112-4deea5c7403f@linux.alibaba.com>
 <3b745e06-d037-f1b7-0fec-373959598a15@linaro.org>
 <d90102c9-e4c3-4c2f-896e-908584b97202@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d90102c9-e4c3-4c2f-896e-908584b97202@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 10/11/23 22:59, LIU Zhiwei wrote:
> 
> On 2023/10/11 13:31, Philippe Mathieu-Daudé wrote:
>> On 11/10/23 05:25, LIU Zhiwei wrote:
>>>
>>> On 2023/10/11 1:04, Richard Henderson wrote:
>>>> On 10/9/23 05:42, LIU Zhiwei wrote:
>>>>>
>>>>> On 2023/10/9 19:02, Philippe Mathieu-Daudé wrote:
>>>>>> When CPUArchState* is available (here CPURISCVState*), we
>>>>>> can use the fast env_archcpu() macro to get ArchCPU* (here
>>>>>> RISCVCPU*). The QOM cast RISCV_CPU() macro will be slower
>>>>>> when building with --enable-qom-cast-debug.
>>
>>
>>>>> If so, maybe we have to do this qom cast somewhere.
>>>>
>>>> No, I don't think so.  Or at least not in these places.
>>>
>>> Yes.  Perhaps, we should remove all RISCV_CPU macros using after the qom objects realized.
>>>
>>> Do you think we should remove the RISCV_CPU using in riscv_cpu_exec_interrupt? Although 
>>> it  is not so hot. I think there is no reason to use it there.
>>
>> I have some note in my TODO to check replacing CPUState by ArchCPU in
>> TCGCPUOps (like the cpu_exec_interrupt handler you mentioned). 
> 
> IMHO, this will make it harder for heterogeneous SOC support. ArchCPU is not a target 
> agnostic struct.

ArchCPU is a target-agnostic typedef of a structure with no visible definition.
C is perfectly happy to manipulate pointers to such structures.

Whether it is worthwhile to adjust interfaces from CPUState to ArchCPU, I don't know.


r~


