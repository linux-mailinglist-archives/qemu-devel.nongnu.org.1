Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF3737F39
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:57:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuZH-0000zr-Hq; Wed, 21 Jun 2023 05:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuZG-0000zg-C7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:56:02 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuZC-0000Mi-T5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:56:02 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51bdd67a306so424923a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687341356; x=1689933356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QmNYpLSbt871gUyI0nYFvhy5d6MZJO6xBbGDpV6gfDs=;
 b=ajuMlZcnwa/LWUsVGoDAADXllE520GtAr2zD8Jjm69+RqcwV/4FC9g3iO/9Mlq3PYc
 5eRqKfoY5C3JyUyMiDDrP4aiCeedIM4WkiJ12Zslg9HMBM/FO/RNSdX/l8BpvOWUQEgf
 gVsUryXXRcn1g1UPyZxeJWsBh6uPtdf7266NotYgPkRUX3X/mL3yIawnYVHnS/Mhc9mu
 4FXWPevYPgmpPJTPyCNpSzCpWTzu9GF/290ni7+QTUXUjsIxUS+6rUTyqo/vHOElCzd7
 49eO5TM9YZtDJsrt8gy5REW5WuckNhzCUSESUvOp1gEGb57ZYXPX70SMGCcEn2VtCjbK
 +SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687341356; x=1689933356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QmNYpLSbt871gUyI0nYFvhy5d6MZJO6xBbGDpV6gfDs=;
 b=NXjQe+0Zrhad8blg36UkcSsPHosIM2ArFWxX6CqxM0ZBcFo1hy1rfxupfAU6ENsF4i
 TCpAmSMrtfuhzdziLQursmm/y4AzhADfk1k1P/t/92diwoAvPHWnWEeVC2scchXID6sl
 xVpXX2tm0WliPI1C3nZqex3muxWmAUGjFg8JtJD7j/TJ/Rqs6cj+fsILmQCZ6XcDvVny
 HxECP+AGLrcmoB6Tn/SXqGfPU0vxUS/nlPIJmf63o8DOMRhjRzO5eWBuUc/ou3T+9Iva
 WoMmLGISATu5SGj/8qa9d7U+Q6ou81MDNqcL9aIBn+GWY7NhhSh3vpKs7/HnH9dq5ZSm
 rfYw==
X-Gm-Message-State: AC+VfDzQofec3uL2+g/1dwsVU9KX/dsFRSwRj6zQlGI+31a+NgvwSYan
 qZse7lgEGDRquh4gCf+0r3FE3w==
X-Google-Smtp-Source: ACHHUZ50QWTX/RcgGuGzyTr7a2hYnGJpWx96UGQ0t289pM700O8LilLIiTDeu2edslmkeF5NvKk5nA==
X-Received: by 2002:a17:907:1689:b0:988:c14e:ddef with SMTP id
 hc9-20020a170907168900b00988c14eddefmr6708572ejc.67.1687341355727; 
 Wed, 21 Jun 2023 02:55:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709061f0500b00973ca837a68sm2862457ejj.217.2023.06.21.02.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:55:55 -0700 (PDT)
Message-ID: <1bb33f17-1620-b225-8a23-951b26f647a5@linaro.org>
Date: Wed, 21 Jun 2023 11:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
 <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
 <87352li6kx.fsf@linaro.org>
 <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 10:53, Peter Maydell wrote:
> On Wed, 21 Jun 2023 at 09:05, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Tue, 20 Jun 2023 at 17:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> $ make -C build/x86 check-tcg
>>>> make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86'
>>>> [...]
>>>>    TEST    munmap-pthread on arm
>>>> **
>>>> ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
>>>> failed: (success)
>>>> **
>>>> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
>>>> failed: (cpu == current_cpu)
>>>
>>> git bisect blames commit d7ee93e2435970:
>>>
>>>      cputlb: Restrict SavedIOTLB to system emulation
>>>
>>> I think that commit is not correct, because it means that
>>> the size of 'struct CPUState' and also the offset of fields
>>> like 'cpu_index' will be different for files which are
>>> compile-per-target-for-usermode and files which are
>>> compile-once-only. The assert happens here because the
>>> code which sets up cpu_index is build-once, but the code
>>> in qemu_plugin_vcpu_init_hook() which reads cpu_index is
>>> build-per-target and now they don't agree about where in
>>> the struct the field is...
>>
>> Hmm two things from that imply:
>>
>>    - I suspect the plugin core stuff could be build once (or maybe twice,
>>      system and user)
> 
> It is already build-once, that's why it goes wrong...
> 
>>    - we need to have some guard rails somehow to make sure things don't
>>      go out of sync
> 
> We do, this is the poison.h stuff. CONFIG_USER_ONLY is a
> special case which we don't poison because there would be
> too much refactoring required...

Just FYI the goal of the series including this commit is to remove
"exec/hwaddr.h" from user emulation.


