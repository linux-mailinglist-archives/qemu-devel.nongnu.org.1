Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70617E4026
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:39:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MHV-0004WA-OF; Tue, 07 Nov 2023 08:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MHQ-0004Vs-N1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MHN-0004gF-FH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDYs/sA84tbhZnD4FJfeZxeN1LNvUXSrcawiElmQ/gg=;
 b=QQMcIk5vNMoiBMqfMOOntj2TjUdy2HwggPcNybRBJjPJ27PZ5inyztg8Sm7uzyaPNqE8dF
 MfDNbn4oToF4ARfJhyitFuAS3tUsl/6Y66JU1M/96XcQB4WQDGeeFURCG8pVSHu1qJBf0f
 GpMFRivw798Z7K2c/y5x5qsb0kt3+ls=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-R5mTP_L9N7a_6qaZrdUnWg-1; Tue, 07 Nov 2023 08:37:57 -0500
X-MC-Unique: R5mTP_L9N7a_6qaZrdUnWg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d87503d24so73491826d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699364273; x=1699969073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDYs/sA84tbhZnD4FJfeZxeN1LNvUXSrcawiElmQ/gg=;
 b=mT/TBAlrrhI8cw0mtuoYVqgIfU1sfucfDCzX/4sfxgxBrfz+OChFCpcVWGGwfN+TMv
 A5135UFsC+sRvByd7qGboUFF8gIgjjHF7lVZbtcz24VPOtg6YCehz1QhOD4nkqXJDX0t
 luezPZvpxJyNeJc8hTbQXV64qizIXssPu6YZIqRMfupVdkr63ujPF/nxJg8jiveU2HfT
 ETfejowu3MMNFMvXcTK3wiUTBPXsZEeuBgk8JVHLsVYfrSu/bkMYbXUd8OSVfFbhgmPj
 n3ugYs0UAANHua4sX7lo+Pgw0R9mxcudVwWaQqB+02EQjejwU2g1kLKIpazrKShGLRrS
 G8cw==
X-Gm-Message-State: AOJu0YxDcLdOJz2tTF9q27IkbCZVEGmLQJoaEUAdYlM+rghJMICUCiEO
 8JthK2v+UwvN4GQn2etPW3zwbEyJPYGdZfF3T/xmpw+ndTI37mcHvYRtGI9/hPIBZUXPp1dot8M
 y7mByToy71G1GD2k=
X-Received: by 2002:ad4:5c47:0:b0:66d:62b7:53f4 with SMTP id
 a7-20020ad45c47000000b0066d62b753f4mr45605510qva.45.1699364272965; 
 Tue, 07 Nov 2023 05:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJSJjTJBs9Z/Fy3bNo2w1zaeYdUHT7EnN/vRnc5w8M6kxsWdw9NVC1/XhWVAdy6ItOspUZNA==
X-Received: by 2002:ad4:5c47:0:b0:66d:62b7:53f4 with SMTP id
 a7-20020ad45c47000000b0066d62b753f4mr45605481qva.45.1699364272655; 
 Tue, 07 Nov 2023 05:37:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e13-20020ad4418d000000b006263a9e7c63sm4312819qvp.104.2023.11.07.05.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:37:52 -0800 (PST)
Message-ID: <2f071396-e3b3-4865-b802-3599a888fd55@redhat.com>
Date: Tue, 7 Nov 2023 14:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/41] util/char_dev: Add open_cdev()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-28-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-28-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> /dev/vfio/devices/vfioX may not exist. In that case it is still possible
> to open /dev/char/$major:$minor instead. Add helper function to abstract
> the cdev open.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>> ---
>   MAINTAINERS                 |  6 +++
>   include/qemu/chardev_open.h | 16 ++++++++
>   util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
>   util/meson.build            |  1 +
>   4 files changed, 104 insertions(+)
>   create mode 100644 include/qemu/chardev_open.h
>   create mode 100644 util/chardev_open.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f35159255..eada773975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3473,6 +3473,12 @@ S: Maintained
>   F: include/qemu/iova-tree.h
>   F: util/iova-tree.c
>   
> +cdev Open
> +M: Yi Liu <yi.l.liu@intel.com>
> +S: Maintained
> +F: include/qemu/chardev_open.h
> +F: util/chardev_open.c

May be move under the IOMMUFD entry instead ?


Thanks,

C.


  





> +
>   elf2dmp
>   M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
>   S: Maintained
> diff --git a/include/qemu/chardev_open.h b/include/qemu/chardev_open.h
> new file mode 100644
> index 0000000000..64e8fcfdcb
> --- /dev/null
> +++ b/include/qemu/chardev_open.h
> @@ -0,0 +1,16 @@
> +/*
> + * QEMU Chardev Helper
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_CHARDEV_OPEN_H
> +#define QEMU_CHARDEV_OPEN_H
> +
> +int open_cdev(const char *devpath, dev_t cdev);
> +#endif
> diff --git a/util/chardev_open.c b/util/chardev_open.c
> new file mode 100644
> index 0000000000..f776429788
> --- /dev/null
> +++ b/util/chardev_open.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> + * Copyright (C) 2023 Intel Corporation.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *      Redistribution and use in source and binary forms, with or
> + *      without modification, are permitted provided that the following
> + *      conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *
> + * Copied from
> + * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/chardev_open.h"
> +
> +static int open_cdev_internal(const char *path, dev_t cdev)
> +{
> +    struct stat st;
> +    int fd;
> +
> +    fd = qemu_open_old(path, O_RDWR);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    if (fstat(fd, &st) || !S_ISCHR(st.st_mode) ||
> +        (cdev != 0 && st.st_rdev != cdev)) {
> +        close(fd);
> +        return -1;
> +    }
> +    return fd;
> +}
> +
> +static int open_cdev_robust(dev_t cdev)
> +{
> +    g_autofree char *devpath = NULL;
> +
> +    /*
> +     * This assumes that udev is being used and is creating the /dev/char/
> +     * symlinks.
> +     */
> +    devpath = g_strdup_printf("/dev/char/%u:%u", major(cdev), minor(cdev));
> +    return open_cdev_internal(devpath, cdev);
> +}
> +
> +int open_cdev(const char *devpath, dev_t cdev)
> +{
> +    int fd;
> +
> +    fd = open_cdev_internal(devpath, cdev);
> +    if (fd == -1 && cdev != 0) {
> +        return open_cdev_robust(cdev);
> +    }
> +    return fd;
> +}
> diff --git a/util/meson.build b/util/meson.build
> index eb677b40c2..eda0b06062 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -107,6 +107,7 @@ if have_block
>       util_ss.add(files('filemonitor-stub.c'))
>     endif
>     util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
> +  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
>   endif
>   
>   if cpu == 'aarch64'


