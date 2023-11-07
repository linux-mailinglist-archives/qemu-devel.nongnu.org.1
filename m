Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C757E411F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:50:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MSF-0008MY-HS; Tue, 07 Nov 2023 08:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MSC-0008FP-7N
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MRv-0007ML-JZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DH86pLMqosnkB/Sjr7V+a4R+x+nti2QmEtOp6GBaDg=;
 b=YZ9wqntqdrQWg9ZVDIzkkNoC9XuAXRWoLPONOOP4FlrG723q1TQw/qlIA1zYix9HxjNSTn
 cMlGNPt80Nj9ejPrqg62fUCqmiaADJyaB5sRCSHCQj8Fse0PrvEERjbKhSSXzsbBLXQ4od
 HhbJwIIKG6RiTdGVABV85EsGrGc/7co=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-h62q8LIqNfany8Zqk7iWjA-1; Tue, 07 Nov 2023 08:48:57 -0500
X-MC-Unique: h62q8LIqNfany8Zqk7iWjA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d155fc53eso70567136d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699364936; x=1699969736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DH86pLMqosnkB/Sjr7V+a4R+x+nti2QmEtOp6GBaDg=;
 b=Plhra2O4D8iZx0EphZSBpTal8hPkuZYmmF10vnHFBkKNsBMtZ3neTjZd0LRuQm6wh8
 WZ3AcqFKUzyJi6K0zALHMmxMDtem13j8C35S0Hzz/S8vmIDNlgN0fDo5IQrmGwV3vbRn
 NgzAo8H1OL70UsFf2pxIQJHJ9+iweslfEgUTlPJKB7XjMHSmmn2j1U4OsUceAQm7Jxj7
 TPgxR9D4NyDuxPAc90hGrW3NVZbf9jFxX/a95F3nyqLDX6wnN19r9Cb7MPmAvoB/MT5M
 fnGEHi4e8IHfcVXdxpWlWyMy2v5bVCiSPHjmDzqVPxnDN9xYUnYvCgouk0RDsZi+07NY
 Sw1w==
X-Gm-Message-State: AOJu0YyzmtRHNZ5FbdJfJuvr80zncOsRzTk/aGEp8u3sxV5UF9u5/vWg
 brypy7Gbad9XDUhx2RujZDfoeKuXw/2qwiDspcblE3KYxjznHNOuH4IBGsqHl1zavfiLXHMC980
 r0qBg1sEQWoPplMUdTpHngGY=
X-Received: by 2002:a05:6214:240d:b0:655:d9b1:7980 with SMTP id
 fv13-20020a056214240d00b00655d9b17980mr44872328qvb.62.1699364936473; 
 Tue, 07 Nov 2023 05:48:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwkLkuAsySn9/KGE44zR+w9WsvwXrb3VthDlUfTM8kW2pKrrae1BYwfHwO3g1OeekfxHOZLg==
X-Received: by 2002:a05:6214:240d:b0:655:d9b1:7980 with SMTP id
 fv13-20020a056214240d00b00655d9b17980mr44872267qvb.62.1699364935490; 
 Tue, 07 Nov 2023 05:48:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a0ce6a3000000b0066d1d860cd1sm4400986qvn.19.2023.11.07.05.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:48:55 -0800 (PST)
Message-ID: <2c67a08e-e384-4dce-aa54-0385c20c083b@redhat.com>
Date: Tue, 7 Nov 2023 14:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/41] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-32-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-32-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> This helper will be used by both legacy and iommufd backends.
> 
> No functional changes intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.h |  3 +++
>   hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
>   2 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index fba8737ab2..1006061afb 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -218,6 +218,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
>   
>   extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>   
> +int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
> +                                    struct vfio_pci_hot_reset_info **info_p);
> +
>   int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
>   int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c62c02f7b6..eb55e8ae88 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2445,22 +2445,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>       return (strcmp(tmp, name) == 0);
>   }
>   
> -static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
> +                                    struct vfio_pci_hot_reset_info **info_p)
>   {
> -    VFIOGroup *group;
>       struct vfio_pci_hot_reset_info *info;
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
>       info = g_malloc0(sizeof(*info));
>       info->argsz = sizeof(*info);
> @@ -2468,24 +2459,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
>       ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
>       if (ret && errno != ENOSPC) {
>           ret = -errno;
> +        g_free(info);
>           if (!vdev->has_pm_reset) {
>               error_report("vfio: Cannot reset device %s, "
>                            "no available reset mechanism.", vdev->vbasedev.name);
>           }
> -        goto out_single;
> +        return ret;
>       }
>   
>       count = info->count;
> -    info = g_realloc(info, sizeof(*info) + (count * sizeof(*devices)));
> -    info->argsz = sizeof(*info) + (count * sizeof(*devices));
> -    devices = &info->devices[0];
> +    info = g_realloc(info, sizeof(*info) + (count * sizeof(info->devices[0])));
> +    info->argsz = sizeof(*info) + (count * sizeof(info->devices[0]));
>   
>       ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
>       if (ret) {
>           ret = -errno;
> +        g_free(info);
>           error_report("vfio: hot reset info failed: %m");
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
>           goto out_single;
>       }
> +    devices = &info->devices[0];
>   
>       trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
>   


