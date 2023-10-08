Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CD7BCE61
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 14:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpTKy-0000TD-UY; Sun, 08 Oct 2023 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qpO7K-0001AM-C6
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 03:22:22 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qpO7I-0007HW-7x
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 03:22:21 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 1F16011EE06
 for <qemu-devel@nongnu.org>; Sun,  8 Oct 2023 07:22:17 +0000 (UTC)
From: ~disean <disean@git.sr.ht>
Date: Sun, 08 Oct 2023 12:54:32 +0600
Subject: [PATCH QEMU] tulip: Fix LXT970 PHY registers
Message-ID: <169674973699.6685.14097094770329042160-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Oct 2023 08:56:45 -0400
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
Reply-To: ~disean <di.sean@protonmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Dmitry Borisov <di.sean@protonmail.com>

Fix incorrect MII status value (0xf02c).

Use default values from a 21143-based board:
https://www.beowulf.org/pipermail/tulip-bug/2000-February/000485.html

Signed-off-by: Dmitry Borisov <di.sean@protonmail.com>
---
 hw/net/tulip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 hw/net/tulip.c

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
old mode 100644
new mode 100755
index 915e5fb595..43e8f4bcb5
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -415,14 +415,15 @@ static void tulip_update_rs(TULIPState *s, int state)
     trace_tulip_rx_state(tulip_rx_state_name(state));
 }
 
+/* LEVEL1 LXT970 PHY registers */
 static uint16_t tulip_mdi_default[] = {
     /* MDI Registers 0 - 6, 7 */
-    0x3100, 0xf02c, 0x7810, 0x0000, 0x0501, 0x4181, 0x0000, 0x0000,
+    0x1000, 0x782d, 0x7810, 0x0001, 0x01e1, 0x41e1, 0x0001, 0x0000,
     /* MDI Registers 8 - 15 */
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     /* MDI Registers 16 - 31 */
-    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000, 0x0000, 0x4000, 0x0000, 0x38c8, 0x0010, 0x0000, 0x0002,
+    0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
 /* Readonly mask for MDI (PHY) registers */
-- 
2.38.5

