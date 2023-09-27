Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2C7AFBAF
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 09:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOdY-0006v3-BZ; Wed, 27 Sep 2023 03:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qlOdV-0006te-Q6; Wed, 27 Sep 2023 03:07:05 -0400
Received: from mail-sn1nam02on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::61b]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qlOdT-0001IA-7G; Wed, 27 Sep 2023 03:07:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1A3MfL/f7+cDiqZj0mafohbvwndiHPvA1wvfbpqqIm2HxPSZ1TMeIicDJ0IRyzD7JJLFcfJH+3pqqFc+/NMRFDERpHvmpUoIxgNEdOq0Hwza90GuQMLn4lqQEu0neGVcSyNsqrBlI3gtrNM9yZXq0ktSblKTCHobQDQIQAHhye6hC64tTZJkW7Fca+O38j9WTnB2IurZ2fZytZafxkWaAUFSZjvKY2WhMceIF0I/5kGFRQEUc8/ZdliWC2tctEk36JROzJEN9AI4aq3oINe3sRS30FGNSqoiCMlJgobo5YSo8bk7JfDmJ3t2se88TUzVpe9o+fStw6gDPS0Q7dtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKxUNcFigmS+wiBjXNgW4H0V9yUvI043TNTwQW0Ni4Y=;
 b=TvrAxyMdSUkv133upfihBC/YQUM/807QQ5f+WXjDeoa3DhufVQrFWmAhYa6PeW173V/raJ2jtT8VyXfxynIhNVRYZi/xPaAMRt+xO9ZQH1/ALQHMJUkWvCASanRwuNyjLmAGYMiXYcOfdc92HVjX7p35jyxYRwq3TfdmSOfcBAHGSv/nzGCMwoAuJdAEzIs//Kw9PLZNeQmyRfoHn1Nvnge5SWLoISmgkfhGe18Kq6D0HmeRPEftK2LlP/Eq23yg3s7n+GJNox1ZjlIyo7ytHXtIzwTXw6/BLbv2dhhE5vhU2MLCOoEWjMSnX/tdEHZh4c8jkXUVM1AqjV6Kx5bV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKxUNcFigmS+wiBjXNgW4H0V9yUvI043TNTwQW0Ni4Y=;
 b=Ip3kY49auYJcXWN3/FlYOaGVncPbBau4ufUj0xZ7SG+pdvUN44gPv0j1a6jBLHTUkhDcSFLtXXzBO2ow8BCGNnU86IccUZKpItcAKQf7hg8eQQGXf2VApLj6wWrtObuAp/Ox/KzMbyd7jtLp0xNgvZXikLz1BeOSr4As5eug3CSKHbpxCJxhZJiaq5xIAfFTEWUSXItQvodolqAWj51NAhxWND80OvKAFPmRREnU+5AiHIPTICogF/sl0NbUtz2Xh5AiNTgAcgsZ+lYXgHx08IfKekXvyRb4RD8V/oVOYEykh+Uu3JRCI9Hh1pJ2y8jGjLSqifqMkma38T7XE4eVXw==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:06:57 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 07:06:56 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Topic: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Index: AQHZ537HoMkIAkADME+0ZStkB7Hp17Ab9V0AgApsEECABT89AIAAAnUAgAAOFICAABKvgIAAEL0AgAFlFROAARgzoA==
Date: Wed, 27 Sep 2023 07:06:56 +0000
Message-ID: <BY5PR12MB3763714BAA5397EEA7B8D30BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>	<20230925140328.GF13733@nvidia.com>
 <20230925155351.00000638@Huawei.com>	<20230925160043.GH13733@nvidia.com>
 <20230925180038.00003879@Huawei.com>
 <BY5PR12MB37637E2A77DC8A9AB064ABCEB0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB37637E2A77DC8A9AB064ABCEB0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SN7PR12MB7449:EE_
x-ms-office365-filtering-correlation-id: 6bd3a416-80b0-434e-ea8f-08dbbf285618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fGPzn7Fnps3WaYGsmKiksskxPUv9Lq66ptVoEbYoOYLCwhl3NfSQRgjlVn7RRy5/gK3e0KgIAIh3HKxJInQdp7iGlo4R+ZiLzsOHsVTdAM9EEPId3pQ2G0bf/8v5TuZL6q21M3IVUpzCW+qWdzo4u5xwAm0lgPN9hmjfjtHVs4kiugeR7vYWqXNJUl4OuQCPFY2rGh9ir2sajpAC0Qp4QGWSrMafQRc6OfUPuYSrcgKUcIoIcDPxN/QnjBfpVo2/JvP9cvs75ZIH4KqEe7GU4WrNe4vaA59lj5Dqv6DOMIvIDkHKtVJnDGMNM5xM/hPL5ugQryb3vyEXHCnCbBPBgJI7DTWax0nEeC9HHZv8oq2MkS/n3c9TwXUI6/uSB3oQrKtqFXrkmFDNHS8IgR1h4hpdmoO6XY0QOBWFOJweQqhqjmY0/nve9Xe/x8C3xCMggnMpFIvF8WK5yvFgjzcn+gaUw1HY5WlMuBV8iHMr5HgDjXPeqb9+equhXOZo5RX16Rqw64EFc5ptysve9V1sQ2wnB/6nycZjoIsHRXFiRrjxo/uAG9yvs/Efx6mesyzZmPPc9JoA2KlmQmvGzNQFY5Orkn3hu8YTs6wtWL/+UJV73P9HzUF/ZBQuhcdLRQrh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(6636002)(9686003)(66946007)(66476007)(316002)(54906003)(64756008)(66556008)(66446008)(110136005)(2906002)(91956017)(76116006)(41300700001)(52536014)(4326008)(8936002)(8676002)(71200400001)(478600001)(5660300002)(33656002)(38070700005)(122000001)(38100700002)(55016003)(7696005)(6506007)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?leFkxsYg+QBBSZYEdKxP/TImOHQZJNczLORpsFsR3sLB5CNGuFPrflGXyF?=
 =?iso-8859-1?Q?xhX5zvhk4o6nWjhSq1jc4QngNcPvLGUJ+W5feLh8MCVdicy/OzTgrPLtCT?=
 =?iso-8859-1?Q?1+FqEUGaF1Jw/uwrmbQQ3emLAb4GOlEsdL0H5mj2l47izcer9vY9HDsMo2?=
 =?iso-8859-1?Q?PHsfKMpVG/1BuYBRQOSfrLFycP0GnJaVPfffScy7lYoRsxMaV/my+Ri8EY?=
 =?iso-8859-1?Q?1GyInGtIEYeX1UDStch6WTchGx0CIMEWcMAimtom6gdvxiTzwZtuwThkgd?=
 =?iso-8859-1?Q?k4svCKbWlloTw4QX6yRlP1QegwfBIxkfC4Z/ipaaLpBISP0SsZBSmkGFvi?=
 =?iso-8859-1?Q?apdfOAZXBTwb9qZX2hnkC6htadxZq6R65irCc+T2Bry40W3q5JOl0PCHdp?=
 =?iso-8859-1?Q?MccPL6NLg7uYbKmIENUX863a+aZhtGzGxqeBxdUBxjhpeipSQVjUU5W8EL?=
 =?iso-8859-1?Q?NQZ43uc4AbksUSpcM939Z504zrqFiHtNjifKudo1nB7G4mg0xPoI8/aJx4?=
 =?iso-8859-1?Q?PoAztU4N6Ce0RqHLpxbwSGQAPibLBrrfXIUmgv2aX2SLq9jaRV4s+gCxSw?=
 =?iso-8859-1?Q?n04OMIpYgUG+/eqvJYIXVh4kjX42Bxd5vt+Bq+u7TMHQcxkRSCpar7/Le+?=
 =?iso-8859-1?Q?79rdVJXDnD3s+u4HgE9DOh5evqPE+3g6i61qpTJwjbyt2LICDBrKrGVzZ9?=
 =?iso-8859-1?Q?rMrlvNagP3Bfo551H7Iu1J68hOU45q/LZGvDDyVyNcu/GxwCwInAiSuMX9?=
 =?iso-8859-1?Q?dYS4fv2DMT+vGMiiXEme/dJDTcsvB7ZlcHeuSug1AG9+78jJ8z3CuffeG6?=
 =?iso-8859-1?Q?2GSMVK+QpUjJq4l1MUlqQaXYtJcyh6WroBwz/ugOl3xHX2xmCs4S7e8MUb?=
 =?iso-8859-1?Q?Qoc50vHQPy54dvUkZzGaUprhPx/hcl+NDsQWOGxW8HhbtIQ/fPSw/2Caw8?=
 =?iso-8859-1?Q?W/oyZzqoQ2fBXzOjSjCrD9iEMcBMgADdrg/7xv12X9IJXSU3w0sJgrfEmj?=
 =?iso-8859-1?Q?frzEXfme78d6UnAlFhG98jWsUm1C/eF7UmR00ABnZ1pvsg/9/3k62Hbe+w?=
 =?iso-8859-1?Q?jX1E4N15RzdcVFM7Cz6bZIpCjUf5lnr5ahxBXLZGEDoLlxXfKQ9MKJeWkK?=
 =?iso-8859-1?Q?hpaoOMU4KNL8llKDoU4M9Uxpv+kB9kydSQi36TgDJpfDeyUxNs4ncMf14b?=
 =?iso-8859-1?Q?qgkloKhxKVlvSzvCRoAc9q7Jh2R9esD/bseAkA6tkeZ4RNtgBs1mqt8VOv?=
 =?iso-8859-1?Q?ILbsHXAWQ1zPXFHdB0cCvxP94rXgQ4DyGCDQCyrzN5Oq83R6VTTwwU7M5f?=
 =?iso-8859-1?Q?5oFXwrHUmy8+RJNi954gQe2Jd+7swy0bueOeWcIII78P+NGwh4MS8hBi8O?=
 =?iso-8859-1?Q?xztubF+YGwB134+NZ1qUam6/rg3X7T/jE0RmNzqVb5PIFE4HVzq98vXoos?=
 =?iso-8859-1?Q?ln5BFRXgcRwy3WWqO/ssX8P0JIwW2aIiJUaYXx3UpQVta9JzQaMiNyJgxl?=
 =?iso-8859-1?Q?uF94FyKiQeHxIJpsRN1g9Hhzzg8WQLG4Gzq5oSYanajzSXZDU/YsQmh8WY?=
 =?iso-8859-1?Q?0L2wdsN3EozGqlTrX7BdWh9jQJCXDKSVO3Z2N3E8y/lhOBfLFrMmuL8Tk5?=
 =?iso-8859-1?Q?IgIWT0SHDrDAY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd3a416-80b0-434e-ea8f-08dbbf285618
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:06:56.6521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhnsqK/GnqMR1DK+R9oafyuFbFiJhA4QsJm/6AaeZSaH0CmUKz35rlGs1wAtmDHlgHJi4jTAM3q0qqzdFyLWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::61b;
 envelope-from=ankita@nvidia.com;
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

>> Ok. I'd failed to register that the bare metal code was doing this thoug=
h=0A=
>> with hindsight I guess that is obvious. Though without more info or=0A=
>> a bare metal example being given its also possible the BIOS was doing=0A=
>> enumeration etc (like CXL does for all < 2.0 devices) and hence was=0A=
>> building SRAT with the necessary memory ranges in place - even if the=0A=
>> driver then does the hot add dance later.=0A=
>=0A=
> Ankit, maybe you can share some relavent ACPI dumps from the physical=0A=
> hardware and explain how this compares?=0A=
=0A=
Yeah, we are pretty much emulating the baremetal behavior here (I should ha=
ve=0A=
been clearer). The PXM domains 8-15 are the "device associated" NUMA nodes=
=0A=
on the host. Here are the kernel logs from the baremetal system related to =
these=0A=
NUMA nodes.=0A=
=0A=
[    0.000000] ACPI: SRAT: Node 1 PXM 8 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 2 PXM 9 [mem 0x00000000-0xffffffffffffffff]=
 hotplug=0A=
[    0.000000] ACPI: SRAT: Node 3 PXM 10 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
[    0.000000] ACPI: SRAT: Node 4 PXM 11 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
[    0.000000] ACPI: SRAT: Node 5 PXM 12 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
[    0.000000] ACPI: SRAT: Node 6 PXM 13 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
[    0.000000] ACPI: SRAT: Node 7 PXM 14 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
[    0.000000] ACPI: SRAT: Node 8 PXM 15 [mem 0x00000000-0xffffffffffffffff=
] hotplug=0A=
=0A=
...=0A=
=0A=
[    0.000000] Initmem setup node 2 as memoryless=0A=
[    0.000000] Initmem setup node 3 as memoryless=0A=
[    0.000000] Initmem setup node 4 as memoryless=0A=
[    0.000000] Initmem setup node 5 as memoryless=0A=
[    0.000000] Initmem setup node 6 as memoryless=0A=
[    0.000000] Initmem setup node 7 as memoryless=0A=
[    0.000000] Initmem setup node 8 as memoryless=0A=
[    0.000000] Initmem setup node 9 as memoryless=0A=
=0A=
=0A=
=0A=
On the VM, it looks like the following with the PXM 2-9 associated with the=
 device.=0A=
=0A=
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

