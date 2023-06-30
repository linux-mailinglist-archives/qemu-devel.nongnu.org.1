Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B941A743B3B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCjC-0001xI-44; Fri, 30 Jun 2023 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFCj9-0001wq-4W
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:55:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFCj7-0008Cl-DF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:55:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b82616c4ecso8984835ad.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688126147; x=1690718147;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SlC9LQyqBUeVDkBDAq4dB+Pw1IO/UN2vkOa6tdAeFM=;
 b=RUfl6Q/Rrg9VEWO7aoXH/LE6TAkdq4RtYJSfYASZNzgk381VbieVuBN/hZQY+VODzF
 6eWkrqJSbBEjOeoZ1jVF7tHrQQWOuGWKcYy/ho4cyA8hPG/11Y3loDwKvcMv4NxCmVBk
 1FDrvqY2QSnx/SfDMkBs+vDc9V7sWneO38Rk/MufDx/TNQ+3JT8W3/cen2VXB+7IU0B9
 ex7euYDyg1I6+9gG7LwUOBdwXSsqRSTqgXOygMb7iQAbMjdtbvUQaAPOdJhgZ6iDaIc9
 yal1qc3MuAXnaTHwTASrxn//19iulg2dg97HKqevmvHSkdtZ0eZzGnQHsS7HQ/k10OVv
 rv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688126147; x=1690718147;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SlC9LQyqBUeVDkBDAq4dB+Pw1IO/UN2vkOa6tdAeFM=;
 b=bcxp0pmU8tKgr8xA5CnzxsxlEfvy/JWO4vx67MWyTR0S4OTUWhw1IemRRTF6A/gCWn
 XO3hdIufWvfdhN4mibdqzJAaWGX0m7+Bj6lM/T2GQrAunoYgyF54yHicDAWfq7pxo9lw
 KHIFEFD448LD+U97yqt/+seiyGwuephmFI5Aui1Eh3U0KTQ0zGnpkVnMBWSOjBPGYS6i
 Gn45oM5Yye2BUXcRaGelPOZGTew8kASztz8mugNEmNfDppN23yv8Dxzc10PH+JA6PYvy
 kzIQdbBRcszY9WLMjH0T+SYrSbq1sA3JfmhHji0mKgwxbkwY9rCNk2o1mQMqhvcAthWT
 9cxQ==
X-Gm-Message-State: ABy/qLbCpqJyS5copT9hhDjRfJt4qfck+0GJDVvfBtcRA1pTi6YXs5QT
 S/BDaD7Y3cKhD/OZ8mzoltXUNw==
X-Google-Smtp-Source: APBJJlGqbxln5Xc40N4uLgJEedktpH1ImiWrJJ1diEAs22l9fupJMyup00JQvQ3UPQu5uW0qwpsV7A==
X-Received: by 2002:a17:903:41cb:b0:1b3:d418:7599 with SMTP id
 u11-20020a17090341cb00b001b3d4187599mr1778704ple.13.1688126147405; 
 Fri, 30 Jun 2023 04:55:47 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b3bf8001a9sm10705833plp.48.2023.06.30.04.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 04:55:46 -0700 (PDT)
Message-ID: <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
Date: Fri, 30 Jun 2023 20:55:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
In-Reply-To: <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/06/30 20:36, Akihiko Odaki wrote:
> On 2023/06/30 19:37, Ani Sinha wrote:
>>
>>
>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>
>>>>
>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>
>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>
>>>>>>
>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> 
>>>>>>> wrote:
>>>>>>>
>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>
>>>>>>>>> Thus the check for unoccupied function 0 needs to use 
>>>>>>>>> pci_is_vf() instead of checking ARI capability, and that can 
>>>>>>>>> happen in do_pci_register_device().
>>>>>>>>>
>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>
>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before 
>>>>>>>>> option ROM loading.
>>>>>>>>
>>>>>>>> Hmm, I tried this. The issue here is something like this would 
>>>>>>>> be now allowed since the PF has ARI capability:
>>>>>>>>
>>>>>>>> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
>>>>>>>>
>>>>>>>> The above should not be allowed and when used, we do not see the 
>>>>>>>> igb ethernet device from the guest OS.
>>>>>>>
>>>>>>> I think it's allowed because it expects you to hotplug function 0 
>>>>>>> later,
>>>>>>
>>>>>> This is about the igb device being plugged into the non-zero slot 
>>>>>> of the pci-root-port. The guest OS ignores it.
>>>>>
>>>>> yes but if you later add a device with ARI and with next field 
>>>>> pointing
>>>>> slot 2 guest will suddently find both.
>>>>
>>>> Hmm, I tried this:
>>>>
>>>> -device pcie-root-port,id=p \
>>>> -device igb,bus=p,addr=0x2.0x0 \
>>>> -device igb,bus=p,addr=0x0.0x0 \
>>>>
>>>> The guest only found the second igb device not the first. You can 
>>>> try too.
>>>
>>> Because next parameter in pcie_ari_init does not match.
>>
>> OK send me a command line that I can test it with. I can’t come up 
>> with a case that actually works in practice.
> 
> I don't think there is one because the code for PCI multifunction does 
> not care ARI. In my opinion, we need yet another check to make 
> non-SR-IOV multifunction and ARI capability mutually exclusive; if a 
> function has the ARI capability and it is not a VF, an attempt to assign 
> non-zero function number for it should fail.

No, the more straightforward way to fix this problem is to check the 
device function number is less than the next function number advertised 
with ARI.

> 
> But it should be a distinct check as it will need to check the function 
> number bits.



