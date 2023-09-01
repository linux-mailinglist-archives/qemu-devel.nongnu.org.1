Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D207A78FA81
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc078-0007pR-UT; Fri, 01 Sep 2023 05:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qc05w-0006zk-Tg
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:05:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qc05r-0002a2-4I
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:05:35 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcX6v38F3z6FGLT;
 Fri,  1 Sep 2023 17:00:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 10:05:17 +0100
Date: Fri, 1 Sep 2023 10:05:14 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, <kwangjin.ko@sk.com>
Subject: Re: [PATCH 3/4] cxl/type3: minimum MHD cci support
Message-ID: <20230901100514.0000074b@Huawei.com>
In-Reply-To: <ZPDG7EKSXmMSAiJa@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
 <20230721163505.1910-4-gregory.price@memverge.com>
 <20230807155609.000055db@Huawei.com>
 <ZPDG7EKSXmMSAiJa@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 31 Aug 2023 12:59:24 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Mon, Aug 07, 2023 at 03:56:09PM +0100, Jonathan Cameron wrote:
> > On Fri, 21 Jul 2023 12:35:08 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> >  =20
> > > Implement the MHD GET_INFO cci command and add a shared memory
> > > region to the type3 device to host the information.
> > >=20
> > > Add a helper program to initialize this shared memory region.
> > >=20
> > > Add a function pointer to type3 devices for future work that
> > > will allow an mhd device to provide a hook to validate whether
> > > a memory access is valid or not.
> > >=20
> > > For now, limit the number of LD's to the number of heads. Later,
> > > this limitation will need to be lifted for MH-MLDs.
> > >=20
> > > Intended use case:
> > >=20
> > > 1. Create the shared memory region
> > > 2. Format the shared memory region
> > > 3. Launch QEMU with `is_mhd=3Dtrue,mhd_head=3DN,mhd_shmid=3D$shmid` =
=20
> >=20
> > I'd definitely like some feedback from experienced QEMU folk on
> > how to model this sort of cross QEMU instance sharing.
> >=20
> > My instinct is a socket would be more flexible as it lets us
> > potentially emulate the machines on multiple hosts (assuming they
> > can see some shared backend storage).
> >  =20
>=20
> I'd considered a socket, but after mulling it over, I realized the
> operations I was trying to implement amounted to an atomic compare
> and swap.  I wanted to avoid locks and serialization if at all
> possible to avoid introducing that into the hot-path of memory
> accesses.  Maybe there is a known pattern for this kind of
> multi-instance QEMU coherency stuff, but that seemed the simplest path.

I'd definitely like some input from others on this if possible as I've
no idea if this problem has really been tackled in the past.
>=20
> This obviously has the downside of limiting emulation of MHD system to
> a local machine, but the use of common files/memory to back CXL memory
> already does that (i think).

Files should be fine I think on a suitable sharing aware file system.

>=20
> =C2=AF\_(=E3=83=84)_/=C2=AF feedback welcome.  I'll leave it for now unle=
ss there are
> strong opinions.
>=20
> > else not needed if we returned in previous leg.
> >=20
> > 	if (ct3d->is_mhd && ...
> >  =20
> > > +               (!ct3d->mhd_shmid || (ct3d->mhd_head =3D=3D ~(0)))) {=
 =20
> >=20
> > How does mhd_head equal that? Default is 0. I'm not sure there is a rea=
son
> > to require it.
> >  =20
>=20
> Good catch, the default should be ~(0).  Updated in the field
> initialization section.
>=20
> > > +    /* For now, limit the number of heads to the number of LD's (SLD=
) */ =20
> >=20
> > Feels backwards.  Number of heads never going to be bigger than numbre =
of
> > LDs.  Other way around is possible of course.
> >  =20
> > > +    if (ct3d->mhd_state->nr_heads <=3D ct3d->mhd_head) { =20
> >=20
> > mhd head needs to be out of range?  Confused.
> >  =20
>=20
> Woops, yes this should be mhd_head >=3D nr_heads. Wording is backwards and
> so is the code.  fixed.
>=20
> > > +    if (ct3d->mhd_state) {
> > > +        shmdt(ct3d->mhd_state);
> > > +    } =20
> >=20
> > Reverse order of realize - so I think this wants to be earlier.
> >  =20
> > >  } =20
>=20
> Just to be clear you *don't* want the reverse order, correct?  If so
> i'll swap it.

I do want reverse order.   Generally speaking it's much easier to
review precisely matching reverse order as then mostly the ordering is
fine in a way that it isn't in any other ordering.

>=20
> > > =20
> > > +    if (ct3d->is_mhd && ct3d->mhd_access_valid) {
> > > +        if (!ct3d->mhd_access_valid(ct3d, dpa_offset, size))
> > > +            return MEMTX_ERROR; =20
> >=20
> > Brackets for inner block.
> > Arguably could just add the ct3d->is_mhd check in the place where
> > mhd_access_valid is set and hence only need to check that here.
> > Maybe that makes it slightly harder to follow though.
> >=20
> > Also could just unset is_mhd if mhd_access_valid not present..
> > =20
>=20
> I'm going to change the next patch to fully inherit CXLType3Dev into
> Niagara as you suggested.  I will have to see what falls out when i do
> that, but my feeling was being more explicit when checking pointers is
> better.  If you prefer to to drop the is_mhd check i'm ok with that
> simply because mhd_access_valid should always be NULL when is_mhd is
> false.  Either way the result is the same.

Minimizing redundant checks is always good as long as a reviewer can
easily see they are redundant. I think that's true here.

Jonathan

>=20
> ~Gregory


