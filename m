Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0A831956
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:43:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRjR-0007pX-8D; Thu, 18 Jan 2024 07:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRjP-0007na-Nb
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQRjN-0003Ez-Il
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705581769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nmy/FmslpayADQrOliIvES+9OsND42okfKZwWFcVfx0=;
 b=MdJ7dgKsOmy1oJPDuYp0p4WPBN9gr11KpuxxOXJN3K9/zfe7FgwqY60+FVSls1ME4v7os3
 cBXexmjsR5HJ3q0oDPjS0w3WrPaQQgkQCXWSyfB7PcQAtc2soEBkACaYpOJNumWmMwxsJd
 7ALMc7K2xIsJgASb57UziaFRzrAfurk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-5Mdb2H8pMF6CrJ3Dc2BiyQ-1; Thu, 18 Jan 2024 07:42:47 -0500
X-MC-Unique: 5Mdb2H8pMF6CrJ3Dc2BiyQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7833761135dso1213390385a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705581767; x=1706186567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nmy/FmslpayADQrOliIvES+9OsND42okfKZwWFcVfx0=;
 b=p74zZA58VECTEb2wjYwEAIznOh7HfV7xbc76xw75niQtHnR31XIvpmpJbQ0I+2HBrB
 +h/B+BrLrO1A71iUCPEt0qj1LueqFD3j35dj0M1Mm6PwMDiZReeGXkS6AfaS7lD/XbkO
 2FhQmhj0LS+m1CtYNHiRNAlp1Nsf4FPB+5GvH1OyUW6GblvXArXg8M50UiadD7yuI2lM
 oh3wi2Qjy2ToZXf7WPkgxBNis+QWG+0icKRO1HV94Ptdr70CnPExT+a5gNaiU/uoUVYv
 /JwPSuKR4YuHKGkofUwfeIFNYofaEeAQIFx16xY4zctwp61aJVz90G343pPBRCHTc8gL
 ltIQ==
X-Gm-Message-State: AOJu0YztH9IBu7IJ0n85Wn8Tm0isJoyDGXpTHPuzvHETEVnfDSH59LsZ
 vB4Hq0OSsvuCc70Bo8VPY87uOLMpdMMeUlN7O4qVMYTudFXEp7w5iprhOa+v5X+TzCPq5neIPz/
 hxBVxtuLx9fTH+iOPOB8uWzUhvPeUjpDj7zQIMlqHiUEndZJ6ifO7
X-Received: by 2002:a05:620a:4608:b0:783:4e8a:6b19 with SMTP id
 br8-20020a05620a460800b007834e8a6b19mr819130qkb.14.1705581766867; 
 Thu, 18 Jan 2024 04:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbb/685dJPVh7lLcMdvgy3UFP/vlqSMPCiuNzD0TIj4nU/Q1ITUIxQ8idDv/U9rmzWQjsCcQ==
X-Received: by 2002:a05:620a:4608:b0:783:4e8a:6b19 with SMTP id
 br8-20020a05620a460800b007834e8a6b19mr819110qkb.14.1705581766594; 
 Thu, 18 Jan 2024 04:42:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 sq11-20020a05620a4acb00b007815c55cdf9sm5236946qkn.105.2024.01.18.04.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 04:42:46 -0800 (PST)
Message-ID: <180a39fb-aa2b-4dca-9f01-adb4f392b846@redhat.com>
Date: Thu, 18 Jan 2024 13:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 1/15/24 11:13, Zhenzhong Duan wrote:
> IOMMUFDDevice represents a device in iommufd and can be used as
> a communication interface between devices (i.e., VFIO, VDPA) and
> vIOMMU.
>
> Currently it includes iommufd handler and device id information
> which could be used by vIOMMU to get hw IOMMU information.
>
> In future nested translation support, vIOMMU is going to have
> more iommufd related operations like allocate hwpt for a device,
> attach/detach hwpt, etc. So IOMMUFDDevice will be further expanded.
>
> IOMMUFDDevice is willingly not a QOM object because we don't want
> it to be visible from the user interface.
>
> Introduce a helper iommufd_device_init to initialize IOMMUFDDevice.
>
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS                     |  4 +--
>  include/sysemu/iommufd_device.h | 31 ++++++++++++++++++++
>  backends/iommufd_device.c       | 50 +++++++++++++++++++++++++++++++++
Maybe it is still time to move the iommufd files in a sepate dir, under
hw at the same level as vfio.

Thoughts?

Eric
>  backends/meson.build            |  2 +-
>  4 files changed, 84 insertions(+), 3 deletions(-)
>  create mode 100644 include/sysemu/iommufd_device.h
>  create mode 100644 backends/iommufd_device.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00ec1f7eca..606dfeb2b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2171,8 +2171,8 @@ M: Yi Liu <yi.l.liu@intel.com>
>  M: Eric Auger <eric.auger@redhat.com>
>  M: Zhenzhong Duan <zhenzhong.duan@intel.com>
>  S: Supported
> -F: backends/iommufd.c
> -F: include/sysemu/iommufd.h
> +F: backends/iommufd*.c
> +F: include/sysemu/iommufd*.h
>  F: include/qemu/chardev_open.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
> diff --git a/include/sysemu/iommufd_device.h b/include/sysemu/iommufd_device.h
> new file mode 100644
> index 0000000000..795630324b
> --- /dev/null
> +++ b/include/sysemu/iommufd_device.h
> @@ -0,0 +1,31 @@
> +/*
> + * IOMMUFD Device
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef SYSEMU_IOMMUFD_DEVICE_H
> +#define SYSEMU_IOMMUFD_DEVICE_H
> +
> +#include <linux/iommufd.h>
> +#include "sysemu/iommufd.h"
> +
> +typedef struct IOMMUFDDevice IOMMUFDDevice;
> +
> +/* This is an abstraction of host IOMMUFD device */
> +struct IOMMUFDDevice {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t dev_id;
> +};
> +
> +int iommufd_device_get_info(IOMMUFDDevice *idev,
> +                            enum iommu_hw_info_type *type,
> +                            uint32_t len, void *data);
> +void iommufd_device_init(void *_idev, size_t instance_size,
> +                         IOMMUFDBackend *iommufd, uint32_t dev_id);
> +#endif
> diff --git a/backends/iommufd_device.c b/backends/iommufd_device.c
> new file mode 100644
> index 0000000000..f6e7ca1dbf
> --- /dev/null
> +++ b/backends/iommufd_device.c
> @@ -0,0 +1,50 @@
> +/*
> + * QEMU abstract of Host IOMMU
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/iommufd_device.h"
> +
> +int iommufd_device_get_info(IOMMUFDDevice *idev,
> +                            enum iommu_hw_info_type *type,
> +                            uint32_t len, void *data)
> +{
> +    struct iommu_hw_info info = {
> +        .size = sizeof(info),
> +        .flags = 0,
> +        .dev_id = idev->dev_id,
> +        .data_len = len,
> +        .__reserved = 0,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +    int ret;
> +
> +    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
> +    if (ret) {
> +        error_report("Failed to get info %m");
> +    } else {
> +        *type = info.out_data_type;
> +    }
> +
> +    return ret;
> +}
> +
> +void iommufd_device_init(void *_idev, size_t instance_size,
> +                         IOMMUFDBackend *iommufd, uint32_t dev_id)
> +{
> +    IOMMUFDDevice *idev = (IOMMUFDDevice *)_idev;
> +
> +    g_assert(sizeof(IOMMUFDDevice) <= instance_size);
> +
> +    idev->iommufd = iommufd;
> +    idev->dev_id = dev_id;
> +}
> diff --git a/backends/meson.build b/backends/meson.build
> index 8b2b111497..c437cdb363 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -24,7 +24,7 @@ if have_vhost_user
>    system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
>  endif
>  system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
> -system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
> +system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c', 'iommufd_device.c'))
>  if have_vhost_user_crypto
>    system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>  endif


