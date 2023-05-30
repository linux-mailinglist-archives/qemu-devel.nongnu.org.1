Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F38716511
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40f5-0003ci-JY; Tue, 30 May 2023 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40em-0002KO-1G
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:05 -0400
Received: from mail-mw2nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::616]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40ei-0007pp-Dp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnJtjssKlmkSfQp8mUfITjNUx+mAJjB+JLbacFyMX5PqCFj29ayPg6CCHBpHpkA5RbxpRSMozv8PBhY96oDG8gd1ILRJv/n04LLRS1jic9atEvxgP+zuAto/dGqu+A2Um9mYOScMAD6NlHcqa6v80sc11dqjmQeZLa7fT5bO3XrXYWPo447Ktc7TnrXDTVZ5fYf5bohijU6bofSjFowXLMnKG8k5fkgdLfp27rns/tLLZTfZnr0bpv9GfMxyhseDpIrHim544amMZNm2lcxiuqejbn0fkClDFVnchPCnaYBqSNAKWEtxVcu1nCUZdAHs21WizfusIAAabrd4Hh/WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=ngP6TUP37dTZhn9MEWvl4wVakLA2Swz8xKCTdkvAXVvj6ZbC8DLwfcdX5QIgL9wtqbdlkbHDID38HUMbOLXsavpZfKaUJ3l36jH5YkR9C3z2CMJROS45skFB16fIzjdPlo7gaxTYdSfuhhtUmzEGmUG6MEvZS1QRP0qPrRJTIwIDiMpcWpDVMKvUBqWqv8Fh02AOymX0GWkFO2ZDvR47PsUoxkuRpvbIyE2FOpkCOCTay/TxByiDpoPGyocaLtPs7gSGvYHDhbP8dGGktCVfnQZat4CZ8H1iQhyhjiXQcpYzxrO8qu4uAquuMqCv7PeWn9lyJD+0KoXz9fA0KBa7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8qr/4vY6rROCFN+GNRissWhsvrGsoPf1KWa7EDU66U=;
 b=moqXVpXPBMlPA9TLQXys0bgabq1OLd7PNPBVG4ilCbQ/g64lywOgWiXNUmbWfwXKQWgzQT6Gb91YIpmim1opL5Ax0mWJtMoX08SuTX3RENQXXPgsU6P5v4wTA0ynhCL3GrHOTiKzQO2h1TyCazjIckree/lmKlA54veTxr0N433sJjZfhvdK+U3p9TQtuX3upZGKNa7bjET06mLuhOnLky/4eGP3Xtm88zTz3oc17a+W8SYBaRkuoZx3KlhikZbW4lU2RL5pUFL0+p/xSdnpk9uHAN36vAYm9kR7aM3mGWOQjNdUIxOA4RYCqV91CjUPERi3wzoQ+RajFKVDiA5VVg==
Received: from MW4PR04CA0049.namprd04.prod.outlook.com (2603:10b6:303:6a::24)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Tue, 30 May
 2023 14:48:55 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::d0) by MW4PR04CA0049.outlook.office365.com
 (2603:10b6:303:6a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:48:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:48:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:48:44 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:39 -0700
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
Subject: [PATCH v5 3/9] migration: Enable switchover ack capability
Date: Tue, 30 May 2023 17:48:15 +0300
Message-ID: <20230530144821.1557-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6080e51c-a9f6-4df6-e00a-08db611cfe43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcMeUzEkPfyHKZYfDIeb4bavFHLrH92ihctrUT0G/bssu4HOboCmuSbsTWAy8XpjZ0NlatvHyehQge2U0NRAr7r9V7pIF9CeGnBz+CBXlupTbyt1Xtzr32233i60wg5IKu0oja5fvwHwgHJ9aCZX7Ghkc//FUd3t8C1tv50ITpbv0K0fwn5HZUPV2GMe7hv9KSk7wJpe5LP9xuhfrzfohEXd2N1JJDEE+KF+GNUL6l/Bh+TO+6ekeYRmGDscQ8Z8MMDQwTTsdZw/oE2fNmNafrJsM0L5TuY7Shg67SCUz19RV96DRnrjDXLEIGHzgN18g0hrsnxqcZIIr6WzQZWQgsQ3eN41yGIw0d+u5n0DP1VGxOi5jmSpZT1CXHnbpwGK7m+fUz0ibAFBt0bN1lZuyn9JQyr5KGgcM1BxqvWtrijv6oNS9Wxl86PkFrmIV1xJWmggVjEc67uG+YwrCtob5wmzlS/zCjiZ7hktQ4NmjmiqjKWOve9G4Lp9ogS58admNw45I0GW346u6x/gEZWvcghMSfdOvWsKwfTVCM/4jB/XRR1QeU/lb7ohlYZ0Hvyuuk+wSUM3kvA36HGJN50WPNbw0vgR250hGlaTUnCMXoPfM3OfUQ3urSSQELEJgUBI9Bk9bRYA4pejvjD5gSvGaG/WadBETYkXnqkrwWjVHgY2Ns183/VRuLhd9+CLf9e88enjhSwZF7o+c9n+o64p124E+o83c2gexamJ5u8xYpk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(86362001)(1076003)(7636003)(356005)(40480700001)(36756003)(7416002)(40460700003)(26005)(426003)(5660300002)(83380400001)(336012)(47076005)(4744005)(2616005)(2906002)(478600001)(70206006)(70586007)(54906003)(8936002)(7696005)(8676002)(41300700001)(6916009)(6666004)(4326008)(316002)(186003)(82740400003)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:48:55.4803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6080e51c-a9f6-4df6-e00a-08db611cfe43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
Received-SPF: softfail client-ip=2a01:111:f400:7e89::616;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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


