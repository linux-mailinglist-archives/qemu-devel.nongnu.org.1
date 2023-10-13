Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE7F7C878C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItT-0007a4-Pt; Fri, 13 Oct 2023 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItR-0007ZE-Kn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItQ-0004QM-1d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so3767421a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206314; x=1697811114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP8e7F+MNf59pa1iU6FTfmv7Sb18zKeyajADdz6BZOc=;
 b=b3IAmPpAJi5ExYA87/gFCN2PyWuhZLwOoYAKoEkgbr5RtOhpVBptt9ox2Id3DdF+BU
 nAg+QQZCGqpmkgvXe2zRr/TzbILGRWOsjCbsSDle9LKO0lw3Fgz7KQVnyiUGzEK643+O
 IqwnR6pU/6eE+TgBK6Ox1oPG1tPAaseC+cTGKhfA4KMFg9GEaeMXRU5ARB90PyabyDtu
 PwqUmNc0znl4RCqz9PsbYm/kP060uw9QMoE34NNPmi+YmLPg4BmUW6D0IV8f5xm5XTLd
 rtX6iRUCxUA49ElGXD3PsEBx7BvbjyTQA9E4jbi+sUBxPzwpT054dIII3jn5oxALQCNS
 tACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206314; x=1697811114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP8e7F+MNf59pa1iU6FTfmv7Sb18zKeyajADdz6BZOc=;
 b=g+J4JdgCR4y3hVErcPkK1hvibgOIVqHnCHwgxthjSe20WDmfbzqbttiDx3LaesIFl8
 Nh8aoTiCF7/j/bsaScVXNbFe20dNGtLICBLHUTzdpBaYuafrxQGvpn8DXfSVuFB7lWW+
 280N6zh9LcNBRv5sTOE4hOnzbc52gyAQeCTKJ819YKyFO44OCjR8Kwtu4duomvs199OE
 8yOVdiHVN31T0tcFvHYx0i33LnI758i4aWh4RsqSQW0l0vthWHDjQgFvEMxsj/ChtYfs
 FpZ85Am1L7kDgsZtEdOQ44gS+jDfmpHQ47+JfbmpA3xFZ1iwu6jTajTf22oKk6DY0+RA
 t6lg==
X-Gm-Message-State: AOJu0YzOf503Gb5l7nLUa/h5ecekBasr4VIJV9uxfyGO+PHIgI24VzHi
 9QpG4i43CtgPOmDEH+5jTVwtBaAsfV7V4hL5K3Q=
X-Google-Smtp-Source: AGHT+IExARe8cmT7qMsM4N8ibsiGIRXeLVCI/BwunDKJ2ZRg0DcHHcF4d3iglFSwM5QKEdoLjFkasw==
X-Received: by 2002:a50:c047:0:b0:53e:3b8f:8ce1 with SMTP id
 u7-20020a50c047000000b0053e3b8f8ce1mr2139072edd.23.1697206314358; 
 Fri, 13 Oct 2023 07:11:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a50f605000000b0053dd798e38asm3529569edn.69.2023.10.13.07.11.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:11:53 -0700 (PDT)
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
Subject: [PATCH v3 3/10] hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
Date: Fri, 13 Oct 2023 16:11:24 +0200
Message-ID: <20231013141131.1531-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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
2.41.0


