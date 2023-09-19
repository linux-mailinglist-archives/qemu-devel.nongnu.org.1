Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7497A5EFB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXX0-0005gT-3G; Tue, 19 Sep 2023 06:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXWw-0005gJ-5k
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:00:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXWs-0002uv-DS
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:00:29 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqcZk2YGWz6K6PB;
 Tue, 19 Sep 2023 17:59:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 11:00:17 +0100
Date: Tue, 19 Sep 2023 11:00:16 +0100
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, <linuxarm@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, Dave Jiang
 <dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
Message-ID: <20230919110016.00007a9d@Huawei.com>
In-Reply-To: <ZQlgCgC1gHF9i7Ad@redhat.com>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
 <6508bdc0befbc_3947ba294b2@iweiny-mobl.notmuch>
 <ZQlgCgC1gHF9i7Ad@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 19 Sep 2023 09:47:06 +0100
Daniel P. Berrang=E9 <berrange@redhat.com> wrote:

> On Mon, Sep 18, 2023 at 02:14:40PM -0700, Ira Weiny wrote:
> > Jonathan Cameron wrote: =20
> > > On Mon, 18 Sep 2023 17:31:38 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >  =20
> > > > On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > >
> > > > > This has been missing from the start. Assume it should match
> > > > > with cxl/cxl-component-utils.c as both were part of early
> > > > > postings from Ben.   =20
> > > >=20
> > > > Sounds plausible -- is there an Intel person who could give us
> > > > an acked-by for this? =20
> >=20
> > While we are at it; what about .../hw/mem/cxl_type3_stubs.c?
> >  =20
> > > >=20
> > > > (Ideally we wouldn't have let more gpl-2-only code into the
> > > > codebase without a rationale...) =20
> >=20
> > I'm curious about this statement.  Does the qemu project not want gpl v2
> > only code? =20
>=20
> Correct, this is explicitly stated in the LICENSE file:
>=20
> [quote]
> As of July 2013, contributions under version 2 of the GNU General Public
> License (and no later version) are only accepted for the following files
> or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
> [/quote]
>=20
> >             I agree with Jonathan that this is the intention of Ben's
> > initial submission; so from that PoV. =20
>=20
> Ideally we would get all QEMU CXL contributors to agree to re-license
> to the GPL-2.0-or-later, unless the code has been copied from another
> project which was GPL-2.0-only thus forcing our code.
>=20
> >=20
> > Acked-by: Ira Weiny <ira.weiny@intel.com>
> >=20
> > Going forward I'd like to better understand the qemu communities view. =
=20
>=20
> Please follow the LICENSE file which is explicit about QEMU's views
> per the quoted text above.

I'd be fine with relaxing these, but there are quite a few contributors
so it will be a little difficult to establish.

Given, for that to be useful we need to do all the CXL files, I'll post
a v2 of this series setting this to GPL-v2-only and we can see if we
can address relicencing at a later date.

>=20
> With regards,
> Daniel


