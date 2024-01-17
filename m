Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C79830C1D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:37:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9qM-0005aU-Vv; Wed, 17 Jan 2024 12:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ9qK-0005Zr-8H
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ9qI-0005Ws-I9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705513005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ibv85sixX/MPOn7ZLArYwAi1jLisxtnpYNc/ncBpyw4=;
 b=Pzjcb2O827C6YuDSTrer+rGNUTkaUJtR1DbWd9RmBYjBpIXQ//UdqpPAntwzgNhQDK/N0J
 IX4C8EWKyiopXHIBWKofVBxJO7QKJAirYdhhqstPgXuqL4usyf+MaHJlCWc70U6L8q4Zuk
 l/BlmY6vuRSN1p9BIr/Yvp6RfkcrJ0o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-VeCQ5mA7MnmXZ05XIFPaDQ-1; Wed, 17 Jan 2024 12:36:43 -0500
X-MC-Unique: VeCQ5mA7MnmXZ05XIFPaDQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bb8b66b091so12473477b6e.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705513003; x=1706117803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ibv85sixX/MPOn7ZLArYwAi1jLisxtnpYNc/ncBpyw4=;
 b=IlvvuNUxm3pSUtHO19PccuGA6HwIzTAiigA4GxctRyEFcH+416coqb1Ey6YoghZnI5
 uZSKk+s3z35AYizN01FbK9udq95HM2ZTZj94aaZrpcxgkBSht1e8lHsFrE7KY2uvfxBh
 /iQzRLiyzX+bImVgnYHReT7qNNXeiiKofOaFlbhgozbUJaYM1EpU1EizGFKyaEMulH4d
 OsAaAquhaDhUCKS8ELD2k+GHXWLDT3wwPxYVKu6dTnEL4iiiyQaH0WwbCUPKZMcqhoPY
 wETHiTdvpDUVH5K26RqjW6moNCp1j6XdJApipIe+MPHt9R3qYyTVHk9WitPClJD5fLpi
 0XPQ==
X-Gm-Message-State: AOJu0Yz/t9eMbIkFfNa1sEsAU0P9btj4H5CPk3s2RuI4l7cnIDvTkQrr
 jl7SnJWPCVUI/Q4pWWnLiIMMde19dPpZpBoix97QtvP1fOQhtTgOwyAG4XC8G46xgco9rCQtA3R
 L1jWS0iXWohERESROvrGc7f0=
X-Received: by 2002:a05:6808:ec9:b0:3bd:53e2:7fb with SMTP id
 q9-20020a0568080ec900b003bd53e207fbmr7189612oiv.57.1705513002759; 
 Wed, 17 Jan 2024 09:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHieUnyDJF5vm2Va8OiFOZyGI4PnlAlZVLMH0fm2+LLzoYtcf2aDhy2zDz+Qk2k76E2MPW9gA==
X-Received: by 2002:a05:6808:ec9:b0:3bd:53e2:7fb with SMTP id
 q9-20020a0568080ec900b003bd53e207fbmr7189571oiv.57.1705513001033; 
 Wed, 17 Jan 2024 09:36:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a05620a12ca00b00783148d1269sm4663039qkl.62.2024.01.17.09.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:36:40 -0800 (PST)
Message-ID: <064a2431-05c9-4732-8044-b58f3e2e238d@redhat.com>
Date: Wed, 17 Jan 2024 18:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 5/6] intel_iommu: extract out vtd_cap_init to
 initialize cap/ecap
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 1/15/24 11:13, Zhenzhong Duan wrote:
> This is a prerequisite for host cap/ecap sync.
>
> No functional change intended.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu.c | 92 +++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 42 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 95faf697eb..4c1d058ebd 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4009,30 +4009,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      return;
>  }
>  
> -/* Do the initialization. It will also be called when reset, so pay
> - * attention when adding new initialization stuff.
> - */
> -static void vtd_init(IntelIOMMUState *s)
> +static void vtd_cap_init(IntelIOMMUState *s)
>  {
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>  
> -    memset(s->csr, 0, DMAR_REG_SIZE);
> -    memset(s->wmask, 0, DMAR_REG_SIZE);
> -    memset(s->w1cmask, 0, DMAR_REG_SIZE);
> -    memset(s->womask, 0, DMAR_REG_SIZE);
> -
> -    s->root = 0;
> -    s->root_scalable = false;
> -    s->dmar_enabled = false;
> -    s->intr_enabled = false;
> -    s->iq_head = 0;
> -    s->iq_tail = 0;
> -    s->iq = 0;
> -    s->iq_size = 0;
> -    s->qi_enabled = false;
> -    s->iq_last_desc_type = VTD_INV_DESC_NONE;
> -    s->iq_dw = false;
> -    s->next_frcd_reg = 0;
>      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
>               VTD_CAP_MGAW(s->aw_bits);
> @@ -4049,27 +4029,6 @@ static void vtd_init(IntelIOMMUState *s)
>      }
>      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
>  
> -    /*
> -     * Rsvd field masks for spte
> -     */
> -    vtd_spte_rsvd[0] = ~0ULL;
> -    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> -                                                  x86_iommu->dt_supported);
> -    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> -    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> -
> -    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> -                                                         x86_iommu->dt_supported);
> -    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> -                                                         x86_iommu->dt_supported);
> -
> -    if (s->scalable_mode || s->snoop_control) {
> -        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
> -        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
> -        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
> -    }
> -
>      if (x86_iommu_ir_supported(x86_iommu)) {
>          s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
>          if (s->intr_eim == ON_OFF_AUTO_ON) {
> @@ -4102,7 +4061,56 @@ static void vtd_init(IntelIOMMUState *s)
>      if (s->pasid) {
>          s->ecap |= VTD_ECAP_PASID;
>      }
> +}
> +
> +/*
> + * Do the initialization. It will also be called when reset, so pay
> + * attention when adding new initialization stuff.
> + */
> +static void vtd_init(IntelIOMMUState *s)
> +{
> +    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> +
> +    memset(s->csr, 0, DMAR_REG_SIZE);
> +    memset(s->wmask, 0, DMAR_REG_SIZE);
> +    memset(s->w1cmask, 0, DMAR_REG_SIZE);
> +    memset(s->womask, 0, DMAR_REG_SIZE);
> +
> +    s->root = 0;
> +    s->root_scalable = false;
> +    s->dmar_enabled = false;
> +    s->intr_enabled = false;
> +    s->iq_head = 0;
> +    s->iq_tail = 0;
> +    s->iq = 0;
> +    s->iq_size = 0;
> +    s->qi_enabled = false;
> +    s->iq_last_desc_type = VTD_INV_DESC_NONE;
> +    s->iq_dw = false;
> +    s->next_frcd_reg = 0;
> +
> +    /*
> +     * Rsvd field masks for spte
> +     */
> +    vtd_spte_rsvd[0] = ~0ULL;
> +    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> +                                                  x86_iommu->dt_supported);
> +    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> +    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> +
> +    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> +                                                    x86_iommu->dt_supported);
> +    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> +                                                    x86_iommu->dt_supported);
> +
> +    if (s->scalable_mode || s->snoop_control) {
> +        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
> +        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
> +        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
> +    }
>  
> +    vtd_cap_init(s);
>      vtd_reset_caches(s);
>  
>      /* Define registers with default values and bit semantics */


