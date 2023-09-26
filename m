Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB37AEE91
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9Sh-0007AV-Is; Tue, 26 Sep 2023 10:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ql9Sa-00077W-2D; Tue, 26 Sep 2023 10:54:48 -0400
Received: from mail-dm6nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ql9SU-0000FT-O3; Tue, 26 Sep 2023 10:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4LWRZQtqRpTEiJq8H7WmHGibE0xPE3FzF7LwwV42tKo/bnL5nj5J2ck6IGj22UdOe8ksXfUoEpH806TceLxav7xNDDPpHllkg1qcnw5Zx489+unAVOYZj8YMgSNImDSDB3vCjBZjWlQtv3nLx62to2WapXUg0BiamBggM3GRp+V5WOfciimXB+VGDKVi0h8BAD/x/ofmtFTN1J2fcmAO4T744zm/aAoi7z4VyR7KGosvhm6QXBuoLVbZ9BTATmeW6+dUO1HMYXte6VUBwWlW8bBf5aZBnt6MqtK8TxLnr/4riwwG6V75h6D+NxHUEI5JZxOfOuJ9nOzY2ym22xVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXg05DrPcQTRdLhsB6wU3sxQ3ceEju40CZdvEHosUkM=;
 b=GTSxNRLruk2DuTgyh/JSkGZbgKRqYm1IxsnHopvWqHlM37a8k1RNclB/ZyKp2ufhtYV5CyPjTirBLTp9PtQFrA9QV2J+AXiwkiSeeXGYxPRf+QWcDgA0KR1tapd+QvDezH5oyYETkmf2ldFbW57GUapQA2sKWZnEuW7XGCbwg6BMjqvPNLywGW0VT8MCplBWY+zgsQkvve56zUjIGumfLEKyRo9sjJ94LxPnQd53ae62ftPBI5Vo1R2M5bChW1bXryGuhEp1SH/7fzSnw7dDAt0HegOBKl0xmpX1Pbw6/6bNlYoVIw1YEIWzAOmDkJoAcTD9zFRjau+Q1+ipUqnomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXg05DrPcQTRdLhsB6wU3sxQ3ceEju40CZdvEHosUkM=;
 b=FcWzHh9cSfZDm5dtwBTYQxYhCRO5uPtwvat/4A4GxzqMw3V3DkFMzCy9svdC/UK52AzAq4VTjiBThbr5pGtdpFctpG0X6vYlX9tqqZGkgCVc8l8r5sqqVkJdZDL/QtV87WZZI7EJlZduTFyY0++bK41njIaUUYveNLNcOcZZlbmccx7t9+HKAGR+mauxa/UtZd/THZuBefZeaAiIOZnAjn2hVyFhyQ9DQYIpk6UeTQycxgQr/OVcgvuduCCVpG6kpNB7c/zJANiMGIt4OmpqoiDCg3wQM9NQrXgEIXi0f7o+C6DkEWKNK9KWgGE0yGV2hv0AXH6uvPhTk567wmF3qg==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 14:54:36 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 14:54:36 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Topic: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Thread-Index: AQHZ537HoMkIAkADME+0ZStkB7Hp17Ab9V0AgApsEECABT89AIAAAnUAgAAOFICAABKvgIAAEL0AgAFlFRM=
Date: Tue, 26 Sep 2023 14:54:36 +0000
Message-ID: <BY5PR12MB37637E2A77DC8A9AB064ABCEB0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>	<20230925140328.GF13733@nvidia.com>
 <20230925155351.00000638@Huawei.com>	<20230925160043.GH13733@nvidia.com>
 <20230925180038.00003879@Huawei.com>
In-Reply-To: <20230925180038.00003879@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SJ2PR12MB8925:EE_
x-ms-office365-filtering-correlation-id: 2c5aaa2f-41f1-4a86-5181-08dbbea0805c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49KBG7hs1N8+msyu1Jo10DFY/B9TNa1K+Ra9WTnZWorq6MpT9J6FheuxS5RoGvivE7gbMaWHCmqsg0T9vYBQ32v8hf+/QJxiGe/r30fIg3f3+UZ/biZBzMTiqcrF2BUrfKtCk22Aw/rS0+WHIsJyoOF7BqcGny5CtugUL7JZUZr3O2mkJaKVOgf1YKGF477V9q0wf+o3fkkt4VU1L9zPldekmxR+DPXdKf2fqiaGnTnTWmk2QHDJ58tMJNtpyb9rw+ccfv78PM2O2nGAj8WGQ8zTETMkKnr632GUl19gxcD5XbYpBKLuD6s6XE26VrpLvD40e8cIRmw4fcnZ+S+us+y6eHuHmZ7KWKcIWvo5hBlmcvaJCedMBhd6YcLV/wGrOhGGbuvjZqLcdbFJFF2RXV0c4x8O1+qlHYSpdUsq6MSzG3VWeEGMZuhZa/on8NnjHlEyW5nuep4k16Dq4vuJknGiopT8xHPBNXsGO4hhdkK33mt6WWsEmyOj0aKB76hl4t/EOHLWFVZwQIBr5eJXVzLN84zbmezhEn7Rb9JHVxCv2bHqktvjmupUwwmrM0e8CF7HUjQfOnPlpyIuNiLyHMR90oFywG9GHskdjhv7h34=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(71200400001)(478600001)(26005)(966005)(83380400001)(86362001)(38100700002)(38070700005)(5660300002)(33656002)(55016003)(122000001)(7696005)(6506007)(9686003)(6636002)(110136005)(66446008)(66476007)(66946007)(64756008)(54906003)(76116006)(2906002)(91956017)(316002)(4744005)(66556008)(41300700001)(52536014)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dItzK6DJmWlwBqY4VpOq4y4sIc8ZJIis9h+D0MeG+4H1Cyy82BIGmhwhyB?=
 =?iso-8859-1?Q?aA4bFAakcA+TARwU5OX6cHY20cmrheseum7wHq5+LlwNQunBOpR21yBpt0?=
 =?iso-8859-1?Q?E7CytHH/DDgiq7o27DCAUd2GBSB0jCRJ5+t/6RC56JB/U17Mqgvkama/Yf?=
 =?iso-8859-1?Q?a2L5NlGf/6d1u5J58nmwzNvxQ1TXGuA/prJG70VxgM6HXhTKRrh6E4tyk5?=
 =?iso-8859-1?Q?siCcaoW0cSq8gr74Nue7Tv89Vj+pArCKAp+sPOEuque8O9Z5DD1I70egjJ?=
 =?iso-8859-1?Q?y6DIiQlzozV8Rh8dOGkyrOJ/A9e7qj3124Me0Q6/GFcdjx1A15jfAcD1br?=
 =?iso-8859-1?Q?jZxW/IyukKpYoFN+Xez2sio7VG9b43m9/7OgQ53Yr4WCzv71yJYeOXLsrC?=
 =?iso-8859-1?Q?X2rqyjxwGZP/qEWnG/vQPwUQ9fnXDw1XCad+Yb1lzemLuxI1OQFvWhEbq6?=
 =?iso-8859-1?Q?jwsBcH209w6STwZkI7VlZuiQfDXAghqtBzfxCaRpaRmQ3c5wdFtl/tmXAL?=
 =?iso-8859-1?Q?HIRudKZoeNBYxamh7ghU+5BrI4sNay5/APy3CtklR11uBB/X54fbiGL4yF?=
 =?iso-8859-1?Q?gWjJraKt9wGQknNhXTNGU4HIsg2B5yC4AaZDnNLBQ7o6fdi3BFiNk5ce2E?=
 =?iso-8859-1?Q?NOfBM82TzT9ZXkMzNpuqk5Oc54hTXvsXLMlYDMsNP3zUfYtHhJkHIOUZiV?=
 =?iso-8859-1?Q?dWBrLLUTSMF5PkHjKlxSrBOx57bqgnckfULMIHXD0GGBA3Zt0O0bRI3p8S?=
 =?iso-8859-1?Q?TaGfnAJwgODU2t5zwOK+XGXJ5kb0Azi6zUaORaNiUASG+LtciiVrtLfsvz?=
 =?iso-8859-1?Q?WLY4PGSuzH3p7wvROF3+/7DlLh7D+48hmx18jKZ7DXF341YDCMBtwd0aFL?=
 =?iso-8859-1?Q?srSNeJJFiSc/cPx7T7/H7wcubxCyz5/A/5P1NFNsY5XZofKlPo6VFpOq29?=
 =?iso-8859-1?Q?fkMQczNdoVRQ6QXu2R+tKPv5BJ+rSqM3jXtVO1CVc2yydbO8iNF48oSnhb?=
 =?iso-8859-1?Q?C1ulz6Ezqnculjz1Tzxv3qbjIbaSoO864Q7nhbuZ5pMIBK6qI/YEbg3j4D?=
 =?iso-8859-1?Q?mlnvX65MnoewK5z1cW/kW/3yqr40fRJGRpYiRgwVO3/jqAwTMUhhg8hmzG?=
 =?iso-8859-1?Q?gJniFQ8GGKHUbmrPnRN1NMFreFgK42YP6N03/tQKZ2IIaN0WRfSFHJuYlJ?=
 =?iso-8859-1?Q?GIPePj2Rcly7y/hW/yTruDkpRErz9xk8v80oVfwzL6cVW/xnfpsNg/lLT7?=
 =?iso-8859-1?Q?HoL66NQPhzZajgqBga7d+HgGv1/+5cUm08Ya5BngO91tBt1jRqQcC3MEAx?=
 =?iso-8859-1?Q?C50QQHqDpnAYwRRWQ8doqiUdku2z7fQ2uMHzQQ6o5vnmQzmIhw73gHKp3n?=
 =?iso-8859-1?Q?v8MiVmpyiQ3eHGO2lr4k8Tz1/UdzUVFceGHGAQhOlz5vwL7zNzVNOAsXmY?=
 =?iso-8859-1?Q?kzf0q+/Ebq3QtuOrnSe/hfbyogU2wFA6Mh7KrKURXmDxv8GixP7FCMI1PV?=
 =?iso-8859-1?Q?3cieCvm38I9vUmcTKhTjKTZDi07d/0UB/k3GlXGDytCjxrCbQBcDzhVGj9?=
 =?iso-8859-1?Q?AGsZxaRZYVkitAHaGkT2AGoP1n47oT7cL71+xYeVsijLgLHjwgGCmiEspx?=
 =?iso-8859-1?Q?iP0c+Uc+SGD48=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5aaa2f-41f1-4a86-5181-08dbbea0805c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 14:54:36.0385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSTZS9KYy9CLr3TMc+zy2YNiSb7MI14fPrkt/rYI1Ib5WzMdtxlB7VhP+Hslazn78aqDtfWX0v+EfxpXIdQt9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
Received-SPF: softfail client-ip=2a01:111:f400:fe59::60f;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

> With an ACPI spec clarification agreed then I'm fine with=0A=
> using this for all the cases that have come up in this thread.=0A=
> Or a good argument that this is valid in under existing ACPI spec.=0A=
=0A=
Hi Jonathan=0A=
=0A=
I looked at the Section 5.2.16 in ACPI spec doc, but could not see=0A=
any mention of whether size =3D=3D 0 is invalid or be avoided. =0A=
https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf=0A=
=0A=
If that is not convincing, do you have suggestions as to how I may=0A=
confirm this?=0A=
=0A=
=0A=

