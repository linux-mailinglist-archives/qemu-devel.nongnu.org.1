Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECC757C78
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 15:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLkJI-0005Qz-Ug; Tue, 18 Jul 2023 09:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLkJE-0005QO-0f
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:00:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLkJ9-00029p-NX
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:00:06 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4zVM5yYQz6J78f;
 Tue, 18 Jul 2023 20:56:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 14:00:00 +0100
Date: Tue, 18 Jul 2023 13:59:59 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH for-8.1] hw/pci-bridge/cxl_upstream.c: Use g_new0() in
 build_cdat_table()
Message-ID: <20230718135959.00001631@Huawei.com>
In-Reply-To: <961f67fe-8c79-d1e3-a58c-5516f00bb249@linaro.org>
References: <20230718101327.1111374-1-peter.maydell@linaro.org>
 <961f67fe-8c79-d1e3-a58c-5516f00bb249@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 18 Jul 2023 14:10:24 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 18/7/23 12:13, Peter Maydell wrote:
> > In build_cdat_table() we do:
> >   *cdat_table =3D g_malloc0(sizeof(*cdat_table) * CXL_USP_CDAT_NUM_ENTR=
IES);
> > This is wrong because:
> >   - cdat_table has type CDATSubHeader *** =20
>=20
> Yes
>=20
> >   - so *cdat_table has type CDATSubHeader ** =20
>=20
> Yes
>=20
> >   - so the array we're allocating here should be items of type CDATSubH=
eader * =20
>=20
> Yes
>=20
> >   - but we pass sizeof(*cdat_table), which is sizeof(CDATSubHeader **),=
 =20
>=20
> Indeed
>=20
> >     implying that we're allocating an array of CDATSubHeader ** =20
>=20
> Ouch
>=20
> > It happens that sizeof(CDATSubHeader **) =3D=3D sizeof(CDATSubHeader *)=
 =20
>=20
> Ah!
>=20
> > so nothing blows up, but this should be sizeof(**cdat_table). =20
>=20
> Still, what a mess :)


>=20
> > Avoid this excessively hard-to-understand code by using
> > g_new0() instead, which will do the type checking for us.
> > While we're here, we can drop the useless check against failure,
> > as g_malloc0() and g_new0() never fail. =20
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20
> > This fixes Coverity issue CID 1508120.
> >=20
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Disclaimer: I have not tested this beyond any testing you
> > get from 'make check' and 'make check-avocado'.

Ah.  Had this on my todo list form your report but got distracted.
Anyhow, thanks for fixing it up.

Tested somewhat. Actually poking this particular DOE instance to
read the CDAT requires a bunch of kernel hacks I haven't forward
ported recently and I don't want to delay this until I get back
to them - depends on some core PCI subsystem work that is ongoing.
Code isn't dependent on reading though so I can't see how this
would break anything.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>




> > ---
> >   hw/pci-bridge/cxl_upstream.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-) =20
>=20


