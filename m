Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F125070534E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxH9-0001z0-O3; Tue, 16 May 2023 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pyxH7-0001yi-O5
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:11:46 -0400
Received: from mail-co1nam11on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::620]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pyxGy-0007dx-2s
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKQkWsYQKZd2bzqsosL2i5vK015sBWIuYQ5kPxRAUcbO+AkADYAJvYnPtId4nh1ZM5eQERDNerlKBfZ7ZoaOCIiq30g3czaAx1eVS9vKfaZ6KfLc6oCnHo4fsnmBBoxZhOJRoimAkBo4hkNKxsYaJ0KTzgiUWdciRJnQQ6azTxyD9qewMgKBr0dx7+Hbl87SqUw0QtuZYpQ9uFDS5RCpMVIsteOMZq6UTNslpSWbkegcRAef/NMs81Fr1GHeBOMj2TjsAgyTKYwiW53ORfBqG9uOM9RpHGf/yvo6tYelY6km7EAQM5ivNEPgRS7++h5NfgdPydgiEj1dZxQpP5jP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EthyKZiYPyz5TU8wpK9XJjQ05R3yMZyNKl1oZjoDEtM=;
 b=O7RJug+PtpfEgg75/X6NH4ekH1tkFMo8UW4LGwTO1NLpo67iQla6qD25rRSoBVPvFbTE2GGYXoTOnHrxUH+kQjTzq1DjS6a4KI5pl7rJI8niB2u+/PWkL62dYs8WjjGXqDuLzDqjxMXQzEjUEFCJwuOeuyWYJuZwMWviHigjsOq12VgtwTzdjEf1bsnp9W0jRcYLcmcQrhFRoUFwkYjb0gMDdqrAfv4xTlHqXlfeJXG7HAFIyoDVDxOthkb3G339PlaG7ExsSSnG8uj418r4lsloJldHM+NIeUCcEPVnFtVkFjk0O/Ric9EG9WlbAfRtw69gj4xqPRMfq4SWfa8NDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EthyKZiYPyz5TU8wpK9XJjQ05R3yMZyNKl1oZjoDEtM=;
 b=RyLndlvxrzcJyEseP0auLONRIer9C8PEgoEnDQItrdnRB8DRbwPAfVPJoJqYpFrbDVi++a+crKJ5J2EllwBXPelPqmPwd+OM5hdEn6wJBDqGReuWbHJ7e0xAS9WlxEmG29uh3ggC8KtYvfuCnereBNtiyaPMvYDJCsr11qT6H18arTaoX1IXaPHO6dHV+6djM1bVAJy97nTHmZrNNdko06pnLjLM2NQXS3zRWoTMERPLzyQz9Uyer70bXiz02OLoQVHE/u4OH3UzyE95mdbB6l0rvI6U3dYVbsSej/Zla8igpMVQG4Mzy8bVLmeHzo5Wtz0BtRv59evl57cgdAO4sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.25; Tue, 16 May 2023 16:11:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:11:31 +0000
Date: Tue, 16 May 2023 13:11:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Message-ID: <ZGOrMk1FPRH2/B3C@nvidia.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com>
 <ZGNwK+6HmM8lPjAU@nvidia.com>
 <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
 <20230516082732.702e8788.alex.williamson@redhat.com>
 <a48c5d11dbcd470f93633aae721b2d18@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48c5d11dbcd470f93633aae721b2d18@huawei.com>
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: b57f5970-2400-4213-70b1-08db56283692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUHmQdb7fFsBxtEzyzZkjpDenS1Tg4R7TC+HZekibwzs1Lm3bUxexvpKvyyv+A9bpIDce52elMySANlkicj16esMFHrGRFbtX6wtVRak+QdPCHVdg+tILGkZxUkVWZ/nxRviYdOZorMDRDvVbSQJ8wbTN64KlnYk0zzm230DHidkBhV/MpzzYs8Mp0JL5NbCv2oT4itp7g0wVD0oOVayk5I/ilM7KtW5xwghgyXGM6Cv1fOdVd/wkjaouBrFWtqqjwJFFEtZxEC8hxtisUJInBYO6GIywFegtlTSQaHItKeHOEpp/kRGpfh8bMxWre49MrrRSEyhAdL1E1DbpTpNsrS8fgL073Mbf1W0L9Uga9XHK+202u3ZEZHuZHV0fwtdDSVFWGG2iV3ig8eV+EOIt+xh/6QimRxWDGkjhj8oolcf5dC8hdgieKzZwh0kAKmX7iYV/5DTNxXDd9lI/+IcG40eaFQ9cVfUCOK47h2Q83/pUp/+FarBLWZEnWxFXKhxxP8TsxloEoOWB61rpQQ5Z5KBzgLisx69MTxwBgzudCQ81NOWyxUU9VQ0azj1G5Bm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(478600001)(54906003)(8676002)(316002)(8936002)(86362001)(7416002)(5660300002)(36756003)(2906002)(4744005)(66946007)(6916009)(4326008)(66476007)(66556008)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6506007)(6512007)(26005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mg8pFyTL1sluq8AiLueq74e/spBMMMSSJwm7NYJFzYKui1M4AtWpLvx4AVC?=
 =?us-ascii?Q?Ovz3oHNLZGZtggjo/wMzrYz+y3DXvY3WTtEXVbYKpL+aXcT5IF6MvoPMXI4u?=
 =?us-ascii?Q?SucKSoOXjy9bdB5w5vnuGBxhCRQeXFjde4VWaivZI2Nrmxq6lMIG6JpWXak1?=
 =?us-ascii?Q?4xaW3Hb7VKY5V70dt35dx11FsCGaCeGt95h12rNoRDawNtMRZ9gnNDlGRGbB?=
 =?us-ascii?Q?CyvUbphAoq8WlyxUuVkRLGlZOETABjvfa9+FB/W4lw3Y5N/gE+muSxOkL9cu?=
 =?us-ascii?Q?Q6VfySyNam9MqoF3MLvOg+oeQZHBuJTC242BzXBtTFZhIGPeXD6OgeyEEbtK?=
 =?us-ascii?Q?j6w9VlTcgpMq7Sst0W3h1lqJUmcVHJGHSc1VDH9FARZeqXxJszsRWKHLrNfA?=
 =?us-ascii?Q?6D9P5sfUrDDc1QWmSbP3PxB/lQDXge49VnZw8CjB+41VYX5ECwLhyHTyMiPA?=
 =?us-ascii?Q?chku3aracUloD3tezvRUqgQ+mjU0JVr+wWnVIqYUivLaIm8SHalvftxy78Rr?=
 =?us-ascii?Q?8DHn1dfQ60iwMP20xPtsTtztyBMQWEUHfFAIUssUQiBi4DfFDAqfTudF3Ryc?=
 =?us-ascii?Q?zFKJ9YpdNcBzQRDHFM4Va7C1mp2dCNkatPqp/+jQHLG8lu7Q0mtc0cVOUH4E?=
 =?us-ascii?Q?LGRhFvBeN4v5hiD8GM4eAUZeze3EQcQ3YtgvS7IP5rLj6LGfEpMU8WT3ILT0?=
 =?us-ascii?Q?OxD3PG29jgs85AnCj0tK68UoPIj8rZaXnUqWksLPFn7G2tHhwA1eHuPoxjVc?=
 =?us-ascii?Q?ZQt8BJvoCYIQEmo+IIfgUlYLdkFxavBi7+K2rVlYpt3DDW2ujPmXJikHNHCz?=
 =?us-ascii?Q?pZLQ7oOQNIAwbdRIL+JROdBC+7jTzwBE94F6KuJuJuYocYEbpijuAKLFmxWd?=
 =?us-ascii?Q?xmr0lR76dhlCl2uihc/RI/VO0ExSyFGsAaK3osXV7J2n1dgGz1oOkivBtuT6?=
 =?us-ascii?Q?XcilIis6VYQJxh8jb+wZrVhrZhcEDDSe5ZbBxdtbgKSsJW7PcPfdV4ef8cZD?=
 =?us-ascii?Q?52iqz/jZMOPgvuFwrCXbhd1hetXlQs/U1jnE+424PRbJBKsz2oa8slOuScxt?=
 =?us-ascii?Q?0wFPj4bDw7s8+1kg1LhbA2AZLq/0zWi1c3dR8AXvrlMLd758soaNTc42il1h?=
 =?us-ascii?Q?JBoaDfWxj5JZ00JmTqgDRR+pSV7R9XSlz0PQRLnWcaqAd/woWr+7Vw6m4IRK?=
 =?us-ascii?Q?rSg9DUwq37bJuJXeJeNCn5XzWbSlaVX85v7NRMLL75BYBs3kP4EFoIn4u+7r?=
 =?us-ascii?Q?0gsh5puw4dAOZTmmMWzR2YWXEQ38lYa4efPzG8crqi6nokrYh3edJSubYb15?=
 =?us-ascii?Q?Wz2dOHFCER3xvbf412aRgS6CVJqNPwGllToX7QHWzxbQ1rhGc7gtV8I3C43i?=
 =?us-ascii?Q?W6TIL7ez7x72DLbRTcb1WF0TB8YFWbx6iulFBxNkIKI7fvLK7gs6PPPLer7J?=
 =?us-ascii?Q?rfwO4fYgf2/ql7iy/Zzjuh7wC5Ro+SE1lW2Wy664hOJbpFnOL/hJ3XmyBDFI?=
 =?us-ascii?Q?QaOKVWoqTQCBW+PzzU+uzEkMliTte2W1CZQIURD809Xpz/KGL8tbROpMJmrk?=
 =?us-ascii?Q?0XkB3rhdIIaX8rC7f3pyZ1LbnTkM9n6Msn6Hms74?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f5970-2400-4213-70b1-08db56283692
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:11:31.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJJ1DEdbHYmfRUp8SuCWYSOOJkVdYx4bofpAJQeFtcxPVm8/sXeTFsky6KxAsZke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
Received-SPF: softfail client-ip=2a01:111:f400:7eab::620;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, May 16, 2023 at 02:35:21PM +0000, Shameerali Kolothum Thodi wrote:

> Ok. Got it. So it depends on what SMMU does for that mapping and is not
> related to migration per se and has the potential to crash the system if 
> SMMU go ahead with that memory access. Isn't it a more generic problem
> then when we have multiple devices attached to the VM? 

It is, and I am hoping to solve it when I get P2P support into iommufd

> I need to check if there is anything in SMMU spec that forbids this
> access.

There isn't, it is up to the integration how it handles 'hairpin'
traffic. A good implementation will work correctly as Intel and other
CPUs do. A very bad implementation will crash. Medium is to return
error tlps.

Jason

