Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E267CC5CA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskuR-0006C0-CI; Tue, 17 Oct 2023 10:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskuL-0006Af-1k; Tue, 17 Oct 2023 10:18:53 -0400
Received: from mail-mw2nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskuF-0005O8-2S; Tue, 17 Oct 2023 10:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPR3Vf0OUi8grmbz2Ps2Q8hEvI44ZDcTiGxa9I1vLXghRPYdCncd1r9qqv56BKCvECA6GENuc/qnAlni4M0k3cTKIpxvftWD9WXHXq5kZZJII/Kar9+JQEuVKrwBX0OkkJNO/4o2BfxB3m7+UKAQR9Sqd/TQCC1bHQZNSFv3ALDVb8CnhimrCjmh0v3I8iPaaPoUt1y3dIViJUPbF0rcXnKoWUi/6bU9M0pLNZx9ZOBn9PbMtihWxpe4h83sgKFMPtMtCaOEENW0Hf2sreiCdKRzZH0o6FG6V1ylEiIIJPD4Y8wvSVYZ16eb4BoIKR026QeNa9pBXKA6v1FGNwbBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa+DHl9tkIYt58Bz+8BCwxNLpC9do3i1tQrDPucvOxE=;
 b=B2/L1WjTqoatTKUWaUufWhDCwpXyHIDpgBYGMka5fJx+ZtEWwZ9TWnXm6yqSKvod81tqHidq65HtnRviXNLWgIUk6x1F/L/6e+NzxKnOJtgfW6ARH2SZSpHFvLrYJUM/Gwz4pzo1PhKNTVPPtFBf5W3NGbB2XAGJWxHVlMZkaEgK2c5BSv8x+pANxAe3Em/b4rNBmx8XOMt4sv2rO6u7impJ8nm7uc+Q+mbom6JVLbkJEkxcx2pcBGMdhPgoxS1+gMCWdiMavpgjkTnBSI8M9ihXdAhvGVACTU8TYvb4Y7AH0XEVjmgg1OG+EtFQaYVg1sn0b4KHS2h3kTlXaMTnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa+DHl9tkIYt58Bz+8BCwxNLpC9do3i1tQrDPucvOxE=;
 b=Zh6CnXmc8l6TJ+keU1wycSheoAyQsQhSCr6EN+fC4GWKXZF6YPhXjgMN3Np91uWiLU1mUDTZUNH6Aj20KyuW4VvGliINKSQYJ8Mcm6MC4uPtgVEX3ZGJtcw1ej/Vn13sZKTM6jDa/4l/uzw/T5kuHM1DSeoICY0x6RsWlDH0BGv2C6mL12Qnfr28l3/tc7dtUCoI2kVOBD4K8rVldbodun1VkcdkiB8ECqMZJ9e65vhKHiUzh+Y8C308L3bEKdW7hoIZleikLJZrH0bmCjbZ/UyuT3L3Ua8R/vNxtblZj74MRzDI3R09QjH3aOgk+aNNvnWLLFl09O5s9oJzTV3khA==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:18:39 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65%7]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 14:18:39 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
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
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Thread-Topic: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Thread-Index: AQHZ+Vt18QX6bvNz2EmmGfmD0VHJcbBBZiYAgACV+YCADBYYaA==
Date: Tue, 17 Oct 2023 14:18:39 +0000
Message-ID: <BY5PR12MB3763565FB32FBEB5B17DDD89B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009133048.00003535@Huawei.com>
 <20231009152735.658313f7.alex.williamson@redhat.com>
In-Reply-To: <20231009152735.658313f7.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|BL1PR12MB5899:EE_
x-ms-office365-filtering-correlation-id: 6a8e541d-1780-4f63-3083-08dbcf1bf5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w97CdyDixxdXDUykNi12N5qsS61o2ebwBz3Y6w2a6Rx6rXcmVQKj0jG8rFD/Lhdi1QgGUOMtg+Oe9i11LhNdnIQvtnUWiv6OGUk/J/DKFuIjY81C4TWpte9rbjR66PH1w2tmsZCm+dkgqzT9k4ep6wvvskMbN8jdk0kf3wGCqrOngRNLDYnffvikxOG12yO2zWweTeIP2V/Bj8ISdWCrLAoiI24yPdCLrnKU2GEtp5j9Q78wi3XxTLX7D6z/m9El2zS6UKfSAE1ENWbRVdDR2GnRFznkonBU7jlh7yQKWSDjqlPVa4itlpmgiPcnWmHui4juOS8y9Aue2DUvSKduDw/xnxzofOPwi5mmAhTmlX7PWpWWuhiDb9asIVvUR+LZcD0E4958wRUXbxAVEPh8OylE4t3dKMvk9SO1NiYfuS3R0/GhDG4YNrVB5gKFQfLKgoT07UoGLGjw6dqHgZ/qZgsbbx+M7na4Co/W8QdiGwtJRMGtSFlUQpsU/rvUtcRpdNxR+fmV3VuSizYFcZShOya3enlIQyxFXudksSmBk/4Yr6YftwaXh/ysQa0mCVbJaZZ7etoj4fd5R6gmi6KWo2H0CqCO7siNh6SqOcLmV6jDgBbT4JwhJdR1mZsGgQnE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(54906003)(66446008)(66476007)(478600001)(64756008)(66556008)(66946007)(91956017)(76116006)(110136005)(71200400001)(6506007)(38070700005)(7696005)(41300700001)(26005)(316002)(5660300002)(33656002)(8676002)(7416002)(8936002)(2906002)(4326008)(122000001)(9686003)(52536014)(86362001)(83380400001)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aQFWA3+fdbGB1Lpdce8naPZux0ocHPQM0SFXDORv+4H80jwFimkV7Il6+I?=
 =?iso-8859-1?Q?TMZiR6uUzl8d8E6X9xX3D8uTe+3xh5n4IryGJJZkt+zckoh1w3FhiS5nmi?=
 =?iso-8859-1?Q?U/1G+mGZGW+d/xpQWWxHlbHvHLuFaJwSADB7XRn0S/69KG++otKSvZDChS?=
 =?iso-8859-1?Q?fsrYyaVWposa2h6+EeJZ7fpOXwMQ1TsX5mcirn3LPyXJ+v66zr8d5qB5m5?=
 =?iso-8859-1?Q?544fBT5HlUzMBzgJSrU8VG/yQ7gbai3XDb2pxAdqYuy5fSzXFyg3TYi+uh?=
 =?iso-8859-1?Q?0mUVuShtUjomMzRDW6OXEJXIpVEDta01026FRSHWZ3v3AYZeKV1h/FdT53?=
 =?iso-8859-1?Q?vEVr6t+3Y2GKQ2G6UgigKQdgLt5UuKxcZDf5JvAAPR07mP6ufieQ46O/5t?=
 =?iso-8859-1?Q?nfhQSBTzxcS5A4TPfZuiVSPE0S/8YCiqh8JJ+0YLY6Om92ourDD/8oP7Yo?=
 =?iso-8859-1?Q?yKwAPgz1U3ZAGTBFrfjuP0ArqyXWHLZ2FcVtp0UgtyfhxoAnN2fm5JjXs2?=
 =?iso-8859-1?Q?W58xpa6lyjalDuRtkSIhYIj58r6cVHzuLe2EWxkQnmL1xuYjuDT909MyEJ?=
 =?iso-8859-1?Q?C5sDZqjFKPP8MrVsa5fWitSSjTSvNvpzxzScuKfTgbkD0R3b0RltRuKrIr?=
 =?iso-8859-1?Q?wMoIQvLL9zenH7nu0A1NU8U0cwvW5CrtQjv64Ch/Fpi+rpPEa7zHjzuY6y?=
 =?iso-8859-1?Q?H1Yt6NQyaeoNJTjJaOlQn2A+2Z4h2n1TbJLS/gCszgM9VxMpndsiSi60N5?=
 =?iso-8859-1?Q?Gfd/XbCM9MZ8mBF2xUqqh8Yzgl9QNzIEHmTVPz/lY/GmHVXg6iwWPgjMFj?=
 =?iso-8859-1?Q?azXGf0Et23jr9VhrhKNoyE/6A0JQqHEJed1yxheN1iFmmh9+IKvFyQNQNW?=
 =?iso-8859-1?Q?0i3Ot1vvHwI1Fw0sFQh6Ef0JqeH01jU6jy6jEx+j549ydec/J5HPLy2/2/?=
 =?iso-8859-1?Q?XG1QB//eWue3sdSyaqYU0M5eo7HlQ0+ocCNxKSToK9ETn/Kx/jziLVZ0JW?=
 =?iso-8859-1?Q?ZQoweC4hnz1TDX/2IO5qITo1B19hleVGbLvefHgnNxtA9lTeyUoNNzP5Ey?=
 =?iso-8859-1?Q?SHXDDvhcqyv+vXHBU9xYFN3Y4Dyjc/7Txig/NlKY+yqV8nmK+oH9LzknmS?=
 =?iso-8859-1?Q?4lpKq+Ryrp1ROSd1z29FmZ8qbgb59sCvZbIumNZ7PBHYrR2aGpsd/pYumU?=
 =?iso-8859-1?Q?K+lYZpPdxizcRH+qyZzr3E+KIzAEln1eOdnl05+49rX2np1AYk1RZKMonH?=
 =?iso-8859-1?Q?lqffxyPbcnn+IX1cHPUpWcRI8YlZukzBcwK4cIhNBmHuuVg6pGdHLh/HRV?=
 =?iso-8859-1?Q?GxtMfGn8c46e/Nh04gEGBpEKDVZymCvxCDwf+7dPqJtWMQV5GIa3trlGg6?=
 =?iso-8859-1?Q?7Ux8Hyb8Wt2OqpCcNv7M9I07SUNvwAlUfuD5fggCx7uwZr4xfpKGkLpPNd?=
 =?iso-8859-1?Q?yWmSbTmKEwdRNcVakFRKsNyeyQdqtUPOQFhpAJWMABmX2l/F497kyMCQ8p?=
 =?iso-8859-1?Q?w2UJpJdh2M7Qa27LWsCh/XE8hfOAU7FEQ3zzePMz8+dp4kTiji6uDgqYPR?=
 =?iso-8859-1?Q?FYmglNDKYDj/e8CIDmtL0FJtKMar97rldhDOxpuMfsjO3EzCamC7VktLu+?=
 =?iso-8859-1?Q?FflTrmjTKnARM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8e541d-1780-4f63-3083-08dbcf1bf5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:18:39.5804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMcSXr+uMuW/eEmHLPmm2hyiGhipFA8IVhFZRluNhjKvNRgLVGUGLxqP0WrjRhETPuel9Wqk+kc/OmTniLNYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
Received-SPF: softfail client-ip=2a01:111:f400:7e89::60a;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

>> An admin can provide the range of nodes using numa-node-start and=0A=
>> numa-node-count and link it to a device by providing its id. The followi=
ng=0A=
>> sample creates 8 nodes and link them to the device dev0:=0A=
>> =0A=
>>         -numa node,nodeid=3D2 \=0A=
>>         -numa node,nodeid=3D3 \=0A=
>>         -numa node,nodeid=3D4 \=0A=
>>         -numa node,nodeid=3D5 \=0A=
>>         -numa node,nodeid=3D6 \=0A=
>>         -numa node,nodeid=3D7 \=0A=
>>         -numa node,nodeid=3D8 \=0A=
>>         -numa node,nodeid=3D9 \=0A=
>>         -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=
=3D04.0,rombar=3D0,id=3Ddev0 \=0A=
>>         -object nvidia-acpi-generic-initiator,id=3Dgi0,device=3Ddev0,num=
a-node-start=3D2,numa-node-count=3D8 =0A=
>=0A=
> If you go this way, use an array of references to the numa nodes instead =
of a start and number.=0A=
> There is no obvious reason why they should be contiguous that I can see.=
=0A=
=0A=
Right.=0A=
=0A=
> I think it is simpler the other way around though - so have the numa node=
s point at the=0A=
> vfio-pci-nohotplug device. =0A=
>=0A=
> Why not something like=0A=
> -numa node,gi=3Ddev0 \=0A=
> -numa node,gi=3Ddev0 \=0A=
=0A=
That could be one way to do this vs the other suggestion on this thread to =
provide=0A=
a node list through the acpi-generic-initiator object.=0A=
=0A=
Just that the Qemu init numa nodes before the vfio-pci device, which could =
affect=0A=
our ability to fail in case the user provides the wrong vfio-pci id.=0A=
=0A=
I am fine with both approach. Will implement the node list option if there =
aren't=0A=
any strong opinion.=0A=
=0A=
>> If you go this way, use an array of references to the numa nodes instead=
 of a start and number.=0A=
>> There is no obvious reason why they should be contiguous that I can see.=
=0A=
>=0A=
> Yup, I was looking for other places we allow a list syntax, I only=0A=
> found fds=3Da:b:...:z, which is also used for vhostfds=3D.=A0 I didn't fi=
nd a=0A=
> property beyond the string type to hold this though.=0A=
=0A=
Maybe something like 'node=3D1-3,8-10'?=0A=
=0A=
> Right, a uint16List should do.=0A=
=0A=
Sure, thanks.=0A=

