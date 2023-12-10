Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B580BC42
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 17:54:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCN3M-0000dW-Qv; Sun, 10 Dec 2023 11:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rCN3H-0000dL-DG
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 11:53:11 -0500
Received: from mail-dm6nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::62c]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rCN3E-0007F9-6H
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 11:53:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSZgTOx2kTLt/D2R08JtaEUIBBXGw5tnxf1flrNDQrG967DKZMvHrqX8uWfMm/gVg7MkyGoKZazmAQd+k3s3383TGmIpsH7iLd6UVn/0X0js0qfXrpmTV7VhgixTK+lT7H3QbJJKPS0BEv6ch5bNl5Obv2IcbNWEjn2dkq9Pt5N8oKxqLO6if5mJQJ89/lXaBqugjrEF3vtsDlQCcw3olq0lm3EwoT95aizjD8UCj8D3BWHUyAe14P8VD8+KUNAOuFcRuVMenxa7SqsJ+Wbz74iPvWbPEKwuJk3WngdHTFpLjcav0Hp6mGuZcRevyByk1Tv+LfXyi5Sm/3lcv2oa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KinkHWjRvNuh9+XMqWW56i5NYsCfK2lRtAhMD+49lvI=;
 b=iqxhHhHBQm96R8hjgs8tgI2sjbMLMps6mX1WirQWYpHb9asBrjYKCw0LJuvSIObs5uKYDmjLSnWUCfPsLBPIWeKQZOF3ypfE39Bpxe8KFaFji1Zwnj71g00BKOmIcJgdKWorrUNeqlzOO4EpCNs6WpXVevt+rC/Bb3kWVsVrEM2i6HrHb3/YmE4IVOU1LZ8cy4eeh730lGIM5BqszotbddjhjEDvn8Q5PAmvGHqWFs4fYjcowIGLUA7q3TA+H20soBBDZDRTYMAgcAulmr0D1GvvqQ2R47Rzw/7tGM9bHCkw743d4BB4ty3rbv/gwKYWXmXu62wpIzz4+RoI++NE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KinkHWjRvNuh9+XMqWW56i5NYsCfK2lRtAhMD+49lvI=;
 b=0iyVBZXEZak0Ae0z7BbUC+uaezlNtmz8NiEpym8qj+INxyZ9iSaO2oaSMs51Pmn6DnpRP60HSMGUdFm2pPXjF49lR/Mj+Zn4VZI8Ew2fs+lTuZVUsiHWd7JUwt318rLFCbd5JZtAar61+mpxTk+38xWpZvVygw5OMrtPgiV8PRQ=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sun, 10 Dec
 2023 16:53:02 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::cc) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 16:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 16:53:01 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 10:52:57 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>, Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC QEMU PATCH v3 1/1] xen: Use gsi instead of irq for mapping pirq
Date: Mon, 11 Dec 2023 00:52:40 +0800
Message-ID: <20231210165240.1551450-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210165240.1551450-1-Jiqian.Chen@amd.com>
References: <20231210165240.1551450-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 41496d0c-bf1b-4692-f7ab-08dbf9a07894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIoztYlGbR0Cg+HblVZ4BMoPeLmf6o1H+sOw+OfvA61Gf27QB8gqe7ctw+gIMapbASS39nQHIkBD2XUoQpmIsdeTwDQdXqNuCBwhtgbOdO/+XatVCp3PEQbqj+GyYmhL66lYS08wkf5ummglBvLr/NCgsCJ0gNyUKh9CwmjEDumsKCLdrcAABp//1RO/wn1z3jGYo9s3wJmwS/7F4nzgQgOiV+CduesFqGBCvweWX40apD8uTeVyPRrx6cmkcnRcEwQ0TI1iy1OCvdtHcgf5nHZb42ErRqeHOH1NC5qDSyVypAY8BBY6E1MhMoXu26HqLpsP3rGLsRUd06WZstJHzxPqAjMejx+dySm4+51B4ZZ4NiOoYs2cU+9wHa53Jo7RIn+38TeVp3W2VCXqFxNSyZMZ2BvDZBJ4db2kVnQHZUZoRmczw0K0yqk1pnaNB/YUOsNsB25qLeXmx5k6iiMkgUXKkmzO2w5QI3F4G0E2X+3sCVrH6syW7Wq9yDO07mTeGNu90gvy7HX06si5Xv/KBAsTKsqwALAzjlT3h4BF+4eQ1JNZYpRK3c3In2wSIZ7GBpZYspN8K20PnN5LmQxzUXEKrdVfN2Wp7dyhXT9ejuw5asMyB1vFihuXczaWxEmE8vWn3uJLAG61fUL8qMJsR7G0nuEO7lzKzrE7baQA7OmuU0RMpZere8vhu18DskeqrEkcAWj+pVtpnkbNACb9tp3qLLQzAvGYGodC9+F11XFgv96/BOgY667NEGmGAtte8Gf5U+b2Xj+0VL8dl8uHOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(26005)(336012)(1076003)(16526019)(6666004)(2616005)(426003)(40460700003)(36756003)(86362001)(82740400003)(81166007)(356005)(83380400001)(5660300002)(2906002)(7696005)(36860700001)(54906003)(110136005)(4326008)(47076005)(8936002)(70206006)(70586007)(8676002)(316002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 16:53:01.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41496d0c-bf1b-4692-f7ab-08dbf9a07894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
Received-SPF: softfail client-ip=2a01:111:f400:fe59::62c;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
the irq number is alloced from small to large, but the
applying gsi number is not, may gsi 38 comes before gsi
28, that causes the irq number is not equal with the gsi
number. And when passthrough a device, qemu wants to use
gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
the gsi number is got from file
/sys/bus/pci/devices/<sbdf>/irq in current code, so it
will fail when mapping.

Use real gsi number read from gsi sysfs.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/xen/xen-host-pci-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716..e270ac2631 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -364,7 +364,7 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     }
     d->device_id = v;
 
-    xen_host_pci_get_dec_value(d, "irq", &v, errp);
+    xen_host_pci_get_dec_value(d, "gsi", &v, errp);
     if (*errp) {
         goto error;
     }
-- 
2.34.1


