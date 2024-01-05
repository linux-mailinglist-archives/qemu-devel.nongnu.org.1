Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45078258E4
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLnl4-00038V-RF; Fri, 05 Jan 2024 12:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLnkt-00035o-8u
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:13:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLnkp-0002Zm-9i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:13:09 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so2094544a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704474784; x=1705079584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VV+6GUBPjLkx/5c8VXWyxeLSspJIwB/ya4y6DAP+no=;
 b=K4GeJ95a3e+5fj27V4OvpQc/ssTKH6YQTZv4F5l4BL/EkVBW+aDEK/K6A8rWKbmhDd
 +GVom2IOxmJmxZ7+Idc5XxOdaHpNTnoLhiNN/QFmIXF06gucCEQ8az9/xEUzYQ24Orcg
 ZEeloEKbzFh7UUnGf6041LODKaizOs1DgVm+ZUM/8YtBn3PUbHsUbsF6EzXPWNm9H2eM
 aHea7qu4+qjI+IV026VjTc7zvmtw/ObzTdstSf9tvuwvU9vFG/jhsqLKxOtCOf90PAoV
 L2oydyVQoEXWGSy4MrLlAGLdNHSou8WPbfhRPpjrrcLIaaxYSysxCCvwcrjGxpwQUfeY
 hW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704474784; x=1705079584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VV+6GUBPjLkx/5c8VXWyxeLSspJIwB/ya4y6DAP+no=;
 b=jgPY+Ln3AQeVp+XP+8d0NGhZNdpy+HZKQT16uxhRNXU6uQxoBoFV6zbfzOojNWYPfB
 wQ6BqHfux76xP2aL0GYfM5SI/szK8JAz5lFNFkPK5jtkwOABQmim65AlPup0Ekfokpze
 1h5S72qafWR39Z7tpMqnhzK0+tRyna0cccLocFqbZecPSagkAoq2SqJ3EqU/SZA/um8T
 rh/+smTMFiUut3jnzXOgcljwj3Fv9DXyRlVf+xnE+F6nXMi3jnQtG+EiqAWVupwieM3b
 pJXTRqWQV0yGK4eK/aZc77Hh82yjpAZyv36cbkTu/Nofg9th/nTurKIlYIdi8ueNb47R
 HHzA==
X-Gm-Message-State: AOJu0Yxuma+dYW6iRWSzwLe37mYCou3Uewc9NzMaW1T0gsHnvQSlJYJ4
 UYWERGVI900SKgoVklwQAzKAL4JEFMhf1A==
X-Google-Smtp-Source: AGHT+IHBaFa2FKrUq2IWbTW2LO1N1qZXaTnujPBjkOyOgrUgk1zOmhMePhLrFt7zfUceQqja3HsxuA==
X-Received: by 2002:a17:907:c88:b0:a27:9660:c2ae with SMTP id
 gi8-20020a1709070c8800b00a279660c2aemr1047501ejc.8.1704474783943; 
 Fri, 05 Jan 2024 09:13:03 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 jo1-20020a170906f6c100b00a26ade46618sm1075431ejb.99.2024.01.05.09.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 09:13:03 -0800 (PST)
Message-ID: <87fcd410-4b25-4f28-80dc-04258dbe7580@linaro.org>
Date: Fri, 5 Jan 2024 18:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/25] memory: Have
 memory_region_init_rom_nomigrate() handler return a boolean
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-4-philmd@linaro.org> <4h38a.h95poe276hnn@linaro.org>
 <af352e7d-3346-4705-be77-6eed86858d18@linaro.org>
 <CAFEAcA_yKxnTMnfWVdXWixPq27=OVQCZ0BjRdiPfSKKhqh=gVw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_yKxnTMnfWVdXWixPq27=OVQCZ0BjRdiPfSKKhqh=gVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

On 5/1/24 15:57, Peter Maydell wrote:
> On Fri, 5 Jan 2024 at 14:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 21/11/23 13:10, Manos Pitsidianakis wrote:
>>> On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org>
>>> wrote:
>>>> Following the example documented since commit e3fe3988d7 ("error:
>>>> Document Error API usage rules"), have cpu_exec_realizefn()
>>>> return a boolean indicating whether an error is set or not.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> include/exec/memory.h | 4 +++-
>>>> system/memory.c       | 8 ++++++--
>>>> 2 files changed, 9 insertions(+), 3 deletions(-)
>>
>>
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 337b12a674..bfe0b62d59 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -1729,14 +1729,18 @@ void memory_region_init_alias(MemoryRegion *mr,
>>>>      mr->alias_offset = offset;
>>>> }
>>>>
>>>> -void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>>>> +bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>>>>                                        Object *owner,
>>>>                                        const char *name,
>>>>                                        uint64_t size,
>>>>                                        Error **errp)
>>>> {
>>>> -    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0,
>>>> errp);
>>>> +    bool rv;
>>>> +
>>>> +    rv = memory_region_init_ram_flags_nomigrate(mr, owner, name,
>>>> size, 0, errp);
>>>>      mr->readonly = true;
>>>> +
>>>
>>> By the way, do we want to set mr->readonly on failure? Should there be
>>> modifications if an error is propagated upwards?
>>
>> Good point
> 
> I don't think it matters much. If the init function fails,
> then the MemoryRegion is not initialized, and there's
> nothing you can do with the struct except free it (if it
> was in allocated memory). Whether the readonly field is
> true or false doesn't matter, because conceptually it's
> all undefined-values. And memory_region_init_ram_flags_nomigrate()
> has already written to some fields, so avoiding changing
> mr->readonly specifically doesn't seem worthwhile.

I concur with your analysis. QEMU Error* type is helpful to propagate
errors, but the cleanup path is rarely well implemented. See for
example the many returns in DeviceRealize handlers without releasing
previously allocated mem.

In this particular patch case, I find Manos suggestion useful, the
code now uses a simpler pattern and avoid having to look at the
callee implementation.

The updated patch is already in a PR I posted before reading your
comment. The changes seem innocuous to me, so not worthwhile to
restore the previous patch content. But if you object, I don't mind
reposting the PR.

Regards,

Phil.

