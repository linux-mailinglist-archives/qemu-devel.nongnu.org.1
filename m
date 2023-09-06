Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEBB793FFC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9g-0004MM-K1; Wed, 06 Sep 2023 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9c-0004M0-VS
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:16 -0400
Received: from mail-dm6nam04on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::61a]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9X-0003hl-UE
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Voj29LNaAbqfJcCcnIORwj0tKNJHAFxLzyP6jNgauue+DI6ox1XcbUpnbcUbbLw2FoFN8fXfl0BCihsdJ3N+5bHEG9bXDtNG/xLxb7c1xGKuP48Q8WwYYl15sGvspfldb6r1CPz2Q14y1wBvvr7fWPINuSERx6Ts3MLlWTpmBYJI1j+NjDeg+UjxpF+8zUwlVG77e2bAb0OHwuKp7qYXoaVtehNwxVlQLJZkjenvJUsa2R4BDAmxLDpKeHjMY16gidHrnz/CaXQ2FXIFNJXA7kCnA5GjQzqvE0ss+L6IbRTJL2d2FAzxcebfdqbNeUPXfrJgMygh2IMHcOI9nCBFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh5Y7Hh8PrdD0RtWLVQ6qBQ26Jx4T8hH8RKCKeEpOyw=;
 b=hbbJcBfKNVW8iu9edyI3TBRJ6/6ij0zrkzGlr+7I2BrPxuW3Bld5vSJ1v+1mqE1Berfl+lY3ZZka+kxnqjGu1fg+WNoB3CCN39IZsfaOrmlGrlMZ2jWRKZD0m/cI9N6JVBXGqxLgoQgM7nqi61OrkBYw9U1PVwPnxOhkWRmNg6z8f2778/cAc6D4qUrcAkNajhtkGeU7735KYElksP919hTqoTIgJGIZ1vI9mi96w7CU7DZRByMLjExjoUta2OEM1FIuBsbcygcVk2WjiwYLZmBKvzyy3ahmQAVbucSKe98rCoOCnoAMbqr06xIMCeKosQmTDQGwQk8QOl0jgbs6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh5Y7Hh8PrdD0RtWLVQ6qBQ26Jx4T8hH8RKCKeEpOyw=;
 b=eewUQ5b7rjK+yLGlCT+LZiqMkMHDriH10Hk6Agvr5WYLBaV81D+1NFzzBWyrDGA6muuTz1Gza95D4YijfkeE8kphANWGdG+dOyS2G0EYc2NdYiVpqKZdtWjdYLC+sY0RrHFp+jmLsoO57td371aRINHkMIsh9PJk0+rz1Tq1qHmePcFo9IETgWyHNzDd4P+cpoqMD8fLT/BLeWNrzGrIXODk6tuAr5B8aF0R0jzOBR9j5xExNuXHyo6T77hXOupRzAm2dbbMQ36DBm6KTETzIx7WGRQNm5UUzd+09HyTa4wX0WBMKaeKS4QZWhug4Meqi9r+hO9KEPiXHHQWxEp/8A==
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 15:09:07 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::41) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:09:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:08:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:08:56 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:08:54 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 0/6] vfio/migration: Block VFIO migration with postcopy and
 background snapshot
Date: Wed, 6 Sep 2023 18:08:47 +0300
Message-ID: <20230906150853.22176-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 47437637-aec6-46ce-4c01-08dbaeeb3799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eshXyrPxBQWFnB6qVb1oytDvUnXh/GXF6Mw1vYIbU7nSyOt5A+0E21koF13pqVgWCdfhS4ofK2/AVrXFTb2ldS+g/WOl+7YcSa0XxBFTdpfv9dX9sUGjJNpwq+1O5kn/T7LJE5/9htKBGM6FHuNqbvAYeioiW7nIfW5uwjsD6ZH8l1lKtSow0P4iICvA1iB+cD0Cgo7qAb0LTT+bt53/AR3sxjVdRsNiQks+Af/mPXKR17L4GHq3ueVpb3ZEBoyPPgkOGyrkthuUhnxSZDw/7tg3V6BKjmScNBy5jLfTI805DUiUHU2tcz79eF5iz5C5TTfcXw1g0GOOg4n2Vu3WDuFcqadz1v29iNfcMfQbH3A6lkjEL7QjaErPlv8tr3EJyTOKSwPHTJqpPTxCWhJL8LMPMcoLFkAeYNi23UQosi8UR4VyP/NAGqvlfDd5CrYfcSiIDsFTpxr7FRVYa1xrAyqbJuPiUpdU6lTS2t1vk+pp7XthqKplg6BQtdtXGBQo9rNhWmZ8fpTTGPBnrurvfb8LnGThGuhD+Ue5+4vSibY1q1oxZo605FkLZU3Gretk1GSNM+dvFNQ81wXg4LMEuHPpwhfbNPj52CcWl4Ets6EFSf5mR7uRyZK3z1fbPRk7QOVtKV7+dQiB/A5OEe6z6UlhK4uOlN2VGHGIoNnD6DNbEeeM6q3jSIosX3+DLrTcF0BIzuoyQTRxLCgI4efcssrYmbeMEYrxEdDZftKirNw7puS2XDQq6HIyeJcBPivWTDelN82+P+U2IPQ/h2VdtQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(36756003)(6666004)(70206006)(4326008)(8936002)(8676002)(36860700001)(7696005)(70586007)(54906003)(316002)(26005)(6916009)(356005)(2616005)(2906002)(40480700001)(5660300002)(41300700001)(82740400003)(1076003)(107886003)(83380400001)(40460700003)(7636003)(336012)(966005)(426003)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:07.4210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47437637-aec6-46ce-4c01-08dbaeeb3799
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::61a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Recently added VFIO migration is not compatible with some of the
pre-existing migration features. This was overlooked and today these
combinations are not blocked by QEMU. This series fixes it.

Postcopy migration:
VFIO migration is not compatible with postcopy migration. A VFIO device
in the destination can't handle page faults for pages that have not been
sent yet. Doing such migration will cause the VM to crash in the
destination.

Background snapshot:
Background snapshot allows creating a snapshot of the VM while it's
running and keeping it small by not including dirty RAM pages.

The way it works is by first stopping the VM, saving the non-iterable
devices' state and then starting the VM and saving the RAM while write
protecting it with UFFD. The resulting snapshot represents the VM state
at snapshot start.

VFIO migration is not compatible with background snapshot.
First of all, VFIO device state is not even saved in background snapshot
because only non-iterable device state is saved. But even if it was
saved, after starting the VM, a VFIO device could dirty pages without it
being detected by UFFD write protection. This would corrupt the
snapshot, as the RAM in it would not represent the RAM at snapshot
start.

This series fixes it by blocking these combinations. This is done by
adding a .save_prepare() handler to struct SaveVMHandler. The
.save_prepare() handler is called early, even before migration starts,
and allows VFIO migration to check the migration capabilities and fail
migration if needed.

Note that this series is based on the P2P series [1] sent a few weeks
ago.

Comments and suggestions will be greatly appreciated.

Thanks.

Changes from v2 [3]:
* Added a new patch that moves more migration initializations to
  migrate_init(). (Cedric)
* Consolidated the two call sites of qemu_savevm_state_prepare() into
  migrate_init(). (Peter)
* Added R-bs and Tested-by tags.

Changes from v1 [2]:
* Adopted Peter's suggestion to block migration upon migrate command
  using a new .save_prepare() handler in SaveVMHandlers.
* Added R-bs by Cedric.

[1]
https://lore.kernel.org/qemu-devel/20230802081449.2528-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20230828151842.11303-1-avihaih@nvidia.com/

[3]
https://lore.kernel.org/qemu-devel/20230831125702.11263-1-avihaih@nvidia.com/

Avihai Horon (6):
  migration: Add migration prefix to functions in target.c
  vfio/migration: Fail adding device with enable-migration=on and
    existing blocker
  migration: Move more initializations to migrate_init()
  migration: Add .save_prepare() handler to struct SaveVMHandlers
  vfio/migration: Block VFIO migration with postcopy migration
  vfio/migration: Block VFIO migration with background snapshot

 include/migration/register.h |  5 +++++
 migration/migration.h        |  6 +++---
 migration/savevm.h           |  1 +
 hw/vfio/common.c             |  7 +++++--
 hw/vfio/migration.c          | 31 +++++++++++++++++++++++++++++++
 migration/migration.c        | 33 ++++++++++++++++++++++-----------
 migration/savevm.c           | 32 ++++++++++++++++++++++++++++----
 migration/target.c           |  8 ++++----
 8 files changed, 99 insertions(+), 24 deletions(-)

-- 
2.26.3


