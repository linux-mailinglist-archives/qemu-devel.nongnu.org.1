Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C809B7EB176
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:04:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u0v-0001n7-9F; Tue, 14 Nov 2023 09:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u0n-0001mj-My
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u0l-0000gt-Hp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hw1qBBtpfAiDzD1CBkcD6Te+kZdSdeaOEit5jDoDv7s=;
 b=N5szKUHZOm0QAAOJMS/T203D8QgEAd3EY2K3Spl/hUPfjYMtiHGNS5rgbFbPGZ6bpbivcb
 7zuI9S1pwvRPClRXb+BAglpU7hmlMt/uaqM9ypmYxCnIgsgrrwt8mcRbm8TJZBkiC/XJcx
 WKQWvkkyfcL/Y6xdXayDZ83i21WW8+M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-F0DyNh64MTqKdUwD-RE5kQ-1; Tue, 14 Nov 2023 09:03:20 -0500
X-MC-Unique: F0DyNh64MTqKdUwD-RE5kQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-421acfe16f6so48871601cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970595; x=1700575395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hw1qBBtpfAiDzD1CBkcD6Te+kZdSdeaOEit5jDoDv7s=;
 b=ZlYlikEwSe9VZJkmDtb/eamG+MSSycnCLVoRS4z1n0wPkL64nTW1Ww1rfCWSku1swC
 ra58ymXBloynU7fqktM4vClxMyZ2ySH3+wSH3RRYDiT9AHGv2CwMYAKbFIinHJY3yR+d
 5Dc221W/vioIDj/PUTvur7THGnY4c1muRqtjw+2WGZ9c8y015GGga/V1aGHzR5OrxVD1
 ZR72H/o4uUUyTpSyFiW7dyo7qvj/TDxylc31boQann3p77qF5rMN/kgYpwpWgVxej2tx
 kaKgbchE5mdBOUNo18r8/98NHB6Yb1lKksu8mEcIU8htheJnPTat4zmoBh7FHBcanyVY
 EEgQ==
X-Gm-Message-State: AOJu0YzLk4PaRs05Zyc+nDlL95lD49/AQXAN09+0zLNO5rsp+PXwHfAI
 QX1RMu/4vdQt/GyaV5If3d0RKN4/qrgpWPW3X184abrazgZ5YXqALtMlTV2F9WW1d6IjR6ogG1C
 JUu+FKrwFfRitq1A=
X-Received: by 2002:a05:622a:1443:b0:418:11ee:6315 with SMTP id
 v3-20020a05622a144300b0041811ee6315mr2335412qtx.43.1699970595306; 
 Tue, 14 Nov 2023 06:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW23hda7nWvcSs4oOFRX4LabUw7aMjGyp3evueFkykUiRnm/YGwFm2f+ej4mNEwfdlx/wH2Q==
X-Received: by 2002:a05:622a:1443:b0:418:11ee:6315 with SMTP id
 v3-20020a05622a144300b0041811ee6315mr2335373qtx.43.1699970595012; 
 Tue, 14 Nov 2023 06:03:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:03:14 -0800 (PST)
Message-ID: <56f5149a-65fd-4407-b905-2040af723cd1@redhat.com>
Date: Tue, 14 Nov 2023 15:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/21] vfio/platform: Allow the selection of a given
 iommu backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-13-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-13-zhenzhong.duan@intel.com>
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> v6: Move #include "sysemu/iommufd.h" in platform.c
> 
>   hw/vfio/platform.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 8e3d4ac458..98ae4bc655 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -15,11 +15,13 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include "qapi/error.h"
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
>   
>   #include "hw/vfio/vfio-platform.h"
> +#include "sysemu/iommufd.h"
>   #include "migration/vmstate.h"
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
> @@ -649,6 +651,10 @@ static Property vfio_platform_dev_properties[] = {
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


