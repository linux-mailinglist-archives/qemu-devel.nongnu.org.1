Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208E7C9E62
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 07:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsFlJ-00066h-AV; Mon, 16 Oct 2023 01:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFlH-00066Z-UX
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:03:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFlF-0000Hd-Vq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 01:03:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so707150966b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 22:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697432604; x=1698037404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5exYDFALQBNByly+1Do2Vwm2my4TCIkLIUi9/Zxsyno=;
 b=EP9vBmZKardtsJaJCmz+x2S6OYvn2F6uyfTlBW2T/FlJdlZbYSPkN1moqiD7V0XxTg
 dPGpGHMGd/pftPsNwNcSWZtOPcgY0sdbvB+QpbmY75JsJ+Y0EJGYMdYvPDkudp0hcdG2
 vMYD5IMGpi4US41xNcm/27eAIdHMk0+9RMlBSuMoRbtO+7y3WKfK0kGSKmVAnGROYHDr
 bOlctCgs2a5hpG14m4c7Og7+ZEswz46ZIlUfbg8VyoosfdCWmhvvJIM9ZGpIjZig8gKa
 g7BWkm1sZcnsXQp5Uh3fcIX+hUUSkmohzfu0aBbcv+EsCdLvy1u7ymfTJ23CNuQwf8kA
 EqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697432604; x=1698037404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5exYDFALQBNByly+1Do2Vwm2my4TCIkLIUi9/Zxsyno=;
 b=ckEa76LCDhAYjR95lLV1ww/5KERiq571q+uBm76xl6kWigIOLG7pXwBio819fUw9xE
 ToIFnbLCMKXqf6rAtC+mVOX+/4eKb/QvMgDuCNDeLx9Hm2Jz+8ZcVWhozyKhnnzHmadB
 EG2rOvNXUUJXASyMh+aOVRadft8zeXLc0xqenJMRdh9AYyPP7+oxY0Ckhp1/2a8peVn3
 XZpsvtsMq5bdp+sFatPUfVjt3i+txTeYvhn/rkRqm60Ny1Dx4bs2wqipLPjQ3s8s1nrn
 7Vo5BMCLqp/pgiLvpnzL92sf3cXFOiLOYn2+/LQXIvusC7Z6sBBy8ccmSD2xlovHXrl3
 WyIw==
X-Gm-Message-State: AOJu0YzAxziOBo7RNclCMz9TixyFrUSoaYe3MbSpEejeL3+TyrSx5yAh
 fZzFl9+VuROyNtdphmb9xaALyQ==
X-Google-Smtp-Source: AGHT+IFs5pSJbefhVHY5pD9fVzdYdKfVP18bS/rnstGn1vMtRFg1ldWjhSuGNUxkpsgfdJoqQianow==
X-Received: by 2002:a17:907:608d:b0:9bd:d8d6:c1ad with SMTP id
 ht13-20020a170907608d00b009bdd8d6c1admr7800244ejc.61.1697432603897; 
 Sun, 15 Oct 2023 22:03:23 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 vb7-20020a170907d04700b0099ccee57ac2sm3245579ejc.194.2023.10.15.22.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 22:03:23 -0700 (PDT)
Message-ID: <4aa32a57-97e7-37c5-2873-4699629f4199@linaro.org>
Date: Mon, 16 Oct 2023 07:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Liu Yi L <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231013145634.224457-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013145634.224457-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cédric, Liu, Joao,

On 13/10/23 16:56, Cédric Le Goater wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> This patch modifies pci_setup_iommu() to set PCIIOMMUOps
> instead of setting PCIIOMMUFunc. PCIIOMMUFunc is used to
> get an address space for a PCI device in vendor specific
> way. The PCIIOMMUOps still offers this functionality. But
> using PCIIOMMUOps leaves space to add more iommu related
> vendor specific operations.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> [ clg: - refreshed on latest QEMU
>         - included hw/remote/iommu.c   ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
> 
>   Hello,
> 
>   Initially sent by Yi Liu as part of series "intel_iommu: expose
>   Shared Virtual Addressing to VMs" [1], this patch would also simplify
>   the changes Joao wants to introduce in "vfio: VFIO migration support
>   with vIOMMU" [2].
> 
>   Has anyone objections ?
> 
>   Thanks,
> 
>   C.
> 
>   [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
>   [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> 
> 
> 
>   include/hw/pci/pci.h     |  8 ++++++--
>   include/hw/pci/pci_bus.h |  2 +-
>   hw/alpha/typhoon.c       |  6 +++++-
>   hw/arm/smmu-common.c     |  6 +++++-
>   hw/i386/amd_iommu.c      |  6 +++++-
>   hw/i386/intel_iommu.c    |  6 +++++-
>   hw/pci-host/designware.c |  6 +++++-
>   hw/pci-host/dino.c       |  6 +++++-
>   hw/pci-host/pnv_phb3.c   |  6 +++++-
>   hw/pci-host/pnv_phb4.c   |  6 +++++-
>   hw/pci-host/ppce500.c    |  6 +++++-
>   hw/pci-host/raven.c      |  6 +++++-
>   hw/pci-host/sabre.c      |  6 +++++-
>   hw/pci/pci.c             | 18 +++++++++++++-----
>   hw/ppc/ppc440_pcix.c     |  6 +++++-
>   hw/ppc/spapr_pci.c       |  6 +++++-
>   hw/remote/iommu.c        |  6 +++++-
>   hw/s390x/s390-pci-bus.c  |  8 ++++++--
>   hw/virtio/virtio-iommu.c |  6 +++++-
>   19 files changed, 101 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index b70a0b95ff5ae367ed7f98483ec8d1d1b6274530..486e54174b1755995328f2352fd4571d01e107dc 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -366,10 +366,14 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>   
>   void pci_device_deassert_intx(PCIDevice *dev);
>   
> -typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
> +typedef struct PCIIOMMUOps PCIIOMMUOps;

Preferably:

typedef ...

> +struct PCIIOMMUOps {

        /* documentation ... */

> +    AddressSpace * (*get_address_space)(PCIBus *bus,
> +                                void *opaque, int32_t devfn);
> +};

... PCIIOMMUOps;

Should this be PciIommuOps?

Do we need 'int32_t' for devfn or 'int' is enough?

Would "lookup_address_space" be clearer?

>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);

Since the prototype is modified, we can take the opportunity to
document it :)

> +void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);

Otherwise the change makes sense.

Regards,

Phil.

