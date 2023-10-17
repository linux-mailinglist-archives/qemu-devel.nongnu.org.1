Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1F7CCE00
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdw-0007uN-NM; Tue, 17 Oct 2023 16:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzz-0004Ar-JN; Tue, 17 Oct 2023 15:45:06 -0400
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::617]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzw-0000wz-Q0; Tue, 17 Oct 2023 15:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh0wWF+hKMl/yxarQJ4GM1+h9MRmSN4cmla97BMQAodomCE+iisPEmQWim4UFOC/5ZjE3fZut+R5AD5Exr1BfsLazEsC0bwlXLLrjvaMeLb9qpdSnkISqvqiABRBxRZ3pZQ+pUCFcA3TiOTkMQxpBw+ok23twQ8X+onW3Cui4m4B9goe4njzlDbpCN41PjgS+n429P1i9dHSujWMad+GyqcVtLkr/nFJdTX0cYCYIVP9C2yWTCULeOztGQwpmd16poGzx7eeOHaIIchy/qjSePSMw8HsFPd090j1zJC/SURGhqZJ6a1PNPIme9aFNo8i8YC2fvM/BasI1yk9fFE23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wfS+JfxNOgzM9HgGG4biMBEsMIyqF0DzyX6UXbp1Bc=;
 b=cLTlrceG1cReIZfrzDo2uLfl8OZFsaDwbju9bMZpCqlzWGe0v30Gh2iscxwTjPXpa/HlleqxkxB8m7TneW09eGAyvKUyCYKNEzLF+JMIjgyscDGLDH9LpyiQWDfa81bgYoCFs07jSs+ImP2+kYCzKM1PyqGtHOjLezIjUdXaR7sX1518Z9QhM5BI3pu6nHepLwHmvcNHgn/mPzqHcTcSMYeMk4dEq7pBzf4Qs2R33BJUrDD3c0IrbcpsuypP6dv5rp7c4bFRd8jPciK8WhWBvVEFguOy4AuG2MJ/TbMn8xI7pcTAa+NnGO71DUjf5FrKmQz7zV+PdPv27nnrjjwNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wfS+JfxNOgzM9HgGG4biMBEsMIyqF0DzyX6UXbp1Bc=;
 b=lrgKRpQx18gUiAU/E1YfNW7mJJC7gTiW1LpRPxLcnTZ2XEwaiD4AC8Bl7Ojuw6ujSuTTCT9siVDWJzJ9+EtocjKPNlz/f0eGu4J5rB1Bla7XDpr5jVP5hTz0PqbFXc9+RlXIvQS8umF+d9c1LJPBSpsRqhcz8vrWA7E310BMRmM=
Received: from DM6PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:333::23)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 19:44:57 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::aa) by DM6PR03CA0090.outlook.office365.com
 (2603:10b6:5:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:56 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:54 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 11/11] hw/net/cadence_gem: enforce 32 bits variable size for
 CRC
Date: Tue, 17 Oct 2023 21:44:22 +0200
Message-ID: <20231017194422.4124691-12-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 94713e3a-cc18-4393-54a5-08dbcf498ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmD15DRQtgVG4QLzN9VAGAgXidHWqrySViv9u+gzF7oho9oi9BLQOX5Yvg8xHqvklEeOoIu67rwucLBqOHr4SlSRUFydMUdnKPbbjUJuNjcHwDhHDCC3s+7hDMqUn/sAgkR8xN9sv3hM+JgHdS/WMnPJtVLI+KUGNjgAXWpiOQAsJnj1MI+scolhPCXSVXytrCUfy6vPwHU6drLgcT0g64zxm8oxyTxpaDuI7896jlO5TszwcivaDSjUUlWuyUotWxIWZCoNdmmBpOflMebemUhPhGbmyvK0vunlSk+b9kezwcVd3/JMD3vGBmnxYhZF/X6m7Z3MCN5NXPOa9pCMOEeYZbYOeVN0RO6mS7OWMV9alS18xVrTZi3tEeL00NvkQhhPkv0GXjbBS7GqB0q35xjBwhURNc4pfbyXqIXOA9RfHTwMxHnuafEj+jItIh0jgAjqWe0n5J0tODEjkfW8A6UQUrmfNPPCileIZ0CP9OJ8XK+p6oM8avZ6bTf4wvUHunlNdrOU2yX93a2gJkqAv3rlvjb/zwqzs+1pmC5PMqrNUd5vsts3HP4rQTJAvw5nqIqjtw1LlTA9yXz1lDcd4Sz044cc937mf3E/zn7LTAkisbWBhz/qjthQfCTnb3Sx9edFab1p4jn5usD7aSpRDIaCWZErCG9AfRneFVsKAl9uI7J7fp0R31z32iODDiF9sMuoRWiZkS/IL5YdtYhDFiYGxu9kXOhzRfs1djS0ALdCneLHq5p1PoxuPEgjICrbF0qA65ZsKuINY+BS80j8Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(86362001)(81166007)(356005)(36756003)(478600001)(8936002)(40480700001)(8676002)(6666004)(4744005)(2906002)(44832011)(82740400003)(4326008)(1076003)(5660300002)(2616005)(40460700003)(26005)(70586007)(336012)(6916009)(70206006)(54906003)(47076005)(316002)(36860700001)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:56.9895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94713e3a-cc18-4393-54a5-08dbcf498ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

The CRC was stored in an unsigned variable in gem_receive. Change it for
a uint32_t to ensure we have the correct variable size here.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 21146f4242..d52530bae4 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1103,11 +1103,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
     /* Strip of FCS field ? (usually yes) */
     if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
         rxbuf_ptr = (void *)buf;
     } else {
-        unsigned crc_val;
+        uint32_t crc_val;
 
         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
             size = MAX_FRAME_SIZE - sizeof(crc_val);
         }
         bytes_to_copy = size;
-- 
2.39.2


