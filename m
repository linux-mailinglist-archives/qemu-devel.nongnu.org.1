Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F437A5CE2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWO9-0006EF-QE; Tue, 19 Sep 2023 04:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiWO7-0006Dp-FE
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiWO5-00081O-Qq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695113237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qHgsfH1VHbtVafP62HO+qf7njlJj3lMjfIwvlLizxqc=;
 b=hr0RjdkkmjlRqhj83x2EzWuNl+gYVlRol0V29zBxFJKJ6AVcjzEmaO+4zUxRqaPAv0JoDx
 KIdnRWebumSB2GgCXnu7q1s+R139eUknGRSxoqcitDy6h4j8+YECDPrG6L+mVmvSFQM8Jn
 N8S76aBTIYebY62d4i9m0N+YNt1DjW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-_SBCyGXhMHWXSjtViLSFjQ-1; Tue, 19 Sep 2023 04:47:13 -0400
X-MC-Unique: _SBCyGXhMHWXSjtViLSFjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C293E802D35;
 Tue, 19 Sep 2023 08:47:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91C941C65E;
 Tue, 19 Sep 2023 08:47:09 +0000 (UTC)
Date: Tue, 19 Sep 2023 09:47:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linuxarm@huawei.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
Message-ID: <ZQlgCgC1gHF9i7Ad@redhat.com>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
 <6508bdc0befbc_3947ba294b2@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6508bdc0befbc_3947ba294b2@iweiny-mobl.notmuch>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 18, 2023 at 02:14:40PM -0700, Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Mon, 18 Sep 2023 17:31:38 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > 
> > > On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > This has been missing from the start. Assume it should match
> > > > with cxl/cxl-component-utils.c as both were part of early
> > > > postings from Ben.  
> > > 
> > > Sounds plausible -- is there an Intel person who could give us
> > > an acked-by for this?
> 
> While we are at it; what about .../hw/mem/cxl_type3_stubs.c?
> 
> > > 
> > > (Ideally we wouldn't have let more gpl-2-only code into the
> > > codebase without a rationale...)
> 
> I'm curious about this statement.  Does the qemu project not want gpl v2
> only code?

Correct, this is explicitly stated in the LICENSE file:

[quote]
As of July 2013, contributions under version 2 of the GNU General Public
License (and no later version) are only accepted for the following files
or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
[/quote]

>             I agree with Jonathan that this is the intention of Ben's
> initial submission; so from that PoV.

Ideally we would get all QEMU CXL contributors to agree to re-license
to the GPL-2.0-or-later, unless the code has been copied from another
project which was GPL-2.0-only thus forcing our code.

> 
> Acked-by: Ira Weiny <ira.weiny@intel.com>
> 
> Going forward I'd like to better understand the qemu communities view.

Please follow the LICENSE file which is explicit about QEMU's views
per the quoted text above.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


