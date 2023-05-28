Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AC7139E0
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3H-000110-VP; Sun, 28 May 2023 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3E-0000z0-TB
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:16 -0400
Received: from mail-mw2nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::614]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3A-0002dd-Oe
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGtJNhI0rkEX+HXr1y1nPgPKZZZ/X/60BjQ6GLKMm98=;
 b=aUEo0dHYwWWBtr1M5erM0k5n334y9JwfYrKVLP+Amdchgqc18OVBFeucqmbkSZkFrCtTWspJWebfspKe8EHBoEa4jLKyA2bzkolOYFk5y5HPQi/OMZ0gCZBPPaQhAYB3MkR0cH/UTI2zl+eLfpJTA21xkYe0ro2Okb+FW0Nv94fXNxH2UUZCRLra7W6dqxjUeHmE1FjleT9N0uIJvXH9NHnFTPJfk6X3ZTXmtqCEIwoS2PFFhmIpPmI5P2kq0bKAYjHrVNsVJJWh2nVvO9waBacnETnwR+OHvJegsNg3Gmu78SzBswiEk7NM7YTvQaO0giDATAS53qhqzIMU3a1DVA==
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 14:07:07 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::24) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 14:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:06:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:06:58 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:06:53 -0700
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
Subject: [PATCH v4 0/9] migration: Add switchover ack capability and VFIO
 precopy support
Date: Sun, 28 May 2023 17:06:43 +0300
Message-ID: <20230528140652.8693-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: da2f302c-e332-479c-ffb1-08db5f84d24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iggcQmIiErfOfb7nmRdZwyV8g+V5W4585YjkOotpMKBib7Xwk1auN0B10oHkckP+q8+JOaUggRLkaT5BxP8+7/BR68NwN2PJtPdf7LtdRYRtpX+oe2sfvjqax/TTH6BO3OmkLj44b0ctqA/Qkzzo21aT4wu+uHSdAyUxXCb6JLvn8b2+Wy/G4FHhLDu+/YhI9nIoItnM6tsnPR8M+McN1LlIX7kP/0z3zStrPpTM/FBVdLxxUhsTOMM6RWq9S7KDy/ib9LvHSEkDoig55o3PIOSWI5AaCbM/Vm3GF9er75ddq/KQbObU9KBMgrvcZ7DVEjQRFHN7qeJP1w+DC6Qu0ycmeSq2XMRKuoo+hFcgC0UaSlOdy4OG1u/85LW+TIHaX/psBBgK7VBGFRPGcmcb21PifMzUp5W1mx5HaUpJ/3qwoKlTrPqd0GisrkRc1XJA3i8MkRV4TogEsO/xhiVC1QEIf3oJ75LtECslyo3zZyKhK3DlWt/4NRi3FsbQX/MOQLe5+MQEfyQJYDupLdP9twbh0MUPnF+liojE3p15sLFMXMDdTTFK3Hktpld4hFvIjh1SfUc6Ck3O/4sDVULOzYxD2tsLEMg4SYTQ0mEiUXS0Yd5A0Ue/nqRFGnKWBqERyYHwYK/R4eZ6uPLtLsUKEmOjYTVPFHpEt2w6FGdZQBHrWx7cn30NZNJxemjOtN0bGFLVIndnFy+Kl0s+H82Uj4OWlIwFzeRWtwxeiPGXNI04uFva+C2tKzLEladoDq4Asq3ssgNFlawgtb5ZgajmGgfyof6v8ar96sUsyui31GQjj6zuDn3vfrLLaC/LrDi
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(2906002)(54906003)(40460700003)(6666004)(5660300002)(70586007)(70206006)(82740400003)(7636003)(356005)(6916009)(4326008)(7416002)(40480700001)(8936002)(8676002)(41300700001)(316002)(86362001)(26005)(1076003)(2616005)(186003)(47076005)(83380400001)(36860700001)(82310400005)(336012)(426003)(966005)(7696005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:06.9634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2f302c-e332-479c-ffb1-08db5f84d24a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
Received-SPF: softfail client-ip=2a01:111:f400:7e89::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hello everyone,

This is v4 of the switchover ack series.

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
- Patches 5-8 add VFIO migration precopy support. Similar version of
  them was previously sent here [2].
- Patch 9 adds switchover ack support for VFIO migration.

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

Avihai Horon (9):
  migration: Add switchover ack capability
  migration: Implement switchover ack logic
  migration: Enable switchover ack capability
  tests: Add migration switchover ack capability test
  vfio/migration: Refactor vfio_save_block() to return saved data size
  vfio/migration: Store VFIO migration flags in VFIOMigration
  vfio/migration: Add VFIO migration pre-copy support
  vfio/migration: Add x-allow-pre-copy VFIO device property
  vfio/migration: Add support for switchover ack capability

 docs/devel/vfio-migration.rst |  45 +++++--
 qapi/migration.json           |  12 +-
 include/hw/vfio/vfio-common.h |   6 +
 include/migration/register.h  |   2 +
 migration/migration.h         |  14 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   1 +
 hw/core/machine.c             |   1 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 230 +++++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |   2 +
 migration/migration.c         |  32 ++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  54 ++++++++
 tests/qtest/migration-test.c  |  26 ++++
 hw/vfio/trace-events          |   4 +-
 migration/trace-events        |   3 +
 17 files changed, 423 insertions(+), 33 deletions(-)

-- 
2.26.3


