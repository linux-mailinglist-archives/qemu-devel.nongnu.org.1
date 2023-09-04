Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8E7912C3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 09:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4RL-0005ci-Nf; Mon, 04 Sep 2023 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4RH-0005cD-KA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:56:03 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4RE-0003XI-Qb
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:56:03 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-500cfb168c6so1927205e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693814159; x=1694418959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aq76xk0R4e1eBtmgWg17QXsRmfYTgAn3YgaI8wjb4iQ=;
 b=qX6Po0m59Ed6XySJDygyVDjsp91AaB0bpWSfwjaBrV0n8ZvBmeTmqv5/Yor8xjG09X
 RFwLMxzj43Ml2WNJmUZndpsXMmzEgBIPPbsoVTnyzz7fWOvyqwkPV4hWCR1KSvIpG196
 pEAZ/WFmPya0ar0FVCShzxGmk0mI4gXEt/QcxDqXK0i+WRp9A16nTtnm0i+rOWFLrSnl
 uW+nyilCUkuQuUZ7UX3YXAR8In0KiTuwEf8FZgn+u9RiK8RoaU4DWL2XPRuuVCMksCI2
 JN9bmdQz82xJtz2X+5jOnC63wJrmipnKEotANVt9FFiiUPgA9Y97d6XciOpHKwjmGsdd
 qDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693814159; x=1694418959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aq76xk0R4e1eBtmgWg17QXsRmfYTgAn3YgaI8wjb4iQ=;
 b=S6obKs/VH9C/OOUajsdneadkHJ/Z28T9LaC3pCReNu1+SreIXJtDTDPwTQb1rxwQJE
 XRyinOQ/UBVsRLrkrcWD2E5YIIBEmrnK1YSndW0nIz71v38qRXOJDzuumpw4hPBmiC6A
 q7vg5wxH5/tU5W4H+7JsC3XeRpRqG8p+9aTdTTcAKd1DzBX/fwtV2170fJy6rovUdC+e
 34611qsRLZSp+nfhTQckw1XI4f7ve2q2FTn8CZMx0MJlmHAfUNqqMapmYc+VgSf36HTI
 KIGKayWj5T1THpkddxg6jfsAI7OswC2oXWFSexuDv2TfTKGmBNNnnhBdz5n5Du704ZEu
 uhiw==
X-Gm-Message-State: AOJu0YyToGszs0FvJtb+csmEiRT6SF+u+iqLxvo+BhWagAJarXc8uigJ
 KsYuK8Y3I57p1a5IEGxfq2wPPg==
X-Google-Smtp-Source: AGHT+IE7bgauqWqr8GvWqRCYSpx3AdJQRnnkKR1dzTeULsBSedz7wHqtCNN6LPRZ9lq7/QWNrU8qEw==
X-Received: by 2002:a05:6512:281c:b0:4fd:d172:fc2c with SMTP id
 cf28-20020a056512281c00b004fdd172fc2cmr7099417lfb.21.1693814158695; 
 Mon, 04 Sep 2023 00:55:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a056402079900b005224f840130sm5378069edy.60.2023.09.04.00.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 00:55:58 -0700 (PDT)
Message-ID: <1a2c4590-532d-a8b8-e77d-1131d6aa88aa@linaro.org>
Date: Mon, 4 Sep 2023 09:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v9 04/20] target/riscv: add DEFINE_PROP_END_OF_LIST() to
 riscv_cpu_options[]
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
 <20230901194627.1214811-5-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901194627.1214811-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 1/9/23 21:46, Daniel Henrique Barboza wrote:
> Add DEFINE_PROP_END_OF_LIST() and eliminate the ARRAY_SIZE() usage when
> iterating in the riscv_cpu_options[] array, making it similar to what
> we already do when working with riscv_cpu_extensions[].
> 
> We also have a more sophisticated motivation behind this change. In the
> future we might need to export riscv_cpu_options[] to other files, and
> ARRAY_LIST() doesn't work properly in that case because the array size
> isn't exposed to the header file. Here's a future sight of what we would
> deal with:
> 
> ./target/riscv/kvm.c:1057:5: error: nested extern declaration of 'riscv_cpu_add_misa_properties' [-Werror=nested-externs]
> n file included from ../target/riscv/kvm.c:19:
> home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
>   473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>       |                               ^
> ./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
> 1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
>       |                             ^~~~~~~~~~
> ./target/riscv/kvm.c:1059:5: note: in expansion of macro 'ADD_UNAVAIL_KVM_PROP_ARRAY'
> 1059 |     ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_extensions);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
>   473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>       |                               ^
> ./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
> 1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
> 
> Homogenize the present and change the future by using
> DEFINE_PROP_END_OF_LIST() in riscv_cpu_options[].
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


