Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BA7EB165
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:58:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tup-0000GJ-VD; Tue, 14 Nov 2023 08:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tun-0000Fc-F2
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:57:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tum-0007fl-0p
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGdL4+McdYUf/H6Mpk2wizYSYk0XQEL16HsvnEN7Ne8=;
 b=YQ8Znxvp+hiFkbdzYE/GJ/flDdFiAXJ4MATA9uKy/4hMEgVOHHlS0U/+q/AugA9NE5UQ9v
 cMaNbH/rGNrFSRAs3ernNr3GoduAdkU+o8JUqEQ0oaiQHzt8dFUKidjllkTkoHG5xTkm4O
 nGtKGGuPtGOP2N8evEvIuTQg48wfyA0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-2hBLueUvNNCBvUOYwFsZdA-1; Tue, 14 Nov 2023 08:57:13 -0500
X-MC-Unique: 2hBLueUvNNCBvUOYwFsZdA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-581dc6915b5so5437362eaf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970232; x=1700575032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGdL4+McdYUf/H6Mpk2wizYSYk0XQEL16HsvnEN7Ne8=;
 b=FfyVs+aSC6TnIVjXE4dlTz7iHHTCgJle0fyStbzwpWE70wKOLHSlUgdmCPVkVq4C/P
 wFJf+lkNqbBA5WjucEE9ZjBDMtTv4tEVH+/3CAZsX6K+1SIeVpHCcZiE84goFT1QAUhl
 iEy0toRixeN3Bkfu1iWs3YNiy3h7ypAxrKKpLGFkUoUOqAoOHspYS/KCJsGFSOVCySNM
 F3Lq7XZpcmqG5Lp0jOM351wOX0rNDbMNQGBZMIIbtoNX0gEzwT5q05mfBKpz/1pbLFU+
 sG9OH83eM5EKQUhzL6dPsOll8dbQrzksJq5k6knB744o+qfN/j8kyeN7VoakyPOaeloU
 41yg==
X-Gm-Message-State: AOJu0Ywtxn1mJ/aea53yk3j5y903CAXXrt1bZVsDCzVd1M+bwmQ5H0eM
 6fyHFd9NoTbdIcWOnQGjHXP2LUklnuTl2LtqHq4P5cnOXOUNkC/Anv59Akh/uKbkvdFVBoZ+s0N
 zWCreMBdhRkkx1YY=
X-Received: by 2002:a05:6358:6f82:b0:16b:c5c1:5a75 with SMTP id
 s2-20020a0563586f8200b0016bc5c15a75mr2990187rwn.12.1699970232493; 
 Tue, 14 Nov 2023 05:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrck9XMbUq1w5Eq6GTLU1AsVv+TnuHujH7ycITJS9P5yufD4yerXCkttnBGNoZatimBEpFVg==
X-Received: by 2002:a05:6358:6f82:b0:16b:c5c1:5a75 with SMTP id
 s2-20020a0563586f8200b0016bc5c15a75mr2990174rwn.12.1699970232208; 
 Tue, 14 Nov 2023 05:57:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p10-20020ac8408a000000b00403cce833eesm2729924qtl.27.2023.11.14.05.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:57:11 -0800 (PST)
Message-ID: <b76f4a3f-25d8-4651-80b3-fa2a4a9cf10f@redhat.com>
Date: Tue, 14 Nov 2023 14:57:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/21] vfio/pci: Allow the selection of a given iommu
 backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-11-zhenzhong.duan@intel.com>
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Now we support two types of iommu backends, let's add the capability
> to select one of them. This depends on whether an iommufd object has
> been linked with the vfio-pci device:
> 
> If the user wants to use the legacy backend, it shall not
> link the vfio-pci device with any iommufd object:
> 
>   -device vfio-pci,host=0000:02:00.0
> 
> This is called the legacy mode/backend.
> 
> If the user wants to use the iommufd backend (/dev/iommu) it
> shall pass an iommufd object id in the vfio-pci device options:
> 
>   -object iommufd,id=iommufd0
>   -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d00c3472c7..c5984b0598 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   
> @@ -42,6 +43,7 @@
>   #include "qapi/error.h"
>   #include "migration/blocker.h"
>   #include "migration/qemu-file.h"
> +#include "sysemu/iommufd.h"
>   
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>   
> @@ -3386,6 +3388,10 @@ static Property vfio_pci_dev_properties[] = {
>        * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
>        * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
>        */
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


