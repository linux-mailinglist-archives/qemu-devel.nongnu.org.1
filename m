Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A36820AB5
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9t-0002Fg-0a; Sun, 31 Dec 2023 04:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9i-0002D3-7e
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:50 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9g-0008LL-BA
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVkm4VazmeGpdPPJHcWs3/BfXMI+BGuP6PePT84xIcRdEOrUuqQmGv8XwI3uf/v4zJs/zKGSJ1Kqf0HhNDFwdpXdao4MyAwu703tNeXaRCcMSxOH8mnTq+9POWLFRTJDT0haddtqQRnX98kpihCZLqKkoTOfdQXqnTy1UNG5E/fgg6xO/sBWQ7g6yl20Mh533JMjnAV5J2AJKBhT9jnnUe8k0a2DevrUD3lcPimS6mt/jSeZWlPXXqr4i64hQnI4E0CTEwK4ciO4jsTqDeLAfthyRHQbMBheqdcApaDcLmK3bP0QevrHV+LdMLFvspeDsZdg3rtydA6Rry2/Ngw5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fl/vu8Cqe8+KUjzLMOn+1F2M6P6XaxNe2THMJmQmGQ=;
 b=HHItAoqbtC7TpFVl2QxettnbNcFpvBsrJ9kvLjPHyajLXvmtW6Mc002ZUl0Ao3TUTHSKt7+/q8CBiALXjei+JqYQeJqfDwZvl+LxnqO0ODcfJEnobVasmq+p9Ri+RpAAiCGf/KDdakP3XwLKUsn6iZk70LMf6cDusz51E8cYPvx9NIYxuS6IeQHDn6y0Pazl3/cs6g0sd12sDGOWrx83O0zWU4DPAMKUn4T1xUW7SYbduosneroL1UHNfxjxwy2TPvd9kuvD6SD+I3ZIThuLSi7XOWs0ZGUESnsmV0dtDge/oU3DWeRXJyZoWMRYwXWuLbPNH+opkR26hxmP7+e6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fl/vu8Cqe8+KUjzLMOn+1F2M6P6XaxNe2THMJmQmGQ=;
 b=hlo4l+sPQZe3QdmkeWFvt0WaxceMfc/VB0W6eqpCSAH5syLMWLFReJ4rKPO9g2tx6XaFBPeiKCzqczq3lvtPGpXTEZ/OFRom2po5/kteyk9DAIvdGhsAQ8jWSy3+uzVOELACc2YLiq4ANSDN+DhH23mbWVMvkaaExspF40T+tb/JSQ6asstNyVNjxnb8Otd8hEjdABeJyBPgw6nxY08Bd+OMgH2dHajz/q76yFe+d0JlCnJkCYjdJFHZwhemw9LGGC5CaiIvU2m6IXYxLDGX8GgV502kR3wVBVJdJJDqAjy3bbvXn9/bJY5g80nJkO3+G8KOGS3raEOnDU+WYTiC+g==
Received: from DM6PR07CA0096.namprd07.prod.outlook.com (2603:10b6:5:337::29)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:30:42 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::b2) by DM6PR07CA0096.outlook.office365.com
 (2603:10b6:5:337::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:42 +0000
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
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:27 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:25 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 03/11] migration: Refactor migration_incoming_setup()
Date: Sun, 31 Dec 2023 11:30:08 +0200
Message-ID: <20231231093016.14204-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CO6PR12MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ba47dd-d84d-4030-aa87-08dc09e32884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nV61aqYo8QvlAVMDyexGVfOANAq2bvJ9TPxGLdCdDXUKA79u2hH1Qka1UXoHCVkHFRrf5/NQ5vTrddylfn0oBRB6Znwk8lZ/vqvG73zd0pMrqCCoV2w0XxTOg5wje2iP1kwEZl/zQPKuVscsgAX5/mDEPN135EIAPxIXC1cMsJJ80FTj9xaFFxcKam5h3pUIOkkDaKf6Pu27BhJxKZIDZ5S9c9HH7PsSfc0zxyAv5q8wPzlh1xHzKXjGLsWA7Nk/JkQzz+pN8vX6gg6gNoljq03EV32X/eGpbC7lI6ZtDxo88qm2NqU8Q05xzfHrpa2dhFfI7fr+DlP0JHpXyDPas0meKBZDt4/9xrn/opFOh5FANESHclmj2nWaK6tF85rAOBz7ttUnXtsZdBXOEOhOTECPI07iFcga9VH9ZpIsdtAb3uMRKgYGHqGfHnhGu80F2jWiYdU/HpT+cCcGXCH9yqvKPotnoM+TiSw2hHqUlEuPmwmMXnrCiQ7nQWcjtdfaSwUHVbKqF/tE6W9oMe12kPbsYJjbpFZTAwXR+xE1fh+JNVQp6gtAYGsUMRyf+8w6ItG5yhIcaIoXEDngY0lrXbSxvOBI0nfFToKOLjN5soIZElvu328WKVwIblQ8VX9xQr3SqW+25he9WyK9b/7131cBEkBnPkFY9+FLtdTNffo46ss6kJHtMiA/W2c/5QMtSLF+qlcoXo+D6JqqkUrY7t0lc32ouDEbp7xg5L1ke4OoZUhUnCFbkAsjqJ10vkpZ
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(7636003)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(336012)(107886003)(26005)(426003)(1076003)(2616005)(7696005)(6666004)(47076005)(54906003)(4326008)(478600001)(8676002)(316002)(8936002)(36860700001)(6916009)(70586007)(70206006)(83380400001)(41300700001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:42.0370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ba47dd-d84d-4030-aa87-08dc09e32884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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

Commit 6720c2b32725 ("migration: check magic value for deciding the
mapping of channels") extracted the only code that could fail in
migration_incoming_setup().

Now migration_incoming_setup() can't fail, so refactor it to return void
and remove errp parameter.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1e25d7966f..55d77572d8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -724,11 +724,8 @@ fail:
 /**
  * migration_incoming_setup: Setup incoming migration
  * @f: file for main migration channel
- * @errp: where to put errors
- *
- * Returns: %true on success, %false on error.
  */
-static bool migration_incoming_setup(QEMUFile *f, Error **errp)
+static void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -736,7 +733,6 @@ static bool migration_incoming_setup(QEMUFile *f, Error **errp)
         mis->from_src_file = f;
     }
     qemu_file_set_blocking(f, false);
-    return true;
 }
 
 void migration_incoming_process(void)
@@ -780,9 +776,7 @@ static bool postcopy_try_recover(void)
 
 void migration_fd_process_incoming(QEMUFile *f, Error **errp)
 {
-    if (!migration_incoming_setup(f, errp)) {
-        return;
-    }
+    migration_incoming_setup(f);
     if (postcopy_try_recover()) {
         return;
     }
@@ -855,10 +849,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 
     if (default_channel) {
         f = qemu_file_new_input(ioc);
-
-        if (!migration_incoming_setup(f, errp)) {
-            return;
-        }
+        migration_incoming_setup(f);
     } else {
         /* Multiple connections */
         assert(migration_needs_multiple_sockets());
-- 
2.26.3


