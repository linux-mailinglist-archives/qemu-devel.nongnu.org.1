Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0BC709C65
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02tx-0006ds-R1; Fri, 19 May 2023 12:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q02tr-0006dP-DC
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:24:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q02to-0007ie-0R
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:24:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QNBw10VsDz67fpR;
 Sat, 20 May 2023 00:22:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 17:24:04 +0100
Date: Fri, 19 May 2023 17:24:04 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 "Ira Weiny" <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel
 P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230519172404.0000649e@Huawei.com>
In-Reply-To: <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 19 May 2023 18:08:30 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 19/5/23 16:18, Jonathan Cameron wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >=20
> > CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> > specified as little endian.
> >=20
> > Define st24_le_p() and the supporting functions to store such a field
> > from a 32 bit host native value.
> >=20
> > The use of b, w, l, q as the size specifier is limiting.  So "24" was
> > used for the size part of the function name.
> >=20
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   docs/devel/loads-stores.rst |  1 +
> >   include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
> >   2 files changed, 28 insertions(+)
> >=20
> > diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> > index d2cefc77a2..82a79e91d9 100644
> > --- a/docs/devel/loads-stores.rst
> > +++ b/docs/devel/loads-stores.rst
> > @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
> >   ``size``
> >    - ``b`` : 8 bits
> >    - ``w`` : 16 bits
> > + - ``24`` : 24 bits
> >    - ``l`` : 32 bits
> >    - ``q`` : 64 bits
> >  =20
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 15a78c0db5..f546b1fc06 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -8,11 +8,25 @@
> >   #undef  bswap64
> >   #define bswap64(_x) __builtin_bswap64(_x)
> >  =20
> > +static inline uint32_t bswap24(uint32_t x)
> > +{
> > +    assert((x & 0xff000000U) =3D=3D 0); =20
>=20
> Asserting here is a bit violent. In particular because there is no
> contract description that x should be less than N bits for bswapN()
> in "qemu/bswap.h" API.
>=20
> But if you rather to assert ...


I'm fine either way.  You asked for it when reviewing v4...
https://lore.kernel.org/all/28a9d97a-b252-a33f-1ac0-cd36264b29ab@linaro.org/


>=20
> > +
> > +    return (((x & 0x000000ffU) << 16) |
> > +            ((x & 0x0000ff00U) <<  0) |
> > +            ((x & 0x00ff0000U) >> 16));
> > +}
> > +
> >   static inline void bswap16s(uint16_t *s)
> >   {
> >       *s =3D __builtin_bswap16(*s);
> >   }
> >  =20
> > +static inline void bswap24s(uint32_t *s)
> > +{
> > +    *s =3D bswap24(*s & 0x00ffffffU); =20
>=20
> ... and sanitize the value here ...
>=20
> > +}
> > +
> >   static inline void bswap32s(uint32_t *s)
> >   {
> >       *s =3D __builtin_bswap32(*s);
> > @@ -26,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
> >   #if HOST_BIG_ENDIAN
> >   #define be_bswap(v, size) (v)
> >   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> > +#define le_bswap24(v) bswap24(v) =20
>=20
> ... then shouldn't you sanitize also here?
>=20

Good point. I forgot that detail whilst fighting with s390
cross builds earlier ;)

> Personally I'd just drop the assertion.

I'm fine with doing that.

Jonathan

>=20
> >   #define be_bswaps(v, size)
> >   #define le_bswaps(p, size) \
> >               do { *p =3D glue(__builtin_bswap, size)(*p); } while (0)
> >   #else
> >   #define le_bswap(v, size) (v)
> > +#define le_bswap24(v) (v)
> >   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
> >   #define le_bswaps(v, size)
> >   #define be_bswaps(p, size) \
> > @@ -176,6 +192,7 @@ CPU_CONVERT(le, 64, uint64_t)
> >    * size is:
> >    *   b: 8 bits
> >    *   w: 16 bits
> > + *   24: 24 bits
> >    *   l: 32 bits
> >    *   q: 64 bits
> >    *
> > @@ -248,6 +265,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
> >       __builtin_memcpy(ptr, &v, sizeof(v));
> >   }
> >  =20
> > +static inline void st24_he_p(void *ptr, uint32_t v)
> > +{
> > +    __builtin_memcpy(ptr, &v, 3);
> > +}
> > +
> >   static inline int ldl_he_p(const void *ptr)
> >   {
> >       int32_t r;
> > @@ -297,6 +319,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
> >       stw_he_p(ptr, le_bswap(v, 16));
> >   }
> >  =20
> > +static inline void st24_le_p(void *ptr, uint32_t v)
> > +{
> > +    st24_he_p(ptr, le_bswap24(v));
> > +}
> > +
> >   static inline void stl_le_p(void *ptr, uint32_t v)
> >   {
> >       stl_he_p(ptr, le_bswap(v, 32)); =20
>=20
> Conditional to removing the assertion in bswap24():
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20


