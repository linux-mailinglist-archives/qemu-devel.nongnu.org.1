Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D517EB177
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:04:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u1B-0001sw-Mo; Tue, 14 Nov 2023 09:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u1A-0001r2-4g
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u18-0000lH-Go
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBFrPuQAfYQV4CufXttOg1Qj84TqUeVf6pt/mhc+DyE=;
 b=Upr4PWZaqEa5esYVcFYPR7mZhJcgvC76V149eoAKBbv9k51Cb4dyBkKviGQVo0efC2O0hS
 idckygp66Mmlga0nOIKeUMqTVJEYi+oz7/vV/H+k9cuR+n3/QEewnn61bhKkcpf23MeSxY
 FqtepUoXSmlJRpwZccyNrxPyswx/O70=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-CYWwq6cfMi2pWPil6dPkAA-1; Tue, 14 Nov 2023 09:03:47 -0500
X-MC-Unique: CYWwq6cfMi2pWPil6dPkAA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-421b4bc2a80so48052021cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970626; x=1700575426;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vBFrPuQAfYQV4CufXttOg1Qj84TqUeVf6pt/mhc+DyE=;
 b=jqdgZnBlZ4jKQcAibzJK622dAWJLMwieM6UYz3945f2TVVHKY11pWAuLSxeL5TqgFD
 ckUUcrn8bXwAV3b7boWvAQxmg9/cGArlbWr4Lv/EVQg7vSHHZeCLyHxXO0ZhD5O57rgJ
 2Kk084P+oOWAu3Ba/ucf75sqe4vx3igPSpznFKahoOzWgQsX94um1L21uGR3wiFh8PIo
 9Y5h08v5DCpVk1s3TTtj0lpudW7UjoVCZESSKTWj9hY/ItxsRZxnSKf7rK5xOHgIpv2r
 tikH+kwN3KOi2lWrKRCRJh3sso6RyEzfS4/WT9vxH0rfPfQlYjtS/1K9+aUNeZObDj2F
 vatA==
X-Gm-Message-State: AOJu0Yx/4LhCAwrbqus77k1lGOC3/0wt9Oe26Ak5JNrKy8piFj7ossa7
 RepMutbKdSBpUn4OEHIBn5G0cmYL0rjUhT0A5FrdFtlXLiv+3Ks52p9LAmxOb6W4ZIPWzl92JkU
 QpZeNCVhvy/B5TyY=
X-Received: by 2002:a05:622a:1a2a:b0:418:cd5:ac97 with SMTP id
 f42-20020a05622a1a2a00b004180cd5ac97mr2436390qtb.65.1699970626683; 
 Tue, 14 Nov 2023 06:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNskHY+XfRhp7RGgidsacuBbzS6TA9BuXXzgQ+h92pLa1z/jOHJ9o6WTufnNNOFQye9ViXA==
X-Received: by 2002:a05:622a:1a2a:b0:418:cd5:ac97 with SMTP id
 f42-20020a05622a1a2a00b004180cd5ac97mr2436341qtb.65.1699970626285; 
 Tue, 14 Nov 2023 06:03:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:03:45 -0800 (PST)
Message-ID: <989ef60c-463c-4733-91be-5ff48c34f4e5@redhat.com>
Date: Tue, 14 Nov 2023 15:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/21] vfio/ap: Allow the selection of a given iommu
 backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-15-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-15-zhenzhong.duan@intel.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-ap device:
> 
> if the user wants to use the legacy backend, it shall not
> link the vfio-ap device with any iommufd object:
> 
>   -device vfio-ap,sysfsdev=/sys/bus/mdev/devices/XXX
> 
> This is called the legacy mode/backend.
> 
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-ap device options:
> 
>   -object iommufd,id=iommufd0
>   -device vfio-ap,sysfsdev=/sys/bus/mdev/devices/XXX,iommufd=iommufd0
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/ap.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index bbf69ff55a..80629609ae 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -11,10 +11,12 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "hw/s390x/ap-device.h"
>   #include "qemu/error-report.h"
>   #include "qemu/event_notifier.h"
> @@ -204,6 +206,10 @@ static void vfio_ap_unrealize(DeviceState *dev)
>   
>   static Property vfio_ap_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


