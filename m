Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C47738238
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlN-0007Jb-4l; Wed, 21 Jun 2023 07:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlM-0007JS-2s
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:36 -0400
Received: from mail-dm6nam10on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62c]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlK-0002Vc-Ey
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/bn7quszxssk1d/d58LJYH5r8B5wgGMVQ3jGWCs3idnYaj4d3duKiZHkcwf9CNRM+npQOJQ25jKOc3ZqgTt+N1emrHkS98KMxtXbOdMZf5qZPlCyEcsV/nZmdWJBlo8Olawz4TqVqx4TSlmI1+kEjMdGtcPudaEHZf3vptuY0V+P1SdeUEU+D9iBJwK5/k8fSu0QYNb7ZuAERI1VH5ozZTNZiWR++AMTMyTYYalqVmrgQmo9XD509ov8oRgcd5DHZrAvd28NYOsjL5cmLyet4Ec6JOQie2KZdK480p6aicU1SEkeWc81W8+UuQhJwsciRP057PriswlDqphqlqMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw/7kW+MZRDVjVwbSnR9Hu2tiTTqZuOHYZIYbCoAxtY=;
 b=nGMChMZfZbP4z/M5DggrIai071MzLmxqdyHT0aBZ36ZEb6sGkLIoOLFdmPp2dO3viga+GRAV8PTm2dLfWSfPIgKWMpmcJsHG/kbTIMKtLwhomCAmZ156U0QG5hikvufMo193SgW4kvSxeUpF9gg/U/rtFd0GOwrFIGPJRm3fZJ1ZIW4mfbs5IoHMfc8fC54wGIjebiTGIEU9LmcM3gHHynnCsmB3WQnYt5LHRtF2lF0P4mx1Hn98Up1xWwb126Zi7xa51MQLEjO3Tzu4d8oTn/P6Yu8MGT5M+cfBRX8SlT8Kvdq2Kh/BQxqcnlUeeZhC+MJHFW2iKsvhAfrWXqhTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw/7kW+MZRDVjVwbSnR9Hu2tiTTqZuOHYZIYbCoAxtY=;
 b=SF6VCVt2SHPDyyc4XHO5XoTnhXfgsllkgs0XZYDVkASB7rm4U5dkVCEJL6cXArVyS4Qt/5fwDXuKXAH0m1tD4c1kR92vv/qhNmmwtDfjM/GaeJeRovPs0NH6oLTKzCZi7BvT3/3fA+2KBmNzlJmpzRcDPKnXj+ftqJggL++AQFzZeJ4RAze34G4P6x7G7Na2nyPQDP+j+9r6SEs68Nu7wLXj0osfaOxbnwz/MF01U4NwLfFoqiZA1OiZWxYy4xsx2rNxxgSBFUsxwexpi5AqrVZ+dNZBkpvO+wXlRK0kMDiHzTHZvBc6+0Efj3xUOYtyQ4HMxdffMZnUDzXT523mwQ==
Received: from CY5PR19CA0097.namprd19.prod.outlook.com (2603:10b6:930:83::23)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:12:31 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::a) by CY5PR19CA0097.outlook.office365.com
 (2603:10b6:930:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21 via Frontend Transport; Wed, 21 Jun 2023 11:12:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:20 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:16 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 3/8] migration: Enable switchover ack capability
Date: Wed, 21 Jun 2023 14:11:56 +0300
Message-ID: <20230621111201.29729-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a4ca32-585c-4ae9-655b-08db724867d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhoZGEl+nnY1c4E1oajJHfKzDSAgXjcGabB+4nmPkq7nuKoIWb7cvDJf/SbSjvDHhGEfhTU092svPcauMndr3MNoK3cSSRb0b+UgrQB/ppeZTyU0MxyWQD/yOmT4PmJhKl43QqWcGsWr7PXgCXHy9z9Q2vCSd+h0QiY7m7Vuan9rML0B9TF4JUeBlulBtNWkndAcDbtomTDsodnhXRznoop9w8G/PeFFFxVrZejgRsYKcfDwElQbp7LzjmIac/v48sejbZErgIlNXq7j6mP08ChSWMrhtAcLOIv6ccgSC8dGyfHnci3W7/eOC7s+XTakOdAfeybPSy2+xApEh+jeMYY2qmzCYv+CHvxxWtNJOzN1/yc4SGgYiPh8JzwNvwZBPt9dHkAiVJLTB21rDekk/KfW5DTV6yAVBB33QqhXAs+OhTIWK4nqo00XjH8x+4oeoWG6I4vicpdbi2XwVo3yR/TJXIjRe+JSzPmZY85j6acqBH9ijoXTUE9xvaRFF8u+hbgj3ZVJhTYHI3Oq30uyQWinSlwS09LxotB7MMbrFZPRpkGHFQlQLWBCQNuigI2IPikaL4TkQGCujul2zPqr1Zt0OcaQokoHH5830+lJ1qu3UNBRxAaf0cNQTQrn3OYOh2r0KsnwGn7Xs4Qm+UYGo5cBwloA6EwfpurRGuZnCuQ1a1jG/WzRVxHkSh6SPMeaCB8xB+tXT4zKXphPqREz1bGLPvRYFmJ2QY5yebu7bV4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(4744005)(2906002)(7696005)(82310400005)(82740400003)(6666004)(356005)(7636003)(2616005)(83380400001)(336012)(426003)(47076005)(1076003)(26005)(186003)(36860700001)(41300700001)(86362001)(54906003)(478600001)(316002)(40480700001)(70586007)(70206006)(36756003)(6916009)(4326008)(8676002)(8936002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:30.6769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4ca32-585c-4ae9-655b-08db724867d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
Tested-by: YangHang Liu <yanghliu@redhat.com>
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


