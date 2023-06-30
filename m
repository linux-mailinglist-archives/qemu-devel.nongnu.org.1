Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DD7432D5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 04:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF46X-0003n5-IE; Thu, 29 Jun 2023 22:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qF46U-0003mi-Ul
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 22:43:22 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qF46S-0000n2-Rb
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 22:43:22 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-553a998bca3so964339a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688092999; x=1690684999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EIZdwJmh1pY1qvNqP7cCqGMZ657OwGYurtYcv2hphu8=;
 b=YYf+eE7QDGCBNnGt1e9C+SRmpOXQJ0q7z37ddp2/uUNPj8QHcrJ+yQvGg7U2pGHBM0
 Q/PqfPqxtqw0rg+bcDFaVMx0aaFdAJd4i6BbyAO0DPXKqSi8v5RbCGp/Xj6G4T55xDSH
 UI3cPV9jEywvTb76m0lFk7fxQoPBzbAiUM2orgZKPU7Lg3gBymdalb5aTdXitFwKuy8y
 yx1QJohRBkpOykXEXrsjV768A+f8tEypbS+7HZKPQTdaGdUXx84XUhxE/Ge4hZ0Eo1dh
 HUFTticpdSJr29/5goE9B/KSnFVvqQhBmzNo58NCQlMPCjDzorBl1HVfwleAMQ2sFCbs
 tTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688092999; x=1690684999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIZdwJmh1pY1qvNqP7cCqGMZ657OwGYurtYcv2hphu8=;
 b=QFgTQOt7+/NUDMT9hHsqiS8yytZ7GFFPegpPvi7mTdypccj588cXJMcP+0/jFsUND/
 CwnUoFyK3eiJ0pPoLH2gCbA9dp0mASfT4+URCNgcQbw0uPgsSEeaokFbDLHXz9UQ+Ble
 iCxpOkOPBBh8GTEG2h/tEnubbbNcD0SWvJipBDu4uXJpbw+Hlr46Z5D2HqmEIJyWimOp
 mfn0WaVbeZAVsL8N/KW1zcOLN9kI++m2iFZnMeq7vyw7oBlAxSqi/VKgshbfLlt7LYB1
 jgXThcTcU6TLYvRTaZZcy0rkbWIg4NYF5p5D2l/w1IQ/+enWW6MtQwGVOKpK/5IhkqYp
 +MoA==
X-Gm-Message-State: AC+VfDxQmfxaP/JQDOG55aGFexD8HE+R22HT/toayuye0kH9rlJ69Tto
 7A+jn5lh5dfK0KBbeq/O55dOjg==
X-Google-Smtp-Source: ACHHUZ6O/jLOX37w8WoiJ40SqngclXcbFE6vXY0poR5kUXEIxx6QaZ0dDiVge8aC/taDmBmgSv0p/g==
X-Received: by 2002:a05:6a20:1d0:b0:12c:5ea0:4fd6 with SMTP id
 16-20020a056a2001d000b0012c5ea04fd6mr1246763pzz.24.1688092998791; 
 Thu, 29 Jun 2023 19:43:18 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 jn20-20020a170903051400b001b6717deb2esm4890768plb.233.2023.06.29.19.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 19:43:18 -0700 (PDT)
Message-ID: <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
Date: Fri, 30 Jun 2023 11:43:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/06/29 23:18, Ani Sinha wrote:
> 
> 
>> On 29-Jun-2023, at 2:19 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/06/29 17:05, Ani Sinha wrote:
>>> On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>> wrote:
>>>     On 2023/06/29 13:07, Ani Sinha wrote:
>>>      > PCI Express ports only have one slot, so PCI Express devices can
>>>     only be
>>>      > plugged into slot 0 on a PCIE port. Enforce it.
>>>      >
>>>      > The change has been tested to not break ARI by instantiating
>>>     seven vfs on an
>>>      > emulated igb device (the maximum number of vfs the linux igb
>>>     driver supports).
>>>      > The vfs are seen to have non-zero device/slot numbers in the
>>>     conventional
>>>      > PCI BDF representation.
>>>      >
>>>      > CC: jusual@redhat.com <mailto:jusual@redhat.com>
>>>      > CC: imammedo@redhat.com <mailto:imammedo@redhat.com>
>>>      > CC: akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>>>      >
>>>      > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
>>>     <https://bugzilla.redhat.com/show_bug.cgi?id=2128929>
>>>      > Signed-off-by: Ani Sinha <anisinha@redhat.com
>>>     <mailto:anisinha@redhat.com>>
>>>      > Reviewed-by: Julia Suvorova <jusual@redhat.com
>>>     <mailto:jusual@redhat.com>>
>>>      > ---
>>>      >   hw/pci/pci.c | 15 +++++++++++++++
>>>      >   1 file changed, 15 insertions(+)
>>>      >
>>>      > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>      > index e2eb4c3b4a..0320ac2bb3 100644
>>>      > --- a/hw/pci/pci.c
>>>      > +++ b/hw/pci/pci.c
>>>      > @@ -65,6 +65,7 @@ bool pci_available = true;
>>>      >   static char *pcibus_get_dev_path(DeviceState *dev);
>>>      >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>      >   static void pcibus_reset(BusState *qbus);
>>>      > +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>      >
>>>      >   static Property pci_props[] = {
>>>      >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>      > @@ -1190,6 +1191,20 @@ static PCIDevice
>>>     *do_pci_register_device(PCIDevice *pci_dev,
>>>      >                      name);
>>>      >
>>>      >          return NULL;
>>>      > +    } /*
>>>      > +       * With SRIOV and ARI, vfs can have non-zero slot in the
>>>     conventional
>>>      > +       * PCI interpretation as all five bits reserved for slot
>>>     addresses are
>>>      > +       * also used for function bits for the various vfs. Ignore
>>>     that case.
>>>      > +       * It is too early here to check for ARI capabilities in
>>>     the PCI config
>>>      > +       * space. Hence, we check for a vf device instead.
>>>      > +       */
>>>     Why don't just perform this check after the capabilities are set?
>>> We don't want to allocate resources for wrong device parameters. We want to error out early. Other checks also are performed at the same place .
>>
>> It is indeed better to raise an error as early as possible so that we can avoid allocation and other operations that will be reverted and may go wrong due to the invalid condition. That should be the reason why other checks for the address are performed here.
>>
>> However, in this particular case, we cannot confidently perform the check here because it is unknown if the ARI capability will be advertised until the device realization code runs. This can justify delaying the check after the device realization, unlike the other checks.
> 
> Ok so are you proposing that the check we have right before (the check for unoccupied function 0) be also moved? It also uses the same vf approximation for seemingly to support ARI.

No, I don't think the check for function 0 is required to be disabled 
because of the change of addressing caused by ARI, but it is required 
because SR-IOV VF can be added and removed while the PF (function 0) 
remains. I think this check should be performed also when SR-IOV is 
disabled and ARI is enabled.

Thus the check for unoccupied function 0 needs to use pci_is_vf() 
instead of checking ARI capability, and that can happen in 
do_pci_register_device().

> Also where do you propose we move the check?

In pci_qdev_realize(), somewhere after pc->realize() and before option 
ROM loading. See the check for failover pair as an example. I guess it's 
also placed in this region because it needs capability information.

> 
>>
>>> Show quoted text
>>>     Regards,
>>>     Akihiko Odaki
>>>      > +    else if (!pci_is_vf(pci_dev) &&
>>>      > +             pcie_has_upstream_port(pci_dev) &&
>>>      > +             PCI_SLOT(devfn)) {
>>>      > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>      > +                   " parent device only allows plugging into
>>>     slot 0.",
>>>      > +                   PCI_SLOT(devfn), name);
>>>      > +        return NULL;
>>>      >       }
>>>      >
>>>      >       pci_dev->devfn = devfn;
> 

