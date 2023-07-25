Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B67617F1
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGli-0004dm-KO; Tue, 25 Jul 2023 08:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOGle-0004d9-IO
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOGlb-0004k1-5y
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690286629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HV57ockkd1QP7lr6ItjRspt/ObyJxnWGmYkzFogygnw=;
 b=g0fxgG6ZL3SgpPfjI54qk1a/6uDCbhHB7oniHdAnQSlFUfQrX2Tw8P/g8o71L//ZXWEZHX
 obq6+8O4C/HQ8PCrqnIC2VrgXE4IFy4Fg9OxPCzZTloo02zOiAEpo8RyMWmUSWvAQSrFaa
 qMsJ+/C5joQ9fogJJkIouVH44f0tydY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Jm0swONpMAGAWNa-cshlCA-1; Tue, 25 Jul 2023 08:03:46 -0400
X-MC-Unique: Jm0swONpMAGAWNa-cshlCA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51a5296eb8eso4215566a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690286623; x=1690891423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV57ockkd1QP7lr6ItjRspt/ObyJxnWGmYkzFogygnw=;
 b=jWcbOhTeddpQctgdaP2KO+mBugqmmulqzmuCl6v/o5ssVXysWr9kBrgOcL7Ol6QHw6
 lqEISKP6/RghWLv/n6A8TjHEyYt9VPLdaGyKfqaU6sNbkEkCzvbnNNnvkgN6j5kSrbpo
 L26uIb5u1yqUaJ/pO3p4wYFFcFUeejxdUZOcDVpqEGvGOzqW0jUweP9WqXv8B6qu6DZ+
 vpZBzvL9O7FkkJd81nZ+a+nCOiNnRqIT0JR7ISO9jfbjJTmPcB8HQtxuSpWZ8YlR1IqF
 sFNMNdnns33rlvBVrZxV1rsJg04GddPYcmWmvJOQ420XvFpGb+dUnrz3wPQjSH7sbZGx
 GAnA==
X-Gm-Message-State: ABy/qLatRFqYMUF3gqmCRUXm8/q/PLcxRVYlFky+cDjvsoWui4+N1IoC
 D3rDu9tAiG0L3gNig6C0n9KJi2E3eCyUEJ8o2gcjm4Tg/AFXFdf5lTqjx9cslrlzO0fVVji0o8X
 k/1zn1OupyOv+UqM=
X-Received: by 2002:a50:ec94:0:b0:518:7a3b:e9fb with SMTP id
 e20-20020a50ec94000000b005187a3be9fbmr11616363edr.19.1690286622883; 
 Tue, 25 Jul 2023 05:03:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdk+gqjfKQ9tYynNnH5kQ2brv5Z+/A76s73D+wxOtvRHCKNvhe8YPnZ18eRGBUC8hB4jXBZw==
X-Received: by 2002:a50:ec94:0:b0:518:7a3b:e9fb with SMTP id
 e20-20020a50ec94000000b005187a3be9fbmr11616338edr.19.1690286622443; 
 Tue, 25 Jul 2023 05:03:42 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 e21-20020a056402105500b0051e22660835sm7470928edu.46.2023.07.25.05.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:03:41 -0700 (PDT)
Date: Tue, 25 Jul 2023 08:03:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: intel-iommu: Report interrupt remapping faults, fix return value
Message-ID: <20230725080310-mutt-send-email-mst@kernel.org>
References: <d6e586699117542f9aeb3018cd5985834d727b44.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e586699117542f9aeb3018cd5985834d727b44.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 25, 2023 at 11:01:16AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A generic X86IOMMUClass->int_remap function should not return VT-d
> specific values; fix it to return 0 if the interrupt was successfully
> translated or -EINVAL if not.
> 
> The VTD_FR_IR_xxx values are supposed to be used to actually raise
> faults through the fault reporting mechanism, so do that instead for
> the case where the IRQ is actually being injected.
> 
> There is more work to be done here, as pretranslations for the KVM IRQ
> routing table can't fault; an untranslatable IRQ should be handled in
> userspace and the fault raised only when the IRQ actually happens (if
> indeed the IRTE is still not valid at that time). But we can work on
> that later; we can at least raise faults for the direct case.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>


looks like post 8.1 material yes?

> ---
>  hw/i386/intel_iommu.c          | 148 ++++++++++++++++++++++-----------
>  hw/i386/intel_iommu_internal.h |   1 +
>  2 files changed, 102 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dcc334060c..a65a94a4ce 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -469,21 +469,12 @@ static void vtd_set_frcd_and_update_ppf(IntelIOMMUState *s, uint16_t index)
>  
>  /* Must not update F field now, should be done later */
>  static void vtd_record_frcd(IntelIOMMUState *s, uint16_t index,
> -                            uint16_t source_id, hwaddr addr,
> -                            VTDFaultReason fault, bool is_write,
> -                            bool is_pasid, uint32_t pasid)
> +                            uint64_t hi, uint64_t lo)
>  {
> -    uint64_t hi = 0, lo;
>      hwaddr frcd_reg_addr = DMAR_FRCD_REG_OFFSET + (((uint64_t)index) << 4);
>  
>      assert(index < DMAR_FRCD_REG_NR);
>  
> -    lo = VTD_FRCD_FI(addr);
> -    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
> -         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
> -    if (!is_write) {
> -        hi |= VTD_FRCD_T;
> -    }
>      vtd_set_quad_raw(s, frcd_reg_addr, lo);
>      vtd_set_quad_raw(s, frcd_reg_addr + 8, hi);
>  
> @@ -509,17 +500,11 @@ static bool vtd_try_collapse_fault(IntelIOMMUState *s, uint16_t source_id)
>  }
>  
>  /* Log and report an DMAR (address translation) fault to software */
> -static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
> -                                  hwaddr addr, VTDFaultReason fault,
> -                                  bool is_write, bool is_pasid,
> -                                  uint32_t pasid)
> +static void vtd_report_frcd_fault(IntelIOMMUState *s, uint64_t source_id,
> +                                  uint64_t hi, uint64_t lo)
>  {
>      uint32_t fsts_reg = vtd_get_long_raw(s, DMAR_FSTS_REG);
>  
> -    assert(fault < VTD_FR_MAX);
> -
> -    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
> -
>      if (fsts_reg & VTD_FSTS_PFO) {
>          error_report_once("New fault is not recorded due to "
>                            "Primary Fault Overflow");
> @@ -539,8 +524,7 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>          return;
>      }
>  
> -    vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault,
> -                    is_write, is_pasid, pasid);
> +    vtd_record_frcd(s, s->next_frcd_reg, hi, lo);
>  
>      if (fsts_reg & VTD_FSTS_PPF) {
>          error_report_once("There are pending faults already, "
> @@ -565,6 +549,40 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>      }
>  }
>  
> +/* Log and report an DMAR (address translation) fault to software */
> +static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
> +                                  hwaddr addr, VTDFaultReason fault,
> +                                  bool is_write, bool is_pasid,
> +                                  uint32_t pasid)
> +{
> +    uint64_t hi, lo;
> +
> +    assert(fault < VTD_FR_MAX);
> +
> +    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
> +
> +    lo = VTD_FRCD_FI(addr);
> +    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
> +         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
> +    if (!is_write) {
> +        hi |= VTD_FRCD_T;
> +    }
> +
> +    vtd_report_frcd_fault(s, source_id, hi, lo);
> +}
> +
> +
> +static void vtd_report_ir_fault(IntelIOMMUState *s, uint64_t source_id,
> +                                VTDFaultReason fault, uint16_t index)
> +{
> +    uint64_t hi, lo;
> +
> +    lo = VTD_FRCD_IR_IDX(index);
> +    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault);
> +
> +    vtd_report_frcd_fault(s, source_id, hi, lo);
> +}
> +
>  /* Handle Invalidation Queue Errors of queued invalidation interface error
>   * conditions.
>   */
> @@ -3300,8 +3318,9 @@ static Property vtd_properties[] = {
>  };
>  
>  /* Read IRTE entry with specific index */
> -static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
> -                        VTD_IR_TableEntry *entry, uint16_t sid)
> +static bool vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
> +                         VTD_IR_TableEntry *entry, uint16_t sid,
> +                         bool do_fault)
>  {
>      static const uint16_t vtd_svt_mask[VTD_SQ_MAX] = \
>          {0xffff, 0xfffb, 0xfff9, 0xfff8};
> @@ -3312,7 +3331,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>      if (index >= iommu->intr_size) {
>          error_report_once("%s: index too large: ind=0x%x",
>                            __func__, index);
> -        return -VTD_FR_IR_INDEX_OVER;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_INDEX_OVER, index);
> +        }
> +        return false;
>      }
>  
>      addr = iommu->intr_root + index * sizeof(*entry);
> @@ -3320,17 +3342,33 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                          entry, sizeof(*entry), MEMTXATTRS_UNSPECIFIED)) {
>          error_report_once("%s: read failed: ind=0x%x addr=0x%" PRIx64,
>                            __func__, index, addr);
> -        return -VTD_FR_IR_ROOT_INVAL;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ROOT_INVAL, index);
> +        }
> +        return false;
>      }
>  
>      trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
>                            le64_to_cpu(entry->data[0]));
>  
> +	/*
> +	 * The remaining potential fault conditions are "qualified" by the
> +	 * Fault Processing Disable bit in the IRTE. Even "not present".
> +	 * So just clear the do_fault flag if PFD is set, which will
> +	 * prevent faults being raised.
> +	 */
> +	if (entry->irte.fault_disable) {
> +		do_fault = false;
> +    }
> +
>      if (!entry->irte.present) {
>          error_report_once("%s: detected non-present IRTE "
>                            "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
>                            __func__, index, le64_to_cpu(entry->data[1]),
>                            le64_to_cpu(entry->data[0]));
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ENTRY_P, index);
> +        }
>          return -VTD_FR_IR_ENTRY_P;
>      }
>  
> @@ -3340,7 +3378,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                            "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
>                            __func__, index, le64_to_cpu(entry->data[1]),
>                            le64_to_cpu(entry->data[0]));
> -        return -VTD_FR_IR_IRTE_RSVD;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_IRTE_RSVD, index);
> +        }
> +        return false;
>      }
>  
>      if (sid != X86_IOMMU_SID_INVALID) {
> @@ -3356,7 +3397,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                  error_report_once("%s: invalid IRTE SID "
>                                    "(index=%u, sid=%u, source_id=%u)",
>                                    __func__, index, sid, source_id);
> -                return -VTD_FR_IR_SID_ERR;
> +                if (do_fault) {
> +                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
> +                }
> +                return false;
>              }
>              break;
>  
> @@ -3368,7 +3412,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                  error_report_once("%s: invalid SVT_BUS "
>                                    "(index=%u, bus=%u, min=%u, max=%u)",
>                                    __func__, index, bus, bus_min, bus_max);
> -                return -VTD_FR_IR_SID_ERR;
> +                if (do_fault) {
> +                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
> +                }
> +                return false;
>              }
>              break;
>  
> @@ -3377,23 +3424,24 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                                "(index=%u, type=%d)", __func__,
>                                index, entry->irte.sid_vtype);
>              /* Take this as verification failure. */
> -            return -VTD_FR_IR_SID_ERR;
> +            if (do_fault) {
> +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
> +            }
> +            return false;
>          }
>      }
>  
> -    return 0;
> +    return true;
>  }
>  
>  /* Fetch IRQ information of specific IR index */
> -static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
> -                             X86IOMMUIrq *irq, uint16_t sid)
> +static bool vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
> +                              X86IOMMUIrq *irq, uint16_t sid, bool do_fault)
>  {
>      VTD_IR_TableEntry irte = {};
> -    int ret = 0;
>  
> -    ret = vtd_irte_get(iommu, index, &irte, sid);
> -    if (ret) {
> -        return ret;
> +    if (!vtd_irte_get(iommu, index, &irte, sid, do_fault)) {
> +        return false;
>      }
>  
>      irq->trigger_mode = irte.irte.trigger_mode;
> @@ -3412,16 +3460,15 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
>      trace_vtd_ir_remap(index, irq->trigger_mode, irq->vector,
>                         irq->delivery_mode, irq->dest, irq->dest_mode);
>  
> -    return 0;
> +    return true;
>  }
>  
>  /* Interrupt remapping for MSI/MSI-X entry */
>  static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>                                     MSIMessage *origin,
>                                     MSIMessage *translated,
> -                                   uint16_t sid)
> +                                   uint16_t sid, bool do_fault)
>  {
> -    int ret = 0;
>      VTD_IR_MSIAddress addr;
>      uint16_t index;
>      X86IOMMUIrq irq = {};
> @@ -3438,14 +3485,20 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>      if (origin->address & VTD_MSI_ADDR_HI_MASK) {
>          error_report_once("%s: MSI address high 32 bits non-zero detected: "
>                            "address=0x%" PRIx64, __func__, origin->address);
> -        return -VTD_FR_IR_REQ_RSVD;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
> +        }
> +        return -EINVAL;
>      }
>  
>      addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
>      if (addr.addr.__head != 0xfee) {
>          error_report_once("%s: MSI address low 32 bit invalid: 0x%" PRIx32,
>                            __func__, addr.data);
> -        return -VTD_FR_IR_REQ_RSVD;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
> +        }
> +        return -EINVAL;
>      }
>  
>      /* This is compatible mode. */
> @@ -3464,9 +3517,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>          index += origin->data & VTD_IR_MSI_DATA_SUBHANDLE;
>      }
>  
> -    ret = vtd_remap_irq_get(iommu, index, &irq, sid);
> -    if (ret) {
> -        return ret;
> +    if (!vtd_remap_irq_get(iommu, index, &irq, sid, do_fault)) {
> +        return -EINVAL;
>      }
>  
>      if (addr.addr.sub_valid) {
> @@ -3476,7 +3528,10 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>                                "(sid=%u, address=0x%" PRIx64
>                                ", data=0x%" PRIx32 ")",
>                                __func__, sid, origin->address, origin->data);
> -            return -VTD_FR_IR_REQ_RSVD;
> +            if (do_fault) {
> +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
> +            }
> +            return -EINVAL;
>          }
>      } else {
>          uint8_t vector = origin->data & 0xff;
> @@ -3516,7 +3571,7 @@ static int vtd_int_remap(X86IOMMUState *iommu, MSIMessage *src,
>                           MSIMessage *dst, uint16_t sid)
>  {
>      return vtd_interrupt_remap_msi(INTEL_IOMMU_DEVICE(iommu),
> -                                   src, dst, sid);
> +                                   src, dst, sid, false);
>  }
>  
>  static MemTxResult vtd_mem_ir_read(void *opaque, hwaddr addr,
> @@ -3542,9 +3597,8 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
>          sid = attrs.requester_id;
>      }
>  
> -    ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid);
> +    ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid, true);
>      if (ret) {
> -        /* TODO: report error */
>          /* Drop this interrupt */
>          return MEMTX_ERROR;
>      }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2e61eec2f5..eb8087a2cf 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -268,6 +268,7 @@
>  #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>  #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
>  #define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
> +#define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>  
>  /* DMA Remapping Fault Conditions */
>  typedef enum VTDFaultReason {
> -- 
> 2.34.1
> 
> 



