Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7597A8218
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwlF-0006Dw-3X; Wed, 20 Sep 2023 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwlB-0006DE-Hh
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiwl9-0006Ma-2u
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695214610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/iGZvZsm9KUF6ICcFBxAIxw4uUQZpb6DnccOEJgjKc=;
 b=e10k85QVRS+WmQV/QCuiDj3MZg9Vt1w6ROyhzP0rqhua5ickQiZRyA4+/Pws77LmxREXUt
 IHEg3zo5hohRM+PKoMCvGF5pa+OCgV1R9kVptLfd8pB7A10mw4RAJ1wRZoIKdOGerQoouf
 qGqLrjvTTIZKjHHoh0wbx5xwH16pidM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-RqiVrbNPN0SVgRmVNu_Vhw-1; Wed, 20 Sep 2023 08:56:46 -0400
X-MC-Unique: RqiVrbNPN0SVgRmVNu_Vhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 466B1800888;
 Wed, 20 Sep 2023 12:56:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5893320268CB;
 Wed, 20 Sep 2023 12:56:44 +0000 (UTC)
Date: Wed, 20 Sep 2023 13:56:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 17/22] util/char_dev: Add open_cdev()
Message-ID: <ZQrsCvNhM3W7hNuU@redhat.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-18-zhenzhong.duan@intel.com>
 <ZQrn5oyrdIXw2A7Y@redhat.com> <20230920125346.GT13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920125346.GT13733@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 20, 2023 at 09:53:46AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 01:39:02PM +0100, Daniel P. Berrangé wrote:
> 
> > > diff --git a/util/chardev_open.c b/util/chardev_open.c
> > > new file mode 100644
> > > index 0000000000..d03e415131
> > > --- /dev/null
> > > +++ b/util/chardev_open.c
> > > @@ -0,0 +1,61 @@
> > > +/*
> > > + * Copyright (C) 2023 Intel Corporation.
> > > + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> > > + *
> > > + * Authors: Yi Liu <yi.l.liu@intel.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > > + * the COPYING file in the top-level directory.
> > > + *
> > > + * Copied from
> > > + * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
> > > + *
> > > + */
> > 
> > Since this is GPL-2.0-only, IMHO it would be preferrable to keep it
> > out of the util/ directory, as we're aiming to not add further 2.0
> > only code, except for specific subdirs. This only appears to be used
> > by code under hw/vfio/, whcih is one of the dirs still permitting
> > 2.0-only code. So I think better to keep this file where it is used.
> 
> The copyright comment above is not fully accurate.
> 
> The original code is under the "OpenIB" dual license, you can choose
> to take it using the OpenIB BSD license text:
> 
>  *      Redistribution and use in source and binary forms, with or
>  *      without modification, are permitted provided that the following
>  *      conditions are met:
>  *
>  *      - Redistributions of source code must retain the above
>  *        copyright notice, this list of conditions and the following
>  *        disclaimer.
>  *
>  *      - Redistributions in binary form must reproduce the above
>  *        copyright notice, this list of conditions and the following
>  *        disclaimer in the documentation and/or other materials
>  *        provided with the distribution.
>  *
>  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>  * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>  * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>  * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>  * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>  * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>  * SOFTWARE.
> 
> And drop reference to GPL if that is what qemu desires.

Simplest is probably just to copy the original license header as-is,
and thus preserve the GPL OR BSD choice.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


