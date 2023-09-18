Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 593167A4038
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6I5-00076D-SL; Mon, 18 Sep 2023 00:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6Hw-00075o-R5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:55:12 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com
 ([40.107.93.75] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6Hu-0004db-Tq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS354S5IG6IWbIvG49BoD2AQX/+LqUP7+NpE1vAoZJVu25mof6pIfshFBTNKwO5um/3vfLnBroOQdE40pbjC21apHlRV9Lfbc3IwaIcTA7mZZVDLsYr5ANuWLctbjLJ0yZ1aUYXPCyj7GNFxB2/QRv65wIue1lk3vcEyxWynyjCvBlskubBPlpWPIC/bLEVGanUZ+tzqiGKxjJEHsMt/zjG0Ho9DwTsKwacfmnFDpQbmdt1ExhxNmteYxjLZsy4HmQM0i9w2sszchqq98AwFiX+HURIWE1WvZd6IE94ednpqJrV5bXCHHf5hmorwr5yZLkTlhYHZNaz8SSsa5ac1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YDYZQT7OpYs1vSYzvuaW0SukIHtMZmhmYYrL/tx6Bc=;
 b=OySBB/Hx7HSWcGHSHsneY6DAC6N/yFtHrWArwDEvrMILdAPP0pATYHFWd43P8tv7UOaY03GHrJpbu3m6TZZBoEjPxHG2t0sDCoprL0LS0w0H6cx+LpGIbwmZc25lqspJmyI8iJU8W8nFxk5qdPm/NxFoqakQe7XcayH6+ih+i6SI8s19qqM02cmzcyO0jGxTYVz5NBeH1I0+JqzubnQtbGk0qgguBB6CU40aCsPnIppirNidrp/Hj/fr/sPpj3Ma4EJrV1cmkSQym+uxoxg3ef6bHoSuOTlMwz40fk6yt98ZvuCA9jfWawbS267FBb7rSaFblggglAgn6LpaHTmg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YDYZQT7OpYs1vSYzvuaW0SukIHtMZmhmYYrL/tx6Bc=;
 b=swVZVrAtUFebpv+s1RVgOHwHPVB707zQLUo7Kabd0wKQUyeSqndS17bCy9g8J8lP2tlMMiozCRUWki2hKXqiGzy7W3jREwyWWbyxw1lBhHw8KJyw5JyeMFOTRFeLNALdI3+QZNOq+eLW2dslcWMn8fG3J4z1sE8mB6d/pPLolzSvDrXEaDEMlw9xBINk3KHMhegNQxodAsOk/wLkNxYbQWya8iuMmXVYG/bVBdDQhYs/qu7IyJtAZ9FSQPRSVjegSatOP5FH+lIomMYAbKz1P3tqps/adwUGbPeP/pkgtKo8zU3bMJELDR/zT5EhNHUyvb9Ct5IhIGtKr/LU8GDlxg==
Received: from CY5PR22CA0029.namprd22.prod.outlook.com (2603:10b6:930:16::22)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 04:50:04 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::a8) by CY5PR22CA0029.outlook.office365.com
 (2603:10b6:930:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:58 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:56 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [RFC PATCH 3/5] vhost-net: Add support for presetup
Date: Mon, 18 Sep 2023 12:49:30 +0800
Message-ID: <20230918044932.1433744-4-yajunw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: ef03b8d4-a250-4811-27e2-08dbb802b941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPTtZbSX6kN2kdtLFWr522hctzs2vFjIRrmuGgbmi4J45hL2dK3SZcvj05R2A0+kcm4X4pBl70RYBS/cy4yIY412geUm9R48UKWbEEYjxnmhPPtWagF6GOFbob4sOTC6tJ4O9+DPzEoAGZOuAfiVN6tRhLh3kiGNJ+DWIiLl63h7JIINFCUNawnrypE1kD03GtoFmwf4egf3ntLfPIa9DPkp2UKasdQjrG1DbsXgDPm4H7RCd5XSTQtIiOYzM7YanS01JQn8oywHJNdKRthVsgW2zdFXsccaU/w/TSf0sUn9MIreiaDoDCeWwiyRD5EwKoglFno8nzS1drWAB/Pa1rVvUXE06hGDfXVHjBo9wjVNb5d3hrzusZWS4h5+4yI1/XG1IhfY9tvnTn5SWf5oEGOI4SJbr8fWMqfniCsuMhFG5CoXhU8A8CgwBhz2c5LFkxLCxab4RoqoUw/v967uhl+IcYcAFJgPqtYS1mCYcMjZLDyyQ+j2XevLqnTevqI3Yvwu/dELj/VbD9BpGCdUXEIsy+QCHzlQmTIVC6hWTX4HtEl4lVin49cWafYq7bz+4MuUTFzApLqSvB13FsorMPzpluNGjiFHciqWMG7qRgMSpbxyI9gZpTGnE0JPkOv4ElkYzG47FP0AZU5jeh4lLiTcE5itJKT+C+RdMHVqEpjlsmMeJqnDWoDb/QjQGyTYl9Ks8R2QfLLxp/KaR2ZFbnhA/7aPVkdm8ye0fjdd7WD34cr5ttOaZSs9SY8d3OWV
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(316002)(7049001)(8936002)(4326008)(8676002)(41300700001)(55016003)(107886003)(1076003)(26005)(16526019)(426003)(2616005)(6286002)(83380400001)(336012)(478600001)(7696005)(36756003)(6666004)(356005)(82740400003)(7636003)(86362001)(36860700001)(47076005)(110136005)(70586007)(70206006)(40460700003)(54906003)(2906002)(40480700001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:03.9463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef03b8d4-a250-4811-27e2-08dbb802b941
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
Received-SPF: softfail client-ip=40.107.93.75; envelope-from=yajunw@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce New API vhost_net_presetup to send virtio net device
configuration to backend in LM setup.

Mainly calling vhost_dev_presetup, then sending out vring enable.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 hw/net/vhost_net.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 include/net/vhost_net.h |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6363..dcb818ccf1 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -345,6 +345,46 @@ static void vhost_net_stop_one(struct vhost_net *net,
     vhost_dev_disable_notifiers(&net->dev, dev);
 }
 
+int vhost_net_presetup(VirtIODevice *dev, NetClientState *ncs,
+                    int data_queue_pairs, int cvq)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    int nvhosts = data_queue_pairs + cvq;
+    struct vhost_net *net;
+    int r = 0, i, index_end = data_queue_pairs * 2;
+    NetClientState *peer;
+
+    if (cvq) {
+        index_end += 1;
+    }
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else { /* Control Virtqueue */
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        vhost_net_set_vq_index(net, i * 2, index_end);
+
+        r = vhost_dev_presetup(&net->dev, dev);
+        if (r < 0) {
+            return r;
+        }
+
+        if (peer->vring_enable) {
+            /* restore vring enable state */
+            r = vhost_set_vring_enable(peer, peer->vring_enable);
+            if (r < 0) {
+                return r;
+            }
+        }
+    }
+
+    return r;
+}
+
 int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
                     int data_queue_pairs, int cvq)
 {
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c37aba35e6..2c9020c5a2 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -26,6 +26,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
                     int data_queue_pairs, int cvq);
 
+int vhost_net_presetup(VirtIODevice *dev, NetClientState *ncs,
+                           int data_queue_pairs, int cvq);
+
 void vhost_net_cleanup(VHostNetState *net);
 
 uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
-- 
2.27.0


