Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED3070AE87
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:23:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kuJ-0005Ej-65; Sun, 21 May 2023 11:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kuH-0005EZ-5c
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:23:37 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com
 ([40.107.244.40] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kuE-0000qp-Rs
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:23:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvLK6elTfAqV2wLhjxrIzNQL8OE7AsLS25KaGnuZ4u8eChOxniDweh6YO1w9XgLwNBMKlTDezj7gwEYGdNtmlzal/CVz5VGXPzUN40vfYW9/stQZ0exxZifv+LibhmWQBYloRG8D/gQ2hWMuV5FMR3qeTuLyNFzN+EDcsZw6EX+9AKAncMWMo61dLAcoisTdqGQHtkGkjv5Om0SHmfCJ5VPmYEHieXtl5Khne+JQHprce5gZzogB4/9P2SgAuUa0cU24KO5tFacL4EbIn6SEEFlRuY7svm6A2LmuvGrGfYkM8dPf4m8lThIoxa0f58ms2MNd6UaewodCCqq9laQCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a1gHl6QZqZYhOrRaM3SVAHKi7Rs4vRe5jTVh/UJp8Q=;
 b=RN5NaQM+ZnUFJEvGdwRVbybU7uT7QqsgcKOiV7pxVjP78ejxuPtd4FFjNMFAZv4bowbE9xIOgCCqGsqC1Yq4ATnl2QZjINmYcqbp3a4Pv6sh2JnuK67Qs5hl8NEhE9CVbNxMEavaxbPnYN1CbluDNNpDsen16KvtOeC9pZFxLxbvZf0a/1aTsDjLdU1hVt/MCA9BmVd949qC8q4wwq55MHDrdECJNIB7OCsKhuwFVJNgQSIkldGq70+28jk4/iblUC6xmbidlap3sW1clWIaBjTwt0VQiAHs4goY7iNIL5gNaVHy6K7zpIJFe84YBEfBSX8KVT3fWIL4iBB0U7y4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a1gHl6QZqZYhOrRaM3SVAHKi7Rs4vRe5jTVh/UJp8Q=;
 b=asUyccoU3yG0UoEevuK5Rpm5Oov2Q3s92Itdch8mFPCsHxtNFxoJmu/dP6R60Rzg/WYV1F1qIDqPYvWiOsJJd0fX2hecM1o/4Xx1a30kh4YxxFxIvZ7zuOrpJZG6EKaiIXKfp2wl6kwEtDnYwbFM1rZAM6jUKUxIvPs+E1fW2Iyp9LzCfQzhVFAckxh+WzBf3oEPzffiz6yY+yAEnteQcFQMbZ/zjXBJoVDORtQX7jnNM4ZOgcxthaoMDTnJ7+HdnXb+7ip/MRUmSpdJf0sfsP9oODtI+iDNwc2kRQSB4me6tI16Q10nSLiXRsIkw9QwFJfoGyLcHn1dNrj9w8PieQ==
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:28 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::b9) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27 via Frontend
 Transport; Sun, 21 May 2023 15:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27 via Frontend Transport; Sun, 21 May 2023 15:18:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:14 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:09 -0700
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
Subject: [PATCH v3 0/7] migration: Add switchover ack capability and VFIO
 precopy support
Date: Sun, 21 May 2023 18:18:01 +0300
Message-ID: <20230521151808.24804-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: ef161cb6-b131-45fe-e9dc-08db5a0ea0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdAbNstWeJYcT1shoj8rBOWrlyOO+pTC7cmuQqGr2dnJT83/44ahQV5jKFI+KAD+4lJ1VZpXa9Qp/EU7pigjS3hdN+puRZzkg2O0rRi8H/8u9h5x5Mw638smS3ON02zV3uz2fRdSBpplDwXbm64fl8aerP9PkgrcZ61RgjBkiol5fRUiTjZumcxQrsIfu2fdSwTK+m8xC7bmMUTKKcV5JHNPP981BThBmmJ7bG53j/6XGz3AxcASIVsg0V//vce68ud3bOEo5fkaDLld1M12T5K7v7hAoUcBerUyxnS0f0EQRtMLcSGr+u+baS15aN11zWOj5pH9uhfXVrcM03NYHQwBvaH5UPZtQF74WI/r0F0lMoWK5ciCPCIPI0W0cb7ohp23fIIrv1UncPg+ifgBhxHxVMwrb9tG/fcDHD17rLzsxk4zJiU1TMkhQJEJ/ytjfB3E7VSItK2spCH/y9f2LPfiiYJwb/ulS9nvyFytb2ItWHCRdFfTQ0fKLGEiwL3gVzcrgn2GlAWAho0C1vTfS7hnxpJqdBwSdGGfIKihLWgsbOZLaqwTV6Dt1S96L8am7XRt29yySGFUwiqsFeak12FkxyEzuHrc0wbfmk1c/wTXcKXy97e9eolP5ArqVoFQTXhiGaalbNNVn/GWeAcwFXMZjOiHa6tzyUMf6Z7+Hg40HZB5WwNsFBBrPj/9/aZOqHXPvvBzPJ/ruNMVnw9MW9dgOm3EHvaIEfNPnFroIxP10AOX3xiy95UuE5iOwzywFhNtUgPEIkTkKiKLDoVGMNoRWNfQlqZEhXKqp7JXpX/LED7vMVgEMTpK2AKpJAT9
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(5660300002)(47076005)(7416002)(36860700001)(82310400005)(186003)(83380400001)(26005)(1076003)(426003)(2616005)(86362001)(82740400003)(336012)(356005)(7636003)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(966005)(70586007)(70206006)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:27.6459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef161cb6-b131-45fe-e9dc-08db5a0ea0db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
Received-SPF: softfail client-ip=40.107.244.40;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

This is v3 of the switchover ack series (previously called precopy
initial data).

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

During migration setup, migration code calls the switchover_ack_needed()
SaveVMHandlers handler of the migrated devices, both in the source and
the destination, to check if switchover ack is used by them. In the
destination, a "switchover_ack_pending_num" counter is increased for
each migrated device that supports this feature. It will be used later
to mark when an ACK should be sent to the source.

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
- Patches 5-6 add VFIO migration precopy support. Similar version of
  them was previously sent here [2].
- Patch 7 adds switchover ack support for VFIO migration.

Thanks for reviewing!

[1]
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/vfio.h#L1048

[2]
https://lore.kernel.org/qemu-devel/20230222174915.5647-3-avihaih@nvidia.com/

[3]
https://lore.kernel.org/qemu-devel/20230501140141.11743-1-avihaih@nvidia.com/

[4]
https://lore.kernel.org/qemu-devel/20230517155219.10691-1-avihaih@nvidia.com/

Avihai Horon (7):
  migration: Add switchover ack capability
  migration: Implement switchover ack logic
  migration: Enable switchover ack capability
  tests: Add migration switchover ack capability test
  vfio/migration: Refactor vfio_save_block() to return saved data size
  vfio/migration: Add VFIO migration pre-copy support
  vfio/migration: Add support for switchover ack capability

 docs/devel/vfio-migration.rst |  45 +++++--
 qapi/migration.json           |  12 +-
 include/hw/vfio/vfio-common.h |   6 +
 include/migration/register.h  |   3 +
 migration/migration.h         |  16 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   2 +
 hw/core/machine.c             |   1 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 220 +++++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |   2 +
 migration/migration.c         |  42 ++++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  56 +++++++++
 tests/qtest/migration-test.c  |  26 ++++
 hw/vfio/trace-events          |   4 +-
 migration/trace-events        |   4 +
 17 files changed, 430 insertions(+), 33 deletions(-)

-- 
2.26.3


