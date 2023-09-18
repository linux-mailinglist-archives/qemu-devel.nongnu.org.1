Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37B7A402B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6DH-0003Pj-OE; Mon, 18 Sep 2023 00:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6DB-0003PH-KO
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:17 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6D7-0003c1-KC
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1lcmfbeGsBLiv4XhFVK6CJhG40DktnDOWfENM/ECkMX4scqqJPYQpXT3u7JKQ1xdh8270y6i94YGaIIbpbzExFUMabPchl6hxB6rQQwhsbjkgNpwqR+FXcUBOI4RyRgaAvsdINJykC+p3mfDikCJQdMdFSpQHA44Yoi52HvELYtPCmeGJXAKNWLLG9w6cIGcoidxORf7KBdeENS6H9N4F7hQIYAS6MjdhvVvdkUU0Ge/SqsQzj0LZe4rLROrPu5vEUu2FmfyKgVlBOG6s84B2iQ5T8WjwGU30SSmZBF5aGQG4o5QGHEKHKeCQOM9gVrLNz2akcCl5idFLSQDlOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OVsXBYUmpEMa/2Lpc37mHB7y5FSC/xhOWZp2oTii8Q=;
 b=U1Kogi4unO0LzCvRaPjiCnAG7RvV+XIdPPxe5evfWVWhoNDvHJF1uWKt42AvAxOVCmVKSm2ievO2AJKsCgXGp4WznyR02ivWz0mkGILZLiEI888SSIbmuHQwjeKvUsp6a01kurgwo1jC/LFmn0uKII/ItSIucJCoL2jGsFj+oXU8BiUYJYQTkDmPIxdL/fS0TdKUSr6ZuQZoNR6Wi637D3Na1ppFaDyWpAEfXSrI9Lai2Re5dLL8befsiAdUC+l2tNmLh7U2dpsGuv1nUDlgZssxmqANVGfa+fqGF4o/TopNUBr7A5UEuDSPV8eVJ2RcUH0cTNfTElrHJCLvv+SNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OVsXBYUmpEMa/2Lpc37mHB7y5FSC/xhOWZp2oTii8Q=;
 b=ghpNU7MBC9slV4ivZhIvpBsQq731VeSVbq2+j1EE2d3MLxtiYUt6bR0OCS2FBvG/WU3U4BGh2AA6wb/n6blFEZbUBbcPONbiL45RqzHa3174QvRFPGY6PCK4uFByfaM4PLO9zHbjWJo0Ew6J2/7yZ1ZNIUyGnJvD/hyhg+wgNm+uuwMt6SyyXboQQtEUEwXoZV7xNGGJtK685YJjz1u1xJUsuUAqJ9ix7m0uM7RtL3jQPH7Lv+G/jhCaaMMb/ZCoRulVAhsIegmrA3NYNeUp1+hZKEbQaF+W7GNBsV76GMrbJR3sNEvUZGx2KIRRJN78GwXS158ASE6k62VrSRgJCg==
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:50:04 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::bc) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:51 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:50 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
Subject: [RFC PATCH 0/5] virtio-net: Introduce LM early load
Date: Mon, 18 Sep 2023 12:49:27 +0800
Message-ID: <20230918044932.1433744-1-yajunw@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d5c736-3211-47f9-b7f2-08dbb802b94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkRXf7eL4tcfP/geu1PriiteWA9pNTDKxq26vU2R2A64UjMH2RCKLe1L4ErxLABwfI26n3+6bt0x4NrEswFxRebhg4vtAQF8E/SjNTCJNblWzkqtVkCEHr3P2BPZYLccWreD+z0JtYObDlviJpfo4y1z1yA539VzcSRi0dL7Wkx043T2w0kE0cOv4u19AHAlGwnSHRgfZGvDaOxU00Ypa2JmQQ7Qo76okG8b3f9mMv/8O0XTeHbwFyPQ6kDBVSH6l8hGx61cjDE2nNTDVrQJQ1wzLDhdK8cEhEUL9kHkRecaXyfHidQy3tM02mbUv49Kk6jlZ+kQE2V8timBybSyc0vAHvVjelU5uTra19OeX3uQboEXn769qzDqlpr01MhyEmTkASTqxVUJGti2+de+lhceb9hx/fKWMRzXIeA7NnTKEvmUku7nvRVzfunX/HBT3EWln2N4mVK3XefMWJXrtvue1HWa2Equ21opifagdw4Gx2R/gPxR+VNBcPHCQp9USRrH6WDIIc24tGCVhWlKJiJtL0acC6YYXk9YQAlQOw1r3uJetF2tAN0/DY8v67BdT1WLlojA95T/xLyewx3FR4YJXytxmIKm4Kn9hhCs50FUpmbqM8XyQiZlOufuESNWJtUYflW6vOjv5VQLkpQRgauxmddEexqRyMIkeku74RSB4Dhcb2pBcCJVX1Z0m1eLdL8AAZhWMUjy1QvQ16Naoz4na6IO92/aLkWcUVrYb2JUSVKJxak8mglFb/JMFeyrD+LihDTxXeQnIxsFZhljG5drH7ulmX9RtPSLyQWi/ys=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(7049001)(6666004)(7696005)(966005)(478600001)(83380400001)(26005)(16526019)(1076003)(2616005)(6286002)(336012)(426003)(47076005)(2906002)(70586007)(70206006)(316002)(110136005)(8676002)(5660300002)(8936002)(41300700001)(40460700003)(36756003)(36860700001)(86362001)(40480700001)(82740400003)(55016003)(356005)(7636003)(66899024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:03.9465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d5c736-3211-47f9-b7f2-08dbb802b94a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
Received-SPF: softfail client-ip=2a01:111:f400:fe59::62b;
 envelope-from=yajunw@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

This series of patches aims to minimize the downtime during live migration of a
virtio-net device with a vhost-user backend. In the case of hardware virtual
Data Path Acceleration (vDPA) implementation, the hardware configuration, which
includes tasks like VQ creation and RSS setting, may take above 200ms. This
significantly increases the downtime of the VM, particularly in terms of
networking.

To reduce the VM downtime, the proposed approach involves capturing the basic
device state/configuration during the VM's running stage and performing the
initial device configuration(presetup). During the normal configuration process
when the VM is in a stopped state, the second configuration is compared to the
first one, and only the differences are applied to reduce downtime. Ideally,
only the vring available index needs to be changed within VM stop.

This feature is disabled by default, because backend like dpdk also needs
adding support for vhost new message. New device property "x-early-migration"
can enable this feature.

1. Register a new vmstate for virtio-net with an early_setup flag to send the
   device state during migration setup.
2. After device state load on destination VM, need to send device status to
   vhost backend in a new way. Introduce new vhost-user message:
   VHOST_USER_PRESETUP, to notify backend of presetup.
3. Let virtio-net, vhost-net, vhost-dev support presetup. Main flow:
   a. vhost-dev sending presetup start.
   b. virtio-net setting mtu.
   c. vhost-dev sending vring configuration and setting dummy call/kick fd.
   d. vhost-net sending vring enable.
   e. vhost-dev sending presetup end.


TODOs:
======
  - No vhost-vdpa/kernel support. Need to discuss/design new kernel interface
    if there's same requirement for vhost-vdpa.

  - No vIOMMU support so far. If there is a need for vIOMMU support, it is
    planned to be addressed in a follow-up patchset.


Test:
=====
  - Live migration VM with 2 virtio-net devices, ping can recover.
    Together with DPDK patch [1].
  - The time consumption of DPDK function dev_conf is reduced from 191.4 ms
    to 6.6 ms.


References:
===========

[1] https://github.com/Mellanox/dpdk-vhost-vfe/pull/37

Any comments or feedback are highly appreciated.

Thanks,
Yajun


Yajun Wu (5):
  vhost-user: Add presetup protocol feature and op
  vhost: Add support for presetup
  vhost-net: Add support for presetup
  virtio: Add VMState for early load
  virtio-net: Introduce LM early load

 docs/interop/vhost-user.rst       |  10 ++
 hw/net/trace-events               |   1 +
 hw/net/vhost_net.c                |  40 +++++++
 hw/net/virtio-net.c               | 100 ++++++++++++++++++
 hw/virtio/vhost-user.c            |  30 ++++++
 hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++-----
 hw/virtio/virtio.c                | 152 ++++++++++++++++-----------
 include/hw/virtio/vhost-backend.h |   3 +
 include/hw/virtio/vhost.h         |  12 +++
 include/hw/virtio/virtio-net.h    |   1 +
 include/hw/virtio/virtio.h        |  10 +-
 include/net/vhost_net.h           |   3 +
 12 files changed, 443 insertions(+), 85 deletions(-)

-- 
2.27.0


