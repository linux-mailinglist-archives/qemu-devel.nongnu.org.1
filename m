Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00D75137F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 00:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJiFV-0007Id-93; Wed, 12 Jul 2023 18:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJiFT-0007IH-9h
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 18:23:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJiFQ-0001DB-2B
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 18:23:51 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-55bc29a909dso111079a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689200626; x=1691792626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5APNkr9aYCkDU5qu+uY//+tTXkYing4dXHvv4pFgmFk=;
 b=UWY0ftI0jbaxp1LfSxbGvy/KszmsL5sg62JJcLtAus60v+DVxomAvupJ5zgGJA/192
 WBya8+daKZhHaz2TnrcCFQD1nyC4zBNH0kVg5MVBWUZN/GolrxeS9YW4ydiBOrMWT7fT
 VQTv8y+0tBUdRqKWjQSKvjnfP/3KlHNgcDP7T8V24p4AKo2GQXH2JOfHnJRiGZ6pniAg
 l0PQivQBUwuvHBW6hr1WW3Ht9iO04lXToMxI24dZssilEawrvyK5DWUNt7gkou4Z/eLH
 CopebLAUerMeT089h1kkiEMXlfMGgDxGKns24LL/BV57cduIUPsjoR8qIaht5ArVqU9S
 dr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689200626; x=1691792626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5APNkr9aYCkDU5qu+uY//+tTXkYing4dXHvv4pFgmFk=;
 b=D+cdbTyvnoqA4k/mogbZ3364PcXDb8zMigvXG2Tldo7uGG6UlsgNkdY4pOOTPTmew7
 Aleu3PTzHg5Dx76OBiTXd2G507XDzUloKGGy/9Ftx0urEcZ70BdVAQTHk6nhCjdkgTaO
 ntGsU47YClcMGHnM83x8boSXkg+jP9KdAyn7OSfk356eRBOGGsNqjkDfXPov+WcNbYDR
 vuKIGSHAhpzhwZfTxw87lLtpbsB96plaZkSi8a65UYJZmP0d/KhIx7VDWgzfxYn3qxru
 xTm8ZA8QMTcDrBB30Mi/HN7Ko334+m1X2WlPy6fi9mmieHRpb7e5LjEszbAIm+R4t47i
 d7pg==
X-Gm-Message-State: ABy/qLaTRJgZ/NiNjOt/d2QCKAJTjGJqlMwHpdn06NBiyvIlWzVxMvlb
 r/7kqBiHGytyeLDC03v9rCCLJg==
X-Google-Smtp-Source: APBJJlHXd+MFESHIzdms+t2EDOEwbq7B8WzKXUiq3H/ppnjDdc3Sb2NGBeDe40j7HjhI53lVv8borQ==
X-Received: by 2002:a17:903:24e:b0:1b6:80f0:d969 with SMTP id
 j14-20020a170903024e00b001b680f0d969mr18015222plh.11.1689200626352; 
 Wed, 12 Jul 2023 15:23:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 az2-20020a170902a58200b001b8052d58a0sm4411834plb.305.2023.07.12.15.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 15:23:45 -0700 (PDT)
Message-ID: <d47cca8a-45b6-e3e9-263c-5b6bd24ff8c8@daynix.com>
Date: Thu, 13 Jul 2023 07:23:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Sebastian Mitterle <smitterl@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20230712080146.839113-1-clg@redhat.com>
 <007f4ae2-c39b-70ad-9e23-9edd543e393c@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <007f4ae2-c39b-70ad-9e23-9edd543e393c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2023/07/12 19:48, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 12/7/23 10:01, Cédric Le Goater wrote:
>> It is useful to extend the number of available PCIe devices to KVM guests
>> for passthrough scenarios and also to expose these models to a different
>> (big endian) architecture. Introduce a new config PCIE_DEVICES to select
>> models, Intel Ethernet adapters and one USB controller. These devices all
>> support MSI-X which is a requirement on s390x as legacy INTx are not
>> supported.
>>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   There could be a more general use of PCIE_DEVICES
>>
>>   v4: Introduce PCIE_DEVICES
>>   v3: PCI -> PCI_EXPRESS
>>   v2: select -> imply
>>   configs/devices/s390x-softmmu/default.mak | 1 +
>>   hw/net/Kconfig                            | 4 ++--
>>   hw/pci/Kconfig                            | 3 +++
>>   hw/s390x/Kconfig                          | 3 ++-
>>   hw/usb/Kconfig                            | 2 +-
>>   5 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/configs/devices/s390x-softmmu/default.mak 
>> b/configs/devices/s390x-softmmu/default.mak
>> index f2287a133f36..2d5ff476e32a 100644
>> --- a/configs/devices/s390x-softmmu/default.mak
>> +++ b/configs/devices/s390x-softmmu/default.mak
>> @@ -7,6 +7,7 @@
>>   #CONFIG_VFIO_CCW=n
>>   #CONFIG_VIRTIO_PCI=n
>>   #CONFIG_WDT_DIAG288=n
>> +#CONFIG_PCIE_DEVICE=n
>>   # Boards:
>>   #
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 98e00be4f937..7fcc0d7faa29 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -41,12 +41,12 @@ config E1000_PCI
>>   config E1000E_PCI_EXPRESS
>>       bool
>> -    default y if PCI_DEVICES
>> +    default y if PCI_DEVICES || PCIE_DEVICES
> 
> There seems to be a pre-existing bug, shouldn't this be
> 
>         default y if PCIE_DEVICES
> 
> ?

I think you should leave this as is and instead add a config selected 
only when legacy PCI is available and make all legacy PCI devices depend 
on the config. This will prevent from selecting legacy PCI devices for 
s390x machines no matter if it's selected due to PCI_DEVICES or selected 
manually by the user (by mistake).

> 
> (Cc'ing maintainers)
> 
>>       depends on PCI_EXPRESS && MSI_NONBROKEN
>>   config IGB_PCI_EXPRESS
>>       bool
>> -    default y if PCI_DEVICES
>> +    default y if PCI_DEVICES || PCIE_DEVICES
> 
> Similarly:
> 
>         default y if PCIE_DEVICES
> 
>>       depends on PCI_EXPRESS && MSI_NONBROKEN
>>   config RTL8139_PCI
>> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
>> index 77f8b005ffb1..fe70902cd821 100644
>> --- a/hw/pci/Kconfig
>> +++ b/hw/pci/Kconfig
>> @@ -8,6 +8,9 @@ config PCI_EXPRESS
>>   config PCI_DEVICES
>>       bool
>> +config PCIE_DEVICES
>> +    bool
>> +
>>   config MSI_NONBROKEN
>>       # selected by interrupt controllers that do not support MSI,
>>       # or support it and have a good implementation. See commit
>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>> index 454e0ff4b613..4c068d7960b9 100644
>> --- a/hw/s390x/Kconfig
>> +++ b/hw/s390x/Kconfig
>> @@ -5,7 +5,8 @@ config S390_CCW_VIRTIO
>>       imply VFIO_AP
>>       imply VFIO_CCW
>>       imply WDT_DIAG288
>> -    select PCI
>> +    imply PCIE_DEVICES
>> +    select PCI_EXPRESS
> 
> I'm confused, TYPE_S390_PCI_HOST_BRIDGE exposes a PCI bus...
> At a minimum you'd need:
> 
> -- >8 --
>   static const TypeInfo s390_pcihost_info = {
>       .name          = TYPE_S390_PCI_HOST_BRIDGE,
> -    .parent        = TYPE_PCI_HOST_BRIDGE,
> +    .parent        = TYPE_PCIE_HOST_BRIDGE,
>       .instance_size = sizeof(S390pciState),
>       .class_init    = s390_pcihost_class_init,
>       .interfaces = (InterfaceInfo[]) {
> ---
> 
> Actually I can see:
> 
>          if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
>              error_setg(errp, "MSI-X support is mandatory "
>                         "in the S390 architecture");
>              return;
>          }
> 
> So this must be PCIe, not legacy PCI, right?
> 
>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>> index 0ec6def4b8b8..0f486764ed69 100644
>> --- a/hw/usb/Kconfig
>> +++ b/hw/usb/Kconfig
>> @@ -36,7 +36,7 @@ config USB_XHCI
>>   config USB_XHCI_PCI
>>       bool
>> -    default y if PCI_DEVICES
>> +    default y if PCI_DEVICES || PCIE_DEVICES
> 
> TYPE_XHCI_PCI inherits TYPE_PCI_DEVICE and implements
> INTERFACE_PCIE_DEVICE, so this is OK.
> 
>>       depends on PCI
>>       select USB_XHCI
> 

