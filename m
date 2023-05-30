Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 200267164F6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:49:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40ey-0002eQ-HH; Tue, 30 May 2023 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40eY-0001xR-OW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:53 -0400
Received: from mail-dm6nam12on20621.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::621]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40eT-0007mM-HI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXfU1+OYSXauMenX3wXETCs9uPJkPEK4B6iVY5XvUDgpArECvxHmk3yN6T6sCy0SpcU+R3VwYdD18dPgeSsskBUAHGf/9sNVfnJOuEBBcmBwcdIibXtJJ0WKUgazRqfR3KcIgYqIuX548qbmGxDknW4NFpOQKMsUuK0KzLCOWAj5B6QNyxUYJ5M/5WMNuPAxdaQefh2JlULY47B9mo2J9S8ex606NSVAGNy1LSwIkFL74o+Nom6QWHJSXMWKXSY4ECfAYRXuz3kHyg854G+qch7+gCT+vWe1gNeKr0YKG+MDhc1+Q/16SXU4ZWBfsR/QuIUuODL/RXEujHZNP6ehJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boQp5sEBWwb/4E1FBqHGrKaRWFTfs2UX/VysmdldINs=;
 b=gro3QdA0nz0oFWxRZJKWsNmUWJs0SJf+JALfi9FhD/vDTZhC4BeBnhyTpoMAQeh/oj5iRQ2pwhxNDgPgsK+rYG3NzAzKlK/pHqqRBl0Cy2hkA1EFoNnUwrPd/9/PbOJa+4up9/ZwJWYV53ona0N2U85xD33+fr2eLZpF6vqJBQe+gpeKivKsE3+hKLTYBztWSlmEQhCnkS1vJX6rChNn4GIhISEURT51oTkNVH3Xa1TCEAfiOusNQDvr0WVwfzgK6kX11jkOpMR359WOToKS5NuGiREbWL+rbk+BjradEvBdKMEa4fEmViCVEAPqUk8aMI5dyhbcZ9OUDPL85YwRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boQp5sEBWwb/4E1FBqHGrKaRWFTfs2UX/VysmdldINs=;
 b=INk6lXjn6d0OHEuIyPr73Z/KfNvcjugx5t28kVyB1I0P64jW2ARTgwjrqQlevP+hDK0XpvCjPkg993mg3J/hWXIY1/lbBquBfiuRSBXzvbhIyNjOB95DFJQ2NJZn/kujb4Wgz6YSoZyBcd204QjImggYIULKqzhkOI4RNQFifu/VpPufCRa9y4T+qcazuAHY/Vcl7nDqrbVUeAKPL6qrEux1zHDFsW2f6BX4H5IpKLXrQ2qM873HxFa3+Y1YOjjqG33TDhNpZ+6Xz3Pv7OA4iuIuaQGmdGCVaatCGJbvwftUjHhABYbvLvUFxIqPufrUMN22sur9+inzlyaS3MOnOA==
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:48:38 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::fc) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:48:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:48:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:48:27 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:22 -0700
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
Subject: [PATCH v5 0/9] migration: Add switchover ack capability and VFIO
 precopy support
Date: Tue, 30 May 2023 17:48:12 +0300
Message-ID: <20230530144821.1557-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: ee23dacd-2f10-4ba0-41dd-08db611cf429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Udy90j+RZhUxTPWjT3etydCzFYArYA7srBUSmNN49pOfxR/HbGoO1rs0wcE7nQTAsO8fNynOffqI26nQuVtJ8gcRj07HuRK9VR6OqV5JYy7OWG9EBNL+u5lWvimFtYYMFlHaDDlFoUbHsYfVlTy0wiXgVZr/DziDg4j5KwvAXky6UP0sx9WZaJJAM83ZaJhgELKc3c2tMrz/aS32rnZX3WRRGXzSeoqEdA8RNqXYis07dk7AqLo7U4DN1eSugA8ZE90oUYg06hx5YgKbR/IsYEdduRu70O6A1B/Wyv2zLWdFIAoBUqeIT5FAHehzPw05lpZwIgvBZrCDUKPGS9hRTsFa5LFYn88iIpuZPabYvXujEbVd3IZYwmQdWskubZlOZZmEB5VHzdfq3z2iGEnYGqIn5TGFa6Q7msRq+JU+IWfSEUtOru8YttopOUJkRGnVb0jnSYJEDF7fXlbSgman7BNPcdai1J3nUGzHdDSFP5FbZeOkVSybV3i7sRl7FGrRJLh2KPNQmiIFl8rJPhfO5hvdQDTxyQJMH2lj7PA9sTbmbnFXjgWGQIk/TpB8xBezHUDRje4/plZbPVq84NnIHMIHetlRUSf8Wwv6Z/QWGZwNVZhKVLbrx9tADSjb5uedAt5+ZT1GgfrSUhpGcyJEDNmcAQrF56xWy4csoyYxC/y8LZh1uJb43ZrrHWjojN96bFpitcGomKQMKxRzASdwtf92oZLUgxkNCXD4sUJgJAaS5vd8mSolOKp30zYfo+Bf4PViC6lpf1kUbZEeFmtB+GSi8KkRoHXkykt+JiUgNPF7IR1QFHE6RRfK6FzGrTP+
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(86362001)(7696005)(41300700001)(966005)(40480700001)(478600001)(40460700003)(6916009)(4326008)(6666004)(316002)(70206006)(70586007)(36756003)(7416002)(36860700001)(5660300002)(186003)(2906002)(2616005)(1076003)(426003)(336012)(83380400001)(47076005)(26005)(8936002)(7636003)(82740400003)(356005)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:48:38.5286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23dacd-2f10-4ba0-41dd-08db611cf429
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
Received-SPF: softfail client-ip=2a01:111:f400:fe59::621;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hello everyone,

This is v5 of the switchover ack series.

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

[6]
https://lore.kernel.org/qemu-devel/20230528140652.8693-1-avihaih@nvidia.com/

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
 include/hw/vfio/vfio-common.h |   5 +
 include/migration/register.h  |   2 +
 migration/migration.h         |  14 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   1 +
 hw/core/machine.c             |   1 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 221 +++++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |   2 +
 migration/migration.c         |  32 ++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  54 +++++++++
 tests/qtest/migration-test.c  |  26 ++++
 hw/vfio/trace-events          |   4 +-
 migration/trace-events        |   3 +
 17 files changed, 413 insertions(+), 33 deletions(-)

-- 
2.26.3


