Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5A76C834
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR70k-0006Mk-W4; Wed, 02 Aug 2023 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70j-0006Ma-08
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:13 -0400
Received: from mail-bn1nam02on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::60f]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70g-0006DB-It
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCpej7U84KpWGYvfQYWLGkVrroXT88X3njRZHUqSwrDO9l+EcsueMbqVf+TL85k/Ug8Za98R/mhuQjsuxKb4r+Bz1FWzm0d+ujCkBAA9cc3110P20O/Kg/+OFLls+UAEVVfMtQ/hBzRuVm9yFUhUzY5rfkM6mwtLbEnWy/YggkRpuA8YwZ8iEIhCeVRz+iY7jMb7ZJPGVYeiLXoWbjALQYGT5r5q9LMFnN5BKc0l7RSWOwmypj7PzLn9Fp1ToOql1RqhKZi64EO1RrzptzbRk7+fWbdze8afzIAWQKBs1B3nSl5daxLMViWu+6dB6KvLA2snIwuVKwOJsM+8cI1hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX2hWt64UAlaOCBIoOS4/AWkYpl5mirztHoxkUWCyXs=;
 b=bRf2jKnpokpHJxbkSvLjkgcdEymvQyPa+bHEvUKChI8jR66vKRMErQY1DX2z156o+vXD7/18vxL1ZW/s7TjR/6K6pTmaRnyYMfZEi4D0nhyTHnaabJCeg0zDLlVIsCSjoRcFyHcp1jEda1WZ8Drm01huonqbFz7nv1ldBZETfA0n08fR0ktLo45a8/ky0kqwEteW7Y7GB3N3DlA16aXgnbnpGVcs7Aic/7eNvv8ob7BtDr3DiZ+qPTw45XSr3G77XfCdYiiGFAvaOgUG6AB5Aqb4G7n5FeB4KeNFUEiu2DCN7SRdAO81kkoh690j26N7YlCGUpLsyEpdHFw9zZCF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX2hWt64UAlaOCBIoOS4/AWkYpl5mirztHoxkUWCyXs=;
 b=JaTF8Om9U795WEtXucZvsQJ3wKzx9U6NCknAhizwFqPPkmJCdPAxu3IkbOn+W+J6iePkE1VK6+uhf3xH35L2C/5VehP8uRbBmUmKqIPpyBWSaL/PJGCcC2Gb0unMHqXRbaXAvaL85axbMDieO4Wz6V80yjn5OHBWxYO7+PkSkGnbhgu+TpAQHzvLyumvY0mv7Vbf8RpzEFtzcd7I3ONRcARgVPvjxyyiERwFYjxvRrmcVQqeTNUxhKpbjd1ueDSEGq6vVP1Jcclj+k8GBxjPnER6BRv8tbkVYfrZAARYjKNROaACVeVVNUGvmhgP04A5h85w2HRASWp/8h/zRgBAAQ==
Received: from CY5PR22CA0083.namprd22.prod.outlook.com (2603:10b6:930:80::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:05 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::62) by CY5PR22CA0083.outlook.office365.com
 (2603:10b6:930:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:14:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:14:53 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:14:50 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 0/6] vfio/migration: Add P2P support for VFIO
 migration
Date: Wed, 2 Aug 2023 11:14:43 +0300
Message-ID: <20230802081449.2528-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: cc39683b-1e1d-4f77-340d-08db9330938a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOI/HPuWuolGgwl/WFSh/iwZT5cHPT1U5fwx7nleStHKbUHOCGFPM9pWhWw1XST7SvGI9LjpvgPmMg1eSpmgqJgwPx1thnGMcZTI3UU8cEKYPMxoBeDNGnM2jY54ce6bAtPLtMklUdh6+AHmzrQuuXtSW7UTx7IPBPuw2U5H8Dwghh3+VDWa34VSHMJfMcan9ttH3JPXWH9B4mi9+AJX6G76oYnG68VVcBqQD4S5WSy1dupBBuv9KDfCzn+AMr/ehssRQI88xkydOYD3cf9FLExSDtNqhyi6plIhKctvMnONN9jOB21/QQo1NJFcPGOl56fXyfALpg/iXc0Y6st6r3VfSnd3rSrvD4spqoPlFc0UIBfG7OlChD7rTADjwEKiQDHRV6EKyEhTVcI5sW4d0mNCfBIFM8+r2eGucUmVVwDRKssQTgKkdcino34aDaD24Pglivcw23OAI5HH2MAtR+HyKHVm+x5QZiq3gcIfxCy9de7jR8B0X3JoUNm9dB/SLf1nI+x1c7q8Yt/8UdX/O5CtSCywhfsyqLH3dn0AqvTlTPkmFWTh1cr5289WtEV2oAg93DBXQADdf+Sjhryr7adAfki2LLxKiyVjv9zU8M1xb4va7FDaNsLu8UYUwkOgou3Z7xP/A8NlL4+To+u9q6hIFx/TPtxWo2Rud/BSuIF9ibJY3i2/VGdIIpQeGCqF/7MHXAXqRreljrwz9FetZ2aXFz1xZK/fsTlqY40lugm5t0bDjf4ve7NyQCWkYmjPfuR7qe6ZG80h6xe8hXRF7izQQJ5eK1qb/woeBsCS0bwup/v+tNz1Oo3nSCLGer1q
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(5660300002)(426003)(26005)(41300700001)(107886003)(36860700001)(2906002)(83380400001)(1076003)(47076005)(36756003)(40460700003)(336012)(2616005)(40480700001)(478600001)(54906003)(7636003)(316002)(86362001)(82740400003)(7696005)(356005)(70586007)(70206006)(6666004)(4326008)(6916009)(186003)(966005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:04.4984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc39683b-1e1d-4f77-340d-08db9330938a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Hi all,

The first patch in this series adds a small optimization to VFIO
migration by moving the STOP_COPY->STOP transition to
vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed that
this can reduce downtime by up to 6%.

The rest of the series adds P2P support for VFIO migration.

VFIO migration uAPI defines an optional intermediate P2P quiescent
state. While in the P2P quiescent state, P2P DMA transactions cannot be
initiated by the device, but the device can respond to incoming ones.
Additionally, all outstanding P2P transactions are guaranteed to have
been completed by the time the device enters this state.

The purpose of this state is to support migration of multiple devices
that might do P2P transactions between themselves.

To implement P2P migration support, all the devices must be transitioned
to the P2P quiescent state before being stopped or started.

This behavior is achieved by adding an optional prepare callback to
VMChangeStateEntry. These callbacks are invoked before the main VM state
change callbacks, transitioning all the VFIO devices to the P2P state,
and only then are the main callbacks invoked, which stop or start the
devices.

This will allow migration of multiple VFIO devices if all of them
support P2P migration.

Thanks.

Changes from v2 [2]:
* Registered VFIO prepare callback only if P2P migration is supported by
  the device. (Cedric)
* Added Cedric R-b tags to patches 2,3 and 6.

Changes from v1 [1]:
* Rebased on latest master branch.
* Renamed pre_change_cb to prepare_cb and adjusted relevant code
  accordingly. (Cedric)
* Split VFIO vmstate change handler to two separate handlers, one for
  prepare callback and another for main callback. (Cedric)
* Renamed vfio_should_block_multiple_devices_migration() to
  vfio_multiple_devices_migration_is_supported() and reverted its logic
  accordingly. (Cedric)
* Rephrased "that are doing P2P" to "that might do P2P" in docs and
  commit message. (Jason)
* Added Cedric R-b tag to patch #4.

[1]
https://lore.kernel.org/qemu-devel/20230716081541.27900-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20230731102521.15335-1-avihaih@nvidia.com/

Avihai Horon (5):
  vfio/migration: Move from STOP_COPY to STOP in vfio_save_cleanup()
  sysemu: Add prepare callback to struct VMChangeStateEntry
  qdev: Add qdev_add_vm_change_state_handler_full()
  vfio/migration: Add P2P support for VFIO migration
  vfio/migration: Allow migration of multiple P2P supporting devices

Joao Martins (1):
  vfio/migration: Refactor PRE_COPY and RUNNING state checks

 docs/devel/vfio-migration.rst     | 93 +++++++++++++++++++------------
 include/hw/vfio/vfio-common.h     |  2 +
 include/sysemu/runstate.h         |  7 +++
 hw/core/vm-change-state-handler.c | 14 ++++-
 hw/vfio/common.c                  | 50 +++++++++++++----
 hw/vfio/migration.c               | 75 ++++++++++++++++++++-----
 softmmu/runstate.c                | 40 +++++++++++++
 hw/vfio/trace-events              |  1 +
 8 files changed, 218 insertions(+), 64 deletions(-)

-- 
2.26.3


