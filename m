Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01678EDE5
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhFp-00038K-JA; Thu, 31 Aug 2023 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEp-0002hy-Ia
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:31 -0400
Received: from mail-dm6nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::606]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEj-0005D3-Gg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjGmcLI4WAiY6Z2FtFSuZCnKl8i0TObpMv9BXKi4Fo6zYnzfBld4MajrLXXI8wYHSUsQsuq3BqLp9xFwX2rT+IMZRoNbkyLkONgWfBCgSHt1rIn3Fa4A9kpUqgwBV5weUJlifrHTw2Dhjv5fuS+Fr381nJ+GbiGXWDmNJaaO9J5Fjf+KbmG+ZjZM5DEDehQkqqkM4OP+SqipIJO3qAWSvFNYdoKLSqOpV2qJpaVOFul1Hfat90dTs8uBq3A+aUQFF6sPTWIdC8mXGX2fHbnXKX7uoPDYRyqUJluHIb5aFPdhegbJSL5GjeoLryMoYR8EVZ+DuzfKXm4UXNQjdiMgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NWteZOyQ8IkZkxbAJF8lF9N+E0xLxzFGevd+dn9GGU=;
 b=ZS0iZgyV+t0AlGfMLuXIJOKHVbec6n+oDDf3OQcnChpoikd4oA0502+2VFpR1WFjLQuETTbHwIY6SAqHXSNRzj7WcTaamBie40KZ9s5UgNxEaVY2/Pbd3lj4XpAQq7KySdLSep5YHNdZTiqd+0HWtshQJ4HkbwfWN382VnFQxHvt+ZbjzOw439fwTGB1Ke3GZsv26tsuDinxr+9al+lGIaLZmPvzG8rcBq4hCefTTJEFprncCoMWdvyiCfN3N3VKcJBwQ5Aon1LoLHoYiqFYjrhK0TgFUTHFSxnHUlC+LLYxNR45nP+CrWNT+tq3M1niyGfacVJ4gG9fdEfgrxNLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NWteZOyQ8IkZkxbAJF8lF9N+E0xLxzFGevd+dn9GGU=;
 b=CdMcI1MpXI6TS6IPhBtHepxKJOeHwYBBFpa4gzzW5WTx8JROkhoceuIO3c/+CXMVRXN/c1kGsR1LgDzlJXa/KnnPAy7gF2zj/m6ZfH23f6cGF4wyMMmP0W+1fWZMxqkj4krdS8OlTQR2JjAgFClTuaqan3knX7LTU8HHQXoniPMbz/r7pO8IwJhgl6GPHvCt1t7+JbKcVV6uKw9MMEugurMPHEH3ag3C4t2hZCbkfha8a/fXwKaf/Dll0FzvMw9PbRITKvNATJgzuF4rITtL9b8fimGmKvOvSAhDGKEepYkDKbbGgANuTmpxbCdJ46eVFGGS2h0LGa8EQQFyhSoeiw==
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 12:57:20 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::db) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 12:57:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:05 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:03 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 0/5] vfio/migration: Block VFIO migration with postcopy and
 background snapshot
Date: Thu, 31 Aug 2023 15:56:57 +0300
Message-ID: <20230831125702.11263-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 151cc171-4519-4fed-fbd9-08dbaa21cf9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfWPpCUoVC7GZYAL8QPCHDxLQJSszIQe0hp2kuaKrxZvaO1M2WO2XjVOLdsLinb5mknnmi+0YmRhRIaDMNM024dJd+G/ZGcAJi+1EvttAqjuVHsr3an//091q4T/tLhz0Me2JUlRQWCMJrd4Nw6Z4q8NolmBmjb6b8dYQKsqqzKw123/Tf9S6IE8hWTZFbHeCEQ8BzRxTtOlhoc0uI9MZo4ohPORisNzC+XNZeeyuf/UzOgVqRxt2KVrxXEx/pwqSWgsvb1dTiPeIXpIy+SvqrUowrQUJ7CxEN7dZxU9jZ0Zhy5KUwSlX10IvQpeYAEI344GBC5P2UKZEWJuV/LCR8FrFrQ3+/qItFPE13XBJuo9RsWaMuhS8n0HpeuUWL5YMt9CKZv1exb3QHqmZMRkEfMpN+v4jaKgMzxomU8NLcUoQe+beQfpJFqlBib6Hk73L6qRe65vqM5Rffg9Oicmn99i4ldmRN1ab5RypaoiUk7qYHNbWzHBV65BlKMUGzcSTuoYQZfqyg71XbOUFNvb0/sDzUzNYDYJNEJ909ThdqrWpByTrnrMoRButfb0cvl/9VxPGN60+78pxejev9ve82xHjdWN6rrjYaUSz7Yfbv85tue3jNNj5UEOQidjqyl+LajkGYpIyzeSHxeDipwHba6SaWIx9NAIyNocMC602OkXDUKHAaQckdFWi7ylJUxG+usUTjnROHADMDvACRbl8iuEysP0pmT1ClqVJ89cLhNhxcAbZt3VXDJpQWZ+YOC7Kyk0pEf41W7NBwWv2vKPgw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(6666004)(7696005)(966005)(478600001)(83380400001)(2616005)(1076003)(107886003)(2906002)(336012)(426003)(26005)(316002)(6916009)(54906003)(41300700001)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(82740400003)(7636003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:19.5243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151cc171-4519-4fed-fbd9-08dbaa21cf9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
and is used by VFIO migration to check the migration capabilities and
fail migration if needed.

Note that this series is based on the P2P series [1] sent a few weeks
ago.

Comments and suggestions will be greatly appreciated.

Thanks.

Changes from v1 [2]:
* Adopted Peter's suggestion to block migration upon migrate command
  using a new .save_prepare() handler in SaveVMHandlers.
* Added R-bs by Cedric.

[1]
https://lore.kernel.org/qemu-devel/20230802081449.2528-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20230828151842.11303-1-avihaih@nvidia.com/

Avihai Horon (5):
  migration: Add migration prefix to functions in target.c
  vfio/migration: Fail adding device with enable-migration=on and
    existing blocker
  migration: Add .save_prepare() handler to struct SaveVMHandlers
  vfio/migration: Block VFIO migration with postcopy migration
  vfio/migration: Block VFIO migration with background snapshot

 include/migration/register.h |  5 +++++
 migration/migration.h        |  4 ++--
 migration/savevm.h           |  1 +
 hw/vfio/common.c             |  7 +++++--
 hw/vfio/migration.c          | 31 +++++++++++++++++++++++++++++++
 migration/migration.c        | 10 +++++++---
 migration/savevm.c           | 31 ++++++++++++++++++++++++++++++-
 migration/target.c           |  8 ++++----
 8 files changed, 85 insertions(+), 12 deletions(-)

-- 
2.26.3


