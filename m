Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0C715FB9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yUu-0004vX-2E; Tue, 30 May 2023 08:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3yUn-0004oo-N5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3yUl-0001PT-2B
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d24136663so2937507b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685449833; x=1688041833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4W+kDvN1TPtWktEZ8ntdoFys6rqrU/SSy1yXhV8nPUY=;
 b=wV7GyaDBg7+aWwuQ43oo8HOk68hZ0tlo3a2oGd1HwF8agL4W00ETR3jfGXMpLOtJ7/
 /lw1Fvz7MVrUVft9UO99DYRZ2GWzHlZbXufyhXsVuFfuhGFO0Im2JAxYLm97bf+WETob
 55dh3dK73qekmXApqqtH+wgeP2W8+JabFVUnttdqspiwmvR9cHWEG1TcuK1DHHVZvDup
 rQAEuaOq70RCqUD9k5h+ocX6c30he4gZf9DfBss0h+jCnI2UOLvVg+a9N+mQ9ZGcleZf
 Xakv5ZnaH5+TVPuH79phdpa/T/DVp+b8yZpwiw9nZQizo3FgZ48bpyuEcpGXxWdAlQZX
 ztjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449833; x=1688041833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4W+kDvN1TPtWktEZ8ntdoFys6rqrU/SSy1yXhV8nPUY=;
 b=h3/251q5Rh81Oz6P0eARq8Rujnh4VfD8Km1jwKql5SIog40ixH1ehaXrjUyeLxXV1N
 uwKIW9roj1mjzlHK0mhVpU7vIVZZXhXV4jlwrrpfdIr7pIeMTLQZTUmsaOeq1XOaJvdF
 U9tz0MWQuqkRF+wPWuDFvKatrJNiYekts8PkzBKueJpNssZdg/1+EumXKe6ULpodjbDA
 PlwlgAb/9ysdJNdRZojh66PzC991rbYxYM6FW4UO8VA7dom0r6gOk5I1Mhn3hTdEgD4Z
 kCTHkNNQpHEU5KyAwrndh1PGcJoM5yQki+BapLClBecdXTVKNjFXyV88dJiaJelSzJx/
 hcRw==
X-Gm-Message-State: AC+VfDzFWRp6ERiPPYvec+VMZEAFeYVdpTDmBuyMrA1H943SbHgjZucX
 DFRGvhnVb85LzNJg/tGuVrRxXA==
X-Google-Smtp-Source: ACHHUZ5Vh4S4C0k+AUWQwoC1U5AEWjPCubueiNiYTVDg3f5/E+OCI96p3lJ75LDevVMWQ+zSeriNsg==
X-Received: by 2002:a17:902:7c8d:b0:1b0:34a1:9946 with SMTP id
 y13-20020a1709027c8d00b001b034a19946mr2051011pll.46.1685449833641; 
 Tue, 30 May 2023 05:30:33 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a17090276c700b001a6d4ea7301sm10142355plt.251.2023.05.30.05.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:30:32 -0700 (PDT)
Message-ID: <ed02c7af-e149-b1c5-0298-12c0d6c1d696@daynix.com>
Date: Tue, 30 May 2023 21:30:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
 <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
 <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
 <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
 <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
 <DBBP189MB1433898733717D58F8A58C75954B9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <DBBP189MB1433898733717D58F8A58C75954B9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/05/30 17:30, Sriram Yagnaraman wrote:
> 
> 
>> -----Original Message-----
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Sent: Tuesday, 30 May 2023 04:02
>> To: Cédric Le Goater <clg@redhat.com>; Sriram Yagnaraman
>> <sriram.yagnaraman@est.tech>; qemu-devel@nongnu.org
>> Cc: Jason Wang <jasowang@redhat.com>
>> Subject: Re: [PATCH] igb: Add Function Level Reset to PF and VF
>>
>> On 2023/05/30 0:07, Cédric Le Goater wrote:
>>> On 5/29/23 09:45, Akihiko Odaki wrote:
>>>> On 2023/05/29 16:01, Cédric Le Goater wrote:
>>>>> On 5/29/23 04:45, Akihiko Odaki wrote:
>>>>>> On 2023/05/28 19:50, Sriram Yagnaraman wrote:
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>>> Sent: Friday, 26 May 2023 19:31
>>>>>>>> To: qemu-devel@nongnu.org
>>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>; Sriram Yagnaraman
>>>>>>>> <sriram.yagnaraman@est.tech>; Jason Wang
>> <jasowang@redhat.com>;
>>>>>>>> Cédric Le Goater <clg@redhat.com>
>>>>>>>> Subject: [PATCH] igb: Add Function Level Reset to PF and VF
>>>>>>>>
>>>>>>>> The Intel 82576EB GbE Controller say that the Physical and
>>>>>>>> Virtual Functions support Function Level Reset. Add the
>>>>>>>> capability to each device model.
>>>>>>>>
>>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
>>>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>>>> ---
>>>>>>>>    hw/net/igb.c   | 3 +++
>>>>>>>>    hw/net/igbvf.c | 3 +++
>>>>>>>>    2 files changed, 6 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/net/igb.c b/hw/net/igb.c index
>>>>>>>> 1c989d767725..08e389338dca
>>>>>>>> 100644
>>>>>>>> --- a/hw/net/igb.c
>>>>>>>> +++ b/hw/net/igb.c
>>>>>>>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev,
>>>>>>>> uint32_t addr,
>>>>>>>>
>>>>>>>>        trace_igb_write_config(addr, val, len);
>>>>>>>>        pci_default_write_config(dev, addr, val, len);
>>>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>>>
>>>>>>>>        if (range_covers_byte(addr, len, PCI_COMMAND) &&
>>>>>>>>            (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
>> @@
>>>>>>>> -427,6
>>>>>>>> +428,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error
>>>>>>>> **errp)
>>>>>>>>        }
>>>>>>>>
>>>>>>>>        /* PCIe extended capabilities (in order) */
>>>>>>>> +    pcie_cap_flr_init(pci_dev);
>>>>>>>> +
>>>>>>>>        if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>>>            hw_error("Failed to initialize AER capability");
>>>>>>>>        }
>>>>>>>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c index
>>>>>>>> 284ea611848b..0a58dad06802 100644
>>>>>>>> --- a/hw/net/igbvf.c
>>>>>>>> +++ b/hw/net/igbvf.c
>>>>>>>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice
>>>>>>>> *dev, uint32_t addr, uint32_t val,  {
>>>>>>>>        trace_igbvf_write_config(addr, val, len);
>>>>>>>>        pci_default_write_config(dev, addr, val, len);
>>>>>>>> +    pcie_cap_flr_write_config(dev, addr, val, len);
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr,
>>>>>>>> unsigned size) @@ -266,6 +267,8 @@ static void
>>>>>>>> igbvf_pci_realize(PCIDevice *dev, Error
>>>>>>>> **errp)
>>>>>>>>            hw_error("Failed to initialize PCIe capability");
>>>>>>>>        }
>>>>>>>>
>>>>>>>> +    pcie_cap_flr_init(dev);
>>>>>>>
>>>>>>> Sorry for my naive question, and perhaps not related to your
>>>>>>> patch, IGBVF device class doesn't seem to have any reset functions
>>>>>>> registered via igbvf_class_init(). So, I am guessing an FLR will
>>>>>>> not trigger igb_vf_reset(), which is probably what we want.
>>>>>
>>>>> It does through the VTCTRL registers.
>>>>>
>>>>>> You're right. Advertising FLR capability without implementing it
>>>>>> can confuse the guest though such probability is quite a low in
>>>>>> practice. The reset should be implemented first.
>>>>>
>>>>>
>>>>> I was looking at an issue from a VFIO perspective which does a FLR
>>>>> on a device when pass through. Software and FLR are equivalent for a
>>>>> VF.
>>>>
>>>> They should be equivalent according to the datasheet, but
>>>> unfortunately current igbvf implementation does nothing when reset.
>>>> What Sriram proposes is to add code to actually write VTCTRL when FLR
>>>> occurred and make FLR and software reset equivalent. And I think that
>>>> should be done before this change; you should advertise FLR
>>>> capability after the reset is actually implemented.
>>>
>>>
>>> AFAICT, the VFs are reset correctly by the OS when created or probed
>>> and by QEMU when they are passthrough in a nested guest OS (with this
>> patch).
>>> igb_vf_reset() is clearly called in QEMU, see routine
>>> e1000_reset_hw_vf() in Linux.
>>
>> I don't think this patch makes difference for e1000_reset_hw_vf() as it does not
>> rely on FLR.
>>
>>>
>>> I don't think a reset op is necessary because VFs are software
>>> constructs but I don't mind really. If so, then, I wouldn't mimic what
>>> the OS does by writing the RST bit in the CTRL register of the VF, I
>>> would simply install igb_vf_reset() as a reset handler.
>>
>> Thinking about the reason why VFIO performs FLR, probably VFIO expects the
>> FLR clears all of states the kernel set to prevent the VF from leaking kernel
>> addresses or addresses of other user space which the VF was assigned to in the
>> past, for example.
>>
>> Implementing the reset operation is not necessary to make it function but to
>> make it secure, particularly we promise the guest that we clear the VF state by
>> advertising FLR.
>>
>> Regards,
>> Akihiko Odaki
>>
> 
> I did some digging, and I can see that the linux igbvf device driver registers for FLR and performs a SW reset anyhow.
> https://lore.kernel.org/all/20230301105706.547921-1-kamil.maziarz@intel.com/

The register function in the Linux driver should be considered as 
something different from FLR. FLR we have discussed is a PCIe capability 
that the hardware advertises.

> I have not checked what the other drivers do though, I can send a patch if you think it is worth having a reset operation on the igbvf device.

I think it's better if Cédric writes such a patch and place it before 
the patch to advertise FLR in a series. It will be easier to make the 
patches in order this way.

Regards,
Akihiko Odaki

> 
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>> I am not sure a VF needs more really, since it is all controlled by
>>>>> the PF. > C.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>        if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>>>>>>>>            hw_error("Failed to initialize AER capability");
>>>>>>>>        }
>>>>>>>> --
>>>>>>>> 2.40.1
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>

