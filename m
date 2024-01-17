Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB58307AB
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:12:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6dj-0001kL-HU; Wed, 17 Jan 2024 09:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ6dh-0001kC-27
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ6df-0002bT-A9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705500690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn/ZGVAtzUnrLQUxV9GNxPhgI9PQn68TNMcAVKvWah8=;
 b=bXnlQ6/osEAWAd0Lp51lsTBBSxvE5JHHl8hnlHMmIhUiqdzYAzPPABKwf79PEYLHJB0dZ6
 /j9mUb1H0tStDNPBBLwNHmeJjRU0+DoNB6j/iq5R6LMK3PbbxYzNO3mr5RvRp0rLB7bpkX
 ojGXKxqzFI4ZmB4K4wB1krSC9oc0S3k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-5p7HN3H6M7KZ9rY-CvL0Zg-1; Wed, 17 Jan 2024 09:11:29 -0500
X-MC-Unique: 5p7HN3H6M7KZ9rY-CvL0Zg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7816bea8d28so1984736285a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500689; x=1706105489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qn/ZGVAtzUnrLQUxV9GNxPhgI9PQn68TNMcAVKvWah8=;
 b=PQwEi1+CrDUG4sZyJnRVm/z5DmClMnwb7Bd8KzfwwH6AtIjleZ7OCLq9TXQ9OnY/iW
 lApcV4ym3jsZbqnCGxsNXMVxGYMbZWGPx78Zrn3GOHQME4HwmN0RZn4SEEbmwIKCj7J9
 j30HeAuK+9w4bQVSqtakd+XSZFZve8SB/re2FwOMV5iWETINS+9nP0nM1b0F3J3z28G8
 kCkn4alrQwlekoz3tHq221Ic3haskQ5p4IsA07OSdzNuizhltgvKZVanQe33eUn9jGb2
 cUI6LJ6PGBNnLLgFL0PshB7U4eKG+Ew5mdxhwrdSjGbY3ypT9D/oF4q4eBF7ZnPU0qKS
 vLBg==
X-Gm-Message-State: AOJu0YyWh1JfXrJPf85QIbdDBH60DP8K9Q3mE/evivFZM5uJvKfOUyoh
 x5QoNIjtGIOhTcacpqx1wUO4vELPDEfmRTY6tLezZS2fqlA7G6L5fnw2LUdBYwj5/v9llh/hU/q
 ffuybHc+SUMRGcBhG4IX8yGUQsdGWz3QC0ZWhjJZumBRjRFLqprSl
X-Received: by 2002:a05:620a:361e:b0:783:82b:5d5 with SMTP id
 da30-20020a05620a361e00b00783082b05d5mr970216qkb.77.1705500688507; 
 Wed, 17 Jan 2024 06:11:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFshlBxSzTGE3PX3FdVrWakLHD4/hPNfF+SI97Uh3AshkoVWzP/fwMru4GIL/rlqV3FzfxcA==
X-Received: by 2002:a05:620a:361e:b0:783:82b:5d5 with SMTP id
 da30-20020a05620a361e00b00783082b05d5mr970210qkb.77.1705500688258; 
 Wed, 17 Jan 2024 06:11:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05620a004d00b00783749b0d2fsm372059qkt.94.2024.01.17.06.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:11:27 -0800 (PST)
Message-ID: <866c6343-054c-40c7-b331-b41497f5610b@redhat.com>
Date: Wed, 17 Jan 2024 15:11:23 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hi Zhenzhong,

On 1/15/24 11:13, Zhenzhong Duan wrote:
> IOMMUFDDevice represents a device in iommufd and can be used as
> a communication interface between devices (i.e., VFIO, VDPA) and
> vIOMMU.
>
> Currently it includes iommufd handler and device id information
iommufd handle
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

+  iommufd_device_get_info helper
>
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS                     |  4 +--
>  include/sysemu/iommufd_device.h | 31 ++++++++++++++++++++
>  backends/iommufd_device.c       | 50 +++++++++++++++++++++++++++++++++
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
it is the abstraction of the IOMMU or of any assigned device?
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
> +int (IOMMUFDDevice *idev,
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
you may prefer using errp instead of hard traces.
> +    } else {
> +        *type = info.out_data_type;
> +    }
> +
> +    return ret;
> +}
> +
> +void iommufd_device_init(void *_idev, size_t instance_size,
nit: why the "_"
> +                         IOMMUFDBackend *iommufd, uint32_t dev_id)
> +{
> +    IOMMUFDDevice *idev = (IOMMUFDDevice *)_idev;
> +
> +    g_assert(sizeof(IOMMUFDDevice) <= instance_size);
at this stage of the reading it is not clear why you input the
instance_size. worth to be clarified/documented.
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
Thanks

Eric


