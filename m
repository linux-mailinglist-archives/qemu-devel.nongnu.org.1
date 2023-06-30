Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6F743AEE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCQj-0003LW-Tm; Fri, 30 Jun 2023 07:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFCQg-0003LC-IL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:36:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFCQe-0001Aq-NM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:36:46 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55ae51a45deso1034266a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688125002; x=1690717002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSY7O1OugaRaZMr8Rb80FrR91/MDWjjWKeybca58yiw=;
 b=xrdHOHDmKMB94S+tg8UiUziKZiWPu0dPfd2nRQuT1y62yOzab1RE7hnBDOieL/HLNl
 +SxuzJKnQ60G4cLJu113B2t9T1sTTHfOYlPLf9SF/DYRuH5pIK4GdJmTk015ykMaIh+4
 JS4vIefcVEFzk67d+e3UznPIaFEyiQUtRHT0u9cqwFnR+V9HrxLooKBCnsxkOhj0vSf4
 fL+cf2orwANZUHL6ZIpu6J4rFLgYN0kQdW8vjQcnVNeIUT3Fr975cN8qOF/GhGANtKFP
 XG75upUELTzDvN0mw7gLel+1CB2etOu9s9UrV/w/Zs4IgcPEauGDop888sF4P0r2uLlT
 V6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688125002; x=1690717002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSY7O1OugaRaZMr8Rb80FrR91/MDWjjWKeybca58yiw=;
 b=KgrRh/MhHpAuhrb0BNA1P1xOsYdKBn2AsNgpVvX0xjjSLfCrbjn3Xpj0K5VeKbWnM8
 gICjF3bsFLBRSnkL/5wFpARSvaGMzAwXed2olnga4NYMJp7RiXd8KcEykueWQgs5CG3G
 sBu/kurgWju7KSGNWd6Pl9ZoLb4UdJ2+JxG/jfmQ1Vn52E2aug5s3qFcgUTMme7ofWf7
 hzZdSfvRrA3k3FokUIdC61eJG6n2lBRJFzfkO7YHsujk+loQ3gStUlvPTQDC7gPJGMyq
 Ly97vp7XmJWyCn3oQ9RlG+tPmirw4phKw/1Sl3yKkKAQQaD0kdYO0l0wBHb4sv1+78aw
 5/Iw==
X-Gm-Message-State: AC+VfDwTjaYL4ZTAtTtlxCp0Hng0DY3o3x4+QBt9JZA8PMtHz/90DGyr
 xQDu7VDP84oSqf6r8MFpIdijrg==
X-Google-Smtp-Source: ACHHUZ6FXvt10H/6r0AOXrecnIbR8iloEYQlkTfaZl4uYrVugKrU4GAldZzkcWQirR4qrqZip4cxOQ==
X-Received: by 2002:a05:6a20:7b26:b0:11c:d2af:70a6 with SMTP id
 s38-20020a056a207b2600b0011cd2af70a6mr1381379pzh.28.1688125001828; 
 Fri, 30 Jun 2023 04:36:41 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001b8707b70d1sm1014114pla.214.2023.06.30.04.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 04:36:41 -0700 (PDT)
Message-ID: <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
Date: Fri, 30 Jun 2023 20:36:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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

On 2023/06/30 19:37, Ani Sinha wrote:
> 
> 
>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
>>>
>>>
>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
>>>>>
>>>>>
>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>>>>>>
>>>>>>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
>>>>>>>>
>>>>>>>>> Also where do you propose we move the check?
>>>>>>>>
>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
>>>>>>>
>>>>>>> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
>>>>>>>
>>>>>>> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
>>>>>>>
>>>>>>> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
>>>>>>
>>>>>> I think it's allowed because it expects you to hotplug function 0 later,
>>>>>
>>>>> This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.
>>>>
>>>> yes but if you later add a device with ARI and with next field pointing
>>>> slot 2 guest will suddently find both.
>>>
>>> Hmm, I tried this:
>>>
>>> -device pcie-root-port,id=p \
>>> -device igb,bus=p,addr=0x2.0x0 \
>>> -device igb,bus=p,addr=0x0.0x0 \
>>>
>>> The guest only found the second igb device not the first. You can try too.
>>
>> Because next parameter in pcie_ari_init does not match.
> 
> OK send me a command line that I can test it with. I can’t come up with a case that actually works in practice.

I don't think there is one because the code for PCI multifunction does 
not care ARI. In my opinion, we need yet another check to make 
non-SR-IOV multifunction and ARI capability mutually exclusive; if a 
function has the ARI capability and it is not a VF, an attempt to assign 
non-zero function number for it should fail.

But it should be a distinct check as it will need to check the function 
number bits.

> 
>>
>>
>>>>
>>>>>> no?
>>>>>>
>>>>>> I am quite worried about all this work going into blocking
>>>>>> what we think is disallowed configurations. We should have
>>>>>> maybe blocked them originally, but now that we didn't
>>>>>> there's a non zero chance of regressions,
>>>>>
>>>>> Sigh,
>>>>
>>>> There's value in patches 1-4 I think - the last patch helped you find
>>>> these. so there's value in this work.
>>>>
>>>>> no medals here for being brave :-)
>>>>
>>>> Try removing support for a 3.5mm jack next. Oh wait ...
>>>
>>> Indeed. Everyone uses bluetooth these days. I for one is happy that the jack is gone (and they were bold enough to do it while Samsung and others still carry the useless port ) :-)

Hello from a guy using a shiny M2 Macbook Air carrying the legacy jack 
with a 100-yen earphone. Even people who ported Linux to this machine 
spent efforts to get the jack to work on Linux ;)

>>>
>>>>
>>>>>> and the benefit
>>>>>> is not guaranteed.
>>>>>>
>>>>>> -- 
>>>>>> MST
> 

