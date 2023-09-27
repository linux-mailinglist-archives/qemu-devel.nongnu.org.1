Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B717B0840
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWSZ-0000t8-0E; Wed, 27 Sep 2023 11:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsethi@nvidia.com>)
 id 1qlW4R-0007es-4P; Wed, 27 Sep 2023 11:03:23 -0400
Received: from mail-bn8nam04on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::62a]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsethi@nvidia.com>)
 id 1qlW4O-0000fJ-2H; Wed, 27 Sep 2023 11:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKlQQv4rXm66qbGwtgBdXbRV91ndke2MuGir8KezLxTC1wHasQZ68b3R64N2S2Woa/+kRV1nUxb6B9uuv86dprILTPICmJzzxO7EOu9nELkfQhopSnsUmRyT4e5RfJM5v58/P8lBo563xytW7U1/6VCCeFUZFKeREeUcjvNZ6E5t4WhNXmTTLB8YiBAjcY81YnG1FDMWFJkKNmT2JGgcWulDvh1JQ4KcpUWHbwWresJZJp9/pnDyIVYZ+Ps2CV3Dr0WEBMyOBM5Y5NKK3HmAd72v6KfBe2lPl7t2P4MTn9EaEgeR1exCdMK6yv3qt8b6wtG5L/SJmDDuWawTqvFg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyvkkIpQhfX7BlNe722dLZREKlb+ey/JRTlqBQVlkgE=;
 b=kdbA1xO4/pgj9ipPMekWJ7l/R0eZap+xRr3PJ0X65yjRi4NOfI3cMarCd32ElMshJ0HlsqeSSK429LhrNEPufy2N0EqsdzmMNoC+h13ZWwDHxAL0ikFMjFrHQfFtzsP++FeyFanCUD+uJiImcPai4lH0vHt5iYZO8GDeK+pmpLbWyCLVSzFZqPTiuWINwt6lH7YP2PQ0yEv7WiFu+IBkSm3g/fUjgqnMtfWFy8aDJwaX8yhZJk29yWkCQHfaGZHEky4JX2ONS5fAolPDsUP0Ax0oKSNJzgCj4Uo8ZA37QPSEbkzFFWvDeoPW7+2P6688yGE4MJQ6VLwo3WxODkOcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyvkkIpQhfX7BlNe722dLZREKlb+ey/JRTlqBQVlkgE=;
 b=gVT346mgQEImqzPaR/lBVaSkNqojDy7jNIYN61L1fF11DChGXp61UPkPoNffemdAo3VXgQ33TkfUHlfcjD/veBZDzFLurItJXGL/MQaFok7sWPO6kdeBUv2UQm+4OuTsrwA264BA5mAV9huXiAlF/d0CzPoFRqH3DC/lfOhm3eGGTf227hUU4COJ5Y61h3p09K1rJHH1dvARXtX0Nif9qFNNPnGNIKxAHZuqyq5ut61T0VkAB7ufAvERr5ExjoGuKfcnZDE+PeJ/CwlEnd5mjvwW+pcPYGLWyh/gsceaCh/yXj85wvRXmkzvBcu3xmtRGeuyNQadBaq/WU8V9HOdfQ==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:03:09 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::bac2:edf4:1c0e:4819]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::bac2:edf4:1c0e:4819%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:03:09 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ankit Agrawal
 <ankita@nvidia.com>, David Hildenbrand <david@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: RE: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Topic: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Index: AQHZ537JsWCPPA/p5kyKc8HTp7OxAbAb8EmAgAAH8ACAAD9dgIAKUiEAgAABJ4CABrhDgIAAIjiAgAAm/4CAAMkrAIAASFEAgAAnMwCAAAinAIAACNmQ
Date: Wed, 27 Sep 2023 15:03:09 +0000
Message-ID: <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>	<20230927135336.GA339126@nvidia.com>
 <20230927082434.3583361c.alex.williamson@redhat.com>
In-Reply-To: <20230927082434.3583361c.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|IA0PR12MB8748:EE_
x-ms-office365-filtering-correlation-id: caa4f541-ffbf-4519-8d6a-08dbbf6adca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYhRQ+XhDLOGolZOYKkSM1X8fvfuspjJ1IK66AsskgUTiJyB9cRw+2VTQllYYg5J6nFWfOv3pr6FBapQO/r2F3nnYgrPWkWzdC/4ceADMGGghmzE0iVa1nR7s7+fNdFgTRLjWAHRdulw4HMHyuS85t8VFjyNwIa3xZJ6LUeDkgUrKF3cONpxrxxafnEw4oJIdKGIUuIsowwRIfAKgAuZdeLqcPtG8Q/ZjMEHu2ZqjvjxLHopmcUHJ9p1IzuvKYM9SIPh49zMeURLdxH1URH7bwMOlBeKb8glFVE6IKKH7Dy1hM6wURlP64qRYnv9z3RExLL8HTlrB9HAc2RJSv7DaWodS7wV+a6lHxfQrYFzXksoeVRQvW4UWZ/h8JEgHG9s6Lj2IIbY3Mu4bwSot08I6bYa4RUip8SU6T9jomVKbUYwWuCpzqiw/pmfU7OWyc0W5aZbc223/mXTYzX1HjdwLq3Otve+GTpGWM/ERDhsUa4YM1z411tYryM81q22Szl+Ijf26tas+9Il/stPIdGHbuwhrIbJNw+vt0jBSYehlyZ7EzUuPKtWrpKI12YobCHjHEkYNgqbbH/QUmaDQYuhW2+K3mae64zvaoN5LWLgRGHotSBJePZC8H3/NPMmZHT7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(9686003)(71200400001)(53546011)(26005)(478600001)(66946007)(7696005)(110136005)(66556008)(86362001)(6506007)(64756008)(66574015)(122000001)(38100700002)(38070700005)(41300700001)(2906002)(33656002)(55016003)(83380400001)(4326008)(7416002)(76116006)(66476007)(66446008)(5660300002)(54906003)(6636002)(316002)(8936002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gtwFkGlDqcpxuZtmsd6gh7SL9tWSNrmrnxJt0GTQr1JRzEOv+bygfcjERU?=
 =?iso-8859-1?Q?9oEQMCVN2oORhGiKr8BlqlNjoT2576AaiU7fzEJZFNGIVOIPYp0fr/GWJO?=
 =?iso-8859-1?Q?dwqBZfCyMpoJ63X1soN2Srp1iYdp+Mh58RR2V/qA3oQ4oEi3D6nqkOzEL6?=
 =?iso-8859-1?Q?h+bMn/yXJSC6OnEU9tz+lWVbEQIC/yb9dp9wOmsXB277gI+VWcW8uK98HB?=
 =?iso-8859-1?Q?yZpJsLHgVZ9/oFXckzbpdlLABxYKblXQ4C9tTvmJ2e8l4NhWobcdu8+khe?=
 =?iso-8859-1?Q?GywRuM6EqeDoKQx+nJnG4SZMu7c2CChC5i4Os45uut3nwXtWADWhDjA8fW?=
 =?iso-8859-1?Q?MOOLLnVzHGFN83jPHIOr8l4OWcUeFItPlvWapXDZfb+zOIePUiMFjqoggy?=
 =?iso-8859-1?Q?e4o0mhaztAB8k2QJ5ABlg9OKaGOlOOfqD/AxxeILIPgcx/6FZOZfUHE0tX?=
 =?iso-8859-1?Q?gju8svPkscA6WaLCB4USlcSYfD0cuyt7ocwacQkpGlNyOiLN3+8h/wW6uB?=
 =?iso-8859-1?Q?SjziTkEGobb0S76PKfRLcsLufhiNUjxLn9r4qrAyBB1hsVJVcTkyKyPFmF?=
 =?iso-8859-1?Q?1jiRmOpcfTy/bRWahhrsz+NT3VgucbOnagklTL9nmIwFix9+DndVNHJiWu?=
 =?iso-8859-1?Q?8STfivlRH7jcCZB5UAgRjkjPXG8QnEu4WXIyfDmQVHGRzvn8RI9UbQPUIS?=
 =?iso-8859-1?Q?AhSCm53wY6iPLhDU9sCPxr91sz0NI+Npky8XGsO1y98vxQMuPYYNp0QaF1?=
 =?iso-8859-1?Q?EzZDLs8Unhb6VVmUKIXvlPRRpQ5T4mpZG8hZpbF3V/qD/fV5ERk18NmZtv?=
 =?iso-8859-1?Q?c7rzbvCZ+/uUvnXlYuNLZwqNvgHgVsKCCHIo4xBFp/zeUIZ88CP3kf/C0C?=
 =?iso-8859-1?Q?sWAYUSBQt3/AMTnLQWF7D+fjeyU5cuv2OkEQA0RhLRHY566MZ9lXD3KZlI?=
 =?iso-8859-1?Q?DGnTvzJN+M/QDTwXUgT40T1hohR4wQlt133fX437GIH34sClpyDCOtpeKN?=
 =?iso-8859-1?Q?zKrAXVNgDMIGhPHZQD7Z4f6SsvwLPT9WAafzcPqlq/iL11z7w1qVNCWaig?=
 =?iso-8859-1?Q?BH+dqCOFJebKST7D1gaMyVajs+fg/8iKmlNtkrTIOJjdET3syxVuusm5VK?=
 =?iso-8859-1?Q?j/m7QhOE2B+akyWHQYLmkMY89yDFAm1Je4z3C9uZDPsl9kf81Ug3PJ/iRu?=
 =?iso-8859-1?Q?CSyFoF2pj033MOrpH0jXund7zbSP8JNuTnSOJbkuGsVGFToW9WpAkqc00a?=
 =?iso-8859-1?Q?FUerz5OA0aK6qqtt0q0sV8evBaHfVBYVHKs8kONgXriFR7V6vk61OfFsnh?=
 =?iso-8859-1?Q?tq8WZjo2rmDohTFCy56MN4HDcx5770wlZJfFPFF34I5MHK3cYxzqcpG2X3?=
 =?iso-8859-1?Q?M7dsq4cqpVeeXx+Oy+Ya2thdHpZuRWGfGt9IMMtRrFgh2QSX/KPgwfayfz?=
 =?iso-8859-1?Q?5fJYaBXNZrlrvtsPbtxVKyVaa+V6aCm88SDL/K8Sqwc+tQ4LphpHfoebHx?=
 =?iso-8859-1?Q?ef61uoL/OPVKwxzfiZaK58gPrurVtMWq7nclWbOqJXsOln6FgNP231aQQi?=
 =?iso-8859-1?Q?fdL0roPzLzsO9tS0NKjuDWblvHATT0hOVzrXqdo7VlQtumelixlpHTFeGc?=
 =?iso-8859-1?Q?qO/KhNKwrMB+o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa4f541-ffbf-4519-8d6a-08dbbf6adca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 15:03:09.1823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN3CALYWGyZKaGeN47rBgPGylTQ1u/RpcqfOW/00V6YyZGrw978DRLFIcemF1gN1wSsyuTCy375/Q5CDvVg9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::62a;
 envelope-from=vsethi@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Sep 2023 11:28:16 -0400
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, September 27, 2023 9:25 AM
> To: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Ankit Agrawal
> <ankita@nvidia.com>; David Hildenbrand <david@redhat.com>; C=E9dric Le
> Goater <clg@redhat.com>; shannon.zhaosl@gmail.com;
> peter.maydell@linaro.org; ani@anisinha.ca; Aniket Agashe
> <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> Vikram Sethi <vsethi@nvidia.com>; Andy Currid <ACurrid@nvidia.com>;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Gavin Shan
> <gshan@redhat.com>; ira.weiny@intel.com; navneet.singh@intel.com
> Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
>=20
>=20
> On Wed, 27 Sep 2023 10:53:36 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> > On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> >
> > > CXL accelerators / GPUs etc are a different question but who has one
> > > of those anyway? :)
> >
> > That's exactly what I mean when I say CXL will need it too. I keep
> > describing this current Grace & Hopper as pre-CXL HW. You can easially
> > imagine draping CXL around it. CXL doesn't solve the problem that
> > motivates all this hackying - Linux can't dynamically create NUMA
> > nodes.
>=20
> Why is that and why aren't we pushing towards a solution of removing that
> barrier so that we don't require the machine topology to be configured to
> support this use case and guest OS limitations?  Thanks,
>

Even if Linux could create NUMA nodes dynamically for coherent CXL or CXL t=
ype devices,=20
there is additional information FW knows that the kernel doesn't. For examp=
le,
what the distance/latency between CPU and the device NUMA node is. While CX=
L devices
present a CDAT table which gives latency type attributes within the device,=
 there would still be some
guesswork needed in the kernel as to what the end to end latency/distance i=
s.=20
It's probably not the best outcome to just consider this generically far me=
mory" because=20
is it further than Intersocket memory access or not matters.=20
Pre CXL devices such as for this patchset don't even have CDAT so the kerne=
l by itself has
no idea if this latency/distance is less than or more than inter socket mem=
ory access latency
even.
So specially for devices present at boot, FW knows this information and sho=
uld provide it.=20
Similarly, QEMU should pass along this information to VMs for the best outc=
omes. =20

Thanks
> Alex


