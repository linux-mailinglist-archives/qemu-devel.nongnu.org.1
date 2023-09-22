Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4C7AA87E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 07:46:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjYyM-000855-03; Fri, 22 Sep 2023 01:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjYyF-00084i-Bv; Fri, 22 Sep 2023 01:44:55 -0400
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjYyB-0007Ia-A1; Fri, 22 Sep 2023 01:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjGDm02+iRYDDpnq80rtyceCuyK3yFjXpSVMKtN/yfThUIq/dw02MBoIjD2XPAaAaM4rZssSEz+qKW3LXHWY6wa/PY36W9d7QWs1qjG4lhJIn1wnrjabFgZuOOy3ZNG/9jXSjC00Q6XhcfgDwJJHqDdSlHR27RjnlPkgEev2HCsiPhVLOlIq5ikUMTfMj8VQnUHqJ8OCGpYWhpso7A/iVyQHEIm/opmiqFnCffxZNxZFv0bqjvUpwLnUTzo1RObL9QNZJfHtBLKg27GOOUXBVGrMmo4GjB2Uz4XV+24ASUK/xp9puc9asRJWdHCr7feW2XWOWr6H6yhPWfCL9HhIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaLG/PgY9V9SN0h5O2V5eg17RgGaC/seQCPyHNpH3LQ=;
 b=mqBbZNVS66Xj2cmt+1lJ2wR+Iq1wMC09GEKmYnuj1B1FrKT75kRkz7l4svaXjUdqGIsM1kND3Ew7e5qa0/I3xaiunKmJD6fi36txb9T1zo2A1+Fb5tlkSo4mwkK3AmQ676bLQwvP31sY0Xtzgsk7kGVN9oP4hANddDt9rP71Hgg+EKpbswLxCtRlQCqEwcv/vSPm/g5EfG9Xmi3SJTJ39StpTVp3ulKIagHJmBDzjW1GG26Fdk2pO84Ch2xUxN5+dXHAHAFz74hxOmSKUEOU2T7pYQlpntUL8WqZCzUkkS2vw/EUPgxnXescZDo1q1wfIXh6QiB2n3wfRf/vf/Fumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaLG/PgY9V9SN0h5O2V5eg17RgGaC/seQCPyHNpH3LQ=;
 b=Y+0d26+7lrK98sbxW2mn+zLTqvfHgtTS9uAiUlg2bPiKS8loIfluc4vb7yVtHCS/arFkX6NC8sJ5O8cSqoKpiGU5WXZkSXzBA2pVni0tAjsj3EcIoDkozG/0NzyTnQNe90+JaERSG7MFRiPRVjYNVaFNQDmIWNkeltbjBCtPJ4pXsbImJnt02IcCOJAJpiIVam9bwqn0hpJzd3c/6rGq1aBsmocP78ZVqHvn9k6Rmj+uuPi7atAZB8wW2n6t/4QmLVsyIifO+Buol696gC2DXANNnCA6U1q8fjIo4yaDA0FSz+YqIT196UnfTjEAOLNu674PFpjiTZAkTbTODrWc3A==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 05:44:44 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 05:44:44 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron via
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v1 1/4] vfio: new command line params for device memory
 NUMA nodes
Thread-Topic: [PATCH v1 1/4] vfio: new command line params for device memory
 NUMA nodes
Thread-Index: AQHZ537GOvmKk8o8AEmeuxweOgaO6LAb8d6AgAAGk4CACmHCkA==
Date: Fri, 22 Sep 2023 05:44:43 +0000
Message-ID: <BY5PR12MB376336ED0A6E20B2AA6FEF33B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-2-ankita@nvidia.com>
 <20230915152509.00003788@Huawei.com>
 <20230915164841.15d20ecc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230915164841.15d20ecc@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|DM4PR12MB7597:EE_
x-ms-office365-filtering-correlation-id: 619dec22-4545-4e60-5294-08dbbb2f05dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SpzSHA3vZ9HJvHEHRkuh3zEk0oYHTZq0wsZahKQrgkZ9VFn8gS3Dtv+7kUyErbmeCaKQezXzT6Zmftl38EJ9SODAmSQWIM67sSOiLiLafLQTCS8VZfjFbMna+TimYTvgwJVBNSR6mOc7Av2c8sVrFfnAp9PW+5oTyOWgJM8R/FudvqnUkkZbYe7RaiGkGoZABtvIFVmyqgNYlcCkrnGkveFtqa//HOozxxN4xNZrY617WqmvzeBiba4mpdPXP8DKyd9LOYjXEjhr8d3DQUpULxCSay+lMEMYZjohJ5Pnk/LLtbpQLhEWbP89eL869RlkJALiSU/bL3UpAHTZ9vwl7Xye+DwibfGEMw5Da3ctN2/kbYfrQIqMJLt5WRG81I4PFZ1O+3q63Fl4mWwaopAR1KcvRExYfCCmeQV2gY6YZT/Wg14TdhZhx0O6TrtMEO4GS63ZMGnaj0C5QsLZfZMd+/UO80Fc+RtOGUE1z5yJCWZawsKu2/kowjWO4VWNScbfleWCMBDO8+bVUdC+zvpb9csXdNnHhNPyJsWpPJ5TosLDGnntU8ejbjDHIX8m1lwfwNkvh6qAuM83hVf86ad8Wg8r8OS5m7R5IXK2CvhFU/M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(83380400001)(9686003)(26005)(7416002)(54906003)(64756008)(41300700001)(316002)(66476007)(8676002)(110136005)(66446008)(5660300002)(4326008)(8936002)(52536014)(66946007)(71200400001)(7696005)(6506007)(478600001)(2906002)(66556008)(76116006)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OhPhMHHLHx8wFqFDqKzANrOCSqstnW90oYnnS2exz9S2KUCjV8tcnYiizj/e?=
 =?us-ascii?Q?3zyV6i78M8Mq2ydCZARXvgEvi5AY4zQxa5LG9WvOJPFzLxoQoscaE0IofxgU?=
 =?us-ascii?Q?r1P4aYX8KB/MNELvLT5O/vFRV9G2+qRQq7uiX/cqVdEn6D+RwNETU/Ed9auz?=
 =?us-ascii?Q?NpY/5tjy+zCylyueXCSGJHZpVImJDcT+56uHxnhNV2wVEq4IxCOShkGcgGYh?=
 =?us-ascii?Q?JKX5iMdiJvEJbcbaBsvROIDFPXlOumhClh/qJjzOqHXYXR+fcey0MIge/I8P?=
 =?us-ascii?Q?ISd25oW5N7JWFC880uIB6UwgaU4xKPhfzSLoGGjJ7bAaWIJAn/PpuXFWi/ej?=
 =?us-ascii?Q?VJ4PVS/+EMsa38pvY/stxbSoWklZrtS7q9OAUmQHXFx3W8R0isgQjQb/Oayq?=
 =?us-ascii?Q?iEePuUTMo0Zt/MEZ5eOu8I0NgcFl4e5wXue/DFCmq80T57RxxIy1Iw4JxFax?=
 =?us-ascii?Q?5bFwKsNcPB1zA1ld0VZJVCGjcQMyyty/hqg1y1PDUu55IGAX+TLuZpNOv50Z?=
 =?us-ascii?Q?3FvsNqg4Qj3GnVhZd6dhl1HFqsPAqqj1M9dzdjdmIuAMOSD7zQ6fi/qS4p0M?=
 =?us-ascii?Q?8SV3DPJz9xnonTiiXLuNWVYl8agroXyeQVtGQzowpKW0DLESQ4vJYX2YX4ka?=
 =?us-ascii?Q?iYOlW3Up8N2oW38uxQ1+j/698fZ49b2+5TphA909IBKvT3RLSLkI9Eqpu0jV?=
 =?us-ascii?Q?TccyJ/CJgN90AGJb2HMwTy86dOGCvaHd4Ik+sCTF2EP5vf8dmt6m5X2ywu0y?=
 =?us-ascii?Q?sjMKvS2qol6XM1aUcUzLM4NoLLdsJxbzgGotPnrVX1ujlmm0Exh3/RUUgwx0?=
 =?us-ascii?Q?17p7a8xDQbrFVWIVUP95Up22b/SweKR6uE1HjoHd9wBwpSRzsJkRVsRvg7in?=
 =?us-ascii?Q?fTRcJTPWyrX2wA+teKEnML1PzR2mzzYvoTSgHlZMYgUGehpLhHyUxMBbxTJ2?=
 =?us-ascii?Q?pSt2GecZxcQnIZRlCwmwEphgUiGNjjRYv50k5AIRLO+jlIbYBJym9f6zuRPk?=
 =?us-ascii?Q?Je9y3zCnf4vC/LrLSjgd+9Ysiq97sWW6303JNrBe7X2GVTsg67g/GnWyWLWR?=
 =?us-ascii?Q?T65XYk4rc6qFdQYEbbu63wibYD81UgfcFU3gGPP70J41yq36x52bplT03xcW?=
 =?us-ascii?Q?U4IAlXxH0lwpeWNPJUZgMYJt4sH6GZRfhpN6JyQo/1tetpw1P3P10K+CcYEi?=
 =?us-ascii?Q?q2ReaS81qw+FLUMGWdJD9YRRQJoXzPt7vwcRjeVadPmC6p2KsalvXA7r28Oc?=
 =?us-ascii?Q?aBOifIV6PRl5kZx54iISXrZbPC8a4vbQkeTlg7HyFiHrf/PedEZeAIhhprh5?=
 =?us-ascii?Q?W2B+6sA5SAEjWfCTg4yeMiEGF0i9b6wfpQVNQEoPZ58/L9Cjt2Dw7dQRTbLG?=
 =?us-ascii?Q?xKWU/P/kNRpomCzFn2iq2VyPzpVoyTwdNOR+Bv07rQDkmQH/nEUoXjenieLq?=
 =?us-ascii?Q?W6IM/iHLhXzN65YreE5bknCYyyOsSXEWp4Ye/o0WpCF1Ar+lBAUZbgQo0/Ab?=
 =?us-ascii?Q?jl/LLjJ2+X8RdUM5c0O5wzE0EQdFwY7o+7inllXhV/h1y3xiX8oq0bB6A3lL?=
 =?us-ascii?Q?XyNpTjt7kec0bcDP0Jkx7tf9k81l215O5hirq/3X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619dec22-4545-4e60-5294-08dbbb2f05dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 05:44:43.9098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGsybIY/7ut5lMw++UY+cjVhZ7bw6qreAn4I1p3WTm4rxMkCpWnaUbfhRv9caHzCR8LYJCAWfT1irlZmKStNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62c;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

> Also, good to say why multiple nodes per device are needed.
This is to support the GPU's MIG (Mult-Instance GPUs) feature,
(https://www.nvidia.com/en-in/technologies/multi-instance-gpu/) which
allows partitioning of the GPU device resources (including device memory) i=
nto
several isolated instances. We are creating multiple NUMA nodes to give
each partition their own node. Now the partitions are not fixed and they=20
can be created/deleted and updated in (memory) sizes at runtime. This is
the reason these nodes are tagged as MEM_AFFINITY_HOTPLUGGABLE. Such
setting allows flexibility in the VM to associate a desired partition/range=
=20
of device memory to a node (that is adjustable). Note that we are replicati=
ng
the behavior on baremetal here.

I will also put this detail on the cover letter in the next version.

> QEMU have already means to assign NUMA node affinity
> to PCI hierarchies in generic way by using a PBX per node
> (also done 'backwards') by setting node option on it.
> So every device behind it should belong to that node as well
> and guest OS shall pickup device affinity from PCI tree it belongs to.

Yes, but the problem is that only one node may be associated this way
and we have several.

