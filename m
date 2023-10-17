Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7E7CC56C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:01:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskdK-00032b-Ht; Tue, 17 Oct 2023 10:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskd7-0002pH-FI; Tue, 17 Oct 2023 10:01:05 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskd3-00084y-LZ; Tue, 17 Oct 2023 10:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlYFZ5W76BC0nE8PQo8E8CmNGK+E84cCC1Y+VIlwMmpJbKUQqfI6Wx7HlHVQeO9tqiY5R9GONRbgMbUEDIfRO3xtR88q0Z90zGvgREpk3grrtq4F7odJz3lQy55hwfjL7egXah4IlFw1luu/QPfwnDzI0BZ5QDihQ3B3urjrM5ltHwre6spfhd38HjxWEkMooGa0FpKAQyNhYu4Aim+dvmKcfZehUvzcecMth7lafa/gd3UcfIDYSUN1qlxlwPJQWLvqeN0KJqhrSdT6lG5oS8cB71r/IsbyAJY8n4yfqO5ot7uThpfGnYutcPrJpxAa26xgyvmi0GhEXjR9m6RGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHLT4dVABvGLToa660wpkJrBUtXewQe/hEJnDcMw5f0=;
 b=Nb5CxMq2zFMLz3ya9mjefQnPLeHuMAEQiO1pfPqRHy7xZgQpiLGHPsRGYu0gRsAE/I8BdtnsYXDP5uNGao38lKod/LEDrx4ppVdWoFJ418cfrlvfs2MkRlEyw+4IysvvfInWUqCLfRpBfb6FV7nH5kOU0qrp6mXIyYco2avXWDqiWJCjJi00HZb3iCX2lT40ArP8F0Ba2SWuHqfaKOPSqYPIDfUIiNOKZcahhUdWH18pbnkjN1zYOjziuxUvyC8+WOHIEJZ670Pq1WTPpKWJCTPBEYMi44/DNVuo8+Dkyjm39VkcDrKo9PsqcJKKFIbs82VXChfv8jixOa5ilY1ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHLT4dVABvGLToa660wpkJrBUtXewQe/hEJnDcMw5f0=;
 b=N8JEf6elkfGx52PGkAeoKy1CtBuxL2/X1RA1AyvIk+ACBebqdAEzq7cVMS8B6XDL7hzeEi+RzeQ8p77TlBgnYH/UvvHqF3nyPZkUBdbOYe6gjwiVmjpKPveq7vXVmuqD1/DEnr2pDKRYwxuD8mFMqBAbPT7C5zBkYKhrAEBPVOT4/xIJ7aCUVj6rFLQK55Miw6LFfG3Z3zsLdxzvyasbF9gPOogz5HxsXK2fd/2MwGgtZ6UNFDzG1C/8xvy+9KuQYVIhReEM+KxQpiseM7RidV4+FMXHNbi7wG4yodboygrZcKVKpaAnVk0+oBtai3gbjRLGeJdNgXml9GQUHR0VIQ==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 14:00:55 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65%7]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 14:00:55 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Thread-Topic: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Thread-Index: AQHZ+Vt18QX6bvNz2EmmGfmD0VHJcbBB+PCAgAwXSoU=
Date: Tue, 17 Oct 2023 14:00:54 +0000
Message-ID: <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009151611.02175567.alex.williamson@redhat.com>
In-Reply-To: <20231009151611.02175567.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SN7PR12MB8001:EE_
x-ms-office365-filtering-correlation-id: 9d0c7072-b3a4-47c0-85c4-08dbcf197b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHaWXUldbByEUBSdYoAHaZ8UMZeqmRv7Ug7ter603ksFbNubuMhypZIJCgiKfxdILi6QOoNoI9c4BxlvZoyitcd/6ko1oJNtFGxT5n2sleqhzU+E1huL4prDGji9cJ2IOf7fy5rYmw1S++ptbdJgO+1hnqh3Z1RPGQmV+oQVUCNALB5M/RpBAYmrowl9Nvfb3YTmeveY+zoDfVbDO5MajRcz8OOXi508luL/nEYL1ZtZ7E0ReyAXvVidk0RKU3xmpxXbfKLpUqbcxwoncVO/KACPcUMAllohYB9XeBEBZHydeffPMaORARLZ0RRTa4BjCxNFaH0Cm/55g15FlvIvmry3cA6Au/iSK1pJD/wEFdIRk8XDm7NO33vo1cylsznfo98eOWN/Nrergvt0kVr1xSI9xbdWdPkFbnFTy2CGQ5sAyFP0VGcAPeCI+U0OyiQ2TVK6qZzd0MZ5D9/HMueAhEMeiJsAIxLS1nlZmOcCXTWf9PUIZ0nHjt7XnDqX3rPXiGJ9qOmiTQ6ve3ItQG5wTSF2OStPD+IIKKDFicQ6ywIlvd5ymMhI45Pl6oLhm46MFFA2wvct8OaO9aDNa7L83C4tZhdqALnawIbJwslOoR8UMEaziSNZpH1cMvkNho+Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(66446008)(55016003)(38070700005)(26005)(122000001)(9686003)(38100700002)(2906002)(5660300002)(66476007)(64756008)(66556008)(41300700001)(76116006)(54906003)(6916009)(66946007)(91956017)(8676002)(4326008)(8936002)(316002)(86362001)(33656002)(7696005)(52536014)(6506007)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1sk9hYGHWXoHKPwKN0EGcH2QBMYEH1nT3oP2HFDGZBGryawC9sYBJdbcXT?=
 =?iso-8859-1?Q?hy6EHR5AfoEA41+xpIkKiI68PXlR40LH0ic2hmqB/mDHO+iwu4BbeE6siK?=
 =?iso-8859-1?Q?j1EXFTsmpDF5H4CD9l2FD31WzMObUWSIGh1JpbILecpGij7B0ypnk4tEwT?=
 =?iso-8859-1?Q?ytU07KCaUjkGM3RXTg8hVyUDzCXVSpGN1Wqvra3iT7/80+bZ0tEJb6SXfr?=
 =?iso-8859-1?Q?kIt8xTuWeBYFUm3vscMniOPS2FWzPOWB737dKEbblYZdNTeXR/QQFnJ/nr?=
 =?iso-8859-1?Q?82oXGp6LzQkG5lgM5IUytiZkI6qWDGz2uUvdqDY8v/AtzzXZS+40a58Myr?=
 =?iso-8859-1?Q?e8wfTEAhJ/al4L9MvVvsQ3N+BRyyFlKEEdlLZt90DGUhndI3MAUB/1DurZ?=
 =?iso-8859-1?Q?i7aQ539Iv9GvtttsNL2hXOsMmF8fe8xV7yVnGksCXQEjFgmwNGrxQGc10L?=
 =?iso-8859-1?Q?U/D+CaGezkouj85Pxtkk/1hHWmZgBdU2lJHIK2rUOM9mIxv+qALvrnm0Ly?=
 =?iso-8859-1?Q?FCkujWToOKa8FtKpPTjQNTL7MJXaHDJtGlfJ7o163xOUN1lQ6PFPYDcgg6?=
 =?iso-8859-1?Q?RVtOJ2QpJxGv3pOGjX32Ma42gQHxiCiXd2UrN7aI0lGUg8O0YLcekFLLad?=
 =?iso-8859-1?Q?eIAdC/q13Re+7BbKJx/fUULDMrgLHPM6oSQm1FrYaV4p/+yc38+yDZEz3l?=
 =?iso-8859-1?Q?9lx62XF/26WMBKrZtqplVFO5aki2OMts5m37VcOSDgtGSadz/4CkECSD2N?=
 =?iso-8859-1?Q?ViEpQG2qQn6JDV+z/dqHFlrTVuav4qPOpbjfzo35aYYSeLuTOH+IWUd9p/?=
 =?iso-8859-1?Q?5P8zGfoed3RzrdF5yVjitASs3OTNW9WE7uMENzwGIZAQFd+GUBqQydHV7U?=
 =?iso-8859-1?Q?iXqHB70AmjTUfo9eWHmrX+D8YQ/nsC4cLF1cClVjC+IXvm7bkCPJqRuUmq?=
 =?iso-8859-1?Q?sY4iV4pwmKgdnv9IUB/AXpEmt4pbpjuggMwzyiTYkXAAbskxkXvuhLVN0X?=
 =?iso-8859-1?Q?RzosAXAm/Bj/EDSn2LY6T21WNI2JaLyvVVHfSDaB219/gFMX5tEnk2zT9i?=
 =?iso-8859-1?Q?UOb9M9qb8KBjcJN7PLv05SD697bN1LYKkgkIFdBI/YVWvwTHkQlNcqkYCw?=
 =?iso-8859-1?Q?JE5oXh4nOJL3y2glk+xQngNYYLpRdTniJLK02ii/mndjIhUmyi3s4FBBat?=
 =?iso-8859-1?Q?yPni6Xi87PjPw5xAOAxw/UJ+41WAIPALdLEMyRn0BoA/vjH3wiTDhz5nlg?=
 =?iso-8859-1?Q?bo4zPUTi1IWJHI17Q4BHWxyQWdAX2azZo2AXzt7GkHQEylWcubJNMwL/O0?=
 =?iso-8859-1?Q?1T0OGcGJ9khXYy2zA3NlX9WAPmyl3YIYfGoZW83WQapdeUT3fgLoiIcCLJ?=
 =?iso-8859-1?Q?X7dVrrnnvTv3Q1sYdVPcD5Io6mEoycvb0KP6Dg+qHgM7Ex8k7eMS+CJ/8W?=
 =?iso-8859-1?Q?yJbu9uXMZAPlfumapNtjlKCDmSMrzdegabplMFW4lXZyqDTJQVXLnH+dgN?=
 =?iso-8859-1?Q?/hgPtB5yoU7AFJd5OFsrLNMzSDlhMvydxKNqxlQNS0AUpIsLtN9Bvdzo5e?=
 =?iso-8859-1?Q?q3ahd+Pa/d+omHFoUwMSNr2eEs+fgNWpInRmT7zobn+4vaeKmgF+I5OHF2?=
 =?iso-8859-1?Q?x56PvEYwUn/Rg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0c7072-b3a4-47c0-85c4-08dbcf197b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:00:54.8778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqncxWIkKi0YqH1KcQ7NVk2zRp4DK+QsndNDW1rKBfU2f6hb4Wcw6ZIEGNUs9d33I1eVo8MiGDXQ3iGS4EqpKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

>>=A0=A0=A0=A0=A0=A0=A0=A0 -device vfio-pci-nohotplug,host=3D0009:01:00.0,b=
us=3Dpcie.0,addr=3D04.0,rombar=3D0,id=3Ddev0 \=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 -object nvidia-acpi-generic-initiator,id=3Dgi0,d=
evice=3Ddev0,numa-node-start=3D2,numa-node-count=3D8=0A=
>=0A=
> Why didn't we just implement start and count in the base object (or a=0A=
> list)? It seems like this gives the nvidia-acpi-generic-initiator two=0A=
> different ways to set gi->node, either node=3D of the parent or=0A=
> numa-node-start=3D here.=A0 Once we expose the implicit node count in the=
=0A=
> base object, I'm not sure the purpose of this object.=A0 I would have=0A=
> thought it for keying the build of the NVIDIA specific _DSD, but that's=
=0A=
> not implemented in this version.=0A=
=0A=
Agree, allowing a list of nodes to be provided to the acpi-generic-initiato=
r=0A=
will remove the need for the nvidia-acpi-generic-initiator object. =0A=
=0A=
> I also don't see any programatic means for management tools to know how=
=0A=
> many nodes to create.=A0 For example what happens if there's a MIGv2 that=
=0A=
> supports 16 partitions by default and makes use of the same vfio-pci=0A=
> variant driver?=A0 Thanks,=0A=
=0A=
It is supposed to stay at 8 for all the G+H devices. Maybe this can be mana=
ged=0A=
through proper documentation in the user manual?=

