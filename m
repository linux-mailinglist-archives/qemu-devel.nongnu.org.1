Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7470DD30
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RjX-0005gW-Tt; Tue, 23 May 2023 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1RjV-0005es-O8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:07:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1RjQ-00017H-U1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:07:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6042d60b5so24546055e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847235; x=1687439235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4+3VLRzeWgTJSpC2LHO0kQkiGEN5/JlDb0HCiLju+wI=;
 b=M1iG8Fs5FURSLXVLkS9zYcBjY526IIsuQAJ71SCMnLDR1qsisfhKgjfMB+1i0N58vN
 YiALJKjTjRJRnbMsIUiB2Kws3iYhW5Wep2WQ61wm+yhzT8wfEFz0vHxFjfZ19KEzYeTh
 BumME773GXjOtQgjfd8WeP5dvE+IDvIj/lMBwq+QQp5zFj49cVieGExqjzxLDn5GqChc
 7u1t7JYjXQpI0sKiyr5VCzL57jRpeEIBfy6jZ7RJum6OO7LA7tOSboauDhbKixJHFPk1
 6Z84+1VeMYssRHWYye6ObNLXsOv0nI1UbFh+QpqlJ6jFjXqnlxwnHfhfecdZc7cGkQaS
 zpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847235; x=1687439235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4+3VLRzeWgTJSpC2LHO0kQkiGEN5/JlDb0HCiLju+wI=;
 b=VQmDYoQnDzMmAbF3LZTEgFNc16xEz143d9TrQC3/Uz3lexhN/yvxRnVgqzDZcleHS9
 S4wFWyEAmOEkn+acUsdx6IN5Psjt3wZ7YVzb7z3A+zBHXuOZjQWwyuKh+Ol21XIMp7sF
 V0n35LfOUgQmFPreatpzMB+5AWBXxh8cHYIH0QMtdJEZHVPGC57vdYe85aQLeYSzKQGt
 0D+fu5Mgt6uWtLSXyL9BKkxnvZZbbutCOjNuAIersCJxZdLCLVz6AhtTXUukGC1XCaXt
 M7Tki9/lbNsrlCR0jEcsXgqgycwqQ1QCyUZ/jWOepHC4H246icGSb7Pc43VqUgjsrhZE
 dNiA==
X-Gm-Message-State: AC+VfDyh9QGxlIdWEikSR6XQWj1Br8JFJZwmsa/TKRQSkGVNL9fVy0nD
 RUD8XpSsIOK9RWrPnU4O5Yf3cw==
X-Google-Smtp-Source: ACHHUZ7Kg3+z7tLn7Gqx++utvEfSy3bXTLR7z2NYMdqF09VR2syN1GzJAjQJULUtgbc3wL/9vCprOA==
X-Received: by 2002:a1c:ed13:0:b0:3f4:253b:92a9 with SMTP id
 l19-20020a1ced13000000b003f4253b92a9mr10160374wmh.30.1684847234968; 
 Tue, 23 May 2023 06:07:14 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 l20-20020a1c7914000000b003f607875e5csm4936995wme.24.2023.05.23.06.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:07:13 -0700 (PDT)
Message-ID: <2bb3f255-1401-0ba3-20c9-a6e10a176474@linaro.org>
Date: Tue, 23 May 2023 15:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, QEMU devel
 <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
 <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
 <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
 <29e26b7b-497c-a446-be86-8dda70b606d7@loongson.cn>
 <B5BE30A5-7DE7-479A-B012-23076EFA7831@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <B5BE30A5-7DE7-479A-B012-23076EFA7831@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 13:18, Jiaxun Yang wrote:
> 
> 
>> 2023年5月23日 11:01，Song Gao <gaosong@loongson.cn> 写道：
>>
>>
>>
>> 在 2023/5/23 上午11:22, Jiaxun Yang 写道:
> [...]
>>>
>>>>
>>> Is totally the same on MIPS and LoongArch. I’m guarding them out because
>>> We have different way to get IOCSR address space on MIPS, which is due
>>> to be implemented.
>>>
>>> I can further abstract out a function to get IOCSR address space. But still,
>>> I think the best way to differ those two architecture is using TARGET_* macros,
>>> as it doesn’t make much sense to have unused code for another architecture
>>> compiled.
>> Most of the code in hw/intc or hw/ uses property to distinguish between different devices,  not TARGE_* macro.
> 
> They are the *same* device, with different way to handle IOCSR address space.
> 
> Another problem is casting CPUState with LOONGARCH_CPU() is something invalid on
> MIPS, vice-versa. We are potentially introducing a security issue here.
> 
> I know nobody have done something like this before, but not necessarily to be a bad idea.
> 
> I’ll introduce something like:
> 
> +#ifdef TARGET_LOONGARCH64
> +static inline void *AddressSpace get_iocsr_as(int cpuid)
> +{
> +    CPUState *cs = qemu_get_cpu(cpuid);
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    return &cpu->env.address_space_iocsr;
> +}
> +#endif
> +
> +#ifdef TARGET_MIPS64
> +static inline void *AddressSpace get_iocsr_as(int cpuid)
> +{
> +    CPUState *cs = qemu_get_cpu(cpuid);
> +    MIPSCPU *cpu = MIPS_CPU(cs);
> +
> +    return &cpu->env.iocsr.as;
> +}
> +#endif

Introduce a QOM interface that provides a get_iocsr_as() implementation.

See for example how TYPE_IDAU_INTERFACE works.

