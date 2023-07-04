Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881774707B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeqi-0005O2-45; Tue, 04 Jul 2023 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGeqf-0005No-Ai
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:09:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGeqd-0004AY-23
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:09:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-668704a5b5bso4230271b3a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688472573; x=1691064573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lo0BxkIUWZ66LWdZFwTmoz0V8WVCNITxWrkNQMl1yw8=;
 b=PRm93BuddqiZIzmI9Ua8uFHSr5pikjAz5kvVs1bXu92awSql2BWTy3mqFhfatMtJ7V
 9hLEGDZtF7SFBXHl4zrsowNW2XwnKpD5FvrO8/iGFlKupNNSCZyJ4IWefEfYLsPkOxa7
 yAGp/T0vUAuYM7U4lMjMAeuhqZQp7fwCrvHdklgQI+TMNlt5ok5BQeYxbkU0oNlWqHQy
 JLPfq+8t+yCdh1nzKyFbi/lyjPnlehYVpAlEXQU+1dFyHEDiCCnoC016h8AMuLmeDmZ6
 PdJsksD9l4w1FhDO7dWZyUcRpMjlMp0tap9UHhuVJO6+WRTBvJGjV+qzPizT8l+Ij4M7
 PCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472573; x=1691064573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo0BxkIUWZ66LWdZFwTmoz0V8WVCNITxWrkNQMl1yw8=;
 b=gjvk3IJ8S7SsaXE+WNPNudt2D4h4NWefc1WY77mbzXGRpFJh1IwsrNb9Vpsc7Ug6+N
 bG3jD6FEhPZT9X394vRHbsbfDru9lUFuEZxj1io2pLeQpB161j0bqFF6xWoerffLoiOF
 dNigBAYpPM/2xurkVK4EQDQVg7zm+8bQxyVQTxV3JWsJJJT3ftBgwrpQt/MSfd8pw96h
 ZkSp2t8yjQh8EAnaT3AjLWzONIuwB71erTF3f9Y0eSaSFrcWp4GH9UTj1jObVbxv1wiq
 dF0PVPBoloZWk+jKIVLH56QVxqudG0wCiSOQXDEhsfqkgiQtB603Eso5NqQdvDfGsU3N
 ZBxQ==
X-Gm-Message-State: ABy/qLaNqI/b3im3sN8UV+pc4xfqAA3SlPAfkWMukF9NWjCgLhu9o9Tw
 dlWZZdFOMUu12CGAIopLwgUXjw==
X-Google-Smtp-Source: APBJJlFHGr5dV7kgB7lW2VFnDxZxnv83EQNyuoYmuf6ZqtBN9hiLOS/0iBUxOgfphLiKqrChWxlZZg==
X-Received: by 2002:a05:6a00:c8f:b0:66c:a45:f00b with SMTP id
 a15-20020a056a000c8f00b0066c0a45f00bmr20379161pfv.23.1688472573223; 
 Tue, 04 Jul 2023 05:09:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a62e211000000b0066ccb8e8024sm15152214pfi.30.2023.07.04.05.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:09:32 -0700 (PDT)
Message-ID: <912dc66d-dad1-53a1-be4e-3ba795ccb947@daynix.com>
Date: Tue, 4 Jul 2023 21:09:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, imammedo@redhat.com
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <6AB4A93A-7543-4991-A934-4C6054F0C2BA@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <6AB4A93A-7543-4991-A934-4C6054F0C2BA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2023/07/04 21:08, Ani Sinha wrote:
> 
> 
>> On 04-Jul-2023, at 5:32 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/07/04 20:59, Ani Sinha wrote:
>>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/07/04 20:25, Ani Sinha wrote:
>>>>> PCI Express ports only have one slot, so PCI Express devices can only be
>>>>> plugged into slot 0 on a PCIE port. Add a warning to let users know when the
>>>>> invalid configuration is used. We may enforce this more strongly later on once
>>>>> we get more clarity on whether we are introducing a bad regression for users
>>>>> currenly using the wrong configuration.
>>>>> The change has been tested to not break or alter behaviors of ARI capable
>>>>> devices by instantiating seven vfs on an emulated igb device (the maximum
>>>>> number of vfs the linux igb driver supports). The vfs instantiated correctly
>>>>> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
>>>>> representation.
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> CC: mst@redhat.com
>>>>> CC: akihiko.odaki@daynix.com
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>> ---
>>>>>   hw/pci/pci.c | 15 +++++++++++++++
>>>>>   1 file changed, 15 insertions(+)
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index e2eb4c3b4a..47517ba3db 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -65,6 +65,7 @@ bool pci_available = true;
>>>>>   static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>   static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>     static Property pci_props[] = {
>>>>>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>>>           }
>>>>>       }
>>>>>   +    /*
>>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
>>>>> +     * PCI interpretation as all five bits reserved for slot addresses are
>>>>> +     * also used for function bits for the various vfs. Ignore that case.
>>>>
>>>> You don't have to mention SR/IOV; it affects all ARI-capable devices. A PF can also have non-zero slot number in the conventional interpretation so you shouldn't call it vf either.
>>> Can you please help write a comment that explains this properly for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear and correct, I will re-spin.
>>
>> Simply, you can say:
>> With ARI, the slot number field in the conventional PCI interpretation can have a non-zero value as the field bits are reused to extend the function number bits. Ignore that case.
> 
> but we are not checking for ARI capability here in the code. So the comment is confusing.

Don't we? We check for:
!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI)

> 
>>
>>>>
>>>>> +     */
>>>>> +    if (pci_is_express(pci_dev) &&
>>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>>> +                    " parent device only allows plugging into slot 0.",
>>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>>> +    }
>>>>> +
>>>>>       if (pci_dev->failover_pair_id) {
>>>>>           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>>               error_setg(errp, "failover primary device must be on "
> 

