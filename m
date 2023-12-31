Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D449820ABD
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9n-0002DL-2q; Sun, 31 Dec 2023 04:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9c-0002CB-I7
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:45 -0500
Received: from mail-bn1nam02on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::606]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9a-0008Kw-QZ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f69Bkp7B35ZExfJyVk9hZIETNQobMjP0H9yV/T7gUTCKDHBNz2qEXVbSzGV65BKPxHz507aHsoAEq5A2YUGMiMOTkESivuUojPesspEzSt0zKsjiMzsGbqXEjbYZ4H8B3pmXYajUgxSnZQMWFWAVC/UOqzo+SjkXtcoiEkXcQLus8cR5fNufyE4WrDtuSLYpwTeLPlHvMqgwbjeuHZg8eO/I1z3J8U4NUX4NBWP7suF9PJSKHFoozJcy4yehFbAA6vdCee/bfkLAqTH7kqAsYkeFI/mbv2op4fRVc6ALVM1kU8PORFlFtVDK+2veHztAh5EyrzXS3AMNSBGlDSYNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCtMpOL+kL48xKZQbBiJDmBJVuOLVM6GAtZub10c0Ls=;
 b=eDM6XdicpXHW6i/jCaLuya8IytGXq8BeFVE7ycHQhaObPw3Fx1JVgbN+yNcfNuBvizHYwtlyDTQsvf5jzf2s/GQzLFhbAN1KGVprH0gKH8x2b0GVXcYUQzRL6AyKhceb/LsJ61mqe6Xhu8Qtmcw12wdJnGwH1AcVSVP/iKmEeZv1uU2k11zUtSrkB0YPWGV5rtilDim407IdcGPg1aOZ5/b8wzegQfQ0ezjeVZGpdw6OOSQOF/2VuhFlgigLoDXvpMDtB6JRqev3TpGBoDVn08ek7mdeHUOIppAZWQyRCsLFm7eFSDtEMdkpN2gK2g9MdNmdC8XW8T20pJPeQ52oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCtMpOL+kL48xKZQbBiJDmBJVuOLVM6GAtZub10c0Ls=;
 b=i9yz3o5c/STu4rSGF2fP3NwuwygV7ty7dd49j1hh67O+M5vmZI+0menZsfaZ+9Laapmq5n32pIf9hyenb1/J3cYvqHO0OpOwBKp+7l/Ps8/0qFBw7AU9X3saxVze5Lsr5Xb9Oha8A9FBxUACZI5pxexAVqv8bttDEUAD0j9+D0FD8LDWhOh1uI8wTnplxs29H8TKw8kMmFQy8dFo6KbsE1wMB52Rl1L8Nt7m9IfHFtjgRG4c5tOE9+v0Mm3sITEMYCGwSJwhZ5LTcIb9mQbyvxC+K+qBQxDJwShjF+iCkH9p8rWnmjj8z0VzEM+rAQE2uI/DgHZWRlQ6GszwzL/NZw==
Received: from CY8PR10CA0006.namprd10.prod.outlook.com (2603:10b6:930:4f::29)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:30:38 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::4) by CY8PR10CA0006.outlook.office365.com
 (2603:10b6:930:4f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:24 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:24 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:22 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 02/11] migration: Remove nulling of hostname in migrate_init()
Date: Sun, 31 Dec 2023 11:30:07 +0200
Message-ID: <20231231093016.14204-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BN9PR12MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ca53f5-30d5-432a-0add-08dc09e325cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrDgxt+3i2r8boxdfWLdOEmGtZNKYBudkrcQKNPM5TNsDQH1NsGpt06r6NlBGHlebdZrbtOEqqD4cJxEE0K80Bsp+jlpxUtYPWY7lvqG2xDsb43aN2tqx/cZR09niR5F5sW7Q3V1nhKidW8dW9pW1wy8sCkZE0FkK1dFMeDFvTgN8B/XfVG8bUy8hHo5RqBZRoomNBPzz2o2BrTGWcegI7sXUbQL22Ji/RJlZ2LI/RejfTD46uG8Il3y/isioiLA+Tzi2LadUyCgsTPUNatL/oA0+LF9dCdfJuTd/hO46ctA2lmbP7Q7Pf5xjo/viWOTgjwn0iytMAF0OVVfKxDfKDPz8u6D6pYyOL4kCaxR4Ho8iJoZm/PYehWxEI8vxhDEDKPuByclU1T9o6MtnUFx3DkEIA9eL/oZujq40lhI0F3A60fUhZOqrxV3wWAfQkqmPobOe0a3bq8xxnbSqNUXOC2w+X90/FgLKPfQz7XvCNZrDCl8mHHKuWM+XwlfzXEK3U454fCKEc97YoTsdRdF1o+hI96kHujCJR8RSyHAe7fCapaFFMUF02LZli46xwECO7N0V/1OEnin+xvC8QwIfglU1nNnkmui6a9VEjuA4t9B4GyMeaJhdvHqmzElN0Fp7GGki5dYXHxJSbRTTcnFvZy63qpf4m1+DBrU8sDfB3KZ9wQO4HNtyhtMNTbRtqZ7LiBXmWCxc//X/HXFyI1Ub3ly714U7ArBWmCbsNYh13/8UYIMNcLjA6OiZCBf17T3
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(107886003)(40460700003)(41300700001)(82740400003)(356005)(7636003)(6916009)(36756003)(4326008)(86362001)(316002)(54906003)(70206006)(70586007)(6666004)(47076005)(7696005)(336012)(426003)(26005)(1076003)(40480700001)(83380400001)(8936002)(8676002)(2616005)(4744005)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:37.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ca53f5-30d5-432a-0add-08dc09e325cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

MigrationState->hostname is set to NULL in migrate_init(). This is
redundant because it is already freed and set to NULL in
migrade_fd_cleanup(). Remove it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2aaf..1e25d7966f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1588,7 +1588,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
-    s->hostname = NULL;
     s->vmdesc = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
-- 
2.26.3


