Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD757E7254
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:30:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiP-0005l9-LH; Thu, 09 Nov 2023 14:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahw-0005Hf-7R
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:57 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahs-0005Hs-N0
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:51 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so211265866b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558127; x=1700162927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5g0UHLmrzpBXUAHJbDdjYHH8dsW06tpS080WDx/2FO0=;
 b=IF0YNX5h+jeFnwz/GDjs7O7/0TnAwwqWMVtRuFm+oxr74QPr2tw1DvFQoNPk7IikKD
 +GtO0/yFn9XZLMnak2KqH84pgIs28uCQTIydjRvVoKw18luZoqqcx+FLeDyAAhVxLTJ2
 7kmE4BHG6/y/AM89G/PnzA9nWIw6X983rzRvknc8VyLssgUDe5iP6Lj9IZCu8x2qIihp
 B82uKDAPqNhRypiKJesmFuqLIdxQhlPNK6iEB6XZBVeq3dWLzMKuXWulbYIxZ9M/69vN
 Ufgp6fslRTQzZNy/yHz4AMMf7H04UuiAeXbboebDsOUFCBUa6q+6PziHK1VXIVYTG/Eo
 s4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558127; x=1700162927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5g0UHLmrzpBXUAHJbDdjYHH8dsW06tpS080WDx/2FO0=;
 b=rD7GhHDMmD4cGnAZxhrPHYtcsBLieYtVSLAIZunYwTc9wDQVLmNU1f/8UQnX9aj1Gw
 YKf9HRW5vSD94koj5+wwfWpyL7pU43ABhY07LATG91CAoUbn2z+WfVQ+kzP0uK/EqVEV
 jNxAIMtHhoWd86B0HrC08ez+yXduIW/eixMqyGYA+/FIo6jJvslxCm/aeKgPUkftJ1x6
 TLH4jtqk5bkoTbwM3z34ftiHa7699l7C3K8h58FKp0LNS6nFV+YUWl/C0Dipe5hJkEDg
 N1SKijk5atun2HBcGwP94Yd2k2Tw2vZ7zwC2uyliir9PrjQvlgspfxaICXMWWCdIdKpC
 EAgw==
X-Gm-Message-State: AOJu0YyVJRyIpU074O/MGdOPqASkEndDe2ObuzTsLcTr93zcp/I61Wf6
 UEsKVJYIQpfrUR3E6T2GP93gPw4N9uv4mUrppkeGgg==
X-Google-Smtp-Source: AGHT+IG1mIB1epOkXgJaPMduGKGeTPr6W+PS0WSWibBTbSNphDMXSkK+WfnOF/yBf0DY9R9lsFpDqg==
X-Received: by 2002:a17:907:26c9:b0:9d2:ab03:a22d with SMTP id
 bp9-20020a17090726c900b009d2ab03a22dmr4450766ejc.73.1699558126739; 
 Thu, 09 Nov 2023 11:28:46 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 qx11-20020a170906fccb00b009b2f2451381sm2930998ejb.182.2023.11.09.11.28.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-8.2 v4 05/10] hw/char/pl011: Extract pl011_read_rxdata()
 from pl011_read()
Date: Thu,  9 Nov 2023 20:28:09 +0100
Message-ID: <20231109192814.95977-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


