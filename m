Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2266823B26
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEWt-0001uS-Kk; Wed, 03 Jan 2024 22:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLEWr-0001tq-F7; Wed, 03 Jan 2024 22:36:21 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLEWk-0000LU-60; Wed, 03 Jan 2024 22:36:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKfzCr9BLrKgGBil+gF/C4NF1BNXIaOrK5Pv0jV6UVRT0lPjlZbwC2gdWSPTuukAFskvjev8cbiPieUv5DuyaAnf2CcEqMXy3dCg8d4SCbDsmrM8tCxc2dIJm6l22DZl1JeUY3pa/9IL1DphOGQNXKc7KSDztgHOAmaFlTPpN3lZBJ1pdFjpgHDoRFgKxNBBznUG94Kxqte4FWGLkQ6ZEmyemx2GGkKzieOC/B8gw7jRjywjzRGU7to96sCVmJDtsHrnhKzSqk3SrBR6BhJMZohmtS4YMBkQx/4NJnqYvBUfHjEaPTJi3FLApXjITm1C8mKByjyfGRqi5+1sXAOTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqioe8IJORIg4D3oP7f/dLerNqjqyc5VNmOoIuV8hgI=;
 b=YjVLzQP0HYskdupXZCAnTRFonIfWz6DHwpwOEM9q4Rath+LzLTykGrBOEmiugkv0ntZflwgOCK3Pe/rBC+oWAfCr1C9bNe3JkhZgPnl0mOve2TsspO7WcDx80Pnp+nFbSmsb96veayotDRfQw8X3oIXMfuWu4UyY6SadkFmu22DNT2W9SJTzzjMJhVlkQaeaCIoqHVYHoNv8cajTfNiME9oc9mNnwR9RNxyMcrA2UhWgnIusohozQh6RCBly4qEnl0Gz3ISyQFqPSXhgCIcF59z3rDk9fAxXVoWd0jukx6hjOs1twRukaBNWvayF7GOTx7Bfw9UuGOx4eJn1Yb1HbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqioe8IJORIg4D3oP7f/dLerNqjqyc5VNmOoIuV8hgI=;
 b=TsmhSySG7FcijzC08xIflDUMNEf+CkVxgDc848fut+IF5CSbjzeg5CqIsUh+du6FXuXTvglJEgB6qfwwqePBits6jvYtfQwFTwq5B7ON3ggK3qnHE7fBZ7Addlv8JYrEG+a7CP+IDzHHS36tU/fcWWAK57/tY+BNWAxXWnv2fhQWdmFCHNXCu0uU5yBVAF1V/x2tkuzjDiUcVDGKnxh97ZQ9P98mRj/+smp8/UxgR7fRJPMsRBEWCzXTYBRr4cwk6GU+UM7BYd72x+UoaiG2HRXmAXL8mzV0xQEGubfPNOX/BrYkj8JIFOJ5cX/3RQmMGLXSovvlQ0nweSsCTrH9dA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 03:36:07 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 03:36:07 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDGiNyAgAKAsMA=
Date: Thu, 4 Jan 2024 03:36:06 +0000
Message-ID: <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
In-Reply-To: <20240102125821.00001aa0@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|BL1PR12MB5111:EE_
x-ms-office365-filtering-correlation-id: c6033de3-35a0-4e83-04fe-08dc0cd64905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ej2rKxlBBXtdDFk/dASOaEod5dtMFNuKR/9a1azkzM/h6MdfSjzG1fLTQdOplUQ2OsrJ/RSqzlM5Q/JDIlXtNrkwRj0jhFNpf0+p3QgOvNYwT3YNKMwEIToIzHBKfXwKFhDqTFRgpEFFSReoH9rpfPACYKK5Etayq+sj2Gz9CmkIG3qeJA3EyTOY1fn0MuitEFggO4+mWVpjPmf4QWX/KZX/OpWVlsicJ3lHmdT+zCl91JEpLYGadtV1kBYS6/EJ80yEvtYpQ8lpB6MMiwS7D4jXWs35TiSD6QHEv6GGgs6OsNdTi9ZiJDNfuIGVq2tihuUV0mTrCqvgB1t7HCB32m1dufLm4HIc5C159alrXPZFYcnIKXDXysD1ds2q6TOQwBB1oV+IdvX1ZSQcLTU32dtSdlUYlww+x07kiclbvLHrFpX60QK+uOzDd06rN3CttS+33Sq7mY+Sb1WcSP6mpQTjlNWyvGmx7SF0AmACFa/ZESwnSKDICAze52Jcw9XSO5Ly5zZJabjfGWNix5OOgqJqtKVYo/+GszE3Sokz6i/YFxYYDwnPymHGEeQSnthuKkTlNvcw8mqGTdlp9eEnS+Ad+kGmBiNkiAS9vpMJMMw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(33656002)(66446008)(91956017)(66556008)(66476007)(64756008)(6916009)(9686003)(66946007)(76116006)(86362001)(38070700009)(6506007)(7696005)(38100700002)(122000001)(2906002)(26005)(41300700001)(8936002)(5660300002)(478600001)(7416002)(8676002)(316002)(52536014)(4326008)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aFm4b+QuiCQYmPt/zc17S5uIyE1bQLuYeZixajb5HMe+XR6hw+I1kEulMj?=
 =?iso-8859-1?Q?lK0JEy6WyysdVQNxJo8qUxkV4INfpZAruiT9EYhwSSgeyMJd64wd5q9Whs?=
 =?iso-8859-1?Q?+jVmLWcKUtM8gt3L2jP5gI+n4C8ivtP70Ipgbwnkxs1iuEovMcWBtkhioa?=
 =?iso-8859-1?Q?dKP+JjWkYxmE6kNxCsQaqdhbbSCblbHV9liqESF4MA1UXl8NJF6Ri7MY5s?=
 =?iso-8859-1?Q?7pdlcMgO6HZzeFr0R76ypbcoTyZ0G9/Gj8B/xZL2f/hbz9iZjS3sCelJuO?=
 =?iso-8859-1?Q?uWmcAJwJmjU2GIx97q1s9VLomCC56PSQ2joPuYi6VlsiDXU3rbObKmAq0f?=
 =?iso-8859-1?Q?PlbVt/4ErucRA/kMwC7Xcncrx/YIln6/BSgK5Blwd77b22OII9T2La/c2p?=
 =?iso-8859-1?Q?07pohuwnmKrYg/WgI+e1o07hGj/jVD7Vd0T3hxNS6lDVojKvTxs9ypmki9?=
 =?iso-8859-1?Q?zNEZeE+/H8eI4plDqtZu59pn/2wINmkm1Vrxn4Q1LoHqpN0MxitCAsT6UT?=
 =?iso-8859-1?Q?3jDZEt6vyhhqPF862aN0e9ERVvSiZeTuJVwNa0SvCq8R36a7FhbbL//qUF?=
 =?iso-8859-1?Q?3ONxgWCEzUh7C5dbSNVWTrCr0f3hyB36/zYhXwB655V9hkrynf6TV4YvNz?=
 =?iso-8859-1?Q?PjsSU/i66Y3JbxB7ha75LR5uC1HOZ97+sSu2eyJJGwHPijFKTUnS+wxgub?=
 =?iso-8859-1?Q?hs+UhvbQ7GOSOKfeDRkdECVB9ds+2TUob/5CywP4zjqSi44c3ofiXFWNz9?=
 =?iso-8859-1?Q?9N63QliK1cXsWwp73Qf4MaUf2CvQMt4GJ9qCVbXemSAtGik67D08PUZiNp?=
 =?iso-8859-1?Q?gdnzssKL0NcNCJC5tYpOaD0cLOjeV7Pk4lqgSKwak2fVl9cFvXrrWybgE8?=
 =?iso-8859-1?Q?vjEYXtdGk2agQJSuGLj3qFimuipuho4ZwU7H/KrPps1A2KSHzQFHBtlinu?=
 =?iso-8859-1?Q?UbnzIkZkPKOIJsiCuSXVdcZHGtkcBpTOP5PNKoWwaN/8s5b5DKtlgRA/mR?=
 =?iso-8859-1?Q?rv9shdNT50a3GFVMFV87z22A3HSJ2qWTPPjj7VVwydvlt0WWohpirejg4Q?=
 =?iso-8859-1?Q?BXA0JPZxYTOAe2uQP5o8f+S8MqNh1Vo4OgzgLo+p0RUskY84XnUAt4+bBZ?=
 =?iso-8859-1?Q?GgzVTp3HcdUsiQSTcVUclfqcsYP+C0HsRcYGFEhKAsl38ECD/m+SZZjO92?=
 =?iso-8859-1?Q?wAnUQ/7U45NMivRpJENn8BNt2VIjB3IJSy+lwUDWED7XSJ4rscwAZtcyPQ?=
 =?iso-8859-1?Q?uZxFdRX1bG3GJq24uligt93bOG7U0hjtgcSt7g0rS6Yt2lOOqJirxHwr8U?=
 =?iso-8859-1?Q?GjTac8dc3wb6m2BhNh7f3D3CFkPitBbwW382EjE9bydjK0b/KgmFpjfJrD?=
 =?iso-8859-1?Q?ibf/gDWi6umZA+5FkNAACfvpYV96D7+/g+xUqE1t6WWdg+cZZ2yVrERB6p?=
 =?iso-8859-1?Q?wYoi7U01pGGpYARh8MN8nhCis4W1yqNBXur0gcjnTdWy0cBtf9/FzvcGVV?=
 =?iso-8859-1?Q?aHt1HdZUySb1O5ZeTw0dhHDQSEJYW80dG3xA11TL6syHzyUmr9N5XKtkiE?=
 =?iso-8859-1?Q?kpi9mywfgsPWVKPHYRiBy5t1u/6PGYAEKgRFLZaIE+F63a1K05pY8+whU9?=
 =?iso-8859-1?Q?VhSwOEKWnIKAE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6033de3-35a0-4e83-04fe-08dc0cd64905
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:36:06.7016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxAYb9vy82DZ+NOaslhueaeQ9d1+GCpKLx2WBvC/HAZeJyhdr2D5IFFyyA94qnVU9CMxl9jE5OYxjsxEQZuY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks Jonathan for the review.=0A=
=0A=
> As per reply to the cover letter I definitely want to see SRAT table dump=
s=0A=
> in here though so we can easily see what this is actually building.=0A=
=0A=
Ack.=0A=
=0A=
> I worry that some OS might make the assumption that it's one GI node=0A=
> per PCI device though. The language in the ACPI specification is:=0A=
> =0A=
> "The Generic Initiator Affinity Structure provides the association betwee=
n _a_=0A=
> generic initiator and _the_ proximity domain to which the initiator belon=
gs".=0A=
> =0A=
> The use of _a_ and _the_ in there makes it pretty explicitly a N:1 relati=
onship=0A=
> (multiple devices can be in same proximity domain, but a device may only =
be in one).=0A=
> To avoid that confusion you will need an ACPI spec change.=A0 I'd be happ=
y to=0A=
> support=0A=
=0A=
Yeah, that's a good point. It won't hurt to make the spec change to make th=
e=0A=
possibility of the association between a device with multiple domains.=0A=
=0A=
> The reason you can get away with this in Linux today is that I only imple=
mented=0A=
> a very minimal support for GIs with the mappings being provided the other=
 way=0A=
> around (_PXM in a PCIe node in DSDT).=A0 If we finish that support off I'=
d assume=0A=
=0A=
Not sure if I understand this. Can you provide a reference to this DSDT rel=
ated=0A=
change?=0A=
=0A=
> Also, this effectively creates a bunch of separate generic initiator node=
s=0A=
> and lumping that under one object seems to imply they are in general conn=
ected=0A=
> to each other.=0A=
> =0A=
> I'd be happier with a separate instance per GI node=0A=
> =0A=
>  -object acpi-generic-initiator,id=3Dgi1,pci-dev=3Ddev1,nodeid=3D10=0A=
>=A0 -object acpi-generic-initiator,id=3Dgi2,pci-dev=3Ddev1,nodeid=3D11=0A=
> etc with the proviso that anyone using this on a system that assumes a on=
e=0A=
> to one mapping for PCI=0A=
>=0A=
> However, I'll leave it up to those more familiar with the QEMU numa=0A=
> control interface design to comment on whether this approach is preferabl=
e=0A=
> to making the gi part of the numa node entry or doing it like hmat.=0A=
=0A=
> -numa srat-gi,node-id=3D10,gi-pci-dev=3Ddev1=0A=
=0A=
The current way of acpi-generic-initiator object usage came out of the disc=
ussion=0A=
on v1 to essentially link all the device NUMA nodes to the device.=0A=
(https://lore.kernel.org/all/20230926131427.1e441670.alex.williamson@redhat=
.com/)=0A=
=0A=
Can Alex or David comment on which is preferable (the current mechanism vs =
1:1=0A=
mapping per object as suggested by Jonathan)?=0A=

