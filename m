Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0569831374
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:57:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNEh-0000vX-A7; Thu, 18 Jan 2024 02:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNEd-0000tn-La; Thu, 18 Jan 2024 02:54:47 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNEc-0007MI-4e; Thu, 18 Jan 2024 02:54:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90F3C45036;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BA0426619F;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381664 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 12/38] hw/net: cadence_gem: Fix MDIO_OP_xxx values
Date: Thu, 18 Jan 2024 10:52:39 +0300
Message-Id: <20240118075404.2381519-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bin Meng <bmeng@tinylab.org>

Testing upstream U-Boot with 'sifive_u' machine we see:

  => dhcp
  ethernet@10090000: PHY present at 0
  Could not get PHY for ethernet@10090000: addr 0
  phy_connect failed

This has been working till QEMU 8.1 but broken since QEMU 8.2.

Fixes: 1b09eeb122aa ("hw/net/cadence_gem: use FIELD to describe PHYMNTNC register fields")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 0c7ffc977195c1f71c8132eb5616827e589d4a0f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


