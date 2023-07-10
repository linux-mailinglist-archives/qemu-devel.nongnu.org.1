Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6974DCC9
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:52:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv3C-0001Bh-Rp; Mon, 10 Jul 2023 13:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3A-00018t-1u
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv37-0000S3-UI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso49508965e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011506; x=1691603506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OE5HK+6QzUc16kbWLHpwXHz/gljwcqm0t8YsiPIa+LE=;
 b=tsYQMg2NbC33ht6evJmCGeSa7UL/wN88thUqyVnXUKJhrqDGOgovZaK9R1khey0t0V
 PyoJRqKvVn/Yd+cPopI/5dvF2h0qS5Ezd/Im1smwkUbk3OpqrpR/tvk+ug/CPleCD2jn
 y7HspVdPfjr3jxxW0PKb706nk6VeyCqGidMkvB8pZg1HmAr7Runxp9kYODIH9pRBPijk
 1ye/EBtVY9Q3/iQoNRVFuJG2wpbpVmTtigFlfhCCHW8XjN3GJLKryA6px8DXBb79ley3
 0UqHyj1HLgdz1Den5lROTV5lGe0ApSKERlghFJHMykkaTtvmVczV0Al6RPPofYkiu2uA
 XjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011506; x=1691603506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OE5HK+6QzUc16kbWLHpwXHz/gljwcqm0t8YsiPIa+LE=;
 b=fAi9dHOHg8Tci4zHaKnPF/2VvPAG4HWR976FbaMdSilumrYP8WvzJX/Cd42RGexcef
 TDO0eYTV5F4gt0zDDZ0A4c7qbTkSiiRUnI85iVCgcjNkFzdO1Bak338zZt6DxgL+ehET
 nLY4D3/LF90cX1E8bp6ptvqs8APzTwnqyGBuLRoSBogHAAtmgcG7WU8kVfGpc3dB8ej6
 IgXI8kwCDesQujJZnfN5TGXgJ37LKx0mrEoDcUfHZD9HXOn/0CrQhWb3KmXFaBd//1yj
 YtZ1Eu+LkLThIccqtEuIA9NW3pAxbJQ9iu3HelPu8dkpi/G7tPVcX3iHTC2/n0WiaZtZ
 f3rg==
X-Gm-Message-State: ABy/qLYaJNeooWxP3wfy1VQRXUnNjy8OKksnnuAz+MFM4yaFKeZ6TDw4
 gEV5AtM7am8Q5Fcw3BlBgMbALHx7tI9wPlO1ecF5Jw==
X-Google-Smtp-Source: APBJJlGTvuvn6A71yE7i5fL3LrX5XO9YvpLbbataZS1IeAugak+MoNlv7E7GWVtCndLHD/YCKFEzhQ==
X-Received: by 2002:a7b:c5d0:0:b0:3fb:b008:1ff6 with SMTP id
 n16-20020a7bc5d0000000b003fbb0081ff6mr10921652wmk.0.1689011506342; 
 Mon, 10 Jul 2023 10:51:46 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 k12-20020a7bc30c000000b003fba92fad35sm10908860wmj.26.2023.07.10.10.51.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/11] hw/char/pl011: Extract pl011_read_rxdata() from
 pl011_read()
Date: Mon, 10 Jul 2023 19:50:58 +0200
Message-Id: <20230710175102.32429-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

To keep MemoryRegionOps read/write handlers with similar logic,
factor pl011_read_txdata() out of pl011_read(), similar to the
previous commit did to pl011_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 7bc7819d8b..e2e3d48b91 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -160,31 +160,37 @@ static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
     pl011_update(s);
 }
 
+static uint32_t pl011_read_rxdata(PL011State *s)
+{
+    uint32_t c;
+
+    s->flags &= ~PL011_FLAG_RXFF;
+    c = s->read_fifo[s->read_pos];
+    if (s->read_count > 0) {
+        s->read_count--;
+        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
+    }
+    if (s->read_count == 0) {
+        s->flags |= PL011_FLAG_RXFE;
+    }
+    if (s->read_count == s->read_trigger - 1)
+        s->int_level &= ~ INT_RX;
+    trace_pl011_read_fifo(s->read_count);
+    s->rsr = c >> 8;
+    pl011_update(s);
+    qemu_chr_fe_accept_input(&s->chr);
+    return c;
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
     PL011State *s = (PL011State *)opaque;
-    uint32_t c;
     uint64_t r;
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        s->flags &= ~PL011_FLAG_RXFF;
-        c = s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
-        }
-        if (s->read_count == 0) {
-            s->flags |= PL011_FLAG_RXFE;
-        }
-        if (s->read_count == s->read_trigger - 1)
-            s->int_level &= ~ INT_RX;
-        trace_pl011_read_fifo(s->read_count);
-        s->rsr = c >> 8;
-        pl011_update(s);
-        qemu_chr_fe_accept_input(&s->chr);
-        r = c;
+        r = pl011_read_rxdata(s);
         break;
     case 1: /* UARTRSR */
         r = s->rsr;
-- 
2.38.1


