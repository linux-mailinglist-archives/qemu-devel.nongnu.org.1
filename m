Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B927CDB74
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5WF-0000cJ-Sl; Wed, 18 Oct 2023 08:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qt5WD-0000c1-Gp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:19:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qt5WB-0006bu-En
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:19:21 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso2853553b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697631557; x=1698236357;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ct7YXxY5pU2C68suqYIlUv+D3LyDjUFZ3H2SwL++Cho=;
 b=VnuDh7KZhxydGtm8LcYz0XSTA4eIhJGnNcDweAnWjUWafzVrGdwYL2Z2vRbvaQFY2r
 W1S/Bt4j91nNYKYh2xM/GEEi8Gm0DmKhSZaUUTizdaXEgvE6TjHpjKDoTRJ59ozuIIyI
 2jtz8GS8hYT4is/7eHQIfPKMlbPFGc2vmxVOAyXagS+LnCytpV6RSQDqiYsLe8Dl08gO
 CgJlO0Lz9PuyotZzmDI0/5NmBL5cBx6zCt7TU+XloUMmVhpdgairzRMIyKn/HNho+lKK
 dA89XsZLZht7v0zeq6WMXLc5DTbnMbKoPxBQ9H0ZZ1NcxT3XisyZyihrTW88EIVNfy04
 UbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697631557; x=1698236357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct7YXxY5pU2C68suqYIlUv+D3LyDjUFZ3H2SwL++Cho=;
 b=jPZAbiTNjmWuDykhhQOgzsLES4i+YjxEjdT0908UMUues/4cmtu1xbfvRET7jb3+VY
 YIO9afZ/SfYT4vpyUUWaEgIK4zlPPvr6D7KhMjJSKA/yN5i55spTOm8MBfy97NFGXR0w
 0rTK6cd5drEPxUAZkzi0sPvrGQ+EHgUf9/S4do7CiOctNqrIYb5U3rEd/Pzt/vyp22zj
 oPFlnOFFOlWiaAxztUA1/RY0tOS0XWcCSZPgp5DHhAmWXfxmImTNwTjUh+iTgyhQ8kgu
 IiMb06C339eHnMG/dkLKs/7HXugPsYO3/1j218PNxfD2OHM6xG5DNCKtq16GKlC0FYLA
 T9mQ==
X-Gm-Message-State: AOJu0Yyivkni/DF3IayBGoOYt32uTeOFlteL0PkYiIb5NJBicZbnqSsF
 jWByp5WaxMT4qJiuLlfFEaK/WA==
X-Google-Smtp-Source: AGHT+IHS86QrpcWkgOlghYdoXe/LKfVVYQ38ytcnLlZO8MxPrn97Mw3ldJqZfU7Jbf/uqntgrml2yA==
X-Received: by 2002:a05:6a21:1ca7:b0:16b:74db:8fde with SMTP id
 sf39-20020a056a211ca700b0016b74db8fdemr4088709pzb.61.1697631557508; 
 Wed, 18 Oct 2023 05:19:17 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a170902c44900b001ba066c589dsm3384708plm.137.2023.10.18.05.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 05:19:17 -0700 (PDT)
Message-ID: <fe9d34fc-8dbb-4c90-a6b4-1539c3b86c0f@daynix.com>
Date: Wed, 18 Oct 2023 21:19:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/riscv: Remove misa_mxl validation
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231012054223.37870-1-akihiko.odaki@daynix.com>
 <20231012054223.37870-2-akihiko.odaki@daynix.com>
 <5147b65f-8211-4355-b667-f450dc189ae3@linux.alibaba.com>
 <64c66917-2e17-47f6-ad0e-a90d7d89eec1@daynix.com>
 <a3fd0789-c09b-4a34-b3d3-d36ac5201750@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <a3fd0789-c09b-4a34-b3d3-d36ac5201750@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/18 14:53, LIU Zhiwei wrote:
> +CC Richard
> 
> On 2023/10/17 11:37, Akihiko Odaki wrote:
>> On 2023/10/17 11:29, LIU Zhiwei wrote:
>>>
>>> On 2023/10/12 13:42, Akihiko Odaki wrote:
>>>> It is initialized with a simple assignment and there is little room for
>>>> error. In fact, the validation is even more complex.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   target/riscv/cpu.c | 13 ++-----------
>>>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index f5572704de..550b357fb7 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -1042,7 +1042,7 @@ static void 
>>>> riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>>>>       }
>>>>   }
>>>> -static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>>>> +static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
>>>>   {
>>>>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
>>>>       CPUClass *cc = CPU_CLASS(mcc);
>>>> @@ -1062,11 +1062,6 @@ static void 
>>>> riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>>>>       default:
>>>>           g_assert_not_reached();
>>>>       }
>>>> -
>>>> -    if (env->misa_mxl_max != env->misa_mxl) {
>>>> -        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
>>>> -        return;
>>>> -    }
>>>>   }
>>>>   /*
>>>> @@ -1447,11 +1442,7 @@ static void riscv_cpu_realize_tcg(DeviceState 
>>>> *dev, Error **errp)
>>>>           return;
>>>>       }
>>>> -    riscv_cpu_validate_misa_mxl(cpu, &local_err);
>>>> -    if (local_err != NULL) {
>>>> -        error_propagate(errp, local_err);
>>>> -        return;
>>>> -    }
>>>> +    riscv_cpu_validate_misa_mxl(cpu);
>>>
>>> This it not right.  As we are still working on the supporting for 
>>> MXL32 or SXL32, this validation is needed.
>>
>> It's not preventing supporting MXL32 or SXL32. It's removing 
>> env->misa_mxl_max != env->misa_mxl just because it's initialized with 
>> a simple statement:
>> env->misa_mxl_max = env->misa_mxl = mxl;
>>
>> It makes little sense to have a validation code that is more complex 
>> than the validated code.
>>
>>>
>>> And we can't ensure the all RISC-V cpus have the same misa_mxl_max or 
>>> misa_mxl,   it is not right to move it to class.
>>> For example, in the future, riscv64-softmmu can run 32-bit cpu and 
>>> 64-bit cpu. And maybe in heterogeneous SOC,
>>> we have 32-bit cpu and 64-bit cpu together.
>>
>> This patch series does not touch misa_mxl. We don't need to ensure 
>> that all CPUs have the same misa_mxl_max, but we just need to ensure 
>> that CPUs in the same class do. Creating a heterogeneous SoC is still 
>> possible by combining e.g. TYPE_RISCV_CPU_SIFIVE_E31 and 
>> TYPE_RISCV_CPU_SIFIVE_E51, for example.
> 
> I see what you mean. It makes sense  to move the misa_mxl_max field from 
> env to the class struct. The misa_mxl_max  is always be set by  cpu init 
> or the migration.
> 
> The former  is OK. I don't know whether QEMU supports migration from 
> 32-bit CPU to 64-bit CPU. Otherwise,
> 
> Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

It doesn't. docs/devel/migration.rst states:
 > For this to work, QEMU has to be launched with the same arguments the
 > two times.  I.e. it can only restore the state in one guest that has
 > the same devices that the one it was saved (this last requirement can
 > be relaxed a bit, but for now we can consider that configuration has
 > to be exactly the same).

The corresponding CPUs in two QEMU instances launched with the same 
arguments will have the same misa_mxl_max values.

