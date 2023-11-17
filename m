Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150917EF174
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 12:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3wjZ-0007vh-Ci; Fri, 17 Nov 2023 06:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3wjX-0007vL-MC
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3wjV-0006Eb-Se
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700219396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xfv06s9XBW67WG4Ep1QpNZHrSDcfX2a7A0dxM4LaUmI=;
 b=fc5/f6EZUJx7jhW+2Cr/nOaWL1Mu6vMJ+Z9TYCpu00ICepUHRjyxwtwWO+JLCEaulm2STN
 KP+xnwMCsUJQa9ET9x1VecLiPDbNQHKcOvC93lP50Fpy+U/3va18QQwZo1QR/4yLZe5jF6
 lGhlGlUTIKsr7lu0Gg26zf5bDBI7LHU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-NAn2AZFpMVacCXs0kFqNHA-1; Fri, 17 Nov 2023 06:09:55 -0500
X-MC-Unique: NAn2AZFpMVacCXs0kFqNHA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77bbd4f45ebso193584685a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 03:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700219395; x=1700824195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xfv06s9XBW67WG4Ep1QpNZHrSDcfX2a7A0dxM4LaUmI=;
 b=tNdu+jGDQ69WlF0iM/Iz2LZ/GfAEiKILfI8P90LovbNn+7ps5WNRDGlmkpW2brcpuB
 5kWGUW3rGn31E5IECppjKJozMjd2DEKC8aOnto/1p5xAJBwaHzJvWzXE/fMCi5QiBRF6
 I3obRHD/9JXqKqBf095RvdATpjmBTFEIUzrL+ziuXnMfDq/Hcv2t0XlEgqV1n+OL6n5G
 ILRqYbYZhzwj/3FSj691AjGcISJ2LMxaFn04uTIWZMDhHskpE6k+DfIPhAV+tg3sn1WI
 KRLve3R5X5g011vrFCTZq2mL/afa52+U/gAjPULResuYCvG7rHQZ85qcLcpXDwfKDgVi
 O5wA==
X-Gm-Message-State: AOJu0YxqsM7RbQ+Y0lJBjkgFFI8DxV4g4Rhgz5zypzMAXr35+yf8wozE
 /LQ9O7TgTFgtok+/rbFLKJZWBdMEu6raXBWqu5h8VTCeZymkX31nJV7rVbWldMlDdjGZyuWibak
 wRlKZtdJc1Gz2Big=
X-Received: by 2002:a05:620a:3a4c:b0:77b:aaf8:df98 with SMTP id
 sk12-20020a05620a3a4c00b0077baaf8df98mr9046366qkn.69.1700219395182; 
 Fri, 17 Nov 2023 03:09:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHumvr5M+ArwHGkdtD3s5xjzoimrdh82iAwzlknbfDmly8D8QZAI+IbIifI6/IP08q3DzlvCg==
X-Received: by 2002:a05:620a:3a4c:b0:77b:aaf8:df98 with SMTP id
 sk12-20020a05620a3a4c00b0077baaf8df98mr9046350qkn.69.1700219394949; 
 Fri, 17 Nov 2023 03:09:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 pq2-20020a05620a84c200b007788bb0ab8esm519262qkn.19.2023.11.17.03.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 03:09:54 -0800 (PST)
Message-ID: <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
Date: Fri, 17 Nov 2023 12:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_ioas_map map = {
> +        .size = sizeof(map),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .ioas_id = ioas_id,
> +        .__reserved = 0,
> +        .user_va = (uintptr_t)vaddr,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    if (!readonly) {
> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
> +                                  vaddr, readonly, ret);
> +    if (ret) {
> +        ret = -errno;
> +        error_report("IOMMU_IOAS_MAP failed: %m");
> +    }
> +    return ret;
> +}

When using a UEFI guest, QEMU reports errors when mapping regions
in the top PCI space :

   iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000001000 size=0x3000 addr=0x7fce2c28b000 readonly=0 (-1)
   qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
   qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150, 0x380000001000, 0x3000, 0x7fce2c28b000) = -22 (Invalid argument)

   iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000004000 size=0x4000 addr=0x7fce2c980000 readonly=0 (-1)
   qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
   qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150, 0x380000004000, 0x4000, 0x7fce2c980000) = -22 (Invalid argument)

This is because IOMMUFD reserved IOVAs areas are :

  [ fee00000 - feefffff ]
  [ 8000000000 - ffffffffffffffff ] (39 bits address space)

which were allocated when the device was initially attached.
The topology is basic. Something is wrong.

Thanks,

C.


