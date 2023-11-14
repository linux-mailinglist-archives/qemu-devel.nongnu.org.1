Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FEC7EB208
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:22:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uJ2-0004aM-0N; Tue, 14 Nov 2023 09:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2uIw-0004VR-4H
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2uIt-0004Qa-Sj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699971730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kH7hMPp/FXrIB8zr50Zi7NwV5wPZBTH+xZ3a/04jnGU=;
 b=h/aY3WY29LaqwAo78F4Vzdv2yTI0XuKwZ6XABIFOUbGom90Mc138K2KTWNyQYGoihERhhJ
 SOJCyJNOVu2FfeKeLwHpM0BvnO4TTZhLGKzy9wHbAA2UmVhb9gM/4soI45S7ymbZY/W4UX
 XBYt6mOvXAIwTW1VmVRfr8OvqEk2Nn8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-3RCmyK0TOMihPijHqPQ2-w-1; Tue, 14 Nov 2023 09:22:07 -0500
X-MC-Unique: 3RCmyK0TOMihPijHqPQ2-w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41cd433742dso73095311cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699971727; x=1700576527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kH7hMPp/FXrIB8zr50Zi7NwV5wPZBTH+xZ3a/04jnGU=;
 b=G3SlOtFFM0ByW6bDZ49eyz8+/EyB8iHevk4fZXoZByjZJSnU031wv1iyIQekDwzyQ8
 AIIMRwYOLPM+VLWKM89nFWRRbBb0xzPLDAeWkCVTaNSZf3OsT8shMM9J9qFmgjol+m1c
 ZuMHlyWCxVhzU61w4LVF8mzb7tMs6kDRVzJrhxQIdunQG16vsh9yV3V7zK2rtsXFRUTT
 aDeIBbhtmjdNvRCbnYtVVbO72kZtwfH3NHupHJwybVAq589zWu0o0nPDla5D0YZwVTHL
 VgMAlHqjL+nE62wBbz4KjlnPTV2Y90RTsKobW3O4AGPrO+86wNyyipEWdv0RnWS8/s/j
 8azg==
X-Gm-Message-State: AOJu0YxwCvpcEmlPSKIiMl6XrsZvxhDm+5p2HdlZHv3euSrL/rdCyO+2
 eDY9W2U2iRlORCQri9Ejh8jAj11RwZahtC+O24GBP/EBjlIObtjXSpgORX3Fnbz0ecEwfmICoSy
 qrpgDZLvuMWy1CGI=
X-Received: by 2002:a05:622a:511:b0:41e:3eef:736d with SMTP id
 l17-20020a05622a051100b0041e3eef736dmr2564795qtx.5.1699971727113; 
 Tue, 14 Nov 2023 06:22:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHblWa6stiZ7FTTBHy1ye4u9VMk+NjGzUbVnt960wmx2q1c9J7sVoms7E8SO/990oqmkVN/Gg==
X-Received: by 2002:a05:622a:511:b0:41e:3eef:736d with SMTP id
 l17-20020a05622a051100b0041e3eef736dmr2564777qtx.5.1699971726804; 
 Tue, 14 Nov 2023 06:22:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o25-20020ac86d19000000b0041cc25a75e5sm2749417qtt.77.2023.11.14.06.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:22:06 -0800 (PST)
Message-ID: <d351d0be-e284-4d09-8b40-aad4253ad5e3@redhat.com>
Date: Tue, 14 Nov 2023 15:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/21] vfio/platform: Make vfio cdev pre-openable by
 passing a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-14-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-14-zhenzhong.duan@intel.com>
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
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/platform.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 98ae4bc655..a97d9c6234 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -531,14 +531,13 @@ static VFIODeviceOps vfio_platform_ops = {
>    */
>   static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>   {
> -    struct stat st;
>       int ret;
>   
> -    /* @sysfsdev takes precedence over @host */
> -    if (vbasedev->sysfsdev) {
> +    /* @fd takes precedence over @sysfsdev which takes precedence over @host */
> +    if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
>           g_free(vbasedev->name);
>           vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> -    } else {
> +    } else if (vbasedev->fd < 0) {
>           if (!vbasedev->name || strchr(vbasedev->name, '/')) {
>               error_setg(errp, "wrong host device name");
>               return -EINVAL;
> @@ -548,10 +547,9 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>                                                vbasedev->name);
>       }
>   
> -    if (stat(vbasedev->sysfsdev, &st) < 0) {
> -        error_setg_errno(errp, errno,
> -                         "failed to get the sysfs host device file status");
> -        return -errno;
> +    ret = vfio_device_get_name(vbasedev, errp);
> +    if (ret) {
> +        return ret;
>       }
>   
>       ret = vfio_attach_device(vbasedev->name, vbasedev,
> @@ -658,6 +656,20 @@ static Property vfio_platform_dev_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static void vfio_platform_instance_init(Object *obj)
> +{
> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
> +
> +    vdev->vbasedev.fd = -1;
> +}
> +
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    vfio_device_set_fd(&VFIO_PLATFORM_DEVICE(obj)->vbasedev, str, errp);
> +}
> +#endif
> +
>   static void vfio_platform_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -665,6 +677,9 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>   
>       dc->realize = vfio_platform_realize;
>       device_class_set_props(dc, vfio_platform_dev_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
> +#endif
>       dc->vmsd = &vfio_platform_vmstate;
>       dc->desc = "VFIO-based platform device assignment";
>       sbc->connect_irq_notifier = vfio_start_irqfd_injection;
> @@ -677,6 +692,7 @@ static const TypeInfo vfio_platform_dev_info = {
>       .name = TYPE_VFIO_PLATFORM,
>       .parent = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(VFIOPlatformDevice),
> +    .instance_init = vfio_platform_instance_init,
>       .class_init = vfio_platform_class_init,
>       .class_size = sizeof(VFIOPlatformDeviceClass),
>   };


