Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603C7EF4D2
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:57:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r40GR-00050X-IP; Fri, 17 Nov 2023 09:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r40GP-00050J-0Q
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r40GL-0004JE-Sn
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700232963;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtbiPLPFwJqRvrmhZNKE8bbO7M93DkRDzR+lEUP1fEk=;
 b=VWKSF4W/LTi1qxskJNwOnsFTFe/2eCpmgtwUFhrzg0yswk2eMUYM5Fsy3H6xS0tGlX6isA
 wNC9B2fZJVtl0XN7mJ4nPySziZgmwgGTyKeCImJvKHOxNr/0gbCN6O3g8o7/xvd37PulNx
 EKftbCT52iOFJ+A2nwquRcyPjdZwUNk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-1etP875BMpKBUu941Pe7Cw-1; Fri, 17 Nov 2023 09:56:01 -0500
X-MC-Unique: 1etP875BMpKBUu941Pe7Cw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-670237ba89aso54591696d6.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 06:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700232961; x=1700837761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtbiPLPFwJqRvrmhZNKE8bbO7M93DkRDzR+lEUP1fEk=;
 b=J1HD5bsZQmCoDzOdhSSPsjuZfaR1jArf+uZTnteyN3wW2DJjSs7XzpVykX/R5Qz4FO
 Q3DM1UjxWDxs45BDRlqJeZSYSxrx9K3BQjySSZr6LekG2S1+D9CwSx8BDJ9NP+fFNICq
 XdyXs5h4FQ5+DgeR91A1/q3oKsR+G2szRQsy/UqEJLb8UjuE4qNsuuX8grXKImkDFx1x
 FDpoj1EMmtCk/oWmiQ/rfMzpmQJ+aXnFOyjxAt4VSPuwwvJeIKoELUV3mCRxL/f55sZc
 AUdr88Y7Y+hMkqosl8OzZNQoZuHEIlanqnqR+4O4gUchqD77fuTNzrURAVAILBRlah4N
 LbAQ==
X-Gm-Message-State: AOJu0Yy87ySzO9m5MLtfX1eAUutNhQiCAi4Bz3MjqFSLVvC3LXL+4oMF
 nKUskcyEJPiYYWQZ7JEbAZd+qcS5peRnAR6vDrUhQytGCiHsjoMEhQL2uL2jzDAmdU4F9SzEeST
 93LMaWpBV4zarqy8=
X-Received: by 2002:a0c:c584:0:b0:670:b327:c86f with SMTP id
 a4-20020a0cc584000000b00670b327c86fmr7012869qvj.17.1700232961349; 
 Fri, 17 Nov 2023 06:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyGqAM23h22xMrP9Zr8doiKJLKA14+SCK23GDFPrO91P6vF9VUol4ftcWXxuMGSs3378uABQ==
X-Received: by 2002:a0c:c584:0:b0:670:b327:c86f with SMTP id
 a4-20020a0cc584000000b00670b327c86fmr7012846qvj.17.1700232961125; 
 Fri, 17 Nov 2023 06:56:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a0562141fc500b0065b13180892sm692342qvb.16.2023.11.17.06.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 06:56:00 -0800 (PST)
Message-ID: <7d926071-5567-4574-9445-7210f9cf75d0@redhat.com>
Date: Fri, 17 Nov 2023 15:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/21] vfio/platform: Allow the selection of a given
 iommu backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-platform device:
>
> If the user wants to use the legacy backend, it shall not
> link the vfio-platform device with any iommufd object:
>
>  -device vfio-platform,host=XXX
>
> This is called the legacy mode/backend.
>
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-platform device options:
>
>  -object iommufd,id=iommufd0
>  -device vfio-platform,host=XXX,iommufd=iommufd0
>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
> v6: Move #include "sysemu/iommufd.h" in platform.c
>
>  hw/vfio/platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 8e3d4ac458..98ae4bc655 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -15,11 +15,13 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>  #include "qapi/error.h"
>  #include <sys/ioctl.h>
>  #include <linux/vfio.h>
>  
>  #include "hw/vfio/vfio-platform.h"
> +#include "sysemu/iommufd.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
>  #include "qemu/lockable.h"
> @@ -649,6 +651,10 @@ static Property vfio_platform_dev_properties[] = {
>      DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
>                         mmap_timeout, 1100),
>      DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  


