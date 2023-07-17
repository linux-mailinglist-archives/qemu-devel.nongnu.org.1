Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB77561CF
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMci-0000zC-PD; Mon, 17 Jul 2023 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMce-0000yo-Em
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:42:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMcc-0000kW-Rz
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:42:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142970df44so4197511f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689594153; x=1692186153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5InIicTtMnRfEzI6acmqa8cqpBH6kVWULVpKURy3/bc=;
 b=y0717Z+ga3UwdbLcqxQTXq/F4HmDaRblzFGl3dKztgMZQyKSHVI6N5lWFURDSrfJw7
 mTBY5uOuKgaVzs8Swn4WgzFnTB6znPNfn5JRHXz1tyJaTbBEgFQObBFEuGk43oaoC4n0
 4nUju6/oh7anb6lVkrrAxXduHiTF3cRaZieNRznnfKHIGbZ7FcC6YBGnv8QzWIqR+KT3
 rWYX0HYBoiznzLyY3ngRNljeSVyVRQiZixi7BKAXzTW5JFfo6JLJ1bshyf9C8CndTMbL
 aYu44PdG73c4CGV2ZslpaEoaaEMRJrBMh6jyuziiD0Owu4d/P6TRLXWo+Z9MX/zwZcr4
 QgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689594153; x=1692186153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5InIicTtMnRfEzI6acmqa8cqpBH6kVWULVpKURy3/bc=;
 b=HxMUTtRoXw05+B36MMdcSjQ+SOmJ4fTnFKxQvUCrIMqT1uO9pZv+qAnmW5DMAk1vXZ
 K3TUqReNr8mHqGBhxYU8enqtqgbd6QpBdB3YRU+kSrvfv36FMZJJ2DpXd2+3baknCAM2
 IGO2CW53he9VldgpgOjaq5MOBrk6COopu7sasQlHPF+LoYwomcgQh2pf4DWHecGNFJt8
 FQuYyho6ZlyN7V1ykHjnZxfa5tLwqlASoecZLe0obgiWl++KO6sb4m1Ulbl5X1jQlKNv
 0cqqQiMlaGEzeEUMt3ftBgbUb2FrlGspuiqxo2FXOlfC+andwC1vMQdVT1euna5IbojY
 mwVQ==
X-Gm-Message-State: ABy/qLb/7wZFZ1/LDXr2GSU5tfS3ZJu1Aybxcsrns8WW6BlBulHOreYy
 MFlzbCqpBzR6vz91q7qfbXOlAA==
X-Google-Smtp-Source: APBJJlE8M4SiATzh3QLyy/S3perRtcNyCWhjRGJU+uoZO2vvubHBEUlONh2wNnbSmszxZ9pc+tqtSA==
X-Received: by 2002:adf:f7cb:0:b0:314:11fe:c72e with SMTP id
 a11-20020adff7cb000000b0031411fec72emr10270885wrq.46.1689594153254; 
 Mon, 17 Jul 2023 04:42:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 a4-20020adfeec4000000b0030c4d8930b1sm19039507wrp.91.2023.07.17.04.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 04:42:32 -0700 (PDT)
Message-ID: <c29e4e41-f54f-5120-ba0d-d04bd7de1f9c@linaro.org>
Date: Mon, 17 Jul 2023 13:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230714172602.397267-1-peter.maydell@linaro.org>
 <869d9cf9-003a-b721-651c-b5bb82ed593d@linaro.org>
 <CAFEAcA9UdPwdJpXg3EFUEvvWji-bs_fCok=M+k=Tf_ej9w+j2w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9UdPwdJpXg3EFUEvvWji-bs_fCok=M+k=Tf_ej9w+j2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 16/7/23 19:32, Peter Maydell wrote:
> On Fri, 14 Jul 2023 at 18:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 14/7/23 19:26, Peter Maydell wrote:
>>> In CPUSparcState we define the fprs field as uint64_t.  However we
>>> then refer to it in translate.c via a TCGv_i32 which we set up with
>>> tcg_global_mem_new_ptr().  This means that on a big-endian host when
>>> the guest does something to writo te the FPRS register this value
>>> ends up in the wrong half of the uint64_t, and the QEMU C code that
>>> refers to env->fprs sees the wrong value.  The effect of this is that
>>> guest code that enables the FPU crashes with spurious FPU Disabled
>>> exceptions.  In particular, this is why
>>>    tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
>>> times out on an s390 host.
>>>
>>> There are multiple ways we could fix this; since there are actually
>>> only three bits in the FPRS register and the code in translate.c
>>> would be a bit painful to convert to dealing with a TCGv_i64, change
>>> the type of the CPU state struct field to match what translate.c is
>>> expecting.
>>>
>>> (None of the other fields referenced by the r32[] array in
>>> sparc_tcg_init() have the wrong type.)
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Another in my occasional series of "fix an avocado failure on
>>> s390" Friday afternoon patches :-)
>>
>> :)
>>
>>> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
>>> index a1c8fdc4d55..bddb9609b7b 100644
>>> --- a/target/sparc/gdbstub.c
>>> +++ b/target/sparc/gdbstub.c
>>> @@ -96,7 +96,10 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>>>        case 83:
>>>            return gdb_get_regl(mem_buf, env->fsr);
>>>        case 84:
>>> -        return gdb_get_regl(mem_buf, env->fprs);
>>> +    {
>>> +        target_ulong fprs = env->fprs;
>>> +        return gdb_get_regl(mem_buf, fprs);
>>
>> Why not return gdb_get_reg32() ?
> 
> Because that would cause different on-the-wire data to be
> sent to gdb -- gdb_get_reg32() puts 4 bytes of data into
> the gdb remote protocol packet, whereas gdb_get_regl() puts
> either 4 or 8 bytes depending on TARGET_LONG_BITS (as
> it happens, here we'll always send 8 because this register
> is sparc64- specific).

Right, I missed the TARGET_LONG_BITS part.

> Anyway, Richard is correct and we don't need to change this
> at all, because gdb_get_regl() takes an integer argument,
> it isn't a magic macro that implicitly takes the address
> or looks at the type of what it gets passed. So passing
> it env->fprs will zero-extend that and DTRT.

OK.


