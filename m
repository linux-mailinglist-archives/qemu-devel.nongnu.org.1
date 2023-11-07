Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA27E481E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:20:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qgk-0002HT-Bs; Tue, 07 Nov 2023 13:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0Qgg-0002Cp-DZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0QgW-00051O-EG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdbGDjfP/L398P4HTtjAZh1/yhF4qFZzWRCm7nPN7lE=;
 b=KPG+O5rQ7DW1vYyRZ8Gw/HGWVytUZL6WIZJpUq1ZI4jLfyIwZ31l6yXVxFUzBmQacbxhy7
 Ll1yA2+itcjpTXhK5rbrRyZBWkkAPGM/J0THjT62GXWk8gnyo1YvJFgXPACqzZ11bEvzb2
 25EktuqvNA1yweTLPlNt8h/l/JJTzBU=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-5aFwwpQbP1urrZi5ANz3iA-1; Tue, 07 Nov 2023 13:20:18 -0500
X-MC-Unique: 5aFwwpQbP1urrZi5ANz3iA-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4ac342cac5cso1109621e0c.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381218; x=1699986018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdbGDjfP/L398P4HTtjAZh1/yhF4qFZzWRCm7nPN7lE=;
 b=RpyfNQcrkBqwrVaj3bVoS7TrQpB3YnivyifvSyQkptOjuhQYr2UAFkHbBOJrfpTJcg
 lj4kQ+YmNVq6S6+mqnKIk9WIZwEf/GtvPMk7i0aydA+jZBlz/5XT3FYy342YHbxZzgdp
 jRg9LVrHrh2jmWeKGpimDP9m5AsZENTSFtSlmoxBSBz6f5A3hElGkX9/PFPGuCUCUvKX
 hmJhRtz09aWEVG2tTcylsajAVtsrWkPglQ6uk8slfvY2qe0dJw+SbjNWpzRR7ZmYltS7
 KzVZxh74D/JmBUQNypzsmLMfDG7unyggcxQE1+8A+sbNyR764dOQD/oISRm5x8H4xPdM
 WEcA==
X-Gm-Message-State: AOJu0YwzJs0ZR3gZEjNtUNoyc51YAbhr5UVnPdWSyb/Xd93AOH6CFBpn
 4EH9LaHQpHRn0HZKs2hi2UWTBb+aP/3XRBFP2W+TFkwypJg/3Xku6mKfRHoT74Qqxunl3cIv1bO
 1LKEPnpk1NrxjeWc=
X-Received: by 2002:a1f:a697:0:b0:4ab:eb9c:ef0d with SMTP id
 p145-20020a1fa697000000b004abeb9cef0dmr11696259vke.7.1699381217845; 
 Tue, 07 Nov 2023 10:20:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgWtRklw/C49cc+4QKPq3PSI7UiRiIoiixZL9dCWlukrS0lB5sXkL9UTDz+pRG96S3yDgxzg==
X-Received: by 2002:a1f:a697:0:b0:4ab:eb9c:ef0d with SMTP id
 p145-20020a1fa697000000b004abeb9cef0dmr11696231vke.7.1699381217559; 
 Tue, 07 Nov 2023 10:20:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a0cfbc3000000b0065b13180892sm144217qvp.16.2023.11.07.10.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:20:17 -0800 (PST)
Message-ID: <d48e9f68-8906-4a7d-8e44-0ea894860a4d@redhat.com>
Date: Tue, 7 Nov 2023 19:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 39/41] vfio/ccw: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-40-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-40-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/2/23 08:13, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Opportunisticly, remove a redundant definition of TYPE_VFIO_CCW.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

We would need an Ack from the Z team for this change.

Thanks,

C.


> ---
>   hw/vfio/ccw.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 7695ede0fc..a674bd8d6d 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -30,6 +30,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
> +#include "monitor/monitor.h"
>   
>   struct VFIOCCWDevice {
>       S390CCWDevice cdev;
> @@ -589,11 +590,12 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    if (vfio_device_get_name(vbasedev, errp)) {
> +        return;
> +    }
> +
>       vbasedev->ops = &vfio_ccw_ops;
>       vbasedev->type = VFIO_DEVICE_TYPE_CCW;
> -    vbasedev->name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
> -                           vcdev->cdev.hostid.ssid,
> -                           vcdev->cdev.hostid.devid);
>       vbasedev->dev = dev;
>   
>       /*
> @@ -690,12 +692,37 @@ static const VMStateDescription vfio_ccw_vmstate = {
>       .unmigratable = 1,
>   };
>   
> +static void vfio_ccw_instance_init(Object *obj)
> +{
> +    VFIOCCWDevice *vcdev = VFIO_CCW(obj);
> +
> +    vcdev->vdev.fd = -1;
> +}
> +
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    VFIOCCWDevice *vcdev = VFIO_CCW(obj);
> +    int fd = -1;
> +
> +    fd = monitor_fd_param(monitor_cur(), str, errp);
> +    if (fd == -1) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    vcdev->vdev.fd = fd;
> +}
> +#endif
> +
>   static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
>   
>       device_class_set_props(dc, vfio_ccw_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
> +#endif
>       dc->vmsd = &vfio_ccw_vmstate;
>       dc->desc = "VFIO-based subchannel assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -713,6 +740,7 @@ static const TypeInfo vfio_ccw_info = {
>       .name = TYPE_VFIO_CCW,
>       .parent = TYPE_S390_CCW,
>       .instance_size = sizeof(VFIOCCWDevice),
> +    .instance_init = vfio_ccw_instance_init,
>       .class_init = vfio_ccw_class_init,
>   };
>   


