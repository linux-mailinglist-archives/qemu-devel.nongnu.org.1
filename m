Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A90750F37
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 19:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJdFY-0000nY-6H; Wed, 12 Jul 2023 13:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qJdFU-0000lc-HQ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 13:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qJdFT-0006kJ-1J
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 13:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689181409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72qQOWc8/l/dIAIBr8usAwAdM/8j6mt7J78jhn86/PA=;
 b=ddBtRbGpuIkwz3YxANuTiLvR2uieEQAYXXCYRHQvwSLU+4PYg5jvmN0PkdUBJJd1BWdGB8
 1yZqDZ1uO6oEQ09bE9/A6/qUxG3ZVRtNGvlEas69sb3JiguP7NeMYgUAKN87tI0Wyp0mJp
 N/TqxCjBHg6aV3hQ3/L74zu6IP1HPhY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-GVPSnX_SPa-bH9oD9-Y1rQ-1; Wed, 12 Jul 2023 13:03:27 -0400
X-MC-Unique: GVPSnX_SPa-bH9oD9-Y1rQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403b30c3cb6so35074081cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 10:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689181407; x=1691773407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=72qQOWc8/l/dIAIBr8usAwAdM/8j6mt7J78jhn86/PA=;
 b=UB5f4k0zgL19EL5HTnK6lDl7DXVt8nCES8QTyiEcGVHZyCmmnBZsLZjAKqsjrR/HXb
 delFJbHOKgKZ9UisRHMOP72rYJ43INjXoSOSz43GNlge71X2YrsVwi6osdto1n9NkT1h
 3TKZ9d8+ntYOiAUQ/S0KX5HAirAcSjlq8Bx5Cmq/ThG0RVC3pjIhNsYdXZOz1/Kd8Wa7
 rEjxHKXyUXAwT5JSo+nAaL9DX1qXmoleAyt892cYkEV5y070pAU0GqYbsJXl5X7ZATXE
 Y7fukkSanIhXhOKOQX4PDFttAewl5tc5eqX81TmiGDpK2nPKahWW7Jd3qQRLS2QGL7mz
 KQ+w==
X-Gm-Message-State: ABy/qLb2Ilia37pA06R/mMCcbMiWyfP6rstXvEeZbXBDlvAG+yVgKkn0
 hJWxm0Tv4aoXMAvzRVxg8ARb8Pr7X8ZAWgMf5rKJE+gph/IO/VHcB6w9hbosyIyGdTjX2leLkq4
 F/0qcRK1WXsGqjgM=
X-Received: by 2002:a05:622a:1d1:b0:3f4:ee64:e30c with SMTP id
 t17-20020a05622a01d100b003f4ee64e30cmr27395097qtw.52.1689181406868; 
 Wed, 12 Jul 2023 10:03:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPI77iJw5iVGeV+yNOmHR7GqY6090EodejlW26qio/MX0F6sKWfX6vUv5MtkQGIDmSSuloFw==
X-Received: by 2002:a05:622a:1d1:b0:3f4:ee64:e30c with SMTP id
 t17-20020a05622a01d100b003f4ee64e30cmr27395072qtw.52.1689181406636; 
 Wed, 12 Jul 2023 10:03:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 8-20020ac856e8000000b0040338d69f51sm2395773qtu.80.2023.07.12.10.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 10:03:26 -0700 (PDT)
Message-ID: <c8c7bf93-17fa-e172-cbf4-06c985fbbe02@redhat.com>
Date: Wed, 12 Jul 2023 19:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Sebastian Mitterle <smitterl@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20230712080146.839113-1-clg@redhat.com>
 <007f4ae2-c39b-70ad-9e23-9edd543e393c@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <007f4ae2-c39b-70ad-9e23-9edd543e393c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It seems difficult to change now without breaking migration compatibility.

C.


