Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7D785B52
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpLB-0006hk-N9; Wed, 23 Aug 2023 11:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYpKx-0005YM-3o
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:59:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYpKu-0008LF-4B
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:59:58 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RW8Qh1NbDz6K6Hd;
 Wed, 23 Aug 2023 22:55:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 15:59:50 +0100
Date: Wed, 23 Aug 2023 15:59:49 +0100
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC: <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 <linuxarm@huawei.com>, James Morse <james.morse@arm.com>, "peter . maydell @
 linaro . org" <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>, "Yicong
 Yang" <yangyicong@huawei.com>
Subject: Re: [RFC PATCH 2/5] HACK: target/arm/tcg: Add some more caches to
 cpu=max
Message-ID: <20230823155949.000071d2@Huawei.com>
In-Reply-To: <87y1ierkuh.fsf@linaro.org>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
 <20230808115713.2613-3-Jonathan.Cameron@huawei.com>
 <87y1ierkuh.fsf@linaro.org>
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

On Mon, 14 Aug 2023 11:13:58 +0100
Alex Benn=E9e <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>=20
> > Used to drive the MPAM cache intialization and to exercise more
> > of the PPTT cache entry generation code. Perhaps a default
> > L3 cache is acceptable for max?
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  target/arm/tcg/cpu64.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index 8019f00bc3..2af67739f6 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -711,6 +711,17 @@ void aarch64_max_tcg_initfn(Object *obj)
> >      uint64_t t;
> >      uint32_t u;
> > =20
> > +    /*
> > +     * Expanded cache set
> > +     */
> > +    cpu->clidr =3D 0x8204923; /* 4 4 4 4 3 in 3 bit fields */
> > +    cpu->ccsidr[0] =3D 0x000000ff0000001aull; /* 64KB L1 dcache */
> > +    cpu->ccsidr[1] =3D 0x000000ff0000001aull; /* 64KB L1 icache */
> > +    cpu->ccsidr[2] =3D 0x000007ff0000003aull; /* 1MB L2 unified cache =
*/
> > +    cpu->ccsidr[4] =3D 0x000007ff0000007cull; /* 2MB L3 cache 128B lin=
e */
> > +    cpu->ccsidr[6] =3D 0x00007fff0000007cull; /* 16MB L4 cache 128B li=
ne */
> > +    cpu->ccsidr[8] =3D 0x0007ffff0000007cull; /* 2048MB L5 cache 128B =
line */
> > + =20
>=20
> I think Peter in another thread wondered if we should have a generic
> function for expanding the cache idr registers based on a abstract lane
> definition.=20
>=20

Great!

This response?
https://lore.kernel.org/qemu-devel/CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcf=
Kv8Bg1f+rCg@mail.gmail.com/

That might get us somewhere but ultimately I think we need a general way to=
 push this stuff
in as parameters of the CPU or a CPU definition with a wide enough set of c=
aches to allow us to
poke the boundaries and hang a typical MPAM setup off it.  Would people min=
d adding at least
an L3 to max? The L4 and above is useful for checking the PPTT building cod=
e works,
but that's probably more a development time activity than an every day one.

Jonathan



> >      /*
> >       * Reset MIDR so the guest doesn't mistake our 'max' CPU type for =
a real
> >       * one and try to apply errata workarounds or use impdef features =
we
> > @@ -828,6 +839,7 @@ void aarch64_max_tcg_initfn(Object *obj)
> >      t =3D FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at lev=
el 2 */
> >      t =3D FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
> >      t =3D FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
> > +    t =3D FIELD_DP64(t, ID_AA64MMFR2, CCIDX, 1);      /* FEAT_TTCNP */
> >      cpu->isar.id_aa64mmfr2 =3D t;
> > =20
> >      t =3D cpu->isar.id_aa64zfr0; =20
>=20
>=20


