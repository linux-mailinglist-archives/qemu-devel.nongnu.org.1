Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E16829407
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:11:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSja-0006Um-VU; Wed, 10 Jan 2024 02:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSj0-0006LG-I9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiy-0005St-NE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JLUr53VGhwGQ3iLEEqmy6bmfInLx4ziu3X7VKm/dbE4=; b=F3uugInZQrWnBUEdtik4JWT0tz
 fkZBMIBh6mpclIvz3Y7UF2Myut++6J/+Hx48hi7WiMmIsw61f+9JSDjB2fIvVo14DQvNYIF11mBP2
 CX+8FG/UbUaK4AKgkXpyF4eRCecMEGNkfQa3Qr5tR0d/AKbDXttGW1ThkYFZqKLnvFSGwWxhdlfU9
 CA1nYw8HnZRmY5PzMVN0dPzi4cRgRxv3Fxs7vwuReUXBVpt4ttFZ+xSr2lgn/WNspMJtHHtSNdcag
 QC7Zxl+cWhTsNMJ1IhkrOVmn5j7IhYgfMlVDx3PWjABgIowtWY6mvY/UhfGkY5+Z+qT+GALr+xvyw
 ldw/RFC89ZCCD2HtlXTLS0jwosm0HU0hOHlEFrtt4amk8Be7wJhrDZjMcJfVD5ILFP6hL8rHnw7vY
 Urn77MZMV9l8f0kavTZDDCKQkDc1kVIOg7kuw15kNZnIi+wd/PcROLqP7DfiHH5M7oEllSW6I1V5V
 5NcesSdyv8n3xlyc5DMCe6z2uBZuzbDYpJuHDXugQvl3CDIwwDKgNN8btuqFI+YWiYA+pC2GbDpfB
 7ERGq40S37Jqv7kt+AkWwiCyw3tXdZPc/W4dcCez8n+a9NRdd/viu+9jR6ZpX1mr8gUK0A4Boov6+
 9AQvAw5SfyKfItRWnr4GiUjbMClyUn6cqZm/35GnM=;
Received: from [2a00:23c4:8bb1:9800:b804:1635:e423:adbd]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiP-0001XX-S1; Wed, 10 Jan 2024 07:09:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Wed, 10 Jan 2024 07:08:07 +0000
Message-Id: <20240110070808.369516-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
References: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:b804:1635:e423:adbd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/2] util/fifo8: Allow fifo8_pop_buf() to not populate popped
 length
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

There might be cases where we know the number of bytes we can
pop from the FIFO, or we simply don't care how many bytes is
returned. Allow fifo8_pop_buf() to take a NULL numptr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231109192814.95977-2-philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/qemu/fifo8.h | 10 +++++-----
 util/fifo8.c         | 12 ++++++++----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 16be02f361..d0d02bc73d 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * fifo8_pop_buf:
  * @fifo: FIFO to pop from
  * @max: maximum number of bytes to pop
- * @num: actual number of returned bytes
+ * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
  * Pop a number of elements from the FIFO up to a maximum of max. The buffer
  * containing the popped data is returned. This buffer points directly into
@@ -82,16 +82,16 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * around in the ring buffer; in this case only a contiguous part of the data
  * is returned.
  *
- * The number of valid bytes returned is populated in *num; will always return
- * at least 1 byte. max must not be 0 or greater than the number of bytes in
- * the FIFO.
+ * The number of valid bytes returned is populated in *numptr; will always
+ * return at least 1 byte. max must not be 0 or greater than the number of
+ * bytes in the FIFO.
  *
  * Clients are responsible for checking the availability of requested data
  * using fifo8_num_used().
  *
  * Returns: A pointer to popped data.
  */
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num);
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_reset:
diff --git a/util/fifo8.c b/util/fifo8.c
index de8fd0f1c5..2eeed56e80 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -66,16 +66,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num)
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     uint8_t *ret;
+    uint32_t num;
 
     assert(max > 0 && max <= fifo->num);
-    *num = MIN(fifo->capacity - fifo->head, max);
+    num = MIN(fifo->capacity - fifo->head, max);
     ret = &fifo->data[fifo->head];
-    fifo->head += *num;
+    fifo->head += num;
     fifo->head %= fifo->capacity;
-    fifo->num -= *num;
+    fifo->num -= num;
+    if (numptr) {
+        *numptr = num;
+    }
     return ret;
 }
 
-- 
2.39.2


