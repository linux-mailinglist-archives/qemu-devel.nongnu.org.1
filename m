Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E47EC388
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Frv-0000cn-E1; Wed, 15 Nov 2023 08:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Frp-0000b2-Dt
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Frn-0003k4-CT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700054617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DF2oOpIF/uXYqCsDTpAvnxPJMZ9sDUoO7PvnqczXug=;
 b=bHsPn3WMmvymNhPhMwMhCfkv0gw77zeToCA2HjBSm3B4PqC5TA8IUGaWv0zh1i9Xd8RYmq
 N5bpGhuqUcbEjxIjDDSg1GtreUUXBA0zNBokIPBXDqimbTy0/deB0kDoXVulaDPcLlFjkW
 +z895ZtN2ckhon555nOGcflbfTjF72I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-xWGVUfjsMK-L6vgcrVif0g-1; Wed, 15 Nov 2023 08:23:36 -0500
X-MC-Unique: xWGVUfjsMK-L6vgcrVif0g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66cffe51b07so75640236d6.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 05:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054614; x=1700659414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DF2oOpIF/uXYqCsDTpAvnxPJMZ9sDUoO7PvnqczXug=;
 b=HzvmkmSyNtvBDnM6+wNmJwIPKQNQ0omvbgoS8ZKnYVihQDsgUueudV1PDXW26Ha++k
 5hoyYpFsyJIZro+NLK0A6psM9gphmipg3YEwzkaV0T+itCnKN1xOxvFye7AvEexWndwO
 cTyM5BZTurH1q3KNKtYX65rC2OcDGiTkopLG+xmFyVOutceyp0IdPz8aL+/rOSdhu1P1
 DMwFLuVgM6fBCTzhsh8c0JL2k6VuOqGr/TUeZHMCYRy/IbrplT8tCdmCXY6FU6GPAzyq
 0u/3XfVRNCo9FhF1Y7taNQkV0gMz56idQq7WNzN7Bf/ZPlOLNfgZdj/1s+VrU9WNAZnq
 +K2g==
X-Gm-Message-State: AOJu0Yzp0hrlmLgUXjq9FZUcDEsB9Z4nu9amidMYRqam+krLucbw/Y3m
 DCU8AAU3tS3vRE5sB+uHICxgsqsJmZkbgkQ1M389kkTxsMMQ9IcjDxm+hPm7eqH5UaDzwqJGyrA
 ttpaq62r58131V+I7W9oUtpY=
X-Received: by 2002:a05:6214:5ecc:b0:66f:bb9b:b37 with SMTP id
 mn12-20020a0562145ecc00b0066fbb9b0b37mr5399227qvb.7.1700054614419; 
 Wed, 15 Nov 2023 05:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6N7c+ddPNOHkgyfyPg5H+tHerijgiiWCFV1Am5VsZsf3J6Sm2fnDdCyrzz/5Z/GgPi6iTxQ==
X-Received: by 2002:a05:6214:5ecc:b0:66f:bb9b:b37 with SMTP id
 mn12-20020a0562145ecc00b0066fbb9b0b37mr5399205qvb.7.1700054614140; 
 Wed, 15 Nov 2023 05:23:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a0cf5ca000000b0065b0554ae78sm537905qvm.100.2023.11.15.05.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:23:33 -0800 (PST)
Message-ID: <1df69fcc-813e-44ee-b19f-bb24a4b493d2@redhat.com>
Date: Wed, 15 Nov 2023 14:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/21] util/char_dev: Add open_cdev()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> From: Yi Liu <yi.l.liu@intel.com>
>
> /dev/vfio/devices/vfioX may not exist. In that case it is still possible
> to open /dev/char/$major:$minor instead. Add helper function to abstract
> the cdev open.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric


> ---
>  MAINTAINERS                 |  3 ++
>  include/qemu/chardev_open.h | 16 ++++++++
>  util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
>  util/meson.build            |  1 +
>  4 files changed, 101 insertions(+)
>  create mode 100644 include/qemu/chardev_open.h
>  create mode 100644 util/chardev_open.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4891f7bda..869ec3d5af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2172,6 +2172,9 @@ M: Eric Auger <eric.auger@redhat.com>
>  S: Supported
>  F: backends/iommufd.c
>  F: include/sysemu/iommufd.h
> +F: include/qemu/chardev_open.h
> +F: util/chardev_open.c
> +
>  
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
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
>      util_ss.add(files('filemonitor-stub.c'))
>    endif
>    util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
> +  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
>  endif
>  
>  if cpu == 'aarch64'


