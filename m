Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546627DBB3D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSoE-0001Hv-Tf; Mon, 30 Oct 2023 10:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSoC-0001EX-56
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSoA-00023G-DV
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698674397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ae68IDfv1Q1Z7BFqiiwzvpF++Xiza49F+kR4rCwOmvA=;
 b=c52n8GcZ5rIQ2HVW9bFYsunbBZmORij9MKc0Yl+1LJ2IqmUIqGlkgjnE7PDKzWilsRrM/4
 EhrmxZ4oV+Ui1uXS1cEpm+LXWMz2pYuuxAUTf9+RdGp5kMj9hDdCBds+2wVRxeOkM5fsz3
 NdITEa65omEnlIEp6z1vEz/lItNrRrs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-MlNOkaiwPOapP-y9Ine2Ow-1; Mon, 30 Oct 2023 09:59:55 -0400
X-MC-Unique: MlNOkaiwPOapP-y9Ine2Ow-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778964b7c8bso561077785a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698674395; x=1699279195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ae68IDfv1Q1Z7BFqiiwzvpF++Xiza49F+kR4rCwOmvA=;
 b=Ut6pOmI8XNfaURAfVsKmFkT3d0ldr95498W5oScVFW3uXdU9nyxZuBpFhNeiSKHNdt
 8eCF3RGmfN2B4xf/c+JsDN6EGzIDxWsdWxlyDZPtLGnsQRO2BI5GQSBBf0f2jBVKaFV8
 NXDDzumZoRG7Os6XY6avKbur4wWLAqh5tJ/+7s2o54aKKEJEndKm+wJ/uMaK893JZExY
 1J54seIG46h83LXoW42y3+P2vtrp2qXtTFDTxXWejGSnl+Rsz3HeGp7eQuSLex6EoCLF
 Rz5j36jy/gWbZlph1Tkt9jvi/3gQsvgnz6vw+BfTRRMV/EdKm8ZvcGnSmXr2al/OjZW0
 yI1A==
X-Gm-Message-State: AOJu0Yw8vcAAbgvxeDdTzp7agvCNeSBTYOkDePVFdOHTWyjfa+nflzy/
 m9Qlh1oO6U8Dsk7sid84mvyZVAZdggp9K2IIDQwI0rVX2PUFY8oYTgObPw4heIdn41HrrjshxX/
 RcIt4+OG0pWZ6ReY=
X-Received: by 2002:a05:620a:6649:b0:773:c19f:9b9 with SMTP id
 qg9-20020a05620a664900b00773c19f09b9mr8504629qkn.46.1698674395331; 
 Mon, 30 Oct 2023 06:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXMa+izLKdNDeVWdH4s09veKlCpbNQDlvxfTv9SeAKVm1ghashHQnFcjRE2xO0bvrQpn6/9Q==
X-Received: by 2002:a05:620a:6649:b0:773:c19f:9b9 with SMTP id
 qg9-20020a05620a664900b00773c19f09b9mr8504617qkn.46.1698674395101; 
 Mon, 30 Oct 2023 06:59:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a05620a110100b0076d25b11b62sm3325505qkk.38.2023.10.30.06.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 06:59:54 -0700 (PDT)
Message-ID: <8127aa87-c946-4db1-b4ae-cdfced09d157@redhat.com>
Date: Mon, 30 Oct 2023 14:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/37] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-31-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-31-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> This helper will be used by both legacy and iommufd backends.
> 
> No functional changes intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

I think we can merge this change before hand.

Thanks,

C.


> ---
>   hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5cbc771e55..c17e1f4376 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2459,22 +2459,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>       return (strcmp(tmp, name) == 0);
>   }
>   
> -static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +static int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
> +                                       struct vfio_pci_hot_reset_info **info_p)
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
> @@ -2482,24 +2473,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
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


