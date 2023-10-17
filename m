Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C87CCE07
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdv-0007nQ-C3; Tue, 17 Oct 2023 16:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzt-00046d-83; Tue, 17 Oct 2023 15:44:57 -0400
Received: from mail-sn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::610]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzq-0000w4-8B; Tue, 17 Oct 2023 15:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TelCdTqrMwcJI9qeTrWd/3cFSXmoddF3HoFT9NJQ1ebWuVXKhvrnWeNVYUq2vmkWNvF9khonSDLDBssk0faro4kOVcNAiK4s/bLuwz9ZducGzrIfhAnyGVix8iHDN/UXk6OcGe4xSez9e+fJpguYGt2E8S+2ARRpLWB6x0dNE6jFgDT4/PVQ4knq0y1xXqYRkA7d9JcgoJ660zyIO7PHChWewjQtpME3k74e41oojERlWiUC2pLxVXzNSFt3Jp9xpK8z4qD+mQMZhOPPRwdjgIg/JKONPTwuSZ834R+UfcyOpmPH1zrAJtrUf2kWxgR5lzVg6NO1iCmPsFkLC0m0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWwyIhq2Ae5Q8aXObkfZAp1jOHJRWPGzdtH4wWOX+eY=;
 b=PxNdNno3lAOOVxBTnNKFy4MKZV0tM4aWGEJe2y5wSqU6z4cTsosmpqWTkWnuY9DubpODZ+DFXBB5LEMisNdHW5LCgeFw3FIi4/OnIxctPhZyx2IHsjaFDkc43aV9V9dgHllUbYuUlgx2vgTe5+tMcvSJFvd1qjCjwLsGLy4tZqjEyVKLPxA5rgV3YW3BtjVdbcmBtai2MxfMAKaHghHR7FuX61FcVPmqm3bmUFLX9fWfeGr0Y/892YegvlJhVyaF7dgthrCIUINmJkhEHvAwl6S9oeWGUGdGHTGmh/WHqT/Pte1A3+wg2e4eiJHFxttJYUyRx8aBxvKjQ/RAONdI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWwyIhq2Ae5Q8aXObkfZAp1jOHJRWPGzdtH4wWOX+eY=;
 b=Z0FkC2DZROpXTGXdQit2CTIUtVinAim93Io8ABnDHMkQLw3forI9dn6IEcPvHU9bJLO6A9PkfMk8UOBJ50MXVD5vXD4pfteSRLYEt0WMn+PzZBVvCHaNz+gSzhv0JceqmtQyon7JgcIZiwtTg20uWK0Q4dhO3Aq1g3UyBFgKL/U=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:44:48 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::2e) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:47 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:46 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 08/11] hw/net/cadence_gem: use FIELD to describe DESCONF6
 register fields
Date: Tue, 17 Oct 2023 21:44:19 +0200
Message-ID: <20231017194422.4124691-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d16778-b9cf-42d2-3e3d-08dbcf49859f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhSK2JvS2ADQQ2PSdR5nxRmqh8q7CujxbDlUj8UM4Aa+UFLYfAhY2PQqQssekS6xIilhVj4YPLHHAEC4YJtciEIJjsUAc4jD58l7dqRYftLUZ4IPYoGtRTqv5ADIHJ79cwHNvJbYXUdiTrVTehaH83dXDyPe4B2LBdVmGpLwguyvZeHe5dBY2jlcMmrrYXZMqAezwmZvxL7FWPiSqTd8capKeibbc5h1bBRpeAT4o3UATzHdzVlP0KNymXhfFNHu1GpttqJXms/rSjZ/0xTt1rKeK9HoFu8T5kcDWIgKmJNNQ0H9X23yDBpKmKCdtdASP5kNlsvmFMW9D8VSixzLboB0EzJtZtQLbDUJP/5XGkWyrPxi2pEnM1sEUsMgezfZxkHyuXLq2SRn9F/toN8qmHEIGR/m2n7T+wjZ+gcKo0lqFXuVk+Rgb0Vod9m+f9haZ0MIBhiiBJ6pi328i+19F303E/REyCAvR2HQFGVpzxJ9Pd6nxlQ+nJrFsET50oonQ5pptn2i3Gd0T1dZ6/8mU6xCrpHJRuKHsuZoP5KC3QzjlQnJZXDFmRTd/E8BdAqo9sMKJfDlUmKd0AwjgWYQEFO5NE9uMPILd8+BzCQ7nbh7xCu69+r2WSQTpiuDxUpDTmbGTWRQMmrJEYq3NyP1JeXapCLmSTQMD/PoQ1p3iDzaGsI7g3/TMgbLXKHZHjbIMtzMRIxdysvL/PWivyx13OHRzkLBVOk/wk7SV7eQM12sXHUo+Vq88ESJfp1HNLMxzbSoR8fntSFOhYUuJ3ozhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(1076003)(478600001)(81166007)(2616005)(356005)(83380400001)(26005)(36860700001)(82740400003)(47076005)(6666004)(336012)(426003)(41300700001)(40460700003)(5660300002)(44832011)(4326008)(8936002)(8676002)(316002)(6916009)(54906003)(70206006)(40480700001)(70586007)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:48.3644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d16778-b9cf-42d2-3e3d-08dbcf49859f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::610;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:26:01 -0400
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

Use the FIELD macro to describe the DESCONF6 register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 6d084a3b31..955a8da134 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -281,11 +281,11 @@ REG32(DESCONF, 0x280)
 REG32(DESCONF2, 0x284)
 REG32(DESCONF3, 0x288)
 REG32(DESCONF4, 0x28c)
 REG32(DESCONF5, 0x290)
 REG32(DESCONF6, 0x294)
-#define GEM_DESCONF6_64B_MASK (1U << 23)
+    FIELD(DESCONF6, DMA_ADDR_64B, 23, 1)
 REG32(DESCONF7, 0x298)
 
 REG32(INT_Q1_STATUS, 0x400)
 REG32(INT_Q1_MASK, 0x640)
 
@@ -1461,11 +1461,11 @@ static void gem_reset(DeviceState *d)
     s->regs[R_RXPARTIALSF] = 0x000003ff;
     s->regs[R_MODID] = s->revision;
     s->regs[R_DESCONF] = 0x02D00111;
     s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[R_DESCONF5] = 0x002f2045;
-    s->regs[R_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[R_DESCONF6] = R_DESCONF6_DMA_ADDR_64B_MASK;
     s->regs[R_INT_Q1_MASK] = 0x00000CE6;
     s->regs[R_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
-- 
2.39.2


