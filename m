Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C7B13B87
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 15:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNvD-0002bh-Uj; Mon, 28 Jul 2025 09:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugN2A-0000Tw-5k
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugN20-0002ya-Gm
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753705957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zVCA/TK8BEsrl3jW99ININABFrAB//qoABK6ra3skjc=;
 b=MUre+aX3VKU+TCtC/OGxWZ18ItDLM9wNazqgQ6IJe+EQ+NTbIoh5843vC8W78/ZHco2Glo
 NvPJolUKeOHu3JOAkGwR5EwPbqPoE649XFzO+w/DupDwwquJn+rurdQBqSdFSdtmKGUSR9
 7QstE4n1TRvVyDT7ccF2ybsU4bY0ScE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Dsxn9qEnOEuXGAIVflGtaA-1; Mon, 28 Jul 2025 08:32:34 -0400
X-MC-Unique: Dsxn9qEnOEuXGAIVflGtaA-1
X-Mimecast-MFC-AGG-ID: Dsxn9qEnOEuXGAIVflGtaA_1753705953
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso26677575e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753705953; x=1754310753;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVCA/TK8BEsrl3jW99ININABFrAB//qoABK6ra3skjc=;
 b=ojxQgltvdRUeqVRWkHG7HLv0J3iS7l0P9AWp7tfdY8a9N0ZC/Wljg1y7vbkEgl3AY5
 h++Du8/nzHKPBZvMi64dRAtLcKrpwVQdfreLOFDQY1BIyf/cLanjRv5zPVCAuqD/u2fv
 wPTE6ZKdFsOeoAyB4RVufGHmOjTxEkPtdPNDjmMhfHnxzBGxN/3LITuPJHz4TIL51ZAk
 E58rrJowSLpFyBdmaw3XDHJdGiumkT50DpwkWZZipHfOb+/cE4sD8zfCqhIQ1ElyWIl0
 txSf+IZI56OHQXWTWAHWOL0VATkqszUxq2rC7/4PSG1w3koLobADbR7V+MApl7qOBFYv
 PmvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcuyDOiEXKf4QC5TwU/+kKnAHcMdC+KB+5XbGnbV94tjF4byMfy5xJ4DAYdxbvqqWFjssZ0KIM+g3S@nongnu.org
X-Gm-Message-State: AOJu0YyQUXgNQofr1wxM62lONs+b1NmMsUWPNTyO1IyqRPfuw9Q8/6rp
 WyupXhsvZc87XBuSVfUVGBP9ib9dxN74DD8eH090o1IOJdpU17IVyVer4vp9qxcDtbNZffIs5Ts
 aFrUWSHBbbh0MSeng9+qeLQ9ko910PSpqDlYTDjpfrunyaahcookfG+Lj
X-Gm-Gg: ASbGncs8Jho/k/mLp339HxZPAcjUOXtdLXrxFvRGq368ognMRyD1Abm60NgYTKfuH5h
 tvoHQZDaCe1SJukPDaj/6owg2yTmJQcCBG/EiOE7zgEntmVKlhCS6YDSlWDeiKJsQczADQxQUAi
 WCeMObi2rXrJy60ySUD5TEFlBIJpA9rYubCOvucIsKJ0nebwol8GJW190JJn/4q40kzmwPFkK/o
 uNDeWS5KpBFuTxA11K1AmV7LdewjYqyqWbqg6ZHV5AnuIIlmQWddZSkxgVrM+YSWMDBF4blqEj6
 Vb2HFQQrnOhOEz+VuBZqkntv7jHmPWN9DH0m1+MOtZSgxDBtXcJvyfGVHwagnATEUuRWzvgzyUx
 snQ==
X-Received: by 2002:a05:600c:8b66:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-45876652621mr86742485e9.25.1753705952710; 
 Mon, 28 Jul 2025 05:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHqE/NgkZci3LTyjZcey0XLhbpD6mIYHWBT45ztsGHdY3BwNkyyP9+6ovtUJaZ9UQhPuvnxA==
X-Received: by 2002:a05:600c:8b66:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-45876652621mr86742165e9.25.1753705952160; 
 Mon, 28 Jul 2025 05:32:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac5816dsm97239825e9.17.2025.07.28.05.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 05:32:31 -0700 (PDT)
Message-ID: <424a42b6-5013-4b95-9d85-37d99ebdfe93@redhat.com>
Date: Mon, 28 Jul 2025 14:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix regression due to unexisting property
 use-legacy-x86-rom
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, slp@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, shahuang@redhat.com, chao.p.peng@intel.com
References: <20250728122906.39703-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250728122906.39703-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Zhenzhong,

On 7/28/25 14:29, Zhenzhong Duan wrote:
> TYPE_VFIO_PCI doesn't have property use-legacy-x86-rom, but
> TYPE_VFIO_PCI_NOHOTPLUG has. The compatibility config leads to
> SIGABRT on new QEMU.
> 
> The default value of element use_legacy_x86_rom for TYPE_VFIO_PCI is
> already false, so no need extra processing.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Fix is here :

  https://lore.kernel.org/qemu-devel/20250723062714.1245826-1-clg@redhat.com/


Thanks,

C.

> ---
>   hw/vfio/types.h   | 2 ++
>   hw/core/machine.c | 2 +-
>   hw/i386/microvm.c | 2 +-
>   hw/i386/pc_piix.c | 2 +-
>   hw/i386/pc_q35.c  | 2 +-
>   hw/vfio/pci.c     | 2 --
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/types.h b/hw/vfio/types.h
> index fa20c29b9f..c19334ff25 100644
> --- a/hw/vfio/types.h
> +++ b/hw/vfio/types.h
> @@ -18,4 +18,6 @@
>   #define TYPE_VFIO_PCI "vfio-pci"
>   /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
>   
> +#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +
>   #endif /* HW_VFIO_VFIO_TYPES_H */
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d6b2240fc2..bd47527479 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {
>       { "scsi-hd", "dpofua", "off" },
>       { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>       { "ramfb", "use-legacy-x86-rom", "true"},
> -    { "vfio-pci", "use-legacy-x86-rom", "true" },
> +    { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
>   };
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>   
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index d90b69a162..94d22a232a 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -635,7 +635,7 @@ GlobalProperty microvm_properties[] = {
>        */
>       { "pcie-root-port", "io-reserve", "0" },
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   
>   static void microvm_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ad5caff3a5..c03324281b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -80,7 +80,7 @@ static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>   
>   static GlobalProperty pc_piix_compat_defaults[] = {
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   static const size_t pc_piix_compat_defaults_len =
>       G_N_ELEMENTS(pc_piix_compat_defaults);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 9b9519fa02..b309b2b378 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -69,7 +69,7 @@
>   static GlobalProperty pc_q35_compat_defaults[] = {
>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>       { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> -    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
>   };
>   static const size_t pc_q35_compat_defaults_len =
>       G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e72d514a4c..0c4606d9cb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -49,8 +49,6 @@
>   #include "vfio-migration-internal.h"
>   #include "vfio-helpers.h"
>   
> -#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> -
>   /* Protected by BQL */
>   static KVMRouteChange vfio_route_change;
>   


