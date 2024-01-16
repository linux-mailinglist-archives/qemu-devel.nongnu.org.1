Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73482F034
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:04:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPk1o-0001SB-Bf; Tue, 16 Jan 2024 09:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rPk1m-0001Rs-8i; Tue, 16 Jan 2024 09:02:54 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rPk1k-0004RK-AV; Tue, 16 Jan 2024 09:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhWt90jH5w8xedWwJOr/4JCQvJNULnkBeTHY6ORo45QRyojLZoTTd1NHN+g6+8zFfQ8XlsHL9dEkbphMlNP6s3z7FeaM0htWRvpl6Z/3CQWIpYVKpyDzuhIHPjoXkPiK0EjGiwYzothY3/ia/AUTmrSMSjtGNzLj8DDiBd6zUL/6po0Tcprho6Mf49YjdqixS4kYEj+nDjWF/3cygIh3tUJJghJkcchmq9zk6iurwWW7N9OTbU5gZvdYJIJmk1UrLdKl35SFeNDHCASuwrZNQhyoNifpvMncwwF2zp96I5Hs0/+mXybjjYl7OZRlqZCZjaWdEPfl7gaZBJM87qdSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlfFoLDVrGY1tHdVbc8NFo0J2uhkmyhPEAwgRVRrnWY=;
 b=bXti5PkofSRMJKclXKGyhSk+JiSgjFoDRIlMlFte4JlM2ZcURlLzVWfz8EIKBaGuMH5mCTGXJ2EXaaVQczJbtP7KHo45OyRsOpzf+efvX/L3h9DcSjCtytAO3HsjCc3Il3IRF+9MTCaFpgtJT9Mkh6TGPMiIVq8dYfEnDCvZx9IgEp1f7rHyc9RKc38Ev6KIp9LQyKWxCJZTm8mK8hYS+Z0jdQm3HbULo2GWDwHvCD+oBL/hveEu/LRhFBPZpoGMwDLdtLUHFwe3Epocde9/flLu52uZXs0qxX5aNC46AoxP5bYE4XiTonal9z6TSkZnfmGlXroy/2DTcqRjRw0a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlfFoLDVrGY1tHdVbc8NFo0J2uhkmyhPEAwgRVRrnWY=;
 b=gBZ8rgVmfsMmLEhrhFc7y2xO15TBTwxeHNZvUicxsX2fPCrXN3el4APDDpnExJ4qq4SBxP473J/2Cxuqj1fGLH10ovGa05uJgNhXmv1hyuyxoQnYoWSR1Tq4uOs8qlv8RRRKANQ2kAu1FPWSMjpf24A0vwfJ3PYPj+rd+FojTmd519M4vYVexynq+WIzkfbmoG6kdTp24REr2i7b0ZWtGU97rZ52/FkXRbefWJJuckz0tUwQs1YLqHCP8Ol9bA1o4ziibwOCUI7wQOIkhkonod/aqym8LtNiVCt3aYbyBYhUV6wgkysKsl6K2NSTZ8dmG7kw7GBiPB0JPZROUqdb/w==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:02:44 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 14:02:44 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alex
 Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun
 Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDGiNyAgAKAsMCAAODhPoAAEbOAgAfOb4CAAAK1gIAB+62AgAjOyA0=
Date: Tue, 16 Jan 2024 14:02:44 +0000
Message-ID: <SA1PR12MB7199BC49E8C15630B2DBC7CCB0732@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
 <659f25e98bbb_5cee2945@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <659f25e98bbb_5cee2945@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW3PR12MB4396:EE_
x-ms-office365-filtering-correlation-id: b7455dae-1977-400f-4c8c-08dc169bcfca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7m55s9c3W6oK6/Nr3kmSs7SLRImrJYAuWaUnGCtD/UKFCSkDm4Vh4BwkgKTyjGMufk/Q+uUh97UoMgnfi3hWsEKQXFVO+EjAJq12QRBJUBmH9gsVICJV5gXPvhDYmxoOx1v0BSw9Es4KfmhCSYYXFUHUSrPi+pTmkbbJJ7LOI3ko7lvx9wFDRWVje+0xkB0gx059ky8GGjTwVd2XJlpFBqJyLDYV86I9jQopsx1uHjTlHrCj7HNgGWL3qyR8YecD2XDC6Hqh39mEdvvKy9A2SKvYP5wHHzV2c3N12U4JpgPCkNrIaj81ZumKZ8NPU5CeT7BhPK3G4EiJDiJNNMv+kkRce1GKmjwBk30YFOkdAMyNoz4ebWpTCQbVCqtXNCNUhVmEEE+AT01pPbdXqUVyfNRmOpqY5xMdSy56kp+VO7ZqX5DJEJT9scaSs+Bt6HEFMWY17uDfhDPq9diurVCRIg45TRHbuIR8mKEl1oY3okcXGXB1g1ns6DQHJjftwdmM4Kgra4SNOV2BWDaiDLbJgHbHAjPs9RYMKzIaXVQ+1lPjuqxc2Vvx9o5IDaxTjAwUw6P5/OXbrSCeY9wku+0uYFQ+f4LsekbpyZhIgtE3XktkTYESUr3KiCSPJ2oGRSN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(83380400001)(76116006)(41300700001)(33656002)(86362001)(38070700009)(91956017)(38100700002)(122000001)(26005)(9686003)(64756008)(478600001)(66476007)(66946007)(2906002)(7696005)(71200400001)(8936002)(316002)(54906003)(66556008)(110136005)(4326008)(52536014)(5660300002)(7416002)(66446008)(6506007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eL1kKAKs22fbaihc/edZHVl+32f9GzxS/3r7Jr/Ur5T6katMuTWABW0WVj?=
 =?iso-8859-1?Q?w7Sijx2vRIW//EgM3kRiK8uqoVShykQciJi9yIJuK6tIVRkBzJZIAnKxQY?=
 =?iso-8859-1?Q?wVh1z9ZxxuZyTkc8eFipT3jDxyhMr4fVgMqxKN44rlQ/2bbMbfoiiqLsG3?=
 =?iso-8859-1?Q?m2U9iBSQstBSlOq9fsiHK4zmipNRjEjlXvYC6ebbd84aOOeC0KK2XHT9SU?=
 =?iso-8859-1?Q?0BGmCCcthc4KuakjKGWM0zRaZSZycZ8JFaH1EznvgNj81LGTi5e1qjdfDP?=
 =?iso-8859-1?Q?qUogL9M/ivHeyt00f+VDgCcTi/sIn2/a0RtTMtM+iSkGBBd9t1BawdOdh6?=
 =?iso-8859-1?Q?FlMztawCW2QVk7LsmncWHC2SwT2yDEj5SxsGHzm9RvRkNg9YqQy1RWlBHN?=
 =?iso-8859-1?Q?SfVVuF/hFR0MCbEyj0Y2mrB/PGlQ2Qivk40ohkkRt0tsR/J+IJlAeeJ/Ut?=
 =?iso-8859-1?Q?aWq9KQT+rJedWlHyctepedyBKfe5Aowem35y9q/UyTSsoscwEoW7B0cOUf?=
 =?iso-8859-1?Q?K9lVPs6I3xGWdBL3BXHJBYzmrWGzxm2f/S1ay1LpUN5+GkmmBSjKXhqrbG?=
 =?iso-8859-1?Q?6cfVuIbqqlA0h/LRDXMIfrGyJe3JhoUVRFYYpOPYaEWT3X/iOHiXUKu4Sx?=
 =?iso-8859-1?Q?VgPXftx6RdEdkGSfe+mnZcU3Rxwyv2q4tnW+qfAtMOJR+mN1b9ZuAVdEk2?=
 =?iso-8859-1?Q?RJkLb+LTYILVJfQZAnaojPMVyfDMuOWbZr+SVIJvIfgipFG6bL2wCV4hXX?=
 =?iso-8859-1?Q?+faBhKO1O6zmlD9S4vU1gTvtsrJL0xso4LmbT/K8JHWMPSSnp1aPh1Y5Ew?=
 =?iso-8859-1?Q?lH4gUZA7VQ1f1CaIRnX7jpjjR1GiHGIHG3oUxwiANEXvmtus9R9gUY9Wsr?=
 =?iso-8859-1?Q?K/SqvrEB7NQRElUCi378vJFPRYKwIVEpmVJvpqs6k5FB5Y8B6KXkzlV7V6?=
 =?iso-8859-1?Q?w9Lx5uhGrA3WopfoVFhP/OndqQGa2q0KP5g2k9Ag6yDM/fhYTE4R0uvRHT?=
 =?iso-8859-1?Q?zO0OKSjw2b3BxHR9/levtK50uvHowrIFWkv3mkpiH8MabWEpqjA54sX4B3?=
 =?iso-8859-1?Q?m2OyyPeDky0fwd9IRsZTS11IRt0tnRcAC2/isRA03bedZL6logPAp+Si7b?=
 =?iso-8859-1?Q?rIY6O6DJXrtjmHNwfu996SOrWjqjxx40G/t+kpltujcHVWSz9ghbSrLU0O?=
 =?iso-8859-1?Q?KMxvq6Pz3Y0W4OHBbDfXHGh5OePTU9uLVLVM7QSuEx7TwtoSdm5yo882k7?=
 =?iso-8859-1?Q?iZjJ4BbJjDs6a3wAnelRZaj69djGKiOAfYPO8SYmvIWq8HGEBlMEjFAyRZ?=
 =?iso-8859-1?Q?gAZZfQaEz67OBx3BCKyJ4y3cCeidHZpioDy0z+NF4vFD8k84DkWnlAob+N?=
 =?iso-8859-1?Q?dN7/yhSHP5mODyP9ZoUDejNNLflvKaJ9DrU8cnzpsXj2QMDOQ7E1FYwz7g?=
 =?iso-8859-1?Q?GQpkaqG8ncLk9I3Dl9kMD1v1S0USinkwSJZvgNvI/NzPW8/aXZpXwMVbwB?=
 =?iso-8859-1?Q?dUU+1DVCGk8ob+HmOjKzBXT8OKbP9vKYEsOGiJEFQBfHwzZJQQs06UyRWZ?=
 =?iso-8859-1?Q?fCEkd/nZtwS1e6hwlCvM4Q9fkYANrRD7BlgMbusGL3V7Jwi9lkP/kguYTc?=
 =?iso-8859-1?Q?bUTM6d4sy2Ge8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7455dae-1977-400f-4c8c-08dc169bcfca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:02:44.1108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E859soS/yOPLXrXkrJE03l6TcQFxfYDqVR97e+X4Fwu01Ls1IQd5sLMqG9XkSXabpW74pW/RHmjTKrkNGl5c5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

>> >=0A=
>> > Given that, an alternative proposal that I think would work=0A=
>> > for you would be to add a 'placeholder' memory node definition=0A=
>> > in SRAT (so allow 0 size explicitly - might need a new SRAT=0A=
>> > entry to avoid backwards compat issues).=0A=
>>=0A=
>> Putting all the PCI/GI/... complexity aside, I'll just raise again that=
=0A=
>> for virtio-mem something simple like that might be helpful as well, IIUC=
.=0A=
>>=0A=
>>=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D2 \=0A=
>>=A0=A0=A0=A0=A0=A0 ...=0A=
>>=A0=A0=A0=A0=A0=A0 -device virtio-mem-pci,node=3D2,... \=0A=
>>=0A=
>> All we need is the OS to prepare for an empty node that will get=0A=
>> populated with memory later.=0A=
>>=0A=
>> So if that's what a "placeholder" node definition in srat could achieve=
=0A=
>> as well, even without all of the other acpi-generic-initiator stuff,=0A=
>> that would be great.=0A=
>=0A=
> Please no "placeholder" definitions in SRAT. One of the main thrusts of=
=0A=
> CXL is to move away from static ACPI tables describing vendor-specific=0A=
> memory topology, towards an industry standard device enumeration.=0A=
=0A=
So I suppose we go with the original suggestion that aligns with the=0A=
current spec description pointed by Jonathan, which is the following:=0A=
=0A=
A separate acpi-generic-initiator object that links only one node to the=0A=
device. For each such association, a new object would be created.=0A=
=0A=
A previously mentioned example from Jonathan:=0A=
  -object acpi-generic-initiator,id=3Dgi1,pci-dev=3Ddev1,nodeid=3D10=0A=
  -object acpi-generic-initiator,id=3Dgi2,pci-dev=3Ddev1,nodeid=3D11=0A=
=0A=
> It is strictly OS policy about how many NUMA nodes it imagines it wants=
=0A=
> to define within that playground. The current OS policy is one node per=
=0A=
> "window". If a solution believes Linux should be creating more than that=
=0A=
> I submit that's a discussion with OS policy developers, not a trip to=0A=
> the BIOS team to please sprinkle in more placeholders. Linux can fully=0A=
> own the policy here. The painful bit is just that it never had to=0A=
> before.=0A=
=0A=
Whilst I agree that Linux kernel solution would be nice as a long term=0A=
solution, such change could be quite involved and intrusive.=

