Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5128937C2E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 20:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs50-00039d-SO; Fri, 19 Jul 2024 14:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4e-0002Qd-AS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4b-0003ok-Mp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso13005545e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412675; x=1722017475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBQBL5W8xgFprC/jppYzPypv2gfWoCKhxuevh4igzXc=;
 b=cHDup4H5TPWAimxswXCit7TSGbrQixMkYckcWu8Lqxk8n3YDSE+HGcFpvaaaIdXf+T
 LwOYwyQfqRzoVBjpJ3pWNFdEPpY7lmm0Br1KxonT4+PuCkRPu8rsdG06nwcPPGitjTEw
 rFk779FCoXpXYMrCHvVBHSquRXFij60RK2EUuBO6IdD4Lgwp1NNYQOLZcauPZJsrmNV3
 KqOuFGQkLNvv4n7wEAa2xHyn39P4QdnrEna/KWPIj8gtM+yUk/0mernOWHbmAQhpiBlj
 BLMt2AZKDRE6YTxicO3hvRvc+HqCQM7nxUAibI2HXV6dFhV2NMxo4GNVwEUioTsqQxT4
 HJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412675; x=1722017475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBQBL5W8xgFprC/jppYzPypv2gfWoCKhxuevh4igzXc=;
 b=eNnG38kKE0pp8/+RjsZOUxnuxgdmhDbSmTenTolcy+PDdSzFpX32vMplfStZtB5fE6
 ZU8hnL8+CrZIB+ZovGGbekc1xKVjqvA/QsuFxhp4mgsdAG7FdmezVqVPgUjieVowDlFO
 YxhMuzeG0IRL0LCwNJzCAyHUzR21lvzHCKYi062tAyJWHXlWTlShzkBPtTiVSoqsS7sy
 2GF9VGjD12pfe6FJUCz7PxHmV7nARN930GuJyCnvQKcnoFpBjzex6ZsCZlqL5m+vvVyI
 mn+uyhvKwA+5r+NegBm4SzbgKrcJTmqtbDAkcnPwejR34YmHdo5MZnC1cc5p5tCcZlnb
 Pv1Q==
X-Gm-Message-State: AOJu0Yypf88jwb3oqODMtkDQ3Ro58IvKahruqUfZ1Shbq0cCUSDaMzYR
 dhq8ahi4o90yCTuGgRP8qo9WuEc+OQcxMzaUin2AhAPUewcmz0s+9DTvZxvaVV4+mJAgz68aKwC
 L
X-Google-Smtp-Source: AGHT+IEysGjoyWG5B0bnxVXXcnsANlfCGJXyjeCLaHK/FKL5YC0n2UXZrK+Ipy734mbaFpWO48MaKg==
X-Received: by 2002:a5d:58da:0:b0:368:65a0:a423 with SMTP id
 ffacd0b85a97d-36865a0a82amr3024174f8f.27.1721412674957; 
 Fri, 19 Jul 2024 11:11:14 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94c0dsm59991275e9.46.2024.07.19.11.11.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 05/16] hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
Date: Fri, 19 Jul 2024 20:10:30 +0200
Message-ID: <20240719181041.49545-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 22195ead7b..3d294c3b52 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -154,14 +154,21 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
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
 
 static void pl011_put_fifo(void *opaque, uint32_t value)
@@ -410,7 +417,8 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
-            pl011_reset_fifo(s);
+            pl011_reset_rx_fifo(s);
+            pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
             int break_enable = value & LCR_BRK;
@@ -619,7 +627,8 @@ static void pl011_reset(DeviceState *dev)
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0;
-    pl011_reset_fifo(s);
+    pl011_reset_rx_fifo(s);
+    pl011_reset_tx_fifo(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


