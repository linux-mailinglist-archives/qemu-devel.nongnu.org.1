Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31E7D709C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfax-0005as-5j; Wed, 25 Oct 2023 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfas-0005Yk-1z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfaq-0003gK-Dr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698246887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m24yJh5lRUIb+owuGncADg13pbuEdOLvr6TCX0S2bc0=;
 b=CVoakyhh07725rdQpxxFFheioyZT+WRCgfjH+vwkCk13Zfy8DjJKdERO2vKf4ORGZzm11P
 G4rILHM6esF6GR86EiAYMR63H0SxnCJhzuMCosroA1pgQIc/GOJD//eQllNN16Iu2K5DJg
 1if1195HIWUYL4PdZm+cg/4cF71rZQo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-NcTMWy16MwmgYK-MVaPgNw-1; Wed, 25 Oct 2023 11:14:45 -0400
X-MC-Unique: NcTMWy16MwmgYK-MVaPgNw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-581e7b03855so2110757eaf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246885; x=1698851685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m24yJh5lRUIb+owuGncADg13pbuEdOLvr6TCX0S2bc0=;
 b=XUe0IXJApLBvpGraNLNKMHNikSZ6790gp4N6h2zNdCiJMeblI3QTo8+hCzejofPJiS
 nowvdL9tP7Y7TdYUp73JPWmk4owiKAHRYWHOPw8OgaG+eP+pgvu6bhElkzC6D6ZHPqZZ
 oouaCbgMjI6zF9OsWQWOJS3FOzttN5qKyHM4UVMWLzXMHu2RJGWsamfTNmDbRglg6Jh0
 wxRQ0wKcAdVW7bCjKtIftydME3x/oj9MJmrA+rMZNZeMng61tV/jSDElfhzynI+/XPtn
 6J3jiZcY7PAuMT0Zu4YDUw3W4q6QVIwea4tGyXP3/kDV+VOyDPMYbwmYinpCE+aK/ePn
 Xj7Q==
X-Gm-Message-State: AOJu0YzO1/MQmQlA3PCGisHUCGupZWUzlPAzucb+VZxosKPhJ0CLIxH6
 6KMq7OLTTx+bUqdIZYYk46KF6niGwZaFFLxzE8H7N7SzAcyafAMx9KSrV8BNWCVMOZOaVMovIDI
 PkkussuqWni7bvH0=
X-Received: by 2002:a05:6358:c9f:b0:168:bff9:939b with SMTP id
 o31-20020a0563580c9f00b00168bff9939bmr11858084rwj.0.1698246885071; 
 Wed, 25 Oct 2023 08:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfF9q78vSwe44mWi+U8gl49nN/CqzPT5KAaq7LcXyryyd/LFnPQTkykPGfwOYS0YckreiveA==
X-Received: by 2002:a05:6358:c9f:b0:168:bff9:939b with SMTP id
 o31-20020a0563580c9f00b00168bff9939bmr11858064rwj.0.1698246884657; 
 Wed, 25 Oct 2023 08:14:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pm10-20020ad446ca000000b0066d1f118b7esm4503683qvb.1.2023.10.25.08.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:44 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:14:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZTkw4itrYANXm4qR@x1n>
References: <20231025051430.493079-1-ethan84@andestech.com>
 <20231025051430.493079-3-ethan84@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025051430.493079-3-ethan84@andestech.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 25, 2023 at 01:14:26PM +0800, Ethan Chen wrote:
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  system/physmem.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index fc2b0fee01..53b6ab735c 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -432,8 +432,13 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
>              iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
>          }
>  
> -        iotlb = imrc->translate(iommu_mr, addr, is_write ?
> -                                IOMMU_WO : IOMMU_RO, iommu_idx);
> +        if (imrc->translate_size) {
> +            iotlb = imrc->translate_size(iommu_mr, addr, *plen_out, is_write ?
> +                                         IOMMU_WO : IOMMU_RO, iommu_idx);
> +        } else {
> +            iotlb = imrc->translate(iommu_mr, addr, is_write ?
> +                                    IOMMU_WO : IOMMU_RO, iommu_idx);
> +        }

Currently the translation size is encoded in iotlb.addr_mask.  Can riscv do
the same?

For example, lookup addr in match_entry_md() ranges, report size back into
iotlb.addr_mask, rather than enforcing *plen_out range always resides in
one translation only.

IMHO it's actually legal if *plen_out covers more than one IOMMU
translations.  QEMU memory core should have taken care of that by
separately translate the ranges and apply RW on top.  With current proposal
of translate_size() I think it'll fail instead, which is not wanted.

Thanks,

-- 
Peter Xu


