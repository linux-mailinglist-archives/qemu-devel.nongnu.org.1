Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418C823AFD
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLE3D-0003m3-QD; Wed, 03 Jan 2024 22:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLE39-0003lW-D8; Wed, 03 Jan 2024 22:05:39 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLE35-0001od-PL; Wed, 03 Jan 2024 22:05:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRiZkjNwT5WObdWP14gH1cnsghPaw7zxagE5/peLoIvVprugbigkXoBHWKEZ8EvDUyk3diI5rpZywpbiQ5FdG1VYCkmhm8U9UE01huAoKVBq9tmFuOWdveKUovGyCcfv/SdDSsgGvctGKjVZCi6wN3Zkm8nB33ga5Y79Sp6K3G3omtr/y6Jx6GDmeiXFBz50Fmxc1DIXSmUoZD7ZeZK6WcjYJL04hMhQnr55jlZC0d7rcN7MgyzL6/s3ojJtwwc8gxzTZ50J3dGKyTOtOt3YHYFvOFKU3s17giLP02ZSf/1xVxdzW03vnPJmmyw7Zo0W0F5V+Pjo7ayqDOpaxjbZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac7LVf5fqOc/KlaLG3HoSwCaLil046PeX+8sJ7uX9YU=;
 b=PSFlBKgY3XRZlXEeoDEX/Yt3XevtSTBF0SJGfxZjmExE3BJ7a2idmWM4pyFgwL53ALxjY79LpjRakbORKFRl2nsNgdTtsjeGEEOLs1R4vCuASwu4Xl7kD2ABTV/Kg2ap1wI7EZ42I9aM81juDfIy2ykP/rjo8wTKGcoSqcRIFXowFQIv1aYKjyQa+7m6/02rXrG4m2DhAs5Zp7oy5CJyiaeWr7Klp6O8jhppZmmxCPDucQJg/T94gQEw1S1v+O944MUd4EtjxQOApFH5tmKKMe0g4GorZMq2Fmm/RXF37HsCEX113cDfTTKjabWnjUAHjV2vCSuRjrpdgc+/5hDxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac7LVf5fqOc/KlaLG3HoSwCaLil046PeX+8sJ7uX9YU=;
 b=YYZkjPQlZnb+FxQJrwPlHf4o7DcR3bwDwVj+Kq+/XiPPYfpP1gQqryNT72S35MefiI0kQN1iSPlciloVhC7tXjwwxmKivQuaw/V7rVXBUymNyeDlF1RNHvIp3cHqOKEaFYok+GiLUr3WRYzhr+pQu6Ai6jJV8+DstkcsQJc7ZFlMNsNnTLv8QOp7oL8e0ikaHOKdAGrmj2B4P16ebex9qt5r7g3p1KBzwL1RoVItSTt/WQ4MBf7lG1+Qt49LM9b28sm1OxE2wvnDKbHahQNwrHse+dDor0CeHNGtonjzlczF5+PkGieoL2TchZ6M97XTovWMAq5ZspjW33oXvi6CzA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 03:05:27 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 03:05:27 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Thread-Topic: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Thread-Index: AQHaNu672iZ2n2fqDk6q3KiBRYyGcbDGgWuAgAKGIYQ=
Date: Thu, 4 Jan 2024 03:05:27 +0000
Message-ID: <SA1PR12MB71990557668BDE5878845A8AB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20240102123143.00006486@Huawei.com>
In-Reply-To: <20240102123143.00006486@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CH2PR12MB4071:EE_
x-ms-office365-filtering-correlation-id: d5d0c231-b3a7-404d-a0c0-08dc0cd2008f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8P5aVnlEZEpKdURJs+1/t2mU3T/O+p3JNWbrRwWzmTgZ6UOzDuLdQgslVN0LZbPov89viU0SlPIYumLkSDMH/mF3jYGOhodXXkSUeJzF+zJwjtSQf9BRag0L0E4CwTpKWDHlOgb8WqRLIosJO2sPOF87iFqEhBa0m9Jk8+gHCn/eTqMedHbL+o/+ZAC8ju5exxiBxef4c0IvcZOFnNCA6wYXyII4pjPhaO5YvnO12Xk5qu0holADRNjup2AseFe/CUYk7rmIT9v9l9YYUOcErua5Bfc9rI7o5U5ZRBhho2AbxSNQlWfI+dDti3sv0yi7Tfc+xrgjC3bm0lV8EJTdjuDqgJEx8YHKfshCZeW3XivsHVnn7+9jj7lviOsRsiA3uOb8zUfUKTSWM7o43XkfFaUHJ0qlWStLrUj3G/PaA8NVatflu/oK75SP4esP2JUZROVyBQGRhOeGi+iAZrmgseicnQ1YAsSbhE+k86wP9LYEkSH5AB+xdVBYVSk+DL01CstbAR0/tXFre3Ev6j1jSG5LRufntTmWateTqCZEpO3WgWJrbt6Z1LygqbIDzD0CL9siXLhxeUTXUaeh1m7XzwJdvjpwoxTkr0xYlPdstB4EP7fO/5I6jaVw3GMUxlZo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(9686003)(122000001)(38100700002)(38070700009)(86362001)(55016003)(478600001)(7696005)(71200400001)(66446008)(91956017)(66476007)(66556008)(66946007)(64756008)(76116006)(26005)(8676002)(6916009)(4326008)(54906003)(316002)(8936002)(52536014)(6506007)(33656002)(7416002)(41300700001)(2906002)(5660300002)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xDUFsPghpqcH1Vp02i4NNjHHVf0rE//d4j/Hhuyf+oVwIcijZuscKQouWN?=
 =?iso-8859-1?Q?wROt+ovV4lxNWkg5lG90eAIgWaGRdDhKDNNOmd8DXCa1Oy14HpfWrtNaTN?=
 =?iso-8859-1?Q?G0J5Ug0ns87vnnkeQZy6PzPgxpLjs3EoTmVvnrZQf6sgZa+WLPoK1Mjqq2?=
 =?iso-8859-1?Q?vr2ba+p39ZpCKEWPaYbEJCH4MFWyOHHlVFc1yd6oSz72ngjyuP+EiUmSg0?=
 =?iso-8859-1?Q?Uw7ZyF8UWTU15wPDrPxI+sKD1bhFNQnJ5p25j9gwuYUFW1xZiBwtks1G4G?=
 =?iso-8859-1?Q?ISQ8Hv3RybZtNxoxvFa+NG2vuhIc5PsAI+fhzYgD7KxnB7yeXizbnF7dwi?=
 =?iso-8859-1?Q?JO37RqKKTFnaKvml3ZR7iFcb9ptyCe4TqkKkjmF2zbs2We7pEB6tCRXBQU?=
 =?iso-8859-1?Q?oGVe0FDjf+I3pKfYoYBddvRCPRRluXqoiukluHCiMUmeLN+1BcpM8V+7d1?=
 =?iso-8859-1?Q?kj9UfIYyrOR8C93JW/TMNVNFsdtOFHz484l+0lT+NmNGSt8CoCXesTnnac?=
 =?iso-8859-1?Q?KcJn54LZLzzgjy01cxKnTAJ0hZEoAQGs9dXz9UhTuZ4Vu72/Ea+/GaCNaa?=
 =?iso-8859-1?Q?wK2DlKXhnl9Ie2DOt3o1umdu7vYIJILh4219eljXNh8jRzKtS6f5gSLpYh?=
 =?iso-8859-1?Q?l+9imeNi6bLIdTnrpMpqPYfYFh9jIAqpVN5PDSdWpTpCtDvXPk/AsbQZPK?=
 =?iso-8859-1?Q?4Xn/8JwLdNCpmSIuSPixSoWnHC2pDJqdYU3KIBqkE4jIT0gsvAObEPdPJB?=
 =?iso-8859-1?Q?muHNEdwPg7PxMNytGW9lhFunAbzgxh+k3eNp+myhfsPvHUn3TWU4iMF8aV?=
 =?iso-8859-1?Q?Ovue+jIf5xVF9RD5YZUcRxcjcQWMJ6pVWWIOLoN5DrwGdQ69baPOEJ25fe?=
 =?iso-8859-1?Q?kj0O4kx/7D7J0i9D2hzgUIWmvtJE1xZvJIA8KEh413RYDGxSzgugDaJqnB?=
 =?iso-8859-1?Q?UKR8lX/OeNw39DWjSZ+0ik1vlHVMTRArTKz1mIZ/tUpzv0GdLrfuHpt3r9?=
 =?iso-8859-1?Q?QU+ALPuo90hXoaSpw+Od5yMnmPAXPtU7SzRKvVOAGMBEL1HDn/slMrm+1P?=
 =?iso-8859-1?Q?82e9IwFmoX9sdLxpcYSSQc77tgOG1aeRfpNY/JQa05FzRcamhrvOXbExqt?=
 =?iso-8859-1?Q?EkfYOdBEnMjAXlqdZd8eFArtaI1kO00Y8nH+emjWf11KVN71eJIoqT9ci1?=
 =?iso-8859-1?Q?jmOVZdjoOeA1RglinMguA9+UBehSVaEZ+iAeqQY7glTXT3JMgz8tfsctJN?=
 =?iso-8859-1?Q?Th3sLslZ6FFGvQC1h5HrhQh0r7MoB51O3keSVR5QggyJMDYy71tVqEt6Mp?=
 =?iso-8859-1?Q?VTy1LMzsfw/58gxtVQo1UD9ANNOgjpOvsEI/GBECCwM9ZpMheq49W/cn3A?=
 =?iso-8859-1?Q?RcnZhlfHaEnvEuimyVKfSHfEGLNFNYrtwHlMoGYWx9x/6aU8bUMJluiWlr?=
 =?iso-8859-1?Q?iWTwH7RYKN8YlvcLkbecuSOYSCJcFYcTflmldYK0Mg7Y95as88l+u8np16?=
 =?iso-8859-1?Q?9d5quZYfxq/PE03sssND5fBLOojX5nAxOD3ZhWZ2QEXaCeO+ftiQogG+ct?=
 =?iso-8859-1?Q?HwhzinR2a4vflcl0N0eKMTBkSXta49IF/22S7AVYL9Xyi6H+cclvEL/cpm?=
 =?iso-8859-1?Q?ARQ6SW5MSzyIA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0c231-b3a7-404d-a0c0-08dc0cd2008f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:05:27.1706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kyrQqEp/dtkHd3MuKLPGN9WHp2goSP/Z21gr9LSmw5zyU1QYg64J81/FhY7inxyYyH837fdZvuKqyKR6dNOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

=0A=
>>=0A=
>> -numa node,nodeid=3D2 -numa node,nodeid=3D3 -numa node,nodeid=3D4 \=0A=
>> -numa node,nodeid=3D5 -numa node,nodeid=3D6 -numa node,nodeid=3D7 \=0A=
>> -numa node,nodeid=3D8 -numa node,nodeid=3D9 \=0A=
>> -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=3D04.0,=
rombar=3D0,id=3Ddev0 \=0A=
>> -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,host-nodes=3D2-9 =
\=0A=
>>=0A=
>=0A=
> I'd find it helpful to see the resulting chunk of SRAT for these examples=
=0A=
> (disassembled) in this cover letter and the patches (where there are more=
 examples).=0A=
=0A=
Ack. I'll document the resulting SRAT table as well.=

