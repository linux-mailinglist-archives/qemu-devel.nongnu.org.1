Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56079E2DB
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLkR-0003hy-Rv; Wed, 13 Sep 2023 05:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLkM-0003fV-Ls
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:01:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLkK-00016H-AP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:01:18 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlvXM0Vvyz6HJcx;
 Wed, 13 Sep 2023 16:59:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 10:01:13 +0100
Date: Wed, 13 Sep 2023 10:01:12 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
 decoder block size everywhere
Message-ID: <20230913100112.000031a8@Huawei.com>
In-Reply-To: <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
 <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
 <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Wed, 13 Sep 2023 08:53:55 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 11/9/23 13:43, Jonathan Cameron wrote:
> > In order to avoid having the size of the per HDM decoder register block
> > repeated in lots of places, create the register definitions for HDM
> > decoder 1 and use the offset between the first registers in HDM decoder=
 0 and
> > HDM decoder 1 to establish the offset.
> >=20
> > Calculate in each function as this is more obvious and leads to shorter
> > line lengths than a single #define which would need a long name
> > to be specific enough.
> >=20
> > Note that the code currently only supports one decoder, so the bugs this
> > fixes don't actually affect anything. Previously the offset didn't
> > take into account that the write_msk etc are 4 byte fields.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > --
> > v3:
> > New patch to separate this out from the addition of HDM decoders.
> > ---
> >   include/hw/cxl/cxl_component.h |  2 ++
> >   hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
> >   hw/cxl/cxl-host.c              |  4 +++-
> >   hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
> >   4 files changed, 31 insertions(+), 18 deletions(-) =20
>=20
>=20
> > @@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
> >   /* TODO: Support multiple HDM decoders and DPA skip */
> >   static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64=
_t *dpa)
> >   {
> > +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BA=
SE_LO;
> >       uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
> >       uint64_t decoder_base, decoder_size, hpa_offset;
> >       uint32_t hdm0_ctrl;
> >       int ig, iw;
> > +    int i =3D 0;
> >  =20
> > -    decoder_base =3D (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI]=
 << 32) |
> > -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> > +    decoder_base =3D
> > +        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc=
] << 32) |
> > +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc=
]); =20
>=20
> Alternatively easier to review as (matter of taste ?):
>=20
> decoder_base =3D deposit64(cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i *=20
> hdm_inc], 32, 32,
>                           cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i *=20
> hdm_inc]);

I'll leave if for now for consistency in the CXL code.  Might make
sense to consider this as a cross subsystem cleanup at some point though!
Thanks for the suggestion.

>=20
> Regardless:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Thanks.

Jonathan

>=20
>=20


