Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85FAAE01DA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 11:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSBit-0004Hb-T5; Thu, 19 Jun 2025 05:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSBir-0004Fr-8P; Thu, 19 Jun 2025 05:38:17 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSBio-0003uN-Mr; Thu, 19 Jun 2025 05:38:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNFrV1P58z6M5dH;
 Thu, 19 Jun 2025 17:37:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9DA511404C6;
 Thu, 19 Jun 2025 17:38:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Jun
 2025 11:38:03 +0200
Date: Thu, 19 Jun 2025 10:38:02 +0100
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <20250619103802.00000dfa@huawei.com>
In-Reply-To: <20250619103028.00000277@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
 <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
 <e4879b1e26f941b5baa419824e4c928c@huawei.com>
 <6e180d39-b1eb-4935-98b0-3ac73766e8aa@redhat.com>
 <5fd7717fcd7e45d9aaff3e293cf63683@huawei.com>
 <20250619103028.00000277@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

On Thu, 19 Jun 2025 10:30:28 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 19 Jun 2025 09:05:07 +0100
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Eric Auger <eric.auger@redhat.com>
> > > Sent: Thursday, June 19, 2025 8:41 AM
> > > To: Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi@huawei.com>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>
> > > Cc: Linuxarm <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
> > > devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
> > > nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> > > imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > > smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > > jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
> > > Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe
> > > Root Complex association
> > >=20
> > > Hi Shameer,
> > >=20
> > > On 6/19/25 9:24 AM, Shameerali Kolothum Thodi wrote:   =20
> > > > Hi Eric,
> > > >   =20
> > > >> -----Original Message-----
> > > >> From: Eric Auger <eric.auger@redhat.com>
> > > >> Sent: Wednesday, June 18, 2025 6:00 PM
> > > >> To: Shameerali Kolothum Thodi
> > > >> <shameerali.kolothum.thodi@huawei.com>; Jonathan Cameron
> > > >> <jonathan.cameron@huawei.com>
> > > >> Cc: Linuxarm <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
> > > >> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
> > > >> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> > > >> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > > >> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > > >> jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
> > > >> Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has   =
=20
> > > PCIe   =20
> > > >> Root Complex association
> > > >>
> > > >> Hi Shameer, Jonathan,
> > > >>
> > > >> On 6/18/25 10:35 AM, Shameerali Kolothum Thodi wrote:   =20
> > > >>>> -----Original Message-----
> > > >>>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > >>>> Sent: Tuesday, June 17, 2025 5:53 PM
> > > >>>> To: Eric Auger <eric.auger@redhat.com>
> > > >>>> Cc: Shameerali Kolothum Thodi
> > > >>>> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> > > >>>> <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
> > > >>>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
> > > >>>> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> > > >>>> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > > >>>> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > > >>>> jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
> > > >>>> Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has  =
 =20
> > > >> PCIe   =20
> > > >>>> Root Complex association
> > > >>>>
> > > >>>> On Tue, 17 Jun 2025 09:49:54 +0200
> > > >>>> Eric Auger <eric.auger@redhat.com> wrote:
> > > >>>>   =20
> > > >>>>> On 6/16/25 12:20 PM, Jonathan Cameron wrote:   =20
> > > >>>>>> On Fri, 13 Jun 2025 15:44:43 +0100
> > > >>>>>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>   =20
> > > wrote:   =20
> > > >>>>>>   =20
> > > >>>>>>> Although this change does not affect functionality at present=
, it is   =20
> > > >>>>>> Patch title says PCIe.  This check is vs PCI host bridge.
> > > >>>>>>
> > > >>>>>> No idea which one you wanted, but if it is PCIe needs to be
> > > >>>>>> TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
> > > >>>>>> I think.   =20
> > > >>>>> I think we need TYPE_PCI_HOST_BRIDGE as we want to check agains=
t   =20
> > > >> pxb   =20
> > > >>>>> pci-bridge/pci_expander_bridge.c:=C2=A0=C2=A0=C2=A0 .parent=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D   =20
> > > >>>> TYPE_PCI_HOST_BRIDGE,   =20
> > > >> sorry but I still fail to understand why we can't just check again=
st
> > > >>
> > > >> TYPE_PCI_HOST_BRIDGE for making sure the SMMU is attached to PXB or
> > > >> GPEX. What does it fail to check? Why shall we care about PCI vs P=
CIe?   =20
> > > > I think the concern is  getting any other TYPE_PCI_HOST_BRIDGE type=
s   =20
> > > attached   =20
> > > > to SMMUv3 other than pxb-pcie or GPEX. For example you could do,
> > > >
> > > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > -device arm-smmuv3,primary-bus=3Dcxl.1,id=3Dsmmuv3.1 \
> > > >
> > > > as pxb-cxl is of type TYPE_PCI_HOST_BRIDGE. I don't know if there a=
re any   =20
> > > other   =20
> > > > ones similar to this out there.
> > > >
> > > > So the aim is to make the checking more specific to PXB.   =20
> > >=20
> > > thank you for the clarification. Is it invalid to have the SMMU
> > > protecting RIDs comming from the pxb-cxl hierarchy?   =20
> >=20
> > That=E2=80=99s a good question. I don't know that for sure. =20
>=20
> It should be fine to support CXL for this but we can work that out later.
>=20
> For now limited use cases as there is no CXL VFIO support and the only th=
ing
> emulated devices do that the SMMU might influence is MSIX.
>=20
> The one that concerned me is pxb-pci if we only care about pcie.
> I'm not sure if we need to make that distinction or not. =20
>=20
Hmm. Shameer pointed out I hallucinated the existence of a PCI only expande=
r bridge.
So ignore that.

> Jonathan
>=20
> > Anyway currently the full support for CXL on virt is in progress here,
> > https://lore.kernel.org/qemu-devel/20250612134338.1871023-1-Jonathan.Ca=
meron@huawei.com/
> >=20
> > Jonathan?
> >=20
> > Thanks,
> > Shameer
> >  =20
> > >    =20
> >  =20
>=20


