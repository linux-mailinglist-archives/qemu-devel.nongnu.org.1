Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DC727CF1
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7D0S-00017C-2O; Thu, 08 Jun 2023 06:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7D0Q-00016x-6N
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:36:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7D0O-0005Kb-A6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:36:37 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcLDh3Q3yz67NsF;
 Thu,  8 Jun 2023 18:34:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 11:36:32 +0100
Date: Thu, 8 Jun 2023 11:36:31 +0100
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "<\"qemu-devel@nongnu.org\"" <qemu-devel@nongnu.org>
Subject: Re: Concept of LD-ID in QEMU
Message-ID: <20230608113631.00007a53@Huawei.com>
In-Reply-To: <20230608113153.000033ef@Huawei.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-15-terry.bowman@amd.com>
 <DM6PR18MB2844C099FB0671E864AA953DAF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230608113153.000033ef@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
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


Shesha,

You've sent an email with the 'In-reply-to' set to one of Terry's patches.
Please check why that happened and make sure you don't do that in future as
it hides your unrelated thread in email clients and the archives!

See
https://lore.kernel.org/linux-cxl/20230607221651.2454764-1-terry.bowman@amd=
.com/T/#t=20
for example

Jonathan

On Thu, 8 Jun 2023 11:31:53 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Jun 2023 23:01:11 +0000
> Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:
>=20
> > Hi,
> > For DCD sideband there needs=A0to=A0be LD-ID. Is the following approach=
 acceptable? =20
>=20
> QEMU question so +CC qemu-devel
>=20
> >=20
> > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem0,dc-memdev=3D=
vmem1,id=3Dcxl-vmem0,num-dc-regions=3D2,ldid=3D0 \
> > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem1,dc-memdev=3D=
vmem2,id=3Dcxl-vmem1,num-dc-regions=3D2,ldid=3D1 \ =20
>=20
> Those will be PCI functions at this level so you can't do this until we h=
ave more advanced switch support
> (it has to know about multiple VHs - right now we only support fixed conf=
ig switches).  You could connect them
> to different switch ports - effectively that will be what it looks like w=
hen we do emulate a configurable switch.
>=20
> > =A0-device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D24,target=3Dcx=
l-vmem0,cxl-vmem1")
> >=20
> > With this configuration, the same i2c device is handing both LDs and in=
 FMAPI commands we use the LDID specified above. =20
>=20
> This effectively becomes a partial implementation of either an MLD or an =
MH-SLD
> To manage the actual memory access, those will almost certainly need a bu=
nch of other shared
> infrastructure.  So I'd ultimately expect the i2c_mctp_cxl device to targ=
et whatever
> device represents that shared infrastructure - it might be a separate dev=
ice or a 'lead' type 3 device.
>=20
> So I'm not sure how this will fit together longer term.  We need same inf=
rastructure
> to work for a mailbox CCI on a MH-SLD/MLD as well and in that case there =
isn't a separate
> device to which we can provide multiple targets as you've done in your pr=
oposal here.
>=20
> So I think we need to work out how to handle all of (I've probably forgot=
ten something)
> X marks done or in progress.
>=20
> X 1) i2c_mctp_cxl to an SLD (no PCI Mailbox definition for this one)
>   2) i2c_mctp_cxl directly to an MLD (your case)
> X 3) i2c_mctp_cxl to a fixed config switch (single fixed VH no MLD capabl=
e ports)
> X 4) PCI mailbox via switch CCI device that fixed config switch (no MLD c=
apable ports)
> 	Even with this simple design some fun things you can do.
>   5) i2c_mctp_cxl to a configurable switch (probably a separate as yet to=
 be defined management interface - that messes with hotplug)
>   6) PCI mailbox via switch CCI to configurable switch (again to defined =
management interface).
>   7) i2c_mctp_cxl to an MH-SLD - probably to which ever device also has s=
upport for
>      tunneling to the FM owned LD via the PCI mailbox.
> X 8) PCI mailbox on MH-SLD tunneling to the FM owned LD.
>   9) i2c_mctp_cxl to an MH-MLD - similar to above - this one isn't that m=
uch more complex than MH-SLD case.
> X 10) PCI mailbox to MH-MLD - similar to above.
>   11) Tunneling via the switch CCI (then over PCI-VDM - though that detai=
l isn't visible in QEMU) to an SLD
>   12) Tunneling via the switch CCI (then PCI-VDM) to an MH-SLD and on to =
he FM owned LD.
>   13) Tunneling via the switch CCI (then over PCI-VDM) to an MLD / MH-MLD
> =20
> Current i2c_mctp_cxl covers 1 and 3
> I'm part way through the tunnelling support for (8 and 100) - need to rev=
isit and wire up the switch CCI PoC
> properly which will give us 4.
>=20
> 2 needs MLD support in general which we could maybe make work with a stat=
ic binding in a switch but that
>   would be odd - so we probably need to emulate a configurable switch for=
 that
> 5,6 need configurable switch
> 7 needs same as 2 plus tunneling part similar to 4
> 9 again probably configurable switch for the MLD part to make sense
> 11 is fairly straight forward - but not done yet.
> 12 also not too bad, but needs the MH-SLD part to be fleshed out (some wo=
rk on going )
> 13 needs pretty much everything defined.
>=20
> Trying to get the command line interface and device model right until we =
have PoC code
> for a few more cases is going to be at most a draft of what it might look=
 like.
>=20
> So in short, lots to do.  For now feel free to hack whatever you need in =
to be able
> to test the FM-API side of things, we can move that towards a clean comma=
nd line definition
> once we have one figured out!
>=20
> Jonathan
>=20
>=20
> >=20
> > Thanks,
> > Shesha. =20
>=20
>=20


