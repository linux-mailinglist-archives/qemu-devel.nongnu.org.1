Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F8E820ABC
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9s-0002Er-JK; Sun, 31 Dec 2023 04:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9j-0002DE-LP
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:53 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9i-0008Lb-8I
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkEM9aZ9yvLLFAf2wMvP76MGvCp2T2AlpNlnuATVfXONgSrsVyB3HL46L9V2D+xc0CKK9JRt6lUWe7EvUUxi9LpsVotX98WI1MZv9ttD30OYAIze9ZKjFELaJLVzYden00eNNbCYbALg/KpXg1YtVQsQDqJ8TnQ4E4/G5EjRrksit3sssBWEEEftRNDOKNwBtDed4yqWMsSboSvjXiJvtLBAOfGFYbCcoUZ6oHLA6A6L3VvVE6o0Rp9tiIB+azwvoevmX8PgLN/EByVp4Gxt3YXixiZvMOe6bUuEm5253sEKXBPChwsja03JRaCrhGAU9PTPfaBfpSnndh5GBTbztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E42zdn25+nfLIPeNKPO2eTdbrr9Fh7hBrlg3JnGglJ4=;
 b=NJ49noLectGmGqPDJAodEl656hazxknx7To+GcFTQW1tz0gM2mlWZqc0ZHzV/nkiqvPuTXBU9gD345oqgOu5IOZZcsrBX1SY4zrjjEfyZmth0DSAMJ1M1+Y5qehouRX7j3ZDLge8SJEfx2xspyLPc+Yt6gF/ANQDVZXnM0YSO+BQZXBLIorKgZeqJCka2+wr8bQ3qeBMMiKKNPGiElHzo3zvx7POdsIx4Cj6r5MhWyY3KLIesQy26fLwrutRQlRQOrEzcX9SQgEGU/2jzMCMpZid77y8+N+fponW+W1SkzdaRUGjs4yXRze7QU7QKulCvvYyB8YU17vleEQAS6Rtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E42zdn25+nfLIPeNKPO2eTdbrr9Fh7hBrlg3JnGglJ4=;
 b=j8vZWLIrZhLOnEJmjc24FkE3IEMEGh8nxT1yMNCYWbFINv4Z2i2x28f8/qpltXocdf7/OuN5Cg6VDE1R92I+4B85WrCqWJBkBNNVhPf+W0WfT8bPOYthBwHsG74PFl+Q/H1LWbow+j8uIr/ejKIFMV2XjMv/kn4Ybnk+2d2dn5bgBtIZJEDT5+3kpCreS1QyfhpabfN3zk/mDTS4RmiyzEFW2XHEAKMu/mgoBGfzRA0sSil/CQXZm/71DtQhkzbJeQgcKhrZslwrw9jBmFtMPvIeIca1ymz8JbCEW38irEEZKELJgN2LdEd3HQcRUlCRaXOH/LOt2qeZaX6F0np2vA==
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:30:46 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d2) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:32 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:32 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:30 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 05/11] migration/multifd: Fix error message in
 multifd_recv_initial_packet()
Date: Sun, 31 Dec 2023 11:30:10 +0200
Message-ID: <20231231093016.14204-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dbc632-e294-4109-0104-08dc09e32ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grmkKLvCSpswyhtL0MFzA0HQIMET329CwzAFeRlncREQDhLaBXIFmC+Sp7V1vDqx2vC4vHPg/5+Ljpx1tfLrcrXTg6iYMi1AwqS6TKBZuxFpacEGTxCcCFmlGQsynUlGeL8GCSeEcHLe1hxkhYgdpvoSzzAClokNzpBgVgx0YNJYBHB7+c9uKrssTdwCBZ/ciSIFmgcEr8OT7Q/UyscUX1JelAecBFqYrZj+ISxN6un8wLlVNpIPjpQ/V2YqNrB8nsra0RA6dTniW4qVAdJ8BJiFaU5sF8xuJwglQH0ls6cOpMbSezeAN40xb4qCw+hSzgbubi0IuTkhHeo2yLhILO19E+fXQhsmu2VHq3tE4fmRHVWttRxV9EuzeTg7ySqRegYgOO91rvJKcMlBBXs2ilx8bHAWW0tmGnamcOcBmVg530f2vlG249NYBvuj7qiYrfLjOJXNAIKOkweyGaV9PP+zWe4btxL5/gkVVaP1C2faIPWAb/G9+X0gStREf0DV4S657r5kjosyvOyH0ONq0F07aOoZeanGVUCJFyQ5Q85A4nBMz9bJURgNmUe0qSzhLp9svWxFljH2fxbvD2hGp20+X7d5wJvZ0uOVggqvlc82Bdy90LKuWi6hZtA7SMFjO7PKyhZfxmTOiruKP7aEYP6pu2HZbFHxGU56QPlfQcBBLW3XLn9j+oeltmIJiOrs2ZIKOB/L37p65rDQg4C42m4E0j0iQhqY/meVvoU8mcftoPlPuIKfGAOnl7kqAEvb
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(336012)(426003)(107886003)(26005)(83380400001)(1076003)(2616005)(6666004)(7696005)(36860700001)(47076005)(15650500001)(5660300002)(4326008)(4744005)(41300700001)(2906002)(478600001)(316002)(8676002)(8936002)(54906003)(70586007)(70206006)(6916009)(86362001)(36756003)(7636003)(356005)(82740400003)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:46.0616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dbc632-e294-4109-0104-08dc09e32ae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

In multifd_recv_initial_packet(), if MultiFDInit_t->id is greater than
the configured number of multifd channels, an irrelevant error message
about multifd version is printed.

Change the error message to a relevant one about the channel id.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 409460684f..a6204fc72f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -228,8 +228,8 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     }
 
     if (msg.id > migrate_multifd_channels()) {
-        error_setg(errp, "multifd: received channel version %u "
-                   "expected %u", msg.version, MULTIFD_VERSION);
+        error_setg(errp, "multifd: received channel id %u is greater than "
+                   "number of channels %u", msg.id, migrate_multifd_channels());
         return -1;
     }
 
-- 
2.26.3


