Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87D7EB179
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:05:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u2M-0003x5-3C; Tue, 14 Nov 2023 09:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u2J-0003tg-5a
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u2G-0000wq-Kh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVAA9GOX/gv2zTZBt8RVHz1zLxdrsVMc4gO+TkwNh4w=;
 b=Ww8oQzQGNCPi5myYDHqicPXDf5I5SC4+T+ZTaTXBHlfGC8TxKTbz+asAPCAbLQXkDazk7d
 yZ52CIqjrZAyZhQbZ7iVOXvUG/QMtWH+zmRVIYcVfrB1ode91HYq0jhjbiJat+QBVW/nX/
 yuYGJAxTA6mjfJt13QNdtvFSlA0g7SU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-tB566KEkMPu6DoKCANbyKg-1; Tue, 14 Nov 2023 09:04:58 -0500
X-MC-Unique: tB566KEkMPu6DoKCANbyKg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6d345756155so5771865a34.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970698; x=1700575498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aVAA9GOX/gv2zTZBt8RVHz1zLxdrsVMc4gO+TkwNh4w=;
 b=jP3kl8bWuREGHkxNMu/0LnC3pW0CJQsreJQS7WxG292o9biFgMslZLxMIsWd/moXTX
 TRD5tkD8w5Xd4RyvbHw+umPcJodJurTxOFNhApX2dBMVzETRV0CdP80eVDktc7RiEUY4
 6zq8AT12lvztnsiCfs6n0GW6jfLK7eeB0VUPeXdPYq4wkoUMZxU9lL1I900IiPotWZ7m
 DDeGXkpfc7XBrk3hixdVv5zJzwsfVB8Dceu2chpPbF4aQbWXfG4YqRGU2yGwJ1OhETrw
 l/KHE1qrvC4HrruW4v6b7EQm8oI2Sn/Ht0J5IUefu6zRtkZcVSWCwCYfSKFxPC9NZRTt
 cTxQ==
X-Gm-Message-State: AOJu0YyMTX4+X/4Mh3WORqvo+NwC+hjmkfDag8xYWFme0ck98m1s4fLh
 NpXHkS6pjCZB+jUJS8yNWzOATcbYsdRMR0iENU6hJ4avfPukzw2uaZQLQII2QAetf2m9Wf4Ef8Z
 7qShB7Qww/TdTscU=
X-Received: by 2002:a05:6830:3a8c:b0:6cd:bc23:4b55 with SMTP id
 dj12-20020a0568303a8c00b006cdbc234b55mr2253704otb.13.1699970698093; 
 Tue, 14 Nov 2023 06:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERYoXbYb6w6XiJlo7ceuQwYhChdQ0RhtiNOfnDizcsej2JjYnn6hUhuqbnLr0Rj3Wa/kxryg==
X-Received: by 2002:a05:6830:3a8c:b0:6cd:bc23:4b55 with SMTP id
 dj12-20020a0568303a8c00b006cdbc234b55mr2253672otb.13.1699970697833; 
 Tue, 14 Nov 2023 06:04:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:04:57 -0800 (PST)
Message-ID: <04d63726-5926-4d3b-8956-64318c562824@redhat.com>
Date: Tue, 14 Nov 2023 15:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/21] vfio/ccw: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-18-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/14/23 11:09, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/ccw.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index d2d58bb677..b116b10fe7 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -590,11 +590,12 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
> @@ -691,12 +692,29 @@ static const VMStateDescription vfio_ccw_vmstate = {
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
> +    vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
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
> @@ -714,6 +732,7 @@ static const TypeInfo vfio_ccw_info = {
>       .name = TYPE_VFIO_CCW,
>       .parent = TYPE_S390_CCW,
>       .instance_size = sizeof(VFIOCCWDevice),
> +    .instance_init = vfio_ccw_instance_init,
>       .class_init = vfio_ccw_class_init,
>   };
>   


