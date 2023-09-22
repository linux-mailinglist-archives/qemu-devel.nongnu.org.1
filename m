Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6147AAF97
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdUp-00011H-85; Fri, 22 Sep 2023 06:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qjdUm-0000yW-3Z
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:34:48 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qjdUk-0000UB-89
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:34:47 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-502f29ed596so4060e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695378884; x=1695983684; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JrXlyzBdUtKbxgWkhgJFQhQT9nuoQ/EezD2z6dPOrrM=;
 b=PAKE9oumlNq4xn+u39nQK/MAKNN+QBc25GLjlMqIjtPjkOWj7OyyjcyeKPO2WV4EVT
 VtMarDzhi/qe8FNpPLur+u/37V6VnbjP7knb8hiu5OZFbDh6x5t041rBR8RYgP4PLWHv
 OjhbCe0IPFqwb/31of3R8c9z5tUz5ZO8zLgsKnsFZ0NeH01cT9z2NX2s6y46LbCyxFBQ
 incl3Q1mVCyuBHfRk/Nt0+MMMmeTBFL0p4O4py3p1xl3w1Wz3wA5WJsLsrblZhQZPZHP
 X7fJxZx+gD7/Usp26nzxSNnZe/FeuBa3QS5qqu0MiJ0hQtyagVrahL/4pWEaU4bw+5jJ
 hNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378884; x=1695983684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrXlyzBdUtKbxgWkhgJFQhQT9nuoQ/EezD2z6dPOrrM=;
 b=LTDzGEAhtVXsVKmUxpQUBu31POskavxXzM9MrFgs4lR6zeVbF/ICBmUotYMEQaY1mS
 0yliy4AOp+JRjd853s5xUA2jmTvNCPQfujfZhtOCmeuZ59w5CbTBvmcCLZF+TSkGJkn0
 sLQsIjopUUkbetWSn+oj3KDc3XHvptnNYg9yvymf0Ghudyd634Nm+AM84p4Nl16GywLQ
 Qa2RuMy+DhEavvh8LTiCmEWsMR6wUWFvU2ngjFvRrAJfcbXFopyQ5npxV9iUsE97lkMS
 n9JPhBcZaXPSJiL0PoLjFH5Cd6oW5qH8e7mf2lLoqNFwx17FXyQMHxLUPAir+oVH60ng
 NUQQ==
X-Gm-Message-State: AOJu0YzRGBQhReVjvf078WcJBR0qp9kou0A32++k7kRq6nSxetr7guuA
 9nyHN27Y1JJmHnEjtcKSWGjwsA==
X-Google-Smtp-Source: AGHT+IFRErkmrwaLSRLPUNP4X2IpEZOmEdYj+6fOuB5r0Fs5lRQGaNkS0wBuXzG60B/+muDUyqNBXA==
X-Received: by 2002:ac2:4c22:0:b0:501:3d3:cbc0 with SMTP id
 u2-20020ac24c22000000b0050103d3cbc0mr44865lfq.2.1695378883725; 
 Fri, 22 Sep 2023 03:34:43 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com.
 [104.199.75.203]) by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b003142e438e8csm4095665wrt.26.2023.09.22.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:34:43 -0700 (PDT)
Date: Fri, 22 Sep 2023 10:34:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
Message-ID: <ZQ1tvgUOLga21EkF@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
 <20230914145705.1648377-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914145705.1648377-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=smostafa@google.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter,

On Thu, Sep 14, 2023 at 03:57:05PM +0100, Peter Maydell wrote:
> The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
> supported, so we should theoretically have implemented it as part of
> the recent S2P work.  Fortunately, for us the implementation is a
> no-op.
> 
> This feature is about interpretation of the stage 2 page table
> descriptor XN bits, which control execute permissions.
> 
> For QEMU, the permission bits passed to an IOMMU (via MemTxAttrs and
> IOMMUAccessFlags) only indicate read and write; we do not distinguish
> data reads from instruction reads outside the CPU proper.  In the
> SMMU architecture's terms, our interconnect between the client device
> and the SMMU doesn't have the ability to convey the INST attribute,
> and we therefore use the default value of "data" for this attribute.
> 
> We also do not support the bits in the Stream Table Entry that can
> override the on-the-bus transaction attribute permissions (we do not
> set SMMU_IDR1.ATTR_PERMS_OVR=1).
> 
> These two things together mean that for our implementation, it never
> has to deal with transactions with the INST attribute, and so it can
> correctly ignore the XN bits entirely.  So we already implement
> FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
> that we need to.
> 
> Advertise the presence of the feature in SMMU_IDR3.XNX.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/smmuv3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 94d388fc950..d9e639f7c41 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -279,6 +279,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
>  
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
May be this can be guarded when S2P is present? according the UM
"In SMMUv3.1 and later, support for this feature is mandatory when
stage 2 is supported, that is when SMMU_IDR0.S2P == 1."
So I am not sure what it would mean for XNX and S1P only.

>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);

> -- 
> 2.34.1

Thanks,
Mostafa


