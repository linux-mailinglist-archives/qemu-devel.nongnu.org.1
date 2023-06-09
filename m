Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F86729F89
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7aAs-00005n-D5; Fri, 09 Jun 2023 07:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7aAn-00005M-7b
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:20:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7aAk-0000eB-HU
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:20:52 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qcz8j2wMKz6J7vv;
 Fri,  9 Jun 2023 19:18:13 +0800 (CST)
Received: from localhost (10.126.170.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 12:20:34 +0100
Date: Fri, 9 Jun 2023 12:20:31 +0100
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "<\"qemu-devel@nongnu.org\"" <qemu-devel@nongnu.org>
Subject: Re: [EXT] Re: Concept of LD-ID in QEMU
Message-ID: <20230609122031.00004bb8@Huawei.com>
In-Reply-To: <DM6PR18MB2844E5BFADF8599A9393358AAF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-15-terry.bowman@amd.com>
 <DM6PR18MB2844C099FB0671E864AA953DAF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230608113153.000033ef@Huawei.com>
 <20230608113631.00007a53@Huawei.com>
 <DM6PR18MB2844E5BFADF8599A9393358AAF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.170.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 8 Jun 2023 23:38:34 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> Hi,
>=20
> Thinking a bit more, LD in CXL are PCIe endpoint functions. Therefore 1-1=
 mapping of cxl-i2c device per PCIe device is sufficient, and we use functi=
on number in BDF as the LD-ID. Does it makes sense ?

LDs are PCIe endpoint functions (always function 0) as seen from the Virtual
Heirarchies (as they end up under a particular vPBB - which look like a
downstream port of a switch to the host) but they aren't from a more general
topology point of view of actual fabric topology and when we are tunneling =
we
address them via physical port, not virtual port I think (not read that bit
of the spec for a while). See figure 7-23 in CXL 3.0

Outer tunneling command targets a port number (unwrapped at the switch),
inner one targets the LD - unwrapped at the MLD and sent to appropriate LD
including FM owned LD (if I understand this stack directly).

Also no relationship between BDF and LD-ID so don't do that as the maximum
ID is only 16 which would rather limit your PCI toplogies if that's the BDF=
 as
well.

For now just do what you originally said and add an ID (starting from 0).
We can probably do that automatically once more infrastructure is in place.

Jonathan


>=20
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, June 8, 2023 3:36 AM
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; <"qemu-devel@n=
ongnu.org" <qemu-devel@nongnu.org>
> Subject: [EXT] Re: Concept of LD-ID in QEMU=20
> =A0
> External Email
>=20
> ----------------------------------------------------------------------
>=20
> Shesha,
>=20
> You've sent an email with the 'In-reply-to' set to one of Terry's patches.
> Please check why that happened and make sure you don't do that in future =
as
> it hides your unrelated thread in email clients and the archives!
>=20
> See
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dcxl_20230607221651.2454764-2D1-2Dterry.bowman-40amd.com_T_-23t&d=3DDw=
IFAw&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o=
4unU&m=3DZMaAF9tkNCKfk8gYXMiPERZeIhavaQ7MdKtqCbShRF6w5ISrgHqAl6XDOONYbprZ&s=
=3DERVX40JlAgnvRvPLm8sYZalsYDbpUU7YAqI0Ol0faPI&e=3D=A0=20
> for example
>=20
> ss - Apologies. Will be careful.
>=20
> Jonathan
>=20
> On Thu, 8 Jun 2023 11:31:53 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>=20
> > On Wed, 7 Jun 2023 23:01:11 +0000
> > Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:
> >  =20
> > > Hi,
> > > For DCD sideband there needs=A0to=A0be LD-ID. Is the following approa=
ch acceptable?=A0  =20
> >=20
> > QEMU question so +CC qemu-devel
> >  =20
> > >=20
> > > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem0,dc-memdev=
=3Dvmem1,id=3Dcxl-vmem0,num-dc-regions=3D2,ldid=3D0 \
> > > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem1,dc-memdev=
=3Dvmem2,id=3Dcxl-vmem1,num-dc-regions=3D2,ldid=3D1 \=A0  =20
> >=20
> > Those will be PCI functions at this level so you can't do this until we=
 have more advanced switch support
> > (it has to know about multiple VHs - right now we only support fixed co=
nfig switches).=A0 You could connect them
> > to different switch ports - effectively that will be what it looks like=
 when we do emulate a configurable switch.
> >  =20
> > > =A0-device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D24,target=3D=
cxl-vmem0,cxl-vmem1")
> > >=20
> > > With this configuration, the same i2c device is handing both LDs and =
in FMAPI commands we use the LDID specified above.=A0  =20
> >=20
> > This effectively becomes a partial implementation of either an MLD or a=
n MH-SLD
> > To manage the actual memory access, those will almost certainly need a =
bunch of other shared
> > infrastructure.=A0 So I'd ultimately expect the i2c_mctp_cxl device to =
target whatever
> > device represents that shared infrastructure - it might be a separate d=
evice or a 'lead' type 3 device.
> >=20
> > So I'm not sure how this will fit together longer term.=A0 We need same=
 infrastructure
> > to work for a mailbox CCI on a MH-SLD/MLD as well and in that case ther=
e isn't a separate
> > device to which we can provide multiple targets as you've done in your =
proposal here.
> >=20
> > So I think we need to work out how to handle all of (I've probably forg=
otten something)
> > X marks done or in progress.
> >=20
> > X 1) i2c_mctp_cxl to an SLD (no PCI Mailbox definition for this one)
> >=A0=A0 2) i2c_mctp_cxl directly to an MLD (your case)
> > X 3) i2c_mctp_cxl to a fixed config switch (single fixed VH no MLD capa=
ble ports)
> > X 4) PCI mailbox via switch CCI device that fixed config switch (no MLD=
 capable ports)
> >=A0=A0=A0=A0=A0=A0=A0 Even with this simple design some fun things you c=
an do.
> >=A0=A0 5) i2c_mctp_cxl to a configurable switch (probably a separate as =
yet to be defined management interface - that messes with hotplug)
> >=A0=A0 6) PCI mailbox via switch CCI to configurable switch (again to de=
fined management interface).
> >=A0=A0 7) i2c_mctp_cxl to an MH-SLD - probably to which ever device also=
 has support for
> >=A0=A0=A0=A0=A0 tunneling to the FM owned LD via the PCI mailbox.
> > X 8) PCI mailbox on MH-SLD tunneling to the FM owned LD.
> >=A0=A0 9) i2c_mctp_cxl to an MH-MLD - similar to above - this one isn't =
that much more complex than MH-SLD case.
> > X 10) PCI mailbox to MH-MLD - similar to above.
> >=A0=A0 11) Tunneling via the switch CCI (then over PCI-VDM - though that=
 detail isn't visible in QEMU) to an SLD
> >=A0=A0 12) Tunneling via the switch CCI (then PCI-VDM) to an MH-SLD and =
on to he FM owned LD.
> >=A0=A0 13) Tunneling via the switch CCI (then over PCI-VDM) to an MLD / =
MH-MLD
> >=A0=20
> > Current i2c_mctp_cxl covers 1 and 3
> > I'm part way through the tunnelling support for (8 and 100) - need to r=
evisit and wire up the switch CCI PoC
> > properly which will give us 4.
> >=20
> > 2 needs MLD support in general which we could maybe make work with a st=
atic binding in a switch but that
> >=A0=A0 would be odd - so we probably need to emulate a configurable swit=
ch for that
> > 5,6 need configurable switch
> > 7 needs same as 2 plus tunneling part similar to 4
> > 9 again probably configurable switch for the MLD part to make sense
> > 11 is fairly straight forward - but not done yet.
> > 12 also not too bad, but needs the MH-SLD part to be fleshed out (some =
work on going )
> > 13 needs pretty much everything defined.
> >=20
> > Trying to get the command line interface and device model right until w=
e have PoC code
> > for a few more cases is going to be at most a draft of what it might lo=
ok like.
> >=20
> > So in short, lots to do.=A0 For now feel free to hack whatever you need=
 in to be able
> > to test the FM-API side of things, we can move that towards a clean com=
mand line definition
> > once we have one figured out!
> >=20
> > Jonathan
> >=20
> >  =20
> > >=20
> > > Thanks,
> > > Shesha.=A0  =20
> >=20
> >  =20


