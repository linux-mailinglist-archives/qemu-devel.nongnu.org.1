Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BB7AFFAA
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQeh-00040y-NU; Wed, 27 Sep 2023 05:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQee-0003yy-Qf
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQec-0008Bt-RX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695806182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hocqoAnDk1a8hSi8YpcDkIzQXx6gG2GGzbZvejg4uHA=;
 b=f+EpaO8d1Zh2DARjjpbYFc1a7xKbfhzPkaEJRShVl7XMAI5NxFZcsXrVGQ4ePc7qrJzQL/
 JHfXgsX/qteVQeqRxeIm5iRLD1idwwmKJpwCGV0orExU+g4f/bq1k2XfQJ3zGhlBqe6rMH
 jgWNgQR3w/4ab3XzxzrqqKJqtspibQU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-BQvcavJ9Ox2obhE_a_XwGw-1; Wed, 27 Sep 2023 05:16:20 -0400
X-MC-Unique: BQvcavJ9Ox2obhE_a_XwGw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41961124b15so9108711cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 02:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695806180; x=1696410980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hocqoAnDk1a8hSi8YpcDkIzQXx6gG2GGzbZvejg4uHA=;
 b=VUbsLxBU85vYYPZTuLZqh/acgojvcvcZP4V5FJcYjbP5qU2o+cC4fiQKSw6SsThQZC
 ZbP7gOrjfP3JHg8AkVFqaEgiz9DdhOFeF2u/lTSPs7DGJBvO6WxZ37Ty+xW9UBZhCCnP
 JNEkqJf18NsBpUVSsuiD8e1qAWgf8ZSL28A7vTa/EakwHKKrLW8ozGNRUXL4Lw/uM+V8
 8isJ0inNfQZ4/KiO4hdzmAQs/GjsJYC3JNJPiv/gZOZT4gUZ/NI8axTOiFqTqLDNZetB
 l8y/7doytljkzCTEAFK24fnc0uItdUllDriowfi0WSlaoHxHnu+7/QVjS66Di6QByC2/
 z5nQ==
X-Gm-Message-State: AOJu0Yw/tI9klZj/vAg6AGQRzScqlLUDhkZTNPYJCliNOw/NyypRakWJ
 wP5mIxYpSgzRiVPlZD/pqq15FpyzVTGVBfNdNbAFj8UDADAvAd1gibEJN6EKiIkwhA/NhSAz6Xu
 FjlQ5rWDDpjptb7Q=
X-Received: by 2002:a05:622a:1102:b0:419:529e:dcee with SMTP id
 e2-20020a05622a110200b00419529edceemr1134871qty.50.1695806179816; 
 Wed, 27 Sep 2023 02:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMGEweP8pdGUrN1nY+dUi8ViJEZzc+DCsFWq7TYG/YPLyz69K883GwYsAhcwwlVKLD6FMzhw==
X-Received: by 2002:a05:622a:1102:b0:419:529e:dcee with SMTP id
 e2-20020a05622a110200b00419529edceemr1134845qty.50.1695806179494; 
 Wed, 27 Sep 2023 02:16:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 jr2-20020a05622a800200b003eabcc29132sm1066573qtb.29.2023.09.27.02.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 02:16:17 -0700 (PDT)
Message-ID: <78bc5496-a017-4f5a-a825-df992ef86016@redhat.com>
Date: Wed, 27 Sep 2023 11:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 08/12] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 9/26/23 13:32, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> Let the vfio-ap device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/ap.c | 68 +++++++++-------------------------------------------
>  1 file changed, 11 insertions(+), 57 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e21d1da5a..16ea7fb3c2 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
>      .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>  };
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
>  static void vfio_ap_req_notifier_handler(void *opaque)
>  {
>      VFIOAPDevice *vapdev = opaque;
> @@ -189,22 +155,15 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>  static void vfio_ap_realize(DeviceState *dev, Error **errp)
>  {
>      int ret;
> -    char *mdevid;
>      Error *err = NULL;
> -    VFIOGroup *vfio_group;
>      APDevice *apdev = AP_DEVICE(dev);
>      VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
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
I think we shall document in the commit msg the fact we use

g_path_get_basename instead of basename here to match other device init
see 3e015d815b  use g_path_get_basename instead of basename

also leak of vbasedev->name

Eric

> +    vbasedev->ops = &vfio_ap_ops;
> +    vbasedev->type = VFIO_DEVICE_TYPE_AP;
> +    vbasedev->dev = dev;
>  
>      /*
>       * vfio-ap devices operate in a way compatible with discarding of
> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       */
>      vapdev->vdev.ram_block_discard_allowed = true;
>  
> -    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
> +                             &address_space_memory, errp);
>      if (ret) {
> -        goto out_get_dev_err;
> +        g_free(vbasedev->name);
> +        return;
>      }
>  
>      vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
> @@ -227,23 +188,16 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           */
>          error_report_err(err);
>      }
> -
> -    return;
> -
> -out_get_dev_err:
> -    vfio_ap_put_device(vapdev);
> -    vfio_put_group(vfio_group);
>  }
>  
>  static void vfio_ap_unrealize(DeviceState *dev)
>  {
>      APDevice *apdev = AP_DEVICE(dev);
>      VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> -    VFIOGroup *group = vapdev->vdev.group;
>  
>      vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
> -    vfio_ap_put_device(vapdev);
> -    vfio_put_group(group);
> +    vfio_detach_device(&vapdev->vdev);
> +    g_free(vapdev->vdev.name);
>  }
>  
>  static Property vfio_ap_properties[] = {


