Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE27F594B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 08:34:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r64DM-00089B-Vn; Thu, 23 Nov 2023 02:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r64DJ-00087U-Q6
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r64DI-0005bz-02
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 02:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700724806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEBNw6xXYpgo9Y15s8btU0DHOGdaUloivo/TJikToic=;
 b=TCU5+RukVD07xJGhounDC12EKV/88fN6j8x3FmB8iZLblQiHB19kvVkAJiFjr4c51+eopc
 fu8kbeDCLlvBnEUTD/2a2N/rm5bJvyEPEo1zvqrb/KU1zUxksyfV1/lCeKHuJlns71qHwp
 s8pkalDw0rV0ukl4fQ8RI3PYLtmhaaA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-0T_OMuCwPRO34XigR2ckQg-1; Thu, 23 Nov 2023 02:33:24 -0500
X-MC-Unique: 0T_OMuCwPRO34XigR2ckQg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67804869762so7502476d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 23:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700724804; x=1701329604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEBNw6xXYpgo9Y15s8btU0DHOGdaUloivo/TJikToic=;
 b=OvnqQWCdFcVk04IlMvh0t8+4hEW8baP8Zftn3DRD2MW0XV2uPiOu6ueLTLnsbfpvlQ
 XAoIkDvSGhHOS5S0MnCgVBG4lOppBd7Rw7RIx1Qw3C5mKgcs8H8OzTiqVOp7pY3ZOF9m
 BRAaxIq8lsAEaMYusl8pqBenKqTjx1oWnpY63hO/YwyJbW8Ltdqbz61le6scKujJ2Kgy
 RU4P8CBpTttY/PH7i25WBn9ywtRQFBMzxbC1xWeSsU38QC6vpKFLA0uhb4XTpYmRtIxB
 Ww4ireK76tGBKK6A3fmA0xr/SMHy96nctQ9aJsgqC/eJwlUy90wwUGL+WJOpllign0bz
 s82A==
X-Gm-Message-State: AOJu0YxXOZRRSxjjCrz5agFbsw8gHUdwvNcPigeN8AGDdlHjqfXgHWVD
 F9HNh2JlY2oKjSz7PeZmnIThU45LWWYjmIwnrAqSM0hfnKE/SyfjxdiF7G9tw3ASdI2P7Hx8oMp
 o3Jg2XW5ylFjmEro=
X-Received: by 2002:a05:6214:2121:b0:679:dc0c:b17b with SMTP id
 r1-20020a056214212100b00679dc0cb17bmr5790387qvc.11.1700724803866; 
 Wed, 22 Nov 2023 23:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwdgbFqCOxYaiR+8UYefYoG/Q/Muxfu6j4VBXXcYkuUldb7yPBeSsXePLxgLyrJiO5R3kQ0Q==
X-Received: by 2002:a05:6214:2121:b0:679:dc0c:b17b with SMTP id
 r1-20020a056214212100b00679dc0cb17bmr5790374qvc.11.1700724803637; 
 Wed, 22 Nov 2023 23:33:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a0cf04e000000b00677f34c4b4fsm294335qvl.6.2023.11.22.23.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 23:33:23 -0800 (PST)
Message-ID: <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
Date: Thu, 23 Nov 2023 08:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: Improve build for PPC VFIO
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231123060109.131904-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/23/23 07:01, Zhenzhong Duan wrote:
> VFIO is not a required subsystem for the pseries machine but it's
> force enabled currently. When --without-default-devices is used
> to drop some default devices including vfio-pci, vfio core code
> is still kept which is unnecessary.
> 
> Introduce a stub file to hold stub functions of VFIO EEH hooks,
> then vfio core could be compiled out.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Nick,

I will take this patch through the vfio tree if that's OK for you.

> ---
> Based on vfio-next/vfio-8.2
> 
>   hw/ppc/spapr_pci_vfio_stub.c | 33 +++++++++++++++++++++++++++++++++
>   hw/ppc/Kconfig               |  2 +-
>   hw/ppc/meson.build           |  6 +++---
>   3 files changed, 37 insertions(+), 4 deletions(-)
>   create mode 100644 hw/ppc/spapr_pci_vfio_stub.c
> 
> diff --git a/hw/ppc/spapr_pci_vfio_stub.c b/hw/ppc/spapr_pci_vfio_stub.c
> new file mode 100644
> index 0000000000..adb3fb5e35
> --- /dev/null
> +++ b/hw/ppc/spapr_pci_vfio_stub.c
> @@ -0,0 +1,33 @@
> +#include "qemu/osdep.h"
> +#include "hw/pci-host/spapr.h"
> +
> +bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> +{
> +    return false;
> +}
> +
> +void spapr_phb_vfio_reset(DeviceState *qdev)
> +{
> +}
> +
> +int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
> +                                  unsigned int addr, int option)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> +int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> +{
> +    return RTAS_OUT_NOT_SUPPORTED;
> +}
> +
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index edc6d2d139..b8dabdbfbe 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -3,11 +3,11 @@ config PSERIES
>       imply PCI_DEVICES
>       imply TEST_DEVICES
>       imply VIRTIO_VGA
> +    imply VFIO if LINUX   # needed by spapr_pci_vfio.c

Zhenzhong,

I changed VFIO to VFIO_PCI because PPC only supports this type
of passthrough devices.

With that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>       select NVDIMM
>       select DIMM
>       select PCI
>       select SPAPR_VSCSI
> -    select VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
>       select XICS
>       select XIVE
>       select MSI_NONBROKEN
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index ea44856d43..2df5db2eef 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -34,9 +34,9 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
>     'spapr_softmmu.c',
>   ))
>   ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
> -ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
> -  'spapr_pci_vfio.c',
> -))
> +ppc_ss.add(when: [ 'CONFIG_VFIO_PCI', 'CONFIG_PSERIES', 'CONFIG_LINUX'],
> +           if_true: files('spapr_pci_vfio.c'),
> +           if_false: files('spapr_pci_vfio_stub.c'))
>   
>   # IBM PowerNV
>   ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(


