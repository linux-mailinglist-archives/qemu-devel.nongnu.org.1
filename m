Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D581DE28
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:10:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdCT-0002Tr-I0; Mon, 25 Dec 2023 00:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHdCO-0002TZ-MI; Mon, 25 Dec 2023 00:08:21 -0500
Received: from mail-bn8nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::624]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHdCM-0003bw-1j; Mon, 25 Dec 2023 00:08:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHbcwLfJyJLTPp7fgI+8lcDRxvbCqmZlRMeAE92nsEjEK9v3qySMaraY63qqvOpxoXma3lDM4PmHEwK7fKpB7ruChL/1s8VpvRREq7a4DDLyAfmxkdGvvGQIkFHlB0Lm8xSEjr/hIgvej6PiMGb9PBdYWlwkCN+n7ts3tPxP5jtsYSO3FJ6B9tf0ZKJTPVFzg/8Rwg/mNLCG94ARLgF5w3XY7dm6bnhhUqsFs+NZhs4zCi+to21tvPHkVDnVWcwyKOE0/HRSM3zxh4lBajEa0FH9sNodWidBUPi/ls6OXD5KlU+o4CBN3dK4eA8mHkprP8HJdxgpQxNeNfVx9+WzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYciJchzkQHvacMuWhaCco+i3hX9D/kcUHr0+N+Ddrk=;
 b=GBrVtdLa0FUkACpAt79OwAo1Hxz1xN9NHrIlS2mEiZNJ2gNsImmggE4yGmAFc/W8WsPsD5iIWb31h+XvaxLmR6ZLyfSL7UG+cFfW+cY4Ue/FVkTTfmPPgHFpM8gJGEfPQXJkswPpiUqusFR/HvFmwUOWLfx4o9bRWXeLzN6XBnhlsX1BLu2amWYd/fiMYivJNV95vXtG1RXZ5XunvEEOr8z8mQeFpHaUS7HoVVmer0sKWkvtzmhwuXsXwEwH+3mGdbv5KX1/hy1byelqI/vlgkHooVIFPRzGt0BH6lQbp4XxHtQfL7a6+ma8n1axRR6EkUxl5YNZ6SW07SIFyNexww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYciJchzkQHvacMuWhaCco+i3hX9D/kcUHr0+N+Ddrk=;
 b=OqmwdId2DXNULPgBIR/KA2eOErRYACgH4IzbGiTLIyIidTKUr6Ei1e70PwKvEujQJaC1EJ/V+E/XsAstxYHz3bo0DBhsbQ3B+w8rdKXqn+5r3T475GeCjHH5i3k7s0bm/DymeDI8+RRL5D4M1krfo9uXrrLuEx7ymCFoUwk5JE7GEL2XNYnz4hf7hcVtZNwBTJEPuXxMJLm6zU/VnRFG2a87xr47hta4DodgHAhkk7tbCUf2ZqK4pKmk34Wdjboeu0tL93xAsHHf2HyKiWgu46YPNS6aalXVzrVneidXo9oOyLPuzctL07zpn4dKGZfhUlMWC6ajWdK9rIqiYM3x6g==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 05:08:11 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::946b:df84:1f08:737a]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::946b:df84:1f08:737a%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 05:08:10 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v5 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaJa5iZlrBdjt4jkCSP8Koa4pJ/bC1WpptgAQ4Ivk=
Date: Mon, 25 Dec 2023 05:08:10 +0000
Message-ID: <BY5PR12MB3763F9BE55E6948D8D204028B099A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231203060245.31593-1-ankita@nvidia.com>
 <20231203060245.31593-2-ankita@nvidia.com> <87msu2h0ye.fsf@pond.sub.org>
In-Reply-To: <87msu2h0ye.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|PH8PR12MB8431:EE_
x-ms-office365-filtering-correlation-id: 8c146d85-92d2-405a-2843-08dc05077d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYdpSD99qDkuV6G/r+VCiuKOL63a13t2gFNXugJ0C/7JUnQUPTDBVrYnGHO2mGlwC2SBlvdsbVSSbQswuztU3j/ii+fGob5NOEFC1095AlHCDy5bd1FL031YlFQyfmc9N79P1C/jwlR9ELbnLiL6pck7y9HBsNEeNo4//RzhmfsSEZimh/MwRN9U6ELLcTJ3+NlIo952Fv9LkNLGA89m8n0owgrql9MQ4XRhPdzwjtRIJ1SeUdsvapVtugFCzz6SM6iB86TRL9dzekb+sw1xFC4amboi2PiVzTszuPQF3Rt0k8/rzFolLTichePlQEYb5BuWxT4CbtI6ElYoeoMKltoHO1nJzvkhuE2EW10Kvq45Sf4roBdwAnDCV4GA2oE/yCbnV4k5BnlPW7IZQsQ7xoUKT3vom0pM8Glv9JZJgoPx/tK6Usbda1lw3OG+C303GeWugruNQMcQ+6FeHIyoi7PApqJSWvJO92O4SDq8l/U1KAdjI/Zr9hcYwZf2RQ+/HhH4dblxOkZnY7VBdiWGtKes1MlXQBxG0uBrdyvV7lEAJ9LwuCcjpGujR/9GWTk4eFWnvduktvx4+wJQ6cxfjm0YmrimxNbX5YdUIYVGw9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(33656002)(86362001)(41300700001)(122000001)(38100700002)(52536014)(478600001)(5660300002)(8936002)(8676002)(4326008)(91956017)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(9686003)(26005)(6506007)(7696005)(7416002)(2906002)(71200400001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZnlvWDbLgirZkEIL4NxVuAxxcILWZEHwAMsyOGBxB8UKl5uw9ibzYvXw1r?=
 =?iso-8859-1?Q?NV42voxza/x9o/HOBtsASCeFrxLAgxkZodQnkTB2m4UFmh7TDAc1RMx5jS?=
 =?iso-8859-1?Q?iJe2svSYJu3Oz/WQ5mxCvNUckgx4AR4+ksK0GN2LZjd9zvCP2GfWHKuCB1?=
 =?iso-8859-1?Q?Ked6uwNW986Fhtm9b9AMWyLiSl/fc9MVSMhAMal7IRw7RG+WskFFEnAs2M?=
 =?iso-8859-1?Q?op2sc/olHxL9EsAAMqDbhJ5Q6lOJsvtXfPxWKeM8cqIA1bhP0QFrycBxpJ?=
 =?iso-8859-1?Q?D1sht2HqbkOGEfx1QkBxGPk5Sxv/8ARsMG0RmSjj9/6H/SIYGkkcBwQ4zd?=
 =?iso-8859-1?Q?35vPdN7pivVmnOnWomeznc4e0usx8Ytq2Xwk+DuE0UtSEyAO4FOV8oNQLc?=
 =?iso-8859-1?Q?qgaFgaDeQDxWf7R37W7hy4mW+AFMUUkGxwlUwGj6WkAb9Nzx0JEaBdZneT?=
 =?iso-8859-1?Q?2ofolGJ8uuXC4Jr/UYu9zBgRxgqNIpEHOOikuMqArut+txHyLAvBm7MSm1?=
 =?iso-8859-1?Q?FnCutUexYOyN8ig2eG8JPB5sCtkJLY0dgcoag1EtzZqlNnIP8/0nPIlJtZ?=
 =?iso-8859-1?Q?kAhZwsDCawaXY9p2kgVZ2WnRhK/IUW9Mpyn2OqB3R+Ba8/Mql4/1x4wV0N?=
 =?iso-8859-1?Q?hG7tHzSAp1oC3nwEMf2NSC86TBT6H0Oc205sC4Y47yRNP/lPX/g1jxnOFQ?=
 =?iso-8859-1?Q?d1oxxNO9EE+dGAsk/Lk3s79f1YOpAkn5I6KFOMEOwe0CdFg2UAtddtKXL8?=
 =?iso-8859-1?Q?5/9HD46ntrnd8Gv6wkvOLXzmeo0HToKy6zowElhpUTNCF7CzkiLVsl5qFz?=
 =?iso-8859-1?Q?WiFLkL+crKedPeY5+nVYl24FksIalRQJGRJOLnbI8DWTwgXkaReHXQTwa4?=
 =?iso-8859-1?Q?yIlmglHN7XB/c3qIyYufwY0/S54OfgsFmG20g3Yrz2gPa5tjlvShPsUys1?=
 =?iso-8859-1?Q?8yijx5cypwV1Q9WiHBdGi9MYjDakSJe5HSSbtvWqC/+hgdX3ixT1Fm/kEm?=
 =?iso-8859-1?Q?Anwv7adKTfKJ91mDatc5r/dUIvoJ+Y6ETBUwqNWoszI60ZvQQhmtMtCrQY?=
 =?iso-8859-1?Q?/AQdPzhuB2m/d2kWCTqSe5IKA7nCwErz4rrT2ZJGVVAmEHcVztxZmIVyED?=
 =?iso-8859-1?Q?YMvMIpkTpnf8GL9sk3QjxFdb6MrqJikppUqwi4Z9P8xH/N4F0Q/qPdEGpb?=
 =?iso-8859-1?Q?2CpMw+YTcaQksesZtQT7+5RFx2lp4P1y+jOqcs1X+A6EMLxJa9tLrot3WA?=
 =?iso-8859-1?Q?r7DRzurdWmjZ9dlhe+xGhvRD8eBbuoXhQ6/rLiWv2e7EnPW++ibE20BnOL?=
 =?iso-8859-1?Q?sD+lm6nGKOcjGeW0k4VOE6soeKwe5Hn5MsELAK60N+9wq0c6+n4lur4v55?=
 =?iso-8859-1?Q?3ZMIpS6C/05oldTFxf27qIuAwDwk/oyd/9T+okySV4NWNDARgyq1n57clX?=
 =?iso-8859-1?Q?YUCSnzUhNnvYccIDWKYM6MiP9p1OMHzU+S2sQcvXRgWFpKlpkpKmhBBwtf?=
 =?iso-8859-1?Q?oghOJNPIdSUirJ3bA6q+E9YkrZo32mFTh4klMoRsCoPYSQ6K0SXlBXx4qq?=
 =?iso-8859-1?Q?lhdp2rn/AgFExvsgpOBlOsjW2kbowz+RlIKCHc2UVEVR/IHmdH99xMWC8d?=
 =?iso-8859-1?Q?If/eMogjZhKeA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c146d85-92d2-405a-2843-08dc05077d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 05:08:10.4521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nky/6Z+ha+XtYZ8ZLXsG7V+7N1NBQsV6HKcy8sVumOtjHnUDQHBdvPayfkZ4CYnEFNCwXzxCWJjr1I7ern0ICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::624;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.594,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Thanks Markus for the review.=0A=
=0A=
>> Introduce a new acpi-generic-initiator object to allow host admin provid=
e the=0A=
>> device and the corresponding NUMA nodes. Qemu maintain this association =
and=0A=
>> use this object to build the requisite GI Affinity Structure.=0A=
>=0A=
> Pardon my ignorance...=A0 What makes this object an "initiator", and why=
=0A=
> is it "generic"?=0A=
=0A=
In ACPI 6.3 (https://uefi.org/sites/default/files/resources/ACPI_6_3_final_=
Jan30.pdf),=0A=
a new table in System Resource Affinity Table called Generic initiator Affi=
nity table=0A=
was introduced to describe devices such as heterogeneous processors and=0A=
accelerators, GPUs, and I/O devices with  integrated compute or DMA engines=
=0A=
(termed as Generic Initiator) that are present on the system. It is used to=
 associate=0A=
a proximity domain with those devices.=0A=
=0A=
You may refer 5.2.16.6 in the aforementioned link. This patch implements th=
at=0A=
structure (Table 5-78) for Qemu ACPI.=0A=
=0A=
>> An admin can provide the range of nodes through a uint16 array host-node=
s=0A=
>> and link it to a device by providing its id. Currently, only PCI device =
is=0A=
>> supported. The following sample creates 8 nodes and link them to the PCI=
=0A=
>> device dev0:=0A=
>>=0A=
>> -numa node,nodeid=3D2 \=0A=
>> -numa node,nodeid=3D3 \=0A=
>> -numa node,nodeid=3D4 \=0A=
>> -numa node,nodeid=3D5 \=0A=
>> -numa node,nodeid=3D6 \=0A=
>> -numa node,nodeid=3D7 \=0A=
>> -numa node,nodeid=3D8 \=0A=
>> -numa node,nodeid=3D9 \=0A=
>> -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=3D04.0,=
rombar=3D0,id=3Ddev0 \=0A=
>> -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,host-nodes=3D2-9 =
\=0A=
>=0A=
> Does this link *all* NUMA nodes to dev0?=0A=
>=0A=
> Would an example involving two devices be more instructive?=0A=
=0A=
Sure, updated in v6.=0A=
=0A=
>> diff --git a/qapi/qom.json b/qapi/qom.json=0A=
>> index c53ef978ff..efcc4b8dfd 100644=0A=
>> --- a/qapi/qom.json=0A=
>> +++ b/qapi/qom.json=0A=
>> @@ -794,6 +794,21 @@=0A=
>>=A0 { 'struct': 'VfioUserServerProperties',=0A=
>>=A0=A0=A0 'data': { 'socket': 'SocketAddress', 'device': 'str' } }=0A=
>>=0A=
>> +##=0A=
>> +# @AcpiGenericInitiatorProperties:=0A=
>> +#=0A=
>> +# Properties for acpi-generic-initiator objects.=0A=
>> +#=0A=
>> +# @pci-dev: PCI device ID to be associated with the node=0A=
>> +#=0A=
>> +# @host-nodes: numa node list=0A=
>=0A=
> This feels a bit terse.=A0 The commit message makes me guess this=0A=
> specifies the NUMA nodes to be linked to @pci-dev.=A0 Correct?=0A=
=0A=
Right, it could be made cleared. Done in v6.=

