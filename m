Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0534382572A
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTU-0003NK-Hy; Fri, 05 Jan 2024 10:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSZ-0000of-EJ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSW-0001ES-F3
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:10 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336897b6bd6so1525530f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469806; x=1705074606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nno3VTCeo04e35HOY3p6uYOV1tAtecR5ZW2yhenY0Bs=;
 b=WincsaJJFH6/ydoWKzmDqEwadD24rT25SUPVLUTA2MOp2iyLtBxtrbgYvSnA+4cWEf
 C0LfAd4J2UhnX2wfrrTp3z7weXamxReN5VujcADpZJ5LYhwVJV1LPWRH77nwU1WtMOkf
 7FtdzEcLWsNhbkBG6FNJ0ogpHrSl7LxL8mLhbqy29U0UZDgjvsqAqQ4N35PoqlODXJ1d
 CIbgnFXKKvnAA4FgZNwrJkd2ahJPqsZVWt8VCSUXS0ryZ6KnXhz8/4yANRdiw7SiUTNZ
 N2sZQni3D46JyI4hDbjUMpBpR4YoqyN34KLbp3D3kTbw5gc8Dd3xaygryrcbPS1ZNMQv
 0mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469806; x=1705074606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nno3VTCeo04e35HOY3p6uYOV1tAtecR5ZW2yhenY0Bs=;
 b=cuBSLQwnitoxvuw36mG7IYKD6w1pcNkOha2r7E54gy9c8iIMpMXeQJlzbiGhlcNDrX
 Ttx2LHyk1+yWjTf833fwQ+BZcgqOY5hhvdU2uH8+Fk+WbOR3qKkITZ4gUBryKR+ocML4
 ObIJSIXwrdxeDO/UCBgJcq3kKC71fC+WiCYrQgT0HIozto/WmauAmGbZB9I1rfaMDtaW
 5kMaSLomt+W+FUEurdq7eLvYJbdPoT3I6N0F334cRn1a+3Vq8h+BKRWMwAEtpq9oyle2
 kmgBlqYjPT9w/E5TBZG3IxOwMKoviJad9HVohpImQBuqSznUIbmjh7ZMQ73ucTpaNjPQ
 BoLg==
X-Gm-Message-State: AOJu0Ywd+BKF80kGaseEX9fz1+v5mf7s+mnaOOw4f8gtFBVUiayW1YoA
 wraZrLigdycM7E7ITvM3XtDnuWjaSVQw9Z1Wkx+tk33YLp8=
X-Google-Smtp-Source: AGHT+IEDuBvHeDIQ6nmVzWRN2hi01IK23e06MHcHgOCGbKhDhedlo9shD8BOBcquIQOvAU/u1hsECw==
X-Received: by 2002:a5d:62d0:0:b0:337:5cf8:b12a with SMTP id
 o16-20020a5d62d0000000b003375cf8b12amr235231wrv.135.1704469806693; 
 Fri, 05 Jan 2024 07:50:06 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 q9-20020a05600000c900b003367eae8e18sm1623623wrx.57.2024.01.05.07.50.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:50:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 69/71] hw/m68k/mcf5206: Embed m5206_timer_state in
 m5206_mbar_state
Date: Fri,  5 Jan 2024 16:43:02 +0100
Message-ID: <20240105154307.21385-70-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Thomas Huth <huth@tuxfamily.org>

There's no need to explicitely allocate the memory here, we can
simply embed it into the m5206_mbar_state instead.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231221122939.11001-1-huth@tuxfamily.org>
---
 hw/m68k/mcf5206.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a46a23538d..183fd3cc08 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -148,15 +148,11 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
     m5206_timer_update(s);
 }
 
-static m5206_timer_state *m5206_timer_init(qemu_irq irq)
+static void m5206_timer_init(m5206_timer_state *s, qemu_irq irq)
 {
-    m5206_timer_state *s;
-
-    s = g_new0(m5206_timer_state, 1);
     s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_LEGACY);
     s->irq = irq;
     m5206_timer_reset(s);
-    return s;
 }
 
 /* System Integration Module.  */
@@ -167,7 +163,7 @@ typedef struct {
     M68kCPU *cpu;
     MemoryRegion iomem;
     qemu_irq *pic;
-    m5206_timer_state *timer[2];
+    m5206_timer_state timer[2];
     DeviceState *uart[2];
     uint8_t scr;
     uint8_t icr[14];
@@ -293,9 +289,9 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
                                 uint16_t offset, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
-        return m5206_timer_read(s->timer[0], offset - 0x100);
+        return m5206_timer_read(&s->timer[0], offset - 0x100);
     } else if (offset >= 0x120 && offset < 0x140) {
-        return m5206_timer_read(s->timer[1], offset - 0x120);
+        return m5206_timer_read(&s->timer[1], offset - 0x120);
     } else if (offset >= 0x140 && offset < 0x160) {
         return mcf_uart_read(s->uart[0], offset - 0x140, size);
     } else if (offset >= 0x180 && offset < 0x1a0) {
@@ -333,10 +329,10 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
                              uint64_t value, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
-        m5206_timer_write(s->timer[0], offset - 0x100, value);
+        m5206_timer_write(&s->timer[0], offset - 0x100, value);
         return;
     } else if (offset >= 0x120 && offset < 0x140) {
-        m5206_timer_write(s->timer[1], offset - 0x120, value);
+        m5206_timer_write(&s->timer[1], offset - 0x120, value);
         return;
     } else if (offset >= 0x140 && offset < 0x160) {
         mcf_uart_write(s->uart[0], offset - 0x140, value, size);
@@ -598,8 +594,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
     s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
-    s->timer[0] = m5206_timer_init(s->pic[9]);
-    s->timer[1] = m5206_timer_init(s->pic[10]);
+    m5206_timer_init(&s->timer[0], s->pic[9]);
+    m5206_timer_init(&s->timer[1], s->pic[10]);
     s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
     s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
 }
-- 
2.41.0


