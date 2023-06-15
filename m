Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33777731A6C
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 15:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9nM9-00045N-1C; Thu, 15 Jun 2023 09:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1q9nM6-00044s-Fu
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:49:42 -0400
Received: from mail-dm6nam12on20706.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::706]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1q9nM4-0007yv-7G
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiOFn/NevI7mxADGTjIXvfcX5ScqM2p3yp4IJZvwGGKtlWDnuSehQYi+bxoe0JBpObiK0kIS+N05gVZ8Cbgc3tRmVu+feX9L+HiMkv6zLFCeYNZBh7NUpFSSuFboUVQCsEEQb0FWSRKFCSCLLd+5PrwYx5TkCF/AQ6WNXqErXNLMQCoOWijVk4RNoeaDBAW+pl3J14vR2WY448NJhaNEFOHcuxxKXHrX5sDvbCb6AyislPz+riCfD2SwKXhxG6xgtF4xakO1s87vjzIP22u2gZFuMFtrXoE843EGqezNxCsXAYwllnKP0LCNE/qvJ/ozhuHg8BusF/pVPdVd3UALeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDsYxdeQqbopLft/fOp2kNeAhWx0vp5YrDS0UHTkjx0=;
 b=F1C0eg+RVTOHWqCyxj9P5to+sset2GLgcK0SaX/Q36yb2rQf0ZAdkIq4jKDD3WBtVN+zKxkHO9jf336HiAsywNSAKorDHuVTayr6dG7hf4DzVfy2OCr1Fc/nUA5WhtOARSkcIl5JYQfDCcTBh7LbZfXU8Vxlx5GeJyykY+XvsKGGGJIIzrIitXBnUNikTyXnsEbkdo6sVuiIiXzPOVn5wIyjmz0MXjk7XK7/ExHL1z3R1AfvN/tcmDxLxmzbpP2X8Y4UTwvlK1sghW/rSoGtCDocVeHbGP7TvrEY88hs6OZ4TVGpFjCZM9wkQWbe7U7S0qMV9L6ULhpjcbTuTwjiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oarcorp.com; dmarc=pass action=none header.from=oarcorp.com;
 dkim=pass header.d=oarcorp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oarcorp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDsYxdeQqbopLft/fOp2kNeAhWx0vp5YrDS0UHTkjx0=;
 b=MptpyFBfdKMqZMQ3ejAFOFy4QjTSOc9IM8lVAuC2dyHX4pje6PfkEFPadkAO3WPCtVICdV999L5Ep/S+0t/+f0+HsTPuplPORUwPWiQfuDb3eZekaXnnkpB2deuadQZuvJHncl965QFMIZ6av/dV04itbXcaLM1xSIBvypabH5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oarcorp.com;
Received: from BN6PR19MB3314.namprd19.prod.outlook.com (2603:10b6:405:76::12)
 by CH2PR19MB4055.namprd19.prod.outlook.com (2603:10b6:610:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.28; Thu, 15 Jun
 2023 13:49:02 +0000
Received: from BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e]) by BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 13:49:02 +0000
From: Kinsey Moore <kinsey.moore@oarcorp.com>
To: qemu-devel@nongnu.org
Cc: Kinsey Moore <kinsey.moore@oarcorp.com>
Subject: [PATCH] hw/arm/xlnx: Connect secondary CGEM IRQs
Date: Thu, 15 Jun 2023 08:48:47 -0500
Message-Id: <20230615134847.4157666-2-kinsey.moore@oarcorp.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230615134847.4157666-1-kinsey.moore@oarcorp.com>
References: <20230615134847.4157666-1-kinsey.moore@oarcorp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0639.namprd03.prod.outlook.com
 (2603:10b6:408:13b::14) To BN6PR19MB3314.namprd19.prod.outlook.com
 (2603:10b6:405:76::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3314:EE_|CH2PR19MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d991467-3d31-49a7-a191-08db6da7471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkQwmbDKFs9yfelNR6Bhbcc+L2GLjdJTTHzXCvnTIOzrl771UNNfRS+e9/IhFI+/u9cKkI19IFyCzX6nvNpdfBw2JJumFh1Zu58Qk4WuodVqcAhnwWuqKc2WTLQE1BhrinYPb27hb4usNNG/dLFPT/V4vRxTgELKp2smt1PQjxuVJR/B/aZyviUB4Tbz+F+GIhTuhr4NhTc7mGE97FPcroRA4arCsucuA+ND6YI+oFKh0Ewr/zsi9MOW3iq0328J1BTMciQeGxxOBkb6HAu+NximPbJWYFJOS23oZhIH7WCo7nEqJ1/RDCd9/J4tcMLAo6mSmxSiCbGKiFLVwYUsch7RTkVdcp/xJ33baKrYsOyJfJmY0+6SPCSqJIbWA0h0Co+Pe6JMX1Ou2d5Iby70JnOklBBNwo3t0DfPDgTJQEGPpbPY5e0gzG11UfQ3+9u+ZbG3jIUXFBBwpbqdk/F9kj74IcMoG7lDKrqPwQCqfTZKcwVblhd2HNgPYc6q9HByNWWD6qaZE8UOt+QkwMb/jqUqW63aFV7HzarQKDMsGWBac9tC8E31BzzQbYMHovGMBl6fs1wlr/XHG03tbLyx+jhQ7vj8JZRhbYPZfw7fY2gY4JMm0UaejT9SqPwiIWxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR19MB3314.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(376002)(39830400003)(366004)(42606007)(451199021)(38350700002)(38100700002)(107886003)(52116002)(6506007)(1076003)(26005)(6512007)(8676002)(2906002)(44832011)(8936002)(86362001)(5660300002)(186003)(2616005)(6486002)(6666004)(36756003)(4326008)(66476007)(6916009)(66556008)(478600001)(316002)(41300700001)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwmGyu2ukjC2IeV71jy9HhjDB3ZD1eaMlB+qIu5/YVw1stJAdLmh4YYqQxAn?=
 =?us-ascii?Q?Lxl5t2/NwugQ677OnV94oJH/biMn8vDCUhgYDHKeKZ5n0uYucK4dwierGAoo?=
 =?us-ascii?Q?8MrH8h9grcvKuukN7JFCy23Qn0pGazUXhaF0ypiWHsMwYVRvkJwBzQZvgTTc?=
 =?us-ascii?Q?kOv/KURdd9gxj0d+t39KB1L4ORQsoDH7sduLOZmK09Cp5A137trUIdL3rCMh?=
 =?us-ascii?Q?eNYaEnzyyeeFvfs9Bsh/Yu8tVZv02WhLBGHwEDONR0vks3wezJu2ViIsHhBS?=
 =?us-ascii?Q?C89WqwOqOqJPGrjl3Dm1qqM7JgdTmmVnS+iw/kG6f8YbdF36JLw0E6NWOlst?=
 =?us-ascii?Q?Lgd5lV1ZPmy7daC+LSTDPVnmLf0ZFToFWqF80Rypa0G8voM42ItX4qWrscte?=
 =?us-ascii?Q?SU4GgBuq4GwXveZUNHw6ljhH6EXfD3TA3keANzEEfAQLaZm2eH3iDDlilN8F?=
 =?us-ascii?Q?bb2XWFnnwKXHJzZAL6+f54l4Ob84n8lXuhVPOlYIjL3z1nnFmlCA7hSisMQv?=
 =?us-ascii?Q?0Oi0jJYS6p7tcPJ+4AnCRBwL/fMJQvFROz2BjD88CDT8LglH89ZTqsnD1QEC?=
 =?us-ascii?Q?m3qGMuCD6kB4QY8uOP3ZE2sWj9RwvMZyByicT7mPLcYFwmxFQJugGN1g38cK?=
 =?us-ascii?Q?VLQfPaYKtiuCR/3dhp2kT5grZ8TzlOFq6OgCRBTkXGRKkztbDaghLw2o9rgG?=
 =?us-ascii?Q?YcYbcwqNkoCcfSuTYbYnxVpMvRTHJKAphJXISj8IT1fhaJRdDgN7/xsaXmNO?=
 =?us-ascii?Q?9SlVCCTrSMGzL8u0hUnEMuAwCM5J0uhoZw6tkxzpDBPGgUE886huPhlGuiO/?=
 =?us-ascii?Q?0HR33Q38Gvw+XJBPHaXNFtPAATO0o1zatNSoWKQm34dxc20pmHwg+qyYIO4p?=
 =?us-ascii?Q?1qnAXqHkC4+Wzq4v+s2F0g3Rznd4q0CzBJQWpyQmlj5z0MrjZH4yx22rpghh?=
 =?us-ascii?Q?ivhDzgBlb5W9e5LMdwII0mKWTWPFnp6pfANBbOqvbks1vQK988ZrH9udcFJH?=
 =?us-ascii?Q?k3OB3JIbV3dQqwA9J2uUp3k1DaXD1CkppdbSb5/Atan0kA0FGH3mqLYMeNgQ?=
 =?us-ascii?Q?K8qlRWjhHbATisAWsNLAg6y+AxA4x2NxJ+aGAHD6jonRkwovWTrBc2Cyhagc?=
 =?us-ascii?Q?IMR8CzdBnlOZcVYcTmiP6VkMPG79ThygmU0YltRoy2WNV0EDXF5zdYMaGJM3?=
 =?us-ascii?Q?TmDscoshUb5kQ4+MrY1Y5MT4cXm7whFa0YxwsZfn3oc1owuFtzm+tyNninqJ?=
 =?us-ascii?Q?Jh2gu30IQIgVV6L8RF9oZ6KzE5r42vsB3rQ0eO1T6dojVjXQd44io75aR9Zk?=
 =?us-ascii?Q?AHFd/fEPtq+ZwzH889K32p6YAn4OifLvjqEcNHkt1uSXTTeHOtGd5VsdTzlL?=
 =?us-ascii?Q?12QconOpFgfBeVcGc+e/n10LssVX8ywmIBXSrS9ptkpOa8/Ae9LtJPJ/kxMf?=
 =?us-ascii?Q?ux+ZgCtdgB173BP/h842uRbBPyX/j4K4Z4uheZ9rYHdBdlfNJrsrBpadvf3I?=
 =?us-ascii?Q?vwL3Ck1eLRhldEDyjMipaE4IyR2bvxnCQAankRgLr7i/PflFkmrSNqU4QHc3?=
 =?us-ascii?Q?Z/BtRto7mMdfkAHUq3txeNwUyapcJpnye9tPBje7?=
X-OriginatorOrg: oarcorp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d991467-3d31-49a7-a191-08db6da7471f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3314.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 13:49:02.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7bdf32a6-03de-4c70-a71b-8665ba1294e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9mcL0bRy2EuX/qoj/ZgMtnUAXAOAmV1zA0njDP5dV69zh29OPeQv5+jwB8+9xVtZDTcTAD7ivOXcuoPzsw3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4055
Received-SPF: pass client-ip=2a01:111:f400:fe59::706;
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
 hw/arm/xlnx-versal.c | 1 +
 hw/arm/xlnx-zynqmp.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 60bf5fe657..a9e06b7fd1 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -272,6 +272,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[irqs[i]]);
         g_free(name);
     }
 }
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 5905a33015..b919b38e91 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -635,6 +635,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
                            gic_spi[gem_intr[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
+                           gic_spi[gem_intr[i]]);
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-- 
2.30.2


