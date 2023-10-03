Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA80B7B6D0C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhI0-0007dK-O3; Tue, 03 Oct 2023 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhHh-0007bY-84
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhHc-0000ou-9d
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696346758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfeqDMYToS9vi5AwVRi/4QgFF3/suxqXGc7/5Ie3SkU=;
 b=CagzzJ/iRcYzGqmZFCd/nBH3ULEXTLZU1xjNETmp/Sn88oaWXYLYM6H/IpWh4VV8xQRWe8
 YOXIy2FZhxrw/iMoVaJksIlXqofVPAhxDTKGMiqsq3YH8Jn3b8xV9wnhdjbFckLBYCypTI
 +6VX1gG0NNbNtjlzhZ31E7nuL/4Ax1k=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-J_7oBpztP4m6DJdGkLqnWg-1; Tue, 03 Oct 2023 11:25:57 -0400
X-MC-Unique: J_7oBpztP4m6DJdGkLqnWg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-59f4f2a9ef0so15604057b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696346756; x=1696951556;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfeqDMYToS9vi5AwVRi/4QgFF3/suxqXGc7/5Ie3SkU=;
 b=w5PRzKOb1VykhTtIx4Qj3sRGupXy83l7HitnUpisvotE2aNWj9UvA6GVcC+cVKJqn2
 qxYsMNfC3Ij99FuL7La34vJ4iSyzxaool/GF9hM/EW9Iy+b/ubNnfdZxoaA8/4ZaluLW
 L/ZsDkcZYNuOCuzJZHWZrs1dS5EOqwfQnQ8nK4iPte2l9d9dRPsFaWvNl5Ldsv/O9b82
 egF33BHEv6q+nSp2LIpenETPTx76/QYw2+Nre1L6QuJWC0NYSSdF4vJKZmHfUrDG/TVN
 5Qm6W1WC1/qKsZBNzGOwLwv34cPnaEUppjZRsWlbFJW5+hjzsybdHEepk46isiz5dcPt
 2gYg==
X-Gm-Message-State: AOJu0YwODt5ocJAnNnVYvW5fhbwkFdHe59k8XhMTsgMezACZLlT1PyUU
 h385T8l4ALvmBmhBoEf0VNShsFEnPKcCnpwT9EzTY86cKXi+qGgSXjj3Ll0FRzkIW4Y/ywi+XAj
 /AgQqlFUJVy7fKASyJEhmYj4=
X-Received: by 2002:a81:bd0c:0:b0:5a4:bf6d:52fb with SMTP id
 b12-20020a81bd0c000000b005a4bf6d52fbmr5795458ywi.48.1696346756438; 
 Tue, 03 Oct 2023 08:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB7QYrZKCkelTP648uIF9OsDPxbHE/CKvqG98zKqOJSVjOnh4+d+2W19wEqzJSqGAOTxoBlg==
X-Received: by 2002:a81:bd0c:0:b0:5a4:bf6d:52fb with SMTP id
 b12-20020a81bd0c000000b005a4bf6d52fbmr5795447ywi.48.1696346756172; 
 Tue, 03 Oct 2023 08:25:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a0cdd0c000000b0062ffbf23c22sm555214qvk.131.2023.10.03.08.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:25:55 -0700 (PDT)
Message-ID: <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
Date: Tue, 3 Oct 2023 17:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 09/15] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-10-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/3/23 12:14, Eric Auger wrote:
> Let the vfio-ap device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> We take the opportunity to use g_path_get_basename() which
> is prefered, as suggested by
> 3e015d815b ("use g_path_get_basename instead of basename")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> ---
> 
> v2 -> v3:
> - Mention g_path_get_basename in commit message and properly free
>    vbasedev->name, call vfio_detach_device
> ---
>   hw/vfio/ap.c | 70 ++++++++++------------------------------------------
>   1 file changed, 13 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e21d1da5a..d0b587b3b1 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
>       .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>   };
>   
> -static void vfio_ap_put_device(VFIOAPDevice *vapdev)
> -{
> -    g_free(vapdev->vdev.name);
> -    vfio_put_base_device(&vapdev->vdev);
> -}
> -
> -static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
> -{
> -    GError *gerror = NULL;
> -    char *symlink, *group_path;
> -    int groupid;
> -
> -    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
> -    group_path = g_file_read_link(symlink, &gerror);
> -    g_free(symlink);
> -
> -    if (!group_path) {
> -        error_setg(errp, "%s: no iommu_group found for %s: %s",
> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
> -        g_error_free(gerror);
> -        return NULL;
> -    }
> -
> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> -        error_setg(errp, "vfio: failed to read %s", group_path);
> -        g_free(group_path);
> -        return NULL;
> -    }
> -
> -    g_free(group_path);
> -
> -    return vfio_get_group(groupid, &address_space_memory, errp);
> -}
> -
>   static void vfio_ap_req_notifier_handler(void *opaque)
>   {
>       VFIOAPDevice *vapdev = opaque;
> @@ -189,22 +155,15 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>   {
>       int ret;
> -    char *mdevid;
>       Error *err = NULL;
> -    VFIOGroup *vfio_group;
>       APDevice *apdev = AP_DEVICE(dev);
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    VFIODevice *vbasedev = &vapdev->vdev;
>   
> -    vfio_group = vfio_ap_get_group(vapdev, errp);
> -    if (!vfio_group) {
> -        return;
> -    }
> -
> -    vapdev->vdev.ops = &vfio_ap_ops;
> -    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
> -    mdevid = basename(vapdev->vdev.sysfsdev);
> -    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> -    vapdev->vdev.dev = dev;
> +    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> +    vbasedev->ops = &vfio_ap_ops;
> +    vbasedev->type = VFIO_DEVICE_TYPE_AP;
> +    vbasedev->dev = dev;
>   
>       /*
>        * vfio-ap devices operate in a way compatible with discarding of
> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>        */
>       vapdev->vdev.ram_block_discard_allowed = true;
>   
> -    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
> +                             &address_space_memory, errp);
>       if (ret) {
> -        goto out_get_dev_err;
> +        g_free(vbasedev->name);
> +        return;
>       }
>   
>       vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
> @@ -225,25 +186,20 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
>            */
> +        vfio_detach_device(vbasedev);
>           error_report_err(err);
> +        g_free(vbasedev->name);
>       }
> -
> -    return;
> -
> -out_get_dev_err:
> -    vfio_ap_put_device(vapdev);
> -    vfio_put_group(vfio_group);
>   }


To be consistent with vfio_(pci)_realize(), I would introduce the same
failure path at the end the routine :

   out_detach:
       vfio_detach_device(vbasedev);
   error:
       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
       g_free(vbasedev->name);


and add the VFIO_MSG_PREFIX while we are at it.

This is minor, so :

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>   
>   static void vfio_ap_unrealize(DeviceState *dev)
>   {
>       APDevice *apdev = AP_DEVICE(dev);
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> -    VFIOGroup *group = vapdev->vdev.group;
>   
>       vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
> -    vfio_ap_put_device(vapdev);
> -    vfio_put_group(group);
> +    vfio_detach_device(&vapdev->vdev);
> +    g_free(vapdev->vdev.name);
>   }
>   
>   static Property vfio_ap_properties[] = {


