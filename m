Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318474DCCF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv32-00016C-87; Mon, 10 Jul 2023 13:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2z-00015Q-LC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2w-0000OO-Te
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5645048f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011494; x=1691603494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vINMBBFp0tNBmc0jxCNSawkrMv3zFmYswmW1JkHmuF4=;
 b=jn7tXF0Vb0kI9zsoLl9pbMSgyVMTyYig7Y7CT3MRnsBjQTEb/vS3dk7yZAseCFEMCk
 6HeReqKI82E32hJ9ZZhOEoVtrMYY+bVlDHWa1XJsCuY2rmP388jPFHHBdtF9lN26/UU6
 QcE16m6QH0l42CQgMTI8mgBeTOhXdyBBxNRU1bYSAkXlEpRRa6tgj9DVzgMnkepE6re4
 KAv1z49zOkq6eJib3YdFIHV3RtSLZa+UFcXQ3WqhD5mjSv5EFEhTcy/T4txY9xJjRWON
 ozhEaklkTE6GFj0ozcd2bHIHB7qa2oGjGLuFCPrBfMHi8L1Ns6Ue5M66BnJ4X3B56R6h
 vVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011494; x=1691603494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vINMBBFp0tNBmc0jxCNSawkrMv3zFmYswmW1JkHmuF4=;
 b=IcqCKqgJEXJ8abHARYuf3e2q2Ah91tSSfIrXFfn6YIeyn0/LFHLp9W3ydoynqUbiti
 oi0w9EgRRCKbx6edgRmhVJ2IMOHtG59yEgt9yP/BdOT7TjRjI+5sAtJAir9R9JJSbNmf
 eGTZvBCt0kF2Z2h9IxGcMd4fWH32hUfeoFn3ty6tPU5Lh9oClSR0p9HlojE2lpnKbPDq
 fJOqB3pf1Xl73bNmAqpsws8eF7nxEPI/CRrbUSAeNq9k0qLt8okLLFMeV3z4INtasi62
 FmNU9I9sZStcGVr5TTp5tgOUKwWdmN0AlSFmLGdXz0o0Rw7weGWjUf4MUDUjPq33Tc/t
 gP4A==
X-Gm-Message-State: ABy/qLZiUnsBgvltFee9B6bc3lecKA+ak2hFIVcoRqU5+4wAPXlEhd2L
 Yw52YlaVKqtTDnKMK0TOySWA2z2T3aGOyq2d7VdpNQ==
X-Google-Smtp-Source: APBJJlGaBovkyYwERLmKrPb7OJiP9ZlPYVS5p/QuhJlB/wE5PatCPCuRKHLHBISsokvssjA8uAqG2A==
X-Received: by 2002:a5d:4ec7:0:b0:314:3843:ebaa with SMTP id
 s7-20020a5d4ec7000000b003143843ebaamr16189249wrv.68.1689011494797; 
 Mon, 10 Jul 2023 10:51:34 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 k3-20020a5d66c3000000b00314398e4dd4sm29988wrw.54.2023.07.10.10.51.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/11] hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
Date: Mon, 10 Jul 2023 19:50:56 +0200
Message-Id: <20230710175102.32429-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To be able to reset the RX or TX FIFO separately,
split pl011_reset_fifo() in two.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/char/pl011.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 58edeb9ddb..1f07c7b021 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -132,14 +132,21 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
-static inline void pl011_reset_fifo(PL011State *s)
+static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
     s->read_pos = 0;
 
     /* Reset FIFO flags */
-    s->flags &= ~(PL011_FLAG_RXFF | PL011_FLAG_TXFF);
-    s->flags |= PL011_FLAG_RXFE | PL011_FLAG_TXFE;
+    s->flags &= ~PL011_FLAG_RXFF;
+    s->flags |= PL011_FLAG_RXFE;
+}
+
+static inline void pl011_reset_tx_fifo(PL011State *s)
+{
+    /* Reset FIFO flags */
+    s->flags &= ~PL011_FLAG_TXFF;
+    s->flags |= PL011_FLAG_TXFE;
 }
 
 static uint64_t pl011_read(void *opaque, hwaddr offset,
@@ -289,7 +296,8 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
-            pl011_reset_fifo(s);
+            pl011_reset_rx_fifo(s);
+            pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
             int break_enable = value & LCR_BRK;
@@ -506,7 +514,8 @@ static void pl011_reset(DeviceState *dev)
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0;
-    pl011_reset_fifo(s);
+    pl011_reset_rx_fifo(s);
+    pl011_reset_tx_fifo(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, void *data)
-- 
2.38.1


