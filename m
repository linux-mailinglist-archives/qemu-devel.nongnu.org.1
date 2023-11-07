Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4927E3250
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 01:41:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0A8R-0003hK-T9; Mon, 06 Nov 2023 19:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0A8M-0003h8-U1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 19:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0A8I-00013Y-2I
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 19:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699317590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVh9XJIOKbHXM8ViHQDJWr44h7WJfdkZkzvuDfpL148=;
 b=FYQazr0BU4k9nntchdu49bfUbXRu5C+XybMi55XqzikkafkDQfrIfwYuepyAhPw8ht6Q8k
 FevOXHXNFR0lilPOCjQuyK8mkqPi/k0bNeUPqBUX38PQO4nJtsqwkaZn7NK/VEOTjHyOuN
 wmaSqT8BKOXDOYfXKCxBM86wUR4I/6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-8CJkLabbPgOSSPEuBCUJuQ-1; Mon, 06 Nov 2023 19:39:48 -0500
X-MC-Unique: 8CJkLabbPgOSSPEuBCUJuQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so32361455e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 16:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699317587; x=1699922387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVh9XJIOKbHXM8ViHQDJWr44h7WJfdkZkzvuDfpL148=;
 b=rbkCGMfTcPT9pxDthRSOw5hIj7jhM8m4HZLNW629fxtrPhjITcmCft1Xnlls1ZZOcF
 jGE9r+g7phmFwY8xe7keeKg0X7+dtVPnLNX/bACaorsmt9kyJwhPmi4A0uizv6JWtQUm
 7X7VNtZojZaCNeJxfcRFSDVrdYDPHICY5ELdx3wtnJ8qwvPZtyl8GoupJEfCH9vcgTn0
 AG/MsivkciVf0B7ezPXONsVDpUDOgL6MecUsjiPUor6EGRLvtEhGsUrJWd2gqDvlwjPi
 cvuecQQoNIQ654y068gAd24MwiAljrZIHM/qx5cdNKH/3BTn51UR03YcWfqhF+zCPKUg
 prKw==
X-Gm-Message-State: AOJu0YyIaoZuORX1gGv90KfR+ZgRnxm4NV6sIIPIhY1ciaz2beeaDq9a
 DkfaL52u+EVRRub2ND5gZf+D+lONXin25NZ+/bNQNd9ovVlob28J7S+cBmVlNkOz4TWXAI8yk+S
 XX7uuBON5qrqqS7w=
X-Received: by 2002:a05:600c:4c19:b0:408:4f50:9602 with SMTP id
 d25-20020a05600c4c1900b004084f509602mr1033742wmp.12.1699317587134; 
 Mon, 06 Nov 2023 16:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkR39rrj7GDmiiloftCFYwzJQ2tNZV2Y91sECSQ0NASqqLPuVLiA68fOIhXbMiC2hI2/i3RA==
X-Received: by 2002:a05:600c:4c19:b0:408:4f50:9602 with SMTP id
 d25-20020a05600c4c1900b004084f509602mr1033731wmp.12.1699317586723; 
 Mon, 06 Nov 2023 16:39:46 -0800 (PST)
Received: from redhat.com ([2.55.35.37]) by smtp.gmail.com with ESMTPSA id
 ay8-20020a05600c1e0800b0040772138bb7sm13978543wmb.2.2023.11.06.16.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 16:39:45 -0800 (PST)
Date: Mon, 6 Nov 2023 19:39:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>
Subject: Re: [PATCH v9 5/5] amd_iommu: report x2APIC support to the operating
 system
Message-ID: <20231106193841-mutt-send-email-mst@kernel.org>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <20231024152105.35942-6-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024152105.35942-6-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=216.145.221.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Oct 24, 2023 at 10:21:05PM +0700, Bui Quang Minh wrote:
> This commit adds XTSup configuration to let user choose to whether enable
> this feature or not. When XTSup is enabled, additional bytes in IRTE with
> enabled guest virtual VAPIC are used to support 32-bit destination id.
> 
> Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
> 0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
> features only the legacy ones, so operating system (e.g. Linux) may only
> detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
> is kept so that old operating system that only parses type 0x10 can detect
> the IOMMU device.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>


changes IVRS without updating expected files for tests.
result seems to be CI failures:
https://gitlab.com/mstredhat/qemu/-/jobs/5470533834

> ---
>  hw/i386/acpi-build.c | 129 +++++++++++++++++++++++++++----------------
>  hw/i386/amd_iommu.c  |  29 +++++++++-
>  hw/i386/amd_iommu.h  |  16 ++++--
>  3 files changed, 117 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3f2b27cf75..8069971e54 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2337,30 +2337,23 @@ static void
>  build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>                  const char *oem_table_id)
>  {
> -    int ivhd_table_len = 24;
>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
>      GArray *ivhd_blob = g_array_new(false, true, 1);
>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
> +    uint64_t feature_report;
>  
>      acpi_table_begin(&table, table_data);
>      /* IVinfo - IO virtualization information common to all
>       * IOMMU units in a system
>       */
> -    build_append_int_noprefix(table_data, 40UL << 8/* PASize */, 4);
> +    build_append_int_noprefix(table_data,
> +                             (1UL << 0) | /* EFRSup */
> +                             (40UL << 8), /* PASize */
> +                             4);
>      /* reserved */
>      build_append_int_noprefix(table_data, 0, 8);
>  
> -    /* IVHD definition - type 10h */
> -    build_append_int_noprefix(table_data, 0x10, 1);
> -    /* virtualization flags */
> -    build_append_int_noprefix(table_data,
> -                             (1UL << 0) | /* HtTunEn      */
> -                             (1UL << 4) | /* iotblSup     */
> -                             (1UL << 6) | /* PrefSup      */
> -                             (1UL << 7),  /* PPRSup       */
> -                             1);
> -
>      /*
>       * A PCI bus walk, for each PCI host bridge, is necessary to create a
>       * complete set of IVHD entries.  Do this into a separate blob so that we
> @@ -2380,56 +2373,94 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>          build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
>      }
>  
> -    ivhd_table_len += ivhd_blob->len;
> -
>      /*
>       * When interrupt remapping is supported, we add a special IVHD device
> -     * for type IO-APIC.
> -     */
> -    if (x86_iommu_ir_supported(x86_iommu_get_default())) {
> -        ivhd_table_len += 8;
> -    }
> -
> -    /* IVHD length */
> -    build_append_int_noprefix(table_data, ivhd_table_len, 2);
> -    /* DeviceID */
> -    build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(&s->pci), "addr",
> -                                                      &error_abort), 2);
> -    /* Capability offset */
> -    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
> -    /* IOMMU base address */
> -    build_append_int_noprefix(table_data, s->mmio.addr, 8);
> -    /* PCI Segment Group */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU info */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU Feature Reporting */
> -    build_append_int_noprefix(table_data,
> -                             (48UL << 30) | /* HATS   */
> -                             (48UL << 28) | /* GATS   */
> -                             (1UL << 2)   | /* GTSup  */
> -                             (1UL << 6),    /* GASup  */
> -                             4);
> -
> -    /* IVHD entries as found above */
> -    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
> -    g_array_free(ivhd_blob, TRUE);
> -
> -    /*
> -     * Add a special IVHD device type.
> +     * for type IO-APIC
>       * Refer to spec - Table 95: IVHD device entry type codes
>       *
>       * Linux IOMMU driver checks for the special IVHD device (type IO-APIC).
>       * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
>       */
>      if (x86_iommu_ir_supported(x86_iommu_get_default())) {
> -        build_append_int_noprefix(table_data,
> +        build_append_int_noprefix(ivhd_blob,
>                                   (0x1ull << 56) |           /* type IOAPIC */
>                                   (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
>                                   0x48,                      /* special device */
>                                   8);
>      }
> +
> +    /* IVHD definition - type 10h */
> +    build_append_int_noprefix(table_data, 0x10, 1);
> +    /* virtualization flags */
> +    build_append_int_noprefix(table_data,
> +                             (1UL << 0) | /* HtTunEn      */
> +                             (1UL << 4) | /* iotblSup     */
> +                             (1UL << 6) | /* PrefSup      */
> +                             (1UL << 7),  /* PPRSup       */
> +                             1);
> +
> +    /* IVHD length */
> +    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
> +    /* DeviceID */
> +    build_append_int_noprefix(table_data,
> +                              object_property_get_int(OBJECT(&s->pci), "addr",
> +                                                      &error_abort), 2);
> +    /* Capability offset */
> +    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
> +    /* IOMMU base address */
> +    build_append_int_noprefix(table_data, s->mmio.addr, 8);
> +    /* PCI Segment Group */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* IOMMU info */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* IOMMU Feature Reporting */
> +    feature_report = (48UL << 30) | /* HATS   */
> +                     (48UL << 28) | /* GATS   */
> +                     (1UL << 2)   | /* GTSup  */
> +                     (1UL << 6);    /* GASup  */
> +    if (s->xtsup) {
> +        feature_report |= (1UL << 0); /* XTSup */
> +    }
> +    build_append_int_noprefix(table_data, feature_report, 4);
> +
> +    /* IVHD entries as found above */
> +    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
> +
> +   /* IVHD definition - type 11h */
> +    build_append_int_noprefix(table_data, 0x11, 1);
> +    /* virtualization flags */
> +    build_append_int_noprefix(table_data,
> +                             (1UL << 0) | /* HtTunEn      */
> +                             (1UL << 4),  /* iotblSup     */
> +                             1);
> +
> +    /* IVHD length */
> +    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
> +    /* DeviceID */
> +    build_append_int_noprefix(table_data,
> +                              object_property_get_int(OBJECT(&s->pci), "addr",
> +                                                      &error_abort), 2);
> +    /* Capability offset */
> +    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
> +    /* IOMMU base address */
> +    build_append_int_noprefix(table_data, s->mmio.addr, 8);
> +    /* PCI Segment Group */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* IOMMU info */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* IOMMU Attributes */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* EFR Register Image */
> +    build_append_int_noprefix(table_data,
> +                              amdvi_extended_feature_register(s),
> +                              8);
> +    /* EFR Register Image 2 */
> +    build_append_int_noprefix(table_data, 0, 8);
> +
> +    /* IVHD entries as found above */
> +    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
> +
> +    g_array_free(ivhd_blob, TRUE);
>      acpi_table_end(linker, &table);
>  }
>  
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 7965415b47..e7809b641a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -31,6 +31,7 @@
>  #include "hw/i386/apic_internal.h"
>  #include "trace.h"
>  #include "hw/i386/apic-msidef.h"
> +#include "hw/qdev-properties.h"
>  
>  /* used AMD-Vi MMIO registers */
>  const char *amdvi_mmio_low[] = {
> @@ -74,6 +75,16 @@ typedef struct AMDVIIOTLBEntry {
>      uint64_t page_mask;         /* physical page size  */
>  } AMDVIIOTLBEntry;
>  
> +uint64_t amdvi_extended_feature_register(AMDVIState *s)
> +{
> +    uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> +    if (s->xtsup) {
> +        feature |= AMDVI_FEATURE_XT;
> +    }
> +
> +    return feature;
> +}
> +
>  /* configure MMIO registers at startup/reset */
>  static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
>                             uint64_t romask, uint64_t w1cmask)
> @@ -1155,7 +1166,12 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>      irq->vector = irte.hi.fields.vector;
>      irq->dest_mode = irte.lo.fields_remap.dm;
>      irq->redir_hint = irte.lo.fields_remap.rq_eoi;
> -    irq->dest = irte.lo.fields_remap.destination;
> +    if (iommu->xtsup) {
> +        irq->dest = irte.lo.fields_remap.destination |
> +                    (irte.hi.fields.destination_hi << 24);
> +    } else {
> +        irq->dest = irte.lo.fields_remap.destination & 0xff;
> +    }
>  
>      return 0;
>  }
> @@ -1501,8 +1517,9 @@ static void amdvi_init(AMDVIState *s)
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> -    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, AMDVI_EXT_FEATURES,
> -            0xffffffffffffffef, 0);
> +    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
> +                   amdvi_extended_feature_register(s),
> +                   0xffffffffffffffef, 0);
>      amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
>  }
>  
> @@ -1585,6 +1602,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>      amdvi_init(s);
>  }
>  
> +static Property amdvi_properties[] = {
> +    DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static const VMStateDescription vmstate_amdvi_sysbus = {
>      .name = "amd-iommu",
>      .unmigratable = 1
> @@ -1611,6 +1633,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->user_creatable = true;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
> +    device_class_set_props(dc, amdvi_properties);
>  }
>  
>  static const TypeInfo amdvi_sysbus = {
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index c5065a3e27..73619fe9ea 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -154,6 +154,7 @@
>  
>  #define AMDVI_FEATURE_PREFETCH            (1ULL << 0) /* page prefetch       */
>  #define AMDVI_FEATURE_PPR                 (1ULL << 1) /* PPR Support         */
> +#define AMDVI_FEATURE_XT                  (1ULL << 2) /* x2APIC Support      */
>  #define AMDVI_FEATURE_GT                  (1ULL << 4) /* Guest Translation   */
>  #define AMDVI_FEATURE_IA                  (1ULL << 6) /* inval all support   */
>  #define AMDVI_FEATURE_GA                  (1ULL << 7) /* guest VAPIC support */
> @@ -173,8 +174,9 @@
>  #define AMDVI_IOTLB_MAX_SIZE 1024
>  #define AMDVI_DEVID_SHIFT    36
>  
> -/* extended feature support */
> -#define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
> +/* default extended feature */
> +#define AMDVI_DEFAULT_EXT_FEATURES \
> +        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
>          AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
>          AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
>  
> @@ -276,8 +278,8 @@ union irte_ga_lo {
>                  dm:1,
>                  /* ------ */
>                  guest_mode:1,
> -                destination:8,
> -                rsvd_1:48;
> +                destination:24,
> +                rsvd_1:32;
>    } fields_remap;
>  };
>  
> @@ -285,7 +287,8 @@ union irte_ga_hi {
>    uint64_t val;
>    struct {
>        uint64_t  vector:8,
> -                rsvd_2:56;
> +                rsvd_2:48,
> +                destination_hi:8;
>    } fields;
>  };
>  
> @@ -364,6 +367,9 @@ struct AMDVIState {
>  
>      /* Interrupt remapping */
>      bool ga_enabled;
> +    bool xtsup;
>  };
>  
> +uint64_t amdvi_extended_feature_register(AMDVIState *s);
> +
>  #endif
> -- 
> 2.25.1


