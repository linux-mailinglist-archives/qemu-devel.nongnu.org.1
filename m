Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45437E331F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtV-0002da-FQ; Mon, 06 Nov 2023 21:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtE-0001y6-Pu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtC-00032v-MJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:28 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso34158555ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324345; x=1699929145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2gNhwmPj0KePQvpBSUWI/zoyA5leX7uEdHzTBDBr3Y=;
 b=lAgv6Q7h6guS4c+hfjVrMyL6NwQYlS5FaRng2K+vuTqFXaloj+pIOrk8izG5i9/i6P
 Y19EvKTSXZW/5o0WHtzNvmUgllMokPSuG5mRERUR599fKBcUzKGZnnPzh1epqqztmZEU
 aL/WzFJdbJtuO6pftpMB0wClj04+l01Ql1gn01ONWi/G1yGCbxxIKWQ3gacwgsWubuoe
 Q+AetBM/8KgZsXDVRm7eYmQ5APx8eeiZiikH+UeKcsiXa8+VsDBAdqCv4LeSx056zfGg
 HdLCg1o/6HoNCnxF4wRSZ+w+sYi+WWtTkY7g+1JK/52GuIjSUvLrNsxDxKsNh+lpLw9/
 GOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324345; x=1699929145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2gNhwmPj0KePQvpBSUWI/zoyA5leX7uEdHzTBDBr3Y=;
 b=EyUuPUv9VHCghISfV0NmaXwIgdAA+84wnp4m1FrWk6brDc/hVJ9A2Hnevmtscr+Bbg
 NeGvD72Ln1+e/qqtRM2qUip8rz998Vv2GnT1l0kUNJG69WqpU8sIkVGPml/+ZLoMGxsg
 H5E48c8AYd1xIpYFxM86DsTrpalCLxNCGPriBB3NXDDXjPtV1Kx7xFAQTlpZz8J+a4Ki
 7m2w6XslWcOL+g4cHh+zF6VabOpCOuKSPjUqDhxmNBVSLm4hgZ7RvWg6gsaqUwJdDg4L
 v/sjfEPFGga6LanpxJtys8IdsqlE9tfg6HE9T6CZPLssLFh/Reu3gbInyDUyvyWvh5xN
 JAZw==
X-Gm-Message-State: AOJu0YwA+OcnDGjIn3PsPJd75spv/R01Isyk1PY01AgB16fWlUHtmUSR
 J6mkQV+wXkUa8V5Hxqj3SB5sbelgbxDa0A==
X-Google-Smtp-Source: AGHT+IHv3D8F+QX5KUI47eMVEfNQuzZ0dsdijP9zvOlGTlo/TixDdmh2tWSHbhHxZJMwwlPm9rnGOQ==
X-Received: by 2002:a17:903:10a:b0:1cc:6101:2086 with SMTP id
 y10-20020a170903010a00b001cc61012086mr14258857plc.11.1699324345053; 
 Mon, 06 Nov 2023 18:32:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 43/49] hw/ssi: ibex_spi_host: Clear the interrupt even if
 disabled
Date: Tue,  7 Nov 2023 12:29:39 +1000
Message-ID: <20231107022946.1055027-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair23@gmail.com>

We currently don't clear the interrupts if they are disabled. This means
that if an interrupt occurs and the guest disables interrupts the QEMU
IRQ will remain high.

This doesn't immediately affect guests, but if the
guest re-enables interrupts it's possible that we will miss an
interrupt as it always remains set.

Let's update the logic to always call qemu_set_irq() even if the
interrupts are disabled to ensure we set the level low. The level will
never be high unless interrupts are enabled, so we won't generate
interrupts when we shouldn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231102003424.2003428-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/ssi/ibex_spi_host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 1ee7d88c22..c300ec294d 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -205,9 +205,10 @@ static void ibex_spi_host_irq(IbexSPIHostState *s)
         if (err_irq) {
             s->regs[IBEX_SPI_HOST_INTR_STATE] |= R_INTR_STATE_ERROR_MASK;
         }
-        qemu_set_irq(s->host_err, err_irq);
     }
 
+    qemu_set_irq(s->host_err, err_irq);
+
     /* Event IRQ Enabled and Event IRQ Cleared */
     if (event_en && !status_pending) {
         if (FIELD_EX32(intr_test_reg, INTR_STATE,  SPI_EVENT)) {
@@ -229,8 +230,9 @@ static void ibex_spi_host_irq(IbexSPIHostState *s)
         if (event_irq) {
             s->regs[IBEX_SPI_HOST_INTR_STATE] |= R_INTR_STATE_SPI_EVENT_MASK;
         }
-        qemu_set_irq(s->event, event_irq);
     }
+
+    qemu_set_irq(s->event, event_irq);
 }
 
 static void ibex_spi_host_transfer(IbexSPIHostState *s)
-- 
2.41.0


