Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8AE7C5A52
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqd9C-0003p5-KL; Wed, 11 Oct 2023 13:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsethi@nvidia.com>)
 id 1qqd97-0003o2-26; Wed, 11 Oct 2023 13:37:21 -0400
Received: from mail-sn1nam02on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::61c]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsethi@nvidia.com>)
 id 1qqd93-0002CE-57; Wed, 11 Oct 2023 13:37:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwoJkcOYPShoomvSfaai6EldhrRROl9Fr9QADXJXnbxTX8zJg+Biv8xfkT0z/qOuaUIl0Djb+Z21SZG95WvTU1Vd05jstrUUNhGP0J8UaqjlX2MDWWPbCHd6IQj3XU738MjiHnpjBaL3nxhyMz1PpxZCdkdP9wO9e8UPfVwyQErdkSwee7DJaYZpHQ/K3L4Y1Rbg/OznC3oS+aedcm9k8ahB7SAQf4cNRBjuRH4bzMzLUEXFTJyShBosa7qOifL4CLA2PhLOVmxAyLu0Qz0XpPeJUXrgfzw3TehYaT+kf2U2B3QePWOjlCB+4xaokqLj0SK+9qs6OUHRCP4ySbfYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE4QbOlYWhCEJyC4TWXAgMq7fRJOEHoYVF7KSDtpUE0=;
 b=nj2vLH0bXXEN1UsIGO0iSesX/3bf93YLgZI4prSifEmrKxCfZBerELWHPS8qBsWHIieNzvXjlrC4No57HzKwjGnBP2Th6S9GzGa9JteWkL/xVS4Xzb5XWj7eUFR8mR/9nMb6+7iYX2+icG5M8iyoaHzNZ5ADf7WH46b/WxRrjCiVKutNEuWnAj6acF5sBplXxWTQK0gDjBHPze2CBpdOrWji5hNl4ToGmU66BkwNtNd8ZiMwhD2iqi1uwAsGYGOVxf16ZLOZ02oIaHUQXmz4OR3g4NzR5+ba3ovoxxh8ScLp8W8SGCyp+nyYGzwtSavVST439AqbpGGTh73eQ8QdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE4QbOlYWhCEJyC4TWXAgMq7fRJOEHoYVF7KSDtpUE0=;
 b=hM688eYanmon60G+7+mdnIFwU5mvk95wnzk1ifJcoAbw2/L2j35BwY7Gd+XmHWany4IChP2cTZFJZts5+DQFpfPZf2fQGhloIZ2e8TkzrkDzZtP7VIDcdmqJYpTE8ZOVK+pLsYOFdPC6Ta+W8FiW7OrzkrjnDMLJh8qtSmjE4Z/saGhXZOMWgl13aqz+Hpr2mfhGncCqFi7v7s+YlTJepbFjUdiIZ1WLe7GPxFjanDbf2BOPyg7H23dsGxH4Pex4RYdByg83JSfBX7l0oMvcwCF9G74CCVLnO3M6Gn7ie6UKwCnz9QCCqkyYxTnx/Xt39NUw2SRCEyy8GrN9TXcHug==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 17:37:11 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::4afa:20f0:2ab5:5a57]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::4afa:20f0:2ab5:5a57%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:37:11 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Ankit Agrawal
 <ankita@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Dave Jiang
 <dave.jiang@intel.com>, Shanker Donthineni <sdonthineni@nvidia.com>
Subject: RE: [PATCH v2 1/3] qom: new object to associate device to numa node
Thread-Topic: [PATCH v2 1/3] qom: new object to associate device to numa node
Thread-Index: AQHZ+VtsxVBzm9F89EefR6VCdr9CyrBBZQAAgAN20uA=
Date: Wed, 11 Oct 2023 17:37:11 +0000
Message-ID: <BYAPR12MB3336E4ABBB0CBD3C87222DA7BDCCA@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-2-ankita@nvidia.com>
 <20231009132642.00002c8d@Huawei.com>
In-Reply-To: <20231009132642.00002c8d@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|SA1PR12MB9002:EE_
x-ms-office365-filtering-correlation-id: 088c1899-36c1-4eda-5ba1-08dbca80b343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7Nz1vNf4nvuMCK6yIzxxXagfyBZTvNj5xeTcewV8HbgROa6woHOD1XXBQntsa/4rVBlon1Xdp+cL8nnDgKD4QzX/kPEbvzwyss3kN5mnN4rdD/hgWB4WyipxfXc5FPtkGQcLksz7L7f9UiuLrTaNfIjM9MNfbRZ/BfvmP/wagMkuo4tAunzKOvB1TFt+L+TzhdA1U+Xr4Fu9PH4c38zvzqUgfrGq5xCjgU4nj0gn56jy9qWgZhIqguc1yGbRdvRN9rplC5j6leG7oX8abqqRbYCb/xf9/wskBH+V+iAusVW3m6o/V1/WvL25uiuVz9k5shn+Svej9LorIiah0y5ss62nKllubZpz6zVbVYHWi0H5yA5E3kSLl5kDrFiX8tuIsUTZ73UwFVakzl14fU1TSpxFMuhauVXfTMn0KsBG5gyYmuoknt+2nnMoJ5PPcs0/6BgHOnVUQE4yOCk6mQX89TXUr4x0oA4P5wf47Sr4fDWVHPB4swAXY/qogjv3HMNqL5LUe2U0TTVWMaptL3w56Bc1s5KcvgbGH/O07TlYZ7MqtYIIBr9I07HvgXWmZVayW8Yzp34xmJpZVonJQ0whyjgXpgObe7zoVwVApNMsitFu+mshw8ZWUXdc30rYxdz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(55016003)(7416002)(38100700002)(38070700005)(26005)(9686003)(122000001)(107886003)(52536014)(45080400002)(4326008)(54906003)(66946007)(64756008)(66476007)(6636002)(8936002)(8676002)(41300700001)(76116006)(66446008)(53546011)(5660300002)(110136005)(71200400001)(6506007)(7696005)(33656002)(2906002)(478600001)(966005)(316002)(86362001)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rRCSoH7HFIyZOpVaAZJEmJZ9xZUgpXaaIvUOWnP0ZOBv6fGtoYfXmBNeGo+B?=
 =?us-ascii?Q?DJf6fO80BN7qnpxxl2w45hZIFXOBhJNzzqsdC4AXfCrrnzgbjS4zn9xsBnvk?=
 =?us-ascii?Q?NDqtoncljBf2gTppM42+T2kGN2WpsWlVR7ecbDYbi46Dbp0qiiT4g7UcLANV?=
 =?us-ascii?Q?B0WltvEtUp3gJYrJXUlWOH90epZEjUeZSyqx4HihjZpklw/nLW0Q0Uj863Z+?=
 =?us-ascii?Q?qqaFc+mIHIXswn/dd/oevzmFkuBrp+y9l5EkqfL1ClcYvL5VYVjkKqzoKY4V?=
 =?us-ascii?Q?powAZFDV1T1A9AuIMbLIRMmYCU8EMwlKzc/7OQTtOdTnYuVYLpjzhSato3bf?=
 =?us-ascii?Q?9irFgEmRStQ3IapSGC2VmSyHGT58jrjgpRwRG1WeWtjI5ZLO/FECOituq5o/?=
 =?us-ascii?Q?aN5YEyHGGDl8zvaE6xS0v8ysVEcTXsr3ebFr9/sZ8Rp7MUpqIEPZv25G6b51?=
 =?us-ascii?Q?/W1A9h76sOphYFT1lCgu3252ipFaMPRgZ5sE+um3MXu8Zr3sQYbref4W+NJo?=
 =?us-ascii?Q?Z9MnDicVHtN4pFxkH+4maRGFmsbOWQWHOl3V5k+oocXZt2ZykWN3ifbZN49S?=
 =?us-ascii?Q?JGIsr3F+sAqRdS+SZJiQZSz3cZSBW3lZNUgvMl9NDLE3/Cpzmnpbm2jDzYtH?=
 =?us-ascii?Q?oajWJjoqYL64wMsnYcT76AAp1iyEs8Yp72xGbwAdkgbwKwNgKhDnUaHor6X/?=
 =?us-ascii?Q?6oQva+G7Dwrg38tVc434kZ1fb4+3nMbSajx44T6LYX+GhGUahf1fE0D1w9Ok?=
 =?us-ascii?Q?dO+rEe13Ox0Qhge4Zkp4uzzfvFjmtokFmWaue4Y+R9ktLFzCpTpcNNn6N/78?=
 =?us-ascii?Q?eZUU1bS6XQbtKzHsndENJXLjHIxyGbJ7cgCwF1VC5F+kiR9KsraeGuuCKrfl?=
 =?us-ascii?Q?tHRRSdKxGb9g8J7I1wxgubHDOK8DfSVgi8+Jfbg+cYdhGqXdrGsMTeGElvd0?=
 =?us-ascii?Q?Yt8hcTPH12pEkpaGVtZxdMkXl4ve4SpUntXSie2WJU7TBZBQr96KgZmAckO5?=
 =?us-ascii?Q?GiB8KlUIG2IW1bDsNALN5X8eGHToQ4pgfHgMpuq6iyQuwr7r+8FNjVWzx+UT?=
 =?us-ascii?Q?WNSeXB1XyN5eR7O3I0X4q3MdnIE5Xhvy+FWgsd0lXI99FIdsr/JPwGl41ANd?=
 =?us-ascii?Q?q6XpBur83p0/z2ffkamaMGKwWXV0rddE0dNkSHqtniIHa/HHj4t1/ztNX1+7?=
 =?us-ascii?Q?dkLRQvdALYpHqKo3F/MCx7bx8X/a9PgoFrJ/bKMesFzI0yZYQcTpor/IZ2SN?=
 =?us-ascii?Q?vhaCSKzze0M/wGIQCtJfiriHg/iauSOx4PmdwGdiI8D/3xz1k8Nn6JzxWCU9?=
 =?us-ascii?Q?LLXeYz3lEkCKBOeUB/h3kMWKmy/dQbVrM9wew8NM0+muBQrLJ8g/JkSVwfxU?=
 =?us-ascii?Q?ENZpUZmeq/g2Iwq145vEiDzLGKr/hKSX2J2qumC9D4v7p5KVNJ30Kqwh+0V8?=
 =?us-ascii?Q?wn0OSgSGgZH40XXGpzL1t+YOBEvSEClJyNZryZErwK3tMezr9QAXZ96K14zJ?=
 =?us-ascii?Q?G/aHyINqjg7lGAAoujsRk+ogJf0cSz3nzNL6lo5Jxv9yZYxW6T+RI8UHFRuc?=
 =?us-ascii?Q?HOXPP7q+S6BxKXL3Md8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088c1899-36c1-4eda-5ba1-08dbca80b343
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 17:37:11.4788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: br3nBIr/OVpvfdF0PUhPoytxBpRAA/byKBuWPbsEi1jS/K3iTIBOzr4iEIspHEjAYTaATfE5Yspu8t4Y6OBswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::61c;
 envelope-from=vsethi@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, October 9, 2023 7:27 AM
> To: Ankit Agrawal <ankita@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; alex.williamson@redhat.com;
> clg@redhat.com; shannon.zhaosl@gmail.com; peter.maydell@linaro.org;
> ani@anisinha.ca; berrange@redhat.com; eduardo@habkost.net;
> imammedo@redhat.com; mst@redhat.com; eblake@redhat.com;
> armbru@redhat.com; david@redhat.com; gshan@redhat.com; Aniket
> Agashe <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> Vikram Sethi <vsethi@nvidia.com>; Andy Currid <acurrid@nvidia.com>;
> Dheeraj Nigam <dnigam@nvidia.com>; Uday Dhoke <udhoke@nvidia.com>;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Dave Jiang
> <dave.jiang@intel.com>
> Subject: Re: [PATCH v2 1/3] qom: new object to associate device to numa
> node
>=20
>=20
> On Sun, 8 Oct 2023 01:47:38 +0530
> <ankita@nvidia.com> wrote:
>=20
> > From: Ankit Agrawal <ankita@nvidia.com>
> >
> > The CPU cache coherent device memory can be added as NUMA nodes
> > distinct from the system memory nodes. These nodes are associated with
> > the device and Qemu needs a way to maintain this link.
>=20
> Hi Ankit,
>=20
> I'm not sure I'm convinced of the approach to creating nodes for memory
> usage (or whether that works in Linux on all NUMA ACPI archs), but I am
> keen to see Generic Initiator support in QEMU. I'd also like to see it do=
ne in a
> way that naturally extends to Generic Ports which are very similar (but d=
on't
> hang memory off them! :) Dave Jiang posted a PoC a while back for generic
> ports.
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fqemu-
> devel%2F168185633821.899932.322047053764766056.stgit%40djiang5-
> mobl3%2F&data=3D05%7C01%7Cvsethi%40nvidia.com%7C846b19f87bc5424d
> c33608dbc8c3015d%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7
> C638324512146712954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&sdata=3Dv318MXognoITHyv7AFqZAfvUi2hLy2ZUVnLvyQ2IAfY%3D&res
> erved=3D0
>=20
> My concern with this approach is that it is using a side effect of a Linu=
x
> implementation detail that the infra structure to bring up coherent memor=
y
> is all present even for a GI only node (if it is which I can't recall) I'=
m also fairly
> sure we never tidied up the detail of going from the GI to the device in =
Linux
> (because it's harder than a _PXM entry for the device).  It requires stas=
hing a
> better description than the BDF before potentially doing reenumeration so
> that we can rebuild the association after that is done.
>=20

I'm not sure I understood the concern. Are you suggesting that the ACPI spe=
cification
somehow prohibits memory associated with a GI node in the same PXM? i.e whe=
ther the GI is memory-less
or with memory isn't mandated by the spec IIRC. Certainly seems perfectly n=
ormal
for an accelerator with memory to have a GI with memory and that memory be =
able to be associated with the same PXM.=20
So what about this patch is using a Linux implementation detail? Even if Li=
nux wasn't currently supporting
that use case, it is something that would have been reasonable to add IMO. =
What am I missing?

> >
> > Introduce a new acpi-generic-initiator object to allow host admin
> > provide the device and the corresponding NUMA node. Qemu maintain
> this
> > association and use this object to build the requisite GI Affinity
> > Structure.
> >
> > The admin provides the id of the device and the NUMA node id such as
> > in the following example.
> > -device
> > vfio-pci-nohotplug,host=3D<bdf>,bus=3Dpcie.0,addr=3D04.0,rombar=3D0,id=
=3Ddev0 \
> > -object acpi-generic-initiator,id=3Dgi0,device=3Ddev0,node=3D2 \
>=20
> This seems more different to existing numa configuration than necessary.
> The corner you have here of multiple GIs per PCI device is I hope the cor=
ner
> case so I'd like to see something that is really simple for single device=
, single
> node.  Note that, whilst we don't do CXL 1.1 etc in QEMU yet, all CXL
> accelerators before CXL 2.0 are pretty much expected to present a GI SRAT
> entry + SRAT memory entry if appropriate.
> For CXL 2.0 and later everything can be left to be discovered by the OS b=
ut
> those Generic Ports I mentioned are an important part of that.
>=20
> Why not something like
> -numa node,gi=3Ddev0 \
> -numa node,gi=3Ddev0 \
> etc or maybe even the slightly weird
> -numa node,gi=3Ddev0,gi=3Ddev0,gi=3Ddev0...
>=20
> ?
>=20
> >
> > Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> > ---
> >  hw/acpi/acpi-generic-initiator.c         | 74 ++++++++++++++++++++++++
> >  hw/acpi/meson.build                      |  1 +
> >  include/hw/acpi/acpi-generic-initiator.h | 30 ++++++++++
> >  qapi/qom.json                            | 20 ++++++-
> >  4 files changed, 123 insertions(+), 2 deletions(-)  create mode
> > 100644 hw/acpi/acpi-generic-initiator.c  create mode 100644
> > include/hw/acpi/acpi-generic-initiator.h
> >
> > diff --git a/hw/acpi/acpi-generic-initiator.c
> > b/hw/acpi/acpi-generic-initiator.c
> > new file mode 100644
> > index 0000000000..6406736090
> > --- /dev/null
> > +++ b/hw/acpi/acpi-generic-initiator.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights
> > +reserved  */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "qom/object_interfaces.h"
> > +#include "qom/object.h"
> > +#include "hw/qdev-core.h"
> > +#include "hw/vfio/vfio-common.h"
> > +#include "hw/vfio/pci.h"
> > +#include "hw/pci/pci_device.h"
> > +#include "sysemu/numa.h"
> > +#include "hw/acpi/acpi-generic-initiator.h"
> > +
> > +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator,
> acpi_generic_initiator,
> > +                   ACPI_GENERIC_INITIATOR, OBJECT,
> > +                   { TYPE_USER_CREATABLE },
> > +                   { NULL })
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator,
> > +ACPI_GENERIC_INITIATOR)
> > +
> > +static void acpi_generic_initiator_init(Object *obj) {
> > +    AcpiGenericInitiator *gi =3D ACPI_GENERIC_INITIATOR(obj);
> > +    gi->device =3D NULL;
> > +    gi->node =3D MAX_NODES;
> > +    gi->node_count =3D 1;
> > +}
> > +
> > +static void acpi_generic_initiator_finalize(Object *obj) {
> > +    AcpiGenericInitiator *gi =3D ACPI_GENERIC_INITIATOR(obj);
> > +
> > +    g_free(gi->device);
> > +}
> > +
> > +static void acpi_generic_initiator_set_device(Object *obj, const char
> *value,
> > +                                              Error **errp) {
> > +    AcpiGenericInitiator *gi =3D ACPI_GENERIC_INITIATOR(obj);
> > +
> > +    gi->device =3D g_strdup(value);
> > +}
> > +
> > +static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
> > +                                            const char *name, void *op=
aque,
> > +                                            Error **errp) {
> > +    AcpiGenericInitiator *gi =3D ACPI_GENERIC_INITIATOR(obj);
> > +    uint32_t value;
> > +
> > +    if (!visit_type_uint32(v, name, &value, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (value >=3D MAX_NODES) {
> > +        return;
> > +    }
> > +
> > +    gi->node =3D value;
> > +}
> > +
> > +static void acpi_generic_initiator_class_init(ObjectClass *oc, void
> > +*data) {
> > +    object_class_property_add_str(oc,
> ACPI_GENERIC_INITIATOR_DEVICE_PROP, NULL,
> > +                                  acpi_generic_initiator_set_device);
> > +    object_class_property_add(oc,
> ACPI_GENERIC_INITIATOR_NODE_PROP, "uint32",
> > +                              NULL, acpi_generic_initiator_set_node, N=
ULL,
> > +                              NULL);
> > +}
> > diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build index
> > fc1b952379..22252836ed 100644
> > --- a/hw/acpi/meson.build
> > +++ b/hw/acpi/meson.build
> > @@ -5,6 +5,7 @@ acpi_ss.add(files(
> >    'bios-linker-loader.c',
> >    'core.c',
> >    'utils.c',
> > +  'acpi-generic-initiator.c',
> >  ))
> >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c',
> > 'cpu_hotplug.c'))
> >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false:
> > files('acpi-cpu-hotplug-stub.c')) diff --git
> > a/include/hw/acpi/acpi-generic-initiator.h
> > b/include/hw/acpi/acpi-generic-initiator.h
> > new file mode 100644
> > index 0000000000..e67e6e23b1
> > --- /dev/null
> > +++ b/include/hw/acpi/acpi-generic-initiator.h
> > @@ -0,0 +1,30 @@
> > +#ifndef ACPI_GENERIC_INITIATOR_H
> > +#define ACPI_GENERIC_INITIATOR_H
> > +
> > +#include "hw/mem/pc-dimm.h"
> > +#include "hw/acpi/bios-linker-loader.h"
> > +#include "qemu/uuid.h"
> > +#include "hw/acpi/aml-build.h"
> > +#include "qom/object.h"
> > +#include "qom/object_interfaces.h"
> > +
> > +#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> > +
> > +#define ACPI_GENERIC_INITIATOR_DEVICE_PROP "device"
> > +#define ACPI_GENERIC_INITIATOR_NODE_PROP "node"
> > +
> > +typedef struct AcpiGenericInitiator {
> > +    /* private */
> > +    Object parent;
> > +
> > +    /* public */
> > +    char *device;
> > +    uint32_t node;
> > +    uint32_t node_count;
> > +} AcpiGenericInitiator;
> > +
> > +typedef struct AcpiGenericInitiatorClass {
> > +        ObjectClass parent_class;
> > +} AcpiGenericInitiatorClass;
> > +
> > +#endif
> > diff --git a/qapi/qom.json b/qapi/qom.json index
> > fa3e88c8e6..86c87a161c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -779,6 +779,20 @@
> >  { 'struct': 'VfioUserServerProperties',
> >    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
> >
> > +##
> > +# @AcpiGenericInitiatorProperties:
> > +#
> > +# Properties for acpi-generic-initiator objects.
> > +#
> > +# @device: the ID of the device to be associated with the node # #
> > +@node: the ID of the numa node # # Since: 8.0 ## { 'struct':
> > +'AcpiGenericInitiatorProperties',
> > +  'data': { 'device': 'str', 'node': 'uint32' } }
> > +
> >  ##
> >  # @RngProperties:
> >  #
> > @@ -947,7 +961,8 @@
> >      'tls-creds-x509',
> >      'tls-cipher-suites',
> >      { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
> > -    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
> > +    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },
> > +    'acpi-generic-initiator'
> >    ] }
> >
> >  ##
> > @@ -1014,7 +1029,8 @@
> >        'tls-creds-x509':             'TlsCredsX509Properties',
> >        'tls-cipher-suites':          'TlsCredsProperties',
> >        'x-remote-object':            'RemoteObjectProperties',
> > -      'x-vfio-user-server':         'VfioUserServerProperties'
> > +      'x-vfio-user-server':         'VfioUserServerProperties',
> > +      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties'
> >    } }
> >
> >  ##


