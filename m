Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C28241D5
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:35:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMuv-000871-6Q; Thu, 04 Jan 2024 07:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLMus-00086D-9q; Thu, 04 Jan 2024 07:33:42 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLMum-0005kD-Tl; Thu, 04 Jan 2024 07:33:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQkiSoioAM3xwSb8jX985sV1HRB1l4lT1GWeVsEDXMnynpTPw7+xymWJ353K6CBVIOn3LGi5PB/4HnDrkJAGFa9+I4ms4oTPmFQFT8z3oRgnoYn8lTYgdRv+RoxxCGSWCk8Y+RlMYQBuHqeAbPhVAuw+MXk4vni5XSkxwG5xBs7Ktf3vY+tCqpridGB9x8UilQ/81ZQda5IrwstcYKxw3dXowwSgv5Txu3ECAIpu1jFa5J/MSfaiwsFnigV56qY4twnIPNaaDc6EybLVO4dVz2hZyHEV4BRSX+2P5PwgG9EH+JkZNenTv/Q2TYcQNThrHXxRrdQThUu2QGEZ08O4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBPVMnWAeShi0yBkIRQGYDF7S9vjtLdZd8S31dDpSYQ=;
 b=SxFuGB5VwdJhr1KJ900R1xbY8G0UNTIY/6RzkR+f1XxomklmRieeKL5u2gaTgJah6WYrRW7HgvbmKnO8M7IrEMM38bp4lMsibxelQcvHw42kSqEEo3hUpzA6WrsHyXA0DU9Cf7u7x4/hsHMoEHf/1V2zwutRKc1IBfiUTzDShsMa7NkqlbZp4jlwlUQiP3DS37JtBpNdpi+ZE9eHz62dnUwyrUR4vm0lotuhJBpnoTUAHDrtuJDaE6sCOtiVbQNYMiNhlWKuzTQ3uKrACH1Wf48MJOev2OtLAU5G916NPug0WSaX0PFaW4ZuExg7g2JB4RwWTmEHqPvFLhldFyt7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBPVMnWAeShi0yBkIRQGYDF7S9vjtLdZd8S31dDpSYQ=;
 b=D8pGBHbzDoEkLAD8Oy5WTxYD5j1TURzoHoGr6/neMvAf/hwvOtU3RZG9LCOpH2swB8Lw9Eb1oZB0kjo8tmqigk6vERqULJaEie05AKqXdTBfDoTm5Al1soURqvQgBbMNN1zwNJoQr9LvqDfB+MSrfsM0Y0vj8mEb6ufKPt65MotBkgUd8g3Q4TemHd0M5khdPy0oAov95h4PBBmtiHJWboK925GlYlwc7b+8o8c9GzARZCk3bOAVmkli5GOxIPTejOkl37dd5so2k7+KxnE9X21jr1NlAcveb0XGnAN6mAMg1i0jyn62J8dhsywJtJks9fjRSGicxlOYnPjzwffghg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 12:33:30 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 12:33:30 +0000
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
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDGiNyAgAKAsMCAAJsghw==
Date: Thu, 4 Jan 2024 12:33:30 +0000
Message-ID: <SA1PR12MB71996E4106DCD4C03EC71DCDB0672@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW4PR12MB7440:EE_
x-ms-office365-filtering-correlation-id: 16b13587-b89a-4d9a-ffde-08dc0d215bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sr+cqUtL0SAGBulBAGQskpGRbQBC5oxp2dvDGch3T7rk97hBZx71Et7ilghXOvk4+B3SnkTgg8kdgNWi4O90AOyUXRI2AZD22puiSVhAnJ5WXX+Ehy9JhK2ExLq0t2z0URt/tbbFrqGXEoIICHK72UtG24hmP9jnCvZbMWTRN34Si3F6YRmTvhF+x2wVVOTIlpj3FoLA1qbtwvzhRlExbRsVBmAgH1G6HiBha6fEfKmH7/RBpww4SvJdW195GkjhbNF8gGMQN8Cv5HvSrsQtZrMKpqifd5eNgryoNsaN2sJaWaZe1YsTx9sHTr87BncScj5NP1j8FTMqh91OzJVU9hIlb3T/2clux0KS7rR0O5JVY+33QITflGkr5aNGYhoaOGjIapxGMz+JALc22UWDcAL8+GqNofIYPUsIMr+XoAKR9lZeCGApGelX3KC7q1AuLpfXCFJ9KrDdcSsFKXMHW5clsW/B/4FqgKeQCCgh7hYFCE5hmVEV8w+plXMJPBNTakBCYyjOfu1g6DyxTdGNgtGNgLuHF3IPr5iaIfnBT08SW8q1H+ki9Duj5up2E3g+NK/96M+NuJlxKeRqI6UeVv4qqX7uezqnAwYjGfgYVVs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(71200400001)(91956017)(2906002)(5660300002)(66556008)(66446008)(64756008)(7696005)(66946007)(66476007)(76116006)(6916009)(38100700002)(8676002)(52536014)(8936002)(54906003)(55016003)(4326008)(9686003)(6506007)(86362001)(478600001)(4744005)(7416002)(316002)(26005)(38070700009)(41300700001)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JHQMFNkfOLNxw+w2QA2nbs6e0pVEFxN2IW20RVfFRCCUJF5WUNn8H+m0nW?=
 =?iso-8859-1?Q?j8JCBARsqWTB1/GPL4v93nWSkRwuD0pkMrSHdGAYtSY+fx+/JKgxAH7w+O?=
 =?iso-8859-1?Q?d2prnLpfDmDbAhfdPq1v2K3qQW+3Q2/gSJqxY3DVb0ULJ5iYJ+s/UbWRkl?=
 =?iso-8859-1?Q?f93J3THpJE1wj0ec2iCHegDlt394I5iqclQYcSHGbrycUez9inuj4h/Kp0?=
 =?iso-8859-1?Q?oKmmstzu/30EOK76zhUmtlDTcioBXVFOapDYknLslbk5UNr5ixiPvweAmN?=
 =?iso-8859-1?Q?OH3kkLFlUXn0MggQXqVylT/2A9w6Xq7Gb9UsxLgKqsscol9Ry+0nEFseko?=
 =?iso-8859-1?Q?vtK4VOQ+99AoLq0jkszyb9+royu5kER09hQODdunydLbFZCQ5K01DnuMuK?=
 =?iso-8859-1?Q?Oq3qZoXCj+jWVwex0pwWwYqq8CiB2WtC54DHu8uJkst3wOWZ+tnDg01aug?=
 =?iso-8859-1?Q?HN3zxXpuyfCP5GItV2tXukKY6eXGYmRDaeYfmdG8EX+j+NqkJJ3PKTLHiM?=
 =?iso-8859-1?Q?VG/bHFzn5eVN1R2tadQUcTadXlckjTFDdGO8rYwUpVyF/YtOVuVBjFRToV?=
 =?iso-8859-1?Q?8bl9qdTky8bgGbgDNCTcF5TMjEoS5IqcWCKGejW2+DoDcieKel70XvA1e8?=
 =?iso-8859-1?Q?1XgsSrXL6vffB20QyvZDE2un8eH7pUQh1QI6bEQNNonwJHNCZxgsFmDPj/?=
 =?iso-8859-1?Q?uRjsyj6Z11RfmwudpMilQeYhrH1sBhy77YupKYo3dQrYq46nrQm7VFCp3m?=
 =?iso-8859-1?Q?6SVk3CPBbCSJKsBEwQzTT5yF0BEhAxNmlnI5oIaPavAMA9Qr2HdU4ungUb?=
 =?iso-8859-1?Q?/MN/SjwNNpIAqV18CUApDC8mFtkiK+XpEfdXHDsi69h33EIMsquG/U5Es9?=
 =?iso-8859-1?Q?OhyZjTprnlG/SizFlI6t6FFsvnZouEtDLNgw+aFwhYCLQXBmzOYi+NAaCY?=
 =?iso-8859-1?Q?SGuR9WUGUccovnTFhFgyaZr2eG3MQtvpvievrl9FdX/qt4hm/MN7mt0mMu?=
 =?iso-8859-1?Q?DLvoomzSsYG/9REDem2mk0CGuEyDu3BWpNQv1mGBHdx2AJQK44+1eMA8tL?=
 =?iso-8859-1?Q?6PCNoVqbOQl2c6/rIGx6sbmRV2m91Iw3UbWkPUlInRSdJoyfkzwz+dp1ss?=
 =?iso-8859-1?Q?UxAEmDRdgLQWNPhAd6MXH3k1QmkgCQfrR0sQIjI+UDgDOTa204ghR/yx5g?=
 =?iso-8859-1?Q?NJjsC0z+rzCZBGd+uylD9VgkkJEmV330QLsWs8myKd8jZYCgbgTrPhpdrs?=
 =?iso-8859-1?Q?tH20PDlevei7qDdNXmRHTF8yi3q8SDxCW1W4KVLeL6EWuvIQCy/uYJHhIH?=
 =?iso-8859-1?Q?OpJzrJNsMV855h3TENVDvpT70q5LlRaDlsK3ZYdFUiZug52lirIYJYnWp9?=
 =?iso-8859-1?Q?j4IRLEkXqhQYx/rn9cmg5VH74qz1GHd1dIisMOy26AKqqdz1ZARLofARA3?=
 =?iso-8859-1?Q?amQXivWl0E7XlnqlqlZA/X2RnPFP05g/O2VzgYyCOzYGA3MqQkO4bvNfHm?=
 =?iso-8859-1?Q?zv4Ca9daV4648BhFrLD8shtw30iNXPU3ram6XP4q6l+1xm2nGbY3CH/+6B?=
 =?iso-8859-1?Q?EB1XtLgRDpVGOyZWcRy8Jo5IKbGpV3dEAjH3UatKalOQklBrxXviS/oBhr?=
 =?iso-8859-1?Q?U8tGgIg9U/O+Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b13587-b89a-4d9a-ffde-08dc0d215bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 12:33:30.2658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Dj+TGaK7bjv1xvDkk3occ3GYvW+Ix74O0FZ9OcXO4HQbY1OqCHvjVIql8jikqsIMH6fzvolywcEFExqA52NXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

>> However, I'll leave it up to those more familiar with the QEMU numa=0A=
>> control interface design to comment on whether this approach is preferab=
le=0A=
>> to making the gi part of the numa node entry or doing it like hmat.=0A=
>> -numa srat-gi,node-id=3D10,gi-pci-dev=3Ddev1=0A=
>=0A=
> The current way of acpi-generic-initiator object usage came out of the di=
scussion=0A=
> on v1 to essentially link all the device NUMA nodes to the device.=0A=
> (https://lore.kernel.org/all/20230926131427.1e441670.alex.williamson@redh=
at.com/)=0A=
=0A=
> Can Alex or David comment on which is preferable (the current mechanism v=
s 1:1=0A=
> mapping per object as suggested by Jonathan)?=0A=
=0A=
Just to add, IMO just a single Qemu object to tie the nodes with the device=
 is=0A=
better as the nodes are kind of a pool. Having several objects may be an ov=
erkill?=0A=
=0A=
Plus this is a Qemu object, eventually we populate one SRAT GI structure to=
=0A=
expose the PXM-to-device link.=

