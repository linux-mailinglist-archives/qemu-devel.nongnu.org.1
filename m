Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52B828ED7
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:24:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJYg-0003gf-G8; Tue, 09 Jan 2024 16:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJYZ-0003gD-7Q
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:22:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJYU-00087V-3F
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:22:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e54f233abso2610715e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704835355; x=1705440155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vilajE5PD5xNBjEyKKd02WV1Do39jbxVN5LpyF4myDk=;
 b=UHue8fNIt3JdFkD0LyUmueGZFqY3JUHtvNd/ItIEtq1/bX7MOBM7trof6XecV3IkBN
 Ijnr6/5IUDg+pNnLi6ER3ug72ze9AXwZ97pMYQZw75ZHdqU+2e3ORcTc4KFLefllqjkB
 xeXzG1v/BzqoYujXBDivhWpnNEZsQNBU1KNPjKjFqeynJaNMS1YoPN0MGAe8yuodmff6
 JCspzVIkB+2avCEUmMc39eRDn33HY1gAyomFwhS0fKju7UrHZvG/5Grcy2aKP8uNcTI0
 +XhTd6hi0I/Jr3j4FiMLM0YgaK1dngUuDKkEUaykl3z+M+9NVOEgMhXPotcT0TWHWkbm
 4WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704835355; x=1705440155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vilajE5PD5xNBjEyKKd02WV1Do39jbxVN5LpyF4myDk=;
 b=jN7K79oVH5SKKnmeKtN2bjJE6UISrP9ks5nWi/e882odoWy8YAKuNPvW0PqTe0ULR8
 2AnsDwpZY3+k+LaZNwQDilpAi/PuYeMEmU3X4dG6l6P4+pRwxa4YdVHpulfCn/lCSHBx
 uBEMY0MMzSCfQ8gijHv0CZ3NataFzhRHkFgf3D0nUHBZPooYb56eTwdrwISi1Q+mEvlj
 3SCDpV9w+oqWB86mkcJTOYzdsXyWtZRBFxWQEWFj69FT1cU8aGQyqLgFBFH8DU2Fh9S7
 Zesg0whnD3LS4DdkOWV6lyKhCvHzfs+I78CP4aGvtE9jXrKc0oCZIt7N0K3ZGN2DM5HU
 Y0Lw==
X-Gm-Message-State: AOJu0YzhcBwLpnh3AkO7hjF8LwCluH6wYnebtsMGyjtzpPX3/zrPBVD3
 kaZx7DehEScQC8ot46hOj5340swlYcb97A==
X-Google-Smtp-Source: AGHT+IEAJEHgRoRyUHQtZpit8RRsRcQzryKB20FYHzfp1NjPrNzEae/jM666RZEIN0O3yT5dlel3NA==
X-Received: by 2002:a05:600c:4fc7:b0:40e:fba:524 with SMTP id
 o7-20020a05600c4fc700b0040e0fba0524mr3152487wmq.120.1704835355086; 
 Tue, 09 Jan 2024 13:22:35 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 bg30-20020a05600c3c9e00b0040d62f89381sm4924090wmb.35.2024.01.09.13.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:22:34 -0800 (PST)
Message-ID: <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
Date: Tue, 9 Jan 2024 22:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-devel@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Xu <peterx@redhat.com>
References: <20231212162935.42910-1-philmd@linaro.org>
 <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org> <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org> <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org> <87bk9u8dhs.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87bk9u8dhs.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Fabiano,

On 9/1/24 21:21, Fabiano Rosas wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 1/9/24 18:40, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@kaod.org> writes:
>>>
>>>> On 1/3/24 20:53, Fabiano Rosas wrote:
>>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>>
>>>>>> +Peter/Fabiano
>>>>>>
>>>>>> On 2/1/24 17:41, Cédric Le Goater wrote:
>>>>>>> On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
>>>>>>>> Hi Cédric,
>>>>>>>>
>>>>>>>> On 2/1/24 15:55, Cédric Le Goater wrote:
>>>>>>>>> On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> When a MPCore cluster is used, the Cortex-A cores belong the the
>>>>>>>>>> cluster container, not to the board/soc layer. This series move
>>>>>>>>>> the creation of vCPUs to the MPCore private container.
>>>>>>>>>>
>>>>>>>>>> Doing so we consolidate the QOM model, moving common code in a
>>>>>>>>>> central place (abstract MPCore parent).
>>>>>>>>>
>>>>>>>>> Changing the QOM hierarchy has an impact on the state of the machine
>>>>>>>>> and some fixups are then required to maintain migration compatibility.
>>>>>>>>> This can become a real headache for KVM machines like virt for which
>>>>>>>>> migration compatibility is a feature, less for emulated ones.
>>>>>>>>
>>>>>>>> All changes are either moving properties (which are not migrated)
>>>>>>>> or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
>>>>>>>> is still migrated elsewhere). So I don't see any obvious migration
>>>>>>>> problem, but I might be missing something, so I Cc'ed Juan :>
>>>>>
>>>>> FWIW, I didn't spot anything problematic either.
>>>>>
>>>>> I've ran this through my migration compatibility series [1] and it
>>>>> doesn't regress aarch64 migration from/to 8.2. The tests use '-M
>>>>> virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I don't
>>>>> think we even support migration of anything non-KVM on arm.
>>>>
>>>> it happens we do.
>>>>
>>>
>>> Oh, sorry, I didn't mean TCG here. Probably meant to say something like
>>> non-KVM-capable cpus, as in 32-bit. Nevermind.
>>
>> Theoretically, we should be able to migrate to a TCG guest. Well, this
>> worked in the past for PPC. When I was doing more KVM related changes,
>> this was very useful for dev. Also, some machines are partially emulated.
>> Anyhow I agree this is not a strong requirement and we often break it.
>> Let's focus on KVM only.
>>
>>>>> 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>>
>>>> yes it depends on the QOM hierarchy and virt seems immune to the changes.
>>>> Good.
>>>>
>>>> However, changing the QOM topology clearly breaks migration compat,
>>>
>>> Well, "clearly" is relative =) You've mentioned pseries and aspeed
>>> already, do you have a pointer to one of those cases were we broke
>>> migration
>>
>> Regarding pseries, migration compat broke because of 5bc8d26de20c
>> ("spapr: allocate the ICPState object from under sPAPRCPUCore") which
>> is similar to the changes proposed by this series, it impacts the QOM
>> hierarchy. Here is the workaround/fix from Greg : 46f7afa37096
>> ("spapr: fix migration of ICPState objects from/to older QEMU") which
>> is quite an headache and this turned out to raise another problem some
>> months ago ... :/ That's why I sent [1] to prepare removal of old
>> machines and workarounds becoming a burden.
> 
> This feels like something that could be handled by the vmstate code
> somehow. The state is there, just under a different path.

What, the QOM path is used in migration? ...

See recent discussions on "QOM path stability":
https://lore.kernel.org/qemu-devel/ZZfYvlmcxBCiaeWE@redhat.com/
https://lore.kernel.org/qemu-devel/87jzojbxt7.fsf@pond.sub.org/
https://lore.kernel.org/qemu-devel/87v883by34.fsf@pond.sub.org/

> No one wants
> to be policing QOM hierarchy changes in every single series that shows
> up on the list.
> 
> Anyway, thanks for the pointers. I'll study that code a bit more, maybe
> I can come up with some way to handle these cases.
> 
> Hopefully between the analyze-migration test and the compat tests we'll
> catch the next bug of this kind before it gets merged.
> 
> 


