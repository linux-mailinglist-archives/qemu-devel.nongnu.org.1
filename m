Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3E887E95
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:18:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLV-0007KP-4Z; Sun, 24 Mar 2024 15:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLS-0007Jx-NV
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLR-0005H9-C5
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L1Xf91YyJW09/aphLZsSH+x9iSbbdC9CU7p2gBJw02s=; b=eToZ/aIltOzJ4kALr6+n1CP3PY
 d5XXnrJiHIx9uHpzd+6ZVGQXb+XHppyi1C5Wcj4DEeDvwDYu5Vb+8zmyQ9Awg5XgZMq4trt1yeLhq
 TreFavuAA54SGq7EnPTMljoFhyul17Ju311dNIfuOCxmlc/j3iYy0mvFgMZ0Yv/Y6zay8idtghlmf
 isrCS5pCI4d0AVDDEkoIepF4siJHBrZwL6dUjgnG8ECa3Lxp290jXIiLuCKVClYb+XPUwv0YDDIWo
 kqrxMRgt4xtQ8aOykOKN/A7gfP7DJkswQDJ5hyJvxZmJmECbwtHZ7Vu7QSuHViO6GJ0JQGo4wQSBD
 EBYhkawx+p25gSIyMWWlcYPoYLosWjjVS0QbqVQ/3LW7tITQeRnxtzhalj7fjQZLmOGB1jUUK+8VM
 6mO5t9WssPOdUaQXwPVtP3lqf1WjFlMUv6n/G4wqlTYCOwmkRbsM+txXBjb1pi8j9FeFXIjFRrw6O
 k1b4G7NgsTFpWa6U2CLhgoxvql+YXhReq3w4THhfG1jk3KQ0V+iJPfHH9SlUX9/0DJneVehWIdtSB
 o6Q13VZIxP45wWrD/oDHoPNo2Qj8KJkgKjQXrPE+aA5kSzyAa2yfGBGJfjH9bK7g95x7hBTCq6hvd
 yQ2h8x8ETSz1ndl6wwBF+bdONGgtXbyZdN/hO/jOE=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKQ-0000dj-Sa; Sun, 24 Mar 2024 19:16:26 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:50 +0000
Message-Id: <20240324191707.623175-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 01/17] esp.c: move esp_fifo_pop_buf() internals to new
 esp_fifo8_pop_buf() function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update esp_fifo_pop_buf() to be a simple wrapper onto the new esp_fifo8_pop_buf()
function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 590ff99744..1b7b118a0b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -125,7 +125,7 @@ static uint8_t esp_fifo_pop(Fifo8 *fifo)
     return fifo8_pop(fifo);
 }
 
-static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 {
     const uint8_t *buf;
     uint32_t n, n2;
@@ -155,6 +155,11 @@ static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     return n;
 }
 
+static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+{
+    return esp_fifo8_pop_buf(fifo, dest, maxlen);
+}
+
 static uint32_t esp_get_tc(ESPState *s)
 {
     uint32_t dmalen;
-- 
2.39.2


