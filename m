Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7F7333C6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAAar-0003RD-0V; Fri, 16 Jun 2023 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1qAAao-0003Qu-9b
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:38:26 -0400
Received: from mail-dm6nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::700]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1qAAam-000121-FL
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:38:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+8IiqQloR4SrQRbtvL/zTPXhDJLnkX/owKlWTqccq1BkwvMGhjABoKTs19zPYxQPqG0qH6nHrHwpCBW+uWxh8iPDrAYecUNq8Iq8IQW7FmDMgJA8uVer7teDv8m2AnXpSoQ2lRTfqhPvsi+AuBYY9AmaEg2syT4QGEdFuu3ioXqUOJ4JhdAxZWyy0XALSAvMobKGb0CdyRafr1DBOacSEaraFi6pg/ZhtEJWwOAHpl1XPgoWNC7tdNQnXmJS+F/MHGZGr/vdWbGe1fRxZ0VVqEPlegXGEieOKNNidEKDa5qO7bFZO/0sxAoziuOQTb7GEAHd21pA11b4xytrc2Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZlB/YtmqUpIkfLIy5SFdPOS2Am+REoWkpKW2LxqMhI=;
 b=BgL2g2KXBRjpge9MRVVb3W8we+hV6frA3JOm8N9J13GwS/8+dFhh4mBKnYUYWnKMNtJvIGshkGmxiQkfsU0hDFLp1lKn04NfF4wmumwfb81Sc3NoN2t3xW6LNfrm6AkUX5avx/sYDH+IE3f7YpnUovCgiczZ3trNoDD3wm+bQnZeEaS5yQvYJ5fNbVVYqmnx7OnQzqSPwtRrKDQ6Ap492zVsCbr2VvE823eJdx+ONzEKribCuX3pvxXYRmWpY8ZngAC3zWD3+TqglMqQ5Q4PxSWLspjNUe0OVjIHzxmScis3gK/eoecotcvNKifPmfoc4K55zR1Kg/BNWMFEZlPj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oarcorp.com; dmarc=pass action=none header.from=oarcorp.com;
 dkim=pass header.d=oarcorp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oarcorp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZlB/YtmqUpIkfLIy5SFdPOS2Am+REoWkpKW2LxqMhI=;
 b=GZkPyfVMLM6Kb4sQe8RpgommVNCuUyQC6wTPHolVzXboIFiYjZIPXU5UCZohV5CxC+cu6S10Amfrs4Q5nvlrQF4xeXKKxoWSxgohJ0rHujVnWhjpNa379CWoFTNwfHXmoJ9frwuFADh5msmUlyfFd/AtazzPP13pLhnZBWJ38bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oarcorp.com;
Received: from BN6PR19MB3314.namprd19.prod.outlook.com (2603:10b6:405:76::12)
 by SA3PR19MB7475.namprd19.prod.outlook.com (2603:10b6:806:307::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.18; Fri, 16 Jun
 2023 14:38:18 +0000
Received: from BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e]) by BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e%4]) with mapi id 15.20.6521.013; Fri, 16 Jun 2023
 14:38:18 +0000
From: Kinsey Moore <kinsey.moore@oarcorp.com>
To: qemu-devel@nongnu.org
Cc: Kinsey Moore <kinsey.moore@oarcorp.com>
Subject: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Date: Fri, 16 Jun 2023 09:38:03 -0500
Message-Id: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:408:143::25) To BN6PR19MB3314.namprd19.prod.outlook.com
 (2603:10b6:405:76::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3314:EE_|SA3PR19MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d255d0a-187c-455e-1637-08db6e775369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJ6Aqh7TatOjaAqp9o/rMdx4B6m0x0wkp6WLQxQwZU2PuA2x+Z0MvGcQqaJjy/5Zy0ferV+aDCtagMs3OACl95iStdBZEFhD3mpDoUTEByjdybDc0Hopl+a2AjBe6ozMATz1Dge8zPDLWwgQaYY7XWWzo7+4BCjZbUChakQtPPDW/2veySXiTFCJvQ4ZxzcCoXfC7R6CK/7m9upgWzESQsWECjsg1nLBbuPeZOCTcQP88n2nZYdQ47+yI+GBwxtB9noRfptjOvXykrSOmNgQUI8pDfpdbixJKUnBk2M5O4gSPEPXj+yAeH2cCRq9oxiZDPJPpm3mMr5Ucl4Hn/pJRS15bh3ZXHSiP2GtSnysZXvZRQh4CT3SKp2r2OaGcT6P9mjXGhqnnaUOE/KMapl/EtFkhCJKPAbIu0xynuLlb59UvRTroJtFg4PmOW0rNieuqEwAvDBoyUg4jKADDFAVBtKezCW+Cw4oTNgKGAEbhQDtfuopNCHbBjDVTaGFSU7L+F7CUdKGCYDIBSeM/yPBNh8OzdtksvJV+1RyJtX0dn4ysPtCbRbXk3mj2yZ5sE2oMTWnjfGuGpB4co7Wud6YncV/XmKaP3XiH1MzDoEFZ9ZmxmJELuymsNuzPhX2Gvzm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR19MB3314.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(42606007)(346002)(376002)(39830400003)(396003)(451199021)(66556008)(66476007)(66946007)(8676002)(8936002)(5660300002)(36756003)(6916009)(6666004)(478600001)(4326008)(41300700001)(52116002)(6486002)(316002)(38350700002)(26005)(38100700002)(6512007)(44832011)(186003)(6506007)(1076003)(2906002)(83380400001)(2616005)(86362001)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oa5RJJUnnpOPRpyg0LIgmS6J9ryOb4x+NczYI8yR8P+mTFv35hNC3NzXBu6h?=
 =?us-ascii?Q?Iv3u+cnUJNQAF3WKifVlzqTua2r5kqvwRqBOAeCYk4NiVr18g7dm205EdcD8?=
 =?us-ascii?Q?hoXACkzFR66St0ZHu0W3kDAq73e+xdaa2ROzMMcmYZdtlszHN5DYTuy3OR2d?=
 =?us-ascii?Q?soQzbigLqGhZ7IMFlOxeSwTFKG0XxQux1u7wquuJ/h07KZW+IFxunsOt49Tp?=
 =?us-ascii?Q?1k+2AFmQFQUwd5T7ecSC5CSp4ePBSiLNtobkSGjwQVo053NiGfC2XAdRfy4u?=
 =?us-ascii?Q?hmVOcphYVMvUh+kf4UvqSP/yajieG9Y33yqCq9c4tBEy1tfptt32vW73fjrz?=
 =?us-ascii?Q?1xgYLPMRDUdgxJgyJiPKKRSB+9ft8MZqwhk7mITmGNV732HdUQGEFRIFHsqR?=
 =?us-ascii?Q?SG7PRgM9IfCkZJOabChD6EEssvnHXTSAjJpXz1A8ybwfiB3sYnfS1rGZvZQJ?=
 =?us-ascii?Q?79e6qMvdno9kBQj3n2CGCXRz7JieFU9Aua+Gmw9VKXvQIxPTcT0xWJwUJ8Ie?=
 =?us-ascii?Q?7OsQuceok6WdzBCC9+4UeX0HC3m6LLHYHye7fT1vVPJtDjhAUYXsmCUflkxE?=
 =?us-ascii?Q?1zCww35ziYpNmpqon/9le/kR/uqAqbM6eO70nBHWY7U3A+VIMT5W23KlHcBq?=
 =?us-ascii?Q?TlLZnz/AZyjbeyAu9dLQI+wUUFOtS2i6om3gUNcqCK0PQai/nyKFHd+hmz5r?=
 =?us-ascii?Q?Q+wKmCoTxikQ2s70Eji3XJKqXAm/W9U3Gxmc03YMXwRVr6tRuN558nlOSvC+?=
 =?us-ascii?Q?9M/255Ft8q0e5LbM/8Hu6/ECIfgWyZ3rjzYWhJ+SjE+bi9YYB5RSgcRJ63Oz?=
 =?us-ascii?Q?O/4VEDu9AjpBJnw7a1CcJU3BgPLoM8zmqUwHIABh0nFLKnGNd0bRr1cQ46sH?=
 =?us-ascii?Q?Vxn7OaYrBS7kZZGbS+sQbrFuRf39WwZanFHYOzIJ/6gsybgqt5hMgis0UC4u?=
 =?us-ascii?Q?Ean952iKbtniSTx9kh19E6vpn0c3qdAPF8asdZuo94MD7CqxhqTdSNZNYwFq?=
 =?us-ascii?Q?aKOTVAw0EHIKx8TK0BAEaLocKk6oKfNJ4Bi4r80ZNrEmSuphOTew3iwMhDn/?=
 =?us-ascii?Q?cijRBmLzjP0MYufLmSuIjgZCEzH9iWrbs1zcnErQqt/9yN+A/s+IiTM7Wcyu?=
 =?us-ascii?Q?bXwr70Rhb2MWFsZiWJMU3AGWX0dHbAECg9MacFfvNPVR8z3VKf4eRivrZlgo?=
 =?us-ascii?Q?eJNxcqz26eaoa22B+CM5ircVDIp1wlWodi/pDZWoo+NH/WA4P8zFd13J6vxg?=
 =?us-ascii?Q?MiIrCL90uykZSFhOJdQIV08jmiSrPuTuWreEncqKau1qZp5nXN8TGW2umJOv?=
 =?us-ascii?Q?3UwmnIMMYu30f8lgReuguolY6Dsdsckb1yU5iFOpIVvvgIULoerH5aHmL4Qk?=
 =?us-ascii?Q?UjMdzAAoiIMNQPI7ZZRHnCwxZgUCJQ8SI8vmRIOQXQKwKqskWfyoqVKvUuaj?=
 =?us-ascii?Q?KlwnaouHC3Ru0HWWeXqwng41B2QqtoYKnyHKEzICMQuVaygqKDfNwWSB07wn?=
 =?us-ascii?Q?2Jj/ES0qoWi6/r0BAFrkmHXBRfIGL6ihwIxX6NWeKafusi934EWLqHkOtYR8?=
 =?us-ascii?Q?z8T+NFKFjonG/U6HD0NJl80YyYwvtJaRQ2naV22+?=
X-OriginatorOrg: oarcorp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d255d0a-187c-455e-1637-08db6e775369
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3314.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:38:18.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7bdf32a6-03de-4c70-a71b-8665ba1294e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBMFgKMzitOtJKZw+c63OV56q6qV7lBUj34mNozcOxEpBqOE+43W6FCCV/hr6Jf+K8N7pVZU06lW5ZCniNOPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7475
Received-SPF: pass client-ip=2a01:111:f400:fe59::700;
 envelope-from=kinsey.moore@oarcorp.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
platforms have two priority queues with separate interrupt sources for
each. If the interrupt source for the second priority queue is not
connected, they work in polling mode only. This change connects the
second interrupt source for platforms where it is available. This patch
has been tested using the lwIP stack with a Xilinx-supplied driver from
their embeddedsw repository.

Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
---
 hw/arm/xlnx-versal.c         | 12 +++++++++++-
 hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
 include/hw/arm/xlnx-versal.h |  1 +
 include/hw/arm/xlnx-zynqmp.h |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 60bf5fe657..cb79b855fd 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -252,9 +252,13 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         NICInfo *nd = &nd_table[i];
         DeviceState *dev;
         MemoryRegion *mr;
+        OrIRQState *or_irq;
 
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
                                 TYPE_CADENCE_GEM);
+        or_irq = &s->lpd.iou.gem_irq_orgate[i];
+        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
+                                or_irq, TYPE_OR_IRQ);
         dev = DEVICE(&s->lpd.iou.gem[i]);
         /* FIXME use qdev NIC properties instead of nd_table[] */
         if (nd->used) {
@@ -264,6 +268,11 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
+        object_property_set_int(OBJECT(or_irq),
+                                "num-lines", 2, &error_fatal);
+        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
+        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
+
         object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                                  &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -271,7 +280,8 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
         g_free(name);
     }
 }
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 5905a33015..f7158e4fd3 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -392,6 +392,8 @@ static void xlnx_zynqmp_init(Object *obj)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
+        object_initialize_child(obj, "gem-irq-orgate[*]",
+                                &s->gem_irq_orgate[i], TYPE_OR_IRQ);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
@@ -629,12 +631,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
+        object_property_set_int(OBJECT(&s->gem_irq_orgate[i]),
+                                "num-lines", 2, &error_fatal);
+        qdev_realize(DEVICE(&s->gem_irq_orgate[i]), NULL, &error_fatal);
+        qdev_connect_gpio_out(DEVICE(&s->gem_irq_orgate[i]), 0, gic_spi[gem_intr[i]]);
+
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
-                           gic_spi[gem_intr[i]]);
+                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
+                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 1));
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39ee31185c..d34c763329 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -74,6 +74,7 @@ struct Versal {
         struct {
             PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
+            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
             CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 687c75e3b0..7e5abce467 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -117,6 +117,7 @@ struct XlnxZynqMPState {
     MemoryRegion mr_unimp[XLNX_ZYNQMP_NUM_UNIMP_AREAS];
 
     CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
+    OrIRQState gem_irq_orgate[XLNX_ZYNQMP_NUM_GEMS];
     CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
     XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
     SysbusAHCIState sata;
-- 
2.30.2


