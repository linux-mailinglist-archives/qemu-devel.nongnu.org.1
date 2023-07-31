Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC64769316
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6y-0000k4-43; Mon, 31 Jul 2023 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ64-0000ap-90
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:53 -0400
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::624]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ61-0006sV-EY
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHFib0Rnp4aSL7e2Wm3wnbfxkAky1TP9OKreSSQ4BRh9G6o+iIKoof6El/m+0tdsZJclOIiANbqrC2hVNEWXv9gwaql+9Qgtby5Vrz6CAZPJvrYOTyJDbXGlV/QVLVavRiqBHo82i9pLmbdA3ct3rZ0DI7Hb/oWTJNwmSfYEltsyh5lkomhnF3vKzr3MeA3C884XMMl1wFYj9stoUDC0xxik5g4HhjSsmluNjG6shE5jq31RX7cgBiNpjl/aTmRtkbatt6eodfExvZu6J9+rDT+WSscCzb3OSDWwjj/f+C6U1f+RFScXZAuyAFIK2YHIxwWZUDbFV8mumJk4NVgqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isNk3kHCli+s9viho0e1clJ5QCuLYbAirIZQqPfhonA=;
 b=Cu/y2pDRhnsX/qRtd59/xxTjwoxgi9c9TOuj4GkEqOBIggDBxB+/7EA6exP3oSyu/pyJ4p5ezTezr/DjD+a2GgtOMouaDc8UQK0DFG5ywHIc1SRx8idvcjmdmnUY+6Jn1sxtwHv+646FflcpXhcHz62VZB8sJlQ0n1A6bsV9d4FGhjxXUuQ+q9C32kyWKt1r2OTIwlXuY6OL8kEvSuvpqeKLpgiy67CAsnj+8kjFuDH0So5EFI2WbGQfzg5DVavWyY+soIbFVOODSwwStxRw1080Zrwcf4JrEZJSUQ6wXSX3RqLOIO6KTOHq6+zrqHyb7c+L3ljkxVlSuwyt6P6u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isNk3kHCli+s9viho0e1clJ5QCuLYbAirIZQqPfhonA=;
 b=TexLotjhQDFzozHWCAGRtEfkVfBrYDaqqKMoo04GY28VOWIgjblfUqsFT+/9aKllyCPMTCMkeo07NgOSvV/m5RQ3PRX8+Q7BF9LH/ZH3sF05X4JCrjkfJ/XJI6ri997VBvfgxDpB/KX36re0VkhbpOJe1uDPjpeFWuRczlDBpnnEhd48u1BmBrJ80MrUfv9BmihQQS51BqXIMt2wtrcLe2CE8fxmqpBaVKSk5Okn3k1B404vCBfVfgT5/guNLsnntmJqtUZrZhzoAHFqqpLik3UayKRfwk4yj3T/6imdFvEyTdpP1YRba5jK8/yYQXEiiV0SYeLTItJMZiVSYf1b9A==
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 10:25:42 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::40) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 10:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 10:25:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:25 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:22 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 0/6] vfio/migration: Add P2P support for VFIO
 migration
Date: Mon, 31 Jul 2023 13:25:15 +0300
Message-ID: <20230731102521.15335-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: a77faab8-d84c-4d3e-496e-08db91b07e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqSzxr+tOG6thY9rkyvQJPrUq4f1T0rHfrRMbFsszBkRSrs+D7g7QNkrSMJxClJZEZ0zhbiDH0BXvRRK90UzQ0y8Vq5SWuvPU+67nkl6b1e/HHDvwwC2+P4iDzB8j5U+ooZbX/2HdtIMXXUDw3SVXa9dmS0N+h5HIDTfoOFmxj6dhOftzomK5wbIMUIYnGcHtbZFufn5Qnsda/+JvguXHd/iY90YNM+AZXcSf7+pmrKWdn3Fu+hToqU3z1rLbKCPLZGuDkkAmvwA/t7jxKZAlsxKuU/3Fsn6qobSaaE3YPOM50KFOLSYyLA2iJy0G1iWJtLcoD1/lpFE6x5yxRGqBDWyXvBzKlThPyFy5p3R1BOdXfCiNZn2Tm/KmUgKhfFk0UcFLy/awlYZNVO7qBYpNLLW+4eSqfMHxWxM/TYVgwclGn1AtML8fHtNI2R+JARr9rcDvWSZb1UtGpO+nCYQ5yq8OJD+kd7r+0EcYgP02IZ6f90CzZIHer9QG7zdrHrWivdUp9AW/uAqAsmjkhaJi+4slYSTHBXl+ek8ZQjoXs+oJg63AXlcrK8sEq/8CyrTett9tLFG+h+h2X3teLnwOce021diKpq+jUtTfyeMG07Y5F0hzS699QRUWpyc9kbrf9tLGN0Qqvu25NxWime7D1U5ITZRzYBI6Gj1Za6la8i78V8fxlzbycsSiS/x376wAWjLdY2KkEwdpYyp2oqM1DMcVFyjSnCn7phcOP6PEhV2Zl2ozRMKhAqk+Wo/tCb3q3TeNp02p1YPNHHk5kIFuy9aZHRIMjfDpE6RaDnpM2c=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(356005)(7636003)(40480700001)(86362001)(40460700003)(36756003)(966005)(6666004)(478600001)(7696005)(2616005)(107886003)(186003)(336012)(26005)(1076003)(8936002)(8676002)(5660300002)(70586007)(70206006)(54906003)(2906002)(41300700001)(6916009)(4326008)(316002)(36860700001)(83380400001)(426003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:25:41.9212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77faab8-d84c-4d3e-496e-08db91b07e33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::624;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
 hw/vfio/migration.c               | 76 ++++++++++++++++++++-----
 softmmu/runstate.c                | 40 +++++++++++++
 hw/vfio/trace-events              |  1 +
 8 files changed, 219 insertions(+), 64 deletions(-)

-- 
2.26.3


