Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D115747484
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhMN-0003Wj-QD; Tue, 04 Jul 2023 10:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMK-0003Vg-Lf
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMJ-0002sp-1O
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso5549999f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482225; x=1691074225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgvgFhMQ/riqnKFVtebpDqRyF4pQ1AQW92hIbSGCdrk=;
 b=Cmdzf5TXLSsWUoR/Hafj/B0KWySChgK/PNunWw/mHFR5RmEZLC1y7Wau4Qgx4+xr09
 Q8b40VVBUZWyRzE12wsuNZSMqqXU/E9cq/Bx0RGrYBvIJWo7Gv5hw+Ctd/YoPbCGx+Q+
 1e25zjGIHqBZG4Vp7Icb2t2SUlnjCoTcsKbxCxeii1qw6UpKgNGwl65FxkTBddJd0gNe
 3LmHAHBTnLnS0x9pY7Q7J4IJPGo1IwK+9X08s5+UK3JrajZiJUDGkVpKt1MgtO0vpfNB
 lKVPfEpGVjPzFFetdOqb0KyM7QFN64R/+0iiU0Xl7rHFktp9Zb9cqI7u7Sk/xzGriSy7
 reCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482225; x=1691074225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgvgFhMQ/riqnKFVtebpDqRyF4pQ1AQW92hIbSGCdrk=;
 b=Xu+l4T/Rlou630eTJIhLgaYlHpp5rRiFqP288plZlt62hjqaBaqxEhX6jWAizz2pT0
 Jkm2VzczppCDKe6Jf1c/POztEZWLBGVH6hWQEwAO4emkUDwsk56P61oYuj4641FW3FxA
 MMJzh+jn4MBK0fwU0qK8EK/iyNpl9lxyE1wJTgvqQIeD5nzCbmuvw6TXeTI+WJ+0sXAH
 yMxvYb0NMpMo/ZOvG+mbXRGluQiPLlCASjgoTQ3bOzqA2C6eTJZJiL9PPibdh8Y9FFJp
 bOQsRYpHtolb7l6SCfMGvH7WLsQWB+ICNR13IstAWtezT9f2U/1aSGDhijlGnM61QFKr
 JtAQ==
X-Gm-Message-State: ABy/qLYAT/CfHniYRpvzkstEROTn5wzkhpY1XJomoksFRUcVE7LfZxFb
 SnkI3elecxIA8u8ncFGAxH1aG5Ly4xGCWZCt6cE=
X-Google-Smtp-Source: APBJJlFLRVECZGukm5KvGAeVtgBy/IN2Kez9YPu/1c9XE4xf6N1Jh69CioTRcqDe1ZCf4VBsFA5Png==
X-Received: by 2002:adf:e40d:0:b0:314:13e2:2f78 with SMTP id
 g13-20020adfe40d000000b0031413e22f78mr11874181wrm.44.1688482225494; 
 Tue, 04 Jul 2023 07:50:25 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff845000000b003141b9ddab3sm13596392wrq.114.2023.07.04.07.50.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/19] hw/timer/arm_timer: Remove pointless cast from void *
Date: Tue,  4 Jul 2023 16:49:55 +0200
Message-Id: <20230704145012.49870-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index e410b37a23..30a34a9a92 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -52,7 +52,7 @@ static void arm_timer_update(arm_timer_state *s)
 
 static uint32_t arm_timer_read(void *opaque, hwaddr offset)
 {
-    arm_timer_state *s = (arm_timer_state *)opaque;
+    arm_timer_state *s = opaque;
 
     switch (offset >> 2) {
     case 0: /* TimerLoad */
@@ -99,7 +99,7 @@ static void arm_timer_recalibrate(arm_timer_state *s, int reload)
 static void arm_timer_write(void *opaque, hwaddr offset,
                             uint32_t value)
 {
-    arm_timer_state *s = (arm_timer_state *)opaque;
+    arm_timer_state *s = opaque;
     int freq;
 
     switch (offset >> 2) {
@@ -154,7 +154,7 @@ static void arm_timer_write(void *opaque, hwaddr offset,
 
 static void arm_timer_tick(void *opaque)
 {
-    arm_timer_state *s = (arm_timer_state *)opaque;
+    arm_timer_state *s = opaque;
     s->int_level = 1;
     arm_timer_update(s);
 }
@@ -214,7 +214,7 @@ static const uint8_t sp804_ids[] = {
 /* Merge the IRQs from the two component devices.  */
 static void sp804_set_irq(void *opaque, int irq, int level)
 {
-    SP804State *s = (SP804State *)opaque;
+    SP804State *s = opaque;
 
     s->level[irq] = level;
     qemu_set_irq(s->irq, s->level[0] || s->level[1]);
@@ -223,7 +223,7 @@ static void sp804_set_irq(void *opaque, int irq, int level)
 static uint64_t sp804_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
-    SP804State *s = (SP804State *)opaque;
+    SP804State *s = opaque;
 
     if (offset < 0x20) {
         return arm_timer_read(s->timer[0], offset);
@@ -255,7 +255,7 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
 static void sp804_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
-    SP804State *s = (SP804State *)opaque;
+    SP804State *s = opaque;
 
     if (offset < 0x20) {
         arm_timer_write(s->timer[0], offset, value);
@@ -324,7 +324,7 @@ struct icp_pit_state {
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
                              unsigned size)
 {
-    icp_pit_state *s = (icp_pit_state *)opaque;
+    icp_pit_state *s = opaque;
     int n;
 
     /* ??? Don't know the PrimeCell ID for this device.  */
@@ -340,7 +340,7 @@ static uint64_t icp_pit_read(void *opaque, hwaddr offset,
 static void icp_pit_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    icp_pit_state *s = (icp_pit_state *)opaque;
+    icp_pit_state *s = opaque;
     int n;
 
     n = offset >> 8;
-- 
2.38.1


