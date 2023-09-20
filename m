Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEBB7A80C9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:40:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwUC-0006Ui-JU; Wed, 20 Sep 2023 08:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwU8-0006TX-IN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwU4-000200-CZ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695213551;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nrvhgjq9z9T93/SSP42zOe0Av7cgqC1k8A1giOIxW20=;
 b=WchU9UwvytI1FP8eZ6AyKUwCUCIOLZPHTuvmpVxxnW2hlJJICBOFHaepaBAPutxjp7I4vn
 5eneKTIl/uPm5lZ4WCPLk7c9MuZ5KuFnxk1nTuDb7b0FkfMN9LHDwcjuH8lmbHroUJXhmW
 K2jGwprPlOB+1cBZfSD0+OBMHpIILCg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-7hxp4yHKNdulCILD8aigtw-1; Wed, 20 Sep 2023 08:39:08 -0400
X-MC-Unique: 7hxp4yHKNdulCILD8aigtw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 896C93801EEE;
 Wed, 20 Sep 2023 12:39:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F489492C37;
 Wed, 20 Sep 2023 12:39:04 +0000 (UTC)
Date: Wed, 20 Sep 2023 13:39:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v1 17/22] util/char_dev: Add open_cdev()
Message-ID: <ZQrn5oyrdIXw2A7Y@redhat.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-18-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830103754.36461-18-zhenzhong.duan@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 30, 2023 at 06:37:49PM +0800, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> /dev/vfio/devices/vfioX may not exist. In that case it is still possible
> to open /dev/char/$major:$minor instead. Add helper function to abstract
> the cdev open.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS             |  6 ++++
>  include/qemu/char_dev.h | 16 +++++++++++
>  util/chardev_open.c     | 61 +++++++++++++++++++++++++++++++++++++++++

Using the same naming scheme for the .c and .h is strongly desired.

>  util/meson.build        |  1 +
>  4 files changed, 84 insertions(+)
>  create mode 100644 include/qemu/char_dev.h
>  create mode 100644 util/chardev_open.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04663fbb6f..74d18593fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3372,6 +3372,12 @@ S: Maintained
>  F: include/qemu/iova-tree.h
>  F: util/iova-tree.c
>  
> +cdev Open
> +M: Yi Liu <yi.l.liu@intel.com>
> +S: Maintained
> +F: include/qemu/char_dev.h
> +F: util/chardev_open.c
> +


> diff --git a/util/chardev_open.c b/util/chardev_open.c
> new file mode 100644
> index 0000000000..d03e415131
> --- /dev/null
> +++ b/util/chardev_open.c
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Copied from
> + * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
> + *
> + */

Since this is GPL-2.0-only, IMHO it would be preferrable to keep it
out of the util/ directory, as we're aiming to not add further 2.0
only code, except for specific subdirs. This only appears to be used
by code under hw/vfio/, whcih is one of the dirs still permitting
2.0-only code. So I think better to keep this file where it is used.

> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

This is set globally for building all files in QEMU

> +#include "qemu/osdep.h"
> +#include "qemu/char_dev.h"
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
> +    char *devpath;

g_autofree for this...

> +    int ret;
> +
> +    /*
> +     * This assumes that udev is being used and is creating the /dev/char/
> +     * symlinks.
> +     */
> +    devpath = g_strdup_printf("/dev/char/%u:%u", major(cdev), minor(cdev));
> +    ret = open_cdev_internal(devpath, cdev);
> +    g_free(devpath);

...avoids the need for g_free, and also avoids the need for
the intermediate 'ret' variable.

> +    return ret;
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
> index a375160286..d5313d858f 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -107,6 +107,7 @@ if have_block
>      util_ss.add(files('filemonitor-stub.c'))
>    endif
>    util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
> +  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
>  endif
>  
>  if cpu == 'aarch64'
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


