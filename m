Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C95BABE3A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Sep 2025 09:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3V3I-0006fE-GE; Tue, 30 Sep 2025 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3V3F-0006f4-0w
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3V36-0004xp-Cw
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218319;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyRjp+iTqRlObiQt/8TCtB2s/jGSO/VuoY5BSJWQUmI=;
 b=fsZLvpCKTavfurX6uKFOOobkVen97Y4otWJ7iOymihnw9w/50Z/DMT18QGMa0szeIZZDOz
 8MZg6U3+YWoUZe7X/pWChJIuiMbDMgsYTNfj+tr4FPse6zXSP1hxrEjUtbyi9gkHDnXWE3
 gbkASaWuqP7lMXTy456NPgqdkdoomTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-fwb2dW94OkOk003Cos0bQg-1; Tue, 30 Sep 2025 03:45:17 -0400
X-MC-Unique: fwb2dW94OkOk003Cos0bQg-1
X-Mimecast-MFC-AGG-ID: fwb2dW94OkOk003Cos0bQg_1759218316
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so3634989f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 00:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759218316; x=1759823116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oyRjp+iTqRlObiQt/8TCtB2s/jGSO/VuoY5BSJWQUmI=;
 b=ltzx3FSR8RvRV++n1HlN681ppzlHU8aO2TJnAag3ukfVZj8g2UKTbnDLeWdQ2KABxW
 2ka2PzMBiyYEjGn1LmUpSfSIR0wdaqnpOu4SPdZIi+CHSWjrEXDonGYsqycAH4jI4KjL
 1EylLldQ1j63OcnHlm6d/PMpdx0aHiDWkW8fy4Mtsb21fAdzxOgnA0ySH45M/+hgt/tn
 L4TGOotoHWJMkdCtSpmUXXcK4VhSro8aGRJj7ZyCXlfiea7AO6C8rO8+PwJkMmp4qdzM
 QuKC/svRHZix3fAhIfiqvye0EqovHEUnZRCVUyHa5Y2teQCussO3E6k/ERtYPK+a+oK5
 ocdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZqKLmtf+NQTPfKlkIgWOkbk6Wu3a4kdjzHy0xHHB7QNQTHVqIZxS43R8meL4xDPKItDHkMC4BR40k@nongnu.org
X-Gm-Message-State: AOJu0YyfUb+SHbHXt+HS8sjL1DxygR+I4Mr1+QcMW3Wyjvj/0o4hluFi
 xLSy2H8rV/lsBwm7tq7S77iAYTkeXUvVejzHtqnjl9WW/9j6e9OP/h8m/W7xhrAlpugixwM2WlL
 4fc9gcvqbMNcTP4EtdsxX6I28tP2YE8Im7Tpu8QvWlugM0vvX5OEcQgHJ
X-Gm-Gg: ASbGncs0OTJ4XirdnbS5SOtdnvqPRSKUOHRyUSZ6q/lxUXWIM2Kti02S3Jc0yDDHkXt
 RcFjPr7xZNjYetQBNAdHunazdklQfjm6CshWt6ioK9cTLL+w2WJJaOrTgreiv10BCMRyOuWliez
 s9qSZhF8d3QLjC3mpnRZh9Lbvj0vrYaCmJGwE5NCyMqZTZc5bsyQUgBJwdHKiFRAZlZdWH1Gvb/
 ccGwbDJGv39gCFzSP+gRxfosv6XHL/cQdo619o5rNCwsLl/37+d4dgpLtLRaoy/uf6EgGDtORsu
 JdUEdSRuLUULw96T0xLbn1tZIllnzTKCl/dcXzdKtyWEGZOPq9q7yhBWrR0NxgWbadLrddibCzu
 INYKrzvR8PY9d46lI
X-Received: by 2002:a05:6000:2010:b0:3ea:5f76:3f72 with SMTP id
 ffacd0b85a97d-40e4b294d86mr15904160f8f.49.1759218315676; 
 Tue, 30 Sep 2025 00:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFykH9isSRp6vH9f3qGcM4EClBzdP3RZZOmqgOWLJUeoWXetL9NV35wFWRobK3YVoipFbbxyQ==
X-Received: by 2002:a05:6000:2010:b0:3ea:5f76:3f72 with SMTP id
 ffacd0b85a97d-40e4b294d86mr15904114f8f.49.1759218314959; 
 Tue, 30 Sep 2025 00:45:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb6b7sm23110719f8f.2.2025.09.30.00.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 00:45:14 -0700 (PDT)
Message-ID: <904187dc-3f3d-4dda-8f73-f799acd8be75@redhat.com>
Date: Tue, 30 Sep 2025 09:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/22] intel_iommu: Update terminology to match VTD spec
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250918085803.796942-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
> VTD spec revision 3.4 released in December 2021 renamed "First-level" to
> "First-stage" and "Second-level" to "Second-stage".
>
> Do the same in intel_iommu code to match spec, change all existing
> "fl/sl/FL/SL/first level/second level/stage-1/stage-2" terminology to
> "fs/ss/FS/SS/first stage/second stage".
>
> No functional changes intended.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu_internal.h |  63 ++++-----
>  include/hw/i386/intel_iommu.h  |   2 +-
>  hw/i386/intel_iommu.c          | 240 +++++++++++++++++----------------
>  tests/qtest/intel-iommu-test.c |   4 +-
>  4 files changed, 156 insertions(+), 153 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 6abe76556a..86b8bfc71f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,8 +195,8 @@
>  #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
>  #define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
> -#define VTD_ECAP_SLTS               (1ULL << 46)
> -#define VTD_ECAP_FLTS               (1ULL << 47)
> +#define VTD_ECAP_SSTS               (1ULL << 46)
> +#define VTD_ECAP_FSTS               (1ULL << 47)
>  
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> @@ -210,7 +210,7 @@
>  #define VTD_MAMV                    18ULL
>  #define VTD_CAP_MAMV                (VTD_MAMV << 48)
>  #define VTD_CAP_PSI                 (1ULL << 39)
> -#define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
> +#define VTD_CAP_SSLPS               ((1ULL << 34) | (1ULL << 35))
>  #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
>  #define VTD_CAP_DRAIN_READ          (1ULL << 55)
>  #define VTD_CAP_FS1GP               (1ULL << 56)
> @@ -282,7 +282,7 @@ typedef enum VTDFaultReason {
>      VTD_FR_ADDR_BEYOND_MGAW,    /* Input-address above (2^x-1) */
>      VTD_FR_WRITE,               /* No write permission */
>      VTD_FR_READ,                /* No read permission */
> -    /* Fail to access a second-level paging entry (not SL_PML4E) */
> +    /* Fail to access a second-stage paging entry (not SS_PML4E) */
>      VTD_FR_PAGING_ENTRY_INV,
>      VTD_FR_ROOT_TABLE_INV,      /* Fail to access a root-entry */
>      VTD_FR_CONTEXT_TABLE_INV,   /* Fail to access a context-entry */
> @@ -290,7 +290,8 @@ typedef enum VTDFaultReason {
>      VTD_FR_ROOT_ENTRY_RSVD,
>      /* Non-zero reserved field in a present context-entry */
>      VTD_FR_CONTEXT_ENTRY_RSVD,
> -    /* Non-zero reserved field in a second-level paging entry with at lease one
> +    /*
> +     * Non-zero reserved field in a second-stage paging entry with at lease one
>       * Read(R) and Write(W) or Execute(E) field is Set.
>       */
>      VTD_FR_PAGING_ENTRY_RSVD,
> @@ -323,7 +324,7 @@ typedef enum VTDFaultReason {
>      VTD_FR_PASID_ENTRY_P = 0x59,
>      VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
>  
> -    /* Fail to access a first-level paging entry (not FS_PML4E) */
> +    /* Fail to access a first-stage paging entry (not FS_PML4E) */
>      VTD_FR_FS_PAGING_ENTRY_INV = 0x70,
>      VTD_FR_FS_PAGING_ENTRY_P = 0x71,
>      /* Non-zero reserved field in present first-stage paging entry */
> @@ -445,23 +446,23 @@ typedef union VTDInvDesc VTDInvDesc;
>  
>  #define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, stale_tm) \
>          stale_tm ? \
> -        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
> -        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM | VTD_SS_TM)) : \
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
> -        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  #define VTD_SPTE_PAGE_L3_RSVD_MASK(aw) \
> -        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
> -        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  
>  #define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, stale_tm) \
>          stale_tm ? \
> -        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
> -        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM | VTD_SS_TM)) : \
> +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, stale_tm) \
>          stale_tm ? \
> -        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
> -        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM | VTD_SS_TM)) : \
> +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SS_IGN_COM))
>  
>  /* Rsvd field masks for fpte */
>  #define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
> @@ -535,7 +536,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CONTEXT_TT_DEV_IOTLB    (1ULL << 2)
>  #define VTD_CONTEXT_TT_PASS_THROUGH (2ULL << 2)
>  /* Second Level Page Translation Pointer*/
> -#define VTD_CONTEXT_ENTRY_SLPTPTR   (~0xfffULL)
> +#define VTD_CONTEXT_ENTRY_SSPTPTR   (~0xfffULL)
>  #define VTD_CONTEXT_ENTRY_RSVD_LO(aw) (0xff0ULL | ~VTD_HAW_MASK(aw))
>  /* hi */
>  #define VTD_CONTEXT_ENTRY_AW        7ULL /* Adjusted guest-address-width */
> @@ -565,35 +566,35 @@ typedef struct VTDRootEntry VTDRootEntry;
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
>  #define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
> -#define VTD_SM_PASID_ENTRY_FLT         (1ULL << 6)
> -#define VTD_SM_PASID_ENTRY_SLT         (2ULL << 6)
> +#define VTD_SM_PASID_ENTRY_FST         (1ULL << 6)
> +#define VTD_SM_PASID_ENTRY_SST         (2ULL << 6)
>  #define VTD_SM_PASID_ENTRY_NESTED      (3ULL << 6)
>  #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>  
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>  #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
>  
> -#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> -#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_FSPM          3ULL
> +#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
>  
>  /* First Level Paging Structure */
>  /* Masks for First Level Paging Entry */
> -#define VTD_FL_P                    1ULL
> -#define VTD_FL_RW                   (1ULL << 1)
> -#define VTD_FL_US                   (1ULL << 2)
> -#define VTD_FL_A                    (1ULL << 5)
> -#define VTD_FL_D                    (1ULL << 6)
> +#define VTD_FS_P                    1ULL
> +#define VTD_FS_RW                   (1ULL << 1)
> +#define VTD_FS_US                   (1ULL << 2)
> +#define VTD_FS_A                    (1ULL << 5)
> +#define VTD_FS_D                    (1ULL << 6)
>  
>  /* Second Level Page Translation Pointer*/
> -#define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SSPTPTR     (~0xfffULL)
>  
>  /* Second Level Paging Structure */
>  /* Masks for Second Level Paging Entry */
> -#define VTD_SL_RW_MASK              3ULL
> -#define VTD_SL_R                    1ULL
> -#define VTD_SL_W                    (1ULL << 1)
> -#define VTD_SL_IGN_COM              0xbff0000000000000ULL
> -#define VTD_SL_TM                   (1ULL << 62)
> +#define VTD_SS_RW_MASK              3ULL
> +#define VTD_SS_R                    1ULL
> +#define VTD_SS_W                    (1ULL << 1)
> +#define VTD_SS_IGN_COM              0xbff0000000000000ULL
> +#define VTD_SS_TM                   (1ULL << 62)
>  
>  /* Common for both First Level and Second Level */
>  #define VTD_PML4_LEVEL           4
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e95477e855..564d4d4236 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -264,7 +264,7 @@ struct IntelIOMMUState {
>  
>      bool caching_mode;              /* RO - is cap CM enabled? */
>      bool scalable_mode;             /* RO - is Scalable Mode supported? */
> -    bool flts;                      /* RO - is stage-1 translation supported? */
> +    bool fsts;                      /* RO - is first stage translation supported? */
>      bool snoop_control;             /* RO - is SNP filed supported? */
>  
>      dma_addr_t root;                /* Current root table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b976b251bc..a47482ba9d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -47,9 +47,9 @@
>  
>  /* pe operations */
>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FL_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
> -#define VTD_PE_GET_SL_LEVEL(pe) \
> +#define VTD_PE_GET_FS_LEVEL(pe) \
> +    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
> +#define VTD_PE_GET_SS_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>  
>  /*
> @@ -319,7 +319,7 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
>       * nested (PGTT=011b) mapping associated with specified domain-id are
>       * invalidated. Nested isn't supported yet, so only need to check 001b.
>       */
> -    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
> +    if (entry->pgtt == VTD_SM_PASID_ENTRY_FST) {
>          return true;
>      }
>  
> @@ -340,7 +340,7 @@ static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer value,
>       * or pass-through (PGTT=100b) mappings. Nested isn't supported yet,
>       * so only need to check first-stage (PGTT=001b) mappings.
>       */
> -    if (entry->pgtt != VTD_SM_PASID_ENTRY_FLT) {
> +    if (entry->pgtt != VTD_SM_PASID_ENTRY_FST) {
>          return false;
>      }
>  
> @@ -747,9 +747,9 @@ static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
> +static inline dma_addr_t vtd_ce_get_sspt_base(VTDContextEntry *ce)
>  {
> -    return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
> +    return ce->lo & VTD_CONTEXT_ENTRY_SSPTPTR;
>  }
>  
>  static inline uint64_t vtd_get_pte_addr(uint64_t pte, uint8_t aw)
> @@ -790,13 +790,13 @@ static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t level)
>  }
>  
>  /* Check Capability Register to see if the @level of page-table is supported */
> -static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
> +static inline bool vtd_is_ss_level_supported(IntelIOMMUState *s, uint32_t level)
>  {
>      return VTD_CAP_SAGAW_MASK & s->cap &
>             (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
>  }
>  
> -static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
> +static inline bool vtd_is_fs_level_supported(IntelIOMMUState *s, uint32_t level)
>  {
>      return level == VTD_PML4_LEVEL;
>  }
> @@ -805,10 +805,10 @@ static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
>  static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>  {
>      switch (VTD_PE_GET_TYPE(pe)) {
> -    case VTD_SM_PASID_ENTRY_FLT:
> -        return !!(s->ecap & VTD_ECAP_FLTS);
> -    case VTD_SM_PASID_ENTRY_SLT:
> -        return !!(s->ecap & VTD_ECAP_SLTS);
> +    case VTD_SM_PASID_ENTRY_FST:
> +        return !!(s->ecap & VTD_ECAP_FSTS);
> +    case VTD_SM_PASID_ENTRY_SST:
> +        return !!(s->ecap & VTD_ECAP_SSTS);
>      case VTD_SM_PASID_ENTRY_NESTED:
>          /* Not support NESTED page table type yet */
>          return false;
> @@ -880,13 +880,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>      }
>  
>      pgtt = VTD_PE_GET_TYPE(pe);
> -    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
> -        !vtd_is_sl_level_supported(s, VTD_PE_GET_SL_LEVEL(pe))) {
> +    if (pgtt == VTD_SM_PASID_ENTRY_SST &&
> +        !vtd_is_ss_level_supported(s, VTD_PE_GET_SS_LEVEL(pe))) {
>              return -VTD_FR_PASID_TABLE_ENTRY_INV;
>      }
>  
> -    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
> -        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
> +    if (pgtt == VTD_SM_PASID_ENTRY_FST &&
> +        !vtd_is_fs_level_supported(s, VTD_PE_GET_FS_LEVEL(pe))) {
>              return -VTD_FR_PASID_TABLE_ENTRY_INV;
>      }
>  
> @@ -1007,7 +1007,8 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -/* Get the page-table level that hardware should use for the second-level
> +/*
> + * Get the page-table level that hardware should use for the second-stage
>   * page-table walk from the Address Width field of context-entry.
>   */
>  static inline uint32_t vtd_ce_get_level(VTDContextEntry *ce)
> @@ -1023,10 +1024,10 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>  
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        if (s->flts) {
> -            return VTD_PE_GET_FL_LEVEL(&pe);
> +        if (s->fsts) {
> +            return VTD_PE_GET_FS_LEVEL(&pe);
>          } else {
> -            return VTD_PE_GET_SL_LEVEL(&pe);
> +            return VTD_PE_GET_SS_LEVEL(&pe);
>          }
>      }
>  
> @@ -1095,7 +1096,7 @@ static inline uint64_t vtd_iova_limit(IntelIOMMUState *s,
>  }
>  
>  /* Return true if IOVA passes range check, otherwise false. */
> -static inline bool vtd_iova_sl_range_check(IntelIOMMUState *s,
> +static inline bool vtd_iova_ss_range_check(IntelIOMMUState *s,
>                                             uint64_t iova, VTDContextEntry *ce,
>                                             uint8_t aw, uint32_t pasid)
>  {
> @@ -1114,14 +1115,14 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>  
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        if (s->flts) {
> -            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +        if (s->fsts) {
> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
>          } else {
> -            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
> +            return pe.val[0] & VTD_SM_PASID_ENTRY_SSPTPTR;
>          }
>      }
>  
> -    return vtd_ce_get_slpt_base(ce);
> +    return vtd_ce_get_sspt_base(ce);
>  }
>  
>  /*
> @@ -1136,13 +1137,13 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>  static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
>  static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
>  
> -static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
> +static bool vtd_sspte_nonzero_rsvd(uint64_t sspte, uint32_t level)
>  {
>      uint64_t rsvd_mask;
>  
>      /*
>       * We should have caught a guest-mis-programmed level earlier,
> -     * via vtd_is_sl_level_supported.
> +     * via vtd_is_ss_level_supported.
>       */
>      assert(level < VTD_SPTE_RSVD_LEN);
>      /*
> @@ -1152,46 +1153,47 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>      assert(level);
>  
>      if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
> -        (slpte & VTD_PT_PAGE_SIZE_MASK)) {
> +        (sspte & VTD_PT_PAGE_SIZE_MASK)) {
>          /* large page */
>          rsvd_mask = vtd_spte_rsvd_large[level];
>      } else {
>          rsvd_mask = vtd_spte_rsvd[level];
>      }
>  
> -    return slpte & rsvd_mask;
> +    return sspte & rsvd_mask;
>  }
>  
> -/* Given the @iova, get relevant @slptep. @slpte_level will be the last level
> +/*
> + * Given the @iova, get relevant @ssptep. @sspte_level will be the last level
>   * of the translation, can be used for deciding the size of large page.
>   */
> -static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
> +static int vtd_iova_to_sspte(IntelIOMMUState *s, VTDContextEntry *ce,
>                               uint64_t iova, bool is_write,
> -                             uint64_t *slptep, uint32_t *slpte_level,
> +                             uint64_t *ssptep, uint32_t *sspte_level,
>                               bool *reads, bool *writes, uint8_t aw_bits,
>                               uint32_t pasid)
>  {
>      dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>      uint32_t level = vtd_get_iova_level(s, ce, pasid);
>      uint32_t offset;
> -    uint64_t slpte;
> +    uint64_t sspte;
>      uint64_t access_right_check;
>  
> -    if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
> +    if (!vtd_iova_ss_range_check(s, iova, ce, aw_bits, pasid)) {
>          error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
>                            "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
>          return -VTD_FR_ADDR_BEYOND_MGAW;
>      }
>  
>      /* FIXME: what is the Atomics request here? */
> -    access_right_check = is_write ? VTD_SL_W : VTD_SL_R;
> +    access_right_check = is_write ? VTD_SS_W : VTD_SS_R;
>  
>      while (true) {
>          offset = vtd_iova_level_offset(iova, level);
> -        slpte = vtd_get_pte(addr, offset);
> +        sspte = vtd_get_pte(addr, offset);
>  
> -        if (slpte == (uint64_t)-1) {
> -            error_report_once("%s: detected read error on DMAR slpte "
> +        if (sspte == (uint64_t)-1) {
> +            error_report_once("%s: detected read error on DMAR sspte "
>                                "(iova=0x%" PRIx64 ", pasid=0x%" PRIx32 ")",
>                                __func__, iova, pasid);
>              if (level == vtd_get_iova_level(s, ce, pasid)) {
> @@ -1201,30 +1203,30 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>                  return -VTD_FR_PAGING_ENTRY_INV;
>              }
>          }
> -        *reads = (*reads) && (slpte & VTD_SL_R);
> -        *writes = (*writes) && (slpte & VTD_SL_W);
> -        if (!(slpte & access_right_check)) {
> -            error_report_once("%s: detected slpte permission error "
> +        *reads = (*reads) && (sspte & VTD_SS_R);
> +        *writes = (*writes) && (sspte & VTD_SS_W);
> +        if (!(sspte & access_right_check)) {
> +            error_report_once("%s: detected sspte permission error "
>                                "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
> -                              "slpte=0x%" PRIx64 ", write=%d, pasid=0x%"
> +                              "sspte=0x%" PRIx64 ", write=%d, pasid=0x%"
>                                PRIx32 ")", __func__, iova, level,
> -                              slpte, is_write, pasid);
> +                              sspte, is_write, pasid);
>              return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
>          }
> -        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> +        if (vtd_sspte_nonzero_rsvd(sspte, level)) {
>              error_report_once("%s: detected splte reserve non-zero "
>                                "iova=0x%" PRIx64 ", level=0x%" PRIx32
> -                              "slpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> -                              __func__, iova, level, slpte, pasid);
> +                              "sspte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> +                              __func__, iova, level, sspte, pasid);
>              return -VTD_FR_PAGING_ENTRY_RSVD;
>          }
>  
> -        if (vtd_is_last_pte(slpte, level)) {
> -            *slptep = slpte;
> -            *slpte_level = level;
> +        if (vtd_is_last_pte(sspte, level)) {
> +            *ssptep = sspte;
> +            *sspte_level = level;
>              break;
>          }
> -        addr = vtd_get_pte_addr(slpte, aw_bits);
> +        addr = vtd_get_pte_addr(sspte, aw_bits);
>          level--;
>      }
>  
> @@ -1350,7 +1352,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>  {
>      bool read_cur, write_cur, entry_valid;
>      uint32_t offset;
> -    uint64_t slpte;
> +    uint64_t sspte;
>      uint64_t subpage_size, subpage_mask;
>      IOMMUTLBEvent event;
>      uint64_t iova = start;
> @@ -1366,21 +1368,21 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>          iova_next = (iova & subpage_mask) + subpage_size;
>  
>          offset = vtd_iova_level_offset(iova, level);
> -        slpte = vtd_get_pte(addr, offset);
> +        sspte = vtd_get_pte(addr, offset);
>  
> -        if (slpte == (uint64_t)-1) {
> +        if (sspte == (uint64_t)-1) {
>              trace_vtd_page_walk_skip_read(iova, iova_next);
>              goto next;
>          }
>  
> -        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> +        if (vtd_sspte_nonzero_rsvd(sspte, level)) {
>              trace_vtd_page_walk_skip_reserve(iova, iova_next);
>              goto next;
>          }
>  
>          /* Permissions are stacked with parents' */
> -        read_cur = read && (slpte & VTD_SL_R);
> -        write_cur = write && (slpte & VTD_SL_W);
> +        read_cur = read && (sspte & VTD_SS_R);
> +        write_cur = write && (sspte & VTD_SS_W);
>  
>          /*
>           * As long as we have either read/write permission, this is a
> @@ -1389,12 +1391,12 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>           */
>          entry_valid = read_cur | write_cur;
>  
> -        if (!vtd_is_last_pte(slpte, level) && entry_valid) {
> +        if (!vtd_is_last_pte(sspte, level) && entry_valid) {
>              /*
>               * This is a valid PDE (or even bigger than PDE).  We need
>               * to walk one further level.
>               */
> -            ret = vtd_page_walk_level(vtd_get_pte_addr(slpte, info->aw),
> +            ret = vtd_page_walk_level(vtd_get_pte_addr(sspte, info->aw),
>                                        iova, MIN(iova_next, end), level - 1,
>                                        read_cur, write_cur, info);
>          } else {
> @@ -1411,7 +1413,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>              event.entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
>              event.entry.addr_mask = ~subpage_mask;
>              /* NOTE: this is only meaningful if entry_valid == true */
> -            event.entry.translated_addr = vtd_get_pte_addr(slpte, info->aw);
> +            event.entry.translated_addr = vtd_get_pte_addr(sspte, info->aw);
>              event.type = event.entry.perm ? IOMMU_NOTIFIER_MAP :
>                                              IOMMU_NOTIFIER_UNMAP;
>              ret = vtd_page_walk_one(&event, info);
> @@ -1445,11 +1447,11 @@ static int vtd_page_walk(IntelIOMMUState *s, VTDContextEntry *ce,
>      dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>      uint32_t level = vtd_get_iova_level(s, ce, pasid);
>  
> -    if (!vtd_iova_sl_range_check(s, start, ce, info->aw, pasid)) {
> +    if (!vtd_iova_ss_range_check(s, start, ce, info->aw, pasid)) {
>          return -VTD_FR_ADDR_BEYOND_MGAW;
>      }
>  
> -    if (!vtd_iova_sl_range_check(s, end, ce, info->aw, pasid)) {
> +    if (!vtd_iova_ss_range_check(s, end, ce, info->aw, pasid)) {
>          /* Fix end so that it reaches the maximum */
>          end = vtd_iova_limit(s, ce, info->aw, pasid);
>      }
> @@ -1563,7 +1565,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>  
>      /* Check if the programming of context-entry is valid */
>      if (!s->root_scalable &&
> -        !vtd_is_sl_level_supported(s, vtd_ce_get_level(ce))) {
> +        !vtd_is_ss_level_supported(s, vtd_ce_get_level(ce))) {
>          error_report_once("%s: invalid context entry: hi=%"PRIx64
>                            ", lo=%"PRIx64" (level %d not supported)",
>                            __func__, ce->hi, ce->lo,
> @@ -1670,10 +1672,9 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
>  }
>  
>  /*
> - * Check if specific device is configured to bypass address
> - * translation for DMA requests. In Scalable Mode, bypass
> - * 1st-level translation or 2nd-level translation, it depends
> - * on PGTT setting.
> + * Check if specific device is configured to bypass address translation
> + * for DMA requests. In Scalable Mode, bypass first stage translation
> + * or second stage translation, it depends on PGTT setting.
>   */
>  static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>                                 uint32_t pasid)
> @@ -1910,13 +1911,13 @@ out:
>  static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
>  static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
>  
> -static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
> +static bool vtd_fspte_nonzero_rsvd(uint64_t fspte, uint32_t level)
>  {
>      uint64_t rsvd_mask;
>  
>      /*
>       * We should have caught a guest-mis-programmed level earlier,
> -     * via vtd_is_fl_level_supported.
> +     * via vtd_is_fs_level_supported.
>       */
>      assert(level < VTD_FPTE_RSVD_LEN);
>      /*
> @@ -1926,23 +1927,23 @@ static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
>      assert(level);
>  
>      if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
> -        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
> +        (fspte & VTD_PT_PAGE_SIZE_MASK)) {
>          /* large page */
>          rsvd_mask = vtd_fpte_rsvd_large[level];
>      } else {
>          rsvd_mask = vtd_fpte_rsvd[level];
>      }
>  
> -    return flpte & rsvd_mask;
> +    return fspte & rsvd_mask;
>  }
>  
> -static inline bool vtd_flpte_present(uint64_t flpte)
> +static inline bool vtd_fspte_present(uint64_t fspte)
>  {
> -    return !!(flpte & VTD_FL_P);
> +    return !!(fspte & VTD_FS_P);
>  }
>  
>  /* Return true if IOVA is canonical, otherwise false. */
> -static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
> +static bool vtd_iova_fs_check_canonical(IntelIOMMUState *s, uint64_t iova,
>                                          VTDContextEntry *ce, uint32_t pasid)
>  {
>      uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
> @@ -1972,32 +1973,32 @@ static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
>  }
>  
>  /*
> - * Given the @iova, get relevant @flptep. @flpte_level will be the last level
> + * Given the @iova, get relevant @fsptep. @fspte_level will be the last level
>   * of the translation, can be used for deciding the size of large page.
>   */
> -static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
> +static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
>                               uint64_t iova, bool is_write,
> -                             uint64_t *flptep, uint32_t *flpte_level,
> +                             uint64_t *fsptep, uint32_t *fspte_level,
>                               bool *reads, bool *writes, uint8_t aw_bits,
>                               uint32_t pasid)
>  {
>      dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>      uint32_t offset;
> -    uint64_t flpte, flag_ad = VTD_FL_A;
> -    *flpte_level = vtd_get_iova_level(s, ce, pasid);
> +    uint64_t fspte, flag_ad = VTD_FS_A;
> +    *fspte_level = vtd_get_iova_level(s, ce, pasid);
>  
> -    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
> +    if (!vtd_iova_fs_check_canonical(s, iova, ce, pasid)) {
>          error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
>                            "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
>          return -VTD_FR_FS_NON_CANONICAL;
>      }
>  
>      while (true) {
> -        offset = vtd_iova_level_offset(iova, *flpte_level);
> -        flpte = vtd_get_pte(addr, offset);
> +        offset = vtd_iova_level_offset(iova, *fspte_level);
> +        fspte = vtd_get_pte(addr, offset);
>  
> -        if (flpte == (uint64_t)-1) {
> -            if (*flpte_level == vtd_get_iova_level(s, ce, pasid)) {
> +        if (fspte == (uint64_t)-1) {
> +            if (*fspte_level == vtd_get_iova_level(s, ce, pasid)) {
>                  /* Invalid programming of pasid-entry */
>                  return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
>              } else {
> @@ -2005,47 +2006,47 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>              }
>          }
>  
> -        if (!vtd_flpte_present(flpte)) {
> +        if (!vtd_fspte_present(fspte)) {
>              *reads = false;
>              *writes = false;
>              return -VTD_FR_FS_PAGING_ENTRY_P;
>          }
>  
>          /* No emulated device supports supervisor privilege request yet */
> -        if (!(flpte & VTD_FL_US)) {
> +        if (!(fspte & VTD_FS_US)) {
>              *reads = false;
>              *writes = false;
>              return -VTD_FR_FS_PAGING_ENTRY_US;
>          }
>  
>          *reads = true;
> -        *writes = (*writes) && (flpte & VTD_FL_RW);
> -        if (is_write && !(flpte & VTD_FL_RW)) {
> +        *writes = (*writes) && (fspte & VTD_FS_RW);
> +        if (is_write && !(fspte & VTD_FS_RW)) {
>              return -VTD_FR_SM_WRITE;
>          }
> -        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
> -            error_report_once("%s: detected flpte reserved non-zero "
> +        if (vtd_fspte_nonzero_rsvd(fspte, *fspte_level)) {
> +            error_report_once("%s: detected fspte reserved non-zero "
>                                "iova=0x%" PRIx64 ", level=0x%" PRIx32
> -                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> -                              __func__, iova, *flpte_level, flpte, pasid);
> +                              "fspte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> +                              __func__, iova, *fspte_level, fspte, pasid);
>              return -VTD_FR_FS_PAGING_ENTRY_RSVD;
>          }
>  
> -        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
> -            flag_ad |= VTD_FL_D;
> +        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
> +            flag_ad |= VTD_FS_D;
>          }
>  
> -        if (vtd_set_flag_in_pte(addr, offset, flpte, flag_ad) != MEMTX_OK) {
> +        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) != MEMTX_OK) {
>              return -VTD_FR_FS_BIT_UPDATE_FAILED;
>          }
>  
> -        if (vtd_is_last_pte(flpte, *flpte_level)) {
> -            *flptep = flpte;
> +        if (vtd_is_last_pte(fspte, *fspte_level)) {
> +            *fsptep = fspte;
>              return 0;
>          }
>  
> -        addr = vtd_get_pte_addr(flpte, aw_bits);
> -        (*flpte_level)--;
> +        addr = vtd_get_pte_addr(fspte, aw_bits);
> +        (*fspte_level)--;
>      }
>  }
>  
> @@ -2199,14 +2200,14 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          }
>      }
>  
> -    if (s->flts && s->root_scalable) {
> -        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
> +    if (s->fsts && s->root_scalable) {
> +        ret_fr = vtd_iova_to_fspte(s, &ce, addr, is_write, &pte, &level,
>                                     &reads, &writes, s->aw_bits, pasid);
> -        pgtt = VTD_SM_PASID_ENTRY_FLT;
> +        pgtt = VTD_SM_PASID_ENTRY_FST;
>      } else {
> -        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
> +        ret_fr = vtd_iova_to_sspte(s, &ce, addr, is_write, &pte, &level,
>                                     &reads, &writes, s->aw_bits, pasid);
> -        pgtt = VTD_SM_PASID_ENTRY_SLT;
> +        pgtt = VTD_SM_PASID_ENTRY_SST;
>      }
>      if (!ret_fr) {
>          xlat = vtd_get_pte_addr(pte, s->aw_bits);
> @@ -2474,13 +2475,13 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>  
>              if (vtd_as_has_map_notifier(vtd_as)) {
>                  /*
> -                 * When stage-1 translation is off, as long as we have MAP
> +                 * When first stage translation is off, as long as we have MAP
>                   * notifications registered in any of our IOMMU notifiers,
>                   * we need to sync the shadow page table. Otherwise VFIO
>                   * device attaches to nested page table instead of shadow
>                   * page table, so no need to sync.
>                   */
> -                if (!s->flts || !s->root_scalable) {
> +                if (!s->fsts || !s->root_scalable) {
>                      vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
>                  }
>              } else {
> @@ -2972,7 +2973,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                  continue;
>              }
>  
> -            if (!s->flts || !vtd_as_has_map_notifier(vtd_as)) {
> +            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
>                  vtd_address_space_sync(vtd_as);
>              }
>          }
> @@ -3818,7 +3819,7 @@ static const Property vtd_properties[] = {
>                        VTD_HOST_ADDRESS_WIDTH),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> -    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, flts, FALSE),
> +    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
>      DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> @@ -4344,12 +4345,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return false;
>      }
>  
> -    if (!s->flts) {
> -        /* All checks requested by VTD stage-2 translation pass */
> +    if (!s->fsts) {
> +        /* All checks requested by VTD second stage translation pass */
>          return true;
>      }
>  
> -    error_setg(errp, "host device is uncompatible with stage-1 translation");
> +    error_setg(errp,
> +               "host device is uncompatible with first stage translation");
>      return false;
>  }
>  
> @@ -4535,7 +4537,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>  
>      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> -             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
> +             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS |
>               VTD_CAP_MGAW(s->aw_bits);
>      if (s->dma_drain) {
>          s->cap |= VTD_CAP_DRAIN;
> @@ -4571,13 +4573,13 @@ static void vtd_cap_init(IntelIOMMUState *s)
>      }
>  
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. */
> -    if (s->flts) {
> -        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> +    if (s->fsts) {
> +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FSTS;
>          if (s->fs1gp) {
>              s->cap |= VTD_CAP_FS1GP;
>          }
>      } else if (s->scalable_mode) {
> -        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SSTS;
>      }
>  
>      if (s->snoop_control) {
> @@ -4864,12 +4866,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>          }
>      }
>  
> -    if (!s->scalable_mode && s->flts) {
> +    if (!s->scalable_mode && s->fsts) {
>          error_setg(errp, "x-flts is only available in scalable mode");
>          return false;
>      }
>  
> -    if (!s->flts && s->aw_bits != VTD_HOST_AW_39BIT &&
> +    if (!s->fsts && s->aw_bits != VTD_HOST_AW_39BIT &&
>          s->aw_bits != VTD_HOST_AW_48BIT) {
>          error_setg(errp, "%s: supported values for aw-bits are: %d, %d",
>                     s->scalable_mode ? "Scalable mode(flts=off)" : "Legacy mode",
> @@ -4877,7 +4879,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>          return false;
>      }
>  
> -    if (s->flts && s->aw_bits != VTD_HOST_AW_48BIT) {
> +    if (s->fsts && s->aw_bits != VTD_HOST_AW_48BIT) {
>          error_setg(errp,
>                     "Scalable mode(flts=on): supported value for aw-bits is: %d",
>                     VTD_HOST_AW_48BIT);
> diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
> index c521b3796e..e5cc6acaf0 100644
> --- a/tests/qtest/intel-iommu-test.c
> +++ b/tests/qtest/intel-iommu-test.c
> @@ -13,9 +13,9 @@
>  #include "hw/i386/intel_iommu_internal.h"
>  
>  #define CAP_STAGE_1_FIXED1    (VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | \
> -                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS)
> +                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS)
>  #define ECAP_STAGE_1_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
> -                              VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FLTS)
> +                              VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FSTS)
>  
>  static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
>  {


