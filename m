Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA77139E2
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3f-000134-Vu; Sun, 28 May 2023 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3e-00012u-96
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:42 -0400
Received: from mail-dm6nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::627]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3Z-0002n4-MA
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKsOfCJfoGVBLHzomeLK8GcdwBPsP91NCzNPYk9PgZEUsCscnBDBmEQuIZEeSjVXtykKAjDI4Zc+ZsR9Zcet0xKcX73bwes+7BFU7llIPaNL/Cv7spMpWMUYIDRmeNy89u6Fq6AOe+ftXBnNUKVMhC1zHs0CrO4BhUBnSe+Z1mcRe7eRcnpLW9cXXBO8+o/bdX0ffKcSjr69dCe6N6INW4UbE4P/Cc7ZIZ58qoHq8Ejf7vvlWSr4EAnIauYoES20ki6LpJ73b4oExoUjNhkcJVAxgahN3WLLuNmfIrO5pakpX05hkXZj5Gz1rhJChH3oAGmcIXvA5DesMKmIHlf+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=iy+3i/yONsWmzsk+S6+DAEv4QR9BuMDZtH6AAIz/Oek6kjaQAlrVBKwZVzQcfmoB1CydPFyoc9yKm01P72sdMpOd/EYj2ag1FgHNQiVlkDQIgxWb6+dewedSO1CxK0OHuN1Lm83d9Pt6FsnBSVxzxiQx6zqc+4gk+IUf5Fti92SOcdrO0O6P8clJbDajMucHZt/cKe88aQvTVWzwru4xaQbMwN4+WgX5XDEvhW+BqhQnWmTGRVVl299z7LED8pDByCGY+dBUEiV8IHjA68MA1FHuWId7PyHUhfFhm/XJV9fUsMrJECvIXCtvpzU3sc9nnrP3XrvLISe+st8zsi06qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=nPIkLB/6AGkT432+28a3qDRebjwnOYN8kIGD43zuXiy6n2Yil0Jjsasp7URYLYG4UgPxYYMprSiDUMhkl3PWymktWx59UPET30aBY5iGX2UKyIXKRAAYXZLB4RUCpBvYw+2zneKzoz5XsWQlmBjEk05xCm+ll0rWUPmyu4Vo9kKvhM+iowjkj6hUd4AzqZTw9RSe1klEbBbYcOK+nQTdzNXsrGi2cWn/u3zauFLI6o+vbSLX5UqWba400nU7r9ZNCq8j92OsSmOJogBkZI7ecl3l4lYFKzEeL7IX8mmydbNUux0q6O6SkFeWmIs1RzLacaYsQ4F3itgGB5WFHNsAPw==
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 14:07:32 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::98) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Sun, 28 May 2023 14:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:16 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:11 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 3/9] migration: Enable switchover ack capability
Date: Sun, 28 May 2023 17:06:46 +0300
Message-ID: <20230528140652.8693-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 78666f00-2e78-4ac1-b235-08db5f84e0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAMpoyv0PXevI1bD85X30B4ldhouD/jLDjMBG5hh3+kVnOXfzs15FVNd22Tfqf855NhdRczDXP9TAzPPDBhJvnfy994X9NdI78IoffMNCwMix3VZvOVAxijCLUaxXEC6JCy2FUC/zPproiObxv+20rx+tA0GGCz34KQQORk+C6XH0Oo3Ih2q1saYcHHwbOWrfu+2iyX2OmPz8JO54Ln7fm6H/ujSVLZog8ijZKE15oEyyKXhiaNRo/WHE9KjvK8+PB4+jLrQDH1lSQDDfORTVVm/2Yc+LXy2xU9LI7NX8xVWOyjCsPMwNxvnLAcucdofM3W1fyOND67SwgO5AWjoMhRHteMv3tRTeqUeR9YKV5eI7fWmRzDGoKvh09udEIB4I4ZE9JfwaUuzwNC53IhdrcScokllDKGVVrSKAKVAm7TbquVdw7x/NSE1CTl5hGTnb/EZcRjc16iziGh2xzPaCnbVmSj93MnEES5Nmsmm3silOwCGAAidCG18IDMM2xKD7qFrTrNk1GFcjtgOyXoebSElaGN0TC08Us+SRx4J9DGATZwUPkLAFE8xDD35AHStM0ur33onRUtM8ZBJD6wI5dJB7X3iFp+LajVmqIAiMlSf7fiYYLmU+11VKnJAoRGvx3B0RZtNazh/yOfemF6T/Dq7l3vak9AOUXYDgN9nCiWwvvbM1BlF488ltL4FViwWv8Akn0hPctAxqPoytrQr3+d/A2kh/Kw3vzTzIMoM5Hg=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(186003)(1076003)(26005)(7696005)(316002)(4744005)(6666004)(2906002)(40480700001)(40460700003)(5660300002)(41300700001)(36756003)(7416002)(8676002)(8936002)(478600001)(82740400003)(7636003)(356005)(36860700001)(54906003)(426003)(336012)(6916009)(4326008)(82310400005)(86362001)(47076005)(2616005)(83380400001)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:31.2556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78666f00-2e78-4ac1-b235-08db5f84e0c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
Received-SPF: softfail client-ip=2a01:111:f400:fe59::627;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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

Now that switchover ack logic has been implemented, enable the
capability.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 16007afca6..5a9505adf7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -562,10 +562,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                              "'return-path'");
             return false;
         }
-
-        /* Disable this capability until it's implemented */
-        error_setg(errp, "'switchover-ack' is not implemented yet");
-        return false;
     }
 
     return true;
-- 
2.26.3


