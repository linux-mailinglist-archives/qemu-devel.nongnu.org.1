Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5D7E2A0A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:38:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02cH-00044M-GU; Mon, 06 Nov 2023 11:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r02cE-00043q-N5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:38:18 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r02cC-0000He-5A
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:38:18 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41b7fd8f458so30100871cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699288695; x=1699893495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uP48glW1B5M1ELOdnJI1eEPyMJZ1kwJPb8tmQvPETf8=;
 b=UYAg67DGfmu86ieMGwZBjtHq+sOsY7KqCtGJhurtPLoOrmO/YINY1iaM8Jriic8Bg9
 lbKoP6prgFRcieiWeBrTv+F5nEPNHeP7oGnGQmvHd7CTtlYjCoP+7usTKs+Sih4xcwqB
 s5wD0NJcKL8WgbqBLCMDE1CFJGwOjqC9io3JGCMyL+AwyvG1ziSaFEnLGrI7y/Sp9mc9
 4Zn+zomL2GfpPwlA9Gtsbn3ISXTk2KSwT0M2OO33DelbA7AQauwkx3XRMol0Zj3S4AKk
 WuA+rMWo8wH+z8on8z/Jlrjuqx4SGG/CVeAgcK7COgM2bm6gy4anPcmGmQbp9Oqa31kz
 J1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288695; x=1699893495;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uP48glW1B5M1ELOdnJI1eEPyMJZ1kwJPb8tmQvPETf8=;
 b=if8dswYSG9l3j7oEpWKf6/MYEbXC6kIbHpYidnzkO5R9br74hfM1KX+A5k2GfvmPSP
 5CQlZ/GlKyCy5x2qkY5rcDnUJoMC4TRNT6dOug8kjUuBRaXUhqPXCNfjcryRnOXbuJ7M
 WXoUd9TkQrATgPCQRhhRquli+rsMKdhjSFF9vYnGvBkkSHlEKrF4ZbDl9Zt8IF7CKq14
 gTAnRxh9NxgeqcSZe9EAsPYteo0VFY43W6zosMOPzuuLsudYf7OW/567E1/2sTuz/0sv
 DIM+2ZEr1mmtwarFImFItmcyRix0j9P35EXmOZiNEE86REHV0xByZ4c5ManxpZEFrFOE
 c1Qw==
X-Gm-Message-State: AOJu0YzBrsPET6DVE1vMyTCz8xqI/P77SCwMW1QQIboiZd+7iV2p6pgy
 0P4sZsZRmFwhvp5+Buj9F3njYA==
X-Google-Smtp-Source: AGHT+IEPPWoPzdB38J+OIA2Q0ZpxBFf2a6L7i+/FhGkgIYFZqws362sHfdT5O2Rib3KShBlSwPTSrA==
X-Received: by 2002:a05:622a:1910:b0:41e:4744:4b42 with SMTP id
 w16-20020a05622a191000b0041e47444b42mr42822397qtc.56.1699288695166; 
 Mon, 06 Nov 2023 08:38:15 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 x5-20020ac87ec5000000b004181d77e08fsm3521434qtj.85.2023.11.06.08.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:38:14 -0800 (PST)
Message-ID: <0fbc4857-d9b3-4327-8a00-3fb277f05ef5@ventanamicro.com>
Date: Mon, 6 Nov 2023 13:38:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: don't enable Zfa by default
Content-Language: en-US
To: Jerry ZJ <jerry.zhangjian@sifive.com>, alistair.francis@wdc.com,
 palmer@dabbelt.com, frank.chang@sifive.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20231106111440.59995-1-jerry.zhangjian@sifive.com>
 <c2901c07-9eef-449c-857a-6d2553aeb170@ventanamicro.com>
 <b1df8107-d0f1-4827-94bd-3f8c7cd3ea57@Spark>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <b1df8107-d0f1-4827-94bd-3f8c7cd3ea57@Spark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/6/23 12:21, Jerry ZJ wrote:
> We do have some cases that failed. SiFive e-series cores (https://static.dev.sifive.com/SiFive-E21-Manual-v1p0.pdf <https://static.dev.sifive.com/SiFive-E21-Manual-v1p0.pdf>) do not have F extension (For example: rv32imc_zicsr_zifencei_zba_zbb). When we use the corresponding extension options to configure QEMU, i.e., rv32, i=true, m=true, a=true, c=true, Zicsr=true, Zifencei=true, zba=true, zbb=true, the QEMU will have the following error.
> Zfa extension requires F extension

Can you send your whole command line? I'm unable to reproduce it here. This
will boot:

./build/qemu-system-riscv32 -M virt -cpu rv32,i=true,m=true,a=true,c=true,zicsr=true,zifencei=true,zba=true,zbb=true --nographic


In a side note, we have a new CPU type (still pending, not yet queue) called
"rv64i", which comes only with 'RVI' enabled and nothing else - no defaults,
nothing.

I believe this use case you testing here would benefit from a "rv32i" CPU that
does the same but for 32 bits. Then you can specify the whole CPU and not worry
about hidden defaults. Does that makes sense?

> 
> IMHO, we should not enable Zfa extension by default, especially when Zfa requires F to be enabled implicitly.

If the rv32 use case you mentioned is really breaking because of zfa and
Fm, I'm fine with disabling zfa because it's now a bug. We just need a
reproducer.


Thanks,

Daniel

> 
> Best Regards,
> Jerry ZJ
> *SiFive Inc. Taiwan*
> On Nov 6, 2023 at 22:55 +0800, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, wrote:
>>
>>
>> On 11/6/23 08:14, Jerry Zhang Jian wrote:
>>> - Zfa requires F, we should not assume all CPUs have F extension
>>> support.
>>
>> We do not have a case where this happen, do we? The default CPUs have F
>> enabled (see misa_ext_cfgs[] in target/riscv/tcg/tcg-cpu.c), so zfa being
>> enable isn't a problem for them. Vendor CPUs might not have F enabled, but
>> they don't use the default values for extensions, so they're not affected.
>> Having zfa enabled by default does not hurt the default CPU setups we have.
>>
>> I am not a fan of these defaults for rv64 and so on, but once we set them to
>> 'true' people can complain if we set them to 'false' because it might break
>> existing configs in the wild. We need a strong case (i.e. a bug) to do so.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>
>>> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
>>> ---
>>> target/riscv/cpu.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index ac4a6c7eec..c9f11509c8 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -1247,7 +1247,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>> MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>>> MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>>> MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
>>> - MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
>>> + MULTI_EXT_CFG_BOOL("zfa", ext_zfa, false),
>>> MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
>>> MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
>>> MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),

