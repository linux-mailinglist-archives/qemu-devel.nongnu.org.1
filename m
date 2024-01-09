Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C640F828EC0
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJLw-00067W-9p; Tue, 09 Jan 2024 16:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJLs-00066x-1v
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:09:37 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNJLo-0001xu-LE
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:09:34 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55753dc5cf0so4073241a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704834569; x=1705439369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wz1iXNg4TXNcOn/x7G2oIVLLHopXLlyNHKrHRtohyQo=;
 b=q2ej43+DEU3HuTNWpIhx7Cu0Ybb/tCGhr974PzhGIZr39Y3rS26d1OWdjZc3V+htSq
 vQph0GX/kXZKNO4OTArySGYCBQDo2RT7IOwDFbDe2CCLG+wUNiG+4r2zVYf69Bahg9bn
 1FW4aWAFw5eGM6xVCQEcPIn/ZhQfrfX+VD6U42TiIPghpkq3nHIP+8YMIw8PlT88OiMy
 XMrqJbgmol75InMxGOMdVqlsvWDs23XcWo5jSwSW8WPmJ8D+NqrugGz68tQfZ6GKwxlL
 xhVfrrj/Z36ccj94nVWJcvETTlT7FYxxiTtbT/hKtRefnhQ25qQuPjSrEGJPg7W4gBXM
 w19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704834569; x=1705439369;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wz1iXNg4TXNcOn/x7G2oIVLLHopXLlyNHKrHRtohyQo=;
 b=B/w8qOCyZnHTE/3eFDkSWfHStUYnB2/KDpcmoaD7TrcTy1ePdCiTFP7UX21JnEN2Pq
 kcwjBDbHMyOkvGhOehlz5DigNCi0fl7PNIcMUHF4El9h3iTA+JfuiOtr2rLE23OBKR7K
 AZeVZYpaLWSj5xeFyt6kReIjryU7d2VIS5gzag7bZppRVBuvBOAW2+GSOR/A3513CxRM
 7oW6ktJFQ7vZ8XK6z9qoxGqh1y9AVxAZomGhLhTQSVmKb6rfn0llb98c43oQytGquMHU
 ZQAb7+27fYffjxUI2X1mtvAfkdmkyJZTJkFmApmcHHz9HamJPGMm5H3Fz8URH3avK9Sx
 n5pQ==
X-Gm-Message-State: AOJu0YzueSerZSRIt3zHs7fMvRI9E+BFXnYgpG4LhvR9Qx/95j6UlEcn
 t5Ce4iN5mBY+ey4W5Fpss0luyO6THvXdcg==
X-Google-Smtp-Source: AGHT+IHftvF2JCRBKB+z64ic95MXrpEdZp/g67kVpBlET30ZvQURGCj3M5YiV7FCXCXenqJW3Z8kkw==
X-Received: by 2002:a17:906:1914:b0:a29:905d:447b with SMTP id
 a20-20020a170906191400b00a29905d447bmr34782eje.96.1704834569679; 
 Tue, 09 Jan 2024 13:09:29 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 p22-20020a17090628d600b00a2b07693f55sm1400919ejd.166.2024.01.09.13.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:09:29 -0800 (PST)
Message-ID: <9a98502f-12a4-4f8f-ba54-a6e1d7a2d4a2@linaro.org>
Date: Tue, 9 Jan 2024 22:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
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
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <e2a282a5-b92a-439e-9ecf-3ea1f74deb25@linaro.org>
In-Reply-To: <e2a282a5-b92a-439e-9ecf-3ea1f74deb25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 9/1/24 22:07, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 9/1/24 19:06, Cédric Le Goater wrote:
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
>>>>>>>>> Changing the QOM hierarchy has an impact on the state of the 
>>>>>>>>> machine
>>>>>>>>> and some fixups are then required to maintain migration 
>>>>>>>>> compatibility.
>>>>>>>>> This can become a real headache for KVM machines like virt for 
>>>>>>>>> which
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
>>>>> virt -cpu max', so the cortex-a7 and cortex-a15 are not covered. I 
>>>>> don't
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
> 
> No no, we want the same for TCG.
> 
>>>>> 1- https://gitlab.com/farosas/qemu/-/jobs/5853599533
>>>>
>>>> yes it depends on the QOM hierarchy and virt seems immune to the 
>>>> changes.
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
>>
>> Regarding aspeed, this series breaks compat.
> 
> Can you write down the steps to reproduce please? I'll debug it.

Also, have you figured (bisecting) which patch start to break?

> We need to understand this.
> 
>> Not that we care much
>> but ​this caught my attention because of my past experience on pseries.
>> Same kind of QOM change which could impact other machines, like virt.
>> Since you checked that migration compat is preserved on virt, we should
>> be fine.
>>
>> Thanks,
>>
>> C.
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/20231214181723.1520854-1-clg@kaod.org/
>>
> 


