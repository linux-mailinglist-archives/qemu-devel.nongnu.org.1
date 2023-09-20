Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567117A8B91
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1oF-00029F-1e; Wed, 20 Sep 2023 14:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1o9-0001xN-9O
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:20:18 -0400
Received: from mail-dm6nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::614]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1nx-0000zd-Tl
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elu14FXnmsp1LP2ZzyrrDe5f607hN4IgvDxjXeC2OT8BBzBwGOUDr44DD8oE89AmnCLppFjOx8h0zg5C09KPHPbzS0Io3jv6fLj48BoMSAcsstQV7B76TFYMm5dPbfnWuloebppv7IeDLCu+lr3lWhSb8fdApIuEac5TKhgD3I4QlyTIWZjzjRQ5+MisfYRqNriwE1lijkGt/DcCjHfEWd7X6IidLuT/zNP6by20VElE6HCPXtabzkDzULsyU4KscnunLGL7WKTBWcVAfJdjQM5UBXCbTV1ux+vmwrnVL2ybL+hxwShExWNK612qpjTRxmLW7UAv4TZu4wSgFEFc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HMm4Z+rLGd/3QcAL4K8uhnlUW2KU9DDwIEc5GBPOeM=;
 b=kHM3fxzXPDwLedjh50W+uvKTzw+a9S2Gw5tfPSHKghFvUiUpNZuZyPWQCHtTMKIh5tJQBnedrn8hvXp9QYRI1rqzqaP5maDeLtVS5F4bls4BcBDt0Ydi0Ell2IY3Zt+w08kK8m+DNzmxeHo/VczTQWo9pk1z1q0LGDhfh9gjkwVWBzMD9YL0/wmQj9iXm+iitNtIuhydGJ+Bd4r5XHLfK9jIZsFcHoSADOF6DTNYUYCij9FOdaV6vAi0ZdnzvqIwqcTi+XqRNDMKbg39BGgzZLTwqpCMYKBxiE5QWtaqfdIQbaHayIdPFJm2rIKBLZU1sub8i1j7ralaKozR37/xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HMm4Z+rLGd/3QcAL4K8uhnlUW2KU9DDwIEc5GBPOeM=;
 b=UebDEKEmIcL/1drlSQLQnTx5akvLo10JSeya6+VPOCEoxOawUS4y5a/xolHluJE6nOlC18NEp7MbZ4AX5zD0X4ojM0IIwGdl3LMNZFNVTfqkDNCAQ7eh6peo0zgcBecexLSwoEOR7+/yqv6yVz/x2dvkIx4UZRR/x1/jP5DNsQV22Et/m8WdzfeGCdjmQ9LNjxTW8z6VWNBLQgqbSV+0G7krkLlh/rpG6qMTVlaNn5GjD8MJ//3QUcQ51nm3ReNQaXi8I7TMmdTUF9H0a0gJ7mXc9i/9P4qGSdAO+AMLwxMgvdOM8vybeAyBijnMhED4JSiI4yJDXS3K2BB5ao2jSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 18:20:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 18:20:00 +0000
Date: Wed, 20 Sep 2023 15:19:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920181959.GI13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
 <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
 <20230920174919.GF13733@nvidia.com>
 <20230920121724.381716d4.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920121724.381716d4.alex.williamson@redhat.com>
X-ClientProxiedBy: YT4PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ba2198-58bb-41b8-6f66-08dbba0633e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nm3gti08kB0xFXWTJLV2ZIki4xz6ecxs5+LpRlh/dpbQ1eUk1Mf6befBmxKYuAhSGOvze+3X/Cf054F67FriztkS4+Fd0pX55DYMtEh3pevZK4L8adhTqidd1g9CTGqBajvlnxR710+Tgk4d+FHR6UIhaYPY+bc0xcwHg7wLmTAiVKdhH53wKZ668rkSfAhb08jM7uJr0/8cFII7YyFA7OLr8hvaxRycQX7ZpZt1ZWVM8BdQf2OyHuzTzxPeZo2I1+HD6jHuz8q35KgSOjXE71/r47G43cNhIiXheqfMUtksQWaqR6t71C+XGN3lQqCL1h5gPcMJFAHiPJbWE3rcqyA0M1fuGmFEn8FWAG/KzQPQ/d8tF7BzO7FOurupOyQk+N/GOHHdswqC8LXyp9XYhq2HQd2udGa3UGJq3uBKJJov2LAejlFPXKd90L+UHMHm4OTkmL3mGk22Oha2Dr/VO7DyoMaZBLRtzyQdZ5BX0mp3VIBkeBIBTweDW5dM7D7hsJsjtlVLwoyXysDn2RP+fPYzVGI6TiUDUs3iwLuZvraN8+OBBXUYzMGljwJ3RCdL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(38100700002)(6506007)(6486002)(36756003)(33656002)(86362001)(1076003)(2906002)(26005)(2616005)(8936002)(6512007)(83380400001)(478600001)(41300700001)(5660300002)(4326008)(8676002)(4744005)(316002)(6916009)(7416002)(54906003)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBnw1nO3Nv9b7gmhHUzNwskopx027LHMcitEkr55Ep/z0zD7P9yOWwx7fMuS?=
 =?us-ascii?Q?qFx2ur4xK89/Rv+aYeUKv3y6w14t34vbbuH4FfM/X14xLKk+X1TCk8TDyxIR?=
 =?us-ascii?Q?3gU96nK/KeGouPC3xXEKVAtFpG5gvHqELO0nXY5wOlOydewU1EEzS391He1i?=
 =?us-ascii?Q?uOIkOiY7jgKRyTvhC9yvrksHolWbxML5Jkvq7QxrFBn51P6vihZzH6OFRW93?=
 =?us-ascii?Q?OTl+LlsqWnrTwtvO8I5h8UQ8Cb8fmXY2sKNAI4c8uZmbLwzZby83UcMv5uqL?=
 =?us-ascii?Q?9geWnFqGtxrwiW2gamluyyE/s7cgLrqD5/oed0wjCy9v6oT13gy901OQWQj9?=
 =?us-ascii?Q?zN8KLL+ItE14iGPUzYvzq+Uq0uf6s3KQcv2Lyaybg+cbVLD4jxXvyF20Tzxz?=
 =?us-ascii?Q?ZV/3Ll7aS5Grup/CFITosK1cuyusjXdqJLsJ8uxzfMPZLJmL4ns+6NMGOfbl?=
 =?us-ascii?Q?dM2XadEDcRq5kWKmLFjjNCTIeVh+18rO18U44eybmViOckeyW4MBOi53dh3j?=
 =?us-ascii?Q?6gWZmcRAv60e61QK9mphqq4Vpwz5PznuDkxdwlY935Gk6kC3L12AgvYfTR27?=
 =?us-ascii?Q?7SdAzVw7IPvkJYM7GnJIUEpxI4AxP/yGR/jjFPF8qkDY2AdAkk4L8bzLr8B0?=
 =?us-ascii?Q?FMI7ZfkJPvsKgm2HwKjjMq97MhvllEKBFtUKxupMZwuVHPpNaHkglwmY5Sh+?=
 =?us-ascii?Q?8LydbQAMGgipbr2luPWSYabH36oUIfNVkMYhEg6vIa/KHJiTYEGcgr9jgW9o?=
 =?us-ascii?Q?bhkNshqV44VCEitOh2AayzwRkEGRVu1pVwH80jPBOdp/pCaId9kc7BBF4RPD?=
 =?us-ascii?Q?4fEmkohv8yOMZvilOAMGSHiCoCYsajkGGueJhd2LlryOjgn0OEKuBIYqYD2R?=
 =?us-ascii?Q?yRJw94O/DyqtToNbJNsrq4FFe33phJnLV8ay9m5ImyYvbx3AJWGZkhX10v/M?=
 =?us-ascii?Q?Kbg1S1wFav/eoUTSHnHYJosbiVdgE1ldyV+oPiv3TysaeXOIYmjjH85Ws1rg?=
 =?us-ascii?Q?nYhirdINj4uQVxq71S9M88VZgtuQ5sEajlsDSs5vxWgmCiXbsWg/dX/XKcBU?=
 =?us-ascii?Q?NYWCb/16eZXW92AzP0MVZxyQ9aCLUjK7poHTUl4hDL8H4lLk/7KF9vYRh+2v?=
 =?us-ascii?Q?si1z1eAcwru/yU4Yo+xQgR9n0qArptLK6NaVZEwCYxRdyVbp0pLwp2dU9/0w?=
 =?us-ascii?Q?w0gISXQpa+gf4gxnDNxbxOHeRWI3A1g5nWCKpD1MrS/CZjWm50JgBqx1Diw7?=
 =?us-ascii?Q?xkMwWzlnuevz30IsPJbmxLToX8062Ux2fpbyNjYbEM/rimxnajd8/886BGtb?=
 =?us-ascii?Q?FtfqXyi3Sbw6Ir7XEca/CzFVK3drTGyF6uw+rZXHKb3ONA4T4tJENqmdckQ3?=
 =?us-ascii?Q?7/vuXOF2g7I5XhiM9SuJJhJX7R+/HAIcJWx8lB0/VsQFyZsWiO+WpMSIVgpe?=
 =?us-ascii?Q?VMgATkRNyAXX5ky0+o0pu+mZSu/evYq3WBP6JRpZC81xBw3ytUD34PBEs85h?=
 =?us-ascii?Q?v9XN+C8N0ssrAufBW9iyNGZfnzeCpKDXv2QOigNcrQr4SMB6rj5hBhiw5VCE?=
 =?us-ascii?Q?s94x8s/xX/57LzEHw7WXzcIY5Tgopn2LNIWI/A9G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ba2198-58bb-41b8-6f66-08dbba0633e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 18:20:00.7612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ADpK/sLQoPLsvKJuaGNq1gefDMiAHaXq1zmDQxOk5SuThqlH6iFirvzkwDRjRmV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::614;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Wed, Sep 20, 2023 at 12:17:24PM -0600, Alex Williamson wrote:

> > The iommufd design requires one open of the /dev/iommu to be shared
> > across all the vfios.
> 
> "requires"?  It's certainly of limited value to have multiple iommufd
> instances rather than create multiple address spaces within a single
> iommufd, but what exactly precludes an iommufd per device if QEMU, or
> any other userspace so desired?  Thanks,

From the kernel side requires is too strong I suppose

Not sure about these qemu patches though?

Jason

