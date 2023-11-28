Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8797FBA75
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 13:47:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xTw-0005Ho-GK; Tue, 28 Nov 2023 07:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r7xTo-0005Fv-FP
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 07:46:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r7xTk-000615-OZ
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 07:46:20 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sfhx31R31z6K9BS;
 Tue, 28 Nov 2023 20:44:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A91F61408FF;
 Tue, 28 Nov 2023 20:46:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 12:46:12 +0000
Date: Tue, 28 Nov 2023 12:46:11 +0000
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@lore.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 2/2] hw/mem/cxl_type3: allocate more vectors for MSI-X
Message-ID: <20231128124611.0000663e@Huawei.com>
In-Reply-To: <CAB=+i9RkLLXTcKNKw9j1EAHEu8ixCzeum88vsYj3mYW6MsbVgQ@mail.gmail.com>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-3-42.hyeyoo@gmail.com>
 <20231127175322.k3zt65vicd4o2ifv@offworld>
 <CAB=+i9RkLLXTcKNKw9j1EAHEu8ixCzeum88vsYj3mYW6MsbVgQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 28 Nov 2023 09:27:28 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Tue, Nov 28, 2023 at 2:53=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.ne=
t> wrote:
> >
> > On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:
> > =20
> > >commit 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background
> > >completion") enables notifying background command completion via MSI-X
> > >interrupt (vector number 9).
> > >
> > >However, the commit uses vector number 9 but the maximum number of
> > >entries is less thus resulting in error below. Fix it by passing
> > >nentries =3D 10 when calling msix_init_exclusive_bar(). =20
> >
> > Hmm yeah this was already set to 10 in Jonathan's tree, thanks for repo=
rting. =20
>=20
> Oh, yeah, it's based on the mainline tree. I should have checked Jonathan=
's.
>=20
> hmm it's already 10 there but vector number 9 is already being used by PC=
Ie DOE.
> So I think it should change msix_num =3D 11 and use vector number 10 for
> background command completion interrupt instead?
>=20
> https://gitlab.com/jic23/qemu/-/commit/2823f19188664a6d48a965ea8170c9efa2=
3cddab

Whilst I clearly messed up a rebase as this wasn't intended, it should be f=
ine
to have multiple things sharing a vector.

On my todo list is making the case of too few vectors being available work =
for
all the cases in which case everything may end up on one vector.
So we do need to expand the vectors to cover what we are asking for, but
moving this to 11 is a nice to have rather than required.

Jonathan

>=20
> Thanks!
>=20
> --
> Hyeonggon


