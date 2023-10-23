Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519717D29DF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 08:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quo1l-00068j-4t; Mon, 23 Oct 2023 02:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quo1V-000660-Vi
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 02:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quo1K-0003Bi-E9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 02:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698040932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W5MV1gFNb82nnFIYVa5B5yAoXaVdbnLhgg6SAwJYVIw=;
 b=IH5SSyM3NjAGs7EgQYRFTW0kpFGpVoMUiOJpJkwInL41ctg6TXi9rKUf5JgWhCnnKwxEKM
 ZZmASYpKEyNDo2kx+m0GGhjZsdM/nfUdOjAVml9tvl85qc7NPFQASFY/7maNKt98j8yU5I
 vnRwgaNZ4icCtmim5UdQcC+n8jEa+fg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-CqsV12wrObq1MJLZgSXS9Q-1; Mon, 23 Oct 2023 02:02:10 -0400
X-MC-Unique: CqsV12wrObq1MJLZgSXS9Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c797b497e8so123023866b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 23:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698040929; x=1698645729;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5MV1gFNb82nnFIYVa5B5yAoXaVdbnLhgg6SAwJYVIw=;
 b=gTl6lchsp/qIx9xi1bPNFQ99aMf+PIgZpRhHddvc4Wdcf9IoJvwjJzv0OtqUy6CjNT
 oSRiVoOLuGxKIF0+MazNE/GlCW/BvO6VDqSj9k9BE7brw9hQ/uIQgwn06CWRdFcTCSm3
 pz9MPX12L8e+lRrHC59HRO0CPiy4bQocRwbWR6gFkGw3bs2FHkdZ6IrhbYNGcTXNrVTy
 veo070kznoxMeA0C1UXtFPFqJc2bWu8S9QMEycH13zTOEPM+VldM0rSL9dbV2KnmiR8m
 1oHwgE2JNDdsLwPzJjfzl8+htlM3oNqlB7Bqo62UtyYURwHP2whyEUKFbPY513I6HNZO
 ETtA==
X-Gm-Message-State: AOJu0YzvBrJYoOFD9QUKo6NlcHsLRFdVXi8r16ZMA6m7q1Qkrr8C+Sbp
 6r1IKu9oVbN3cPqQV2GgF9732tbkLTRBBCzg/5MerjAcxOtX6fY+MiON2aHJ73in2yEQOQQ0Wig
 9eTODfGZOaLUCm8E=
X-Received: by 2002:a17:907:2d09:b0:9c3:a3f2:4cec with SMTP id
 gs9-20020a1709072d0900b009c3a3f24cecmr5603990ejc.0.1698040929048; 
 Sun, 22 Oct 2023 23:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMBMamq9Cgzx3kNWD3Ee4QoZXnOYzcGq/StLeIG/pEM6BDo+ff/rjwkNHzziv7UB4/MNjoCA==
X-Received: by 2002:a17:907:2d09:b0:9c3:a3f2:4cec with SMTP id
 gs9-20020a1709072d0900b009c3a3f24cecmr5603980ejc.0.1698040928727; 
 Sun, 22 Oct 2023 23:02:08 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 a19-20020a1709065f9300b009b94c545678sm6028653eju.153.2023.10.22.23.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 23:02:08 -0700 (PDT)
Message-ID: <76272c6c-f7b6-4fbd-a457-8cf14048ddca@redhat.com>
Date: Mon, 23 Oct 2023 08:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] migration: Use vmstate_register_any() for isa-ide
Content-Language: en-US
To: quintela@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Stefan Weil
 <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-4-quintela@redhat.com>
 <efef6d37-925c-415e-9a59-85e528eacb7b@redhat.com>
 <871qdpytau.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <871qdpytau.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/2023 21.42, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
>> On 20/10/2023 11.07, Juan Quintela wrote:
>>> Otherwise qom-test fails.
>>> ok 4 /i386/qom/x-remote
>>> qemu-system-i386: savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=isa-ide, instance_id=0x0
>>> Broken pipe
>>> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>>> Aborted (core dumped)
>>> $
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>    hw/ide/isa.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/hw/ide/isa.c b/hw/ide/isa.c
>>> index 95053e026f..ea60c08116 100644
>>> --- a/hw/ide/isa.c
>>> +++ b/hw/ide/isa.c
>>> @@ -73,7 +73,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>>>        ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>>>        ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>>>        ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
>>> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>>> +    vmstate_register_any(VMSTATE_IF(dev), &vmstate_ide_isa, s);
>>>        ide_bus_register_restart_cb(&s->bus);
>>>    }
>>
>> Would it make sense to use another unique ID of the device instead? E.g.:
>>
>> diff a/hw/ide/isa.c b/hw/ide/isa.c
>> --- a/hw/ide/isa.c
>> +++ b/hw/ide/isa.c
>> @@ -73,7 +73,9 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>>       ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>>       ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>>       ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
>> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>> +    vmstate_register(VMSTATE_IF(dev),
>> +                     object_property_get_int(OBJECT(dev), "irq", &error_abort),
>> +                     &vmstate_ide_isa, s);
>>       ide_bus_register_restart_cb(&s->bus);
>>   }
>>     Thomas
> 
> Ide is not my part of expertise.
> But anything that is different for each instantance is going to be good
> for me.

It's not really my turf either ... ok, so unless the IDE maintainer speaks 
up, I think it's maybe best if you continue with your "_any" patch.

  Thomas


