Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FC7EC92C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:03:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JH1-000888-Ad; Wed, 15 Nov 2023 12:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3JGG-0007ul-BH
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3JGE-0001PR-2v
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700067664;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3je50V88qi5vB32tAkI1ec9HuTk6heqqyTmRRyPMnc=;
 b=IoNnBf2lpGiO+UIgFpnzJAHSFl/J1KTQe4alylmj8c8Rf4XsybwOVsHwmUffDEVeikgbb2
 je5p+QJYMsLbPzFMVJH/LIfFU7vRdUzRNbyUspYwUVDxjq4xuCftCrNJBC9di/46EvJxoN
 DX2tfk4hmdaC1oLaVet9W44iYaK8vYk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jJSqzNn9P1iqQJPd5ag6oQ-1; Wed, 15 Nov 2023 12:01:02 -0500
X-MC-Unique: jJSqzNn9P1iqQJPd5ag6oQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d12b547e2so87062166d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 09:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700067662; x=1700672462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3je50V88qi5vB32tAkI1ec9HuTk6heqqyTmRRyPMnc=;
 b=NUinPIYpbk2PqI4WUdTIItUzQ9fkgQntrhJbKQRyGA1ALOZZfuIX0hssBDO6JcEE1q
 r1ZFLkzSPJXeZsxzFXxE2dpvqwMOjAoONby+vp5SfMf5Pr7XKypd/MiVRhwCHNNgaj36
 AXhxrEXLrWDz/9BWh6gVJP84+WH9vRSxHmK7W/aKzUrSQPfPAQjbo06lpiCFNc91QmRV
 E/+GWmcqdig6x0hptNp42mPR3lnK9tYBsh6m9qnRKPP0hss8+1vndsJqZfnHImF3HICi
 b4AGVGdxJkxQ8d5ECxX8LMSG3uRgp++QfK6spmnWmwtKcv82sxUFKmZV0frO24UfM5/k
 etuw==
X-Gm-Message-State: AOJu0YzBppfIC3eOId/BAVSQaYXUqSs7KizzM1m4YVvIOesokR0FausC
 9e3mDXC31oRMvgehEwMaMqc/iqP/MFEJhnSkCXmeffbE717gElxhMZQPM7L9q44pbQLogQ4K19T
 5O09WWrcfEiYzj8Q=
X-Received: by 2002:ad4:5501:0:b0:658:8f94:5e61 with SMTP id
 pz1-20020ad45501000000b006588f945e61mr6200693qvb.43.1700067661935; 
 Wed, 15 Nov 2023 09:01:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiEoMp3PS8rZHeZzyoGYuNMW7aAL9W3c9wFqg9VpOU00Wt4CPp8vVIPCaG6xocEL0IDxDZAw==
X-Received: by 2002:ad4:5501:0:b0:658:8f94:5e61 with SMTP id
 pz1-20020ad45501000000b006588f945e61mr6200666qvb.43.1700067661714; 
 Wed, 15 Nov 2023 09:01:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a0cd60e000000b0066cf06339bcsm677735qvj.0.2023.11.15.09.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 09:01:00 -0800 (PST)
Message-ID: <9f8a07d7-84a2-4cb3-b742-c745ab946609@redhat.com>
Date: Wed, 15 Nov 2023 18:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/21] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 11:09, Zhenzhong Duan wrote:
> This helper will be used by both legacy and iommufd backends.
>
> No functional changes intended.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/pci.h |  3 +++
>  hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
>  2 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index fba8737ab2..1006061afb 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -218,6 +218,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
>  
>  extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>  
> +int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
> +                                    struct vfio_pci_hot_reset_info **info_p);
> +
>  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>  
>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c62c02f7b6..eb55e8ae88 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2445,22 +2445,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>      return (strcmp(tmp, name) == 0);
>  }
>  
> -static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
> +                                    struct vfio_pci_hot_reset_info **info_p)
>  {
> -    VFIOGroup *group;
>      struct vfio_pci_hot_reset_info *info;
> -    struct vfio_pci_dependent_device *devices;
> -    struct vfio_pci_hot_reset *reset;
> -    int32_t *fds;
> -    int ret, i, count;
> -    bool multi = false;
> +    int ret, count;
>  
> -    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
> -
> -    if (!single) {
> -        vfio_pci_pre_reset(vdev);
> -    }
> -    vdev->vbasedev.needs_reset = false;
> +    assert(info_p && !*info_p);
>  
>      info = g_malloc0(sizeof(*info));
>      info->argsz = sizeof(*info);
> @@ -2468,24 +2459,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
>      ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
>      if (ret && errno != ENOSPC) {
>          ret = -errno;
> +        g_free(info);
>          if (!vdev->has_pm_reset) {
>              error_report("vfio: Cannot reset device %s, "
>                           "no available reset mechanism.", vdev->vbasedev.name);
>          }
> -        goto out_single;
> +        return ret;
>      }
>  
>      count = info->count;
> -    info = g_realloc(info, sizeof(*info) + (count * sizeof(*devices)));
> -    info->argsz = sizeof(*info) + (count * sizeof(*devices));
> -    devices = &info->devices[0];
> +    info = g_realloc(info, sizeof(*info) + (count * sizeof(info->devices[0])));
> +    info->argsz = sizeof(*info) + (count * sizeof(info->devices[0]));
>  
>      ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
>      if (ret) {
>          ret = -errno;
> +        g_free(info);
>          error_report("vfio: hot reset info failed: %m");
> +        return ret;
> +    }
> +
> +    *info_p = info;
> +    return 0;
> +}
> +
> +static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +{
> +    VFIOGroup *group;
> +    struct vfio_pci_hot_reset_info *info = NULL;
> +    struct vfio_pci_dependent_device *devices;
> +    struct vfio_pci_hot_reset *reset;
> +    int32_t *fds;
> +    int ret, i, count;
> +    bool multi = false;
> +
> +    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
> +
> +    if (!single) {
> +        vfio_pci_pre_reset(vdev);
> +    }
> +    vdev->vbasedev.needs_reset = false;
> +
> +    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
> +
> +    if (ret) {
>          goto out_single;
>      }
> +    devices = &info->devices[0];
>  
>      trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
>  


