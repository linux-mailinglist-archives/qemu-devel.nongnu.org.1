Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145DF7472CC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgAU-0002Bl-7H; Tue, 04 Jul 2023 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGgAO-0002Ab-Oh
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:34:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGgAM-0002iN-ME
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:34:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso5456335f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688477639; x=1691069639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fV0JVHcVY8V2ijMeAjn+xiL18Yl03KZvKUcURiK1JjA=;
 b=mYct5BXgSj16GfNtiDe+FHMabYWA3LtYJ0WmnPsQYaV2nwEMZX3Bo16tCOKUtUpHPm
 gMckB5dqMICP8G1UsPWITbRvuCmvfKRW1ij2mdIG9EtDVxCII1BVLY+XRE4NwcVFh/jP
 C8XHhgnEIcTylzXqH6+IvnL3j7Om8VpwUjUOpsQsjyc4SpBUvU+kIKEgkux0wfaImWIq
 /ywksLctAB+npuWrFTaSvIIV6Ft+d9NhHfHQyUoba1dxsKmbeounpfUSccBYNgrm6Sqk
 6tNp9JnlCYUfL+wJ5gaOZKcrzc7dc88X/eBCQNbe3sMBAPyczhajFGeFKKE+UBJFRdY2
 sQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477639; x=1691069639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fV0JVHcVY8V2ijMeAjn+xiL18Yl03KZvKUcURiK1JjA=;
 b=Nf2eVu5Jos8Xiq18rhHDGcaGImOLXJTXPPnHtiC/VZr8Szmpc0xJEj1RKEqbQ419Pi
 IWSu8IlfkQU+wQFAlaMc9DBdlLwcgD56svkRbvTHSYmoM7sDuu6Qbd+XdX7izTa3Oees
 cp284wyWtLYRlrkMYUTKUwxS+JxsJI32P1p9I8oYi+9HSFZXNYVFrOBxviALHrRHdaB6
 /9olL8YvqwSiSPfB1z3R1oeZ7FsRCDx2OGvz14jzbhpe7Pg9ah6vm9CMSiLXV+k3VZYL
 nM2+ClLQ+ZZPXZdZzMcCoUi3+tLVD69j+5qjkGzC3rpSFP9BDeZs7MMd92TgfVpeOcG6
 N1tA==
X-Gm-Message-State: ABy/qLZ0KY4KVUNnuuI3+udHJmwlpyip9fkKOksjtp3xYLUX4bsVy5GU
 mf0QP7Hro63H1h/awPR17pLPLoNqKH8LfhaC+RY=
X-Google-Smtp-Source: APBJJlEi+M5bYipObcRDIKBksLDZnXe/jvxCqRYzILWv9vQVyhdVI/LAGiKm3+lppi0++aJq7cTvzw==
X-Received: by 2002:a5d:56d2:0:b0:313:fdbb:422 with SMTP id
 m18-20020a5d56d2000000b00313fdbb0422mr13124145wrw.43.1688477639147; 
 Tue, 04 Jul 2023 06:33:59 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 c15-20020adffb4f000000b00313e4d02be8sm27419853wrs.55.2023.07.04.06.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:33:58 -0700 (PDT)
Message-ID: <bf100be6-2b22-f45d-3479-f8ce50cfdf76@linaro.org>
Date: Tue, 4 Jul 2023 15:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230704120137.2604646-1-clg@redhat.com>
 <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
 <149fdc25-f88d-67f5-f409-8ea2299e41ef@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <149fdc25-f88d-67f5-f409-8ea2299e41ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/7/23 14:32, Cédric Le Goater wrote:
> On 7/4/23 14:09, Philippe Mathieu-Daudé wrote:
>> On 4/7/23 14:01, Cédric Le Goater wrote:
>>> It is useful to extend the number of available PCI devices to KVM guests
>>> for passthrough scenarios and also to expose these models to a different
>>> (big endian) architecture. Include models for Intel Ethernet adapters
>>> and one USB controller, which all support MSI-X. Devices only supporting
>>> INTx won't work on s390x.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>
>>>   Tested under KVM as a machine device, under KVM nested as a 
>>> passthrough
>>>   device
>>>
>>>   hw/s390x/Kconfig | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>>> index 5e7d8a2bae8b..7a82c58cdf6e 100644
>>> --- a/hw/s390x/Kconfig
>>> +++ b/hw/s390x/Kconfig
>>> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>>>       select SCLPCONSOLE
>>>       select VIRTIO_CCW
>>>       select MSI_NONBROKEN
>>> +    imply PCI_EXPRESS
>>
>> No, PCIe is a bus, which is implemented in s390-pci-bus.c;
>> S390_CCW_VIRTIO exposes this bus, so we Kconfig SELECT it.
>>
>>> +    imply E1000E_PCI_EXPRESS
>>> +    imply IGB_PCI_EXPRESS
>>> +    imply USB_XHCI_PCI
>>
>> These are devices you can plug on a PCIe bus, so Kconfig
>> IMPLY is correct.
> 
> If I understand correctly, this should be ?
> 
> @@ -5,8 +5,11 @@ config S390_CCW_VIRTIO
>       imply VFIO_AP
>       imply VFIO_CCW
>       imply WDT_DIAG288
> -    select PCI
> +    select PCI_EXPRESS
>       select S390_FLIC
>       select SCLPCONSOLE
>       select VIRTIO_CCW
>       select MSI_NONBROKEN
> +    imply E1000E_PCI_EXPRESS
> +    imply IGB_PCI_EXPRESS
> +    imply USB_XHCI_PCI

This is how I'd write this patch. Note I have zero knowledge of zPCI.


