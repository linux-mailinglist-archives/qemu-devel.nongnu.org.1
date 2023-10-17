Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E587CCDFC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdk-0007d2-8J; Tue, 17 Oct 2023 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzk-00043p-01; Tue, 17 Oct 2023 15:44:48 -0400
Received: from mail-bn8nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::602]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzf-0000uL-HA; Tue, 17 Oct 2023 15:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAK9zmFo4TFGLXKP66RrZUuANJMUjS4IG7O8Cvq3/TO9g/gq15yM+iWTtaNyQt50p7+iIz+oGilnLWZYvxrgJv5XLa6d3YQM42WhQpzefBU7kwv7/Gdz92enGkHm1UroDbRTEW37ufnSQgOtkltl9+Lk8WSZIglTukOiuOeSe18xgY3nqp4eCjWss40PfgmfJ+J2yuJELlXXM5ysoRGYyL6wMztQst61b9vkO3/RMsVx1ZRuEAYW8Lg23zxIGdpHEkMs2y+SZG/OEHuxD+pNYacoZvDHSF7wuN3BpPYuXtMF8CnQiZId6KPYbwPb5XKrbfQTcITgKbztvpmMj2DTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja1JvdoHdVCJL2/iNW/bf1H+G7BDdlHffQNB4p3FwpA=;
 b=jMGb9228HR70FW/MWdQ5Ad5nMHh2hkerKXikF6RNEtyoa7qYK3jIJcZuWe7HV9CaDrrxU+rulLCwTwBePVi7aLF4IIAwOCReuauYOTaV+I4hvCJ6jgYP5e0pewoHb78reptTnvXC0myW8HkzFRd9lz/Y5yLd1uoLeNcUv4YDV9lK3R1K5CMdppeH2XFrRfueEDQaJ0YWey78JtzOhkI3cZV0bLqFdQv1UFt/osvikBMgGSWBAvJNl1EOZt96TyFd12XWzR2cz7kcbf7T3r2JUmIUY1t2k40GLrtinFSC/0FZxIbUPz8wGT/cl4DrMK+7m2MzvKT484ko5+yWZwvbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja1JvdoHdVCJL2/iNW/bf1H+G7BDdlHffQNB4p3FwpA=;
 b=kMKlebJwp7onyJxipIgKVqHBOp1GPtj1wbRmgZAp7rqn4gYXS+Eb05otc2RcUl6DyN8Rfh8rrpsvdt9Xl4v0eH1V/xAOZbVTj7bYR+Jo1ToWONRIWWuMbMokKxdZIYRvWOzGKug4kwJJEHpEVN5SDPAxZWH44qcyGcfk+QYbxx8=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 17 Oct
 2023 19:44:35 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::18) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:44:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:33 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:32 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 01/11] hw/net/cadence_gem: use REG32 macro for register
 definitions
Date: Tue, 17 Oct 2023 21:44:12 +0200
Message-ID: <20231017194422.4124691-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d204376-f13c-4480-ec68-08dbcf497d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrNXopmDE/LYGWiJ5oKlLNfx+OcQJwTxZpeuCCQ1P/0q4kM2Y/cUOnk8+Xw+l/2e+b0MZfqI5XXjwiNvLrCi9qb9g07iiKsuhPYIdh++IAyWFowhbw/L8jINABr670KRORyQQQEFXjN7RoSggEx8vp739E/QaQmiEZrluBfedtf6rFYLMB5ZEdwXJLx/aDZoG8pNRPp/OZwoeBHxGeY6k7JlbA/YkpcJ2Kv0XvMECr4E2qDIDwtgynI574OW2X7YxSBoOaYRbt8eHY2OpYWWg2QYdAeNtHMHKOlwQtjegYJW8odF/yV7TYHtWdoWYn0De1KCsqtMU8gEzqKgyvPNUz3YC9dg9KdrXHOnf3Epk5cnqhNb6gs0zwMqGDOfWy51Q+mBJ4QXFqqcdYB/2I9yNp8A8osp440ZRVauHnF39BrStUmc4W1S8h48D5cl+4N2Kg0KsdyeEp42eGxrTBvBFGvqSPI1zOk49oq/gvQeY9ijHBtNW357QF9qdfsMfuUO9a+YQs/FvTS+kD3hwPi03OccnrgP31cuxGrQOo3gtESXNW8WcJW/3t1Mp1Mu0ocWMX7PJAb4QulDPuHmjjX1XNarKkU17f4dK1TgjgUniKKFBp/vBcSR6oMiYfagn6wtpRbC6RsRpnu4nklMyHetMJHXhIBAQZaW/TPfTM/G7JCAhUnX2UBixAECRCI2HIcS1tosJyIGyGfOn46AXOnujiD4YL6KXLnLZ2/RKStdnHZZiH1ShBrJmc+E+3W2qb56d1vbMJkgwBioo3jV0XGOQ6+fVbOGKnleEyM+AqS+rJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(1076003)(2906002)(2616005)(40480700001)(40460700003)(82740400003)(86362001)(356005)(81166007)(36756003)(47076005)(26005)(36860700001)(336012)(426003)(83380400001)(8936002)(54906003)(44832011)(8676002)(5660300002)(4326008)(316002)(478600001)(41300700001)(6916009)(70586007)(70206006)(6666004)(30864003)(36900700001)(579004)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:34.6617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d204376-f13c-4480-ec68-08dbcf497d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:26:00 -0400
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

Replace register defines with the REG32 macro from registerfields.h in
the Cadence GEM device.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 527 +++++++++++++++++++++----------------------
 1 file changed, 261 insertions(+), 266 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f445d8bb5e..0e5744ecd7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -26,10 +26,11 @@
 #include <zlib.h> /* For crc32 */
 
 #include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
@@ -42,151 +43,146 @@
         qemu_log(": %s: ", __func__); \
         qemu_log(__VA_ARGS__); \
     } \
 } while (0)
 
-#define GEM_NWCTRL        (0x00000000 / 4) /* Network Control reg */
-#define GEM_NWCFG         (0x00000004 / 4) /* Network Config reg */
-#define GEM_NWSTATUS      (0x00000008 / 4) /* Network Status reg */
-#define GEM_USERIO        (0x0000000C / 4) /* User IO reg */
-#define GEM_DMACFG        (0x00000010 / 4) /* DMA Control reg */
-#define GEM_TXSTATUS      (0x00000014 / 4) /* TX Status reg */
-#define GEM_RXQBASE       (0x00000018 / 4) /* RX Q Base address reg */
-#define GEM_TXQBASE       (0x0000001C / 4) /* TX Q Base address reg */
-#define GEM_RXSTATUS      (0x00000020 / 4) /* RX Status reg */
-#define GEM_ISR           (0x00000024 / 4) /* Interrupt Status reg */
-#define GEM_IER           (0x00000028 / 4) /* Interrupt Enable reg */
-#define GEM_IDR           (0x0000002C / 4) /* Interrupt Disable reg */
-#define GEM_IMR           (0x00000030 / 4) /* Interrupt Mask reg */
-#define GEM_PHYMNTNC      (0x00000034 / 4) /* Phy Maintenance reg */
-#define GEM_RXPAUSE       (0x00000038 / 4) /* RX Pause Time reg */
-#define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
-#define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
-#define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
-#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */
-#define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
-#define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
-#define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
-#define GEM_SPADDR1HI     (0x0000008C / 4) /* Specific addr 1 high reg */
-#define GEM_SPADDR2LO     (0x00000090 / 4) /* Specific addr 2 low reg */
-#define GEM_SPADDR2HI     (0x00000094 / 4) /* Specific addr 2 high reg */
-#define GEM_SPADDR3LO     (0x00000098 / 4) /* Specific addr 3 low reg */
-#define GEM_SPADDR3HI     (0x0000009C / 4) /* Specific addr 3 high reg */
-#define GEM_SPADDR4LO     (0x000000A0 / 4) /* Specific addr 4 low reg */
-#define GEM_SPADDR4HI     (0x000000A4 / 4) /* Specific addr 4 high reg */
-#define GEM_TIDMATCH1     (0x000000A8 / 4) /* Type ID1 Match reg */
-#define GEM_TIDMATCH2     (0x000000AC / 4) /* Type ID2 Match reg */
-#define GEM_TIDMATCH3     (0x000000B0 / 4) /* Type ID3 Match reg */
-#define GEM_TIDMATCH4     (0x000000B4 / 4) /* Type ID4 Match reg */
-#define GEM_WOLAN         (0x000000B8 / 4) /* Wake on LAN reg */
-#define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
-#define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
-#define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100 / 4) /* Octets transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104 / 4) /* Octets transmitted High reg */
-#define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
-#define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
-#define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
-#define GEM_TXPAUSECNT    (0x00000114 / 4) /* Pause Frames Transmitted */
-#define GEM_TX64CNT       (0x00000118 / 4) /* Error-free 64 TX */
-#define GEM_TX65CNT       (0x0000011C / 4) /* Error-free 65-127 TX */
-#define GEM_TX128CNT      (0x00000120 / 4) /* Error-free 128-255 TX */
-#define GEM_TX256CNT      (0x00000124 / 4) /* Error-free 256-511 */
-#define GEM_TX512CNT      (0x00000128 / 4) /* Error-free 512-1023 TX */
-#define GEM_TX1024CNT     (0x0000012C / 4) /* Error-free 1024-1518 TX */
-#define GEM_TX1519CNT     (0x00000130 / 4) /* Error-free larger than 1519 TX */
-#define GEM_TXURUNCNT     (0x00000134 / 4) /* TX under run error counter */
-#define GEM_SINGLECOLLCNT (0x00000138 / 4) /* Single Collision Frames */
-#define GEM_MULTCOLLCNT   (0x0000013C / 4) /* Multiple Collision Frames */
-#define GEM_EXCESSCOLLCNT (0x00000140 / 4) /* Excessive Collision Frames */
-#define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
-#define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
-#define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150 / 4) /* Octets Received register Low */
-#define GEM_OCTRXHI       (0x00000154 / 4) /* Octets Received register High */
-#define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
-#define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
-#define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
-#define GEM_RXPAUSECNT    (0x00000164 / 4) /* Pause Frames Received Counter */
-#define GEM_RX64CNT       (0x00000168 / 4) /* Error-free 64 byte Frames RX */
-#define GEM_RX65CNT       (0x0000016C / 4) /* Error-free 65-127B Frames RX */
-#define GEM_RX128CNT      (0x00000170 / 4) /* Error-free 128-255B Frames RX */
-#define GEM_RX256CNT      (0x00000174 / 4) /* Error-free 256-512B Frames RX */
-#define GEM_RX512CNT      (0x00000178 / 4) /* Error-free 512-1023B Frames RX */
-#define GEM_RX1024CNT     (0x0000017C / 4) /* Error-free 1024-1518B Frames RX */
-#define GEM_RX1519CNT     (0x00000180 / 4) /* Error-free 1519-max Frames RX */
-#define GEM_RXUNDERCNT    (0x00000184 / 4) /* Undersize Frames Received */
-#define GEM_RXOVERCNT     (0x00000188 / 4) /* Oversize Frames Received */
-#define GEM_RXJABCNT      (0x0000018C / 4) /* Jabbers Received Counter */
-#define GEM_RXFCSCNT      (0x00000190 / 4) /* Frame Check seq. Error Counter */
-#define GEM_RXLENERRCNT   (0x00000194 / 4) /* Length Field Error Counter */
-#define GEM_RXSYMERRCNT   (0x00000198 / 4) /* Symbol Error Counter */
-#define GEM_RXALIGNERRCNT (0x0000019C / 4) /* Alignment Error Counter */
-#define GEM_RXRSCERRCNT   (0x000001A0 / 4) /* Receive Resource Error Counter */
-#define GEM_RXORUNCNT     (0x000001A4 / 4) /* Receive Overrun Counter */
-#define GEM_RXIPCSERRCNT  (0x000001A8 / 4) /* IP header Checksum Err Counter */
-#define GEM_RXTCPCCNT     (0x000001AC / 4) /* TCP Checksum Error Counter */
-#define GEM_RXUDPCCNT     (0x000001B0 / 4) /* UDP Checksum Error Counter */
+REG32(NWCTRL, 0x0) /* Network Control reg */
+REG32(NWCFG, 0x4) /* Network Config reg */
+REG32(NWSTATUS, 0x8) /* Network Status reg */
+REG32(USERIO, 0xc) /* User IO reg */
+REG32(DMACFG, 0x10) /* DMA Control reg */
+REG32(TXSTATUS, 0x14) /* TX Status reg */
+REG32(RXQBASE, 0x18) /* RX Q Base address reg */
+REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
+REG32(RXSTATUS, 0x20) /* RX Status reg */
+REG32(ISR, 0x24) /* Interrupt Status reg */
+REG32(IER, 0x28) /* Interrupt Enable reg */
+REG32(IDR, 0x2c) /* Interrupt Disable reg */
+REG32(IMR, 0x30) /* Interrupt Mask reg */
+REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
+REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
+REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
+REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
+REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */
+REG32(JUMBO_MAX_LEN, 0x48) /* Max Jumbo Frame Size */
+REG32(HASHLO, 0x80) /* Hash Low address reg */
+REG32(HASHHI, 0x84) /* Hash High address reg */
+REG32(SPADDR1LO, 0x88) /* Specific addr 1 low reg */
+REG32(SPADDR1HI, 0x8c) /* Specific addr 1 high reg */
+REG32(SPADDR2LO, 0x90) /* Specific addr 2 low reg */
+REG32(SPADDR2HI, 0x94) /* Specific addr 2 high reg */
+REG32(SPADDR3LO, 0x98) /* Specific addr 3 low reg */
+REG32(SPADDR3HI, 0x9c) /* Specific addr 3 high reg */
+REG32(SPADDR4LO, 0xa0) /* Specific addr 4 low reg */
+REG32(SPADDR4HI, 0xa4) /* Specific addr 4 high reg */
+REG32(TIDMATCH1, 0xa8) /* Type ID1 Match reg */
+REG32(TIDMATCH2, 0xac) /* Type ID2 Match reg */
+REG32(TIDMATCH3, 0xb0) /* Type ID3 Match reg */
+REG32(TIDMATCH4, 0xb4) /* Type ID4 Match reg */
+REG32(WOLAN, 0xb8) /* Wake on LAN reg */
+REG32(IPGSTRETCH, 0xbc) /* IPG Stretch reg */
+REG32(SVLAN, 0xc0) /* Stacked VLAN reg */
+REG32(MODID, 0xfc) /* Module ID reg */
+REG32(OCTTXLO, 0x100) /* Octects transmitted Low reg */
+REG32(OCTTXHI, 0x104) /* Octects transmitted High reg */
+REG32(TXCNT, 0x108) /* Error-free Frames transmitted */
+REG32(TXBCNT, 0x10c) /* Error-free Broadcast Frames */
+REG32(TXMCNT, 0x110) /* Error-free Multicast Frame */
+REG32(TXPAUSECNT, 0x114) /* Pause Frames Transmitted */
+REG32(TX64CNT, 0x118) /* Error-free 64 TX */
+REG32(TX65CNT, 0x11c) /* Error-free 65-127 TX */
+REG32(TX128CNT, 0x120) /* Error-free 128-255 TX */
+REG32(TX256CNT, 0x124) /* Error-free 256-511 */
+REG32(TX512CNT, 0x128) /* Error-free 512-1023 TX */
+REG32(TX1024CNT, 0x12c) /* Error-free 1024-1518 TX */
+REG32(TX1519CNT, 0x130) /* Error-free larger than 1519 TX */
+REG32(TXURUNCNT, 0x134) /* TX under run error counter */
+REG32(SINGLECOLLCNT, 0x138) /* Single Collision Frames */
+REG32(MULTCOLLCNT, 0x13c) /* Multiple Collision Frames */
+REG32(EXCESSCOLLCNT, 0x140) /* Excessive Collision Frames */
+REG32(LATECOLLCNT, 0x144) /* Late Collision Frames */
+REG32(DEFERTXCNT, 0x148) /* Deferred Transmission Frames */
+REG32(CSENSECNT, 0x14c) /* Carrier Sense Error Counter */
+REG32(OCTRXLO, 0x150) /* Octects Received register Low */
+REG32(OCTRXHI, 0x154) /* Octects Received register High */
+REG32(RXCNT, 0x158) /* Error-free Frames Received */
+REG32(RXBROADCNT, 0x15c) /* Error-free Broadcast Frames RX */
+REG32(RXMULTICNT, 0x160) /* Error-free Multicast Frames RX */
+REG32(RXPAUSECNT, 0x164) /* Pause Frames Received Counter */
+REG32(RX64CNT, 0x168) /* Error-free 64 byte Frames RX */
+REG32(RX65CNT, 0x16c) /* Error-free 65-127B Frames RX */
+REG32(RX128CNT, 0x170) /* Error-free 128-255B Frames RX */
+REG32(RX256CNT, 0x174) /* Error-free 256-512B Frames RX */
+REG32(RX512CNT, 0x178) /* Error-free 512-1023B Frames RX */
+REG32(RX1024CNT, 0x17c) /* Error-free 1024-1518B Frames RX */
+REG32(RX1519CNT, 0x180) /* Error-free 1519-max Frames RX */
+REG32(RXUNDERCNT, 0x184) /* Undersize Frames Received */
+REG32(RXOVERCNT, 0x188) /* Oversize Frames Received */
+REG32(RXJABCNT, 0x18c) /* Jabbers Received Counter */
+REG32(RXFCSCNT, 0x190) /* Frame Check seq. Error Counter */
+REG32(RXLENERRCNT, 0x194) /* Length Field Error Counter */
+REG32(RXSYMERRCNT, 0x198) /* Symbol Error Counter */
+REG32(RXALIGNERRCNT, 0x19c) /* Alignment Error Counter */
+REG32(RXRSCERRCNT, 0x1a0) /* Receive Resource Error Counter */
+REG32(RXORUNCNT, 0x1a4) /* Receive Overrun Counter */
+REG32(RXIPCSERRCNT, 0x1a8) /* IP header Checksum Err Counter */
+REG32(RXTCPCCNT, 0x1ac) /* TCP Checksum Error Counter */
+REG32(RXUDPCCNT, 0x1b0) /* UDP Checksum Error Counter */
 
-#define GEM_1588S         (0x000001D0 / 4) /* 1588 Timer Seconds */
-#define GEM_1588NS        (0x000001D4 / 4) /* 1588 Timer Nanoseconds */
-#define GEM_1588ADJ       (0x000001D8 / 4) /* 1588 Timer Adjust */
-#define GEM_1588INC       (0x000001DC / 4) /* 1588 Timer Increment */
-#define GEM_PTPETXS       (0x000001E0 / 4) /* PTP Event Frame Transmitted (s) */
-#define GEM_PTPETXNS      (0x000001E4 / 4) /*
-                                            * PTP Event Frame Transmitted (ns)
-                                            */
-#define GEM_PTPERXS       (0x000001E8 / 4) /* PTP Event Frame Received (s) */
-#define GEM_PTPERXNS      (0x000001EC / 4) /* PTP Event Frame Received (ns) */
-#define GEM_PTPPTXS       (0x000001E0 / 4) /* PTP Peer Frame Transmitted (s) */
-#define GEM_PTPPTXNS      (0x000001E4 / 4) /* PTP Peer Frame Transmitted (ns) */
-#define GEM_PTPPRXS       (0x000001E8 / 4) /* PTP Peer Frame Received (s) */
-#define GEM_PTPPRXNS      (0x000001EC / 4) /* PTP Peer Frame Received (ns) */
+REG32(1588S, 0x1d0) /* 1588 Timer Seconds */
+REG32(1588NS, 0x1d4) /* 1588 Timer Nanoseconds */
+REG32(1588ADJ, 0x1d8) /* 1588 Timer Adjust */
+REG32(1588INC, 0x1dc) /* 1588 Timer Increment */
+REG32(PTPETXS, 0x1e0) /* PTP Event Frame Transmitted (s) */
+REG32(PTPETXNS, 0x1e4) /* PTP Event Frame Transmitted (ns) */
+REG32(PTPERXS, 0x1e8) /* PTP Event Frame Received (s) */
+REG32(PTPERXNS, 0x1ec) /* PTP Event Frame Received (ns) */
+REG32(PTPPTXS, 0x1e0) /* PTP Peer Frame Transmitted (s) */
+REG32(PTPPTXNS, 0x1e4) /* PTP Peer Frame Transmitted (ns) */
+REG32(PTPPRXS, 0x1e8) /* PTP Peer Frame Received (s) */
+REG32(PTPPRXNS, 0x1ec) /* PTP Peer Frame Received (ns) */
 
 /* Design Configuration Registers */
-#define GEM_DESCONF       (0x00000280 / 4)
-#define GEM_DESCONF2      (0x00000284 / 4)
-#define GEM_DESCONF3      (0x00000288 / 4)
-#define GEM_DESCONF4      (0x0000028C / 4)
-#define GEM_DESCONF5      (0x00000290 / 4)
-#define GEM_DESCONF6      (0x00000294 / 4)
+REG32(DESCONF, 0x280)
+REG32(DESCONF2, 0x284)
+REG32(DESCONF3, 0x288)
+REG32(DESCONF4, 0x28c)
+REG32(DESCONF5, 0x290)
+REG32(DESCONF6, 0x294)
 #define GEM_DESCONF6_64B_MASK (1U << 23)
-#define GEM_DESCONF7      (0x00000298 / 4)
+REG32(DESCONF7, 0x298)
 
-#define GEM_INT_Q1_STATUS               (0x00000400 / 4)
-#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
+REG32(INT_Q1_STATUS, 0x400)
+REG32(INT_Q1_MASK, 0x640)
 
-#define GEM_TRANSMIT_Q1_PTR             (0x00000440 / 4)
-#define GEM_TRANSMIT_Q7_PTR             (GEM_TRANSMIT_Q1_PTR + 6)
+REG32(TRANSMIT_Q1_PTR, 0x440)
+REG32(TRANSMIT_Q7_PTR, 0x458)
 
-#define GEM_RECEIVE_Q1_PTR              (0x00000480 / 4)
-#define GEM_RECEIVE_Q7_PTR              (GEM_RECEIVE_Q1_PTR + 6)
+REG32(RECEIVE_Q1_PTR, 0x480)
+REG32(RECEIVE_Q7_PTR, 0x498)
 
-#define GEM_TBQPH                       (0x000004C8 / 4)
-#define GEM_RBQPH                       (0x000004D4 / 4)
+REG32(TBQPH, 0x4c8)
+REG32(RBQPH, 0x4d4)
 
-#define GEM_INT_Q1_ENABLE               (0x00000600 / 4)
-#define GEM_INT_Q7_ENABLE               (GEM_INT_Q1_ENABLE + 6)
+REG32(INT_Q1_ENABLE, 0x600)
+REG32(INT_Q7_ENABLE, 0x618)
 
-#define GEM_INT_Q1_DISABLE              (0x00000620 / 4)
-#define GEM_INT_Q7_DISABLE              (GEM_INT_Q1_DISABLE + 6)
+REG32(INT_Q1_DISABLE, 0x620)
+REG32(INT_Q7_DISABLE, 0x638)
 
-#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
-#define GEM_INT_Q7_MASK                 (GEM_INT_Q1_MASK + 6)
-
-#define GEM_SCREENING_TYPE1_REGISTER_0  (0x00000500 / 4)
+REG32(SCREENING_TYPE1_REG0, 0x500)
 
 #define GEM_ST1R_UDP_PORT_MATCH_ENABLE  (1 << 29)
 #define GEM_ST1R_DSTC_ENABLE            (1 << 28)
 #define GEM_ST1R_UDP_PORT_MATCH_SHIFT   (12)
 #define GEM_ST1R_UDP_PORT_MATCH_WIDTH   (27 - GEM_ST1R_UDP_PORT_MATCH_SHIFT + 1)
 #define GEM_ST1R_DSTC_MATCH_SHIFT       (4)
 #define GEM_ST1R_DSTC_MATCH_WIDTH       (11 - GEM_ST1R_DSTC_MATCH_SHIFT + 1)
 #define GEM_ST1R_QUEUE_SHIFT            (0)
 #define GEM_ST1R_QUEUE_WIDTH            (3 - GEM_ST1R_QUEUE_SHIFT + 1)
 
-#define GEM_SCREENING_TYPE2_REGISTER_0  (0x00000540 / 4)
+REG32(SCREENING_TYPE2_REG0, 0x540)
 
 #define GEM_ST2R_COMPARE_A_ENABLE       (1 << 18)
 #define GEM_ST2R_COMPARE_A_SHIFT        (13)
 #define GEM_ST2R_COMPARE_WIDTH          (17 - GEM_ST2R_COMPARE_A_SHIFT + 1)
 #define GEM_ST2R_ETHERTYPE_ENABLE       (1 << 12)
@@ -194,12 +190,12 @@
 #define GEM_ST2R_ETHERTYPE_INDEX_WIDTH  (11 - GEM_ST2R_ETHERTYPE_INDEX_SHIFT \
                                             + 1)
 #define GEM_ST2R_QUEUE_SHIFT            (0)
 #define GEM_ST2R_QUEUE_WIDTH            (3 - GEM_ST2R_QUEUE_SHIFT + 1)
 
-#define GEM_SCREENING_TYPE2_ETHERTYPE_REG_0     (0x000006e0 / 4)
-#define GEM_TYPE2_COMPARE_0_WORD_0              (0x00000700 / 4)
+REG32(SCREENING_TYPE2_ETHERTYPE_REG0, 0x6e0)
+REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
 
 #define GEM_T2CW1_COMPARE_OFFSET_SHIFT  (7)
 #define GEM_T2CW1_COMPARE_OFFSET_WIDTH  (8 - GEM_T2CW1_COMPARE_OFFSET_SHIFT + 1)
 #define GEM_T2CW1_OFFSET_VALUE_SHIFT    (0)
 #define GEM_T2CW1_OFFSET_VALUE_WIDTH    (6 - GEM_T2CW1_OFFSET_VALUE_SHIFT + 1)
@@ -323,11 +319,11 @@
 
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0];
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
 }
 
@@ -368,24 +364,24 @@ static inline void print_gem_tx_desc(uint32_t *desc, uint8_t queue)
 
 static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0] & ~0x3UL;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
 }
 
 static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)
 {
     int ret = 2;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
         ret += 2;
     }
-    if (s->regs[GEM_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
+    if (s->regs[R_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
                                        : GEM_DMACFG_TX_BD_EXT)) {
         ret += 2;
     }
 
     assert(ret <= DESC_MAX_NUM_WORDS);
@@ -454,32 +450,32 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
 static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
 {
     uint32_t size;
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
-        size = s->regs[GEM_JUMBO_MAX_LEN];
+    if (s->regs[R_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+        size = s->regs[R_JUMBO_MAX_LEN];
         if (size > s->jumbo_max_len) {
             size = s->jumbo_max_len;
             qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg cannot be"
                 " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
         }
     } else if (tx) {
         size = 1518;
     } else {
-        size = s->regs[GEM_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
+        size = s->regs[R_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
     }
     return size;
 }
 
 static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
 {
     if (q == 0) {
-        s->regs[GEM_ISR] |= flag & ~(s->regs[GEM_IMR]);
+        s->regs[R_ISR] |= flag & ~(s->regs[R_IMR]);
     } else {
-        s->regs[GEM_INT_Q1_STATUS + q - 1] |= flag &
-                                      ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+        s->regs[R_INT_Q1_STATUS + q - 1] |= flag &
+                                      ~(s->regs[R_INT_Q1_MASK + q - 1]);
     }
 }
 
 /*
  * gem_init_register_masks:
@@ -489,47 +485,47 @@ static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
 static void gem_init_register_masks(CadenceGEMState *s)
 {
     unsigned int i;
     /* Mask of register bits which are read only */
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
-    s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
-    s->regs_ro[GEM_NWSTATUS] = 0xFFFFFFFF;
-    s->regs_ro[GEM_DMACFG]   = 0x8E00F000;
-    s->regs_ro[GEM_TXSTATUS] = 0xFFFFFE08;
-    s->regs_ro[GEM_RXQBASE]  = 0x00000003;
-    s->regs_ro[GEM_TXQBASE]  = 0x00000003;
-    s->regs_ro[GEM_RXSTATUS] = 0xFFFFFFF0;
-    s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
-    s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
-    s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
+    s->regs_ro[R_NWCTRL]   = 0xFFF80000;
+    s->regs_ro[R_NWSTATUS] = 0xFFFFFFFF;
+    s->regs_ro[R_DMACFG]   = 0x8E00F000;
+    s->regs_ro[R_TXSTATUS] = 0xFFFFFE08;
+    s->regs_ro[R_RXQBASE]  = 0x00000003;
+    s->regs_ro[R_TXQBASE]  = 0x00000003;
+    s->regs_ro[R_RXSTATUS] = 0xFFFFFFF0;
+    s->regs_ro[R_ISR]      = 0xFFFFFFFF;
+    s->regs_ro[R_IMR]      = 0xFFFFFFFF;
+    s->regs_ro[R_MODID]    = 0xFFFFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
-        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFF319;
-        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFF319;
-        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;
+        s->regs_ro[R_INT_Q1_STATUS + i] = 0xFFFFFFFF;
+        s->regs_ro[R_INT_Q1_ENABLE + i] = 0xFFFFF319;
+        s->regs_ro[R_INT_Q1_DISABLE + i] = 0xFFFFF319;
+        s->regs_ro[R_INT_Q1_MASK + i] = 0xFFFFFFFF;
     }
 
     /* Mask of register bits which are clear on read */
     memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
-    s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
+    s->regs_rtc[R_ISR]      = 0xFFFFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
+        s->regs_rtc[R_INT_Q1_STATUS + i] = 0x00000CE6;
     }
 
     /* Mask of register bits which are write 1 to clear */
     memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
-    s->regs_w1c[GEM_TXSTATUS] = 0x000001F7;
-    s->regs_w1c[GEM_RXSTATUS] = 0x0000000F;
+    s->regs_w1c[R_TXSTATUS] = 0x000001F7;
+    s->regs_w1c[R_RXSTATUS] = 0x0000000F;
 
     /* Mask of register bits which are write only */
     memset(&s->regs_wo[0], 0, sizeof(s->regs_wo));
-    s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
-    s->regs_wo[GEM_IER]      = 0x07FFFFFF;
-    s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
+    s->regs_wo[R_NWCTRL]   = 0x00073E60;
+    s->regs_wo[R_IER]      = 0x07FFFFFF;
+    s->regs_wo[R_IDR]      = 0x07FFFFFF;
     for (i = 0; i < s->num_priority_queues; i++) {
-        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
-        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
+        s->regs_wo[R_INT_Q1_ENABLE + i] = 0x00000CE6;
+        s->regs_wo[R_INT_Q1_DISABLE + i] = 0x00000CE6;
     }
 }
 
 /*
  * phy_update_link:
@@ -559,11 +555,11 @@ static bool gem_can_receive(NetClientState *nc)
     int i;
 
     s = qemu_get_nic_opaque(nc);
 
     /* Do nothing if receive is not enabled. */
-    if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_RXENA)) {
+    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_RXENA)) {
         if (s->can_rx_state != 1) {
             s->can_rx_state = 1;
             DB_PRINT("can't receive - no enable\n");
         }
         return false;
@@ -596,14 +592,14 @@ static bool gem_can_receive(NetClientState *nc)
  */
 static void gem_update_int_status(CadenceGEMState *s)
 {
     int i;
 
-    qemu_set_irq(s->irq[0], !!s->regs[GEM_ISR]);
+    qemu_set_irq(s->irq[0], !!s->regs[R_ISR]);
 
     for (i = 1; i < s->num_priority_queues; ++i) {
-        qemu_set_irq(s->irq[i], !!s->regs[GEM_INT_Q1_STATUS + i - 1]);
+        qemu_set_irq(s->irq[i], !!s->regs[R_INT_Q1_STATUS + i - 1]);
     }
 }
 
 /*
  * gem_receive_updatestats:
@@ -613,43 +609,43 @@ static void gem_receive_updatestats(CadenceGEMState *s, const uint8_t *packet,
                                     unsigned bytes)
 {
     uint64_t octets;
 
     /* Total octets (bytes) received */
-    octets = ((uint64_t)(s->regs[GEM_OCTRXLO]) << 32) |
-             s->regs[GEM_OCTRXHI];
+    octets = ((uint64_t)(s->regs[R_OCTRXLO]) << 32) |
+             s->regs[R_OCTRXHI];
     octets += bytes;
-    s->regs[GEM_OCTRXLO] = octets >> 32;
-    s->regs[GEM_OCTRXHI] = octets;
+    s->regs[R_OCTRXLO] = octets >> 32;
+    s->regs[R_OCTRXHI] = octets;
 
     /* Error-free Frames received */
-    s->regs[GEM_RXCNT]++;
+    s->regs[R_RXCNT]++;
 
     /* Error-free Broadcast Frames counter */
     if (!memcmp(packet, broadcast_addr, 6)) {
-        s->regs[GEM_RXBROADCNT]++;
+        s->regs[R_RXBROADCNT]++;
     }
 
     /* Error-free Multicast Frames counter */
     if (packet[0] == 0x01) {
-        s->regs[GEM_RXMULTICNT]++;
+        s->regs[R_RXMULTICNT]++;
     }
 
     if (bytes <= 64) {
-        s->regs[GEM_RX64CNT]++;
+        s->regs[R_RX64CNT]++;
     } else if (bytes <= 127) {
-        s->regs[GEM_RX65CNT]++;
+        s->regs[R_RX65CNT]++;
     } else if (bytes <= 255) {
-        s->regs[GEM_RX128CNT]++;
+        s->regs[R_RX128CNT]++;
     } else if (bytes <= 511) {
-        s->regs[GEM_RX256CNT]++;
+        s->regs[R_RX256CNT]++;
     } else if (bytes <= 1023) {
-        s->regs[GEM_RX512CNT]++;
+        s->regs[R_RX512CNT]++;
     } else if (bytes <= 1518) {
-        s->regs[GEM_RX1024CNT]++;
+        s->regs[R_RX1024CNT]++;
     } else {
-        s->regs[GEM_RX1519CNT]++;
+        s->regs[R_RX1519CNT]++;
     }
 }
 
 /*
  * Get the MAC Address bit from the specified position
@@ -704,39 +700,39 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
     int i, is_mc;
 
     /* Promiscuous mode? */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_PROMISC) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_PROMISC) {
         return GEM_RX_PROMISCUOUS_ACCEPT;
     }
 
     if (!memcmp(packet, broadcast_addr, 6)) {
         /* Reject broadcast packets? */
-        if (s->regs[GEM_NWCFG] & GEM_NWCFG_BCAST_REJ) {
+        if (s->regs[R_NWCFG] & GEM_NWCFG_BCAST_REJ) {
             return GEM_RX_REJECT;
         }
         return GEM_RX_BROADCAST_ACCEPT;
     }
 
     /* Accept packets -w- hash match? */
     is_mc = is_multicast_ether_addr(packet);
-    if ((is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (!is_mc && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    if ((is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
+        (!is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
         uint64_t buckets;
         unsigned hash_index;
 
         hash_index = calc_mac_hash(packet);
-        buckets = ((uint64_t)s->regs[GEM_HASHHI] << 32) | s->regs[GEM_HASHLO];
+        buckets = ((uint64_t)s->regs[R_HASHHI] << 32) | s->regs[R_HASHLO];
         if ((buckets >> hash_index) & 1) {
             return is_mc ? GEM_RX_MULTICAST_HASH_ACCEPT
                          : GEM_RX_UNICAST_HASH_ACCEPT;
         }
     }
 
     /* Check all 4 specific addresses */
-    gem_spaddr = (uint8_t *)&(s->regs[GEM_SPADDR1LO]);
+    gem_spaddr = (uint8_t *)&(s->regs[R_SPADDR1LO]);
     for (i = 3; i >= 0; i--) {
         if (s->sar_active[i] && !memcmp(packet, gem_spaddr + 8 * i, 6)) {
             return GEM_RX_SAR_ACCEPT + i;
         }
     }
@@ -752,11 +748,11 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     uint32_t reg;
     bool matched, mismatched;
     int i, j;
 
     for (i = 0; i < s->num_type1_screeners; i++) {
-        reg = s->regs[GEM_SCREENING_TYPE1_REGISTER_0 + i];
+        reg = s->regs[R_SCREENING_TYPE1_REG0 + i];
         matched = false;
         mismatched = false;
 
         /* Screening is based on UDP Port */
         if (reg & GEM_ST1R_UDP_PORT_MATCH_ENABLE) {
@@ -784,11 +780,11 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
             return extract32(reg, GEM_ST1R_QUEUE_SHIFT, GEM_ST1R_QUEUE_WIDTH);
         }
     }
 
     for (i = 0; i < s->num_type2_screeners; i++) {
-        reg = s->regs[GEM_SCREENING_TYPE2_REGISTER_0 + i];
+        reg = s->regs[R_SCREENING_TYPE2_REG0 + i];
         matched = false;
         mismatched = false;
 
         if (reg & GEM_ST2R_ETHERTYPE_ENABLE) {
             uint16_t type = rxbuf_ptr[12] << 8 | rxbuf_ptr[13];
@@ -797,11 +793,11 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
             if (et_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
                               "register index: %d\n", et_idx);
             }
-            if (type == s->regs[GEM_SCREENING_TYPE2_ETHERTYPE_REG_0 +
+            if (type == s->regs[R_SCREENING_TYPE2_ETHERTYPE_REG0 +
                                 et_idx]) {
                 matched = true;
             } else {
                 mismatched = true;
             }
@@ -821,12 +817,12 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
             if (cr_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range compare "
                               "register index: %d\n", cr_idx);
             }
 
-            cr0 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
-            cr1 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
+            cr0 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
+            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
             offset = extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
                                     GEM_T2CW1_OFFSET_VALUE_WIDTH);
 
             switch (extract32(cr1, GEM_T2CW1_COMPARE_OFFSET_SHIFT,
                                    GEM_T2CW1_COMPARE_OFFSET_WIDTH)) {
@@ -869,15 +865,15 @@ static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
 {
     uint32_t base_addr = 0;
 
     switch (q) {
     case 0:
-        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
+        base_addr = s->regs[tx ? R_TXQBASE : R_RXQBASE];
         break;
     case 1 ... (MAX_PRIORITY_QUEUES - 1):
-        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
-                                 GEM_RECEIVE_Q1_PTR) + q - 1];
+        base_addr = s->regs[(tx ? R_TRANSMIT_Q1_PTR :
+                                 R_RECEIVE_Q1_PTR) + q - 1];
         break;
     default:
         g_assert_not_reached();
     };
 
@@ -896,12 +892,12 @@ static inline uint32_t gem_get_rx_queue_base_addr(CadenceGEMState *s, int q)
 
 static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
 
-    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
-        desc_addr = s->regs[tx ? GEM_TBQPH : GEM_RBQPH];
+    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+        desc_addr = s->regs[tx ? R_TBQPH : R_RBQPH];
     }
     desc_addr <<= 32;
     desc_addr |= tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
     return desc_addr;
 }
@@ -928,11 +924,11 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
                        sizeof(uint32_t) * gem_get_desc_len(s, true));
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
-        s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
+        s->regs[R_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
         gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
 }
@@ -956,11 +952,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (maf == GEM_RX_REJECT) {
         return size;  /* no, drop silently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_LERR_DISC) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_LERR_DISC) {
         unsigned type_len;
 
         /* Fish the ethertype / length field out of the RX packet */
         type_len = buf[12] << 8 | buf[13];
         /* It is a length field, not an ethertype */
@@ -973,17 +969,17 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /*
      * Determine configured receive buffer offset (probably 0)
      */
-    rxbuf_offset = (s->regs[GEM_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
+    rxbuf_offset = (s->regs[R_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
                    GEM_NWCFG_BUFF_OFST_S;
 
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
      */
-    rxbufsize = ((s->regs[GEM_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
+    rxbufsize = ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
                  GEM_DMACFG_RBUFSZ_S) * GEM_DMACFG_RBUFSZ_MUL;
     bytes_to_copy = size;
 
     /* Hardware allows a zero value here but warns against it. To avoid QEMU
      * indefinite loops we enforce a minimum value here
@@ -999,11 +995,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (size < 60) {
         size = 60;
     }
 
     /* Strip of FCS field ? (usually yes) */
-    if (s->regs[GEM_NWCFG] & GEM_NWCFG_STRIP_FCS) {
+    if (s->regs[R_NWCFG] & GEM_NWCFG_STRIP_FCS) {
         rxbuf_ptr = (void *)buf;
     } else {
         unsigned crc_val;
 
         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
@@ -1105,11 +1101,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Count it */
     gem_receive_updatestats(s, buf, size);
 
-    s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
+    s->regs[R_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
     gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
 
@@ -1124,43 +1120,43 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
                                      unsigned bytes)
 {
     uint64_t octets;
 
     /* Total octets (bytes) transmitted */
-    octets = ((uint64_t)(s->regs[GEM_OCTTXLO]) << 32) |
-             s->regs[GEM_OCTTXHI];
+    octets = ((uint64_t)(s->regs[R_OCTTXLO]) << 32) |
+             s->regs[R_OCTTXHI];
     octets += bytes;
-    s->regs[GEM_OCTTXLO] = octets >> 32;
-    s->regs[GEM_OCTTXHI] = octets;
+    s->regs[R_OCTTXLO] = octets >> 32;
+    s->regs[R_OCTTXHI] = octets;
 
     /* Error-free Frames transmitted */
-    s->regs[GEM_TXCNT]++;
+    s->regs[R_TXCNT]++;
 
     /* Error-free Broadcast Frames counter */
     if (!memcmp(packet, broadcast_addr, 6)) {
-        s->regs[GEM_TXBCNT]++;
+        s->regs[R_TXBCNT]++;
     }
 
     /* Error-free Multicast Frames counter */
     if (packet[0] == 0x01) {
-        s->regs[GEM_TXMCNT]++;
+        s->regs[R_TXMCNT]++;
     }
 
     if (bytes <= 64) {
-        s->regs[GEM_TX64CNT]++;
+        s->regs[R_TX64CNT]++;
     } else if (bytes <= 127) {
-        s->regs[GEM_TX65CNT]++;
+        s->regs[R_TX65CNT]++;
     } else if (bytes <= 255) {
-        s->regs[GEM_TX128CNT]++;
+        s->regs[R_TX128CNT]++;
     } else if (bytes <= 511) {
-        s->regs[GEM_TX256CNT]++;
+        s->regs[R_TX256CNT]++;
     } else if (bytes <= 1023) {
-        s->regs[GEM_TX512CNT]++;
+        s->regs[R_TX512CNT]++;
     } else if (bytes <= 1518) {
-        s->regs[GEM_TX1024CNT]++;
+        s->regs[R_TX1024CNT]++;
     } else {
-        s->regs[GEM_TX1519CNT]++;
+        s->regs[R_TX1519CNT]++;
     }
 }
 
 /*
  * gem_transmit:
@@ -1173,11 +1169,11 @@ static void gem_transmit(CadenceGEMState *s)
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
 
     /* Do nothing if transmit is not enabled. */
-    if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_TXENA)) {
+    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
         return;
     }
 
     DB_PRINT("\n");
 
@@ -1198,11 +1194,11 @@ static void gem_transmit(CadenceGEMState *s)
                            sizeof(uint32_t) * gem_get_desc_len(s, false));
         /* Handle all descriptors owned by hardware */
         while (tx_desc_get_used(desc) == 0) {
 
             /* Do nothing if transmit is not enabled. */
-            if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_TXENA)) {
+            if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
                 return;
             }
             print_gem_tx_desc(desc, q);
 
             /* The real hardware would eat this (and possibly crash).
@@ -1256,26 +1252,26 @@ static void gem_transmit(CadenceGEMState *s)
                     s->tx_desc_addr[q] = packet_desc_addr +
                                          4 * gem_get_desc_len(s, false);
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
-                s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
+                s->regs[R_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
                 gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
 
                 /* Is checksum offload enabled? */
-                if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
+                if (s->regs[R_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
                     net_checksum_calculate(s->tx_packet, total_bytes, CSUM_ALL);
                 }
 
                 /* Update MAC statistics */
                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
 
                 /* Send the packet somewhere */
-                if (s->phy_loop || (s->regs[GEM_NWCTRL] &
+                if (s->phy_loop || (s->regs[R_NWCTRL] &
                                     GEM_NWCTRL_LOCALLOOP)) {
                     qemu_receive_packet(qemu_get_queue(s->nic), s->tx_packet,
                                         total_bytes);
                 } else {
                     qemu_send_packet(qemu_get_queue(s->nic), s->tx_packet,
@@ -1287,13 +1283,12 @@ static void gem_transmit(CadenceGEMState *s)
                 total_bytes = 0;
             }
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-
-                if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
-                    packet_desc_addr = s->regs[GEM_TBQPH];
+                if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                    packet_desc_addr = s->regs[R_TBQPH];
                     packet_desc_addr <<= 32;
                 } else {
                     packet_desc_addr = 0;
                 }
                 packet_desc_addr |= gem_get_tx_queue_base_addr(s, q);
@@ -1305,11 +1300,11 @@ static void gem_transmit(CadenceGEMState *s)
                                MEMTXATTRS_UNSPECIFIED, desc,
                                sizeof(uint32_t) * gem_get_desc_len(s, false));
         }
 
         if (tx_desc_get_used(desc)) {
-            s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_USED;
+            s->regs[R_TXSTATUS] |= GEM_TXSTATUS_USED;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
                 gem_set_isr(s, 0, GEM_INT_TXUSED);
             }
             gem_update_int_status(s);
@@ -1351,34 +1346,34 @@ static void gem_reset(DeviceState *d)
 
     DB_PRINT("\n");
 
     /* Set post reset register values */
     memset(&s->regs[0], 0, sizeof(s->regs));
-    s->regs[GEM_NWCFG] = 0x00080000;
-    s->regs[GEM_NWSTATUS] = 0x00000006;
-    s->regs[GEM_DMACFG] = 0x00020784;
-    s->regs[GEM_IMR] = 0x07ffffff;
-    s->regs[GEM_TXPAUSE] = 0x0000ffff;
-    s->regs[GEM_TXPARTIALSF] = 0x000003ff;
-    s->regs[GEM_RXPARTIALSF] = 0x000003ff;
-    s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02D00111;
-    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
-    s->regs[GEM_DESCONF5] = 0x002f2045;
-    s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
-    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
+    s->regs[R_NWCFG] = 0x00080000;
+    s->regs[R_NWSTATUS] = 0x00000006;
+    s->regs[R_DMACFG] = 0x00020784;
+    s->regs[R_IMR] = 0x07ffffff;
+    s->regs[R_TXPAUSE] = 0x0000ffff;
+    s->regs[R_TXPARTIALSF] = 0x000003ff;
+    s->regs[R_RXPARTIALSF] = 0x000003ff;
+    s->regs[R_MODID] = s->revision;
+    s->regs[R_DESCONF] = 0x02D00111;
+    s->regs[R_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
+    s->regs[R_DESCONF5] = 0x002f2045;
+    s->regs[R_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[R_INT_Q1_MASK] = 0x00000CE6;
+    s->regs[R_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
-        s->regs[GEM_DESCONF6] |= queues_mask;
+        s->regs[R_DESCONF6] |= queues_mask;
     }
 
     /* Set MAC address */
     a = &s->conf.macaddr.a[0];
-    s->regs[GEM_SPADDR1LO] = a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24);
-    s->regs[GEM_SPADDR1HI] = a[4] | (a[5] << 8);
+    s->regs[R_SPADDR1LO] = a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24);
+    s->regs[R_SPADDR1HI] = a[4] | (a[5] << 8);
 
     for (i = 0; i < 4; i++) {
         s->sar_active[i] = false;
     }
 
@@ -1435,15 +1430,15 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     retval = s->regs[offset];
 
     DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset*4, retval);
 
     switch (offset) {
-    case GEM_ISR:
+    case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
-    case GEM_PHYMNTNC:
+    case R_PHYMNTNC:
         if (retval & GEM_PHYMNTNC_OP_R) {
             uint32_t phy_addr, reg_num;
 
             phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
             if (phy_addr == s->phy_addr) {
@@ -1493,11 +1488,11 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
     /* do w1c */
     s->regs[offset] &= ~(s->regs_w1c[offset] & val);
 
     /* Handle register write side effects */
     switch (offset) {
-    case GEM_NWCTRL:
+    case R_NWCTRL:
         if (val & GEM_NWCTRL_RXENA) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
@@ -1513,60 +1508,60 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         if (gem_can_receive(qemu_get_queue(s->nic))) {
             qemu_flush_queued_packets(qemu_get_queue(s->nic));
         }
         break;
 
-    case GEM_TXSTATUS:
+    case R_TXSTATUS:
         gem_update_int_status(s);
         break;
-    case GEM_RXQBASE:
+    case R_RXQBASE:
         s->rx_desc_addr[0] = val;
         break;
-    case GEM_RECEIVE_Q1_PTR ... GEM_RECEIVE_Q7_PTR:
-        s->rx_desc_addr[offset - GEM_RECEIVE_Q1_PTR + 1] = val;
+    case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
+        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = val;
         break;
-    case GEM_TXQBASE:
+    case R_TXQBASE:
         s->tx_desc_addr[0] = val;
         break;
-    case GEM_TRANSMIT_Q1_PTR ... GEM_TRANSMIT_Q7_PTR:
-        s->tx_desc_addr[offset - GEM_TRANSMIT_Q1_PTR + 1] = val;
+    case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
+        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = val;
         break;
-    case GEM_RXSTATUS:
+    case R_RXSTATUS:
         gem_update_int_status(s);
         break;
-    case GEM_IER:
-        s->regs[GEM_IMR] &= ~val;
+    case R_IER:
+        s->regs[R_IMR] &= ~val;
         gem_update_int_status(s);
         break;
-    case GEM_JUMBO_MAX_LEN:
-        s->regs[GEM_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+    case R_JUMBO_MAX_LEN:
+        s->regs[R_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
         break;
-    case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
-        s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
+    case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~val;
         gem_update_int_status(s);
         break;
-    case GEM_IDR:
-        s->regs[GEM_IMR] |= val;
+    case R_IDR:
+        s->regs[R_IMR] |= val;
         gem_update_int_status(s);
         break;
-    case GEM_INT_Q1_DISABLE ... GEM_INT_Q7_DISABLE:
-        s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_DISABLE] |= val;
+    case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= val;
         gem_update_int_status(s);
         break;
-    case GEM_SPADDR1LO:
-    case GEM_SPADDR2LO:
-    case GEM_SPADDR3LO:
-    case GEM_SPADDR4LO:
-        s->sar_active[(offset - GEM_SPADDR1LO) / 2] = false;
+    case R_SPADDR1LO:
+    case R_SPADDR2LO:
+    case R_SPADDR3LO:
+    case R_SPADDR4LO:
+        s->sar_active[(offset - R_SPADDR1LO) / 2] = false;
         break;
-    case GEM_SPADDR1HI:
-    case GEM_SPADDR2HI:
-    case GEM_SPADDR3HI:
-    case GEM_SPADDR4HI:
-        s->sar_active[(offset - GEM_SPADDR1HI) / 2] = true;
+    case R_SPADDR1HI:
+    case R_SPADDR2HI:
+    case R_SPADDR3HI:
+    case R_SPADDR4HI:
+        s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
-    case GEM_PHYMNTNC:
+    case R_PHYMNTNC:
         if (val & GEM_PHYMNTNC_OP_W) {
             uint32_t phy_addr, reg_num;
 
             phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
             if (phy_addr == s->phy_addr) {
-- 
2.39.2


