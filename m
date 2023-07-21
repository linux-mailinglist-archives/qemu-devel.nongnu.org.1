Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313075CA74
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:45:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrN0-0008GJ-2a; Fri, 21 Jul 2023 10:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMrMp-0008AJ-Qr
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:44:27 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMrMn-0003BX-4w
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:44:27 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1ba4460f0a4so1559820fac.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689950662; x=1690555462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aq4AY18v/iLfI5GDZ6OcQUNQsA2YFyIx56X2KOOxqT4=;
 b=WPKr7YOqo1uk99LSOQM4JVs1zYnxuJBC3Knn7gq2/T11iiBRLGTekwDVsV9+7PZHAI
 E0iOJo2nmWwWXEVleFx0wqi2l7PbJ2VG8M9eMzAZOpRmzGD0qwPd5x8ARYS2/G0JdDQo
 3kdVgKDr+xOiY28DovHyKn+RArYqubJe+Mct2rPRxiB+f9QW9GoxTzj0avF2k4H/m+mT
 Zm6JKt0uRBT7xCldyb0G5jkbqazrBnDq8M968GmUv4IUPZ27okTftdXWljJDrsFR3n0Y
 MDM6gjcK89DhFvUoPnVlBCts8ko7LVwfqxu3nFpjYIJ9ynYUqXfg1Rl+E46YxiIrp8ul
 dfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689950662; x=1690555462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aq4AY18v/iLfI5GDZ6OcQUNQsA2YFyIx56X2KOOxqT4=;
 b=ArdzozKbvV9VmIY7kiqlAuoMJkT2mbR8m6x8orURiHa49dc90iFtdIHVRBsxE6C8VI
 yKIo0PgTkd9d6BSigTSKGGhXfE9bA+rd2SGOBkA7SJKmgr007jRobQ24xpnn/N86v1/o
 UqPyb8Dn0vhjhlz06hjUHmJ6Zn5h0gFejc03CwZoHYup18rGdm6WzN7QidkzHduCGLu+
 ICE4BtS728Cc2OP3qGP6gj4BFjVRIOtfoHKBAp9fN2jZZiVGj8c3teQ/CI6OIYCPaKez
 amM1qe66K1uQq/lR9TJJwQ97acyKMlAP97dtrM58veJl6eQ2myAFJ1zOLHMfHvRFS9DW
 or9A==
X-Gm-Message-State: ABy/qLabLWrurtt5O6BGCJ3dwSivikpRI9v7GrPor+WIq/6q28c2ixvx
 PC6rkPB19031qhjE9Wtt1r3GHQ==
X-Google-Smtp-Source: APBJJlHzb4VzOimN5JUfxg7MQco7PBInX+/Xk7hakMI63GGynLLPJZFL1Pjq817BzZ38udxe/HvE9A==
X-Received: by 2002:a05:6871:89f:b0:1ba:caf2:acc3 with SMTP id
 r31-20020a056871089f00b001bacaf2acc3mr2058011oaq.5.1689950662298; 
 Fri, 21 Jul 2023 07:44:22 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 n6-20020a056870034600b001a9eb707366sm1575036oaf.15.2023.07.21.07.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 07:44:21 -0700 (PDT)
Message-ID: <21f22eff-7f43-54a7-d345-96e4a5552979@ventanamicro.com>
Date: Fri, 21 Jul 2023 11:44:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv/cpu.c: do not run 'host' CPU with TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230721133411.474105-1-dbarboza@ventanamicro.com>
 <3b93823c-3d12-0d67-b814-54a3922d027f@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <3b93823c-3d12-0d67-b814-54a3922d027f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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



On 7/21/23 11:37, Philippe Mathieu-Daudé wrote:
> On 21/7/23 15:34, Daniel Henrique Barboza wrote:
>> The 'host' CPU is available in a CONFIG_KVM build and it's currently
>> available for all accels, but is a KVM only CPU. This means that in a
>> RISC-V KVM capable host we can do things like this:
>>
>> $ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
>> qemu-system-riscv64: H extension requires priv spec 1.12.0
>>
>> This CPU does not have a priv spec because we don't filter its extensions
>> via priv spec. We shouldn't be reaching riscv_cpu_realize_tcg() at all
>> with the 'host' CPU.
>>
>> We don't have a way to filter the 'host' CPU out of the available CPU
>> options (-cpu help) if the build includes both KVM and TCG. What we can
>> do is to error out during riscv_cpu_realize_tcg() if the user chooses
>> the 'host' CPU with accel=tcg:
>>
>> $ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
>> qemu-system-riscv64: 'host' CPU is not compatible with TCG acceleration
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 6b93b04453..08db3d613f 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1395,6 +1395,11 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
> 
> /me wonders why this method isn't used as AccelCPUClass:cpu_realizefn().
> 
>>       CPURISCVState *env = &cpu->env;
>>       Error *local_err = NULL;
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
>> +        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
>> +        return;
>> +    }
> 
> We should manage that generically, likely in CPUClass.
> We could define riscv CPU with a DEFINE_CPU_WITH_CLASS() macro to pass
> the class_init() handler. Anyhow meanwhile your patch is sufficient, so
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks. I'll mark all your suggestions as todo for 8.2.


Daniel

> 

