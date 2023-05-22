Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A668E70BCF8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14M3-0001MK-Vh; Mon, 22 May 2023 08:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q14Lp-0001Ea-Ps
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:09:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q14Lm-0003WM-Oh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:09:21 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPx2h4R23z6J6dY;
 Mon, 22 May 2023 20:04:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 13:09:13 +0100
Date: Mon, 22 May 2023 13:09:12 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 "Ira Weiny" <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel
 P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230522130912.0000555f@Huawei.com>
In-Reply-To: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
 <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
 <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, 20 May 2023 19:08:22 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 20/5/23 17:15, Richard Henderson wrote:
> > On 5/20/23 06:15, BALATON Zoltan wrote: =20
> >> On Sat, 20 May 2023, Peter Maydell wrote: =20
> >>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> >>> <qemu-devel@nongnu.org> wrote: =20
> >>>>
> >>>> From: Ira Weiny <ira.weiny@intel.com>
> >>>>
> >>>> CXL has 24 bit unaligned fields which need to be stored to.=A0 CXL is
> >>>> specified as little endian.
> >>>>
> >>>> Define st24_le_p() and the supporting functions to store such a field
> >>>> from a 32 bit host native value.
> >>>>
> >>>> The use of b, w, l, q as the size specifier is limiting.=A0 So "24" =
was
> >>>> used for the size part of the function name. =20
> >>
> >> Maybe it's clearer to use 24 but if we want to keep these somewhat=20
> >> consistent how about using t for Triplet, Three-bytes or Twenty-four? =
=20
> >=20
> > I think it's clearer to use '3'.
> > When I added 128-bit support I used cpu_ld16_mmu. =20

As an aside on that - you didn't update the docs when you added that
(I was looking for it to copy your regex ;)

>=20
> There is also ld8u / ld8s / st8.
>=20
> > I think it would be clearer to not use letters anywhere, and to use=20
> > units of bytes instead of units of bits (no one can store just a bit),=
=20
> > but changing everything is a big job. =20
>=20
> So:
>=20
> ldub ->  ld1u,
>=20
> lduw_le -> ld2u_le,
>=20
> virtio_stl -> virtio_st4,
>=20
> stq_be -> st8_be.
>=20
> Right?
>=20
> Also we have:
>=20
> cpu_ld/st_*
> virtio_ld/st_*
> ld/st_*_phys
> ld/st_*_pci_dma
> address_space_ld/st
>=20
> While mass-changing, we could use FOO_ld/st_BAR with FOO
> for API and BAR for API variant (endian, mmuidx, ra, ...):
>=20
> So:
>=20
> ld/st_*_pci_dma -> pci_dma_ld/st_*
>=20
> for ld/st_*_phys I'm not sure.


