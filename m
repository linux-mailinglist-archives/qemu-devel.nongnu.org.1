Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B784773A972
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQtQ-0001Sc-02; Thu, 22 Jun 2023 16:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQtA-0001Qk-UX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQt8-00056c-Pj
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687465601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRjV7wZFrFjhDbAQFew1TOgDrI5aleXAHiDoRE+Gkfg=;
 b=WMbIMaU5aMkqKk7YsFkhdUx6pP9Nto6rSkkdAJ/Ulxrs7CyFeAKiLndhLsNzrmA1lsJ43W
 cXWAilQVNHtUSfzID6HUJwOtO2oTvYtmnsuEaFDpzqV9FTjF8bRQNXBnKN5RbBefS5Gp6H
 mjNJzDmr9JB69iSsA44EmlpyWsKDh2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ii3lkD5hPJCZyCtZPJdWMQ-1; Thu, 22 Jun 2023 16:26:38 -0400
X-MC-Unique: ii3lkD5hPJCZyCtZPJdWMQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f8fe1f1199so29312325e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687465597; x=1690057597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRjV7wZFrFjhDbAQFew1TOgDrI5aleXAHiDoRE+Gkfg=;
 b=TXSBdex6v6C0NyWSmoNXIVLckYba3xOpbO2JJgwdIZAqbSA8HphnNeEKOUxDGJ0Xu8
 NS6VBTqexBrC10h65RvlLUB+2wMRJo/6dk3Jbzv60OZ7u7SOzAo0T8Ic/CThDWfVRk5w
 0ZK+MjwOCASWB2/faA3yQyth/eno9e48kUJczkcDj+Gulj8vmQTlRejmHLquECubjBDL
 KwFC4S54cIY0cLk3qqqZIjL/+ElPyiPVShmZET3F/sa3qr5PbbhO9WEGpTVs7DCBZuQf
 cWI7J/m+h/CpiYRaaeivQgFxrCQi5x4HDOxa2NDgIifA00R3Rxo+DB8cTKKAz1lhQheh
 4vvg==
X-Gm-Message-State: AC+VfDzkUCCvXeSFqpwhJdAHcAw/uGpLBDgbs31WClS1rgqOmgxVla1A
 hjXNNDY5zZnFAFAa1ctgE5wx98C70qsDzazSj4sAAixUNRr0/TFOTicqe1E1FDyaf52JH+BgJry
 3Wilz2VUSJtl2Ml4=
X-Received: by 2002:a05:600c:2189:b0:3f6:7e6:44ea with SMTP id
 e9-20020a05600c218900b003f607e644eamr2467830wme.18.1687465597638; 
 Thu, 22 Jun 2023 13:26:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P3O1MSwL2iAie9rFZyKToaL6dvlTlCZonzk2rmBKRUnD2SSG64JLtqdJTu4/n6ElwFNGWTA==
X-Received: by 2002:a05:600c:2189:b0:3f6:7e6:44ea with SMTP id
 e9-20020a05600c218900b003f607e644eamr2467818wme.18.1687465597231; 
 Thu, 22 Jun 2023 13:26:37 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 k19-20020a05600c0b5300b003f90ab2fff9sm432306wmr.9.2023.06.22.13.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 13:26:36 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:26:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 5/5] amd_iommu: report x2APIC support to the operating
 system
Message-ID: <20230622162602-mutt-send-email-mst@kernel.org>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
 <20230522163157.9754-6-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522163157.9754-6-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 22, 2023 at 11:31:57PM +0700, Bui Quang Minh wrote:
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
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  hw/i386/acpi-build.c | 127 ++++++++++++++++++++++++++-----------------
>  hw/i386/amd_iommu.c  |  21 ++++++-
>  hw/i386/amd_iommu.h  |  16 ++++--
>  3 files changed, 108 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 512162003b..4459122e56 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2339,30 +2339,23 @@ static void
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
> @@ -2382,56 +2375,92 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
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
> +    build_append_int_noprefix(table_data, s->efr_reg, 8);
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
> index 9c77304438..0e308184d7 100644
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
> @@ -1155,7 +1156,12 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
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
> @@ -1503,10 +1509,15 @@ static void amdvi_init(AMDVIState *s)
>      s->enabled = false;
>      s->ats_enabled = false;
>      s->cmdbuf_enabled = false;
> +    s->efr_reg = AMDVI_DEFAULT_EXT_FEATURES;
> +
> +    if (s->xtsup) {
> +        s->efr_reg |= AMDVI_FEATURE_XT;
> +    }
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> -    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, AMDVI_EXT_FEATURES,
> +    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, s->efr_reg,
>              0xffffffffffffffef, 0);
>      amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
>  }
> @@ -1591,6 +1602,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
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
> @@ -1617,6 +1633,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->user_creatable = true;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
> +    device_class_set_props(dc, amdvi_properties);
>  }
>  
>  static const TypeInfo amdvi_sysbus = {
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 6da893ee57..f3730db990 100644
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
> @@ -278,8 +280,8 @@ union irte_ga_lo {
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
> @@ -287,7 +289,8 @@ union irte_ga_hi {
>    uint64_t val;
>    struct {
>        uint64_t  vector:8,
> -                rsvd_2:56;
> +                rsvd_2:48,
> +                destination_hi:8;
>    } fields;
>  };
>  
> @@ -366,6 +369,9 @@ struct AMDVIState {
>  
>      /* Interrupt remapping */
>      bool ga_enabled;
> +    bool xtsup;
> +
> +    uint64_t efr_reg;            /* extended feature register */
>  };

It would be cleaner to have efr_reg as a function and just call it
when needed.

With that addressed:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


>  #endif
> -- 
> 2.25.1


