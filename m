Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AA7DBC25
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTeR-0002cY-Ar; Mon, 30 Oct 2023 10:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxTeP-0002by-Fz
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxTeN-0004zy-MV
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698677635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZowNvlmXlsisEqXBO8RXO+9eb/Oy+hUieUqca3EPOU=;
 b=ZJQhdf+2pQt1nceZHVT1TbNdO0Nwq87nccd7Zs/tbdxtXaXYcK1hw0K9OWelg614Epe3Pb
 7yUOQKZC5jPEZLdbRgzgafgVDLbsfOgzHaNpgUy9J2CzZtk8Y9mBBQC3s3sBM72HIa0U71
 FwK+s7mr2EIJWHpcCrzMXGFnXYM6RKs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-LwyP8sX4NOqutqOAFCFALg-1; Mon, 30 Oct 2023 10:53:53 -0400
X-MC-Unique: LwyP8sX4NOqutqOAFCFALg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77892f2ee51so589323085a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698677633; x=1699282433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZowNvlmXlsisEqXBO8RXO+9eb/Oy+hUieUqca3EPOU=;
 b=qzIceH30Yqls5rTRUblzc6swuu8xz/kAVoNUGLyC7nn0yUnXmgI+FZxROPvhp2zLX0
 PBFqSnyu5nB58jlYEXuiM+z9YBBiNttxJWHl26eRFuToSvJYDhtAiz3WyQ+mn+57PK5B
 BmziTp7MWJt2QE7oTHouqHapb+59TZjTQPMUaBYES6xU8T6afC6nv3DKUubvZL+V4rWj
 GieTZFEuumu6Wki2ZF5wtf1eAwDWdwPM5vHD2D35VQCTYfS64yAl5iBKpI9E0KiZ1/H/
 gyGKXR1UvoBOVRaXrjd6afxHIWUIb1rd1ekk412MslGidyOrruKRCX92DM01ov3EJpZ3
 AglA==
X-Gm-Message-State: AOJu0Yxe8Qmp03pQ674lG//V6syr6+j8teztPCcvTjD1Ptvkip42tu1S
 pQivSvvKYGrpRAyA3hCExuShqIkSvOF4En+W3rzgR48Q//qxhpIW7uw0O1YanP5Z5Oji//qcL+X
 bHOl1KObId/rzEb0=
X-Received: by 2002:a05:620a:1d05:b0:778:8bad:662d with SMTP id
 dl5-20020a05620a1d0500b007788bad662dmr10779011qkb.18.1698677633159; 
 Mon, 30 Oct 2023 07:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1F9pi68r+jyWcwnP5dpk5Rw+p+MOGam5/hn3fLO2stASy4Qx3dkOwDWrM7Aso3iuwvsaivA==
X-Received: by 2002:a05:620a:1d05:b0:778:8bad:662d with SMTP id
 dl5-20020a05620a1d0500b007788bad662dmr10778988qkb.18.1698677632841; 
 Mon, 30 Oct 2023 07:53:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a05620a22ce00b007776c520488sm3378131qki.9.2023.10.30.07.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 07:53:51 -0700 (PDT)
Message-ID: <50827527-ff82-434f-ab95-770572b0d81c@redhat.com>
Date: Mon, 30 Oct 2023 15:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/37] util/char_dev: Add open_cdev()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-26-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-26-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> From: Yi Liu <yi.l.liu@intel.com>
> 
> /dev/vfio/devices/vfioX may not exist. In that case it is still possible
> to open /dev/char/$major:$minor instead. Add helper function to abstract
> the cdev open.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS                 |  6 +++
>   include/qemu/chardev_open.h | 16 ++++++++
>   util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
>   util/meson.build            |  1 +
>   4 files changed, 104 insertions(+)
>   create mode 100644 include/qemu/chardev_open.h
>   create mode 100644 util/chardev_open.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7aa57ab16f..123e999bee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3447,6 +3447,12 @@ S: Maintained
>   F: include/qemu/iova-tree.h
>   F: util/iova-tree.c
>   
> +cdev Open
> +M: Yi Liu <yi.l.liu@intel.com>
> +S: Maintained
> +F: include/qemu/chardev_open.h
> +F: util/chardev_open.c
> +
>   elf2dmp
>   M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
>   S: Maintained
> diff --git a/include/qemu/chardev_open.h b/include/qemu/chardev_open.h
> new file mode 100644
> index 0000000000..6580d351c6
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
> +#ifndef QEMU_CHARDEV_HELPERS_H
> +#define QEMU_CHARDEV_HELPERS_H
> +
> +int open_cdev(const char *devpath, dev_t cdev);
> +#endif
> diff --git a/util/chardev_open.c b/util/chardev_open.c
> new file mode 100644
> index 0000000000..005d2b81bd
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
> +    g_autofree char *devpath;

Please initialize g_autofree variables ( = NULL)


Thanks,

C.


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


