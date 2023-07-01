Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940EE74478E
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUjj-0003R4-R9; Sat, 01 Jul 2023 03:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUji-0003Qu-GZ
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:09:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUjg-0003Jh-6t
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:09:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so2051437b3a.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688195374; x=1690787374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2yKZQhpgz6rMoakUlQ2ANLJZIfYYrHytvw9jsQZCf8=;
 b=WfqfMIw+z40GNmpJT+wqnlMs8eV7voa5ybrYORsfhieYaPDqjHu+y26s+oJ9xyOg0d
 67r/mYxk3s+4L9zgokQN95T2+AMTed3XkrhlXQuslI45rkfPSyoCvNTmUR4Wm2QV7z3D
 Cfq+gbP5To1chPKT0MXAhL6+7BKj3hIH99pPqRsgGFWyWcxsFNpicO9pxejpET7gBz0t
 m/S4dFaUPstbs3WDP/JHktSvcGacBBOEoakOtexkVVruy7j8KBiq1gjtg434bIiG1RXV
 0M7AbXjQlGy6kGOA9wvfJK6GCm16cVxGAWn7ocPjLOSvH04FIjZH28XfDd3kj+YeMDmt
 tQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688195374; x=1690787374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2yKZQhpgz6rMoakUlQ2ANLJZIfYYrHytvw9jsQZCf8=;
 b=X3gJJtL0IFozBTmd1GCpbdWHlRK58XIy97ZCd0EAG7s4emTRl7AyRRwc5mkeWjkIG+
 6vvbY2E9v+88CiN1DyNbK22SBj5cQv7u99jr536wM9yDX/l9DCSPeC3AHjsjEW/Fx6m6
 qUuYaYjzgDGN8VutVYSo9tOBZC2QHJOG6F3HxJ6AhEtsuQ4Lc4IL0WzLNV7w+ZJ3oSRI
 4gnS8klJ6sZFfnUjcUY5T42BMh2dpC96MdZShZRliE0dtxwU4th4VfKfT3sL2OioyoVx
 s8b7EfwBP79HUnW2WjoLPo+Pdx8obtNOJaw45YyZoD7QS2C9sE0iDmNKXmKFCb2IyzAz
 ra4Q==
X-Gm-Message-State: ABy/qLZtiWDqQovdJYnrnrt0ns1pFpfBM6M1q8R31cKabvYEUPct+1lW
 NXOg4amI+7zhJPGmLegl/AykqQ==
X-Google-Smtp-Source: APBJJlEHvK1ZuxSErnPKc/Cr0k5zZk8B3HUZddWa1Dl+a5QL+Rq0hdabXmLeUHo6eIBfyJWThk+ydw==
X-Received: by 2002:a05:6a00:847:b0:676:399f:346b with SMTP id
 q7-20020a056a00084700b00676399f346bmr6715379pfk.1.1688195374557; 
 Sat, 01 Jul 2023 00:09:34 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 g6-20020aa78746000000b00666b6dc10desm10389757pfo.56.2023.07.01.00.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 00:09:34 -0700 (PDT)
Message-ID: <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
Date: Sat, 1 Jul 2023 16:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

On 2023/06/30 22:56, Ani Sinha wrote:
> 
> 
>> On 30-Jun-2023, at 5:25 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/06/30 20:36, Akihiko Odaki wrote:
>>> On 2023/06/30 19:37, Ani Sinha wrote:
>>>>
>>>>
>>>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>
>>>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>>>
>>>>>>
>>>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>
>>>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>>>
>>>>>>>>>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
>>>>>>>>>>>
>>>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>>>
>>>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
>>>>>>>>>>
>>>>>>>>>> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
>>>>>>>>>>
>>>>>>>>>> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
>>>>>>>>>>
>>>>>>>>>> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
>>>>>>>>>
>>>>>>>>> I think it's allowed because it expects you to hotplug function 0 later,
>>>>>>>>
>>>>>>>> This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.
>>>>>>>
>>>>>>> yes but if you later add a device with ARI and with next field pointing
>>>>>>> slot 2 guest will suddently find both.
>>>>>>
>>>>>> Hmm, I tried this:
>>>>>>
>>>>>> -device pcie-root-port,id=p \
>>>>>> -device igb,bus=p,addr=0x2.0x0 \
>>>>>> -device igb,bus=p,addr=0x0.0x0 \
>>>>>>
>>>>>> The guest only found the second igb device not the first. You can try too.
>>>>>
>>>>> Because next parameter in pcie_ari_init does not match.
>>>>
>>>> OK send me a command line that I can test it with. I can’t come up with a case that actually works in practice.
>>> I don't think there is one because the code for PCI multifunction does not care ARI. In my opinion, we need yet another check to make non-SR-IOV multifunction and ARI capability mutually exclusive; if a function has the ARI capability and it is not a VF, an attempt to assign non-zero function number for it should fail.
>>
>> No, the more straightforward way to fix this problem is to check the device function number is less than the next function number advertised with ARI.
>>
> 
> Personally I would leave the check for ARI capable devices to someone else. I am ok with moving the check to pci_qdev_realize() and I verified that both unit tests and the breaking test case for BZ 2128929 is caught. I have also verified that the change does not break igb vf generation.
> If there is any interest to push this change, I will spin a new version with tags for test fixes added and the rework for this patch with the check moved to the new location as you had suggested.

I sent a patch series to add ARI next function number check:
https://lore.kernel.org/qemu-devel/20230701070133.24877-1-akihiko.odaki@daynix.com/

Yes, I want the slot number restriction to be enforced. If it worries 
you too much for regressions, you may implement it as a warning first 
and then turn it a hard error when the next development phase starts.

