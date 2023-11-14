Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B32D7EB543
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:03:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wlG-00076S-Mq; Tue, 14 Nov 2023 11:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wlA-00071Q-VU; Tue, 14 Nov 2023 11:59:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wl9-00054W-CY; Tue, 14 Nov 2023 11:59:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62CDA33273;
 Tue, 14 Nov 2023 19:59:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2E307351FA;
 Tue, 14 Nov 2023 19:58:43 +0300 (MSK)
Received: (nullmailer pid 2949111 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH trivial 13/21] hw/net/cadence_gem.c: spelling fixes: Octects
Date: Tue, 14 Nov 2023 19:58:26 +0300
Message-Id: <20231114165834.2949011-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Fixes: c755c943aa2e "hw/net/cadence_gem: use REG32 macro for register definitions"
Cc: Luc Michel <luc.michel@amd.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/cadence_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 5b989f5b52..19adbc0e19 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -225,8 +225,8 @@ REG32(WOLAN, 0xb8) /* Wake on LAN reg */
 REG32(IPGSTRETCH, 0xbc) /* IPG Stretch reg */
 REG32(SVLAN, 0xc0) /* Stacked VLAN reg */
 REG32(MODID, 0xfc) /* Module ID reg */
-REG32(OCTTXLO, 0x100) /* Octects transmitted Low reg */
-REG32(OCTTXHI, 0x104) /* Octects transmitted High reg */
+REG32(OCTTXLO, 0x100) /* Octets transmitted Low reg */
+REG32(OCTTXHI, 0x104) /* Octets transmitted High reg */
 REG32(TXCNT, 0x108) /* Error-free Frames transmitted */
 REG32(TXBCNT, 0x10c) /* Error-free Broadcast Frames */
 REG32(TXMCNT, 0x110) /* Error-free Multicast Frame */
@@ -245,8 +245,8 @@ REG32(EXCESSCOLLCNT, 0x140) /* Excessive Collision Frames */
 REG32(LATECOLLCNT, 0x144) /* Late Collision Frames */
 REG32(DEFERTXCNT, 0x148) /* Deferred Transmission Frames */
 REG32(CSENSECNT, 0x14c) /* Carrier Sense Error Counter */
-REG32(OCTRXLO, 0x150) /* Octects Received register Low */
-REG32(OCTRXHI, 0x154) /* Octects Received register High */
+REG32(OCTRXLO, 0x150) /* Octets Received register Low */
+REG32(OCTRXHI, 0x154) /* Octets Received register High */
 REG32(RXCNT, 0x158) /* Error-free Frames Received */
 REG32(RXBROADCNT, 0x15c) /* Error-free Broadcast Frames RX */
 REG32(RXMULTICNT, 0x160) /* Error-free Multicast Frames RX */
-- 
2.39.2


