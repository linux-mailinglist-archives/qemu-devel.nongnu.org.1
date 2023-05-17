Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D8706D5A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJSN-0003Io-E2; Wed, 17 May 2023 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSH-0003D2-8T
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:45 -0400
Received: from mail-dm6nam11on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::631]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSE-0005tP-0j
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol9lQm8NxvLlY28KcB50pP+2Qpjnyn1BUZ5mDEDd8cgPljs/IvyQI36QQHSN8jj+xmGBTP7cYSft3TAPO9FtW4Eo/q1a7FpQdFoghbGDybYr70dc4uue/eHfi+XWr+cu//zlJGh7nPP0R6pd64sXpPHPAGPqhwpy5jAy4i4FH0oADYGYp0QbwoF5t8HzKYfKqSMFKC/VVWEpV5zPwfB7vujxytL0mwiDeanE89iAJvmxbjCYcaq+buOpy5MxRyFrRi6SDj/S/ltdJRGeN+nZOIFgKayphp4SARXloVxZQVQyNKVSMB4m+4IIWoUDaJNETyMcsHI0HCgGAyA2siOVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3coa1a5zun8xZs0gP1w2ucz8wJQqn7vkHcxMIsqm+s=;
 b=a8OWnjYX5cg8VxPOXvygNY0Ym2vghsBoET2T+o6VP/zV6ysp7CGmJCu7/w2E3+fLR5aBd8eLTkaoxo5U3vTOBKkELYpIZNzJ1wC4nYyEx+5UltEAQZ4BcLU+mFeGyTVG9c+AqTaYSV2AyehRZsoE1JcwyRc0Nx57FJTScgi9NcoCzQTyT/FP0dYrqKbytwYCyO4vQINuSibj+onNW//2WRJ1H2dqWCwEWEffV95X4GBNlGn2k56XFeSn2J+G4lbZlkTm1rabmYTU9pxKBnKcOMjsqq6j99mtFEaDAE2jU0HFtcPmjw4ShTpozwPmlfaRrNbdHyghiA3Kl+RVMp39sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3coa1a5zun8xZs0gP1w2ucz8wJQqn7vkHcxMIsqm+s=;
 b=Whugy2kpDJ+vjCgOUzPpITulNNCBlXE8B2pbUIEVBoMS+M2VPK/p6GAQl9l1EIhlE9bR3daNGfBvstiFtuUqHxKuHN3BNijDwkkMw5A6ThFXdF/zQGQ4LFN1sFMphv5ESr1yKeaDle34Z+mNKCw1zeSdizWQtpMA5zVkgz5DgtjfDBvsd/MZ23RKIICT518dsKYETcisNJzext9QmcS3x+GttB3MfMAI6LZL46Z/Vxwmq+dnmyntQqT83olWRmVZYWHyFriN9L8ZKFi4GqlxN6P6QuyxWnaj+iVKeufB73DB5o3yoGg6qJQmsWbzOnTHmsIG6kWPFYIKEHIXOEp1uQ==
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 15:52:38 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::ad) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 15:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:52:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:24 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:19 -0700
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
Subject: [PATCH v2 0/7] migration: Add precopy initial data capability and
 VFIO precopy support
Date: Wed, 17 May 2023 18:52:12 +0300
Message-ID: <20230517155219.10691-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: a1104e58-0585-43c3-2201-08db56eebd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6Cw27SZgTIVyGecbJC7o/vFlqN9NxIWblaZD2mVs1ywnyhj6X6QPvH41azWXuVzqyk6UNSUPucPBuVDga2Bl0hzHAuEJtREKatBmIYjUc3LkZkpGLsXfzVrvI+d76jfIA5slVbpIqNwy9wLdax/KdZ8+bMi3xNKwwu+MPuu4OYSxTkIOluqaENGHP2ir15KEurE3IAEbVBOQ/IHTgcjRftsK0nkprP069S65tdkPs3yv17JrNlY1YupyiNTAuakcKxL9DgtDFLrymm1u7wnCRtQZdDjN6FB9Q6lMyK+GCevfqj1wQHL/QbEBKt1e4kNZs0bofvcdG+uAUJ1Ok+wY/kLIQA1QDjRPir0sWRncXtmA1n8hyKbzQB7ua7Sac1cpBV10gI8Qfj7/Yj7fYRxP3ZVAaOxZZcuaeRZAl09pgfD5qxoi8VTvtyjX1hU/L9fTOw4djMe+rZCdEsIK/E194byoc8sqe5kEYVMPkwT3pjWKKh8DkIjyKfBo/lKhQdtzXsM0zD/ZRYfiaG1VnIkUn+O1n/MWhp9gLjKx0yQ4w6l/g5QcRGpyiAKgOHy3UevbYt4kf3Xptc9lJuJKaBA+bbpKRb6IMTo+tQLISuDRUpYkfBUkb/lagbvs6RJIoAtuS+vfACJsE82GPoaEtGP00m9kFX+07Knj73LmuzMwJian7zoP8ZjILsQckOQiQpzXAQoQYcmKP1BCBExlcVAF49sNFp+GGjZX5khvbfSu3cqmena97U6YtGSfK6QGhZX7Ts5hpT37KMl3bI/vdDY5dgLTJyORDbw6odxD5eS5OAtXPloB0K0FuBiR4WaQJBS
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(7416002)(336012)(426003)(5660300002)(966005)(83380400001)(47076005)(186003)(1076003)(82740400003)(7636003)(82310400005)(36860700001)(86362001)(2616005)(356005)(26005)(40460700003)(54906003)(7696005)(6666004)(478600001)(40480700001)(70206006)(41300700001)(70586007)(6916009)(4326008)(36756003)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:52:38.2885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1104e58-0585-43c3-2201-08db56eebd7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::631;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Hello everyone,

This is v2 of the precopy initial data series.
I am still wondering about the name -- maybe "explicit switchover", as
suggested by Peter, is better as it's more general?

Anyway,

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

This series adds a new migration capability called "precopy initial
data". The purpose of this capability is to reduce migration downtime in
cases where loading of migration data in the destination can take a lot
of time, such as with VFIO migration data.

The series then moves to add precopy support and precopy initial data
support for VFIO migration.

Precopy initial data is used by VFIO migration, but other migration
users can add support for it and use it as well.

=== Background ===

Migration downtime estimation is calculated based on bandwidth and
remaining migration data. This assumes that loading of migration data in
the destination takes a negligible amount of time and that downtime
depends only on network speed.

While this may be true for RAM, it's not necessarily true for other
migration users. For example, loading the data of a VFIO device in the
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

The new precopy initial data migration capability helps us achieve this.
It allows the source to send initial precopy data and the destination to
ACK that this data has been loaded. Migration will not attempt to stop
the source VM and complete the migration until this ACK is received.

Note that this relies on the return path capability to communicate from
the destination back to the source.

=== Flow of operation ===

To use precopy initial data, the capability must be enabled in both the
source and the destination.

During migration setup, migration code calls the initial_data_advise()
SaveVMHandlers handler of the migration users, both in the source and
the destination, to notify them that precopy initial data is used.
In the destination, an "initial_data_pending_num" counter is increased
for each migration user that supports this feature. It will be used
later to mark when an ACK should be sent to the source.

Migration starts to send precopy data and as part of it also the initial
precopy data. Initial precopy data is just like any other precopy data
and as such, migration code is not aware of it. Therefore, it's the
responsibility of the migration users (such as VFIO devices) to notify
their counterparts in the destination that their initial precopy data
has been sent (for example, VFIO migration does it when its initial
bytes reach zero).

In the destination, when a migration user finishes to receive and load
its initial data, it notifies the migration code about it and the
"initial_data_pending_num" counter is decreased. When this counter
reaches zero, it means that all initial data has been loaded in the
destination and an ACK is sent to the source, which will now be able to
complete migration when appropriate.

=== Test results ===

The below table shows the downtime of two identical migrations. In the
first migration precopy initial data is disabled and in the second it is
enabled. The migrated VM is assigned with a mlx5 VFIO device which has
300MB of device data to be migrated.

+----------------------+-----------------------+----------+
| Precopy initial data | VFIO device data size | Downtime |
+----------------------+-----------------------+----------+
|       Disabled       |         300MB         |  1900ms  |
|       Enabled        |         300MB         |  420ms   |
+----------------------+-----------------------+----------+

Precopy initial data gives a roughly 4.5 times improvement in downtime.
The 1480ms difference is time that is used for resource allocation for
the VFIO device in the destination. Without precopy initial data, this
time is spent when the source VM is stopped and thus the downtime is
much higher. With precopy initial data, the time is spent when the
source VM is still running.

=== Patch breakdown ===

- Patches 1-4 add the precopy initial data capability.
- Patches 5-6 add VFIO migration precopy support. Similar version of
  them was previously sent here [2].
- Patch 7 adds precopy initial data support for VFIO migration.

Thanks for reviewing!

[1]
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/vfio.h#L1048

[2]
https://lore.kernel.org/qemu-devel/20230222174915.5647-3-avihaih@nvidia.com/

[3]
https://lore.kernel.org/qemu-devel/20230501140141.11743-1-avihaih@nvidia.com/

Avihai Horon (7):
  migration: Add precopy initial data capability
  migration: Implement precopy initial data logic
  migration: Enable precopy initial data capability
  tests: Add migration precopy initial data capability test
  vfio/migration: Refactor vfio_save_block() to return saved data size
  vfio/migration: Add VFIO migration pre-copy support
  vfio/migration: Add support for precopy initial data capability

 docs/devel/vfio-migration.rst |  45 +++++--
 qapi/migration.json           |   9 +-
 include/hw/vfio/vfio-common.h |   6 +
 include/migration/register.h  |   6 +
 migration/migration.h         |  14 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   2 +
 hw/core/machine.c             |   1 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 220 +++++++++++++++++++++++++++++++---
 hw/vfio/pci.c                 |   2 +
 migration/migration.c         |  40 ++++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  65 ++++++++++
 tests/qtest/migration-test.c  |  26 ++++
 hw/vfio/trace-events          |   4 +-
 migration/trace-events        |   4 +
 17 files changed, 435 insertions(+), 33 deletions(-)

-- 
2.26.3


