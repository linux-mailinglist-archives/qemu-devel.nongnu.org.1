Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E958CAEAD
	for <lists+qemu-devel@lfdr.de>; Tue, 21 May 2024 14:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9P0f-0004jG-TA; Tue, 21 May 2024 08:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9P0Y-0004SM-4g
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9P0U-0005ns-Ar
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716296056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5bFhftGrkOaKS5dqV0ZL9P5jw4L5e6ejLPVbeeiXho=;
 b=NMWwWcncKt66S5s+nbDC4RmUMTXp6WW+nj3FzmWhFBAfXG3AsDxAc7l170/zvDMoRhsLWW
 icu8PZ0Husx6h0WdRVMeEnGPs0do540afo4AtakW+LJzKN/MXCzLskdMVmQglVTjOysH79
 h/xkxosf5FGIvMni1ZQMBmRrJfbj6Gg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-ggJFs5DUPGya_3St21ijCQ-1; Tue, 21 May 2024 08:54:15 -0400
X-MC-Unique: ggJFs5DUPGya_3St21ijCQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5729fd97df9so29989a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716296054; x=1716900854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5bFhftGrkOaKS5dqV0ZL9P5jw4L5e6ejLPVbeeiXho=;
 b=uCiPOUYXlfV3Vn+m2fd1NpYZj1pyM69Y/swsGh10Kb7P3UegbkVwflEISzoHeFVxSj
 g44je4Pl+5r8pz16SKEP9Cvc97b9S+dm0tVFhvLnOYjGzhELCGgzZalpiR4S9WlTpwf4
 GyfRZhsrveUkh2p3xuTmS00EtGQPQv4B00QnyCiJFmE7rTf/Ccyf+AWRNeQc7tpFEG6v
 j8Zho6wo/UPwOCyquADfe00y5AtwyAu9wcPhXA6NPq2RKf97BNafJaz0PataVao/DFfX
 ZpKRXo/MzIBTNclvoWssbgIPF1zzELSSUiwwGa9SJxZvp3E996hrEvz+TrDVfGAjxZTv
 yhsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5GJO2GVi24tswo+vJdnKlEwaJme80GLQSYf3JJgI6fbrNo3w3AoXx3dqqQkm3rjds+2DCLB0dxD+XzWDrhKbWYQ+mLf8=
X-Gm-Message-State: AOJu0YxuJ0q7nhSQgRPBRxWaEuxpf0GaHUZGNG+6J1/oo++vIuqSQIFH
 7JKDvrBONhEAzkMZH/kTtPMuOeN3A58rArVtKJYQZgD9lDdxzqdLQuV2BGr8QbTjgUHTt29f+4h
 Hzseimu7wW1gW4L4t6xIK3jK5fcYgSIYOqaKVDZVBbXCjwHoV6mMd
X-Received: by 2002:aa7:d294:0:b0:574:eb43:3865 with SMTP id
 4fb4d7f45d1cf-574eb433921mr12518091a12.32.1716296053813; 
 Tue, 21 May 2024 05:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa7kyt6dumS+csJJkSpt9F7yxjv8TDts5Xuv61EcmBFXEXByVc7tmqF6DA8uUf51KSzLrWtA==
X-Received: by 2002:aa7:d294:0:b0:574:eb43:3865 with SMTP id
 4fb4d7f45d1cf-574eb433921mr12518075a12.32.1716296053414; 
 Tue, 21 May 2024 05:54:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5750b47411csm6820829a12.75.2024.05.21.05.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:54:12 -0700 (PDT)
Message-ID: <acd14e4b-bf3a-437d-a0a1-aa8618750d17@redhat.com>
Date: Tue, 21 May 2024 14:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] vfio/pci: Make capability related functions return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-14-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> The functions operating on capability don't have a consistent return style.
> 
> Below functions are in bool-valued functions style:
> vfio_msi_setup()
> vfio_msix_setup()
> vfio_add_std_cap()
> vfio_add_capabilities()
> 
> Below two are integer-valued functions:
> vfio_add_vendor_specific_cap()
> vfio_setup_pcie_cap()
> 
> But the returned integer is only used for check succeed/failure.
> Change them all to return bool so now all capability related
> functions follow the coding standand in qapi/error.h to return
> bool.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 77 ++++++++++++++++++++++++---------------------------
>   1 file changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1922593253..ecfbb9619f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1339,7 +1339,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> +static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   {
>       uint16_t ctrl;
>       bool msi_64bit, msi_maskbit;
> @@ -1349,7 +1349,7 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
>                 vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
>           error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
> -        return -errno;
> +        return false;
>       }
>       ctrl = le16_to_cpu(ctrl);
>   
> @@ -1362,14 +1362,14 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
>       if (ret < 0) {
>           if (ret == -ENOTSUP) {
> -            return 0;
> +            return true;
>           }
>           error_propagate_prepend(errp, err, "msi_init failed: ");
> -        return ret;
> +        return false;
>       }
>       vdev->msi_cap_size = 0xa + (msi_maskbit ? 0xa : 0) + (msi_64bit ? 0x4 : 0);
>   
> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
> @@ -1644,7 +1644,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       return vfio_pci_relocate_msix(vdev, errp);
>   }
>   
> -static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> +static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   {
>       int ret;
>       Error *err = NULL;
> @@ -1660,11 +1660,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       if (ret < 0) {
>           if (ret == -ENOTSUP) {
>               warn_report_err(err);
> -            return 0;
> +            return true;
>           }
>   
>           error_propagate(errp, err);
> -        return ret;
> +        return false;
>       }
>   
>       /*
> @@ -1698,7 +1698,7 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>           memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>       }
>   
> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_teardown_msi(VFIOPCIDevice *vdev)
> @@ -1977,8 +1977,8 @@ static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
> -                               Error **errp)
> +static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
> +                                Error **errp)
>   {
>       uint16_t flags;
>       uint8_t type;
> @@ -1992,7 +1992,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>   
>           error_setg(errp, "assignment of PCIe type 0x%x "
>                      "devices is not currently supported", type);
> -        return -EINVAL;
> +        return false;
>       }
>   
>       if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
> @@ -2025,7 +2025,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>           }
>   
>           if (pci_bus_is_express(bus)) {
> -            return 0;
> +            return true;
>           }
>   
>       } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
> @@ -2063,7 +2063,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                * Legacy endpoints don't belong on the root complex.  Windows
>                * seems to be happier with devices if we skip the capability.
>                */
> -            return 0;
> +            return true;
>           }
>   
>       } else {
> @@ -2099,12 +2099,12 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>       pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
>                                errp);
>       if (pos < 0) {
> -        return pos;
> +        return false;
>       }
>   
>       vdev->pdev.exp.exp_cap = pos;
>   
> -    return pos;
> +    return true;
>   }
>   
>   static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
> @@ -2137,14 +2137,14 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>       }
>   }
>   
> -static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> -                                        uint8_t size, Error **errp)
> +static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> +                                         uint8_t size, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>   
>       pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
>       if (pos < 0) {
> -        return pos;
> +        return false;
>       }
>   
>       /*
> @@ -2156,15 +2156,15 @@ static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
>           memset(pdev->cmask + pos + 3, 0, size - 3);
>       }
>   
> -    return pos;
> +    return true;
>   }
>   
> -static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> +static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>   {
>       ERRP_GUARD();
>       PCIDevice *pdev = &vdev->pdev;
>       uint8_t cap_id, next, size;
> -    int ret;
> +    bool ret;
>   
>       cap_id = pdev->config[pos];
>       next = pdev->config[pos + PCI_CAP_LIST_NEXT];
> @@ -2185,9 +2185,8 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>        * will be changed as we unwind the stack.
>        */
>       if (next) {
> -        ret = vfio_add_std_cap(vdev, next, errp);
> -        if (ret) {
> -            return ret;
> +        if (!vfio_add_std_cap(vdev, next, errp)) {
> +            return false;
>           }
>       } else {
>           /* Begin the rebuild, use QEMU emulated list bits */
> @@ -2197,7 +2196,7 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>   
>           ret = vfio_add_virt_caps(vdev, errp);
>           if (ret) {
> -            return ret;
> +            return false;
>           }
>       }
>   
> @@ -2221,28 +2220,27 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>       case PCI_CAP_ID_PM:
>           vfio_check_pm_reset(vdev, pos);
>           vdev->pm_cap = pos;
> -        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> +        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
>           break;
>       case PCI_CAP_ID_AF:
>           vfio_check_af_flr(vdev, pos);
> -        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> +        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
>           break;
>       case PCI_CAP_ID_VNDR:
>           ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
>           break;
>       default:
> -        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> +        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
>           break;
>       }
>   
> -    if (ret < 0) {
> +    if (!ret) {
>           error_prepend(errp,
>                         "failed to add PCI capability 0x%x[0x%x]@0x%x: ",
>                         cap_id, size, pos);
> -        return ret;
>       }
>   
> -    return 0;
> +    return ret;
>   }
>   
>   static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
> @@ -2388,23 +2386,21 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>       return;
>   }
>   
> -static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
> -    int ret;
>   
>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>           !pdev->config[PCI_CAPABILITY_LIST]) {
> -        return 0; /* Nothing to add */
> +        return true; /* Nothing to add */
>       }
>   
> -    ret = vfio_add_std_cap(vdev, pdev->config[PCI_CAPABILITY_LIST], errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_add_std_cap(vdev, pdev->config[PCI_CAPABILITY_LIST], errp)) {
> +        return false;
>       }
>   
>       vfio_add_ext_cap(vdev);
> -    return 0;
> +    return true;
>   }
>   
>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
> @@ -3136,8 +3132,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_register(vdev);
>   
> -    ret = vfio_add_capabilities(vdev, errp);
> -    if (ret) {
> +    if (!vfio_add_capabilities(vdev, errp)) {
>           goto out_teardown;
>       }
>   


