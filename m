Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DB887E99
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:18:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTM3-0007Rd-TO; Sun, 24 Mar 2024 15:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM2-0007RH-Cb
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM1-0005M9-3K
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/7DugGZmj9nrUGIORfJCP5kDeXH4DbbdOeI4njT8IBg=; b=Qf8y+jtLpP312MomU56ICyQNyO
 ifryGUNlJbI+2Sx4lLP6YGychLJnSx37ef+HUmzI1ZRbHI5WO0vADlE82sRxw7ykiyla93P/9UU0t
 XJkM1BRDepzxX2+PgVI9etA+PVysfiLsQLF3CdJLrnozahaGKKk0XC2Lj9QtRJgvfHFD6RPiMrEOu
 S7hI+9F0Z4ryO3CxrAYpxFweSwUDlNLeslPnqLtBqbYVQnBxWmn5SNo4/rT25LSskWgiHwkbGOZja
 8Pjz6IPcH1a6rWazl7XqUKntfpeMzCancgd+93neY6Zu8FtZWAh4LY8ZaiGuKfIsm7UDjpBIt0PdX
 4YWWXBMQg0pEMjaRCb/bhEh950Xzf2nG/s+d9xt6A/YmV7I5ak+srjd8GiF80A/oysrJyZZtUCVLL
 NTZ3Rr5WSiEnYYhI4OKSP0uNs8F2dM4KRyyk0u8rNdLM8UxTV2ksbm+MLSL/H3H2QP3V+wXWHlLif
 8450jYB9E0Mh0VcUqB3/CmwCKVbbVDjan7oC2heftt/i0wS1lALl+A8U5Pxr+MTH3VH+92WPg4RS4
 JEhPcTCEDO00VU5zahnfD9/dLnigqtY0RKLN+qX+0w+Htw7W0zPuKW89m9cWFQv57hAAoFGxnZQ8l
 iJ6AWw8XH/Bfd3kUlozK1HVkohiwtMX+q2zRKOw6w=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTL1-0000dj-7Z; Sun, 24 Mar 2024 19:17:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:59 +0000
Message-Id: <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 10/17] esp.c: don't assert() if FIFO empty when executing
 non-DMA SELATNS
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

The current logic assumes that at least 1 byte is present in the FIFO when
executing a non-DMA SELATNS command, but this may not be the case if the
guest executes an invalid ESP command sequence.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1aac8f5564..f3aa5364cf 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(s, buf, 1);
+            len = esp_fifo_pop_buf(s, buf,
+                                   MIN(fifo8_num_used(&s->fifo), 1));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
-- 
2.39.2


