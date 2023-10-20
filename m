Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15A7D0CA6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmKv-0002HF-1y; Fri, 20 Oct 2023 06:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtmKc-0002GZ-Qu
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:02:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtmKb-0005sg-0l
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:02:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so5433125e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697796131; x=1698400931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flw+kmMs6an/+VeOsRRRuEdHjQnexjS3qn45gzvLIU0=;
 b=OE1vtjE/hKWI8viBPuhYV/h1/aa39VN0c4qI5xcT4+vgq8t0wyOAEnU0RfoF9WMx41
 IWMJxnA+Gkbu+QBanVMOl4aURjL9b13hxLDP5P8Mnx9ApIRnT9cQPj6mDvQ+L0UgWnpt
 FMbnhzGY5eQGcSv/Qhb6/AJpnr0dtorH3ecU4g44CN1GfUYHmUiGkrQMrYPT4aB5sNeC
 Kn3HXzGrmR818fOJzHJjbA67P7P/oi4ysorgzlwtGdi6I/oSSqgo5OTDg6Zio3VzWTbo
 P9V2yJcmR2Wf11URy3vja+YUt4xphuI7ogToFZ7XoXHS2aUMj9dzeFamZH2KIUNmo9pp
 a3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697796131; x=1698400931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flw+kmMs6an/+VeOsRRRuEdHjQnexjS3qn45gzvLIU0=;
 b=Tvh0DR5RgJ/p2v8t4BPPJgOSes5QH+Jr3cP7yBm0A3q44sP/aTEHnE3bZbRm9wAO4r
 JSDsGH3V1Ax2UUNyNyW7/EMMKvMNJ3AZlHuMihT5mrVSmtxrdWHBAPdYH2zdZYAhEeTD
 En9i4KpwlxDW6dkKjkst4zqz20A7tNqU0ACbrFGsefrn9h56WvgdamCBvLYcBmbMhEoT
 0xM2cxLfsxkvZ961btJIB9mBVjs/v/cuAZoGjd3fkcgvMrKgOsej2M6jgfNiFds/GJdz
 8HaQiGes09VWU5Fysmys1rfwdkJY23VkT4c3jWxviWN2juOh5OKkpyTqwhGsB8kU1ZJK
 n94Q==
X-Gm-Message-State: AOJu0YzSZucW4BZK9R1x0vjrJSqHTAEne5g0Ns8rAgFv058qRT43qgzw
 ioX2h675GjL7zzXoIl5y7WQcgA==
X-Google-Smtp-Source: AGHT+IH0hJ+RWo8qHGzeEAE43Yb3s8EHnxQ/VswJuByO7+Eu7rPMzFO7IkCWgTvaiRxNb2nPUejdbQ==
X-Received: by 2002:a05:600c:4506:b0:402:ee71:29 with SMTP id
 t6-20020a05600c450600b00402ee710029mr1112054wmo.10.1697796131345; 
 Fri, 20 Oct 2023 03:02:11 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 k32-20020a05600c1ca000b00401e32b25adsm1810127wms.4.2023.10.20.03.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 03:02:10 -0700 (PDT)
Message-ID: <078513d9-78fb-21b2-6ad7-8b223f53babe@linaro.org>
Date: Fri, 20 Oct 2023 12:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/audio/pcspk: Inline pcspk_init()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231019073307.99608-1-philmd@linaro.org>
 <C044C8A9-952A-4F9A-8B9F-DE689A5FEF46@gmail.com>
 <87ttqmcxc3.fsf@pond.sub.org>
 <5fd6c6c2-5245-c73c-6683-5136751dbde5@linaro.org>
 <878r7xdhk8.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <878r7xdhk8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 20/10/23 06:49, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 19/10/23 19:54, Markus Armbruster wrote:
>>> Bernhard Beschow <shentey@gmail.com> writes:
>>>
>>>> Am 19. Oktober 2023 07:33:07 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>>> pcspk_init() is a legacy init function, inline and remove it.
>>>>>
>>>>> Since the device is realized using &error_fatal, use the same
>>>>> error for setting the "pit" link.
>>>>>
>>>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> [...]
>>>
>>>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>>>> index 63e0857208..79ffbb52a0 100644
>>>>> --- a/hw/isa/i82378.c
>>>>> +++ b/hw/isa/i82378.c
>>>>> @@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>>>       uint8_t *pci_conf;
>>>>>       ISABus *isabus;
>>>>>       ISADevice *pit;
>>>>> +    ISADevice *pcspk;
>>>>>
>>>>>       pci_conf = pci->config;
>>>>>       pci_set_word(pci_conf + PCI_COMMAND,
>>>>> @@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>>>       pit = i8254_pit_init(isabus, 0x40, 0, NULL);
>>>>>
>>>>>       /* speaker */
>>>>> -    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
>>>>> +    pcspk = isa_new(TYPE_PC_SPEAKER);
>>>>> +    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
>>>>> +    isa_realize_and_unref(pcspk, isabus, &error_fatal);
>>>>
>>>> Why not pass errp here? I think that was Mark's comment in v1.
>>
>> That would more than "inlining".
> 
> Limiting this patch to exactly "inlining" makes sense.  It makes the
> "inapproproate use of &error_fatal" problem more visible.  On the one
> hand, that makes it more likely to be fixed some day.  On the other
> hand, it makes it a more effective bad example.  Bad examples tend to
> multiply.

Fair.

>>                                   Can be updated on top, but so far
>> this function is not error proof, so I'm not really worried.
> 
> Are there more inappropriate uses of &error_fatal in this function?

Indirectly: yes.
Directly: no.

> If no, please throw in a second patch to fix this one.
> 
> If yes, please add a FIXME comment.  Unless you feel like fixing them
> all, in which case go right ahead ;)

Let's continue ignoring the indirect calls.

>>> &error_fatal is almost always wrong in a function that takes Error **.
>>> Happy to explain in more detail if needed.
>>> [...]
> 


