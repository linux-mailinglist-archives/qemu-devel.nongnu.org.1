Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9A738245
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvq5-00065i-WD; Wed, 21 Jun 2023 07:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvq2-00062V-R1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:17:27 -0400
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com
 ([40.107.93.66] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvq0-0003rp-C0
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfzVe5Xf9o1anngCe6X1tUUm/ua/0M0vfonrDYdMb8WpEnQNvvryqpb9eidYqpwSO8GaG6dX044eXW7zhAHIBNJBNvFTUNadja+3ySpIn3vUtx9hTaLMnje+oQPm9TvIgYqlVMSqM78OhHDACLvnuKULJmtdaXCvWo0TCVI/iUQlI8XnsgDkgfgHqAJpksTS5F0kSHi1ZtKLHX5iErDI0ehnoWaX9QpzanuwmEgo0tzyruKm2YISOOjr+sUCReSDYyLBSxpWpOcoxH4yqvN+Pe4bokSI+oMIMPxDCSLTRpTMvKbtcdPAn0Wj0QGAtr9arH0kdPYYeMPyZ7xi4nn1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtVqmOam0jYsIXJNpLdU3uPmnD0pSXY4D+Xr+BdMCJs=;
 b=MAGBrSYImPwYhUKrzxHLllNBCA0VOfh+lNUeatFmctspmYw9xMPzdDClFXSrvKxnCUfSltoadngZYXDp8pTuvAvUzYDgyiWmYZaLr2EPHpaL5N04yOTI+ZUGJkq7z1DKTTGJXmXttgP3YFPW72x2SVno/EP2bEI3qXqKD9AcNTFbYAWPbMzpS753FjLSccCrmSO1DJai4+Fs/SgDliMEvX9C42ER70CODa2EmberixznNkUxkioo8jL6lzT5xRi64parUCbVQVoxI9peZ9iiErWrjijz8/ywTNMmwhFgXM0VZe2y/SkWOOA6INOZCYyLAxR5gqDe2/C5GqZ9YcvL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtVqmOam0jYsIXJNpLdU3uPmnD0pSXY4D+Xr+BdMCJs=;
 b=TFGvmhe/gR2nb9/QsWge1EhUvpA0U57O6cUJI46iM98uXJF15Ju5cjkIn34DhBSJezZUCrpfaUYL84R5aEXDgzReEynglrmdMjEpc0hGFLwsDPELXKQwgVZfoMni/Os81nexS6oYwhRyUMfbHG/mfNmVcmRe0WWdvJdpyK+KvLRroBfRxR1cWNJBWjGmiv8ph+jtPNjFaER5c2gpNa+gvqxueUvw6CVTFF2ApJokWFUShlarw1LKDqI3jWg4xRXlB9r7XpJoGPOn3TBn1rBy5PKLCY0T8Yuzeynw+IcLgCaijEUyXMkrDNBW3VhLsUIMl+oUn/Mh7shux3pb9GpgFQ==
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 11:12:19 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::a1) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.38 via Frontend Transport; Wed, 21 Jun 2023 11:12:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:02 -0700
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
Subject: [PATCH v6 0/8] migration: Add switchover ack capability and VFIO
 precopy support
Date: Wed, 21 Jun 2023 14:11:53 +0300
Message-ID: <20230621111201.29729-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: c450fc68-6ea0-435a-29c3-08db724860a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUG9dCMKoLK3MdcZAjZcbJSC+QmSUw3uis0Q5yYMrUS7mQgDPEnTdt4/J3CF6SNP7HQ/R4YgMzphkibBX5ap033xzj/a630rh3a3lc7ISB8xULZFav6pvuT/ZKT58KKZcYP6wFS9pUwmHsBP2EeJy1DkCez2vi/JbqSPmiF+YiJ5zXIptagBMmg9lBqjMyEA/berWiwY598O85KKZi6WYT34T+U54rL+xRFCBkpr0bhrUQxuRBKP0CcXIWVeH/z0njiiw52CLzyjEWIFdaS115A/BfyUeOQLyHrZBRAjsKpp8l4ltS8Jd9jVmgtPHjbkiJ7jt5enAvM8upigBmoO12kOy3bqNch7Uf/IoZqldaswPkVvappG30/KlsDayLYg4n5fO5VgfARKyF7nWTARIZk9urDpBvLZ4Zu76v5bamWGhe73XWEDThDca0yWDL2kUOmssxziQzULtdGb8ODt/7dY8KRBaYr6VhQA3nyeFE+OD37sHEsp+KKxOER41RUbM8m1f4c/sniK2hSq7drVUQW6fDaHQsaUOa7vBAjSR+rGsj/weBMOeCywEja+9WLOBFlOfpBArWyNXP5VlJgbTK3E3tSJxnvQ8LzFicTDwfEc8yaeA+Jfb7vn0Y+upG/CvAV6z2N4yjwp65c8HmCX9l4hlFI+b4Oi+EATFMEFacsr74llqKpzKENRVxLB+uLrDLXKUwr36p8PzfJOeIB3Plm2nfYg41Om0DKG/V8MZHR878ORKGOiGTsZx8S4JvuKEkgeMVvugCnE3bor0WRPzrd9cNbrS1CkFsuQg9QHRPO7sRN586TzYKwnvvjGtwAC
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(356005)(82740400003)(36860700001)(54906003)(47076005)(336012)(7636003)(83380400001)(426003)(86362001)(1076003)(2616005)(40460700003)(26005)(4326008)(186003)(36756003)(40480700001)(966005)(2906002)(5660300002)(6666004)(316002)(82310400005)(478600001)(7696005)(7416002)(6916009)(70586007)(70206006)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:18.6012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c450fc68-6ea0-435a-29c3-08db724860a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
Received-SPF: softfail client-ip=40.107.93.66; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello everyone,

The latest changes to migration qtest made the tests run non-live by
default. I am posting this v6 to change back the switchover-ack
migration test to run live as it used to (because the source VM needs to
be running to consider the switchover ACK when deciding to do the
switchover or not).

Changes from v5 [7]:
* Rebased on latest master branch.
* Made switchover-ack migration test run live again (I kept the R-bs as
  this was the original behavior when they were given).
* Dropped patch #8 (x-allow-pre-copy property). (Alex)
* Adjusted patch #9 commit message according to drop of patch #8.
* Added R-b to patch #9 and Tested-by tags to the series.

Changes from v4 [6]:
* Removed superfluous '"' in vfio_save_iterate() trace. (Cedric)
* Removed VFIOMigration->switchover_ack_needed and computed it locally
  when needed. (Cedric)
* Added R-bs.

Changes from v3 [5]:
* Rebased on latest master branch.
* Simplified switchover ack logic (call switchover_ack_needed only in
  destination). (Peter)
* Moved caching of VFIO migration flags to a separate patch. (Cedric)
* Moved adding of x-allow-pre-copy property to a separate patch. (Cedric)
* Reset VFIOMigration->precopy_{init,dirty}_size in vfio_query_precopy_size()
  and in vfio_save_cleanup(). (Cedric)
* Added a reference to VFIO uAPI in vfio_save_block() ENOMSG comment. (Cedric)
* Added VFIOMigration->precopy_{init,dirty}_size to trace_vfio_save_iterate(). (Cedric)
* Adapted VFIO migration to switchover ack logic simplification:
  - Checked migrate_switchover_ack() in vfio_{save,load}_setup() and set
    VFIOMigration->switchover_ack_needed accordingly.
  - vfio_switchover_ack_needed() doesn't set VFIOMigration->switchover_ack_needed
    and only returns its value.
* Move VFIOMigration->switchover_ack_needed = false to vfio_migration_cleanup()
  so it will be set to false both in src and dest.
* Fixed a few typos/coding style. (Peter/Cedric)
* Added R-b/A-b (didn't add Cedric's R-b on patch #7 as switchover ack
  changes in patch #2 introduced some changes to patch #7 as well).

Changes from v2 [4]:
* Rebased on latest master branch.
* Changed the capability name to "switchover-ack" and the related
  code/docs accordingly. (Peter)
* Added a counter for the number of switchover ack users in the source
  and used it to skip switchover ack if there are no users (instead of
  setting the switchover acked flag to true). (Peter)
* Added R-bs.

Changes from v1 [3]:
* Rebased on latest master branch.
* Updated to latest QAPI doc comment conventions and refined
  QAPI docs and capability error message. (Markus)
* Followed Peter/Juan suggestion and removed the handshake between
  source and destination.
  Now the capability must be set on both source and destination.
  Compatibility of this feature between different QEMU versions or
  different host capabilities (i.e., kernel) is achieved in the regular
  way of device properties and hw_comapt_x_y.
* Replaced is_initial_data_active() and initial_data_loaded()
  SaveVMHandlers handlers with a notification mechanism. (Peter)
* Set the capability also in destination in the migration test.
* Added VFIO device property x-allow-pre-copy to be able to preserve
  compatibility between different QEMU versions or different host
  capabilities (i.e., kernel).
* Changed VFIO precopy initial data implementation according to the
  above changes.
* Documented VFIO precopy initial data support in VFIO migration
  documentation.
* Added R-bs.

===

This series adds a new migration capability called "switchover ack". The
purpose of this capability is to reduce migration downtime in cases
where loading of migration data in the destination can take a lot of
time, such as with VFIO migration data.

The series then moves to add precopy support and switchover ack support
for VFIO migration.

Switchover ack is used by VFIO migration, but other migrated devices can
add support for it and use it as well.

=== Background ===

Migration downtime estimation is calculated based on bandwidth and
remaining migration data. This assumes that loading of migration data in
the destination takes a negligible amount of time and that downtime
depends only on network speed.

While this may be true for RAM, it's not necessarily true for other
migrated devices. For example, loading the data of a VFIO device in the
destination might require from the device to allocate resources and
prepare internal data structures which can take a significant amount of
time to do.

This poses a problem, as the source may think that the remaining
migration data is small enough to meet the downtime limit, so it will
stop the VM and complete the migration, but in fact sending and loading
the data in the destination may take longer than the downtime limit.

To solve this, VFIO migration uAPI defines "initial bytes" as part of
its precopy stream [1]. Initial bytes can be used in various ways to
improve VFIO migration performance. For example, it can be used to
transfer device metadata to pre-allocate resources in the destination.
However, for this to work we need to make sure that all initial bytes
are sent and loaded in the destination before the source VM is stopped.

The new switchover ack migration capability helps us achieve this.
It prevents the source from stopping the VM and completing the migration
until an ACK is received from the destination that it's OK to do so.
Thus, a VFIO device can make sure that its initial bytes were sent
and loaded in the destination before the source VM is stopped.

Note that this relies on the return path capability to communicate from
the destination back to the source.

=== Flow of operation ===

To use switchover ack, the capability must be enabled in both the source
and the destination.

During migration setup, migration code in the destination calls the
switchover_ack_needed() SaveVMHandlers handler of the migrated devices
to check if switchover ack is used by them.
A "switchover_ack_pending_num" counter is increased for each migrated
device that supports this feature. It will be used later to mark when an
ACK should be sent to the source.

Migration is active and the source starts to send precopy data as usual.
In the destination, when a migrated device thinks it's OK to do
switchover, it notifies the migration code about it and the
"switchover_ack_pending_num" counter is decreased. For example, for a
VFIO device it's when the device receives and loads its initial bytes.

When the "switchover_ack_pending_num" counter reaches zero, it means
that all devices agree to do switchover and an ACK is sent to the
source, which will now be able to complete the migration when
appropriate.

=== Test results ===

The below table shows the downtime of two identical migrations. In the
first migration swithcover ack is disabled and in the second it is
enabled. The migrated VM is assigned with a mlx5 VFIO device which has
300MB of device data to be migrated.

+----------------------+-----------------------+----------+
|    Switchover ack    | VFIO device data size | Downtime |
+----------------------+-----------------------+----------+
|       Disabled       |         300MB         |  1900ms  |
|       Enabled        |         300MB         |  420ms   |
+----------------------+-----------------------+----------+

Switchover ack gives a roughly 4.5 times improvement in downtime.
The 1480ms difference is time that is used for resource allocation for
the VFIO device in the destination. Without switchover ack, this time is
spent when the source VM is stopped and thus the downtime is much
higher. With switchover ack, the time is spent when the source VM is
still running.

=== Patch breakdown ===

- Patches 1-4 add the switchover ack capability.
- Patches 5-7 add VFIO migration precopy support. Similar version of
  them was previously sent here [2].
- Patch 8 adds switchover ack support for VFIO migration.

Thanks for reviewing!

[1]
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/vfio.h#L1048

[2]
https://lore.kernel.org/qemu-devel/20230222174915.5647-3-avihaih@nvidia.com/

[3]
https://lore.kernel.org/qemu-devel/20230501140141.11743-1-avihaih@nvidia.com/

[4]
https://lore.kernel.org/qemu-devel/20230517155219.10691-1-avihaih@nvidia.com/

[5]
https://lore.kernel.org/qemu-devel/20230521151808.24804-1-avihaih@nvidia.com/

[6]
https://lore.kernel.org/qemu-devel/20230528140652.8693-1-avihaih@nvidia.com/

[7]
https://lore.kernel.org/qemu-devel/20230530144821.1557-1-avihaih@nvidia.com/

Avihai Horon (8):
  migration: Add switchover ack capability
  migration: Implement switchover ack logic
  migration: Enable switchover ack capability
  tests: Add migration switchover ack capability test
  vfio/migration: Refactor vfio_save_block() to return saved data size
  vfio/migration: Store VFIO migration flags in VFIOMigration
  vfio/migration: Add VFIO migration pre-copy support
  vfio/migration: Add support for switchover ack capability

 docs/devel/vfio-migration.rst |  45 +++++--
 qapi/migration.json           |  12 +-
 include/hw/vfio/vfio-common.h |   4 +
 include/migration/register.h  |   2 +
 migration/migration.h         |  14 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   1 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 220 +++++++++++++++++++++++++++++++---
 migration/migration.c         |  32 ++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  54 +++++++++
 tests/qtest/migration-test.c  |  31 +++++
 hw/vfio/trace-events          |   4 +-
 migration/trace-events        |   3 +
 15 files changed, 413 insertions(+), 33 deletions(-)

-- 
2.26.3


