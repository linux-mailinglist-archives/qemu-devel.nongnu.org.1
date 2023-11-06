Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0F7E2A8A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02wj-0004GM-Tt; Mon, 06 Nov 2023 11:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02wd-0004Ag-R9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02wc-0004Ak-B7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFJz7E7pAKgxG6wYH08T5PtR59Z/udkMLNmLFz3fQXs=;
 b=T0skjLYTT1eIhjqgvuBKBrSYPupB+cRZP76O62HsVT4nxDDGAOKXBYDw2TH+DYWnhPnKln
 JDOWb+hWadCYg96fe38g68i5pp9c8tBn8H36GDH97no/onnaMBD126spNwbVUdirv1zRpq
 lKIjA7M5ulwD9ejJfb5emTe4qGTbZHQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-y9iZEVVWNemrUOKMa5T4rw-1; Mon, 06 Nov 2023 11:59:18 -0500
X-MC-Unique: y9iZEVVWNemrUOKMa5T4rw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66fbd02d104so58898456d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289958; x=1699894758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFJz7E7pAKgxG6wYH08T5PtR59Z/udkMLNmLFz3fQXs=;
 b=NEDTanPJoM05PWoWrAKVJNhRjZUa1er6PqY/pR9eBGI9534PC02bQsBFG+ASXaaJ6y
 Q+DeUSOjSe8Xo+z1OSj44IRFHQA3000+2FqIqYv5Tb7Z14zT8cA3clUbTipmVxV5Ft4o
 kLJS0o2zk0JOmsgJxuWRjX+glo+qrK/CkFdwjgULNQEh3fvx3TWTjo6ZBQ4hH7FtgReK
 uner1m2L9Wn4gywkDw/x7Mvh8Bq7UVTnaQWdAFecjd+LyIPNagm2cT0kYJeKcL7WYhH1
 dcjTYNzxH0Vhaw6Fev6B1zrToFUnxGwUSvn47jzfSBIGZ+O+BL+0RrhOligW32eU6Tpd
 CWvA==
X-Gm-Message-State: AOJu0YxNTz1HthnRQEMV92oYyAVIWCJhX+Ska0uTtLNMdBhrWmN9r3Af
 CwRbH4WkoUFwb3oT0T1kCzZTtXpeUunuml6Bn/KAPNCC8R2bQ2FHV1GSvEKb+XVUYWTaWrxQJ6A
 c/HLPCfruTyPLPpw=
X-Received: by 2002:a05:6214:76e:b0:66d:3716:4e11 with SMTP id
 f14-20020a056214076e00b0066d37164e11mr40779101qvz.38.1699289957923; 
 Mon, 06 Nov 2023 08:59:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVARghf0pRKeq50FS0FO2Lzfj1NFCEIXhErg+nVsRZZPDSSSu3ODzWPn6nietTTI0u5mAFZA==
X-Received: by 2002:a05:6214:76e:b0:66d:3716:4e11 with SMTP id
 f14-20020a056214076e00b0066d37164e11mr40779091qvz.38.1699289957701; 
 Mon, 06 Nov 2023 08:59:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a0cfd61000000b006616fbcc077sm3584120qvs.129.2023.11.06.08.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:59:17 -0800 (PST)
Message-ID: <f4e86e43-0dba-4ed8-9086-9dde228da65e@redhat.com>
Date: Mon, 6 Nov 2023 17:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/41] vfio/container: Implement attach/detach_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-21-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-21-zhenzhong.duan@intel.com>
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/vfio/common.c    | 16 ++++++++++++++++
>   hw/vfio/container.c | 12 +++++-------
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8ef2e7967d..483ba82089 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1498,3 +1498,19 @@ retry:
>   
>       return info;
>   }
> +
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp)
> +{
> +    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
> +
> +    return ops->attach_device(name, vbasedev, as, errp);
> +}
> +
> +void vfio_detach_device(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->bcontainer) {
> +        return;
> +    }
> +    vbasedev->bcontainer->ops->detach_device(vbasedev);
> +}
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 721c0d7375..6bacf38222 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -873,8 +873,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>    * @name and @vbasedev->name are likely to be different depending
>    * on the type of the device, hence the need for passing @name
>    */
> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                       AddressSpace *as, Error **errp)
> +static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
> +                                     AddressSpace *as, Error **errp)
>   {
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
> @@ -914,14 +914,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> -void vfio_detach_device(VFIODevice *vbasedev)
> +static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> -    if (!vbasedev->bcontainer) {
> -        return;
> -    }
> -
>       QLIST_REMOVE(vbasedev, global_next);
>       QLIST_REMOVE(vbasedev, container_next);
>       vbasedev->bcontainer = NULL;
> @@ -933,6 +929,8 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   const VFIOIOMMUOps vfio_legacy_ops = {
>       .dma_map = vfio_legacy_dma_map,
>       .dma_unmap = vfio_legacy_dma_unmap,
> +    .attach_device = vfio_legacy_attach_device,
> +    .detach_device = vfio_legacy_detach_device,
>       .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
>       .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
>   };


