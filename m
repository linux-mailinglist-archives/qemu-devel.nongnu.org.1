Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C904829406
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:10:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSjh-0006iN-UT; Wed, 10 Jan 2024 02:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSj9-0006Ri-EK
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSj4-0005eF-BN
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tE5WW7Z9fiCY6JlqITracdAm9enLLbV05zXpQrGF9/8=; b=tpoxVglQ4fgS8EaYDA+Wc1ty7x
 AoUW2ZQmvjvFdWPk1vdBqa0roFYGgQlVd4e6eMELpTN7xUG/h/6yRznU03V2MJT6gIoclwJS1dIPr
 S0rBYBZGp/mA3sHMOQcuoodGvNDTlQmGyQE9nc4Mv64Tuoohykl6fkTLmaDcgFFhDwqZcA+5TNDJu
 ZrcMmQLoiuCEnxZ07l7x1bsQdKB8WMZyBmHPkjSXMWb1A3ivr5t5r7pLBCEyGlfGEZQ//Rh31L++5
 tKgA3Keq3Wbq+wkdp29pHIZd2eAsvmMfIKZK2nlw8ss6AC2/YCFrUUgJDA8AZolyBesB45L6UdO2Q
 D85/CNuEQwVxDA1DJ38ImuoGVTymEdMROOnBryeTJv7ewx9l662D3M1/gsGFe5C6kPhBo93AcXvLO
 tNJvO2qu7Wdt59wKo5rl5+/EdG1aI31HIU9cT5ZkcYEA5XZN4w3qrqVVAIxTF0gtMDE1BCbsYqsID
 iSNC8RO6DrswMsjckvsApPm09CGPFKZm0CW34s4ofzsb6fx/3hC/mWPGpyDu0lJEdI2QU2ZdVzCit
 F1RfBXoVLW3v94hGbce2HTu1L5jZCSZu9UZ3oVcZLf52OggwCDDkVZKMYpUM6LwWGpDWD8JbGVNNu
 JIFuaZeZ5iAmMEek1xCd3MA1eODyZLz16ccPTMqHM=;
Received: from [2a00:23c4:8bb1:9800:b804:1635:e423:adbd]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiU-0001XX-1Q; Wed, 10 Jan 2024 07:09:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Wed, 10 Jan 2024 07:08:08 +0000
Message-Id: <20240110070808.369516-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
References: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:b804:1635:e423:adbd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 2/2] util/fifo8: Introduce fifo8_peek_buf()
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

To be able to peek at FIFO content without popping it,
introduce the fifo8_peek_buf() method by factoring
common content from fifo8_pop_buf().

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231109192814.95977-3-philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/qemu/fifo8.h | 27 +++++++++++++++++++++++++++
 util/fifo8.c         | 22 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d0d02bc73d..c6295c6ff0 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -93,6 +93,33 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  */
 const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
+/**
+ * fifo8_peek_buf: read upto max bytes from the fifo
+ * @fifo: FIFO to read from
+ * @max: maximum number of bytes to peek
+ * @numptr: pointer filled with number of bytes returned (can be NULL)
+ *
+ * Peek into a number of elements from the FIFO up to a maximum of max.
+ * The buffer containing the data peeked into is returned. This buffer points
+ * directly into the FIFO backing store. Since data is invalidated once any
+ * of the fifo8_* APIs are called on the FIFO, it is the caller responsibility
+ * to access it before doing further API calls.
+ *
+ * The function may return fewer bytes than requested when the data wraps
+ * around in the ring buffer; in this case only a contiguous part of the data
+ * is returned.
+ *
+ * The number of valid bytes returned is populated in *numptr; will always
+ * return at least 1 byte. max must not be 0 or greater than the number of
+ * bytes in the FIFO.
+ *
+ * Clients are responsible for checking the availability of requested data
+ * using fifo8_num_used().
+ *
+ * Returns: A pointer to peekable data.
+ */
+const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+
 /**
  * fifo8_reset:
  * @fifo: FIFO to reset
diff --git a/util/fifo8.c b/util/fifo8.c
index 2eeed56e80..4e01b532d9 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -66,7 +66,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
+                                        uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
     uint32_t num;
@@ -74,15 +75,28 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     assert(max > 0 && max <= fifo->num);
     num = MIN(fifo->capacity - fifo->head, max);
     ret = &fifo->data[fifo->head];
-    fifo->head += num;
-    fifo->head %= fifo->capacity;
-    fifo->num -= num;
+
+    if (do_pop) {
+        fifo->head += num;
+        fifo->head %= fifo->capacity;
+        fifo->num -= num;
+    }
     if (numptr) {
         *numptr = num;
     }
     return ret;
 }
 
+const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+{
+    return fifo8_peekpop_buf(fifo, max, numptr, false);
+}
+
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+{
+    return fifo8_peekpop_buf(fifo, max, numptr, true);
+}
+
 void fifo8_reset(Fifo8 *fifo)
 {
     fifo->num = 0;
-- 
2.39.2


