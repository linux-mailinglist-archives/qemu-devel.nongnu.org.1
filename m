Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B947EB0E3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:30:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tUB-00047A-SZ; Tue, 14 Nov 2023 08:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tU6-00046h-Ft
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tU2-00022I-Fe
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699968577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71BlbIN7DxN20Igbri6xlHaiZVHqPqtsizezESFxyiQ=;
 b=FalToesmuUIdADoN4Qax/TkRnf2+TO/zgPPoau5s68HyUM9zTw2FZ//609IWz5VgGFEO2T
 TscHYskt43Xskb/sSQkvFA/vyes1PjIbedscxRVJMVywLXXhXoIM/DJqEuUMQqkcN6Z5/I
 ttMz12uLdEYwW2S6Lod4sW7qIWVFaok=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-A7KHg0IfO7Cp_y8DWwn4NQ-1; Tue, 14 Nov 2023 08:29:36 -0500
X-MC-Unique: A7KHg0IfO7Cp_y8DWwn4NQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41ea8e21785so97032721cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699968576; x=1700573376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71BlbIN7DxN20Igbri6xlHaiZVHqPqtsizezESFxyiQ=;
 b=fcCafYkP93DkLc5DpqFd+9at3arc2bIxLazd/z11JFVFi5dYPNZZ1V94BCcS1t7mZ/
 k6XIygmS7+/cnU43kEZMSDnq55ByayPr5cUlY7AN26fw0KK5lNGmm4XCHKmforsi0RZD
 UU3eVJ66GeOuzLOYYKNsxFebBOMIwRi3gkeqiK/hCdpgIWZEup01UNwlyBJc5JqK8sNf
 rgGdGMhmrEx+wbvQq8I3djfwoWuYvtGr2nI+Re0Z2LntaquI7YdysTqc/kApYakYmyNp
 ZclLDQs10Kz91r7UO1HmCKH6BpbbjgCqRtq8dQCQBML+PYd/dJJHgAXrvbrTzJZ4u2jF
 ZPzA==
X-Gm-Message-State: AOJu0YyhMQ7I+8Iv3PFHqpLj9CH8YguxmU70Q/oN6sCSHmIbHUHscAng
 nGKE0EEIG+7I2oNiVVrtpXX//kajkl0T+2VR8DETNN5n4HMU+vCzPa/jDmtMQPhZ7ektz8lM+zN
 wDXbBUTFIIKmxn7k=
X-Received: by 2002:a05:622a:1a14:b0:403:b088:5d3 with SMTP id
 f20-20020a05622a1a1400b00403b08805d3mr3384489qtb.17.1699968575839; 
 Tue, 14 Nov 2023 05:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGalpADANHiNVj/M727LF5eyrUws8iH1rFsklv06BA9wluCKF1/gi0oup4KZfopU/y1mESRFg==
X-Received: by 2002:a05:622a:1a14:b0:403:b088:5d3 with SMTP id
 f20-20020a05622a1a1400b00403b08805d3mr3384458qtb.17.1699968575504; 
 Tue, 14 Nov 2023 05:29:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d15-20020ac8544f000000b0041cf5ec8b75sm2720761qtq.96.2023.11.14.05.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:29:35 -0800 (PST)
Message-ID: <d4bea21c-fdda-4f94-b7ac-c2d8cd495c99@redhat.com>
Date: Tue, 14 Nov 2023 14:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/21] util/char_dev: Add open_cdev()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> /dev/vfio/devices/vfioX may not exist. In that case it is still possible
> to open /dev/char/$major:$minor instead. Add helper function to abstract
> the cdev open.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS                 |  3 ++
>   include/qemu/chardev_open.h | 16 ++++++++
>   util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
>   util/meson.build            |  1 +
>   4 files changed, 101 insertions(+)
>   create mode 100644 include/qemu/chardev_open.h
>   create mode 100644 util/chardev_open.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4891f7bda..869ec3d5af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2172,6 +2172,9 @@ M: Eric Auger <eric.auger@redhat.com>
>   S: Supported
>   F: backends/iommufd.c
>   F: include/sysemu/iommufd.h
> +F: include/qemu/chardev_open.h
> +F: util/chardev_open.c
> +
>   
>   vhost
>   M: Michael S. Tsirkin <mst@redhat.com>
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
> index c2322ef6e7..174c133368 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -108,6 +108,7 @@ if have_block
>       util_ss.add(files('filemonitor-stub.c'))
>     endif
>     util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
> +  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
>   endif
>   
>   if cpu == 'aarch64'


