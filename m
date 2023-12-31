Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243D820ABA
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9t-0002Hp-Rp; Sun, 31 Dec 2023 04:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9s-0002F9-3g
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:00 -0500
Received: from mail-mw2nam04on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::607]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9q-0008MQ-33
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUS/C27bbT1/JGgpvGtmqT3DuvcAnR48Fx1sGZDX0eoa/j5iCZeLFCW5eRjJkhP7YMxhaPnAAY2KSxv/vZSWuItWDZfbXQuXk/86F9bN0RzzGMUuiYeWEdSyTLQ6hJauCr0DTxRZfVaZ3dMv5FGi7j1uzECKaecuOTtjXFEQn7qR71yRUvUutpl5qkg5YUmFy2QLIF/nk7XErKPWjvjqnaJ3YFNdKv8lUd+8ZOZYHnBOVzoFv5GYlUJDELATAgxrcPKUv6kS0AxF8kFcycjvqyxrXXA7uafDLQ95jo+FiC4o67/9Pl6LPvpUf69d7QfihDLMzWupKC4RvuXnIjR+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7bw+w3VI+IUjmhnR3XMJ/dv+Ndf5bfY8a4eE0di+rk=;
 b=SBCzeKC138OQTbz4574krOqtPPb8tbD0jw1VevKl4rFnHS3LRWXIftx9dvRn4Ecoy83JsxTswZbpNmawzVbran5wm9DvTGrAfXDyd2CLJdpcxNUDQa3C9foAijbQcDPIvlwMCwIiVj97G9xQq9YHeWBxfi2Bc9KIxO6By7Z/iDMoXFoYgjHPnr897JGIUE/sTIcWtkGX478C/VwtWU2NdcIMO3gB15suoyw1kbgdeLZXztgHg1QSWhb9Pq9rHb/wAvmLzybCFTXt11jLt05KJRvMUxMR02uhAQ3EkcdgVRrej7k7ubHVX1EdD0sjU1Q/pi6fTOmEwOFxbfTGsMeLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7bw+w3VI+IUjmhnR3XMJ/dv+Ndf5bfY8a4eE0di+rk=;
 b=QPYlrdmQoPLD+RC59I7GGK+TjiFn7M8kNQNMpdejUJLIYc7mYJw0/jijw4J6t7qMVz+Ia+q2kHxuKl0uMANIt1IPuf3LAkN2y3Uui5TjNjY8q7SIDX8mkVkSnQekCngbZwrSPc4slH5ir+PQKpsTAxuvOPwMlsCpjPgRGaFh6MrtlQxy2SgtCOzhIeT6Z9Ip9IXLIivrFL8EpEoYoE2qsYWUnmcc2OgJkWIaIR0RyZ0eJqxBAz8UBgsvwJEi6GlsfFWaNFTE3QPKROeST8I8BIF2bqtjAGhqCd6R/ONERWjqEQj8miLrrfa2GO/ISPsqzhkF6Pw635FOqtoFHpezxA==
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 31 Dec
 2023 09:30:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::b5) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:35 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:33 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 06/11] migration/multifd: Simplify multifd_channel_connect()
 if else statement
Date: Sun, 31 Dec 2023 11:30:11 +0200
Message-ID: <20231231093016.14204-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dc058b-01eb-468f-f4aa-08dc09e32dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk/o5tF/8ur2rLIugkjW8HH62RBZec6jlg4j++hzuC+9sVpkv3fIEL9XMF7WDr3+ZF1bRHE0y3U77aqxqHmVTfNSO46CtIF6TcOSrKRODyfMV9EvT6nLEcLHi9QasrE818+GMfHORiLmhs7q1o/9s3NEwvDUDwbKsblVwigSZghBACsIVEGEVEnur2bl/a9VOWwQRNavuNza2bVAhqpEgFp36bygov3T1BKqSgvSnInJJfwC7P/ul1XH/YBDZiX31hEm+dxj6v9NzBwzSewkNKqOsKGrNMddhdV4d35QrCh5D/sv5e74PNej8J4m40g/kr17kPJynAOEYOlCS/od0oBxVZzJqUR10r3qb41GVjWeNCqP1l1FU8pRXnMwt3kk8wJLiwSukZNK2h3WqyEro65kvozWJpEVV/kgF+saAxKtmUlB9wOF7Flv2NUmSXQs+Y0RckTGVgPP+B7g7btSZSO9RaC7GLI1NyVz+Ms/La4dU//eYQUhWpfnb8VD8URKOo5VVlHaS1HR0wQrJK19Eo/8lE0pnpzmUavUBprVJ/53p2Omc7OeZKZBtzRHY8adynsDu2w4MqujV6nsY9jvGOihOzpM6WacsDFHOByjkLLcAEafnrhKN8/39LIO72evtRSeFyVyWw3JZtcFEqvTjkNyYFhDimbUrJChcnwYQfuNzUeUr81pxHhiDwfB5NCSJ7y3c/1sg1RBd/MxTfM1jPH3Lbn/xac6+rgYeSPrV/GUzrYE43qeYACqDabGnMH8
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(7696005)(54906003)(6916009)(356005)(40480700001)(7636003)(6666004)(70586007)(70206006)(40460700003)(316002)(478600001)(8676002)(8936002)(5660300002)(4326008)(107886003)(82740400003)(36860700001)(86362001)(2616005)(83380400001)(36756003)(47076005)(336012)(426003)(26005)(1076003)(2906002)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:50.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dc058b-01eb-468f-f4aa-08dc09e32dc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

The else branch in multifd_channel_connect() is redundant because when
the if branch is taken the function returns.

Simplify the code by removing the else branch.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a6204fc72f..55d5fd55f8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -847,14 +847,13 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
          * so we mustn't call multifd_send_thread until then
          */
         return multifd_tls_channel_connect(p, ioc, errp);
-
-    } else {
-        migration_ioc_register_yank(ioc);
-        p->registered_yank = true;
-        p->c = ioc;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
     }
+
+    migration_ioc_register_yank(ioc);
+    p->registered_yank = true;
+    p->c = ioc;
+    qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                       QEMU_THREAD_JOINABLE);
     return true;
 }
 
-- 
2.26.3


