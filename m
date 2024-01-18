Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E88312EE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:03:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMPu-0001no-1H; Thu, 18 Jan 2024 02:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQMPm-0001nQ-Mx
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQMPk-0003ql-VX
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705561331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Wb5Sq5jf9m6NlV54D8BmTxluDPtuCfJgZG7E597LyI=;
 b=hxZTk9vlZJs1Yl7+TzgfzC7D3VlEKUjiz5OQNwVl2DNwoQFlM84moFzsEg/G2sl/WVxHs8
 PG4sLwUSZpDiAY+IYgGPmO2yBMkbbTrcdUbeAebsKsG6IZpfXpU57CLoM2zrQhvqrdXCLq
 0KyV799pz7zTCtc0jg9jwXcYeZx2nsc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-BnsT41CSP9yZ2StywFgNWQ-1; Thu, 18 Jan 2024 02:02:10 -0500
X-MC-Unique: BnsT41CSP9yZ2StywFgNWQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-427b56e96a6so179536211cf.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705561330; x=1706166130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Wb5Sq5jf9m6NlV54D8BmTxluDPtuCfJgZG7E597LyI=;
 b=GYVt2fmxt+qzpXJFDWra9N41SOucR3G0gtIUT9KdtR5v8KomzsHabtARJV7M1M/IJF
 9fBGauUCdCopLDgBhJyAG+2o8g4Ya9Xb04veJi22h+s0AwUdWLs/24uURbDROxiFqZKC
 dkXUuHsR13sjhhLA+cQ3z2TTGop6eryofOoUXIPFWb0MJ+uCEPHu/PBP3MObyGgWCEpg
 R4Q8s+G2w7Gm3xmVXwpuVkvQ8+MqtMLcbT50y54yA30+DRQlhmGX7LJYcltTUHX1DQQv
 bxj/QX6jITzq0lmhsYlGkL5TKiA1Igp97Ghq4HtyAhYxL/lH+bQzs6fYvSF+Gc9hc7mh
 0mhA==
X-Gm-Message-State: AOJu0Yz/uDANtwb9Z5KvSU7+09rlL80S4yzM4B2jeCDzu0Fm1GxTp4NN
 bhpMns684sm5YgwCwBAmGDn+xco+fr2O07BFGqDLHldJmzMehtu1g5Zf2djbbrsIe2Oz8mbtvb8
 Npl5hTvWzk3vmDr0Yd8Y0gLK3K9h9wj+DZyIyqKz8dQbg/ILJuMdK
X-Received: by 2002:a05:622a:1481:b0:429:f8c3:d84 with SMTP id
 t1-20020a05622a148100b00429f8c30d84mr474593qtx.48.1705561329952; 
 Wed, 17 Jan 2024 23:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIO95srFX4FsIMvqvOWwf+9UE9CaR52jS0WSyoMxtTVDODPnWx1QZHdV0r5GVroZxATqwyqA==
X-Received: by 2002:a05:622a:1481:b0:429:f8c3:d84 with SMTP id
 t1-20020a05622a148100b00429f8c30d84mr474579qtx.48.1705561329711; 
 Wed, 17 Jan 2024 23:02:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 po27-20020a05620a385b00b007836720b96asm2136225qkn.24.2024.01.17.23.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 23:02:09 -0800 (PST)
Message-ID: <9a5eb63a-a4f0-4238-a889-ab111d981313@redhat.com>
Date: Thu, 18 Jan 2024 08:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
 <66735e9f-a4fb-474f-abec-6c83d36f921e@redhat.com>
 <0131acaf-6daf-46b3-9368-e491766e2825@linux.ibm.com>
 <04379048-1ff0-482b-8fc7-74cc13bb5a21@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <04379048-1ff0-482b-8fc7-74cc13bb5a21@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/17/24 22:11, Matthew Rosato wrote:
> On 1/17/24 10:19 AM, Matthew Rosato wrote:
>> On 1/17/24 6:01 AM, Cédric Le Goater wrote:
>>> Adding Alex,
>>>
>>> On 1/16/24 23:31, Matthew Rosato wrote:
>>>> ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
>>>> needs to be reset before the vfio-pci device is reset (triggering a full
>>>> UNMAP).  In order to ensure this occurs, trigger ISM device resets from
>>>> subsystem_reset before triggering the PCI bus reset (which will also
>>>> trigger vfio-pci reset).  This only needs to be done for ISM devices
>>>> which were enabled for use by the guest.
>>>> Further, ensure that AIF is disabled as part of the reset event.
>>>>
>>>> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
>>>> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
>>>> Reported-by: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
>>>>    hw/s390x/s390-virtio-ccw.c      |  2 ++
>>>>    include/hw/s390x/s390-pci-bus.h |  1 +
>>>>    3 files changed, 20 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index 347580ebac..3e57d5faca 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
>>>>        pci_device_reset(pbdev->pdev);
>>>>    }
>>>>    -static void s390_pci_reset_cb(void *opaque)
>>>> -{
>>>> -    S390PCIBusDevice *pbdev = opaque;
>>>> -
>>>> -    pci_device_reset(pbdev->pdev);
>>>> -}
>>>> -
>>>>    static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>>>    {
>>>>        HotplugHandler *hotplug_ctrl;
>>>>          if (pbdev->pft == ZPCI_PFT_ISM) {
>>>>            notifier_remove(&pbdev->shutdown_notifier);
>>>> -        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
>>>>        }
>>>>          /* Unplug the PCI device */
>>>> @@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>                if (pbdev->pft == ZPCI_PFT_ISM) {
>>>>                    pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
>>>>                    qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
>>>> -                qemu_register_reset(s390_pci_reset_cb, pbdev);
>>>>                }
>>>>            } else {
>>>>                pbdev->fh |= FH_SHM_EMUL;
>>>> @@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>>>>        pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
>>>>    }
>>>>    +void s390_pci_ism_reset(void)
>>>> +{
>>>> +    S390pciState *s = s390_get_phb();
>>>> +
>>>> +    S390PCIBusDevice *pbdev, *next;
>>>> +
>>>> +    /* Trigger reset event for each passthrough ISM device currently in-use */
>>>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>>>> +        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
>>>> +            pbdev->fh & FH_MASK_ENABLE) {
>>>> +            s390_pci_kvm_aif_disable(pbdev);
>>>> +
>>>> +            pci_device_reset(pbdev->pdev);
>>>> +        }
>>>> +    }
>>>> +}
>>>
>>>
>>> Could we instead define a VFIOPCIDevice::resetfn handler for these
>>> ISM devices (1014:04ed) ? This would be cleaner if possible.
>>>
>>> If so, as a prerequisite, we would need to introduce in a little VFIO
>>> helper to define custom reset handlers.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>
>> Oh interesting, I had not noticed that.  This may well work -- resetfn is currently setup via vfio_setup_resetfn_quirk but it would probably be easier to have a helper that takes the vdev and a function pointer so that we can provide a platform-specific reset handler (rather than having hw/vfio/pci-quirks.c worry about CONFIG_S390 etc).  I'll have to play around with this.
>>   
>>
> 
> Hmm, it was a good idea but I don't think this will work.  I tried to hack something together today but I'm definitely seeing paths where the vfio_listener_region_del happens before the call to vfio_pci_reset (which would ultimately trigger the new custom resetfn).

OK.
  
> Perhaps we should stick with the call from subsystem_reset -- it will ensure that the ISM cleanup happens after guest CPUs are stopped but before vfio does its cleanup.

Let's keep the subsystem_reset() method then. Please add a comment on the reset ordering.

Thanks,

C.



> 


