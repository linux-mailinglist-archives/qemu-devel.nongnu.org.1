Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B253D7CC778
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslzv-0005XJ-A1; Tue, 17 Oct 2023 11:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qslzt-0005Wz-L7; Tue, 17 Oct 2023 11:28:41 -0400
Received: from mail-dm6nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::616]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qslzq-0006ua-A3; Tue, 17 Oct 2023 11:28:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c20UH7SvM9kCY1j5Ur8beEuMIpcTIe6DlLgRgI2/8qy8Vhyn5mVI2HQraQBLPfX5HOxLCbGfBDLNCyi2iiW3+roINQomsByFREMTiC59M13zRFWAp8+Mb8C1Dlgd46CY77Q6vGj78mG5k/IYO0OrsabJVm9ccvqD1HzWgaUHfZp5BVeKYq9BZrL1bl5xlrQNlorTA97bB/MEaw5epGqE4Umd1t4F/REXEzmsiv8tzsa4MUwxDsn47q/8lMWYtr7bJs48fhnQw5ejaz62j1IRk6iJiWtYmI9iCVl6dhGq57QkelGTCqMxxJixH6+2Z99qJB2tUlFUSW78i4T6CsN5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjXnZuGCka0mxe1+P+bRHhztzkrekgod3TJbEPNxCsY=;
 b=nQknXWs6SrQYad78WfLjz3EvtaHH+wbvkjeuTbq8XbLwgI+TQadVlBtW+py+Hj0663yIfu5uABH0IDUn5g4qgcEFpNLK9jw/V2khrJllTSQI8CQr0VhgjykDIAoeGm1NJjuCjBmsI8Z8Hb6SCYB/ilkMCBomOWHu6uCWITYC3VFEBP0/bkMG4A+x3bucz5RSMUa4OB5kOp126zTKftS5wEwDAou72U4qzPDPIMkVKaW7jF/bGHwA5AIEezqMQehE/BaE654+mgqUmZQGRD+1yup8DoFwI34mzsd0FN1yKWr7NXEI3Fw/tPcRXd1KrEtys54lU01QG9YSUIaWDKPuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjXnZuGCka0mxe1+P+bRHhztzkrekgod3TJbEPNxCsY=;
 b=CbC1YEJ0a060fa7coYcAC5IHmiFfI/Uesa21CYMa3VTYANhrYtxO+FHkJBJUD1GxoYDNCy7BYaR0yBOmmcG4otjR5xp+IFWgr3o8czJZsQZ5kk0Gu+MC5urkKaKLgtDLYSiV1/lbnDgrJorlSje6APYQ8TMhMcAUmIIUFUiliy/i3vdP6wb6SB2KYt2fAtfaootxNCCQiLyEBcg7DwWrT/esqqY0qDOq2zWCrFuxN8Qduc/+iz5zqT3NbBbVlNVnzwOmStf3qBsvDuz6sUAK410N2/laoyNhFkejI90Hi4JvuP18EEr0TxsGVVfo3vP4504epwdyUG1/AQ8Ph5Rv+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 15:28:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:28:32 +0000
Date: Tue, 17 Oct 2023 12:28:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Message-ID: <20231017152830.GC3952@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009151611.02175567.alex.williamson@redhat.com>
 <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20231017092116.09ad2737.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017092116.09ad2737.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16)
 To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: f68d5357-7eb6-4673-1973-08dbcf25b8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8giZlOibUoiunjDfflDRFPECLZJiTpWSMWkkdalvTKIESrHfJwL2+RKSylpcKeazASUoVMuBYXjAxpyl4UonHF6kmxLwD++0gLDZVSALTYxfecZycvjq2JEjB52/ejk+59CdPVekFzCyR9Ro3X+jVAOQZvPjGMQv1H4beVWynQU5WkRqfgxCuGBCgfN40d8pgraBr8WNmKHf5TAoTkakbSnI5drXtvzbkn2uycxQBv+rz2HScZgqVGRmv6vb3Vrv9qzG4pXT+g1iIOfknH0152ZIbT39vdlAtwBm9Gb07ZVVHIerOZgPIntQ6U/Dpt9w5/Ogxi7RMHvA6ZGTH3aHUfUu6Q6nQQNeu6IT/lL6xwWAPUU0sehd99qUE7bnwIe03Fx2s+4Ad6dS94cNel6ARhd54CKl89Ht/EuBiiepUtDD0sOKf3OkIu+pMpn22HPvyR64F2GVaFocZ8AS6/0Rok1Giq8b40C7gs4g6RuLudgDUuSRj6irZPPWoDUADtOX5wzRjC82j+DpdJQSCMKVzQAL0kGLlwDx21XHLOPIawD0xIu1/TVg+qBy7d/AzTHa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(6506007)(5660300002)(2906002)(26005)(36756003)(83380400001)(4744005)(2616005)(33656002)(38100700002)(86362001)(6512007)(7416002)(6486002)(478600001)(1076003)(66946007)(54906003)(66476007)(66556008)(6916009)(41300700001)(316002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYRoaGACz9te0WzXHRuqMcNtOUlJXHHD1+/Ddjkt84LvyeDVgEwrd6/9EeZs?=
 =?us-ascii?Q?BtwT+rin8Vt4im5ZuZj41QQljeFd51c1QZbgG9lXwQ/pHt0RwcrrA48QB9pK?=
 =?us-ascii?Q?sr59Pud1jy4U5UkyUGD2Pjt5tfX3TJzS8Su/T2ntAi8vxn906nmwgK2gJMgl?=
 =?us-ascii?Q?SDkWqW60tKgCsNeii75CJm4Mv3pc0q5g8pRO0J3BLX8zCOX4Im3GcuEE4Wz+?=
 =?us-ascii?Q?Oc0fA23jqo881rscIOGjE8GQoztyxPJ2XhQk17OqR1hd6mNz/jVcu2ig5DAK?=
 =?us-ascii?Q?bhfiibjp/Hkf+l1MZl/ZMB/TSTXg7b0/fiGSJTwrnw19FCfsgeDozpFyYgge?=
 =?us-ascii?Q?b9+yEmMkh+mj/y/gbTlCY6Eug0yYUor4Odq7NQpOkh/pl9QlexjCPfVhN6yT?=
 =?us-ascii?Q?elf1ojdr53yKiRi8o7ay7rO1ZjueuScJpmCHmsK9+Tvrp/wkhtX/7oq0/UBB?=
 =?us-ascii?Q?zHUOBFWZHdcFmo5rkw6L0VZIFFjvGB3PSLj8pcDHq9o0zGhiit+pQL9XXvMz?=
 =?us-ascii?Q?Nd4GxetV/t1+Lro0NN3CHpVe4lwlws/kRQgpT03RpmuyBVAq/gza9DtgKdzD?=
 =?us-ascii?Q?J4cX2l81mFNSpPis/+xwp60qw+JYqDtLOMkTb6OaXMwGV1LtXBWeT/YuZBGe?=
 =?us-ascii?Q?Z5z2xci8fVMS5/IpEdTB5TxbglHaxAiJvDmJvHLzwl9TjxGAt3v4S8QtZzix?=
 =?us-ascii?Q?rfc+3AxGrCvnxtR7/4xMsBUlU0C0xVRFV9WYB5dKSwpRirHlUGYbyeJ4RHqg?=
 =?us-ascii?Q?UylBhMzMH52L9nJFgm4dElIVFU7pzzpviibhcX0poMz7dmSuPvMmd/QhsCyw?=
 =?us-ascii?Q?PFNxfg4Lv/IGrut/gYBVdr3zvkGq+4zV9S6Mj3nXhMm+Kfa6/yafTKHMhZmK?=
 =?us-ascii?Q?vSdtb51KoR+Ct9+8pxSP53/kkUvUNGtDN8rvx5cqA3niKkuUFA19C1cHjqoo?=
 =?us-ascii?Q?dti81/PsybxHI7M6eSQkTHzHXD+9vpVtGqW81JldQc5u8O+RexCZtGLWBom5?=
 =?us-ascii?Q?I2QLL5LBEq0r2f8EJD6iYHeAopGPa3KnoGUuVc5zwFr/PNtjVmo8tutSEH/T?=
 =?us-ascii?Q?vqDZ3Nt8nt1M5vgGM9GRyJObQyZsRQ0weZfYkPN8aejBGp14TSFLd/fYmISa?=
 =?us-ascii?Q?VqCZxhbVhFzLFk3iLxFaseE/KOrs+4iVdpSibTVIouQvMqdARaI6yiwAhlBN?=
 =?us-ascii?Q?9kwsprJ/OjghHwjVvzNfmvOZAvFwb0XOh7v1RNAyVVo/srpOP5pZvykcyqfj?=
 =?us-ascii?Q?UfP69uR0jI6Adjb3TI2vgbPLO1pgkAkNp9sMnT856BNV5ie82kbfXv7ho6BC?=
 =?us-ascii?Q?IhUJXV3sqChQbuWXpMhNa7iSuoDqDGpU92NqT4KL9gjWRBOx8aktgbFFAZqb?=
 =?us-ascii?Q?GghRCdbt/yqGKOG7syKhM5FcawlbsxwpvcFkkjYq/7h7XIhnBsJGYDhSAbnn?=
 =?us-ascii?Q?zLyTXIJuXj12X1ALoTgye2w730V7Fx7kvk5sC4mhrDuopmyOY+2fmmXiXxCV?=
 =?us-ascii?Q?hJxyqqAu9v+v/xeXKPDvd/KTTcF5tj/Y5AYsqRELxbzo0Tn5HaE5Gvquk+yr?=
 =?us-ascii?Q?QUOzuDI2+0ioejTTIhbtYcLEeJjIXBiHESFcc6lU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68d5357-7eb6-4673-1973-08dbcf25b8ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:28:32.3319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZNHNLzE1meuI2Gcxpv3MLvFM7F1En7/TVnCIlaVtT2Lv9Sn4cXbvxqi8tk/xaHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
Received-SPF: softfail client-ip=2a01:111:f400:7e88::616;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Tue, Oct 17, 2023 at 09:21:16AM -0600, Alex Williamson wrote:

> Do we therefore need some programatic means for the kernel driver to
> expose the node configuration to userspace?  What interfaces would
> libvirt like to see here?  Is there an opportunity that this could
> begin to define flavors or profiles for variant devices like we have
> types for mdev devices where the node configuration would be
> encompassed in a device profile? 

I don't think we should shift this mess into the kernel..

We have a wide range of things now that the orchestration must do in
order to prepare that are fairly device specific. I understand in K8S
configurations the preference is using operators (aka user space
drivers) to trigger these things.

Supplying a few extra qemu command line options seems minor compared
to all the profile and provisioning work that has to happen for other
device types.

Jason

