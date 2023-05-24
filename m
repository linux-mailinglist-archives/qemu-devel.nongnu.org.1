Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B270F223
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:21:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kfj-0000cj-O1; Wed, 24 May 2023 05:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q1kfh-0000aH-MP
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:20:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q1kfe-0003So-Ng
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:20:40 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QR5Gm73tGz67M49;
 Wed, 24 May 2023 17:19:12 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 10:20:34 +0100
Date: Wed, 24 May 2023 10:20:33 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira
 Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Michael Roth <michael.roth@amd.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <20230524102033.00002d41@huawei.com>
In-Reply-To: <20230524101158.0000579d@huawei.com>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
 <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
 <87lehgq1cy.fsf@pond.sub.org> <20230522135737.000079c4@Huawei.com>
 <87fs7na2o8.fsf@pond.sub.org> <20230523113543.00006a1f@Huawei.com>
 <87ttw35i6q.fsf@pond.sub.org> <20230524101158.0000579d@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 24 May 2023 10:11:58 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 23 May 2023 14:46:37 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> >=20
> > >> >   =20
> > >> >> > +#
> > >> >> > +# Inject an event record for a General Media Event (CXL r3.0 8=
.2.9.2.1.1)     =20
> > >> >>=20
> > >> >> What's "CXL r3.0", and where could a reader find it?   =20
> > >> >
> > >> > We have docs in docs/system/devices/cxl.rst that include the conso=
rtium
> > >> > website which has download links on the front page.   =20
> > >>=20
> > >> cxl.rst has
> > >>=20
> > >>     References
> > >>     ----------
> > >>=20
> > >>      - Consortium website for specifications etc:
> > >>        http://www.computeexpresslink.org
> > >>      - Compute Express link Revision 2 specification, October 2020
> > >>      - CEDT CFMWS & QTG _DSM ECN May 2021
> > >>=20
> > >> Should the second reference be updated to 3.0?  Exact title seems to=
 be
> > >> "The Compute Express Link=E2=84=A2 (CXL=E2=84=A2) 3.0 specification"=
.  Not sure we need
> > >> to bother with the "=E2=84=A2" in a reference. =20
> > >
> > > Yes. On the todo list is to update all the references to latest relea=
sed
> > > specification because old ones are unobtainable to non consortium mem=
bers
> > > unless they grabbed a copy in the past.
> > >
> > > Annoyingly this will be a repeated requirement as new spec versions a=
re released
> > > but the cadence should be fairly low.
> > > =20
> > >>  =20
> > >> >                                                      I'm not sure =
we want to
> > >> > have lots of references to the URL spread throughout QEMU.  I can =
add one
> > >> > somewhere in cxl.json if you think it is important to have one her=
e as well.   =20
> > >>=20
> > >> You could add an introduction right under the "# =3D CXL devices" he=
ading,
> > >> and include a full reference to the specification there.  Suitably
> > >> abbreviated references like the ones you use in this patch should th=
en
> > >> be fine. =20
> > >
> > > I tried doing that - it resulted in the index including an entry with=
 all the text.
> > > So on the webpage, the contents list to the left includes whatever te=
xt you put
> > > in that block.
> > > =20
> > > I'm not sure why, or how to fix that. =20
> >=20
> > Show me what you tried (as a patch or something I can git-pull), and
> > I'll have a look.
> >=20
> > [...]
> >=20
> Very simple to replicate the issue - see below.
>=20
> Result of this is an extra
> "Test text" entry in the index to the left of the html docs.
>=20
> In qemu-qmp-ref.html we have
>=20
> <li class=3D"toctree-l3"><a class=3D"reference internal" href=3D"#qapidoc=
-3297">CXL devices</a><ul>
> <li class=3D"toctree-l4"><a class=3D"reference internal" href=3D"#qapidoc=
-3298">Test text</a></li>
> <li class=3D"toctree-l4"><a class=3D"reference internal" href=3D"#qapidoc=
-3301"><code class=3D"docutils literal notranslate"><span class=3D"pre">Cxl=
EventLog</span></code> (Enum)</a></li>

Experimented and dived in the code a bit more and got reminded of how bad m=
y python is
(which is why I was avoiding looking at this :)
One option would be to give the extra text a meaningful title so that ends =
up in the contents list.

> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -3,6 +3,8 @@
>=20
>  ##
>  # =3D CXL devices
> +#
> +# CXL Background
> +#
> +# Actually useful text.
>  ##
>=20
>  ##

Can't do
=3D=3D CXL Background

though to get it nicely formatted as then we loose all the actual entries f=
rom the
contents list.  I guess they dropped down one too many levels.

>=20
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 05c560cfe5..9f7f0485ae 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -3,6 +3,8 @@
>=20
>  ##
>  # =3D CXL devices
> +#
> +# Test text
>  ##
>=20
>  ##


