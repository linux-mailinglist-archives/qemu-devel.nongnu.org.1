Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728373BBA5
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiiX-0004Qi-UN; Fri, 23 Jun 2023 11:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qCiiS-0004Pl-Ms
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:28:52 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qCiiQ-0001b2-Fe
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:28:52 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a046446dacso467787b6e.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687534129; x=1690126129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5mSfWdCbQfM+kRayAB4carkZBy03jJuRft+chbZzuw=;
 b=chaaN76upd46rVF70YBmiFNgxsd4YZ+3y5uof9j98/tiH3aZBJIfB4t3tRZMiNz58G
 bQlYlBhN8AQG/tcWcyh/xIoaMOwdCGtImiIAhopTwmu2j0vH65UiuZSwzgWI1/75PnOF
 VKFdUMuXk7BFWFN6803qnxTJpAhTTJV9XO/JMBB8cjjGQeMhU8iImRDowviqwPgmjn0+
 spLxfAjxivAfrBw/0x1rQ6SEkkNxcxmmyjNJwsd9cmrhnNModEwJCd4hGEvCEhhm7sM0
 B2I7M4m6ltKHj5esXYPyegTdq4ATDilJrmbyqp8YR/PsrgPtSKJa3M3LRiJaP2+zjL2z
 0iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534129; x=1690126129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5mSfWdCbQfM+kRayAB4carkZBy03jJuRft+chbZzuw=;
 b=YAzCRSo0//L04/zm5eUAKZwy1810j+WEDSZ22JnXkib3TbA0P3F1nVx8CuswcxmGwu
 qzTznoQoz8xOM7MPhWc54R7nB8LdiItc6Unkx7ovKS9kOBBz4ka7CC7C6BAHmoNKHMUt
 wkA+gHP5bW21fjQ4bZLzSkQR00q0PoHa8NkdAIGV03S+Y4NOPT68dHgJkHuLKyonsiEy
 Sn2jgRjHOmFq2m342FWTSyLJAC+o3UvJmZU9RoqAl/Hmz+JKsubftXSNUlBKkseNIDze
 YFeRRy2zIMNCP+wVtYYz/KbndeGhRhgkbiSlGQCbf/DoT73Dj5JIbabWJQzYSEjEu8xw
 00YA==
X-Gm-Message-State: AC+VfDy0TI/yyc/v1Tzhlp5DiRLWPAIhfk3ltv+tHMeLUGvNSJuuzs9S
 cUIxHeT1ay8/xv5M8KT7MAg=
X-Google-Smtp-Source: ACHHUZ48TLF2EK6FXJ8RHQKSVmD5jB9fwwAXkkK5a7gfcDl1D1Fc8jB0ZrRsIUjjypTDPaVoKDBJ3Q==
X-Received: by 2002:a05:6808:21aa:b0:3a0:57ce:bff7 with SMTP id
 be42-20020a05680821aa00b003a057cebff7mr7585291oib.51.1687534128855; 
 Fri, 23 Jun 2023 08:28:48 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fb3:b780:9a41:e6b4:2e4a:b7d3?
 ([2001:ee0:4fb3:b780:9a41:e6b4:2e4a:b7d3])
 by smtp.gmail.com with ESMTPSA id
 gj13-20020a17090b108d00b00262ad7b2340sm1057924pjb.54.2023.06.23.08.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:28:48 -0700 (PDT)
Message-ID: <bfa5991d-07d0-84ae-d29c-d467c091343d@gmail.com>
Date: Fri, 23 Jun 2023 22:28:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/5] amd_iommu: report x2APIC support to the operating
 system
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
 <20230522163157.9754-6-minhquangbui99@gmail.com>
 <20230622162602-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230622162602-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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

On 6/23/23 03:26, Michael S. Tsirkin wrote:
> On Mon, May 22, 2023 at 11:31:57PM +0700, Bui Quang Minh wrote:
>> This commit adds XTSup configuration to let user choose to whether enable
>> this feature or not. When XTSup is enabled, additional bytes in IRTE with
>> enabled guest virtual VAPIC are used to support 32-bit destination id.
>>
>> Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
>> 0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
>> features only the legacy ones, so operating system (e.g. Linux) may only
>> detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
>> is kept so that old operating system that only parses type 0x10 can detect
>> the IOMMU device.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   hw/i386/acpi-build.c | 127 ++++++++++++++++++++++++++-----------------
>>   hw/i386/amd_iommu.c  |  21 ++++++-
>>   hw/i386/amd_iommu.h  |  16 ++++--
>>   3 files changed, 108 insertions(+), 56 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 512162003b..4459122e56 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2339,30 +2339,23 @@ static void
>>   build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>                   const char *oem_table_id)
>>   {
>> -    int ivhd_table_len = 24;
>>       AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
>>       GArray *ivhd_blob = g_array_new(false, true, 1);
>>       AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>>                           .oem_table_id = oem_table_id };
>> +    uint64_t feature_report;
>>   
>>       acpi_table_begin(&table, table_data);
>>       /* IVinfo - IO virtualization information common to all
>>        * IOMMU units in a system
>>        */
>> -    build_append_int_noprefix(table_data, 40UL << 8/* PASize */, 4);
>> +    build_append_int_noprefix(table_data,
>> +                             (1UL << 0) | /* EFRSup */
>> +                             (40UL << 8), /* PASize */
>> +                             4);
>>       /* reserved */
>>       build_append_int_noprefix(table_data, 0, 8);
>>   
>> -    /* IVHD definition - type 10h */
>> -    build_append_int_noprefix(table_data, 0x10, 1);
>> -    /* virtualization flags */
>> -    build_append_int_noprefix(table_data,
>> -                             (1UL << 0) | /* HtTunEn      */
>> -                             (1UL << 4) | /* iotblSup     */
>> -                             (1UL << 6) | /* PrefSup      */
>> -                             (1UL << 7),  /* PPRSup       */
>> -                             1);
>> -
>>       /*
>>        * A PCI bus walk, for each PCI host bridge, is necessary to create a
>>        * complete set of IVHD entries.  Do this into a separate blob so that we
>> @@ -2382,56 +2375,92 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>           build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
>>       }
>>   
>> -    ivhd_table_len += ivhd_blob->len;
>> -
>>       /*
>>        * When interrupt remapping is supported, we add a special IVHD device
>> -     * for type IO-APIC.
>> -     */
>> -    if (x86_iommu_ir_supported(x86_iommu_get_default())) {
>> -        ivhd_table_len += 8;
>> -    }
>> -
>> -    /* IVHD length */
>> -    build_append_int_noprefix(table_data, ivhd_table_len, 2);
>> -    /* DeviceID */
>> -    build_append_int_noprefix(table_data,
>> -                              object_property_get_int(OBJECT(&s->pci), "addr",
>> -                                                      &error_abort), 2);
>> -    /* Capability offset */
>> -    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
>> -    /* IOMMU base address */
>> -    build_append_int_noprefix(table_data, s->mmio.addr, 8);
>> -    /* PCI Segment Group */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU info */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU Feature Reporting */
>> -    build_append_int_noprefix(table_data,
>> -                             (48UL << 30) | /* HATS   */
>> -                             (48UL << 28) | /* GATS   */
>> -                             (1UL << 2)   | /* GTSup  */
>> -                             (1UL << 6),    /* GASup  */
>> -                             4);
>> -
>> -    /* IVHD entries as found above */
>> -    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>> -    g_array_free(ivhd_blob, TRUE);
>> -
>> -    /*
>> -     * Add a special IVHD device type.
>> +     * for type IO-APIC
>>        * Refer to spec - Table 95: IVHD device entry type codes
>>        *
>>        * Linux IOMMU driver checks for the special IVHD device (type IO-APIC).
>>        * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
>>        */
>>       if (x86_iommu_ir_supported(x86_iommu_get_default())) {
>> -        build_append_int_noprefix(table_data,
>> +        build_append_int_noprefix(ivhd_blob,
>>                                    (0x1ull << 56) |           /* type IOAPIC */
>>                                    (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
>>                                    0x48,                      /* special device */
>>                                    8);
>>       }
>> +
>> +    /* IVHD definition - type 10h */
>> +    build_append_int_noprefix(table_data, 0x10, 1);
>> +    /* virtualization flags */
>> +    build_append_int_noprefix(table_data,
>> +                             (1UL << 0) | /* HtTunEn      */
>> +                             (1UL << 4) | /* iotblSup     */
>> +                             (1UL << 6) | /* PrefSup      */
>> +                             (1UL << 7),  /* PPRSup       */
>> +                             1);
>> +
>> +    /* IVHD length */
>> +    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>> +    /* DeviceID */
>> +    build_append_int_noprefix(table_data,
>> +                              object_property_get_int(OBJECT(&s->pci), "addr",
>> +                                                      &error_abort), 2);
>> +    /* Capability offset */
>> +    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
>> +    /* IOMMU base address */
>> +    build_append_int_noprefix(table_data, s->mmio.addr, 8);
>> +    /* PCI Segment Group */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* IOMMU info */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* IOMMU Feature Reporting */
>> +    feature_report = (48UL << 30) | /* HATS   */
>> +                     (48UL << 28) | /* GATS   */
>> +                     (1UL << 2)   | /* GTSup  */
>> +                     (1UL << 6);    /* GASup  */
>> +    if (s->xtsup) {
>> +        feature_report |= (1UL << 0); /* XTSup */
>> +    }
>> +    build_append_int_noprefix(table_data, feature_report, 4);
>> +
>> +    /* IVHD entries as found above */
>> +    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>> +
>> +   /* IVHD definition - type 11h */
>> +    build_append_int_noprefix(table_data, 0x11, 1);
>> +    /* virtualization flags */
>> +    build_append_int_noprefix(table_data,
>> +                             (1UL << 0) | /* HtTunEn      */
>> +                             (1UL << 4),  /* iotblSup     */
>> +                             1);
>> +
>> +    /* IVHD length */
>> +    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>> +    /* DeviceID */
>> +    build_append_int_noprefix(table_data,
>> +                              object_property_get_int(OBJECT(&s->pci), "addr",
>> +                                                      &error_abort), 2);
>> +    /* Capability offset */
>> +    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
>> +    /* IOMMU base address */
>> +    build_append_int_noprefix(table_data, s->mmio.addr, 8);
>> +    /* PCI Segment Group */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* IOMMU info */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* IOMMU Attributes */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +    /* EFR Register Image */
>> +    build_append_int_noprefix(table_data, s->efr_reg, 8);
>> +    /* EFR Register Image 2 */
>> +    build_append_int_noprefix(table_data, 0, 8);
>> +
>> +    /* IVHD entries as found above */
>> +    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>> +
>> +    g_array_free(ivhd_blob, TRUE);
>>       acpi_table_end(linker, &table);
>>   }
>>   
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 9c77304438..0e308184d7 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -31,6 +31,7 @@
>>   #include "hw/i386/apic_internal.h"
>>   #include "trace.h"
>>   #include "hw/i386/apic-msidef.h"
>> +#include "hw/qdev-properties.h"
>>   
>>   /* used AMD-Vi MMIO registers */
>>   const char *amdvi_mmio_low[] = {
>> @@ -1155,7 +1156,12 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>>       irq->vector = irte.hi.fields.vector;
>>       irq->dest_mode = irte.lo.fields_remap.dm;
>>       irq->redir_hint = irte.lo.fields_remap.rq_eoi;
>> -    irq->dest = irte.lo.fields_remap.destination;
>> +    if (iommu->xtsup) {
>> +        irq->dest = irte.lo.fields_remap.destination |
>> +                    (irte.hi.fields.destination_hi << 24);
>> +    } else {
>> +        irq->dest = irte.lo.fields_remap.destination & 0xff;
>> +    }
>>   
>>       return 0;
>>   }
>> @@ -1503,10 +1509,15 @@ static void amdvi_init(AMDVIState *s)
>>       s->enabled = false;
>>       s->ats_enabled = false;
>>       s->cmdbuf_enabled = false;
>> +    s->efr_reg = AMDVI_DEFAULT_EXT_FEATURES;
>> +
>> +    if (s->xtsup) {
>> +        s->efr_reg |= AMDVI_FEATURE_XT;
>> +    }
>>   
>>       /* reset MMIO */
>>       memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>> -    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, AMDVI_EXT_FEATURES,
>> +    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, s->efr_reg,
>>               0xffffffffffffffef, 0);
>>       amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
>>   }
>> @@ -1591,6 +1602,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>       amdvi_init(s);
>>   }
>>   
>> +static Property amdvi_properties[] = {
>> +    DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>       .name = "amd-iommu",
>>       .unmigratable = 1
>> @@ -1617,6 +1633,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
>>       dc->user_creatable = true;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
>> +    device_class_set_props(dc, amdvi_properties);
>>   }
>>   
>>   static const TypeInfo amdvi_sysbus = {
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 6da893ee57..f3730db990 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -154,6 +154,7 @@
>>   
>>   #define AMDVI_FEATURE_PREFETCH            (1ULL << 0) /* page prefetch       */
>>   #define AMDVI_FEATURE_PPR                 (1ULL << 1) /* PPR Support         */
>> +#define AMDVI_FEATURE_XT                  (1ULL << 2) /* x2APIC Support      */
>>   #define AMDVI_FEATURE_GT                  (1ULL << 4) /* Guest Translation   */
>>   #define AMDVI_FEATURE_IA                  (1ULL << 6) /* inval all support   */
>>   #define AMDVI_FEATURE_GA                  (1ULL << 7) /* guest VAPIC support */
>> @@ -173,8 +174,9 @@
>>   #define AMDVI_IOTLB_MAX_SIZE 1024
>>   #define AMDVI_DEVID_SHIFT    36
>>   
>> -/* extended feature support */
>> -#define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
>> +/* default extended feature */
>> +#define AMDVI_DEFAULT_EXT_FEATURES \
>> +        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
>>           AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
>>           AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
>>   
>> @@ -278,8 +280,8 @@ union irte_ga_lo {
>>                   dm:1,
>>                   /* ------ */
>>                   guest_mode:1,
>> -                destination:8,
>> -                rsvd_1:48;
>> +                destination:24,
>> +                rsvd_1:32;
>>     } fields_remap;
>>   };
>>   
>> @@ -287,7 +289,8 @@ union irte_ga_hi {
>>     uint64_t val;
>>     struct {
>>         uint64_t  vector:8,
>> -                rsvd_2:56;
>> +                rsvd_2:48,
>> +                destination_hi:8;
>>     } fields;
>>   };
>>   
>> @@ -366,6 +369,9 @@ struct AMDVIState {
>>   
>>       /* Interrupt remapping */
>>       bool ga_enabled;
>> +    bool xtsup;
>> +
>> +    uint64_t efr_reg;            /* extended feature register */
>>   };
> 
> It would be cleaner to have efr_reg as a function and just call it
> when needed.
> 
> With that addressed:
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

You mean function like this

uint64_t amdvi_extended_feature_register(AMDVIState *s)
{
	uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
	if (s->xtsup)
		feature |= AMDVI_FEATURE_XT;

	return feature;
}

>>   #endif
>> -- 
>> 2.25.1
> 

