Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47C7EDC40
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X5J-0000cA-37; Thu, 16 Nov 2023 02:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X4s-0007Q8-LT; Thu, 16 Nov 2023 02:46:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X4o-0005bC-TR; Thu, 16 Nov 2023 02:46:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E826833BEC;
 Thu, 16 Nov 2023 10:45:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 800DE35852;
 Thu, 16 Nov 2023 10:44:42 +0300 (MSK)
Received: (nullmailer pid 3202544 invoked by uid 1000);
 Thu, 16 Nov 2023 07:44:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 19/27] hw/net/cadence_gem.c: spelling fixes: Octects
Date: Thu, 16 Nov 2023 10:44:33 +0300
Message-Id: <20231116074441.3202417-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116074441.3202417-1-mjt@tls.msk.ru>
References: <20231116074441.3202417-1-mjt@tls.msk.ru>
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Luc Michel <luc.michel@amd.com>
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


