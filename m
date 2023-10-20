Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54E7D06CE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 05:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtg7B-00006i-8T; Thu, 19 Oct 2023 23:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtg79-00006J-5F; Thu, 19 Oct 2023 23:23:55 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtg77-0005cr-Hm; Thu, 19 Oct 2023 23:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697772233; x=1729308233;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bfPBI0norhwBX2TA7blApidsQAVHZ/QQGLCBg+r3xXg=;
 b=VXS9nz3de7cyM0vhnWAvH8hRuutfL3RwvmrFlapaGhLOfAqsrWt7L7Pj
 rQ6up74Kdh8TO+su1TM+q5UBe0+dZUa0AJhppD1x0yjNpRgyb6i49VPS2
 QmLm69jEoVGFvhKlPg1BQMW4K91SnUmSA2sM8fdWYVoWtIAQrCXtyG+e4
 Nmlf0TTu2LQ0nmuM7j2bbpIbOWWXG+sxpFsEMHK4cOlX6PrrY3zO5JiEv
 Wpmeb4klPD5+MJ5ciJxQAOJqTX8fcWXHkur0GO0KqMU4xqmfnqI6VNqcQ
 1cdStBKhrzDTkJ3IUqtEajV5fGW5gG5jn+UyriKm8DK24AzMFKLlvrB7J A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366655081"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; d="scan'208";a="366655081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 20:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4974078"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 19 Oct 2023 20:22:33 -0700
Date: Fri, 20 Oct 2023 11:35:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 02/12] hw/i386/intel_iommu: Do not use SysBus API to
 map local MMIO region
Message-ID: <ZTH1eK6f7RqUSfsF@intel.com>
References: <20231019071611.98885-1-philmd@linaro.org>
 <20231019071611.98885-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019071611.98885-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.55.52.151; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Oct 19, 2023 at 09:16:00AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 19 Oct 2023 09:16:00 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 02/12] hw/i386/intel_iommu: Do not use SysBus API to map
>  local MMIO region
> X-Mailer: git-send-email 2.41.0
> 
> There is no point in exposing an internal MMIO region via
> SysBus and directly mapping it in the very same device.
> 
> Just map it without using the SysBus API.
> 
> Transformation done using the following coccinelle script:
> 
>   @@
>   expression sbdev;
>   expression index;
>   expression addr;
>   expression subregion;
>   @@
>   -    sysbus_init_mmio(sbdev, subregion);
>        ... when != sbdev
>   -    sysbus_mmio_map(sbdev, index, addr);
>   +    memory_region_add_subregion(get_system_memory(), addr, subregion);
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Oh, I missed you've queued this series...

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2c832ab68b..e4f6cedcb1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4134,6 +4134,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      qemu_mutex_init(&s->iommu_lock);
>      memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
>                            "intel_iommu", DMAR_REG_SIZE);
> +    memory_region_add_subregion(get_system_memory(),
> +                                Q35_HOST_BRIDGE_IOMMU_ADDR, &s->csrmem);
>  
>      /* Create the shared memory regions by all devices */
>      memory_region_init(&s->mr_nodmar, OBJECT(s), "vtd-nodmar",
> @@ -4148,15 +4150,12 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion_overlap(&s->mr_nodmar,
>                                          VTD_INTERRUPT_ADDR_FIRST,
>                                          &s->mr_ir, 1);
> -
> -    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->csrmem);
>      /* No corresponding destroy */
>      s->iotlb = g_hash_table_new_full(vtd_iotlb_hash, vtd_iotlb_equal,
>                                       g_free, g_free);
>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
>                                        g_free, g_free);
>      vtd_init(s);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
>      pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
>      /* Pseudo address space under root PCI bus. */
>      x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
> -- 
> 2.41.0
> 
> 
> 

