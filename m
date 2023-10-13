Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8047C8790
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItl-0000CI-Ry; Fri, 13 Oct 2023 10:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIti-0008JR-LE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIth-0004Y0-30
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so3764885a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206331; x=1697811131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5g0UHLmrzpBXUAHJbDdjYHH8dsW06tpS080WDx/2FO0=;
 b=LbR4l6wh4PeuIsGyPnZOBHs/BTmVrry41/p4vuPe+zq5cnbuno+NLxKAo1rvpdhFrR
 bNsGlEf7ptEkDoMqCmYO2PWR4cFSC4/R9xzz+hnjOV7p1Dm1Hox9nLiuiogsRe5kjaYo
 i1IZd9yViATOLSwQdx519DHWmamyONFlI1n+tyn5ZtGEvHrjHzxH9oORk++EexRKLPcm
 Q+3QSoi86bkEa2uNcfKMSBFf0o/TBV6Gfz3K6OhNU8Vxie0IHuCusmcwb3ZtbY4qEYtk
 Xa52P2mbxd2is6lJ+jD2G+m8RbYP7UlRk9EdwavW9vV6I6miq2Dd1fXia8C2bEB9FXWa
 lgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206331; x=1697811131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5g0UHLmrzpBXUAHJbDdjYHH8dsW06tpS080WDx/2FO0=;
 b=vt1ddHcZI/C3tLeXswGYQzNN25lTEQU5cr1vkm99W0CCypR0rHDA5DUUjLyMRvR/wF
 ztlHOLdl8N4bfuL60ZgJTEvsDoyFLZvPS2CchCZkxPO4Xfvp+bosr4PpA/znWbn8dj+g
 dnx00/66ntHTF8qZKxKGR0fqQYwD9Fur6m3y3gkZ8O8EabWOPdhXv3BWU2P3/lBdVqaa
 0uCXrHQW4sNtbGBUvbO7VhxhE/NDWI02PbBqOPbuW/h83UyDApF8okw7IuUq9sday18G
 G0SevxlwvexkSBKYLnHK8VVix3YfgfbWnMAI8Ds3bteCmvGUdaVEXgu9B9oHKqu9ZO/Y
 dmRw==
X-Gm-Message-State: AOJu0YzLdPHUhlCGdIKUFSqhExN0G3ftnqAh69QbDyI3haakBQ0MMi23
 XgpOPbr0W01vYGWznZjDk3crXHcdRSawkm5WT6Q=
X-Google-Smtp-Source: AGHT+IEU0+VaJj644Dxa8lEx1bgYoJG65nDixpQ3I5LhB91q96hBCxy+8t0gQFmYrSDIts+JZpp4YQ==
X-Received: by 2002:a17:907:a0c7:b0:9ba:33ef:fe51 with SMTP id
 hw7-20020a170907a0c700b009ba33effe51mr9836619ejc.11.1697206331196; 
 Fri, 13 Oct 2023 07:12:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 jw5-20020a170906e94500b009ae6a6451fdsm12419392ejb.35.2023.10.13.07.12.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:12:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/10] hw/char/pl011: Extract pl011_read_rxdata() from
 pl011_read()
Date: Fri, 13 Oct 2023 16:11:26 +0200
Message-ID: <20231013141131.1531-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To keep MemoryRegionOps read/write handlers with similar logic,
factor pl011_read_txdata() out of pl011_read(), similar to what
the previous commit did to pl011_write().
No functional change intended.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1cb9015ea2..30309337b1 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -160,31 +160,38 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
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
+    if (s->read_count == s->read_trigger - 1) {
+        s->int_level &= ~ INT_RX;
+    }
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
2.41.0


