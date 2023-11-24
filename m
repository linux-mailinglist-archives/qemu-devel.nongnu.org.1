Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785B7F7668
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:37:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XHb-0007v9-U8; Fri, 24 Nov 2023 09:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHU-0007uF-4s; Fri, 24 Nov 2023 09:35:44 -0500
Received: from mail-mw2nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::615]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1r6XHS-00071C-5a; Fri, 24 Nov 2023 09:35:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzTjFQQ0OoEgtMbRIoW4SEJaVK+sh9DGzZ5E9XstXVYk7EIgYsQHMXuKTjEmFH5vLxoCqZn/fe0nCA9Vz8ScTwCIJUUjO6mX3pq4hoC6R3wWjr5pqKhqD+qVPXMr1iar34otCm25cdWFfNI2bcd2vMhZqB4wvHP4IC78gSX2Gb2+RfCNdLWjUWbaulD+4hD9hBfPoJz/EMtwemWMOzp/2999tYugU183y8bOcqVpDLE8Uzv+rZ0uDfbrdTVHYQybuNfnrdkNreOODg4nBUNocQgxagJUwf9AdoGn54PNFfAafC5erGHIwQueDyGYCVhlobIQ9aE600FK4QpfNbAywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDojrg7fMzIGXpt9VTQdu1Ag5EoGwKCyUwEKmToMJGs=;
 b=TdNVQvKX678cggI7s04C5qPDebQ/IUhg8QiEB8SxO0eKLjTY9A397wUiol9IqEPLt4BgvdKvQNkcuScjrWNxj/IXmTYnArPbQkSsmJd2SVSqG2ZRAdOLiTwZ6u9BM7kRqHqqEATOjJO0zSP4LnXZcytq5LWRVdbAJVWfWGuhAHmxY1h63TsHtvux0NGru6ic/vU5IGpTWPVzaV3ApvTcXw/MYeXER7hM3KVpWAkmLwmHXX1d+uLM8wrQILzGqHD3fWityeipcrBjsX0cm/fd1zdQS4Zla3F2to8CbNpWZ8sbinlIUgRwJjLlsbpKr9Y3iP/qGOMIdvulsmYBpmGdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDojrg7fMzIGXpt9VTQdu1Ag5EoGwKCyUwEKmToMJGs=;
 b=aedSujlZZJdbZDSo5u8PFhFoXynaUgW8V2TE1Ros1Nulcf+4blxKXzThEruNb3rh4+rM8FkAGqrEKxcggNDsmg4yg60G83NT0yf22YujoLsyxj9ykAOyArT7jjdHJOJXtCL9ye+fEDH5BcXpVfvtY7ueLRejxaO5+blUUt3rvj4=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Fri, 24 Nov
 2023 14:35:37 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::15) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Fri, 24 Nov 2023 14:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 14:35:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 08:35:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 24 Nov
 2023 06:35:36 -0800
Received: from xdcsswbld02.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 24 Nov 2023 08:35:35 -0600
From: Frederic Konrad <fkonrad@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <francisco.iglesias@amd.com>,
 <peter.maydell@linaro.org>, <edgar.iglesias@gmail.com>,
 <alistair@alistair23.me>, <luc.michel@amd.com>, <fkonrad@amd.com>
Subject: [PATCH v1 3/3] hw/dma/xlnx_csu_dma: don't throw guest errors when
 stopping the SRC DMA
Date: Fri, 24 Nov 2023 14:35:05 +0000
Message-ID: <20231124143505.1493184-4-fkonrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124143505.1493184-1-fkonrad@amd.com>
References: <20231124143505.1493184-1-fkonrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0976beca-6f93-4bbb-94ab-08dbecfaa024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0Ow/m4JEUMSL/PJnyzjuZPDxb2t0GX82Vi9U9cEtvcQE3wzEdy9yqjZ+ECtZBK1IYEXlxv41sENPbS47i+KOWiFmdUsIKtlRD1JYMCksM7elFl0ihuArkcnr1s7nVqsn4ENthI/UBPc7lWvCYL1YFKRjAQkfKMneRRWFQd49aAOb9EU2gNNudboY26hT15/2JnqzFumemeDOl8jl7rEkMDsf6kqCLUsB9tEMwTthti5j8Ars3Lu9qKqOUNak33jhrbGSGnwjWUXv+nf0v3cnjrPh5ACTr57X9JHLpSuLor+Jyu8lMT9y5i7Btm3JbkvV6OrTgik7zblnV+gpoB/m1o2SK88TDF1O9xmh0yLy2SwUmrupU8Ob1xEbxSTOhroCJGLfUthLwGFKlAFcqn69cgZQQgA/DWyq6HhxoPLhIDNBZV6ilOR9xEONlCZN0jjiFSHJX5pLHpELIGt6oZW3YCa7PvcuqYDnfce3ObXrUuVODezzURFlDzTNIXTrz/Mqqqc1MHBC6qsCtk037xFvr3ZIl//vSPuigxcfpAacC95ZGSmf0Zh8dZYklK1MSAWwvriYZwYin2riDabl0H0KnQxbwiXSIGNjAgC+5LShfWjA+vmBNaOfarX+/yxhGrW9wQAZLZKcCRZo01UUb5wlDvj8uQB6Uq6Lkq3McXtNtV3l4IlL3EK2Cxlr90FCCKeBl0a0YET6JPztP5OzLSQlBXzs7lr3kijMwfKW9Nu4c5Oqt+3dl1tcd7UFdv8eP98is6V6WK1VAJ83Vfhi2z+cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(41300700001)(4326008)(8936002)(316002)(70206006)(8676002)(70586007)(6916009)(6666004)(40480700001)(966005)(478600001)(2616005)(26005)(54906003)(1076003)(426003)(83380400001)(336012)(40460700003)(36860700001)(81166007)(82740400003)(47076005)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:35:37.5006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0976beca-6f93-4bbb-94ab-08dbecfaa024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
Received-SPF: softfail client-ip=2a01:111:f400:7e89::615;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

UG1087 states for the source channel that: if SIZE is programmed to 0, and the
DMA is started, the interrupts DONE and MEM_DONE will be asserted.

This implies that it is allowed for the guest to stop the source DMA by writing
a size of 0 to the SIZE register, so remove the LOG_GUEST_ERROR in that case.

While at it remove the comment marking the SIZE register as write-only.

See: https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/CSUDMA_SRC_SIZE-CSUDMA-Register

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
---
 hw/dma/xlnx_csu_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 531013f35a..bc1505aade 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -39,7 +39,7 @@
 REG32(ADDR, 0x0)
     FIELD(ADDR, ADDR, 2, 30) /* wo */
 REG32(SIZE, 0x4)
-    FIELD(SIZE, SIZE, 2, 27) /* wo */
+    FIELD(SIZE, SIZE, 2, 27)
     FIELD(SIZE, LAST_WORD, 0, 1) /* rw, only exists in SRC */
 REG32(STATUS, 0x8)
     FIELD(STATUS, DONE_CNT, 13, 3) /* wtc */
@@ -335,10 +335,14 @@ static uint64_t addr_pre_write(RegisterInfo *reg, uint64_t val)
 static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxCSUDMA *s = XLNX_CSU_DMA(reg->opaque);
+    uint64_t size = val & R_SIZE_SIZE_MASK;
 
     if (s->regs[R_SIZE] != 0) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Starting DMA while already running.\n", __func__);
+        if (size || s->is_dst) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Starting DMA while already running.\n",
+                          __func__);
+        }
     }
 
     if (!s->is_dst) {
@@ -346,7 +350,7 @@ static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
     }
 
     /* Size is word aligned */
-    return val & R_SIZE_SIZE_MASK;
+    return size;
 }
 
 static uint64_t size_post_read(RegisterInfo *reg, uint64_t val)
-- 
2.25.1


