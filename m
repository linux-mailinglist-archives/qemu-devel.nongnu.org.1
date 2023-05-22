Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2370C28F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wf-0007cB-8s; Mon, 22 May 2023 11:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wa-0007Uu-WD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WP-0001RU-J8
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso9303235e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769546; x=1687361546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=256qRxVoRgmn8ZQNw96BSPjzs8Oo5GL3PGwhSL7cRNw=;
 b=C/t7JMkQsTbjpIgJ59MHwv63ucFDE2WtK1AE0dsf4JCAAsNUrp1pDlOCrmtxwNAj+C
 oceIXdKSpx4vUBXmKDLfyQ+5HS+At35HtKg2gvcngba7a/Lzav1Jvpv7XGm969IfTPKc
 lh2eTjhN3LR5TiRFc3LSSFTVtFhLGmUPEmwd7xIC+rcCrEjG46BtGVY9L3KlhU26iMxw
 JCv4Lu5Xx+PjGfWP86KsSoMROJ14gykSKxfg4Jkbvcv1xGpblT1+KdtLfCwft61nCPVX
 n/NBbkh4uHNUUC/CjtuAokQbW7UQTZu7tv9rUWGkpX3Px2K1MiFXZEzchZTE26af3RZy
 k57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769546; x=1687361546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=256qRxVoRgmn8ZQNw96BSPjzs8Oo5GL3PGwhSL7cRNw=;
 b=jGa+kwnUivsN0UlyBum8r609n9WLig9jdOPFvRJAfm22xRXoClQPLyl8bDk/Lx1xMK
 FXRlQx0HuPNpktlC3Q+vL93BzyA3wA/qkcZNBvXS8+eCSwPwOUGrcCWZRwiOd46nmn1y
 RAffMP1FwcbZG9b8XCH7Cjuvf/M8C37MKCVOk0t6xQgK69SllvklM2gHHcQHFjjT8ik+
 iBEkwACzEsrEnx2g5CEVmHWvCKdSB4sjCa2Vtp6LXHZfZbCjYkrxGQi1CyUCYBGIawM6
 +b4PrtqhUt2pbtSPJFvmTjroqOQdFD5iZNapufjjW0/qRVqLuH3Fibhu8beN3uQueTgO
 HwGw==
X-Gm-Message-State: AC+VfDxWpH476QPo/LHGZtZMQ6h6jv2mtYsxYeXnaJxzUjcCj6QdGfbB
 jEZZMQR3aYZBl022SI4BLyh8ciuft8/VOeLIi7c=
X-Google-Smtp-Source: ACHHUZ4nod3UtzH9pNJ6BVfmAx/Fej6Cz66sTAoSu24l4cQfeNXH5SGQcmVgRqo9cwDkeYxmt+Bklg==
X-Received: by 2002:a7b:cc8e:0:b0:3f6:89a:94c8 with SMTP id
 p14-20020a7bcc8e000000b003f6089a94c8mr658221wma.24.1684769546718; 
 Mon, 22 May 2023 08:32:26 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 18-20020a05600c229200b003f42d8dd7d1sm12078857wmf.7.2023.05.22.08.32.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
Date: Mon, 22 May 2023 17:31:39 +0200
Message-Id: <20230522153144.30610-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/char/pl011.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 98c5268388..f0b305e5d7 100644
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
@@ -504,7 +512,8 @@ static void pl011_reset(DeviceState *dev)
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


