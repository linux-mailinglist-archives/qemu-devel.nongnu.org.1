Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE9821D8E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 15:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKfcb-0004C5-20; Tue, 02 Jan 2024 09:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>)
 id 1rKfcS-00049n-Rb; Tue, 02 Jan 2024 09:19:49 -0500
Received: from bg4.exmail.qq.com ([43.154.221.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>)
 id 1rKfcN-0000TO-KV; Tue, 02 Jan 2024 09:19:48 -0500
X-QQ-mid: bizesmtp75t1704205086tlo0k0n9
Received: from ubuntu.. ( [111.196.133.100]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 02 Jan 2024 22:18:04 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: eSZ1CZgv+JCCjt6BRbUVmkjPFKhqPKNmwfr7qhuM4FJoYoyWBapMtpPIgDNL1
 zK3lLxi3jbsizU0zwXso7o6eKy6b/f2WR9Z7hTAzJ8S4xmLVviBMsiHs6gCKABT+Gw8Rzsk
 hl7v73pxdpKsTCruPgOAl6Hsq5WiGJel7vljdEIN8nnoJLGkAK9E7wkuF82Axa0ffh5XeZo
 xaVHhqO8IGEeGhmAcOpthIqGCTGASRre5WNjtzOg3wHzhu7FkA18sdmK4Bu0/WqlAqDTDVB
 O8LI0T0l/HmdbU5Kb6qGdZYqh/MRiSqMt2CnMaZLCfJN4kWNVYJ6JTbtXO/ZVFroSVtFVD/
 hK+Ievt2Y2CFQ5G1NtWqiv68Lk1JjZ+A4nCUv9Y
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 33360802043665270
From: Bin Meng <bmeng@tinylab.org>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH for 8.2.1] hw/net: cadence_gem: Fix MDIO_OP_xxx values
Date: Tue,  2 Jan 2024 22:18:03 +0800
Message-Id: <20240102141803.117631-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.154.221.58; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Testing upstream U-Boot with 'sifive_u' machine we see:

  => dhcp
  ethernet@10090000: PHY present at 0
  Could not get PHY for ethernet@10090000: addr 0
  phy_connect failed

This has been working till QEMU 8.1 but broken since QEMU 8.2.

Fixes: 1b09eeb122aa ("hw/net/cadence_gem: use FIELD to describe PHYMNTNC register fields")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Meng <bmeng@tinylab.org>

---

 hw/net/cadence_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 296bba238e..472ce9c8cf 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -199,8 +199,8 @@ REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
     FIELD(PHYMNTNC, PHY_ADDR, 23, 5)
     FIELD(PHYMNTNC, OP, 28, 2)
     FIELD(PHYMNTNC, ST, 30, 2)
-#define MDIO_OP_READ    0x3
-#define MDIO_OP_WRITE   0x2
+#define MDIO_OP_READ    0x2
+#define MDIO_OP_WRITE   0x1
 
 REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
 REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
-- 
2.34.1


