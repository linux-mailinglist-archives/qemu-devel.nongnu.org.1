Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB6824F26
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 08:25:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLeZf-0000Nc-4S; Fri, 05 Jan 2024 02:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rLeZY-0000Lc-7q
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 02:24:52 -0500
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com
 ([40.107.92.86] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rLeZT-0006Zg-RR
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 02:24:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTAuZ/j+nsgq9fmtMqNnLUXRIy8V/hZOzfv1AChxlmmzo8jFULZ0tIsqZdRtzQ0tWTUiLGmJ0Qao2Tr8tY1Yk00mVCuRyki3W/6W0LAzqa0Oqvf4zdOEHeiZAB1Vgr8zaePThIOI1HMuEhAaqvrVNvh6+Fsu6xxIOqp+6c3DiT/Lbx5fOzO/HOLgf4tibqu/gFn7Q9SVJBqRbc+vmppzA12WYyHVT9FhYyxEHsPnHFijNFHj+jTRud/wH93/4INGVJy2vwN5X/MBwmYVvhEFp1AUs4RjpXNIUZacFU7S7xosMBOmcd3SXZCcZY6FdAQ6Wx0bhUYJScuJZIK3vb7qHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYi3Wyegxmzc7EKOM+Ed9WYPUa0D9CsuJMsABf608SM=;
 b=eHQb57cVcUebcD9RgcrPksj1fhwtYaHl0ggtRTmp3ivI1FQ7AsxpHqFwqgWeGzLBTjO6dj72pLeEXe0dktr/fMcpAeG2ingPLixWEdfrU2mEs1aXgHmH9LzAj5VD2LZ3wuF3GN+ENox7U5kCcnZFxnoI75WWdT9m6ybovPq5+LLwlCop+euR7V/yKUy6SVLy9RwJjvWt2yadym6Lnb5Taa63QDL8UvcDV/G1GShxuDbIbBgxDzew2f/LERvlUPAHzNFNN+cL9s5TBVjUdah7eDGxUFbl5HZeVReRku5sVG1i/yr2xRDAnrhhIV9aFfwzPVyyANeSBk1B9HMzaJseXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYi3Wyegxmzc7EKOM+Ed9WYPUa0D9CsuJMsABf608SM=;
 b=nKVzNrI91PjbWfEFjtKKOXlHP9AxxQ1sfsiEgCJuGkpTb9B7v5m+8AGu9AQwBINCZc5EXgGZi6TFGvLEcw6/xA5TB5mOhRRXPnAPWWrPdM0tDvxe/mjohgGBISSMRE2rbxoOyEAC5/2cQcOt3cDfUm9PwWE2bsqq2O8znn13CWo=
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 07:19:42 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::53) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Fri, 5 Jan 2024 07:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 07:19:41 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 01:19:38 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC QEMU PATCH v4 1/1] xen: Use gsi instead of irq for mapping pirq
Date: Fri, 5 Jan 2024 15:19:19 +0800
Message-ID: <20240105071919.350397-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105071919.350397-1-Jiqian.Chen@amd.com>
References: <20240105071919.350397-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a048163-0ff8-4cad-2bb6-08dc0dbeaf80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ11ChwosA938dS1k/ZPrzlGzTmF233umkMGTawenNS+fSeLg2QCaW24R29sRr1IHldgXrJOMirYKWhPGoPJo+ZIg8AKQIfhgqW1iRAuQjL0pomfP83BBVxEX6u0TW9Q6qOnzNwW3jkLoyjX3SwoRbfudBMJzFgpEqE/Zi79XsaYd2u6igL3ot8ZWcmtiVrTUPwrf1qrHbmRkMmElljKKNoAnmX4aDMO9XCGeoPvRd7BWtwR9qMdpNcAxyMJcW/mTUKW1SsWuwfd3HMrGjkaRko7SGWSkLZyayiBAKZs2e3UeuCBh6aQnvGECc7yXJgua/Va14hzGDHnC3eILaX8t86Lr/wT8H2m+TKn2Lw4OcoBiUZdgukrcCM58y5V/2xvFVAO59/Dc4iH2/Hje2UUVrWX6p3uBq3TdjgaYem+N4O7lKrOCNKRwa8stbg0A8OGfMxMSAiR3WWAYpqhN43bjB6nLmzAcKHNY1D0duEEHtytYzjoyxM22SGU0Wk0JU36GJuIAku8YjUPsf7XDnQP9/wcMVnC3ypg19r46iCrz4DYAOZPz6CLFKMylrZ2ZoDcQ5P+erIaDpYhPLb4U54xORkORdfdwBZAEw66nCX/UnXrVR/GEGFtRYArTgniLqnz2S3M+4CjOn+haJj3ewWz+XZtvQLUDSZUEtLI5Fv42y20XLDH933Qqxw362MYaHajWz1rCBzYo+kjIR9onPzFD9JGhgn1MasZXDlgi/p+oSrpyLdaoHw06Ky+2u4zg5OhzaIvghTpSY8Yd4H9Xc6aLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(2616005)(426003)(26005)(1076003)(336012)(7696005)(6666004)(478600001)(82740400003)(86362001)(36756003)(81166007)(356005)(2906002)(41300700001)(36860700001)(47076005)(16526019)(83380400001)(6916009)(70586007)(54906003)(316002)(70206006)(5660300002)(4326008)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 07:19:41.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a048163-0ff8-4cad-2bb6-08dc0dbeaf80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
Received-SPF: softfail client-ip=40.107.92.86;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Add gsi into XenHostPCIDevice and use gsi number that
read from gsi sysfs if it exists.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/xen/xen-host-pci-device.c | 7 +++++++
 hw/xen/xen-host-pci-device.h | 1 +
 hw/xen/xen_pt.c              | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716a2..5be3279aa25b 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -370,6 +370,13 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     }
     d->irq = v;
 
+    xen_host_pci_get_dec_value(d, "gsi", &v, errp);
+    if (*errp) {
+        d->gsi = -1;
+    } else {
+        d->gsi = v;
+    }
+
     xen_host_pci_get_hex_value(d, "class", &v, errp);
     if (*errp) {
         goto error;
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb024..74c552bb5548 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -27,6 +27,7 @@ typedef struct XenHostPCIDevice {
     uint16_t device_id;
     uint32_t class_code;
     int irq;
+    int gsi;
 
     XenHostPCIIORegion io_regions[PCI_NUM_REGIONS - 1];
     XenHostPCIIORegion rom;
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 36e6f93c372f..d448f3a17306 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -839,7 +839,11 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         goto out;
     }
 
-    machine_irq = s->real_device.irq;
+    if (s->real_device.gsi < 0) {
+        machine_irq = s->real_device.irq;
+    } else {
+        machine_irq = s->real_device.gsi;
+    }
     if (machine_irq == 0) {
         XEN_PT_LOG(d, "machine irq is 0\n");
         cmd |= PCI_COMMAND_INTX_DISABLE;
-- 
2.34.1


