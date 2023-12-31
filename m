Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F054820ABE
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsA6-0002Nr-GC; Sun, 31 Dec 2023 04:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJsA4-0002NC-8F
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:12 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9x-0008Mt-5W
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP+hvJwrEl2hC0wpw2E8Z7CBdNUkmPSVJIdr6LUpwHtaFd2WR8Mj8AZ0kciRhFDqT3faGMhrryNH7JcWwNbuXVKEhSsl/Z8w3CHeiymLVLTp+2itNVmQfZzbz0KMD5C32MFZNT8Q7uool3K6bs5qVx0T3rSMGjpb1pghIQxUnszOE4klKEoGsppIaq3INLrSNcrPGT735isPCWdfX3yoiYwP9ycXrGlDTXthYgkrO6b952+dYeidZ2AbnooejCrKEmrXvHZlP0XqrwNK1GfMfM6HOoxq6H3fSfiZrNY6fNU5tdkDVD2pD+EaGUCLqimFibFGkNLAOUDtJzS9akKerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYe5CAtagiSzoe1ZtZytJGDHbG6roK6CmwNc/PwW1n4=;
 b=ZSu306lQxppMrfSm+jvHSEFgBEFn9rYmQ03/fc5NPzVbAFie7Yxj4Uixb1hNgQWbDg8h/4DxFpXGzTnQeqm5Rze7F5dNoi596Zw3oOUJ4HCIsfD2BVcwoaNokm+SLr3xDgPc4Otcng8+dNQdkbfx3R+fn20RB9nJfNGo5EzEdxGpdfqJHqdOdyaT7a0lyp0Um2g3x566Gh41HqJjbKeJF1S0JvHQBlFZiy/ZrIivADbp0N0RLbjYYPYvQnTEAuQ/xUlSSa/AZTm3AWxNHkWKPnfdIT22wenWvh/w8M0PkNi383jOyWUbTecj4Qp0E6K2d3wG7CBo+5CqPsOefV+nCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYe5CAtagiSzoe1ZtZytJGDHbG6roK6CmwNc/PwW1n4=;
 b=Os+5Xq18Ki6jSqkj7wvInc6fxzVEk+b4NWb+JHuz1ofOsFGi1RY9ulGzh22EzjrV6GChh0bpAwn3ASpUZQSEuYOWtgFdDwzaJQfbndssFgiuNjiNDP/hK+3OhocpwbndoK6SOTc0ADeJV+EA7Hn55fLSK/IMNgXmbxZvw037Wk11nLo5aZGDxQECE/ql/VwaAoS2lPRau+kNxdE4Db/qNbFtr1ygkUg+m2SP6g3z+Bk25oB0BoGEOE7vl33CuR3C4WGxF2x6cBzPK4SSyLqO2ZwRI+mCOZk0HnwGDDu002APyN1sWoogv91Nt0lOxmx2xQO/xaEFoItN3CDNitThvQ==
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:30:59 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::9d) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:42 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:40 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 09/11] migration: Fix migration_channel_read_peek() error path
Date: Sun, 31 Dec 2023 11:30:14 +0200
Message-ID: <20231231093016.14204-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 75083d16-353a-4aa2-b975-08dc09e33251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Wcco9iwMGdfUTg9napRtOTIS1n6kyHkjyqf5PuojSLTtlZoWw2zQO8m95G/VFvwqXFrJl/+qJ653DqR/YOO8DXxGlOCBPGSNVkleBB6GOWvoAN7gnU+GiVYoKnItYM1eCl78e0u7tVM6vZsvPC5o75390uY++q59R8ZhMVwGRH2R6DH+kKrymw2Iv43/cnDoMd2a3Z5dz5HjrLBax7Cqkzqs7C+RL84xwdOm0Xpz7Dlwrb2U7YBBFLFOa0+4XGoJfpokSM68rlDcW8MCb8RyrWHvpO7ar2mk+4wVcKA0EyGyTnjcIxKUFlE+RtOhlAr7GkgU4+vtJRj8k8wR9sIYWJrAtIqOpKf0cZzuMA2FPtnG2meHUayDIF5qpkuY6V05RAfZFDDRgpSelyuiqA7S1Pds1ZE2wDhscmgBvMu2PM28G/GBGl4EwQEuEP9QG5AYX9WT10uSttdE2nMA1Yeek0K8y5YFLy8CLnwlKZNhEDbTby0OOC3x6xvXw+2gHj8Y3w92799mTmkTsnZq34agUX91OnU4f/acFUv3MTeerzjgvFbTuUFvjalH/LD7VTVE3wNOmQlur2/f2PT8NQRMpoQDNZOAkB0Ziya50t1XeXmECNSsFMxgfhurEIspdYILOyKWXGZYdfWNvkj6V3FOS1x+/SFcSFxbBRH91XdeswgJXH0a+n0fRPB8GgKOnmwBVlemGOAF+J6c3+dL33kYZOTCK1+yeTP/EXTG6+urscQaRu+qkd6+9wnTTpBWkBI
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(336012)(426003)(107886003)(26005)(1076003)(83380400001)(6666004)(7696005)(2616005)(36860700001)(47076005)(5660300002)(4326008)(41300700001)(2906002)(478600001)(316002)(8676002)(8936002)(54906003)(70586007)(70206006)(6916009)(86362001)(7636003)(36756003)(82740400003)(356005)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:58.4648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75083d16-353a-4aa2-b975-08dc09e33251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

migration_channel_read_peek() calls qio_channel_readv_full() and handles
both cases of return value == 0 and return value < 0 the same way, by
calling error_setg() with errp. However, if return value < 0, errp is
already set, so calling error_setg() with errp will lead to an assert.

Fix it by handling these cases separately, calling error_setg() with
errp only in return value == 0 case.

Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapping of channels")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/channel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index ca3319a309..f9de064f3b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -117,9 +117,12 @@ int migration_channel_read_peek(QIOChannel *ioc,
         len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL,
                                      QIO_CHANNEL_READ_FLAG_MSG_PEEK, errp);
 
-        if (len <= 0 && len != QIO_CHANNEL_ERR_BLOCK) {
-            error_setg(errp,
-                       "Failed to peek at channel");
+        if (len < 0 && len != QIO_CHANNEL_ERR_BLOCK) {
+            return -1;
+        }
+
+        if (len == 0) {
+            error_setg(errp, "Failed to peek at channel");
             return -1;
         }
 
-- 
2.26.3


