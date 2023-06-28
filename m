Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 214997409BE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:37:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPjI-0002VG-Gl; Wed, 28 Jun 2023 03:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPjG-0002Uk-Ta
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:36:42 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEPjE-0000m1-Kj
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJudYCBaRXzNPs9wZkATagzqZMeYglO5kXfLGmgT7R8WLgIQW2Kw3+SJNDw2bFVcEiBcL+NfvQT2IKuH7a30RQ3HxWtUvpViu2ITiHBGDswjxHXQEolESScFXk9MpGDuP9jnwa8165xx/Sx2xbOQQLB+vo8IZDULMOapJaJhis/CeoNocE9xgve8M9miQ3DzL/aRGEaBc8I2o0RLTmcNXHToaUBUHi6CHIvzqU6be7cAmzi4PybrcHOHW6Celkca3EJG8omnSLt4pVYeBef+FSoxL8fSYePAeLGQ12tDoZciUPk4o+IcYlW/h5qm0Wvi/S4Qscb0D96GDj0S35QWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l3dk12jNpgDo61se0xp6QLWuif8Sr/HDZk/LJzt50g=;
 b=YiV1QJ+sH/7ojI+hIuQpeQYGiMkFGeIKv5WhjKlI/qB+wmx8jDXRp4h8eGBY9ccfxPZW3OWEA86jAkeET1BlP9bcRtVy8fbpBcREyyeAy4J7IsRMq7jNlBmQsxrEbQ0nIram4UZEEKEwZzGxtr65VHCv/6JWLJ3B7yrzMolYgSMYPc8dvXYphuMbvgXD0Afzk1Z9oUdLYkTYQhXhIyNuBwfhbYEvrQ4BWJHjJVqfG9NiYS31jWT6VrQBOAN7Toi5JQeXJ36Iuap3IL26p3oUO7LQHuzsCisXxxCvwSkwMLMlVruaD7XUYuE4qV5TV9MjNX7+mVxrtnUcK7DubFk34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l3dk12jNpgDo61se0xp6QLWuif8Sr/HDZk/LJzt50g=;
 b=WeDxrG1+jw66H3d5HlYpwY311muBmX5oxA9Ao6P7sEEy+wQ0HOWbfk3OSVuHZRPBVPpJPc6htpUZFBiY2jvSWdMIzIBwsia92oKJgCtEWov16cDZWip9fJSUWBqpb5ebFj57i2oTWqb6Ut4a/CneDDz6RPM2CuPfhgS0vDlKmcwA439FgAVOMjPGpYHgxNycAVqpjsIG6JTbOflJWeKc8F8zBiIteH7k+0b1YmPmV/VwchUrvGrNijju6P6gCcTWwDXwR3cSeh+hrQpPRd8JkRg6hzdLMvEfYEF17LvLoE6F9An9JNu49ixFqBKZXmgDmoA75nM3KtyoeRk+eumr9A==
Received: from BYAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:c0::18)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 07:31:31 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:c0:cafe::22) by BYAPR05CA0005.outlook.office365.com
 (2603:10b6:a03:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 07:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 07:31:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 00:31:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 00:31:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 28 Jun
 2023 00:31:13 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v2 0/2] vfio/migration: Make VFIO migration non-experimental
Date: Wed, 28 Jun 2023 10:31:10 +0300
Message-ID: <20230628073112.7958-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a0a44c-31d0-4232-3d3d-08db77a9b0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKK35BakAdIfSwpmB2aoEyvXPoKtUXuXuwpJ5LVPKKU64gLBNzpLJqgBwo0oBQLXyD75AUfYj1D+f5zSySk/PR89yVJP1nPz8Atn/4DaFrOgsJa5Fax0H+NpV9l8C1BoW8VAY7kFObDZ0VMQ8hnfO6ASKMDk3C2ZpXSlhsJq/8qXR+9F98wZvqjqK+E3SYc9dE+t0jYoUPD2NYUb5h/NBGunhfCyuI5n+SKr7lFUvcwy97ESah8IGIzWu6/0uIvt+19cAWQ5BkAQB9XEybfCSCtYUIzxIfiP0/20kgPpAIR3mGeKXdXxwZ4KyGabXqupICZKe6d/GIfIpiKnx8fyTJlGEvHGNl9q6jOFsOsaxW2aW9uuBUvZnBcUyzidWr9F8rJOVsWlQOvHhl2zrRVbwDSyfvoyMUAzBQwHyYF4JXGOOPzNB41eRVLrCorwU3DB01MejKOaozR1y6mTiF7EuFbjfg9+MsJkQqmD2fhxqUG4HaZIz1VUU+EQV4t4GDFB53S1KmmGf11B83OWft0daGQYl/WFVYZTut9A/POYy+O63dMqO93znw0Byr/2xfpyYAz1b9llMqrLGR0t+uhR7yau6OQk+pWcPk3/DgKFLmijtX2XHsPSPKSLh+z+80oBxcy+XzNWG7iKZUrvRqMZFh3xgWHckUvDIDCY0ydzwr7nhRmsYpG/BlBVLVc++pABEO9bPsd4kBEnXWn/a4AEM6cXtnk4Frzuwc8X6M2179HkIq5IPoywcjxOUmkFF50MGRtP+PsVcFPoTvHu2H2dkVqVYO+gvFq6QcwuXtQDSYGvrCh0+zHlW3Ci8YrhR4o8
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(70586007)(4326008)(6916009)(40480700001)(36756003)(316002)(70206006)(8936002)(8676002)(5660300002)(478600001)(40460700003)(54906003)(86362001)(36860700001)(41300700001)(966005)(7696005)(82310400005)(2906002)(186003)(26005)(336012)(47076005)(1076003)(426003)(2616005)(7636003)(83380400001)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 07:31:30.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a0a44c-31d0-4232-3d3d-08db77a9b0ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
Received-SPF: softfail client-ip=40.107.93.43; envelope-from=avihaih@nvidia.com;
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

Hello,

The major parts of VFIO migration are supported today in QEMU. This
includes basic VFIO migration, device dirty page tracking and precopy
support. Thus, at this point in time, it seems appropriate to make VFIO
migration non-experimental.

This short series (which is based on the precopy series [1]) does that
and also adds a few improvements:
- Patch #1 resets bytes_transferred counter properly.
- Patch #2 cleans up the VFIO migration realize flow and makes VFIO
  migration non-experimental.

Note that Zhenzhong's series [2] fixes additional bugs and further
cleans the VFIO migration realize flow.

Changes from v1 [3]:
* Dropped patch #1 as it's an optimization. (Cedric)
* Added Fixes tag to patch #2. (Cedric)
* Made VFIO device realization fail if migration is not supported and
  enable_migration is ON. (Cedric)
* Kept the error message of errno == ENOTTY case as it was in
  vfio_migration_query_flags(). (Cedric)
* Added a warn when enable_migration is ON and device dirty tracking is
  not supported. (Alex)
* Renamed trace_vfio_migration_probe() to
* trace_vfio_migration_realize().


Thanks.

[1]
https://lore.kernel.org/qemu-devel/20230621111201.29729-1-avihaih@nvidia.com/

[2]
https://lore.kernel.org/qemu-devel/20230621080204.420723-1-zhenzhong.duan@intel.com/

[3]
https://lore.kernel.org/qemu-devel/20230626082353.18535-1-avihaih@nvidia.com/

Avihai Horon (2):
  vfio/migration: Reset bytes_transferred properly
  vfio/migration: Make VFIO migration non-experimental

 include/hw/vfio/vfio-common.h |  7 +--
 migration/migration.h         |  1 +
 hw/vfio/common.c              | 16 ++++++-
 hw/vfio/migration.c           | 85 ++++++++++++++++++++++++-----------
 hw/vfio/pci.c                 |  4 +-
 migration/migration.c         |  1 +
 migration/savevm.c            |  1 +
 migration/target.c            | 17 ++++++-
 hw/vfio/trace-events          |  2 +-
 9 files changed, 97 insertions(+), 37 deletions(-)

-- 
2.26.3


