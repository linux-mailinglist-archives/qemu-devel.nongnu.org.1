Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865AF820AB4
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9m-0002DB-Sa; Sun, 31 Dec 2023 04:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9b-0002C5-VX
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:44 -0500
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9Z-0008Kn-Ev
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLcbFRYzsZ98FlzpK2qmCvRbRC2gBwRJRcN04GlTbHOKN5pelpRpTbrRr/IkaabhPPKPIpb8E6kNl+De7N9IjWAYlb3tU5qtjEkIHQ6zZ9cf2rIp3DiYuoCVyLMgeWOjCWE7sTwiNLq6Vv+lw56uU8mGyjucSaPPnhoweWIndKZFVvZfSzcLVGJ7oYTnwCwU8nsiwkuUDkQotLPSm9jXe9GO9yRgohW8vtRV6e3A9U2ThwDwfBVsxMnowOgxAcnRmiHlHAdMUqq26LIbEyNax3unroiNtfd6nW55rUAoOCdKUJ80Eg+udlvHPE/QRcGC7BA9OI2snMo17SPmxUAxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdIo33Cr60+SuFBvvBM2M2d8TGnpS4hOxhdu8/lt//g=;
 b=SezXtOTl9FelmZ3DfOAB4FRCBgGprW+Xy7Mlv8PKspmTT7OhXsYdoV/jswg3UWf75h54TlWFrOq+1NvIklA+rZeG2gFx1GLgcWskMl6p76xV+KXH8pQI/jI8tQSQrhYWtiSnbdMxakSUJ7Ytui+m3mWThZyvHt4RHdqkY00T1SREKYj2tlf25lUhvdTk6V1GR/8oF5LZexz6l8RXZYz4a2ruF1dX5oSgQc+bvwSp68R06D66lDi9kJcT3EVeqfgj0HB8YjelikXaBwDMO3c8MIu/OoazRGBGAbKny8hdyLgL+Dc/ZilGi1kbW2azHF9mwrKPl1G5HplFHvpE37hb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdIo33Cr60+SuFBvvBM2M2d8TGnpS4hOxhdu8/lt//g=;
 b=D4ObncjqYgLlbqSzRVi4/Sx+hx3utQdv2pxshvwL1qL5o7sPKd2njClbsqfg7dwjt2sMDl8R9y8h1ZdbezH15f7gJUTOCGjR6O6fqMRyvnwVAWMqtY2UOvg5q/DOok3PJxDZKExNtqMmBWsM1sioJzwOB5HFpU8HMp1LMjIsm7wQuOydntMVYfrj6GO/qVn3vwyCehTDFs3++CbcTRWHoLlSephCMlYwcqOXZ8fh8WOlncMnMHjfAByluKrtmvRSg8eVfy5mzhT3sEn2OATBbew1vXPCZrD7u8SHbOt0uCMmmkjZusV1wejf5WKWRDJaWJd5T8XeQR2XdSUillTL5g==
Received: from CYZPR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:8e::28)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 31 Dec
 2023 09:30:36 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::b8) by CYZPR19CA0019.outlook.office365.com
 (2603:10b6:930:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:21 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:19 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 01/11] migration: Remove migrate_max_downtime() declaration
Date: Sun, 31 Dec 2023 11:30:06 +0200
Message-ID: <20231231093016.14204-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 218722c0-83af-426c-f0f9-08dc09e324ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9p/Q8qSk+lWOQtrnFpOmNAq9vkvYKTPgQBBo6R4ZExZUUMsegokBV0VmD/nPELsV10bpQdVfVVlzM1SvdCh05G8MnOlYhd+IxzfaGER9Ft1btzgWQfO4HQtxCOfhW/lTHTdbNceYg4kIJ8O5JtzssOkJ3L0w9sfvAofRyMiO6S6jSmond/RS/OtlfIUV4G7F62PSe/QF1TifXKZHLiebq3mXLRx6dyj5DSBxhs2O7aJZu2QeUzGEiLG+8M32U52LjicTc4TGKWVxIyjJ3o2qheLfxJ4caNY7i4dWhl/sVO9eZx74QA9NtogvoRnCId09WlkuPT5cacM5hSZydVi0PMjOILk7OXH4LnVwojWHb1XU/qzKd9uU0IwIIqDcXwftA8AohbGg+JTRFM6PdlYUXt7K4y1Qac6VlUfND4gGqxebXfwKTkzvCaJiWiJ2LNP5TGiSekFzgzczFokOBDneYWcICSAPGMerrQ5DX0OzRKoXccoLSCTFPAoTUfa3fQLMviKIQV5Ouk9Z/Lwm/GHFzgyRd6P5f8e/Si0YmxAdB9Kxq2/bHaJX2zthaN8gMlx1iA3RRe4jlR8svsotWycJTBP+9OIb1bvFrDeeUtv7dsfj3fdsuAmndrf+86gc9dM9BQ2YKV7aD6Psj+f4OK6Wxqww6CmsBEwznld34MwoE2LXkL/bK9hpgC+/F6vzVKFwrAI7jLxfzkF+Kf5zLQE/GydoBqSqd2Tn76dgHzTHIRklt6cXuSGM1MNGp8tcbtO
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(7696005)(82740400003)(478600001)(356005)(426003)(6916009)(86362001)(336012)(107886003)(7636003)(36756003)(70206006)(70586007)(6666004)(316002)(26005)(1076003)(83380400001)(40480700001)(8936002)(4326008)(8676002)(4744005)(5660300002)(54906003)(40460700003)(2906002)(41300700001)(36860700001)(47076005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:36.1653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218722c0-83af-426c-f0f9-08dc09e324ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

migrate_max_downtime() has been removed long ago, but its declaration
was mistakenly left. Remove it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index cf2c9c88e0..b3c9288c38 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -480,8 +480,6 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
-uint64_t migrate_max_downtime(void);
-
 void migrate_set_error(MigrationState *s, const Error *error);
 bool migrate_has_error(MigrationState *s);
 
-- 
2.26.3


