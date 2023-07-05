Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB3748265
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzyP-0007cW-Gi; Wed, 05 Jul 2023 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGzyN-0007bd-3Q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:42:59 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGzyK-0005CH-Ez
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:42:58 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5634fbf0cf4so4197791eaf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688553775; x=1691145775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1P+VYCKt92x26DUgQfF47azno/yla4Tkyf8Zqp690C0=;
 b=CGAHRROOFBFsZqMu5Uejxwu7FV8aJoC6oRK+7TLNoc7izOC9F6DcbC+Cltc9h44rcn
 J0ZlUiXTTX1fv+g/jnz/SOi0R2yBEYnKluaKL4ULWyp9rcB84vskEf34MHUdxmQHMDpL
 2ZHHVK144Mb41InWldsCJBUxx89ncpqKniJwzj8bDPaKpdwoA99fR/0COB4Z8KtaegTP
 bO5gfTvruCGgTCeI+niWM2AmkeQniG/d7iLTWOgVNaVAYHsYmOEDO/pjuEDnxOrxJRW0
 ZhRXmwhBsVOcjRR+tHLYYYMXSYvjj9oLzHxG7O7Ft1YQbOTqIgpKgnMpht41b6q5JkAj
 zbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688553775; x=1691145775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1P+VYCKt92x26DUgQfF47azno/yla4Tkyf8Zqp690C0=;
 b=CzU25Li16taJDTPGmZFtGOUdqfPP58ErTB8+4+ZonKp2ZREJDX82KMqo/o8T9UNeSE
 gE6PT+TL3JStYtUXLWDOqW04yzk8Nv78gVyq13boBaIYlFhau3FfImV+HJlnEAcHKa+8
 HRzDya4HTwUvmxB6oLJSioV0//T40Y3i7T8uVo+M/s7KItI6IWmZOeCz0ODZBtZ+zzxD
 d9U2CJknJWfy1gwDAz/nITEMCGwGmqV4ahYiRPEqAmwSOGuJKg/jga+VDQ3/b3TJdmhf
 2C744xJhCOem8IS1+Lnl01A9zLnC8IMgGlRPMRpu4uYKM+mxLQ8kAF+cUIJHinUTxig+
 Fg8g==
X-Gm-Message-State: ABy/qLbA2l7V0Bg2duyS+FhLY2ous4p7S0UE36WPyRRNBG0ZjjSdc3IE
 RKPGAn4pS/u6E97ci07+smKG5w==
X-Google-Smtp-Source: APBJJlG8fStZY8BzOsan7FX5v10EtpYYxa9eljkESQNvT7kevLupGOkofr+57jXcpNNfPAzdh6A0kg==
X-Received: by 2002:a05:6808:114b:b0:3a3:96db:8da8 with SMTP id
 u11-20020a056808114b00b003a396db8da8mr10862436oiu.32.1688553774876; 
 Wed, 05 Jul 2023 03:42:54 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p38-20020a634f66000000b005535ddd8dcfsm17673598pgl.89.2023.07.05.03.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:42:54 -0700 (PDT)
Message-ID: <cec1bb4e-813a-fd27-25a2-4d547b91613e@daynix.com>
Date: Wed, 5 Jul 2023 19:42:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
 <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
 <20230704162836.61a08ff9@imammedo.users.ipa.redhat.com>
 <AD213C8D-85EC-43F6-B9C0-3541BFBDCBCF@redhat.com>
 <0815cf6b-9739-8494-89db-3f2cdf032d40@daynix.com>
 <C3053F47-2C39-4CB4-BEBD-9EC95CF1C4BC@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <C3053F47-2C39-4CB4-BEBD-9EC95CF1C4BC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
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

On 2023/07/05 14:43, Ani Sinha wrote:
> 
> 
>> On 05-Jul-2023, at 7:09 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>>
>>
>> On 2023/07/05 0:07, Ani Sinha wrote:
>>>> On 04-Jul-2023, at 7:58 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>>>>
>>>> On Tue, 4 Jul 2023 19:20:00 +0530
>>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>>
>>>>>> On 04-Jul-2023, at 6:18 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>>>>>>
>>>>>> On Tue, 4 Jul 2023 21:02:09 +0900
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>>> On 2023/07/04 20:59, Ani Sinha wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>
>>>>>>>>> On 2023/07/04 20:25, Ani Sinha wrote:
>>>>>>>>>> PCI Express ports only have one slot, so PCI Express devices can only be
>>>>>>>>>> plugged into slot 0 on a PCIE port. Add a warning to let users know when the
>>>>>>>>>> invalid configuration is used. We may enforce this more strongly later on once
>>>>>>>>>> we get more clarity on whether we are introducing a bad regression for users
>>>>>>>>>> currenly using the wrong configuration.
>>>>>>>>>> The change has been tested to not break or alter behaviors of ARI capable
>>>>>>>>>> devices by instantiating seven vfs on an emulated igb device (the maximum
>>>>>>>>>> number of vfs the linux igb driver supports). The vfs instantiated correctly
>>>>>>>>>> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
>>>>>>>>>> representation.
>>>>>>>>>> CC: jusual@redhat.com
>>>>>>>>>> CC: imammedo@redhat.com
>>>>>>>>>> CC: mst@redhat.com
>>>>>>>>>> CC: akihiko.odaki@daynix.com
>>>>>>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
>>>>>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>> hw/pci/pci.c | 15 +++++++++++++++
>>>>>>>>>> 1 file changed, 15 insertions(+)
>>>>>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>>>>>> index e2eb4c3b4a..47517ba3db 100644
>>>>>>>>>> --- a/hw/pci/pci.c
>>>>>>>>>> +++ b/hw/pci/pci.c
>>>>>>>>>> @@ -65,6 +65,7 @@ bool pci_available = true;
>>>>>>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>>>>>> static void pcibus_reset(BusState *qbus);
>>>>>>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>>>>>>    static Property pci_props[] = {
>>>>>>>>>>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>>>>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>>>>>>>>          }
>>>>>>>>>>      }
>>>>>>>>>> +    /*
>>>>>>>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
>>>>>>>>>> +     * PCI interpretation as all five bits reserved for slot addresses are
>>>>>>>>>> +     * also used for function bits for the various vfs. Ignore that case.
>>>>>>>>>
>>>>>>>>> You don't have to mention SR/IOV; it affects all ARI-capable devices. A PF can also have non-zero slot number in the conventional interpretation so you shouldn't call it vf either.
>>>>>>>>
>>>>>>>> Can you please help write a comment that explains this properly for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear and correct, I will re-spin.
>>>>>>>
>>>>>>> Simply, you can say:
>>>>>>> With ARI, the slot number field in the conventional PCI interpretation
>>>>>>> can have a non-zero value as the field bits are reused to extend the
>>>>>>> function number bits. Ignore that case.
>>>>>>
>>>>>> mentioning 'conventional PCI interpretation' in comment and then immediately
>>>>>> checking 'pci_is_express(pci_dev)' is confusing. Since comment belongs
>>>>>> only to PCIE branch it would be better to talk in only about PCIe stuff
>>>>>> and referring to relevant portions of spec.
>>>>>
>>>>> Ok so how about this?
>>>>>
>>>>>    * With ARI, devices can have non-zero slot in the traditional BDF
>>>>>      * representation as all five bits reserved for slot addresses are
>>>>>      * also used for function bits. Ignore that case.
>>>>
>>>> you still refer to traditional (which I misread as 'conventional'),
>>>> steal the linux comment and argument it with ARI if necessary,
>>>> something like this (probably needs some more massaging):
>>> The comment messaging in these patches seems to exceed the value of the patch itself :-)
>>> How about this?
>>>      /*
>>>       * A PCIe Downstream Port normally leads to a Link with only Device
>>>       * 0 on it (PCIe spec r3.1, sec 7.3.1).
>>>       * With ARI, PCI_SLOT() can return non-zero value as all five bits
>>>       * reserved for slot addresses are also used for function bits.
>>>       * Hence, ignore ARI capable devices.
>>>       */
>>
>> Perhaps: s/normally leads to/must lead to/
>>
>>  From the kernel perspective, they may need to deal with a quirky hardware that does not conform with the specification, but from QEMU perspective, it is what we *must* conform with.
> 
> PCI base spec 4.0, rev 3, section 7.3.1 says:
> 
> "
> Downstream Ports that do not have ARI Forwarding enabled must associate only Device 0 with the device attached to the Logical Bus representing the Link from the Port. Configuration Requests 15 targeting the Bus Number associated with a Link specifying Device Number 0 are delivered to the device attached to the Link; Configuration Requests specifying all other Device Numbers (1-31) must be terminated by the Switch Downstream Port or the Root Port with an Unsupported Request Completion Status (equivalent to Master Abort in PCI). Non-ARI Devices must not assume that Device Number 0 is associated with their Upstream Port, but must capture their assigned Device Number as discussed in Section 2.2.6.2. Non-ARI Devices must respond to all Type 0 Configuration Read Requests, regardless of the Device Number specified in the Request.
> 
> …
> 
> With an ARI Device, its Device Number is implied to be 0 rather than specified by a field within an ID. The traditional 5-bit Device Number and 3-bit Function Number fields in its associated Routing IDs, Requester IDs, and Completer IDs are interpreted as a single 8-bit Function Number. See Section 6.13. Any Type 0 Configuration Request targeting an unimplemented Function in an ARI Device must be handled as an Unsupported Request.
> 
> “
> 
> So it seems they do indeed use the “must” clause. I prefer to use the line from the spec verbatim as possible. Hence, this is what I am going with and be done with this patchset:
> 
>      /*
>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>       * associate only Device 0 with the device attached to the bus
>       * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
>       * sec 7.3.1).
>       * With ARI, PCI_SLOT() can return non-zero value as the traditional
>       * 5-bit Device Number and 3-bit Function Number fields in its associated
>       * Routing IDs, Requester IDs and Completer IDs are interpreted as a
>       * single 8-bit Function Number. Hence, ignore ARI capable devices.
>       */

Looks perfect.

> 
> 
>>
>> Otherwise looks good to me.
>>
>>>>
>>>>
>>>>          /*
>>>>          * A PCIe Downstream Port normally leads to a Link with only Device
>>>>          * 0 on it (PCIe spec r3.1, sec 7.3.1).
>>>>           However PCI_SLOT() is broken if ARI is enabled, hence work around it
>>>>           by skipping check if the later cap is present.
>>>>          */
>>>>
>>>>>
>>>>>
>>>>>> (for example see how it's done in kernel code: only_one_child(...)
>>>>>>
>>>>>> PS:
>>>>>> kernel can be forced  to scan for !0 device numbers, but that's rather
>>>>>> a hack, so we shouldn't really care about that.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +     */
>>>>>>>>>> +    if (pci_is_express(pci_dev) &&
>>>>>>>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>>>>>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>>>>>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>>>>>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>>>>>>>> +                    " parent device only allows plugging into slot 0.",
>>>>>>>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>>      if (pci_dev->failover_pair_id) {
>>>>>>>>>>          if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>>>>>>>              error_setg(errp, "failover primary device must be on "
>>>>>
>>>>
>>
> 

