Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FCAC3F31
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 14:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWk4-0008G5-Ux; Mon, 26 May 2025 08:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWk0-0008Fw-Sx
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWjm-0008GI-VE
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748261724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xO526LJ2vdB0zr25IS+Y6O8/PNTGO6HEBjKHok9NYXQ=;
 b=X6Z98Zct4gS6Rl6w0B0jhegZoNbrdCl2qbA4QswsYGe3sGuC88EK0lnQCeNtoXBvnPD6pZ
 iHIXdGn+Mo2Sw+MiCd+kVyiFVPQ9eKlj3yW9GY6LAGXtI/uzD9jcTe9dYwBkoXGBvI8JNu
 HXa+2rcHPUSdzzpMD406xVc+wayRzHo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-BbnNBFtLPVOhDhk_X_uiVw-1; Mon, 26 May 2025 08:15:22 -0400
X-MC-Unique: BbnNBFtLPVOhDhk_X_uiVw-1
X-Mimecast-MFC-AGG-ID: BbnNBFtLPVOhDhk_X_uiVw_1748261721
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so12859355e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 05:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748261721; x=1748866521;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xO526LJ2vdB0zr25IS+Y6O8/PNTGO6HEBjKHok9NYXQ=;
 b=OlEp0vz7ptrcClvJQmb9LagAnWcpHcon2C6Z0tqWnwXAqYDsCGOLQfmTY4gj1ko7qW
 YK+p0+NEsvQjpuJV6Qdx7CitxJ7pSNI5CN1cbh8i+PGbVEXaAsSOlRm16hIkZ120KcSR
 3WDTYSUOViy071QCNMJ4yP3tMSzs2d1p9+f5YAqO8kPIYJiSFlAm7sZFx1VghrUvzN+e
 2iM06m7MyTNSVuBoSL3Fv/Rikkmch25lDMI2vxN900p9ta+ufWpr5raD5IxIzxTI59hE
 Y4ExzMDeTxYdFfTQ1Gm028/A5m03uqnpAu07fUZPleSV88g49KK18/FeLlsiN8NULlDm
 AozQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvCIWUp0S03/CJxYIRLmUNMPWe2iVyXihN+Gw1Ga5/TKBU6UgWj4wp9w4sHr77w0M2rLybbcpcIRG5@nongnu.org
X-Gm-Message-State: AOJu0YwLEeKsvb5SWzsooLEgAX2g/x1I9ZDI+riSA7mlWEYbntpG4hUy
 HKZpXMGxTtMTmTvrh+WCRsfZmf1GxPBqEwi0zr2cCCppx7WqpWjVxgFunALTQRyB7Kpd8FoViJm
 NLWIz5Cteni/Hdi0eaZZZVEaws9RZq48k/wJMKiA58Ir20TyCwXIM9KUp
X-Gm-Gg: ASbGncuszHHXplUz5leOiHcY8i2nNQt02ZvV9FhpvxIzemlzgKopLAaNz5b7rNaVEcr
 yU7Cmtt2k0saOmQoAExz7M7pjo/P3wqLP3qUMqu6t8tId7ZSdRb0q2xM+pxs2N0b93BEqK45a0S
 dB+0LahiV2ioAwXAHzHdbXEIlAGLQKER4v74iqKR6bRQBMRhXs3kHy+wR8nyaONPmN/QZ78PlHN
 AOYD6hviintl0SLNU7/w/tMNsCvowK/GqBaOkVXJgXKkrSVODxIYURtiMhobuJ+Bwyrt9GnYOB+
 MqnH3wkkwxmWF3a/bRzBKBEr44xOWW3APAxoH5QlpKxShMU2XA==
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-44c919e13ddmr98352845e9.10.1748261721378; 
 Mon, 26 May 2025 05:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvxyphRGhlo0Fj93nMBQXLnEBNafODVVMvdT1TYrqS8WlnSa2T2VMfP8947SfUB8IO1I2GPQ==
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-44c919e13ddmr98352335e9.10.1748261720959; 
 Mon, 26 May 2025 05:15:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a79asm34533968f8f.25.2025.05.26.05.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:15:20 -0700 (PDT)
Message-ID: <0212e796-9869-47ea-bcab-0d86bae2580e@redhat.com>
Date: Mon, 26 May 2025 14:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-6-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250521111452.3316354-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Zhenzhong,

On 5/21/25 13:14, Zhenzhong Duan wrote:
> Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
> specific. Save them all in a new defined structure mirroring that vendor
> IOMMU's structure, then get_cap() can query those information for
> capability.
> 
> We can't use the vendor IOMMU's structure directly because they are in
> linux/iommufd.h which breaks build on windows.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/host_iommu_device.h | 12 ++++++++++++
>   hw/vfio/iommufd.c                  | 12 ++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 809cced4ba..908bfe32c7 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -15,6 +15,17 @@
>   #include "qom/object.h"
>   #include "qapi/error.h"
>   
> +/* This is mirror of struct iommu_hw_info_vtd */
> +typedef struct Vtd_Caps {

please name the struct VtdCaps instead.


Thanks,

C.



> +    uint32_t flags;
> +    uint64_t cap_reg;
> +    uint64_t ecap_reg;
> +} Vtd_Caps;
> +
> +typedef union VendorCaps {
> +    Vtd_Caps vtd;
> +} VendorCaps;
> +
>   /**
>    * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>    *
> @@ -26,6 +37,7 @@
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
>       uint64_t hw_caps;
> +    VendorCaps vendor_caps;
>   } HostIOMMUDeviceCaps;
>   
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index d661737c17..5c740222e5 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -834,6 +834,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       VFIODevice *vdev = opaque;
>       HostIOMMUDeviceIOMMUFD *idev;
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    VendorCaps *vendor_caps = &caps->vendor_caps;
>       enum iommu_hw_info_type type;
>       union {
>           struct iommu_hw_info_vtd vtd;
> @@ -852,6 +853,17 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       caps->type = type;
>       caps->hw_caps = hw_caps;
>   
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        vendor_caps->vtd.flags = data.vtd.flags;
> +        vendor_caps->vtd.cap_reg = data.vtd.cap_reg;
> +        vendor_caps->vtd.ecap_reg = data.vtd.ecap_reg;
> +        break;
> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
> +    case IOMMU_HW_INFO_TYPE_NONE:
> +        break;
> +    }
> +
>       idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
>       idev->iommufd = vdev->iommufd;
>       idev->devid = vdev->devid;


