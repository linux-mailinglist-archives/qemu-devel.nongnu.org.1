Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E87447B5
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFV28-0007zp-2W; Sat, 01 Jul 2023 03:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFV26-0007zg-1S
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:28:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFV24-0001sN-06
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:28:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so2263661b3a.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688196513; x=1690788513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRE1h4cJwtDUVPPMZi0vlYKRFABMLjQLrQzGOQp5MZ4=;
 b=DdGYF6vfHTN39SklI2JLF8YI8vo0Um4WsUD/K/X1QSzraO4iZEwAGFym5Rqpgqn0CJ
 1Z7o+Wvxh8nV25w67LgQu3AKedFXyliSpk/P/rScgL17anEApGTGZIRW4S6TWhJZWEqN
 AbI6Cjr71yFBint/nW6t6TnrILDrcAUaOU88Opjn706cdjm1CDFvcTncQjKvCKpFO8w5
 u8/STJDPLkpcjOvWrVCABkmQmFXZMJai149psbLzILsu5rAIJm1hOGEpME/2amXZBUWH
 aQCOWVtr1RtV3XJaT+GDrnpyI6T6cR3EIDYszR7oXV7r6+jPqMnVjWiN13NE6biFsW/O
 bvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688196513; x=1690788513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRE1h4cJwtDUVPPMZi0vlYKRFABMLjQLrQzGOQp5MZ4=;
 b=lLPaBbmKQJ8S0h0t+qIE13hWAYRmOjUshHTVKC35D8RmVnIvsmML2mxw+36YC8yb52
 HkAnZngZIjbfulOoCh1Ee4qkJ/pOtaqegiMow+Ree2rfqJrNiIIGli1lhHiMt6de7sxt
 9I125gS6NCpCBa3sGwbd4E6ztjFKFAFiKum9Z0+Ect26ghoLHCFVKsUVQEeKzc6o4isz
 vrfl1mqNmk5e8Oz1c/HlaKb7JiU0ph3+EPg3RF2oIPD1hUhnJaHuJFSO+xTRFCaaXvIP
 DuEaUohJZeG9c0K9POzy7FJvF8qI6g6lUEXolE8XXwTG2foUKtx5n0wpYKYqpiRchRi2
 W8zQ==
X-Gm-Message-State: ABy/qLaY11QuDMR/R9MJxpVv3un3CqPemHZM1iighvyEYcosAWClUlM9
 B99UYou5OfXxETKNJziZkJaLjt5fhM6qd4+z3aI=
X-Google-Smtp-Source: APBJJlF1JI8Ygny4tXQB4m+jfZlDGl01MIyjVUl+WIvW2KVz/daOP3SoTKxfL0E90rlbx3rsTPkj2Q==
X-Received: by 2002:a05:6a00:3983:b0:66a:5d4a:e47d with SMTP id
 fi3-20020a056a00398300b0066a5d4ae47dmr6016224pfb.8.1688196512881; 
 Sat, 01 Jul 2023 00:28:32 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 21-20020aa79255000000b00665a76a8cfasm10952767pfp.194.2023.07.01.00.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 00:28:32 -0700 (PDT)
Message-ID: <0879ed66-766c-1d3f-dcce-31e1285a7972@daynix.com>
Date: Sat, 1 Jul 2023 16:28:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <20230630112611-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230630112611-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

On 2023/07/01 0:29, Michael S. Tsirkin wrote:
> On Fri, Jun 30, 2023 at 08:36:38PM +0900, Akihiko Odaki wrote:
>> On 2023/06/30 19:37, Ani Sinha wrote:
>>>
>>>
>>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>>>
>>>>>
>>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>>>
>>>>>>>>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
>>>>>>>>>>
>>>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>>>
>>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
>>>>>>>>>
>>>>>>>>> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
>>>>>>>>>
>>>>>>>>> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
>>>>>>>>>
>>>>>>>>> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
>>>>>>>>
>>>>>>>> I think it's allowed because it expects you to hotplug function 0 later,
>>>>>>>
>>>>>>> This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.
>>>>>>
>>>>>> yes but if you later add a device with ARI and with next field pointing
>>>>>> slot 2 guest will suddently find both.
>>>>>
>>>>> Hmm, I tried this:
>>>>>
>>>>> -device pcie-root-port,id=p \
>>>>> -device igb,bus=p,addr=0x2.0x0 \
>>>>> -device igb,bus=p,addr=0x0.0x0 \
>>>>>
>>>>> The guest only found the second igb device not the first. You can try too.
>>>>
>>>> Because next parameter in pcie_ari_init does not match.
>>>
>>> OK send me a command line that I can test it with. I can’t come up with a case that actually works in practice.
>>
>> I don't think there is one because the code for PCI multifunction does not
>> care ARI. In my opinion, we need yet another check to make non-SR-IOV
>> multifunction and ARI capability mutually exclusive; if a function has the
>> ARI capability and it is not a VF, an attempt to assign non-zero function
>> number for it should fail.
> 
> Why is that? My understanding is that ARI capable devices should also
> set the multifunction bit in the header. It's not terribly clear from
> the spec though.

Something like the following will not work properly with ARI-capable 
device (think of a as an ARI-capable device):
-device a,addr=0x1.0x0,multifunction=on -device a,addr=0x1.0x1

This is because the next function numbers advertised with ARI are not 
updated with the multifunction configuration, but they are hardcoded in 
the device implementation. In this sense, the traditional (non-SR/IOV) 
multifunction mechanism QEMU has will not work with ARI-capable devices.

> 
>> But it should be a distinct check as it will need to check the function
>> number bits.
>>
>>>
>>>>
>>>>
>>>>>>
>>>>>>>> no?
>>>>>>>>
>>>>>>>> I am quite worried about all this work going into blocking
>>>>>>>> what we think is disallowed configurations. We should have
>>>>>>>> maybe blocked them originally, but now that we didn't
>>>>>>>> there's a non zero chance of regressions,
>>>>>>>
>>>>>>> Sigh,
>>>>>>
>>>>>> There's value in patches 1-4 I think - the last patch helped you find
>>>>>> these. so there's value in this work.
>>>>>>
>>>>>>> no medals here for being brave :-)
>>>>>>
>>>>>> Try removing support for a 3.5mm jack next. Oh wait ...
>>>>>
>>>>> Indeed. Everyone uses bluetooth these days. I for one is happy that the jack is gone (and they were bold enough to do it while Samsung and others still carry the useless port ) :-)
>>
>> Hello from a guy using a shiny M2 Macbook Air carrying the legacy jack with
>> a 100-yen earphone. Even people who ported Linux to this machine spent
>> efforts to get the jack to work on Linux ;)
>>
>>>>>
>>>>>>
>>>>>>>> and the benefit
>>>>>>>> is not guaranteed.
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> MST
>>>
> 

