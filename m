Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820787EB178
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u1d-000257-AY; Tue, 14 Nov 2023 09:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u1X-00023U-57
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u1T-0000oL-OD
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6bDnWBFrB+QFP5Zd2QKrW1KKBPqlmKdkzVKfCobBxQ=;
 b=MlMSNkTUMSjwdmaHws6CHeB5liJZq9kAQdwF2v2WAjPSvpZV6I4XcVy+8Cmmi2isPGSjI0
 MqdNu/w1dJ0GOC3UORAolFnGNeetWEsa66xXvNc90BBGDmopgUZdAqbt23J3+o0f7k+ky4
 mIQv/l1ZeqwbE27ZOwfSEm1a6jZa8D0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-_pQz7jrfOYWmrKvv3Ut1qA-1; Tue, 14 Nov 2023 09:04:08 -0500
X-MC-Unique: _pQz7jrfOYWmrKvv3Ut1qA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e1d05a5d7so55817761cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970648; x=1700575448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6bDnWBFrB+QFP5Zd2QKrW1KKBPqlmKdkzVKfCobBxQ=;
 b=Yp6cSNhqK+rI07UzhaehH7qNr1j6ylQDJ7ul77Eomw7fsAVKjh4YOiyWmizXR3oulN
 TksBwBAh58oB2BCa7eXv4iMESeYcQsdEFmIvEkjvfqi/jcvtFx7guQVbAqTXY1dV4CIr
 ZiX59Oanvc7MhTevxlRLQv55eEGAyRFw6XY992ulANyGMeAXH8Zx98Yjyt08XrZg1Ggr
 1H9i5nj6a8dPBbX4+LJkJgFSlgqrwPSYBUUA3eNaFxxR+Mr4jsolekMoYbfI+9MkclcD
 4fy9RbpauXQYiOsvC44O2vvyl587OnVY6toR7KcyTzsewcFDqtBH2cxa2NH66dVJ4ZVn
 IoiQ==
X-Gm-Message-State: AOJu0YwzkELqi3dxes1w/ZlmK4RWA0y/+/9kEGWgqs6Uecb0D7JU2xNf
 NjQ5m8iWulcOuDlsG2jENoQyMxuMj4TcghsGMnWfla66cMDT7Z0AGq9+1wTnlvhSVlvcqcgEOvm
 M7gsmRuw9WFVoBP8=
X-Received: by 2002:ac8:5812:0:b0:41c:be07:c6c7 with SMTP id
 g18-20020ac85812000000b0041cbe07c6c7mr2331115qtg.24.1699970647946; 
 Tue, 14 Nov 2023 06:04:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTs92WlGvSRzvEDnQirqd8+ukTdB+uQf1RD3MXnf7pMSBJ1uVQZ38+aQDhLzFITD76G1e2eA==
X-Received: by 2002:ac8:5812:0:b0:41c:be07:c6c7 with SMTP id
 g18-20020ac85812000000b0041cbe07c6c7mr2331083qtg.24.1699970647624; 
 Tue, 14 Nov 2023 06:04:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:04:07 -0800 (PST)
Message-ID: <abd964a0-fadb-4554-b537-a9f355be54c9@redhat.com>
Date: Tue, 14 Nov 2023 15:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/21] vfio/ap: Make vfio cdev pre-openable by passing
 a file handle
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
 <20231114100955.1961974-16-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-16-zhenzhong.duan@intel.com>
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
>   hw/vfio/ap.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 80629609ae..b21f92291e 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -160,7 +160,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
> @@ -230,11 +233,28 @@ static const VMStateDescription vfio_ap_vmstate = {
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
> +    vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
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
> @@ -249,6 +269,7 @@ static const TypeInfo vfio_ap_info = {
>       .name = TYPE_VFIO_AP_DEVICE,
>       .parent = TYPE_AP_DEVICE,
>       .instance_size = sizeof(VFIOAPDevice),
> +    .instance_init = vfio_ap_instance_init,
>       .class_init = vfio_ap_class_init,
>   };
>   


