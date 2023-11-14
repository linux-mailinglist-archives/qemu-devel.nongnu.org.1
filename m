Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C247EB17A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:05:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u22-0002p9-0E; Tue, 14 Nov 2023 09:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u1x-0002dO-Lk
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u1u-0000u1-HZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FU7lgD2lawwwjeYBAQo9hzpvhOg2qt4nKWkANuEUoAs=;
 b=D+052RLqPZ6wmYtT1AX8DS3h5P0T70Y4bIWM/heICESwAMGVnTQYx9VRLGmw4cXMx1sw1X
 rG9HODVs9fp9+zVuR6uENcUTOI2dzA8nPwYElljEMVW1EuBmuuwIZaLuEk5MN9OevSFR8b
 zyewtyqVjr08rPSCNvdTXi2/9bdoETA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-trPdyWRfO1iLLCAJrW06Mw-1; Tue, 14 Nov 2023 09:04:35 -0500
X-MC-Unique: trPdyWRfO1iLLCAJrW06Mw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cdc542b56so68481011cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970675; x=1700575475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FU7lgD2lawwwjeYBAQo9hzpvhOg2qt4nKWkANuEUoAs=;
 b=KMGksNWJF0olYLX2AIfd5aZxA4T7K/kSXYWD10I5otWr/65A/aDvH6rySwcPGmyu/C
 oY+wfBjcC7KSqQ0WC7dqPSl1OCI9HSnm2ncPQ89V/7IZw97HvztJVJyfyFI8qq5KcTZm
 L/n0Dww/H+cJhz/4r5STEARq/cGu9cQ23p+4PTM2QPXQ+k61ND9kcgbQ6JkuxU5iDRfc
 63L8CVih9Pp5rSc/7ahpok24bnmNpfJwh1Ucqzah0IRwqQ6yFJDNr8ow+EW9nL/zCXv3
 4gQWCsG1ndobSCYYn6FpYwP9wVO5rW0BoS23szPXOaQHBTDA6vDcl8YkgEk00uk8uKyH
 8hlw==
X-Gm-Message-State: AOJu0YyJUZ6TfaSExeWxI6sQZd0YdYYWIZHPljuHFOyvTRydlK8XROvT
 k5xOIY+OJEexlQTxjaYFeawAZ920CrH/9Y7klf83DII2OwCmxHGgWW9ECo8f3hhR8S+KyJ4HaSG
 EdJsffCGH+biDOKQ=
X-Received: by 2002:ac8:570e:0:b0:418:224:db06 with SMTP id
 14-20020ac8570e000000b004180224db06mr2748283qtw.50.1699970675335; 
 Tue, 14 Nov 2023 06:04:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLnQNBNSQtKhvzWkyKfHI+p8+xQPEwk4C1y7YG+a8qHwqK/B3z2q4UGenso3CMaianxDfGfQ==
X-Received: by 2002:ac8:570e:0:b0:418:224:db06 with SMTP id
 14-20020ac8570e000000b004180224db06mr2748247qtw.50.1699970675105; 
 Tue, 14 Nov 2023 06:04:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:04:34 -0800 (PST)
Message-ID: <1aa20373-966e-427b-b480-089029ed8e57@redhat.com>
Date: Tue, 14 Nov 2023 15:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/21] vfio/ccw: Allow the selection of a given iommu
 backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-17-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-ccw device:
> 
> If the user wants to use the legacy backend, it shall not
> link the vfio-ccw device with any iommufd object:
> 
>   -device vfio-ccw,sysfsdev=/sys/bus/mdev/devices/XXX
> 
> This is called the legacy mode/backend.
> 
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-ccw device options:
> 
>   -object iommufd,id=iommufd0
>   -device vfio-ccw,sysfsdev=/sys/bus/mdev/devices/XXX,iommufd=iommufd0
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/ccw.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index d857bb8d0f..d2d58bb677 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -15,12 +15,14 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <linux/vfio_ccw.h>
>   #include <sys/ioctl.h>
>   
>   #include "qapi/error.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "sysemu/iommufd.h"
>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/vfio-ccw.h"
>   #include "hw/qdev-properties.h"
> @@ -677,6 +679,10 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>   static Property vfio_ccw_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>       DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


