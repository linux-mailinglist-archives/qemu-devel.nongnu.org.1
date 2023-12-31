Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0E820AB9
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsA5-0002NR-25; Sun, 31 Dec 2023 04:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJsA2-0002MW-To
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:10 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9x-0008My-Ge
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT3FKoE+eHxvZYMFbd6XmLhKxlEcFsVTWCqO9d0cozrriLQKeV5sEdS4GUzyNvJiFDyXzZqbLCdYWcfcv4N7PlCOvYPYGSwNJHqRK3zThGQWoA8l+TzhOzrXmYmA+SF+A5GNJwwDNRlHfaQ6ujgGp+SO1dbcxdUmtAOTdi8YveWA5aADas51bU/NbXa78HruSVA+kMHAFwSQ9goxkbwALo+XMVw6nVK1htaYuoCFofoNCSArAAGPDBmt3XbnqihjbKNXDLxFkWNEkrIFHgZxFPqrZ8Y6HIOAnnaMYj8l7JlNMiQl3c6yZBN1k8OX9CkqN1eZXaTFN5t4kpcaVdYAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+NB4u+Lh8zA5QvMfHDwCiyztTARD7M8hs83TUcnxik=;
 b=LqhU5jVBf2lNT2ivb7Ky/PzTkVMjj9XyZNhvCtdb9z4A9cN+WwmuaxhXdZ5AcXLXuTI775juGCb9cJIrrEyNv+MlMFRJ4m08Uj5nmWsmDItG7a3jJclcMivNYW3OATxJjz137ihGTM20YwnaBn8kvZEabAN2sUWPd3sxIeWaGKjzYwxreRe+G4YWMP2HUas9ZlCpXrV40gLVJWeRrpGBaVnHRig17sVWh+Fb+TqicAgalKDsgERfqFLmMdZhAXy67l8XawttOfev197qRWQWewlWA7cnjtO34vXJdQ1POlN/IbKXNBzffQLsBvmMZa/glLefcVdt0K2PVogLLER09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+NB4u+Lh8zA5QvMfHDwCiyztTARD7M8hs83TUcnxik=;
 b=OxlDmovGLtF6gVCHJ5gdT9yjw4DxxDkYanpmVnp4HK8EKCmywdGdkE8ur5OYYqH2zoYJNS2RyvjiCgcS7/ZVAinle4wuNZuBEBQrOwHwTIGZsVUziK7jOQL4T+csksjGzfelGVmQCaU8RVnGGS9LAqVlLt33lgyGZX/k0ayagv+YtVZ5CiswwoK2o5dRh8LYHa5qTeAkATV5t+OwAsqfDLlSh1IW5dpcva8qocbs8dmgOuJm/8xjyMYaapJlzS+93mehvt2aYsXTkzxlkR2t6WgxCCz5g1r76vsIO20SC8R3gYjyx7mx0T/AeYkrEWaIeyrHlsgs3kh8E3Zr3e9Z8g==
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:31:01 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::dc) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:31:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:48 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:46 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 11/11] migration/multifd: Remove unnecessary usage of local
 Error
Date: Sun, 31 Dec 2023 11:30:16 +0200
Message-ID: <20231231093016.14204-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dcd5bb-2f9a-4b16-c12d-08dc09e333dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9uiIaTp/rk8BXOWl/yPWfOh+Lg32xItOiqt057ZF/DHEf7Y1JlFS24ZvXWVJw2RmIP2h+yHPml4pVfUoFounV5MVR/cYsCSRke2I7o2Nwcd+tCY0IRDlVVcm5ZWqY5OThAVhP64XFXWTbYmSmwtZNTPl07WQaCFPh81tb+eJjV+6qzJjxXusKlwAXaZbwZLJiYDR9REOgJ+JYZEH/hF95iXeYltgKsD+bO6nnRWkVgfCPj9WaMQBAYUv1Mlbq7MWmr9j8j7UmVjEv89JdYY9q2kcuyQp46Y9mworHiCF8wSUWhmpMr5okxaf2rNF76ZgFiqTYuc2j7C48LjVDw9DukfObSlyEwKW5rfrlR+uNQ5kyamtI8bM28iKNTMl9bG7ZAKz+tWeHTWjLPwC659bgt+J007XH9HNIe/tCTdrqgYDZlCWLzT4tRdWG2l2HwGAaS10wwi836bpF90t0T1HoVBvsAXWEmry3kZsJ0wDTKHiJWnL+/wdrK90Y1AKrBZPvJT5TH8cm+jvvlBWmNYRjqDtd6ySFOXiunq6TtFLLKbkPcbK6gJb9oXZDgNhYK0L1lQoZV+k1IkswRbSr4Lrw0cMYi7auxm+8yXxQlMsneF/PIq996WakLFSsB4bWUSDj3t1NiJT/3Ftd33rVDcozeIVPrPAj3NTx+gKyjQa0BUck5+o1KHc4OS0DChhGCXYA+WZ36j0/Cgsfup1K21DyymHlJmwCPP0MR902TMiIfL49BucpV5+s8oA595jxHMxX7wXdBoMu9i3XRP5yhNopj/Md48PwmL49BeehcuM/8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(47076005)(7696005)(40480700001)(6916009)(7636003)(4326008)(86362001)(316002)(54906003)(40460700003)(8936002)(8676002)(70206006)(36756003)(356005)(70586007)(36860700001)(6666004)(5660300002)(478600001)(2616005)(107886003)(1076003)(26005)(41300700001)(426003)(336012)(2906002)(83380400001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:31:01.1071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dcd5bb-2f9a-4b16-c12d-08dc09e333dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

According to Error API, usage of ERRP_GUARD() or a local Error instead
of errp is needed if errp is passed to void functions, where it is later
dereferenced to see if an error occurred.

There are several places in multifd.c that use local Error although it
is not needed. Change these places to use errp directly.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9ac24866ad..9f353aecfa 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -951,12 +951,10 @@ int multifd_save_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
         int ret;
 
-        ret = multifd_send_state->ops->send_setup(p, &local_err);
+        ret = multifd_send_state->ops->send_setup(p, errp);
         if (ret) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
@@ -1195,12 +1193,10 @@ int multifd_load_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
-        Error *local_err = NULL;
         int ret;
 
-        ret = multifd_recv_state->ops->recv_setup(p, &local_err);
+        ret = multifd_recv_state->ops->recv_setup(p, errp);
         if (ret) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
-- 
2.26.3


