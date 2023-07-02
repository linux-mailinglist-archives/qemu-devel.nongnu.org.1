Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB3744E70
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzKD-0004QO-Gw; Sun, 02 Jul 2023 11:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKA-0004Ps-Nc
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzK8-0007RN-PI
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G7IDZZ2EE3/FLoDyp3shTPN+mXi9/uXytBT9RdNQXYo=; b=EYswbqDta3TRuB7WZ6uPBY7iU5
 N1ceKaTWcHj8AcSAmbSV3g1DCfjoxNOzPYCOd2B3yNlYvOyIz3TR7IBrzNIv8dBY8bT+qM5+KYk9U
 V0TGzjHvH9R7eXK3p4859PQI9voXYzNuPJf9tUv+OIJ3oYyxNfTUK6ICqhGksWjAurLgPysPz+gUL
 iGpo+czpXI3wDh5+8lIpgHh738sVsmvrN3DhQCiXSeFIHqKhKkMzjxutS2ev9Du5mDnkEpfRvArEP
 2YHOrz2XUIrds5oKf3U6c0LCA5SnV3baQm8PtWpn5s/wuEV4HrUGNP0YnDzXgGsL+wZNi8OZ6EODo
 H4U1t1JTV5FMQjbXAm6toU4o0CWlY/Gv5inPorPscJqubc9gkNO4DTnl8lJ1h+iWlezz/VLPVxDbA
 AbTAv6oeNMP0XO3w/8/Ay0vHDIEm+vfV7ihkBa//pEXPOmlzvQ8uKQQahJTPPZdE7K4BNhp7K3AuB
 tnFPqWyqE2MnuzQ+w1thtSQ3qGpo4jAlUgawAxiX8yMEuA+7nkUyGXNdx3OxgBd8rLxOEU0PdtqZe
 qWSJK7cvpEjakVru077hEQOVetgWTkWERd+KFUVBWS2KhhhFjm0Q6wRDkVdeNIJzi5sh2eeBdQhB3
 z8Z2HTjbTZt+kJqgWyCXPsx5lRmxBhYF1MT+qIZEM=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJx-0001Ji-A6; Sun, 02 Jul 2023 16:49:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:25 +0100
Message-Id: <20230702154838.722809-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/21] asc: generate silence if FIFO empty but engine still
 running
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

MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
been written to the hardware, and expects the FIFO status flags and IRQ to be
updated continuously.

Since not all audio backends guarantee an all-zero output when no data is
provided, explicitly generate at least one full output buffer of all-zero output
when the FIFO is disabled and continuously if the FIFO is empty. Otherwise some
audio backends such as Windows re-use their internal buffers causing the last
played sound to loop indefinitely.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/audio/asc.c         | 43 ++++++++++++++++++++++++++++++++----------
 include/hw/audio/asc.h |  1 +
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index ebcb8a97a6..f9bfae5168 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -148,6 +148,20 @@ static uint8_t asc_fifo_get(ASCFIFOState *fs)
     return val;
 }
 
+static int generate_silence(ASCState *s, int maxsamples)
+{
+    uint8_t *buf = s->mixbuf;
+
+    if (s->flush_zero_samples) {
+        memset(buf, 0x80, maxsamples << s->shift);
+        s->flush_zero_samples -= MIN(maxsamples, s->flush_zero_samples);
+
+        return maxsamples;
+    }
+
+    return 0;
+}
+
 static int generate_fifo(ASCState *s, int maxsamples)
 {
     uint8_t *buf = s->mixbuf;
@@ -156,18 +170,26 @@ static int generate_fifo(ASCState *s, int maxsamples)
     limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
 
     /*
-     * If starting a new run with no FIFO data present, update the IRQ and
-     * continue
+     * MacOS (un)helpfully leaves the FIFO engine running even when it has
+     * finished writing out samples. Since not all audio backends guarantee an
+     * all-zero output when no data is provided, zero out the sample buffer
+     * and then update the FIFO flags and IRQ as normal and continue
      */
-    if (limit == 0 && s->fifos[0].int_status == 0 &&
-            s->fifos[1].int_status == 0) {
-        s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
-                                  ASC_FIFO_STATUS_FULL_EMPTY;
-        s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
-                                  ASC_FIFO_STATUS_FULL_EMPTY;
+    if (limit == 0) {
+        if (s->fifos[0].int_status == 0 && s->fifos[1].int_status == 0) {
+            s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
+                                      ASC_FIFO_STATUS_FULL_EMPTY;
+            s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
+                                      ASC_FIFO_STATUS_FULL_EMPTY;
+        }
+
+        if (s->flush_zero_samples == 0) {
+            s->flush_zero_samples = s->samples;
+        }
 
+        generate_silence(s, maxsamples);
         asc_raise_irq(s);
-        return 0;
+        return maxsamples;
     }
 
     while (count < limit) {
@@ -309,7 +331,7 @@ static void asc_out_cb(void *opaque, int free_b)
     switch (s->regs[ASC_MODE] & 3) {
     default:
         /* Off */
-        samples = 0;
+        samples = generate_silence(s, samples);
         break;
     case 1:
         /* FIFO mode */
@@ -437,6 +459,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
             asc_lower_irq(s);
             if (value != 0) {
                 AUD_set_active_out(s->voice, 1);
+                s->flush_zero_samples = 0;
             } else {
                 AUD_set_active_out(s->voice, 0);
             }
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index 41c6cba8fa..918f6ac582 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -65,6 +65,7 @@ struct ASCState {
     uint8_t *mixbuf;
     int samples;
     int shift;
+    uint32_t flush_zero_samples;
 
     qemu_irq irq;
 
-- 
2.30.2


