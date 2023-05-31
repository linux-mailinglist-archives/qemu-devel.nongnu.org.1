Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84358718B47
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SYi-0007oI-Qq; Wed, 31 May 2023 16:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYh-0007m2-6C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYf-00036b-EH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso1169305e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565396; x=1688157396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVO2YZhj70IQRx0DkEHrVUKir9ojXgRvhsJpsCyyon4=;
 b=YXn2bcH5uNzpFH5D4BGle4BmG26lHQu3zC1bbGEbm2HtI/SAaiSVGQtuIRNz+XkJE9
 n3VMnM8nutiKJgFg0IukIhC67AEe7H3UJqGj1l41sQYA1KccB21G7bCYQzKbQ3kjZwDo
 GWoogoWVDhgDKhNHFmUlpvf/IT0fqSmT+FpJDp2hf8hYuFIV2frU4KfUvEsGopOgeNow
 /a4MNHwzvbqnccCc4qksV+dIyR1iyvQ771WgaTM6IVlHr3buvzbl9k1jDjcAT9cdxV59
 28trj1mIrYvFJFJSOhgB9gQciU+neFjtoOpppWNYGgl6NjDRPfcAkja/qd41rfUNhDaQ
 zPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565396; x=1688157396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVO2YZhj70IQRx0DkEHrVUKir9ojXgRvhsJpsCyyon4=;
 b=NiAF/eOIfwqlVeTXC6d6pxKaqs19ZB+vTLaSe+IZEr9rupKQ12drMjst5HgRfSJrls
 sKmqDc16wcLPktkMEXPR6caWAOUNcFnmvktJ8N/RephEpuhsxkI+vn2vMKN7EEnU+n9B
 F7/qoXy4wV0ecS4tZmGklbCSHWo5wuZUsDGKjjQnV5OWH23ixC8Lp+hRafZu3mfG+CMQ
 K9gXbagbZQRB+zNsg9iAfIj39d5b/DQ6Q37udfYp/k8d4zxeIqZRdVYOKWqYpThFigSQ
 Tb+cm1hbArDKY1EwBOiABhB48xwCJ/WrR8lv2xMGA5nxJoZ10W5L0c6IPNyG3rwGXAE3
 wANQ==
X-Gm-Message-State: AC+VfDxO4q6Kovfuhd0A98dCJap7LFARFfB8OpKDfqPPwettvYWpW+q8
 PpdvqAUhFTHWPo/W3QlrtSI7WtGxWZLzE3Th0xM=
X-Google-Smtp-Source: ACHHUZ49Sa4+xsj+fUtMgYEELMVj3pVblzZFsLEGWyqsOKJ1yN899Ixb58r2LBry4hwqjsXSSZ4Hlw==
X-Received: by 2002:a1c:6a09:0:b0:3f6:f2b2:15c9 with SMTP id
 f9-20020a1c6a09000000b003f6f2b215c9mr417614wmc.37.1685565396522; 
 Wed, 31 May 2023 13:36:36 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c24cd00b003f4dde07956sm25484459wmu.42.2023.05.31.13.36.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/15] hw/timer/arm_timer: CamelCase rename arm_timer_state ->
 ArmTimerState
Date: Wed, 31 May 2023 22:35:50 +0200
Message-Id: <20230531203559.29140-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
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

Following docs/devel/style.rst guidelines, rename arm_timer_state
as ArmTimerState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index fc8d25b0dc..2cd8c99b4e 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -36,11 +36,11 @@ typedef struct {
     int freq;
     int int_level;
     qemu_irq irq;
-} arm_timer_state;
+} ArmTimerState;
 
 /* Check all active timers, and schedule the next timer interrupt.  */
 
-static void arm_timer_update(arm_timer_state *s)
+static void arm_timer_update(ArmTimerState *s)
 {
     /* Update interrupts.  */
     if (s->int_level && (s->control & TIMER_CTRL_IE)) {
@@ -52,7 +52,7 @@ static void arm_timer_update(arm_timer_state *s)
 
 static uint32_t arm_timer_read(void *opaque, hwaddr offset)
 {
-    arm_timer_state *s = opaque;
+    ArmTimerState *s = opaque;
 
     switch (offset >> 2) {
     case 0: /* TimerLoad */
@@ -79,7 +79,7 @@ static uint32_t arm_timer_read(void *opaque, hwaddr offset)
  * Reset the timer limit after settings have changed.
  * May only be called from inside a ptimer transaction block.
  */
-static void arm_timer_recalibrate(arm_timer_state *s, int reload)
+static void arm_timer_recalibrate(ArmTimerState *s, int reload)
 {
     uint32_t limit;
 
@@ -99,7 +99,7 @@ static void arm_timer_recalibrate(arm_timer_state *s, int reload)
 static void arm_timer_write(void *opaque, hwaddr offset,
                             uint32_t value)
 {
-    arm_timer_state *s = opaque;
+    ArmTimerState *s = opaque;
     int freq;
 
     switch (offset >> 2) {
@@ -154,7 +154,7 @@ static void arm_timer_write(void *opaque, hwaddr offset,
 
 static void arm_timer_tick(void *opaque)
 {
-    arm_timer_state *s = opaque;
+    ArmTimerState *s = opaque;
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
+        VMSTATE_UINT32(control, ArmTimerState),
+        VMSTATE_UINT32(limit, ArmTimerState),
+        VMSTATE_INT32(int_level, ArmTimerState),
+        VMSTATE_PTIMER(timer, ArmTimerState),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static arm_timer_state *arm_timer_init(uint32_t freq)
+static ArmTimerState *arm_timer_init(uint32_t freq)
 {
-    arm_timer_state *s;
+    ArmTimerState *s;
 
-    s = g_new0(arm_timer_state, 1);
+    s = g_new0(ArmTimerState, 1);
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
 
@@ -198,7 +198,7 @@ struct SP804State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    arm_timer_state *timer[2];
+    ArmTimerState *timer[2];
     uint32_t freq0, freq1;
     int level[2];
     qemu_irq irq;
@@ -343,7 +343,7 @@ struct IntegratorPitState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    arm_timer_state *timer[3];
+    ArmTimerState *timer[3];
 };
 
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
-- 
2.38.1


