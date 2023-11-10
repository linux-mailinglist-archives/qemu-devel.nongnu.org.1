Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D445D7E7AF6
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nv4-0006l5-3p; Fri, 10 Nov 2023 04:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1Nut-0006cO-5m
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:35:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1Nuq-00067b-Sv
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699608904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY+2b5/41TIar/opnw0mmNctXoeUsnqwd6MVXp04vSY=;
 b=RE8B1yyNVcKjpGB6YMxoZKnZ4cMA/3ZE4qnovBp2XFByYWJrR7w6c3IqitRJQa3H9PmE1W
 149KoV9JjcWbLfg4E4PIBNQblusqv7jlCvVh/ynj+AV0w0DTHLYTlQV00eb1Awk3stVOpm
 pjeRGz/9iHZhv8s5eqi4qgAdaLntCFE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-IgAA5r_wMUu6G2r0JALFqQ-1; Fri, 10 Nov 2023 04:35:02 -0500
X-MC-Unique: IgAA5r_wMUu6G2r0JALFqQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6707401e1aeso21021606d6.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699608902; x=1700213702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SY+2b5/41TIar/opnw0mmNctXoeUsnqwd6MVXp04vSY=;
 b=bW3fSZf6dD57cqhfWMwRymAbuWIXAmiOpWmXt5xQz2n36nBVa4K8tcwJX7RPHR47WU
 JbnLslLu2huJVGZwg2IaqMt2OyA54bdLrPfToD2ys6Ej8b8xnEdODCWRCIkUeVvUxuZV
 3+P4JGyRFASDOSWi55LbBYPT6cQ5eaGq3y9b2V7fgex8AKy3vV4+WW1UhhPh99WlrOET
 myPBIX8GBPVvZaNbYc22s3uKYudk7Yf/w2JmgRUiobMOBEkLknQFafpUH7Nwitxd584j
 BcWuoqMBXNiCAPv8CC2a+9EuRUMX4NShCJ0QW/a6pDOpFZ03htR9laBDHFkABxwrX5l2
 c30w==
X-Gm-Message-State: AOJu0YwdqBnTEP+J+vK13n644Fz2BCg7dmwyCRSiyroVvZT3zv5av2Io
 b9yYZZU5eCkjQOwEytz3B3hl9SEzHH4L7hEWVzqn/qJKB7HZeWIOGUYamlw3NAq39DtIrrZJ1y3
 mq9b6qHORu8Oi/9c=
X-Received: by 2002:a05:6214:5085:b0:658:2ee7:7658 with SMTP id
 kk5-20020a056214508500b006582ee77658mr6990927qvb.25.1699608902417; 
 Fri, 10 Nov 2023 01:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4a4DnQf6R2XeFQ7PQJJeAsnkAD0p7TSsoy2h7zIbPyLsZfspg0LDKKhjmPeaMPLNA5DmPdw==
X-Received: by 2002:a05:6214:5085:b0:658:2ee7:7658 with SMTP id
 kk5-20020a056214508500b006582ee77658mr6990920qvb.25.1699608902184; 
 Fri, 10 Nov 2023 01:35:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a0ce78e000000b0065afbb39b2dsm2784013qvn.47.2023.11.10.01.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 01:35:01 -0800 (PST)
Message-ID: <b4bac441-cb54-444f-bc7c-359d22bfcea4@redhat.com>
Date: Fri, 10 Nov 2023 10:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/20] vfio/iommufd: Relax assert check for iommufd
 backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231109114529.1904193-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/9/23 12:45, Zhenzhong Duan wrote:
> Currently iommufd doesn't support dirty page sync yet,
> but it will not block us doing live migration if VFIO
> migration is force enabled.
> 
> So in this case we allow set_dirty_page_tracking to be NULL.
> Note we don't need same change for query_dirty_bitmap because
> when dirty page sync isn't supported, query_dirty_bitmap will
> never be called.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container-base.c | 4 ++++
>   hw/vfio/container.c      | 4 ----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 71f7274973..eee2dcfe76 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -55,6 +55,10 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start)
>   {
> +    if (!bcontainer->dirty_pages_supported) {
> +        return 0;
> +    }
> +
>       g_assert(bcontainer->ops->set_dirty_page_tracking);
>       return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>   }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 6bacf38222..ed2d721b2b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -216,10 +216,6 @@ static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>           .argsz = sizeof(dirty),
>       };
>   
> -    if (!bcontainer->dirty_pages_supported) {
> -        return 0;
> -    }
> -
>       if (start) {
>           dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
>       } else {


