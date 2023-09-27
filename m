Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2227AFBC4
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 09:16:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOkv-0000eB-If; Wed, 27 Sep 2023 03:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qlOkn-0000dF-Bj; Wed, 27 Sep 2023 03:14:37 -0400
Received: from mail-mw2nam04on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::62e]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qlOkl-00034Z-8u; Wed, 27 Sep 2023 03:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQxlF0IbCC4ngXXBOM9bZ5a86hBcD6iaLFPtM0TfCNK0zh/S0e40GO49OWHBbsiZHy5bQM0EmW72DxJGueRtbQFSCrpbqhJF1SBGKuGEj6hwdzAJ2TST+xepxEDr516UDO/NPRmaZWkPwA6rYttgKruU/njHlHV7LCAfK7ShGzJ4fBQs+MuTvTGOIC0WrWHgKITRGIyXcu+sP2+aRDs5wpC49D0DZbRUdjxhGPvfpUNj4FcVEdQQl1RxxVVQp5oQajJp9oWplBUj6vK4UMDN+OvfDbRJ302qgD00O2UgSrEaEp8x2kWPzdGSuREQ+MrnuSeuEdorZXJHDtMdxXPA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To6p7Ojm7rerKEWwO0yO8ra/+XtD6bl/ln3ECl2GhKU=;
 b=ilhXboVRky7GDOIP7kUcIEfqqeUUQmIByBX5mcC3pAPhTfoj9rxgR4F9T4imwb7AIWyDEhAON/v8LIpqd8AF5oVDun7NmUjBmVekwmKt9DGLvrr3Dcu+1DZEQW/ZN/OS1qgfETzhCubvyqPbzByRCBUjdv01trbGl3phLrLr7LlCMdKe92hJ1GSxeYMwVjacEnLz7jxULBLBYUh4P/75V89DnVQ/mLgkJ2Xi29FN72PdRgLL/SOQqUGBUlz9SaPQaAqJIwIKW+wm46wCJSMWNqzUi8HpKg6Fe4FcuvuJ1o7+QaN4uAAwGDbd4RWnellE/5vHbpJkwDjEPV9RLv13Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To6p7Ojm7rerKEWwO0yO8ra/+XtD6bl/ln3ECl2GhKU=;
 b=W8ZeVo+jJ3RMENN6FqfaJacbcQG0lCR4c7gIRlyfqPph1YIjDjPJ6gAYpDJdqQvm0IeSm1eLGIny540y7s6chGu0iEdqLLbRR9nqaYzXBc4ndHpioB1UUMjZgGfHLrNSQ05q/DSCuEEoWBiBnQB4sJEK4no+U/xBA2tNgg63X2WWbnfYnFSBq5FvhruHsJbTM0SGil1N/Vy2F/hO7EyYnJo7WytIiglzujw+V3utUwz0//r8OIYXXVSHsU8/YfXkMK7NkcZDDDz1zxTA5UhyQ105N7QaVpNRxr4g1SupBK3yF9gsyzXOTcOQ4AYfffUj2KqK7W8RhNo7onzbBQAppg==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 07:14:28 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 07:14:28 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand
 <david@redhat.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gavin Shan
 <gshan@redhat.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Topic: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Index: AQHZ537JxLWb7mRoJ0CHc31F6ORMKbAb8EmAgAAH8ACAAD9dgIAKT71wgAADi4CABrQ0B4AAJkeAgAAm/4CAAMdQGQ==
Date: Wed, 27 Sep 2023 07:14:28 +0000
Message-ID: <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
In-Reply-To: <20230926131427.1e441670.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SN7PR12MB8130:EE_
x-ms-office365-filtering-correlation-id: 31fd1b61-8a33-44a4-50ea-08dbbf296325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4JphrPFIbxDb7qoPSoY0wyCIYuwo0JZS4fmwHRL282un/dfKGgLGSZleaVmbkmyLPQ+BZODrKQVThRpmHSf58tAGV6803PJvFo2hKSzQE34ILeB7CcEuRASM+AixsDnYjW3RugDoMpTqa37n+l4ibdHRcYbKU869pbuhd8WlVOVeTNwHWRZknUrABfyDde4+pdxhBrNV0pvuXvAtWX0yhmtcmhN3OV3MBWLtQeU3D9Vl4ssdoCsqsxTJH57eZ50Ga9bVGRgBWd701zfGpte8tafTmPPnu6bnnOVUOIT3VSof59zgLUZPW86fPK+bEArzRX095Wb90Gmm1WocwydVKy8YNysV/bJfWiGSkDkabNWj5ciOHcd+zDLCCS87K3gnUM0xeGk7WwqZA5wWwGUSSqYUlP24fShguqOBSL9LG+gllQIv1l37xUsOFSiB1XI6BqpV5+/isOTDWf2aWyaqBwlu7PHaH7okgLzN9z50NRtGEb5xSUKOrcdKw0nyvahdrt3i2jKhRN6qCWcN0pWY5WwPOgWctgRtJ03LjlIL4vxtAMOgF/YCc5KZ9vgNqGOEKf+96rEyHJ4yK1P71zFGWgvxlNNdjxnwcj3F86YoZYJkiTG/YbmlxwQuTta1P2K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(33656002)(55016003)(86362001)(316002)(64756008)(54906003)(66446008)(66946007)(110136005)(66476007)(91956017)(76116006)(66556008)(478600001)(41300700001)(52536014)(5660300002)(8676002)(8936002)(4326008)(7696005)(122000001)(6506007)(2906002)(9686003)(38070700005)(38100700002)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IP9e65cy7c7XhaOQlIJanRDaVdz27HLanYyS14CXOBcVLwDeHAwDYS1Eaj?=
 =?iso-8859-1?Q?WpKkTyznFn06YoDuvEEvxy99Xlv91cAxIagxUJqIuZk66B96IWYOQgLnm8?=
 =?iso-8859-1?Q?+qm2mviwSMOGl9vjE14muGdfnireywbeHlXFZrHuH39xDYuev31R3cdgip?=
 =?iso-8859-1?Q?pHqqovGWqnNoJgVk4bLtp86AX+BpE+Yezk73seuhTNvdLrpDa5bP5CNe0O?=
 =?iso-8859-1?Q?qLoz+BPKpEm2Nn8gLlJqQscXZsPOgd7FEvu14LOlA1nG7TV9QXT8k+3/ac?=
 =?iso-8859-1?Q?q8UXLDrhPfjDyCdO398xOg4JwSiCgOIiWckRK2mrre5cbgwFYw1PLU9QrI?=
 =?iso-8859-1?Q?Xh61/C1b75yO4qhaKsAAtCwN3kIvtlUwJEuJEUHjmoHJTnb9uC91LToEL5?=
 =?iso-8859-1?Q?cNRa0NKHssCmNsyYX+ZT8w8G6EB0Y47rYJnl3VpvfDoLmUHawh22vAXEDD?=
 =?iso-8859-1?Q?vRBsdW1NtDC5Og8Ozp47sjfVVh3zhLkduzoHQxCXvoPAPV+TUFeZ5kiD5w?=
 =?iso-8859-1?Q?+09+Am1OW8IwrRQ2RIZlx5BIC985UayGWRmPBaem1SyCPTEjq7U+BKuRN3?=
 =?iso-8859-1?Q?LMuR+rVTAOdbUJuz2XiBl7vF+nrgAfVGDHmb0o0S5ORx0sg+xaoBoylE3j?=
 =?iso-8859-1?Q?d53HB5LeA/P3fl7Nf1B4fwC+VZH+0fAqhbfUmujZZPLyLLH4Qsz2Q0WTXN?=
 =?iso-8859-1?Q?HapIxUaC61Kl7v0gbWTuGbv6sPoeLslbwcwEgDKtVEHQmlcI2iZ2PFR04V?=
 =?iso-8859-1?Q?lDLLpZW9UohAcFw4srj95MzNx9tvrid3sAV1OSri4qiPNS5Y2dCVg7epQ2?=
 =?iso-8859-1?Q?WgMo0+LjdUyn+182jwp1aMrAFC3UDn/8VJlUIHRtuLQy0o8QB+mK7ST7TP?=
 =?iso-8859-1?Q?5uvx70kqkB+JNegPJsxHUuvC9mt8cISXzT0fman05aEy5SC39zq1BWcEji?=
 =?iso-8859-1?Q?tfSKyZQGEBxKmhZCRMgr/Ya82uGexuZAnNzsJ1+d8r9pNHwdp0aQd258S8?=
 =?iso-8859-1?Q?34G1FMR5WbALnsPC0rllbi/M65ApB9M+g0P2/dtD6YnElOicKdLvvvIHHx?=
 =?iso-8859-1?Q?dcgjKrf//s6tRctktCPxEhEpb2w7KppadxGa/YERtfwaguO1pn61hIoRGJ?=
 =?iso-8859-1?Q?FWDZtD4HI8mEM+7UvJa53K2DJksfvu+NhBsGZhArb3WPjBHnD+Tk2DLoDP?=
 =?iso-8859-1?Q?OGMoE70nRd7Wkt3veFXDB8EKQ0bv8dxsO17n2tJmGi726ZVSInXJBYBHZf?=
 =?iso-8859-1?Q?+PjeWYXk63utncmLAlAlABVpAWsLQPZQIQRRl5Bb92yfZ+svPX6HJvRugG?=
 =?iso-8859-1?Q?N3mq9VfCR6YaUUI+CF0AMGf0sxFrsHEOOM/yowbS3y2iUDX33Y77Mg8huK?=
 =?iso-8859-1?Q?faP/fidOVZzSVnKpxw5W65Rgm/7KEii7Zv9Q/zVnkteH03jYlgpHqYjh+X?=
 =?iso-8859-1?Q?uju2dXqj+eEQR+BqvZ9mD2JU1+8bopwMppHT5gTi2OuxVi9Yh0nJe3tVrM?=
 =?iso-8859-1?Q?CrVO5vNqTBjvm952zjpW7k1McbT6p5D07Jo0IzIMzOCrRc3VUPwnJT6u0/?=
 =?iso-8859-1?Q?d6vhtw4AlORgQrOpGegJ2qIHImfAwoBLxpnq7D+jnuJC9nnOok1ReNsraN?=
 =?iso-8859-1?Q?RMa24v8Nw00uU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fd1b61-8a33-44a4-50ea-08dbbf296325
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:14:28.0515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hOmMtlhdqaJCquMESyG3cO7vGsm+51BvVTteREuCd5S3lusjF///s/UelKs4d+iNQ4s5tzBVQp5BxyDZp6NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::62e;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

> >=0A=
> > Based on the suggestions here, can we consider something like the=0A=
> > following?=0A=
> > 1. Introduce a new -numa subparam 'devnode', which tells Qemu to mark=
=0A=
> > the node with MEM_AFFINITY_HOTPLUGGABLE in the SRAT's memory affinity=
=0A=
> > structure to make it hotpluggable.=0A=
>=0A=
> Is that "devnode=3Don" parameter required? Can't we simply expose any nod=
e=0A=
> that does *not* have any boot memory assigned as MEM_AFFINITY_HOTPLUGGABL=
E?=0A=
>=0A=
> Right now, with "ordinary", fixed-location memory devices=0A=
> (DIMM/NVDIMM/virtio-mem/virtio-pmem), we create an srat entry that=0A=
> covers the device memory region for these devices with=0A=
> MEM_AFFINITY_HOTPLUGGABLE. We use the highest NUMA node in the machine,=
=0A=
> which does not quite work IIRC. All applicable nodes that don't have=0A=
> boot memory would need MEM_AFFINITY_HOTPLUGGABLE for Linux to create them=
.=0A=
=0A=
Yeah, you're right that it isn't required. Exposing the node without any me=
mory as=0A=
MEM_AFFINITY_HOTPLUGGABLE seems like a better approach than using=0A=
"devnode=3Don".=0A=
=0A=
> In your example, which memory ranges would we use for these nodes in SRAT=
?=0A=
=0A=
We are setting the Base Address and the Size as 0 in the SRAT memory affini=
ty=0A=
structures. This is done through the following:=0A=
build_srat_memory(table_data, 0, 0, i,=0A=
                  MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);=0A=
=0A=
This results in the following logs in the VM from the Linux ACPI SRAT parsi=
ng code:=0A=
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 4 PXM 4 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 5 PXM 5 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 6 PXM 6 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 7 PXM 7 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 8 PXM 8 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 9 PXM 9 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
=0A=
I would re-iterate that we are just emulating the baremetal behavior here.=
=0A=
=0A=
=0A=
> I don't see how these numa-node args on a vfio-pci device have any=0A=
> general utility.=A0 They're only used to create a firmware table, so why=
=0A=
> don't we be explicit about it and define the firmware table as an=0A=
> object?=A0 For example:=0A=
>=0A=
>=A0=A0=A0 =A0=A0=A0 -numa node,nodeid=3D2 \=0A=
>=A0 =A0=A0=A0=A0=A0 -numa node,nodeid=3D3 \=0A=
> =A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D4 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D5 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D6 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D7 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D8 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D9 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=
=3Dpcie.0,addr=3D04.0,rombar=3D0,id=3Dnvgrace0 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 -object nvidia-gpu-mem-acpi,devid=3Dnvgrace0,nodeset=
=3D2-9 \=0A=
=0A=
Yeah, that is fine with me. If we agree with this approach, I can go=0A=
implement it.=0A=
=0A=
=0A=
> There are some suggestions in this thread that CXL could have similar=0A=
> requirements, but I haven't found any evidence that these=0A=
> dev-mem-pxm-{start,count} attributes in the _DSD are standardized in=0A=
> any way.=A0 If they are, maybe this would be a dev-mem-pxm-acpi object=0A=
> rather than an NVIDIA specific one.=0A=
=0A=
Maybe Jason, Jonathan can chime in on this?=0A=
=0A=
=0A=
> It seems like we could almost meet the requirement for this table via=0A=
> -acpitable, but I think we'd like to avoid the VM orchestration tool=0A=
> from creating, compiling, and passing ACPI data blobs into the VM.=0A=

