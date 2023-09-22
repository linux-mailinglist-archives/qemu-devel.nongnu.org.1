Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D77AA891
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 07:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjZ3A-0000tb-4C; Fri, 22 Sep 2023 01:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjZ38-0000tI-48; Fri, 22 Sep 2023 01:49:58 -0400
Received: from mail-co1nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::623]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjZ36-0008I4-1b; Fri, 22 Sep 2023 01:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKqOlkoGvX4yX8HjK+RewRSKZAEeAYNCyWGiTH3b7gSlHtb+qm9c2JMlNseWV3/5jhaOBTnV2jpYyJvDIE9ZwcriizXCd35puiDQKdp7woeethUGmsvE+D9cTwMwYE/EFB8CBIp8KkoJpUUdouuDJovCGKd5gvnPejamyhgC5xExjCHC6rUeafaygZ+UCR87/Pg0IJYpFV4K4F31qiIyfGtHH8a4j2KAmCHaRh6Fz4fC03Uu0Zv6ewxszIVMmH7zMYcbVOPZp1OguDahnxR09RIouigKV8imWUl+qwywcD7QCbd2ACybg/pblIVLagyhHxbeel3T5XmaqHF0fqdi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6W6zIOSY23Dhm3XcFI6BbclJRTeK/LlytJSZg6u5Qg=;
 b=ARc3iTG3GuQ3X/yH3C9/mUAmRkDUXBmCrUuG9SQZpvpKap/dO85RKE8BT9rWL9kjSz+Hyz9s6VXeWP2VvQpWyGVMKz17Br0N9kNoBvUPSe7d+CxbEwOdOUwPL4SiWcs43MlFjf/o7MJYhquNEFB22BpvY7YHk19Cn1EqeabGbI5QAfnQAc0g2aMHe+Lx32Vmzq2Ayy0RVgpl0RAYU7IUOb4g/7KpzSf0+r+fDkNZMnHWFhJqybYEMMX0VzOZcqXywhdhZADzQxpB0Dg8C+CgQmxrwL3IO2omwMMjbErU1uYZVSfyikanZQfi9VzJ4YQ4qvMJDAlFOeI6fTiAB9++Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6W6zIOSY23Dhm3XcFI6BbclJRTeK/LlytJSZg6u5Qg=;
 b=CB0OQLg/6mush0DFeuRnF0ypUXS5lXf2zfxjLqai9n7AAbJQ1BXG+R8eD+DoBW5TpYgczkQRtKiCyfLGhfKx5OScEFRYO/qSoqE+spa79ry0uxbBTxQrERNdtTmb9ShejrQkoWwxI1WdQSI1MTvATlHy2KDeLXwLGPT1woGUS7TdCTTJd1ibO5XCedfsWIQ6r4Sj/W6SiiBA9GtcPbCALBpB9TMVcCP87rMjyPyeS9yZncKruhHI5TE4qjU2Sg+aonZTF7wRSw0pzLtHU85k7Lsr82feJWVPDN8uZsX82bPx3K9oiNA8MFdDWDj8JqU0qRp1lKGrUL2M+ufNc45P3g==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 05:49:46 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 05:49:46 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Topic: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Index: AQHZ537HoMkIAkADME+0ZStkB7Hp17Ab9V0AgApsEEA=
Date: Fri, 22 Sep 2023 05:49:46 +0000
Message-ID: <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
In-Reply-To: <20230915153740.00006185@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|DM4PR12MB7597:EE_
x-ms-office365-filtering-correlation-id: 32b6054e-cee9-4d57-2f9a-08dbbb2fba0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XE29KvS5E/Zj7dAF9CXVZU8bxgS6at4AVVYezQ+M9po6S61u0HEo1hXxGC0dIm1oXahzO40BeB31axJH0jDHt+dx2qbIBX/jYbc3cE/vPGQApoMHmmSHQ3O1Ff06iuLilMGMAt3JcEwrfG/rtfBZAldwDb5jP7DOxyDSFLrb85iNv+AyhQRO/zyHtcE+H2BzIARh+p/6VBZxENdsjAGtycjYVzcMp+CdZFGRAr1aVxHZxcBhACsJ+iUJv0qVy49fyWdh89HJtNsFsXOh1r2hqxrH3dqT6YPfMbPZ9bhJ+SmVp3hnhTZgtRiMNax64PocBy23gFUzsG1tN2q8RMMqF9KSMXGoV6f0QFZQYzO9mkO9wud09yciawS4iQWF1liDRJOVzeMDZuTYJBW6+KoNIbmu6xiNx5HSRG6bqtolQ524EVSIve/NkyOc/a+6r9x0U5SPtsLEgrTT5A2AIqwSGl610pxNUYLOo/y5G0IfhT4hBz5ZWab5mciI6bvg5ipRIs1BunudpCkVDxD0nVJZwaMyhpQwnC+YHicUkcIdl5f3sQFW0WGbM+kTgmyMNhzJ6EYV33B5Jy+qi88AUdPXO6K5+15RanBw5J4/YPo88VQIeHry8AX2wknGJ931uBiY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(186009)(451199024)(1800799009)(122000001)(38070700005)(38100700002)(33656002)(86362001)(6506007)(7696005)(2906002)(478600001)(66446008)(5660300002)(8676002)(66946007)(71200400001)(8936002)(4326008)(52536014)(55016003)(66556008)(76116006)(9686003)(54906003)(66476007)(64756008)(6916009)(41300700001)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqkAqgEBjxOuOQWMg60LBRblg1gDRC0c2MHX7K4nkqLeV5zrCC6T25UParMG?=
 =?us-ascii?Q?7bOmHAZtUXQEYKrb93QsG9mVwqtY96QPQJzmYjlwcYtrbtE1sgbUJFYGRrd3?=
 =?us-ascii?Q?dcBGyX84021kYv6JZKK2ytC35UfNGo2AN9BzGQyHSvTvwb8Mxbff4SOPEsJC?=
 =?us-ascii?Q?9BdnEiGR5L/MSVJFniFUcEy4B39t1OpIeOZw7gD/TkkSLRX3NrUNiL8m0l9q?=
 =?us-ascii?Q?GcZlMR4rj8KNdrJWUFng0WBeQpL6041QX9UW/be4FJ2vPrtIpKJUbqd2vrf0?=
 =?us-ascii?Q?d86exUDE6TbpYw4lDjtULeKdNN+WPI8Ol1ika0bDfXFzWqZvSZ9zxkM6qgVq?=
 =?us-ascii?Q?h+9NhmX2Y4M7lkjRUgh8g2DOyuLXyudZS85njdZKDK/oSDV54BG6avTuLKbM?=
 =?us-ascii?Q?s/GeSdtuqQ4uqrOHfy3bEQp5GNickyVPFI1MQLMvsbz89fzQXSgfML9DkMgt?=
 =?us-ascii?Q?BHWD0CFkoiihW1tK/YI9nVAar6GhS6kcHg2dtaFajJe2ZTPOxQnYOkQBs9B8?=
 =?us-ascii?Q?W7jgYQDS4S+zZ29YYS7SkYYaNU1rBAIPQRDvHUlx0rql5IJt78djAW42ihnx?=
 =?us-ascii?Q?VCu9SEu/xLG3qbaSdzEupRfHYD242ESYeAKBnzu2954C3sjO5G5YyOarnoFS?=
 =?us-ascii?Q?LxculGW3tdbsgL2bbLeufAxRWwckdPk4/19x6E1rW1elH5dZhzOtTrJ/UxNr?=
 =?us-ascii?Q?Slu8doNP3rVWp5+ntxogtBAExxCSeqSiaGRZjE0okY8ZQn29NjAz4d2M/ATg?=
 =?us-ascii?Q?4MQRsXXMZPBCYrEuD2gTgC5aPT9TzZaSSjUS/vecsEE1H6LPm4G/pHrJS9S5?=
 =?us-ascii?Q?eHHV2U/PxRUkYru03JX8WX0GXkLMtR7HiPbrWWc3x7Xnr9oRQlj2kbXUC94k?=
 =?us-ascii?Q?tvW7oFyAbnp+yeqVazmzrzFobEMb9D3OU3oadBz63UYWV/EKeiDU5kXmRHfg?=
 =?us-ascii?Q?VvihQgN0l1wjK4wWWJD2brSUsJLm+aIXCRXoAW6oxRHZVvmqRnekC92MZHFY?=
 =?us-ascii?Q?fHvH/Oo1eToouqrUbFxUx65dfVB+qPbRqleSZiJGusQIDcOPck2DnMuCuy6T?=
 =?us-ascii?Q?APhs/pxQRrUpnoxJFExRGMETIseNfWXMQVebCbZXrLVMAPiqoXjEj17R5xGp?=
 =?us-ascii?Q?UZniN3D8srM4TuJskOy7xkhka9xlYLoPw5qPS5CghZu1YT7EZUfu9A2WFiOK?=
 =?us-ascii?Q?XNoFG8krA24+MCLhMpA5+OMo2PmdsCa0IRBQ3W526KwEoqNfOfYmobDixyj/?=
 =?us-ascii?Q?qI9jZSFB+iwcqusdZFY2eS5ageRTmqeICqcgNLX4CFVnDVOrA3Ed6ZwzV1Lu?=
 =?us-ascii?Q?y+fCxFNlhzYPMNo1qB66y8FiK0CO1srNQ/A05viFj+9wS2zn+rvk2vTFGMdL?=
 =?us-ascii?Q?Sw6AB9gV4aQzz7n52cuCi9Y6NTTEttumtLe5lf+jmZylmpDwLRL1cbpXdezr?=
 =?us-ascii?Q?BZylu3jkZRANEoidjwBrCX8uosfM4GsgR3TRNiHu7aUFRigb968WWL5vrEky?=
 =?us-ascii?Q?SGky83GOtSlwLzFU2GPYp47HaO/0E420JQw8N6caKlvltMmVHcOq9e1Lv46v?=
 =?us-ascii?Q?YI4GzvehGANMs4Yo4t4fyTW/Mqcv7YCZEmqzhMbq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b6054e-cee9-4d57-2f9a-08dbbb2fba0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 05:49:46.1882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgk9xxOegJRq3Lo3aeByOh89KjOXjcDh8ajCv4TItZXPFarU1c0mB5WxqsK4U2h5ISSJ7gsnqUBTr3SG+bttrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
Received-SPF: softfail client-ip=2a01:111:f400:7eab::623;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Hi Jonathan

> > +        if (pcidev->pdev.has_coherent_memory) {
> > +            uint64_t start_node =3D object_property_get_uint(obj,
> > +                                  "dev_mem_pxm_start", &error_abort);
> > +            uint64_t node_count =3D object_property_get_uint(obj,
> > +                                  "dev_mem_pxm_count", &error_abort);
> > +            uint64_t node_index;
> > +
> > +            /*
> > +             * Add the node_count PXM domains starting from start_node=
 as
> > +             * hot pluggable. The VM kernel parse the PXM domains and
> > +             * creates NUMA nodes.
> > +             */
> > +            for (node_index =3D 0; node_index < node_count; node_index=
++)
> > +                build_srat_memory(table_data, 0, 0, start_node + node_=
index,
> > +                    MEM_AFFINITY_ENABLED |
> > + MEM_AFFINITY_HOTPLUGGABLE);
>=20
> 0 size SRAT entries for memory? That's not valid.

Can you explain in what sense are these invalid? The Linux kernel accepts
such setting and I had tested it.

> Seems like you've run into the same issue CXL has with dynamic addition o=
f
> nodes to the kernel and all you want to do here is make sure it thinks th=
ere are
> enough nodes so initializes various structures large enough.
>
Yes, exactly.


