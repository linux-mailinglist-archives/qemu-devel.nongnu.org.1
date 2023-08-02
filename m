Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AF176DAF4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKfI-0002jn-1a; Wed, 02 Aug 2023 18:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qRKfF-0002je-AW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:49:57 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com
 ([40.107.220.71] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qRKfC-0002gW-HT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+jcxkP/d4QIJIKMSnHougg7sJmzpFaShLrwhn3cBKRhNj4Gy5Yv09zI1r3nuWM13RaRGZX1q7T8JTn0Bsr79CpNqYHwQhRR1nmW/TaTRpgMMsafm92nWFM41dGVqXsCZ9Wn0GcF0DW1dLgf3tYJxUSYfxonoimkS30Z8z0zOP52a1EMmDLPYnJFa6SxCFVJy9Nl4/WRRutJN0CZEa9LNxiQwr1SBY3bjrSya4S5AkH2zn2Dt+j4CxHsAmy5pazfH5HkPCSdYhW+yW/P+v50GHMRtuxjoX6nSyqIHS5Irj7FEL42170unVR+R4yetAunZuRGcKl1BUkRqLetvg2rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKmEIDYIfCTtDjxqSRPgG2/s4sphI1I6hrfBDQJtv1w=;
 b=mbvY5TI014LkQrlEJX5ncn1WlvaRNASWp+q4X89e82/MuFVZYXaR9by1BmrnM6uAsA/Dm8K3wJXTMRZDddChlDq6h8dpoeJiUd8HGa6u27+VyTu3Ib1YSZTtnfsK4t0gDDbT8uiKvVoe9uj8crihJq1X7BSJzpFnYjFu4yyc5mySxdHgySBbnf1qJfvuu32hwuVr+OCJiJvTPn7MZ2IrVyjJ/AWA3gKmEYiBNVHfEL1vYI/PSVaAHiNfhVmDQe42YhwORd9tYOTfNsshaYKG55MX7PpSLpsVU6cpE9W6T66eukCFG7FwQZulls2EHoLwSyyfghIiGaplgFaqn+C34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKmEIDYIfCTtDjxqSRPgG2/s4sphI1I6hrfBDQJtv1w=;
 b=m6AW30kBzcoloJFpCr85BAzOlR82e7kocZzizm4WFRNS4K8UUjq2l+ljbPPbpX/VHZbUfBx4RT1KRlxqMc807nP+tSMOT3UVGdY4oEYTdlbAGCLOlS5CYRjpxi0GcdXhaJkgQzq1ZP96FBuJzyvOyKw3MydyiKgEBju0MN3RFr53URk0hna0RwDTtqq/EGRZV8epazGV8Oh5T2F94clJOPQWXEB4sdqrbzOXbC3S2iFdVYoVtqKPO33UOGdj/56xQDTepQLdoG2vw4hbZqIK1JWTVI5IW2Pm2pX2CbWKrIyazJhbBUy8HPL2bHmixHAoo6LdYkiBogmdSd29l31vVw==
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 22:44:49 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::33) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 22:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 22:44:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 15:44:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 15:44:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 15:44:35 -0700
Date: Wed, 2 Aug 2023 15:44:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>
Subject: Re: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Message-ID: <ZMrcHDFfAxtklauC@Asurada-Nvidia>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <SJ0PR11MB67442D288CD3705A0705CC21920AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67442D288CD3705A0705CC21920AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 016438d9-72dd-462d-7fef-08db93aa13bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VU2CnRZi6tH8+/whe2+zT3CdB9Ik6xDNld8e5M3jsSxv4w5gL8a/PhfV4/tG0c6xEb4oQeYpGtWxhpMacJ2X8WqPkDT6JILbO8O9FVgMmzHfQwpsVln4GWS7C35pNAQukQ5jlvddf5oYlj93S4qm4kuAmATn8JiR1ZMwemfAJk+Zu5vb0SGeyOdjozGmkdWaDToWIEEpqT4cf8JpvqlZ6LsmFzJ6d/THM5SfrdvRvGJnHue8eFnDz0u7MFUArKb+z4Om6RjT1tBcwNFEGo54Og61P8mofclDoI5Scy3nXrhmwmK1pmq4pAZb808k9eaMfyMkJG6UaHp0tq9Wa2KDGYsW/nq1+78h2/x0aWIT39kFRhBqkX4R7g1S7M2bEft0G1n4EWSDsPGDL8hIJyF5aYYBVG+DHQT36F4qIvGmgWUlKv5VgqxDwXY0Je9wc3xm7OoiW/8d/uhh3/XVlc1rym3HEvk9FfKpqHXxGZRSmHv5zyzYA6+eGOqViAOHTqn5//XKYhcg33sXW/Mknhz/O/zdamDYk3wvEQyyOz8CQxSzPgHPit3mJ1odcgHlln2pGygmJbP4iRlzIKgO9BfUCwDYVzOGnPHyO6x+5loklIU1hLlX5IjO6KmN0l152Zq0ZTat/Oge1pkcnJMbGMK1lvxoBWsayzdGBK3QrpC9y4IcojlxpnNwFj1bFUoEGTZ6Unk3aysxaXp2ASu2t3n8MIN7KckTLUMl+rRD5uj80OQTvq6dqlVAxWgnMv6+vVvH
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(426003)(336012)(83380400001)(26005)(186003)(47076005)(36860700001)(4744005)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(7416002)(41300700001)(8676002)(8936002)(9686003)(478600001)(54906003)(40480700001)(55016003)(356005)(7636003)(33716001)(86362001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 22:44:48.6898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016438d9-72dd-462d-7fef-08db93aa13bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
Received-SPF: softfail client-ip=40.107.220.71;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 01, 2023 at 08:28:01AM +0000, Duan, Zhenzhong wrote:
 
> Ping, any comments or suggestions are appreciated.

Zhenzhong, I'd love to, yet haven't got the chance to go through
this series. I think that most of us are quite occupied at this
moment by the kernel side of the changes.

I plan to take a close look and run some tests next week.

Thanks
Nicolin

