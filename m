Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F014D747485
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNI-0004cn-Gu; Tue, 04 Jul 2023 10:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMw-0004CQ-6V
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMt-00036p-75
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so6334781f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482261; x=1691074261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDbZi+FugjgWhilKkMiEZjysEFMTjfONCoSIxxTN6sY=;
 b=Cf31yA0rPCjRrlKVGtc1E7y9DsccYWcUESQjyLath1r2cZniaPx3hntbzaqVcsGwna
 8vPKoruKH5ImwitIN/gfVxOQfTttNiSeOcGAD5d2V6GffczXEOg8VcXzR/CLHXBcj4Ew
 EOj4m7vRMfiOfM+o57OEqfllLZNrOedU6bzV0r7ohxoNVydF+J4DfwIaNntJaowFCRqE
 e9tYLqi2ipjgqoZCbZ/PLXHSDLvWbC59Yb8TgGaECtFDPBPYUQEhIxmLWPpdK13Lg4bJ
 zyEOjqMXBba8k5seb8Yw0/pHnal7nBGyb2BuAMuyUxNoWx4E/U47wqNSfmb7h7xmmmz6
 tAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482261; x=1691074261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDbZi+FugjgWhilKkMiEZjysEFMTjfONCoSIxxTN6sY=;
 b=TISdcERJFJvq20UHzv22rCDz3X1WHNrYK998z3sxkLfbl+BbDE1jNepXD6MNQrbDpq
 MuRyRiS/m4aNylxdYo7YQe4AE0KwzTxHNeI6oId11gSYoE+fl4/0klJ0FW4tgyYbrkgJ
 NfqjVp0N9FWxRsFpHlqYfbpZoUYF4FHMB/bf0q3rhJZrrSzMnW6UX2jaLEjdTzq8CRk8
 LQOUkMDkmKfrLE8xVhc61sp+y+c4eKX/KepiEYHemGbg4YdmBLZ63xChKxsZxZq4lfdG
 7kNgUXE6UsM+/8UNmpMn1WdS+Czsyd6MFXGW48TM7U8eCuKua0Y72SRPoAfKH+DQlM+3
 IPWA==
X-Gm-Message-State: ABy/qLZ4xka6+Uy2QbdTfG2LoljZCDbo1XLqw0Dv/5Xa2NKtBRJgn5RY
 LD8gi4Lf/3cDlFsLUAhaSYHW3GGVb8MQdbyER3k=
X-Google-Smtp-Source: APBJJlEY4N5yyEuM/5AjTjSGmqQt/OPVnh8C01Yovf5M8YVJVKvLdWSvbKN9BfWh32YQ5sIhNSmnqw==
X-Received: by 2002:adf:ef4e:0:b0:314:25c6:7f6d with SMTP id
 c14-20020adfef4e000000b0031425c67f6dmr10401009wrp.14.1688482261685; 
 Tue, 04 Jul 2023 07:51:01 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a5d5951000000b00313f61889ecsm22420188wri.66.2023.07.04.07.51.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/19] hw/timer/arm_timer: Convert read/write handlers to
 MemoryRegionOps ones
Date: Tue,  4 Jul 2023 16:50:02 +0200
Message-Id: <20230704145012.49870-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In order to simplify the QOM convertion of ARM_TIMER in a few
commits, start converting the read/write() handlers to follow
the MemoryRegionOps::read/write() prototypes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 0d7fac4d78..cbd82e8365 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -50,7 +50,7 @@ static void arm_timer_update(ArmTimer *s)
     }
 }
 
-static uint32_t arm_timer_read(void *opaque, hwaddr offset)
+static uint64_t arm_timer_read(void *opaque, hwaddr offset, unsigned size)
 {
     ArmTimer *s = opaque;
 
@@ -97,7 +97,7 @@ static void arm_timer_recalibrate(ArmTimer *s, int reload)
 }
 
 static void arm_timer_write(void *opaque, hwaddr offset,
-                            uint32_t value)
+                            uint64_t value, unsigned size)
 {
     ArmTimer *s = opaque;
     int freq;
@@ -233,10 +233,10 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
     SP804Timer *s = opaque;
 
     if (offset < 0x20) {
-        return arm_timer_read(s->timer[0], offset);
+        return arm_timer_read(&s->timer[0], offset, size);
     }
     if (offset < 0x40) {
-        return arm_timer_read(s->timer[1], offset - 0x20);
+        return arm_timer_read(&s->timer[1], offset - 0x20, size);
     }
 
     /* TimerPeriphID */
@@ -265,12 +265,12 @@ static void sp804_write(void *opaque, hwaddr offset,
     SP804Timer *s = opaque;
 
     if (offset < 0x20) {
-        arm_timer_write(s->timer[0], offset, value);
+        arm_timer_write(&s->timer[0], offset, value, size);
         return;
     }
 
     if (offset < 0x40) {
-        arm_timer_write(s->timer[1], offset - 0x20, value);
+        arm_timer_write(&s->timer[1], offset - 0x20, value, size);
         return;
     }
 
@@ -356,7 +356,7 @@ static uint64_t icp_pit_read(void *opaque, hwaddr offset,
         return 0;
     }
 
-    return arm_timer_read(s->timer[n], offset & 0xff);
+    return arm_timer_read(&s->timer[n], offset & 0xff, size);
 }
 
 static void icp_pit_write(void *opaque, hwaddr offset,
@@ -371,7 +371,7 @@ static void icp_pit_write(void *opaque, hwaddr offset,
         return;
     }
 
-    arm_timer_write(s->timer[n], offset & 0xff, value);
+    arm_timer_write(&s->timer[n], offset & 0xff, value, size);
 }
 
 static const MemoryRegionOps icp_pit_ops = {
-- 
2.38.1


