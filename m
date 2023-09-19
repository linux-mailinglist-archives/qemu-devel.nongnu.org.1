Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2597A5E31
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX9e-0005QX-SK; Tue, 19 Sep 2023 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiX9V-0005Jw-OC
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:36:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiX9F-0004hd-7j
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:36:17 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqc2g2LFjz6K5WY;
 Tue, 19 Sep 2023 17:35:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 10:35:58 +0100
Date: Tue, 19 Sep 2023 10:35:57 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <linuxarm@huawei.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
Message-ID: <20230919103557.00000bf3@Huawei.com>
In-Reply-To: <CAFEAcA_ROGZ1jDPP59NBD2td-R7e9VjJ=2mNEY01cPL8ZMYgkw@mail.gmail.com>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
 <5083ba81-f74d-3698-6418-72d288917df5@intel.com>
 <CAFEAcA_ROGZ1jDPP59NBD2td-R7e9VjJ=2mNEY01cPL8ZMYgkw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 18 Sep 2023 18:38:10 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 18 Sept 2023 at 18:26, Dave Jiang <dave.jiang@intel.com> wrote:
> >
> >
> >
> > On 9/18/23 10:00, Jonathan Cameron wrote:  
> > > On Mon, 18 Sep 2023 17:31:38 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >  
> > >> On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
> > >> <Jonathan.Cameron@huawei.com> wrote:  
> > >>>
> > >>> This has been missing from the start. Assume it should match
> > >>> with cxl/cxl-component-utils.c as both were part of early
> > >>> postings from Ben.  
> > >>
> > >> Sounds plausible -- is there an Intel person who could give us
> > >> an acked-by for this?
> > >>
> > >> (Ideally we wouldn't have let more gpl-2-only code into the
> > >> codebase without a rationale...)
> > >>  
> > >
> > > I've +CC'd the kernel CXL maintainers from Intel a few of whom
> > > have also contributed some of the QEMU CXL code.
> > > Hopefully someone can ack.  
> >
> > I see that nvdimm.c from Intel is under LGPL 2.1. What is the typical license this should be applied for QEMU?  
> 
> The project has a mix of licenses, for mostly historical reasons.
> The overall license is thus GPLv2 (as the most-restrictive of the set).
> Our preference (as noted in the top level LICENSE file) for new
> code is for GPL-v2-or-later; we can take other GPL-2-compatible
> licenses (preferably GPL-v2-or-later compatible) if there's a
> good rationale from the submitter. (Historically, one reason
> for the GPL-v2-only code has been "this came from the Linux
> kernel and so it's GPL-2-only"; "we copied a lot of this code
> from some other file in QEMU and that has license X" is
> the other one.)

As this one is now 'historical' code I'll stick to the v2 only
but make sure anything new goes in with v2 or later unless there is
a good reason for another choice.

Thanks for the info,

Jonathan

> 
> thanks
> -- PMM
> 


