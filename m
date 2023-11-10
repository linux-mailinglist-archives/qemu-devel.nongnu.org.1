Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD37E7A4C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:52:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NDs-0000uV-UF; Fri, 10 Nov 2023 03:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1NDr-0000u4-4M
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1NDn-0005gC-Jm
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699606233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgg8j3ooXHfy29OpnYE9Lh6w+b4gLvn26Zph3Ne7SyA=;
 b=WJqQ3zHkOAPwGUejanG94nsGedSsK+8/gZxwLxAYTNevqs35+FxS61TP7xyPbEH+nQH6HS
 3Sjzf6Nrwvwj/tFadkASS5M+tXDDuOPna5JrdMhOKTJ+J/Lqmwk8aMWiNX6R8uHRIbP+GC
 SKdkk/6j5A4SRoK+MSOVvim7WXDTfW4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-cn9pQll6NaKrYVXYkIMpgg-1; Fri, 10 Nov 2023 03:50:31 -0500
X-MC-Unique: cn9pQll6NaKrYVXYkIMpgg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cba6d1330so21932231cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 00:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699606231; x=1700211031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgg8j3ooXHfy29OpnYE9Lh6w+b4gLvn26Zph3Ne7SyA=;
 b=fLNyd9px7+RpVFS5oLlhroHiosvqQYbs5fLnG2GIh1jlnDQPXbUMGJVHKERy64uaae
 zFkR6j4X45C7uigaPi/dbzCGyqYhPbpLQGJefszQDRjDSNTmusjRAEzi1nupXKM87yqv
 Le+yrT9+EhVQDr3pfXuPFwr75YPOtqFsbwO8/0pJg2drFI+csx/v3HzQIVcpYKW7iVdf
 DLQ14vMBES+DyV4TViDWRlrHU/eOoVmXwkyhQTzWd9qUUIoJtPMy2SmN50zm8qY1hQHP
 J2wRNSlx0c9RQzSqghWQmQneQdcs539IMrEzHSRgpNWtg42kIPqXDkkp8izmKqWeS9Ym
 bRvg==
X-Gm-Message-State: AOJu0YxcSSaHDh06vMk+AeI5HPVWzEqfwWNmkieSIgo87SdlEBy+pNqq
 XCsgJHDQHGcrggCQhXPDBhS1WyojNN0AP1xTpcLULqDrJFzcP/FItUma5tfJJsoesCqUKYBpGw3
 bBOk9NNjFIUefh+U=
X-Received: by 2002:a05:622a:341:b0:41c:cfc0:5c52 with SMTP id
 r1-20020a05622a034100b0041ccfc05c52mr8333879qtw.39.1699606231184; 
 Fri, 10 Nov 2023 00:50:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp5BSn6KT27W9VLqs9r7RmdDAA/ehKosHRusihr0FFVOx3lOFW9JiYWHZ2GOjtQmy8bJoYCA==
X-Received: by 2002:a05:622a:341:b0:41c:cfc0:5c52 with SMTP id
 r1-20020a05622a034100b0041ccfc05c52mr8333854qtw.39.1699606230863; 
 Fri, 10 Nov 2023 00:50:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 jr23-20020a05622a801700b0041aff9339a2sm2654867qtb.22.2023.11.10.00.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 00:50:30 -0800 (PST)
Message-ID: <130a66bf-07b6-49ea-a7bf-de8afe0c83b9@redhat.com>
Date: Fri, 10 Nov 2023 09:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] vfio/platform: Allow the selection of a given
 iommu backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-12-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231109114529.1904193-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 11/9/23 12:45, Zhenzhong Duan wrote:
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-platform device:
> 
> If the user wants to use the legacy backend, it shall not
> link the vfio-platform device with any iommufd object:
> 
>   -device vfio-platform,host=XXX
> 
> This is called the legacy mode/backend.
> 
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-platform device options:
> 
>   -object iommufd,id=iommufd0
>   -device vfio-platform,host=XXX,iommufd=iommufd0
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-platform.h | 1 +
>   hw/vfio/platform.c              | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
> index c414c3dffc..f57f4276f2 100644
> --- a/include/hw/vfio/vfio-platform.h
> +++ b/include/hw/vfio/vfio-platform.h
> @@ -18,6 +18,7 @@
>   
>   #include "hw/sysbus.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/queue.h"
>   #include "qom/object.h"
I think we can move this change including "sysemu/iommufd.h" to file
"hw/vfio/platform.c"


Thanks,

C.



> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 8e3d4ac458..86e176ee97 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -15,6 +15,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include "qapi/error.h"
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
> @@ -649,6 +650,10 @@ static Property vfio_platform_dev_properties[] = {
>       DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
>                          mmap_timeout, 1100),
>       DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


