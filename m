Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED878B446
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:20:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae1N-0002Aw-6y; Mon, 28 Aug 2023 11:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae1A-00025f-Q4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:06 -0400
Received: from mail-bn8nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::61d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qae18-0006v5-0O
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAe/3xbB7aKCqzvIL/X5Ru60uT7DSf9hF3MGfdzMTbMHb4FNI3+PlOzBBufoDZP9MYmUqRW1C2tBf5iA99Gc8BNeQChPGMa2K98Gw9Gj5gBzuFdgaenpnSV3d3zDEPJMZ57Vq5yu79YyouMSRPPwq2ZZ88i07MuM/MiP+oVbEdvp+kFX5sIN9mzrBMQOvxsSHXZPcl+WhnmBryL/eBG9PpSEKMOlsjXH+l65y81s0xstCIGPCC++6igS7y9pPAoTsSldeX3H7wYRTCudzuFSu7+U8rSlxchmzhC+BmGwXSCh/yvtWa2tAR+gaPsYFnxi8FPNb2oJ75hMx9IOuHrE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzdAXZt7/EXDuo/P7flbnh0I0+sdXcFyMVluWknmHFc=;
 b=bpLOS7ze7hNSrtuzApV43b6I7sH99cKaeaM54BfsBrXMFZbG8VSMt7WAVQLkNDSrXt7vesZef5uAbdSclQZid48FOCSDKAoUVZ7Ag6Y1FeX5zl2wGY6GYr4Ot9Jv2q6tezHmnl2E/mYrbKWqQU1H+t5mDQcJALtCNqPd8WPyLB8/kHXVdCJifOBPoOVHqdfKYzxI3XA8lfq4PG4NuDMIFJrBE2aVk8sKjtP9NqGjdUG7ClXAUK62Rkdz8+g7tGwybH5j+hbmeGSbF8ROo9Wh4ZAXKq2eTrF5xOMIfUTV0vX65El+knu2WC4BOHbhcK44ROYvAfLE1rtw97+nzn11Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzdAXZt7/EXDuo/P7flbnh0I0+sdXcFyMVluWknmHFc=;
 b=QLiYdAVER8rVliVEmuA0DLnVeiY0B1piMheg3UyksdWgdzAJ3G8soAQ+IvpFR0vqh4Z08QoKqzF+CSVKyHnUUOLNzGROHuG/w7/GTQMb2UfPHmev1o13v0BthZkfEOUF784xO5utuz0Qdge1hsUTP2LzCym1zhnSudpkL9MCf37cQGqV5vp2zHfLKpd/ufYYF1JpQo7t50lnU6o7sLkr0dseOC7var8A5Qx0Fq32StCkj2+Ks1TNyhJ/dmfexoazG8mh1V+q8Ekn6VIRhXFPYUVnK9AkPyB4O99Kbr+H45h+e2elI/6D8mvtgYllXomcMAceHq89KqMpq5jMWkxBKg==
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 15:18:57 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::15) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 15:18:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 08:18:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 28 Aug 2023 08:18:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Mon, 28 Aug 2023 08:18:43 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 0/6] vfio/migration: Block VFIO migration with postcopy and
 background snapshot
Date: Mon, 28 Aug 2023 18:18:36 +0300
Message-ID: <20230828151842.11303-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 72388d34-5097-4081-5c94-08dba7da18e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBLf6easz0xCB/1Q1vgOaCviYKPe94xQt3n3otAUeVgtyukfNhKXM+2MlafNwo0XhURC5ywRebVExbCURCv6VJtNXeuyFtSmXtn+VCfyznbSM0gvOn+fKuKKwfMadE0yWjRlAYlTJ4Lxm+dyFyi/JArWWuJfS8Grwr7UjzZtrNdzf2E7oGY7aQ0oRsxOgOjnHeXuw1rVsJMklH79kVdbDn0qKrCLDoIbwlHFgyH+8ZSaDy1Ry3sPS4/DQTUY41u6CnQXAqBAmhOYXbgdQNiob4pnIm2SlcD8Li98HoqHH7lM9aPyydWVfrEnJ0NF1S0JClUIIZ/tM0ALo/NxEVe5Rh9Y+NNI3yi9jORwk5lV/bcvTNkaf7sW9z3iG+4eHKE1GZhMRygUNmY83ljTWLJHbDfdaLMkVmE9zF2pGFz/k6IMDHP/M+50cg0diRqR5Pmta1ptLQz3ciD+ChZoqYR4E5JMKDoxtUoAlUK070z1gKKE1HQBGYcw37ueGXeX9+uqrjbEsRINa0dbPLiVWdRXyGFn7Brhz7AKizyGyZs2qzb8ibJRgGeU45mhIvuQQmK1aawhugwPdZnuISg59cEuXSqRpWO2lt1CCfw5wJwwLmpHO7nEP3QFPZmOQ2wCQwjgbWpIFHBh+hqoehV78IDt+Dm6SavJ7X1/A+u637mzipOg7r+mTU4xMgbVLQqqfeVyGqqNzq0O/e56fF9U0LNcxRNoLTwPcNkZyUbWx3CUPdmSzS+Mp0BpjgGCgzAOHKbx3jzcTaOXwkQdrbjF+AwKmg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(316002)(6916009)(2906002)(36756003)(54906003)(70206006)(70586007)(5660300002)(40460700003)(41300700001)(7696005)(36860700001)(426003)(2616005)(336012)(26005)(107886003)(1076003)(40480700001)(82740400003)(7636003)(356005)(478600001)(966005)(47076005)(83380400001)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:18:56.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72388d34-5097-4081-5c94-08dba7da18e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::61d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

This series blocks these combinations explicitly:
If a VFIO device is added when postcopy or background snapshot are on,
a migration blocker will be added. If a VFIO device is present, setting
postcopy or background snapshot capabilities will fail with an
appropriate error message.

Note that this series is based on the P2P series [1] sent a few weeks
ago.

Comments and suggestions will be greatly appreciated.

Thanks.

[1]
https://lore.kernel.org/qemu-devel/20230802081449.2528-1-avihaih@nvidia.com/

Avihai Horon (6):
  migration: Add migration prefix to functions in target.c
  vfio/migration: Fail adding device with enable-migration=on and
    existing blocker
  vfio/migration: Add vfio_migratable_devices_num()
  vfio/migration: Change vfio_mig_active() semantics
  vfio/migration: Block VFIO migration with postcopy migration
  vfio/migration: Block VFIO migration with background snapshot

 include/hw/vfio/vfio-common.h |   4 ++
 migration/migration.h         |   7 +-
 hw/vfio/common.c              | 120 +++++++++++++++++++++++++++++-----
 hw/vfio/migration.c           |  12 ++++
 migration/migration.c         |   6 +-
 migration/options.c           |  26 ++++++++
 migration/savevm.c            |   2 +-
 migration/target.c            |  36 ++++++++--
 8 files changed, 187 insertions(+), 26 deletions(-)

-- 
2.26.3


