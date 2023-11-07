Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E67E481B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:19:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qfu-0001JM-LM; Tue, 07 Nov 2023 13:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0Qfs-0001HW-6R
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0Qfc-0004jY-BH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYtCSU2ecmvzzjSxjaeAfiEGUcyXp1uHXALOGIk2C/g=;
 b=hjLpT3BWGLe4oqfKWlQjR0SdqH4qFP2DugruulifEUn1W/nhrd643nCXCe/dsiBHzbqDUG
 z1KxD5MRcXRZ6eWBblOd/s7xVCSxg1l8gk0dZ0crqKxkubM3wONXKdeb/Dev+6+xvm/2ca
 6NMIm7WOUVkQT5yR/75gaXMLKYZ0aVg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Vbu6m845MY2cOQZOhVuZsA-1; Tue, 07 Nov 2023 13:19:21 -0500
X-MC-Unique: Vbu6m845MY2cOQZOhVuZsA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-da0737dcb26so7130183276.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381161; x=1699985961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYtCSU2ecmvzzjSxjaeAfiEGUcyXp1uHXALOGIk2C/g=;
 b=CD5eXv6wQy28s2Aff+gFYm6mfBEKXcIuGhuFsEPcYdvQ21cFxdHj574n38DEBS2ICJ
 AwpiUmfWlv4qEvAn54LFJ5WcBc67XbPXilgn5W5/8nT4UCIRE77lfjUkv81MXLI7Zk9j
 wT0D+xpSB6RzCoKjvjnEU3ivVX3PgVlM79qvXOiDbLYMD/Y7+ZW3+vayQtKUImCeNY5c
 tmK42vGdQeoHWzTg48spy79PtwQtG8ZXk706V0vTf4v83eiCzgXl6p/RG0m9K23Yircf
 jx0gi/t9m9Irdo7/gp76uS4o79PjNCY5oUUu3ISikIYyqxxwloEvaG23kHlH1yVbpe6J
 n2TA==
X-Gm-Message-State: AOJu0YxkDPQdo7EmL8As6ZK6ifDydQ3e9yo5r0FZdfRee3Nq6aeQsMq5
 okeD2eRii5KF0bYyYzyDB3yo8NVTju2RDV61OXX2Nd/OnbtviUAu++ufYKoqOKECPd3BjXHdbtB
 cyY2fosBHUgHnLSY=
X-Received: by 2002:a25:d38d:0:b0:d9c:2a9c:3f4f with SMTP id
 e135-20020a25d38d000000b00d9c2a9c3f4fmr32132896ybf.62.1699381161184; 
 Tue, 07 Nov 2023 10:19:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Rf2E4lSXvYeGZxdxI0b0nBWPmZdiN+G7gAB9WUHkqt0myziohakxIw6BIHCenKXwP8BOmA==
X-Received: by 2002:a25:d38d:0:b0:d9c:2a9c:3f4f with SMTP id
 e135-20020a25d38d000000b00d9c2a9c3f4fmr32132868ybf.62.1699381160968; 
 Tue, 07 Nov 2023 10:19:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a0cfbc3000000b0065b13180892sm144217qvp.16.2023.11.07.10.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:19:20 -0800 (PST)
Message-ID: <6aed2302-b951-4f3b-8d3d-81ec328be036@redhat.com>
Date: Tue, 7 Nov 2023 19:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 38/41] vfio/ap: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-39-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-39-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Opportunisticly, remove some unnecessory double-cast.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


We would need an Ack from the Z team for this change.

Thanks,

C.

> ---
>   hw/vfio/ap.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6a4186ccd3..0a810f8b88 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -29,6 +29,7 @@
>   #include "hw/s390x/ap-bridge.h"
>   #include "exec/address-spaces.h"
>   #include "qom/object.h"
> +#include "monitor/monitor.h"
>   
>   #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
>   
> @@ -159,7 +160,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> -    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> +    if (vfio_device_get_name(vbasedev, errp)) {
> +        return;
> +    }
> +
>       vbasedev->ops = &vfio_ap_ops;
>       vbasedev->type = VFIO_DEVICE_TYPE_AP;
>       vbasedev->dev = dev;
> @@ -229,11 +233,36 @@ static const VMStateDescription vfio_ap_vmstate = {
>       .unmigratable = 1,
>   };
>   
> +static void vfio_ap_instance_init(Object *obj)
> +{
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
> +
> +    vapdev->vdev.fd = -1;
> +}
> +
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
> +    int fd = -1;
> +
> +    fd = monitor_fd_param(monitor_cur(), str, errp);
> +    if (fd == -1) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    vapdev->vdev.fd = fd;
> +}
> +#endif
> +
>   static void vfio_ap_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       device_class_set_props(dc, vfio_ap_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
> +#endif
>       dc->vmsd = &vfio_ap_vmstate;
>       dc->desc = "VFIO-based AP device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -248,6 +277,7 @@ static const TypeInfo vfio_ap_info = {
>       .name = TYPE_VFIO_AP_DEVICE,
>       .parent = TYPE_AP_DEVICE,
>       .instance_size = sizeof(VFIOAPDevice),
> +    .instance_init = vfio_ap_instance_init,
>       .class_init = vfio_ap_class_init,
>   };
>   


