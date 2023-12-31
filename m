Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC473820AB8
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9y-0002Ju-JZ; Sun, 31 Dec 2023 04:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9x-0002Jg-6h
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:05 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9v-0008Mo-GR
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5lPePv0I2wKjHaNXWA5Qh5rMKPXHQq6YcAiUYEr0WEwCtagNG3OSTUY9ddBAV6ZosRKOV/Qrye7yT+oRd8dTxaMc4mbagQj9h6SDWRPxgLOKOMZnrwWQnLI43B/FxCOOnhhKz7UaYr3XdPCqMYVuoLVH6NZ7+ylxa24FZKFzWHhoLET21zXwyOMmM4W4/gQ1rj6zPtSI9wnbGtFFqGRC/PM3w5pnG/JUuiHIeUlK3fstCIK6jW/2FMd+sMZQCVlBdn/1SFUgCAkxt0dHODoJ/ZOtAlfxi/pXaDmRhCDaj5OmOc3JETlUpGzN2NwD+ztUJ+EUx3q6tmPH7LKprXT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdDmB9KpRrH2AQ0tZ21aZr5lp2apV2SVGxjHqJcRA7o=;
 b=dfX4n6ID5xjkzkIYiscNtyMQM/2STDQrXBXJmoNzTL3A7NjrfSBqt1jKOCohJl93TVWxAlDp/Uul6jOShY8Zzr06G6wZaCFtpg7L/btwQHFj+yVJ5mHBHhdan3VbV4DBrJSlbeq0efud5ZQGtr0UuHji7XGpGm3YyvBVGEiBfDFhJJ4X6V71W75T0J33fEmIJwQyhlAm4bGlJ9my97vb5P5M9PbuO626MGSVGq1c0Cvx8iJP6IdMgahiobbaPq9WajmmSVJG8VYC9eOQ1QXAHYOu+4Lkpib/9RwkIfYUykABGdjsX0xxb5XAQnnp1M26XvIBWMVwc04Rgoe9HDfc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdDmB9KpRrH2AQ0tZ21aZr5lp2apV2SVGxjHqJcRA7o=;
 b=ft3FRvt5aD3LxdTkJI6rz/nNXt6VPTlR51ryPDE3rHMASnFxX4sGcv6n503p8ueiocJ/M2t1PBmJmBNGpEozIUyuogSSkrJTx9ozr39AnBgNXio2RDTlSkiw+xc+tG+Wz8PzU7aZme7XMpo5yNJlfb+kKKuv4Y/eFkQ/3TrCXEu1xAakXMZxa0SuZpLmQafVcGigvu3E500kU8CRFOlFgZmKCcvRgaBirHGfbakEc5p/ahK8zHONzdkkBUE7TDy8V2LhmwMCD52avtEMfXASGk5AfpOzJQNo5kWJDO+1RA2vmju9C38rT/KAff9+OpUV5hvPcwoWpa9o+SpkO7iyyA==
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Sun, 31 Dec
 2023 09:30:57 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::ad) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:40 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:38 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 08/11] migration/multifd: Remove error_setg() in
 migration_ioc_process_incoming()
Date: Sun, 31 Dec 2023 11:30:13 +0200
Message-ID: <20231231093016.14204-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6553112e-8174-49cb-f5de-08dc09e3313b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23hZWGzj6q5Y+hOoyYE9CWJuHew0k6ORjYN4IWMtzq9a+OxabhoQIfwCQA3tvz778Ux/1gHGn4l2SycMQJymw9DwVRsTzJyOEpIMD+mv66Lb6U8HhNxPoHGwnULO1SSHe+cJ0uV3ZbTqmKv08iKIxae4Doj87loNRzcMFzA6eC38Ydxigf9FIP3PMETFToC89+D9ykzbpezR0C/uTyboKFfvOpdQzp181pa8GG+g0MBV8ogpGnOlJ90bo9VA8qPPvacIJO4vyTiK7jTPfjhSofL+eb15TXW0fh3dQW3Fp3+DqO7Yi+DMZKK46G0EgunFkud7pMktW5uPX0wM+Q4/lxLEHPuCa9/ks75oa2+G3QADFrOeOiU+N+KBVX4RR40Mtdjp6aseZzVrHIKUwBb1d2Mzyii3qze1UMGzSrJSoMqeeipNODsNSArgssx3hMlKcIA4b/RSW8kD8i8ZwI3mAkX9mVi3NW8cOvou4tN5vsxFr/4v6OnHzu6oh/5Z4UcE+e1UAAlwyFBDc2ZOI1fvLHffxJeh41ZZrw3NdWTDrm5zj/DYz98b5MFvOsUyX0eHzmC1Ed4QzJMvi6h26b6TggkAVrNILTzRMIg9+z6FUXuhNSw9IaTIJ9+dnYAllQJykMjF6Yz8Qc1EP27z0aF9Rgoqo0fSgDT1mPQxBohZVBfj83ghscqFd20+vt11ihXzNwqq3LJi++X9fgny8AIwTBTw3A3dpfx74qt3n4fwW0G39HirqbIfoyi+ggEHc15t
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(107886003)(40460700003)(41300700001)(82740400003)(356005)(7636003)(6916009)(36756003)(4326008)(86362001)(316002)(54906003)(70206006)(70586007)(6666004)(47076005)(7696005)(336012)(426003)(26005)(1076003)(40480700001)(83380400001)(8936002)(8676002)(2616005)(4744005)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:56.6600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6553112e-8174-49cb-f5de-08dc09e3313b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

If multifd_load_setup() fails in migration_ioc_process_incoming(),
error_setg() is called with errp. This will lead to an assert because in
that case errp already contains an error.

Fix it by removing the redundant error_setg().

Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapping of channels")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 732e3dadd9..b0c3b4c23a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -843,7 +843,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     }
 
     if (multifd_load_setup(errp) != 0) {
-        error_setg(errp, "Failed to setup multifd channels");
         return;
     }
 
-- 
2.26.3


