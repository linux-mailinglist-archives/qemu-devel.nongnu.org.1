Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA37CE667
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBGP-00087o-EM; Wed, 18 Oct 2023 14:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBFt-00083c-71
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:26:53 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBFr-0003Gs-LF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:26:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9be1ee3dc86so782761766b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697653609; x=1698258409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v0O6QkQIfHxfDYCocjtWA/gx85Y3GhqSdWEfZKggQ6g=;
 b=MRqKmT0noYwwtgVe0IjvHM5tjh/zL2ITOw+dwLbroN0j2udwkIbnvdF+lUnAFwKft/
 KW0a+3Zxp0Es7gDO3X3y46NsM5+90oOQ45nBTCwe7YUHfPCJB7AlaF6ixqTiIytHzNBx
 UyBPU5RCbltEp9bdvzjzWfJjKMzDtw0bUDF4o6SiJI6kMtlp/m2HMNFUZMytRgjbLoGL
 Z60oWSTyAT2QqtjcVFDgEq3Cyr/cpzwriluAJ6hDPxcvTXjiiUMi4RgX5OOx4xCj6IlG
 tkr/YU8+DjrGeJpWvEIY3mK/9zDLV+takVnEYmTkotMgfbI/AVd30Mv8tDDXadYypaIl
 C+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653609; x=1698258409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0O6QkQIfHxfDYCocjtWA/gx85Y3GhqSdWEfZKggQ6g=;
 b=EE1I3lsSYExo8QqiTxwm255KsoLXPFV6ZRZkmmiYlbbusGTh0GaRIoaMp/r8fugsMb
 T31cGaDsxebj88Aq9RhMqjOybwo/itgyvsrOKCReHPQ9haIV4sVLnG5QnPKNUgsztELc
 g6gGQDd6qZYxy+hMOrO3T6PdUd1q2yXuUNRbEFqgqRlbFaolGN+8qgkjMbtZPJ67kIVp
 m7SCEaR7JoKz2dfS4/+UMPvWUYQ8yAmCSwqoMCpMqWW1xd60KorjmxRlOIVzRaqQ3aH2
 VDS6Y/6Qo7A2RmNtj3r8QAPgbE+kaKit+qNlz0ueocoSESlpD7h3rxuKfgcMKi+675lX
 nfCQ==
X-Gm-Message-State: AOJu0YxZxoX99LaWiN39tnGfOR6HxG6hzuh5EIR3hOy2Bc8Oj58Zjfvc
 1TsgRlG7JnqF0YzTePl7bLhLDg==
X-Google-Smtp-Source: AGHT+IEf9NYxQ4uu5A/9neGRx+8DbLaDarkV0megFeylxumnqMlMLuW0hry7679gsTl15M1m/W0SFg==
X-Received: by 2002:a17:906:4784:b0:9be:36c2:162 with SMTP id
 cw4-20020a170906478400b009be36c20162mr58267ejc.31.1697653608888; 
 Wed, 18 Oct 2023 11:26:48 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a170906039800b009bf7a4d591bsm2112585eja.45.2023.10.18.11.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 11:26:48 -0700 (PDT)
Message-ID: <d5dd91d5-ecc3-c8d4-6cd9-4ec3f277d15f@linaro.org>
Date: Wed, 18 Oct 2023 20:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 08/12] hw/isa: Realize ISA BUS sysbus device before
 accessing it
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231018141151.87466-1-philmd@linaro.org>
 <20231018141151.87466-9-philmd@linaro.org>
 <a9a6adeb-ab58-40fa-b940-5c5897c82cc8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <a9a6adeb-ab58-40fa-b940-5c5897c82cc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/23 17:57, Thomas Huth wrote:
> On 18/10/2023 16.11, Philippe Mathieu-Daudé wrote:
>> sysbus_mmio_map() should not be called on unrealized device.
> 
> I also cannot spot a sysbus_mmio_map() here ... do you mean qdev_new() 
> instead?

Yeah, bad copy/paste :/

> 
>   Thomas
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/isa/isa-bus.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
>> index a289eccfb1..f1e0f14007 100644
>> --- a/hw/isa/isa-bus.c
>> +++ b/hw/isa/isa-bus.c
>> @@ -52,18 +52,25 @@ static const TypeInfo isa_bus_info = {
>>   ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
>>                       MemoryRegion *address_space_io, Error **errp)
>>   {
>> +    DeviceState *bridge = NULL;
>> +
>>       if (isabus) {
>>           error_setg(errp, "Can't create a second ISA bus");
>>           return NULL;
>>       }
>>       if (!dev) {
>> -        dev = qdev_new("isabus-bridge");
>> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +        bridge = qdev_new("isabus-bridge");
>> +        dev = bridge;
>>       }
>>       isabus = ISA_BUS(qbus_new(TYPE_ISA_BUS, dev, NULL));
>>       isabus->address_space = address_space;
>>       isabus->address_space_io = address_space_io;
>> +
>> +    if (bridge) {
>> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(bridge), &error_fatal);
>> +    }
>> +
>>       return isabus;
>>   }
> 


