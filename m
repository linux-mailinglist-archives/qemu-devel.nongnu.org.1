Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583357A47BE
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiC1i-00031i-Sy; Mon, 18 Sep 2023 07:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiC1d-0002rS-65
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiC1b-0002HM-EG
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695034962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xp1iy6sezCJpX0rF+l09jiXaRJ9Grmtkqion6oCdXOA=;
 b=G9JQd7Httpfoe5MEqdLmouoiY5EafBOpJgeqmDWDKGWIALd4WhRFKWCdDswLwS9ITb6z4a
 NQB4p5wgrtLa4KH7Xp6KW3VyAhH3Lw4jF5OL8KjeB5VxS5TR5iurZs4ywOVnEidwt50YuI
 zV+wNPl6U9dOPv2BrrF13r38QH/u0Fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-H0RLgOuoOMmE3DcpYtBkIQ-1; Mon, 18 Sep 2023 07:02:41 -0400
X-MC-Unique: H0RLgOuoOMmE3DcpYtBkIQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso2884466f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034960; x=1695639760;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xp1iy6sezCJpX0rF+l09jiXaRJ9Grmtkqion6oCdXOA=;
 b=g5W1nMXt9a9+2sv13soZUhqPCCQ5ePgYztMZsRhYW5iJxVsvCStWRkK+EiJjKtfA2s
 BaQ4rYB4KvVfTAyXt1O0W3a0Guk4BSuRgumf7AcxsdeXzFrfWtUDjGltVjXWWYpmkqtt
 a7uEWQGpztkt2sSnnsl7rnTXpbwZEUJ3KoSHv+OyYpySZaK+nKZZc4WqZvA11nZ4WdSA
 xSAJ0XeuIrZtyA+aYqgNu7ISh364v1IfdydWc54EyjOdLOBIjePJOrr83iRkVdwiJ20B
 5t6mUUVZKKCOJ3eZZ1aSnIS4wlG6OA685j4tpaGUoUkDVZzAJ66Eskl5ujWUA9eZrCfz
 6Lxg==
X-Gm-Message-State: AOJu0YyM+H33ebC1sWkmWWsV5lFnZiKrk2LBt/U9HQ0ZT8foF6dODroh
 STqwLjUX8c4xxs/O/8AlvCxGlyENxn4/VeiSaH2IJUn2HSR79rgB2AMWPubzVtECd4QryeIRilb
 OxGiK6vh+glJY3lQ=
X-Received: by 2002:a5d:5a15:0:b0:31f:f43e:4f3c with SMTP id
 bq21-20020a5d5a15000000b0031ff43e4f3cmr9245388wrb.8.1695034959958; 
 Mon, 18 Sep 2023 04:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhpIU6aShqY6lwJnwXDTG87ThpLn6UDF4QAJTqJp5fB+rErsYwD1cfCAbdbKiafq3qI2+7iA==
X-Received: by 2002:a5d:5a15:0:b0:31f:f43e:4f3c with SMTP id
 bq21-20020a5d5a15000000b0031ff43e4f3cmr9245362wrb.8.1695034959578; 
 Mon, 18 Sep 2023 04:02:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b00402fa98abe3sm14993144wmr.46.2023.09.18.04.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 04:02:39 -0700 (PDT)
Message-ID: <3aa2bd37-c9d3-558a-5cc1-7c5b0cb8337a@redhat.com>
Date: Mon, 18 Sep 2023 13:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
 <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
 <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
 <5b22fff5-270f-0ab5-1ee5-2e54f491aefd@redhat.com>
 <CAK3XEhMf88si5NcQbAODRC+7760ymgFOx83a_ih4jOqoaDDcyg@mail.gmail.com>
 <cce0cebd-952f-9ed9-f2fd-d84dd666d322@redhat.com>
 <CAK3XEhO9DAWE6SXd4Nmham3Q=MMLU6Dda1O=EHwz55iMELv3zQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhO9DAWE6SXd4Nmham3Q=MMLU6Dda1O=EHwz55iMELv3zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 18.09.23 13:00, Ani Sinha wrote:
> On Mon, Sep 18, 2023 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.09.23 12:54, Ani Sinha wrote:
>>> On Mon, Sep 18, 2023 at 3:49 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 18.09.23 12:11, Ani Sinha wrote:
>>>>
>>>>>
>>>>>       Ok hopefully my last question. I am still confused on something.
>>>>>       Does the above mean that the hole64 will actually start from an
>>>>>       address that is beyond maxram? Like basically if you added all of
>>>>>       ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can it
>>>>>       exceed maxram? I think it will. Does this not an issue?
>>>>
>>>> If you'd have a 2 GiB VM, the device memory region and hole64 would
>>>> always be placed >= 4 GiB address, yes.
>>>>
>>>> As maxram is just a size, and not a PFN, I don't think there is any
>>>> issue with that.
>>>
>>> So this is all just a scheme to decide what to place where with maxram
>>> amount of memory available. When the processor needs to access the
>>
>> Yes. ram_size and maxram_size are only used to create the memory layout.
>>
>>> memory mapped PCI device, its simply dynamically mapped to the
>>> available physical ram. Is my understanding correct here?
>>
>> I'm no expert on that, but from my understanding that's what the
>> pci/pci64 hole is for -- mapping PCI BARs into these areas, such that
>> they don't conflict with actual guest RAM. That's why we still account
>> these "holes" as valid GFN that could be used+accessed by the VM once a
>> PCI BAR gets mapped in there.
> 
> Yes that was my understanding too but since device drivers need to
> access those BAR addresses, they need to be mapped to the actual
> available physical ram.

These devices supply their own RAM memory regions for BARs, that will 
get mapped into the holes. They are not using any boot/hotplug memory. 
It's confusing.

-- 
Cheers,

David / dhildenb


