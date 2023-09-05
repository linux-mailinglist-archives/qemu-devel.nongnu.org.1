Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9179240D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYE6-0003b3-4T; Tue, 05 Sep 2023 11:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdYE3-0003aO-Ey
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:44:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdYDz-0006VW-7q
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:44:23 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg8sV4Bgfz6HJRk;
 Tue,  5 Sep 2023 23:42:54 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 16:44:14 +0100
Date: Tue, 5 Sep 2023 16:44:13 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/2] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230905164413.0000406c@huawei.com>
In-Reply-To: <56291b02-5474-77b6-5563-6367bf5dcb4c@linaro.org>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-3-Jonathan.Cameron@huawei.com>
 <56291b02-5474-77b6-5563-6367bf5dcb4c@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 4 Sep 2023 20:36:02 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> Hi Jonathan,
>=20
> Few style comments inlined.
>=20
> On 4/9/23 18:47, Jonathan Cameron wrote:
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
Hi Philippe,

Thanks for the particularly quick reviews!=20

...

> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index e96398e8af..79b9369756 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -42,6 +42,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_c=
state, hwaddr offset,
> >  =20
> >       switch (offset) {
> >       case A_CXL_HDM_DECODER0_CTRL:
> > +    case A_CXL_HDM_DECODER1_CTRL:
> > +    case A_CXL_HDM_DECODER2_CTRL:
> > +    case A_CXL_HDM_DECODER3_CTRL:
> >           should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, CO=
MMIT);
> >           should_uncommit =3D !should_commit;
> >           break;
> > @@ -81,7 +84,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwa=
ddr offset, uint64_t value,
> >       }
> >  =20
> >       if (offset >=3D A_CXL_HDM_DECODER_CAPABILITY &&
> > -        offset <=3D A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
> > +        offset <=3D A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> >           dumb_hdm_handler(cxl_cstate, offset, value);
> >       } else {
> >           cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_=
registers)] =3D value;
> > @@ -161,7 +164,7 @@ static void ras_init_common(uint32_t *reg_state, ui=
nt32_t *write_msk)
> >   static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >                               enum reg_type type)
> >   {
> > -    int decoder_count =3D 1;
> > +    int decoder_count =3D 4; =20
>=20
>    unsigned decoder_count =3D HDM_DECODER_COUNT;
>=20
> >       int i;
> >  =20
> >       ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_C=
OUNT,
> > @@ -174,19 +177,22 @@ static void hdm_init_common(uint32_t *reg_state, =
uint32_t *write_msk,
> >                        HDM_DECODER_ENABLE, 0);
> >       write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] =3D 0x3;
> >       for (i =3D 0; i < decoder_count; i++) { =20
>=20
> Alternatively:
>=20
>          for (i =3D 0; i < decoder_count; i++, write_msk +=3D 8) {
>              write_msk[R_CXL_HDM_DECODER0_BASE_LO] =3D 0xf0000000;

That's a bit nasty and fragile given we are offsetting the base register th=
an
indexing into it (so applying a later offset).

>=20
> > -        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] =3D 0xf000000=
0;
> > -        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] =3D 0xfffffff=
f;
> > -        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] =3D 0xf000000=
0;
> > -        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] =3D 0xfffffff=
f;
> > -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] =3D 0x13ff;
> > +        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4] =3D 0xf00=
00000; =20
>=20
> (this 0x20 / 4 bugs me a bit).

Instead, I've gone with a local variable which leaves me room for deriving
this based on the step between the registers for decoders 0 and 1.

hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;

I haven't added a define for this because it would probably have to be
long enough that it will cause line length problems :(
So it is replicated in a few different places which isn't ideal
but definitely better than the 0x20 / 4

>=20
> > +        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4]  =3D 0xff=
ffffff;
> > +        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4] =3D 0xf00=
00000;
> > +        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4] =3D 0xfff=
fffff;
> > +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4] =3D 0x13ff;
> >           if (type =3D=3D CXL2_DEVICE ||
> >               type =3D=3D CXL2_TYPE3_DEVICE ||
> >               type =3D=3D CXL2_LOGICAL_DEVICE) {
> > -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] =
=3D 0xf0000000;
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4=
] =3D
> > +                0xf0000000;
> >           } else {
> > -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] =
=3D 0xffffffff;
> > +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4=
] =3D
> > +                0xffffffff;
> >           }
> > -        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] =3D 0x=
ffffffff;
> > +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20 / 4] =3D
> > +            0xffffffff;
> >       }
> >   } =20
>=20


