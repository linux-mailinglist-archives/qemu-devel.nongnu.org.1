Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77870AE7E
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kpf-00087k-Hy; Sun, 21 May 2023 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpd-00087J-Es
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:49 -0400
Received: from mail-mw2nam12on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpb-0000CS-L0
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuFjI7UvSHDmaOJV9YtnIi4GL6sUOZ/x5d+4zfWUcu5HhkiT+IHvd7CW/BDTkPOuBgjdyzniwOEQsGYYTrHH8Tpe2Hg03VMvYD/x53bk0JNEbIyYQf67JrfewiSkFoKon00C3u75Z6YE0pAHaLs7QM6btvnDJxsxhWXUSJxC3DyJNusvUIY8Ph8wMfXt9A/jO+psNv0H2LEwyWjIp9VLwTkwdNR4tIalpBdOW5N62ryQ65bTzkGhF0jwMY6PupMkGFzECEakLDulP1e4qwGYOOmPeUl8Z7q0KVTQEKMVm7efHZh4eV+nWxnF4typQ/MdTOhe3tA3E4v841TTyzoaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=LLY3YiYEiieUR9anwfjuGdaDTrVar93gil9ixLHRduM5MiKFVbtlIrXB/gD8Uyz8J7/Fsf6ncg/h6+qY4rdEKrcdQZZiSMjFqulbo9RNEk4+ktONdWbPptioIXle4FA0DmL1q/nqteSF5Y2VBj8jswLQ4P9doAj8XthlPf5a3Q1a1JVMfqyyYIWvA+BNmv+jJRRRlHf1txF9g0KuM8YUAI/as65nT0aZT+awHnHdQUcmoPJ1Xp6MDdDXG9CabmRAFs9R5O4prGC4rukBdWAORCXQ6MkrB4aZuNDueDPjXgvINxnoU8gpiGoo0qW7K4oNkjIEXiPYkrp/md1JG7T1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=H7rliA//RQYRZlwQlaEbY3fcI20oioO92owc2M+KOXmjo9G1gnptibjydZpbwNZ0pCV+wavkfplbVPLJ0UU0KIB5soH5+XrGx8uk1mwOKziGyvLh7mIWcTJGgxPCGKDTz/9Qd+eXXp9ttEhZLXdK9Sws+uiymAc9ThIZpyMf5AAsJMDOgMxIEkEneNzlGxr3ufsuXYbBjup8cR+KRJGvFHsCusorVc06uY/M5Kx4LpaICEwJMuGOVcpB1wwzrYimC43t20OzezzyFAc5ztUIBEf8bMWIAcmyrkyAD0XzIAKqg9Hv8zZco59r1FmsQH2iIbuEq+/lx2gwfq1Fotob+Q==
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:43 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::ae) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12 via Frontend
 Transport; Sun, 21 May 2023 15:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Sun, 21 May 2023 15:18:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:31 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:26 -0700
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
Subject: [PATCH v3 3/7] migration: Enable switchover ack capability
Date: Sun, 21 May 2023 18:18:04 +0300
Message-ID: <20230521151808.24804-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 4393b04f-abb6-400c-3b06-08db5a0eaa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Dadh4PPlS2nlL3+rPFGGQJhXXQCqPgs06l9+to+fEEB3powuTxWyea6s7LU/dguIBJo/zOgHlE5VdJuigFdhalO14zImCzVvLQHWXh7qGenLVjYVojm/s9uvVSI4vt/7nj0kjV6ie+zLskQ1T0TI3OaqQPfjCsnkHYHpdlpwMn3ZCqUF3j/llXzL5cjSI4Us19+YuhAT2Xwq6+KKbZBdANV121AEgC71/tTwiGv8Gc7+F+lPiiTKUrhLjWjXqkKn1saYdmCBiQRbhJh1wCSb3U5j8mT5HeKr47DQ5c74LKL2tLTtwRtx43HQQdy8moiRNMQZoDrDsqDZ4l7cM8mU+gYud2kPUGkJALFXC+dRUKr8D991dmzl3dm2iZ50d8QTQv9mxxPlrKcJ9RePaxj8Ugi84/l5Qvi3DNOy7rudA3Xz/b0xRW5dEptfpKhKUg2DxbbpU2Hm7UfqYMirH+DMW67l078ki8iAOesPOMFYK6EOlXrSi3WK/zivqmmnsqkYaknglsIDEdpAKSD9El79SYGvAsVimuhc91oRQs387e+zlHMWpLcdlgwPFR2txuRrK7ppCTvAN4tMWPsS6yU1rf8BcKebaboWn5f1Qky8ETnW6f1j/lR+zOBHxlpf62GqloroRTKqtwHdfG+/iKr4ltofqrnHjXTQIgFEXOBpVglddOtYM3Dvo9aLgGKel4FUbAOqjR6K434xfxP0t+HSZkr063mZ24MUga34Kn9eZo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(7416002)(40460700003)(5660300002)(8676002)(36860700001)(47076005)(36756003)(186003)(2906002)(4744005)(83380400001)(426003)(336012)(86362001)(2616005)(7636003)(356005)(82740400003)(82310400005)(40480700001)(8936002)(1076003)(26005)(41300700001)(478600001)(316002)(6666004)(6916009)(4326008)(70206006)(70586007)(7696005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:43.0817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4393b04f-abb6-400c-3b06-08db5a0eaa0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


