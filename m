Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B365674748A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNH-0004Lw-NI; Tue, 04 Jul 2023 10:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMf-0003qQ-Rv
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMc-00030D-MU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31441dfbf97so654289f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482241; x=1691074241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Y5uqlDug0UobussbvEXXtJ8MTJBYQAz+WAikQsGjjQ=;
 b=o6pc1i4aj2XtKjBy5fZWG3Orj80SurirteIzW0tn7W4IHP847n4GgQmaP3CybCNP54
 rKYbvQJwET6k9wp7iGZp8Tf3w/u4Ws4Cs6sXelAQZdssOWcPrmPwzrPZvHlezcf3nitp
 /0W856tsLHUPwyiLvC/CZd6Ip83Yq8kxeAyJxE0Gg9Qf+gAXHu0yyPiegRYMuf+3c5ZI
 z0DSCyGHl2w5Y/XRWByRvsfX0BYm+0lTHri7ohSjScG9QWmYAbuho30PD0DkcJOmOnWq
 2PuVbos05BZOTYUpcr7sip25Q8Jy4JOuK8XfTu9Tzxj/LJzYcW8IUZOe9WgEx9u3xRJw
 /xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482241; x=1691074241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Y5uqlDug0UobussbvEXXtJ8MTJBYQAz+WAikQsGjjQ=;
 b=RfMnf889bRJqN0M4OYBlj0GgTn0/K7n1m6nl4MoVC+A8AkNFtv/lIrIHTS+kVx45sX
 u//hq4LugNCqHA1EYro9v1r0fBviio+ygSrhzlABuyLXvG8iJjERFfmg7Kx9tA79dTSw
 EbiqJU+JYES+MfVFXc14shHtIJbzkZCeGZPhNUKTTuEmoRmVR7IQaY10CLn6FkS8mMHy
 ohjVXIYy2fL5svd0PVCtHwXpApJR4fNuDBszLCJFb/ZSGSrwWQ06/Zlv6DJF1YdvUGsq
 7kDsPcud75NJFfiqyqEanOoiz+KQK0GfRJjNtCYwDjEXReBt8NBQj6QB8ZIlMjnLdx/W
 eErA==
X-Gm-Message-State: ABy/qLYEp/ejDRtDhbAdqc7jG/Iv4NvHk4R+Pd/m4Dqr5FVYTgJVqy5c
 uUlAbZsJHftD8j6FWggnm56fbyo2kOGKx2wOxbQ=
X-Google-Smtp-Source: APBJJlGeWPzJmluAz7qI6s2cErWujtpobdUfliGHmFB1Aypvw6+pEYvLGkHNKMRCt+z7nDuirJJSKg==
X-Received: by 2002:adf:ea45:0:b0:313:e88d:e6cf with SMTP id
 j5-20020adfea45000000b00313e88de6cfmr11670620wrn.69.1688482240899; 
 Tue, 04 Jul 2023 07:50:40 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 s7-20020adfeb07000000b0030ae901bc54sm28426750wrn.62.2023.07.04.07.50.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/19] hw/timer/arm_timer: CamelCase rename arm_timer_state
 -> ArmTimer
Date: Tue,  4 Jul 2023 16:49:58 +0200
Message-Id: <20230704145012.49870-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Following docs/devel/style.rst guidelines, rename arm_timer_state
as ArmTimer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index c741e89cb4..8a2939483f 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -36,11 +36,11 @@ typedef struct {
     int freq;
     int int_level;
     qemu_irq irq;
-} arm_timer_state;
+} ArmTimer;
 
 /* Check all active timers, and schedule the next timer interrupt.  */
 
-static void arm_timer_update(arm_timer_state *s)
+static void arm_timer_update(ArmTimer *s)
 {
     /* Update interrupts.  */
     if (s->int_level && (s->control & TIMER_CTRL_IE)) {
@@ -52,7 +52,7 @@ static void arm_timer_update(arm_timer_state *s)
 
 static uint32_t arm_timer_read(void *opaque, hwaddr offset)
 {
-    arm_timer_state *s = opaque;
+    ArmTimer *s = opaque;
 
     switch (offset >> 2) {
     case 0: /* TimerLoad */
@@ -79,7 +79,7 @@ static uint32_t arm_timer_read(void *opaque, hwaddr offset)
  * Reset the timer limit after settings have changed.
  * May only be called from inside a ptimer transaction block.
  */
-static void arm_timer_recalibrate(arm_timer_state *s, int reload)
+static void arm_timer_recalibrate(ArmTimer *s, int reload)
 {
     uint32_t limit;
 
@@ -99,7 +99,7 @@ static void arm_timer_recalibrate(arm_timer_state *s, int reload)
 static void arm_timer_write(void *opaque, hwaddr offset,
                             uint32_t value)
 {
-    arm_timer_state *s = opaque;
+    ArmTimer *s = opaque;
     int freq;
 
     switch (offset >> 2) {
@@ -154,7 +154,7 @@ static void arm_timer_write(void *opaque, hwaddr offset,
 
 static void arm_timer_tick(void *opaque)
 {
-    arm_timer_state *s = opaque;
+    ArmTimer *s = opaque;
     s->int_level = 1;
     arm_timer_update(s);
 }
@@ -164,19 +164,19 @@ static const VMStateDescription vmstate_arm_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(control, arm_timer_state),
-        VMSTATE_UINT32(limit, arm_timer_state),
-        VMSTATE_INT32(int_level, arm_timer_state),
-        VMSTATE_PTIMER(timer, arm_timer_state),
+        VMSTATE_UINT32(control, ArmTimer),
+        VMSTATE_UINT32(limit, ArmTimer),
+        VMSTATE_INT32(int_level, ArmTimer),
+        VMSTATE_PTIMER(timer, ArmTimer),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static arm_timer_state *arm_timer_init(uint32_t freq)
+static ArmTimer *arm_timer_init(uint32_t freq)
 {
-    arm_timer_state *s;
+    ArmTimer *s;
 
-    s = g_new0(arm_timer_state, 1);
+    s = g_new0(ArmTimer, 1);
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
 
@@ -198,7 +198,7 @@ struct SP804State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    arm_timer_state *timer[2];
+    ArmTimer *timer[2];
     uint32_t freq0, freq1;
     int level[2];
     qemu_irq irq;
@@ -333,7 +333,7 @@ struct IntegratorPIT {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    arm_timer_state *timer[3];
+    ArmTimer *timer[3];
 };
 
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
-- 
2.38.1


