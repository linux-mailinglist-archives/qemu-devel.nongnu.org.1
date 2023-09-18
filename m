Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05B7A402A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6DL-0003RC-ON; Mon, 18 Sep 2023 00:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6DD-0003Pc-Hf
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:20 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6D8-0003d6-Uq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj4dcrVrAOarWfHbTelugtfgy7XUHCMhBdWpXAgTOIHMBNFtl/h51gUpsMfjaTZOLRsg4H/k/wByaFzqvN9N4z2U+G/iGDYyzgMcjPJ9TdpyIIjK4zWU9JrCHSyuqfDe7IUaexONoqx9V7vGys9vMTcl0FliWjZetGPFld/OrpdsnCPWBTOBhFKKxxkHh4WA+pyxxlo5S1WUSqbHJB/VIvcXgRdtzYCVmw/FCmBh5bHmpS4sRwZTFRyf0a3CVIKyJhelakmuR0Gu9sSckVGGKB1+1a9zuBpdbX8H712XHDC7Dj2j99KNVWecZ/Mr759DMEER3Nzcm10vAXZ6AyaoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSpfpC5j95uMVKOZEhNck1dD0TKKMDMXlNqXac/uXCA=;
 b=c+6eFy/RteMueDieKCOhVvLqFtsPtc6i1VbL/HM6Z8WbnRy3A+YhM9zGd0vuz6EPC4lxJLWUqJrpMy32keZKsE2JtdjDu9u8p5rkDkGu8SUv69UqRlZvvuHht1x7Y6tYktJWCX6JP6CWBBTwXEPWQ7Weq4iVxyDnf/Q0R/PU+rb/iHzOz/2Cfe5e0HeEtjOf0rAwKHoaPynkDb//+2RbEGKe2jlfc9eUGSwJD8f0364TWToqf081mbXQg9npagfRsXZ8gZngB2T48XMDbqaJm/brVK0cUHH2T7jD0skMeCLOYbFmwCoDi6QSI1v+ZHBV8tRmtty7M0In0hlOLwmkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSpfpC5j95uMVKOZEhNck1dD0TKKMDMXlNqXac/uXCA=;
 b=KTbDffWK5Qv113K/0Mm8X1QmHQI7TwRsqQIDL9pI9AtM+qLVr9TPDTXZVeL0FZkI3ARZ6EdAEujyRtUZJo5PmmtFyxyXRG+Jt7H9ocQOrYEd8wMC3iSxaP29m+JCMWVGyeJuIXMHeN9IywsVnV/5JFLYGqkEXgrAiIw6fWF8LwxUU/2fcbsNx7T5Cj2eT2p2Y1mKqTmvU1Z/ue4nZDyjfOBTNq+2YCbpdydEl8GNARKMqh8BZ31BhMTY+byXqAPq+ChaUwxH1KVkgv0dIwQSHOmCSGZq/JBL+4AaPm/Ui+8pTP0b9delB9fgDvNkbhTH9H5Hca5Bv1NMOMMdH2FWVw==
Received: from CY5P221CA0151.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::24)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:50:11 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::29) by CY5P221CA0151.outlook.office365.com
 (2603:10b6:930:6a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:50:03 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:50:01 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [RFC PATCH 5/5] virtio-net: Introduce LM early load
Date: Mon, 18 Sep 2023 12:49:32 +0800
Message-ID: <20230918044932.1433744-6-yajunw@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918044932.1433744-1-yajunw@nvidia.com>
References: <20230918044932.1433744-1-yajunw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a78591-2376-43fd-af21-08dbb802bd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RizkzscPUMcCUac5LZCCVNd5swmOHGDvhDfcoaGWsDm/cxh468R16XvlxAfJGoGz304+FC9EQSpxo/4pVbVKrBlMqNOEfXRq4T4bQPpDHUkcEB83DFHjxiuA2D/QMh8G12qEsWgTgXyhrwgs6yaY1msZ3NlABcWZY5Cnp/y20v08oRAsbSzC5k9MmegK2PPFft5n3pHxt7WIz4419EFkhe6LH2nJlhZB70aZ7xhiPZ96B7fZQRI54WSbp6H5ICfOXfrERBBQ/7PhFDzsXKon1mROkn3jl838Sqhqe74UCXx5U2DTj1essq+rymrOEzJEUe2HZK7iuS/EsCxxoh60ouuQ8YNMwPguaIusNeTz/YipyH/CANf9kcT+t3U+y9xbyAsWIZX3EeoGVBFH2KLypr3OQ5bVzK9kq58ksYIkmUoRW19IUADJE4T3XGbh8G0/yIXNk2q/omAyiGci1haHfGRadILysLeumahseer83YU7u7jDMG0RGTK3VlH0P6mrNIYK8fpKJkAbZw7lnTo/MsJAwfqAIgxmOky+w1OSeCxKvGnA6F6+CuKqi8k5JMgpUtf+JajTd1VnBNA3t4X8fUstSxDnJXQDLFDZEUaujRT27yTApyx5xiPmRjfl+L8wo0KfgTs/EV1/nN3RbjWycSODaoUIm6JnQTIc7DnF8ux8aX8bv/yPtLFWWQ3BUC7Uq4+u5R1LTAgLNBMd72ZKYH8eqPIr4orAbdBjA2SRP6D3cWWX6X/ImlqzS7uuyu4q
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(7636003)(356005)(26005)(16526019)(82740400003)(6286002)(8936002)(2616005)(1076003)(8676002)(4326008)(40460700003)(107886003)(83380400001)(36860700001)(2906002)(36756003)(47076005)(426003)(336012)(40480700001)(55016003)(5660300002)(86362001)(7696005)(478600001)(6666004)(110136005)(316002)(54906003)(70206006)(70586007)(7049001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:10.9818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a78591-2376-43fd-af21-08dbb802bd72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=yajunw@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Register a new vmstate for virtio-net with an early_setup flag to send
the device state during migration setup.

This can reduce the migration downtime of a virtio-net device with a
vhost-user backend.

This feature is disabled by default and can be enabled by setting the
"x-early-migration" device property to on.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 hw/net/trace-events            |   1 +
 hw/net/virtio-net.c            | 100 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |   1 +
 3 files changed, 102 insertions(+)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index 6b5ba669a2..ec89229044 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -399,6 +399,7 @@ virtio_net_post_load_device(void)
 virtio_net_rss_disable(void)
 virtio_net_rss_error(const char *msg, uint32_t value) "%s, value 0x%08x"
 virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x, table of %d, key of %d"
+virtio_net_load_early_setup(void) ""
 
 # tulip.c
 tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..d0b0cc2ffe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -46,6 +46,7 @@
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -3568,6 +3569,95 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static int virtio_net_load_early_setup(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    NetClientState *nc = qemu_get_queue(n->nic);
+    int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+    int cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
+        n->max_ncs - n->max_queue_pairs : 0;
+    VHostNetState *net;
+    int r;
+
+    assert(nc->peer);
+    assert(nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER);
+
+    net = get_vhost_net(nc->peer);
+    assert(net);
+    assert(net->dev.vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    trace_virtio_net_load_early_setup();
+
+    /* backend should support presetup */
+    r = vhost_dev_set_presetup_state(&net->dev, true);
+    if (r < 0) {
+        error_report("Start presetup device fail: %d", r);
+        return r;
+    }
+
+    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MTU)) {
+        r = vhost_net_set_mtu(get_vhost_net(nc->peer), n->net_conf.mtu);
+        if (r < 0) {
+            error_report("%uBytes MTU not supported by the backend",
+                         n->net_conf.mtu);
+            goto error;
+        }
+    }
+
+    r = vhost_net_presetup(vdev, n->nic->ncs, queue_pairs, cvq);
+    if (r < 0) {
+        error_report("Presetup device fail: %d", r);
+        goto error;
+    }
+
+    r = vhost_dev_set_presetup_state(&net->dev, false);
+    if (r < 0) {
+        error_report("Finish presetup device fail: %d", r);
+        return r;
+    }
+    return 0;
+
+error:
+    vhost_dev_set_presetup_state(&net->dev, false);
+    return r;
+}
+
+static bool virtio_net_early_setup_needed(void *opaque)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc = qemu_get_queue(n->nic);
+    VHostNetState *net = get_vhost_net(nc->peer);
+
+    /*
+     * Presetup aims to reduce live migration downtime by sync device
+     * status in setup stage. So only do presetup when source VM is in
+     * running state.
+     */
+    if (runstate_is_running() &&
+        nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER &&
+        net->dev.vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
+        !vhost_dev_has_iommu(&net->dev) &&
+        n->vhost_started &&
+        n->status & VIRTIO_NET_S_LINK_UP) {
+        return true;
+    }
+    return false;
+}
+
+static const VMStateDescription vmstate_virtio_net_early = {
+    .name = "virtio-net-early",
+    .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .version_id = VIRTIO_NET_VM_VERSION,
+    .fields = (VMStateField[]) {
+        VMSTATE_EARLY_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .early_setup = true,
+    .post_load = virtio_net_load_early_setup,
+    .needed = virtio_net_early_setup_needed,
+};
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -3743,6 +3833,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
         virtio_net_load_ebpf(n);
     }
+
+    if (n->early_migration) {
+        vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
+                         &vmstate_virtio_net_early, n);
+    }
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -3787,6 +3882,10 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     g_free(n->rss_data.indirections_table);
     net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
+
+    if (n->early_migration) {
+        vmstate_unregister(NULL, &vmstate_virtio_net_early, n);
+    }
 }
 
 static void virtio_net_instance_init(Object *obj)
@@ -3922,6 +4021,7 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
+    DEFINE_PROP_BOOL("x-early-migration", VirtIONet, early_migration, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index e07a723027..9e6f90b46f 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -212,6 +212,7 @@ struct VirtIONet {
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
+    bool early_migration;
     DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
-- 
2.27.0


