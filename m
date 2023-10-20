Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D503D7D06CD
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 05:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtg5M-0007s4-Qk; Thu, 19 Oct 2023 23:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtg5K-0007rk-MN; Thu, 19 Oct 2023 23:22:02 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtg5F-0005Tz-6l; Thu, 19 Oct 2023 23:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697772117; x=1729308117;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FgdCXE8fYvNp8EnunnbdqUCUXCP+TzMOENOBvtKMGxM=;
 b=VCkMJUoIK1kcgB2TEXvizDmXK64RYIm5xqbsKmzVylw8sAftomtJ4Avu
 W30TJAM4dNgYapQ35uhfBsxRS/0ycgMelbRP3wQxbG5iz6fd4wTWXc7kY
 2g4eCjPncogq+sJVIU0dQKhQIOSRDp93D520o/bm0mcZd34wMBlTA4Y4E
 htKHJNcCyLtXdzbEqLYYe5SBz8+1z7yrqHcT2fMhE6uMTKhTmYyqalr5d
 +7Y+HmJ8s3Zl71ROExMFnTG87oSYjEn0G8EzxERzFjqMLFvbWhHXFcFL2
 5Un507y1LaUUbCfJrbnk/7JnDSrSTKp0tSvbTNpRDPTP3Em7BJt9Gz1g2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="417552554"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; d="scan'208";a="417552554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 20:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="847941950"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; d="scan'208";a="847941950"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2023 20:21:45 -0700
Date: Fri, 20 Oct 2023 11:33:23 +0800
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
Subject: Re: [PATCH v2 01/12] hw/i386/amd_iommu: Do not use SysBus API to map
 local MMIO region
Message-ID: <ZTH1AynH2fmL4Ntq@intel.com>
References: <20231019071611.98885-1-philmd@linaro.org>
 <20231019071611.98885-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019071611.98885-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 19, 2023 at 09:15:59AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 19 Oct 2023 09:15:59 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 01/12] hw/i386/amd_iommu: Do not use SysBus API to map
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
>  hw/i386/amd_iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

-Zhao

> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 8d0f2f99dd..7965415b47 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1579,9 +1579,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>      /* set up MMIO */
>      memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
>                            AMDVI_MMIO_SIZE);
> -
> -    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
> +    memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
> +                                &s->mmio);
>      pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
>      amdvi_init(s);
>  }
> -- 
> 2.41.0
> 
> 
> 

