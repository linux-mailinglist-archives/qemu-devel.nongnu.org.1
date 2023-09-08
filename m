Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEB798A72
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qee0P-0002dx-9E; Fri, 08 Sep 2023 12:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qee0J-0002de-La
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:06:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qee0A-0002Jg-T9
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:06:39 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a63b2793ecso278539866b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694189193; x=1694793993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NiGKgNwoo1t9QvBDw/C4yJW9zW4DCLZnsDeXbgw6FE8=;
 b=ljcfGcKWgdfIyNN5FKKcfT45+t/u9ETqB5uqNsoRu58eQsQG8AfzKu36NN1ldGd9vX
 DFYI18kT0MGyNn21eCR57VfZXTDuzzTKsBI8m6Gn3vza6KFC2AbhLM8zedm/SqrrIp4n
 /W0kaU6x5+bEhUsqyvFK69a81GBKi8WnoM0A/mcziQZELmo/delEbQFqpQPMqlP/BrQ2
 Kmt92BJffWqoWwMbrKrrGlnU8xO34iefUqoKjgmyIcrb3qYXuoPaGzQ61Bb4vZ7XQ6yt
 MRXN5Q8NkJbBfyz0wd45fvc9yQHawzUu1eb16diRR20UO41sHu3IiM4Yzc5luZGok2I6
 dCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694189193; x=1694793993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NiGKgNwoo1t9QvBDw/C4yJW9zW4DCLZnsDeXbgw6FE8=;
 b=UDxowYhjqshcWRDpJh/JhHBnviXKTgqGED3NYhVkWK9qsWmIAxfW3O/uxyu3hT7dpR
 6VHK5ADTGbehvcgbE7iJk4/l34PJUIB4Qy9vjurwgIAcE7SSNjLFXB7TqZz7gEewGNXS
 b7E4eM3HZYXw0J2ych9lduZ/+aO8gEurt9r/JwsOCLC42JoOh26yXkaWHPcKPPAAOjNW
 YY7oGScTP1I5MApKIIOeQ3SufwDrLXeaawV/AaLSl+klymhGcEBUEu9WMKlXCzE2pL4D
 MDb2FqiM+cTrmCRKk/vuror7LDAf6LEhGDgCiJT55HGNVmHIBTCaiT/W0xpzV9LrG4JR
 fzTA==
X-Gm-Message-State: AOJu0YwgcPb6YVQURu2UIH3nlESrUZANi5h/i5OaeJapPSZyKKWcsNZm
 7QgijtLzhaKfD25IRy77ftQTyA==
X-Google-Smtp-Source: AGHT+IH5y6vibNkfMXQVTkoWUgnyHw1MnU704vaLQ9+yhsCp7iRgy5t6vR5FXha3/3NRmp+okoKA6w==
X-Received: by 2002:a17:906:112:b0:994:4095:3abf with SMTP id
 18-20020a170906011200b0099440953abfmr2437436eje.14.1694189193085; 
 Fri, 08 Sep 2023 09:06:33 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 va17-20020a17090711d100b009929ab17be0sm1208705ejb.162.2023.09.08.09.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 09:06:32 -0700 (PDT)
Message-ID: <73c4f932-c96e-af23-4f5c-b25077347b96@linaro.org>
Date: Fri, 8 Sep 2023 18:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
 <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
 <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
 <ed274425-43bd-a4b6-b1d6-1d1d42784cf7@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ed274425-43bd-a4b6-b1d6-1d1d42784cf7@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 8/9/23 18:03, Mark Cave-Ayland wrote:
> On 08/09/2023 10:42, Philippe Mathieu-Daudé wrote:
> 
>> On 8/9/23 08:54, Mark Cave-Ayland wrote:
>>> On 07/07/2023 09:29, Philippe Mathieu-Daudé wrote:
>>>
>>>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>>>> This determines whether the Apple Sound Chip (ASC) is set to 
>>>>> enhanced mode
>>>>> (default) or to original mode. The real Q800 hardware used an EASC 
>>>>> chip however
>>>>> a lot of older software only works with the older ASC chip.
>>>>>
>>>>> Adding this as a machine parameter allows QEMU to be used as an 
>>>>> developer aid
>>>>> for testing and migrating code from ASC to EASC.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> ---
>>>>>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>>>>>   include/hw/m68k/q800.h |  1 +
>>>>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>>> +static bool q800_get_easc(Object *obj, Error **errp)
>>>>> +{
>>>>> +    Q800MachineState *ms = Q800_MACHINE(obj);
>>>>> +
>>>>> +    return ms->easc;
>>>>> +}
>>>>
>>>> Is the getter useful? Otherwise:
>>>
>>> Isn't it a requirement? Otherwise I can see that if we decide to 
>>> enumerate machine properties (similar as to how device properties 
>>> appear in "info qtree") then it would be impossible to display its 
>>> value. Certainly at the moment we consider that adding an object 
>>> property to an underlying struct effectively makes it "public".
>>
>> Just FYI this is not a requirement, per "qom/object.h":
>>
>>    /**
>>     * object_property_add_bool:
>>     * @obj: the object to add a property to
>>     * @name: the name of the property
>>     * @get: the getter or NULL if the property is write-only.
>>     * @set: the setter or NULL if the property is read-only
>>
>> I'm not sure when we want a write-only QOM boolean property, so I
>> genuinely ask, since I agree introspecting QOM object fields from
>> the monitor is helpful.
> 
> Agreed, although I'd be interested to hear if anyone can come up with a 
> compelling use case for write-only properties. In that case I'll assume 
> your R-B stands when I re-send the latest version of the series ;)

Sure R-b stands, this discussion is outside of the scope of your series.


