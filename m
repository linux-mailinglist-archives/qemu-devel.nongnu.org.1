Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D16B74747F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNJ-0004j1-Da; Tue, 04 Jul 2023 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMh-0003v7-60
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMf-00031t-Fh
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so58789335e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482246; x=1691074246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIwsdI/cQgkg0mdSj90u8YDrX9ZsJjYV9q/7uRRhEe8=;
 b=PL2Bvkq4IL2H79ISndXuECgIemX9vXMX7SsYfKC+RgfClIumNdJAv8F09o8HePBjc0
 hL3LwHHG96EKsFz/TF2wc1J2d7vU7WFY0HwEk44RBaWFmi9IC+Y8vfOqUoAWnX/TK2qN
 h9dqrjtLWIp8FflrzHVzsxAqDdWOK83Lp0hXvkfD4kRUWlKlMxEwZdNbFgRfZa9hQBWD
 PKohkGgOyIVo7fvpddGwHHVE2Ib+z5GfFwhnKLHZOi8ZO0Wtuz8JnRinEfh1khvKhNXO
 l2GZDcurbmAhpYd6Nrw6zEnod3Oia3IUd36HE+s/Djtoz+YeOm9Utt52KHxCtUef2KBw
 l07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482246; x=1691074246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIwsdI/cQgkg0mdSj90u8YDrX9ZsJjYV9q/7uRRhEe8=;
 b=YgG0XAxH16VG/LVONCdLRDCL0jMHtEmG2rtmkbdfMwaQPwEyi8c0jo50M6+Ft+htkI
 KMtcylHNIalNfxl2VStjNj60wmg1r3ymYqzJyK6beR6gB1m8KLaNEvj4/SAn8h7Z704n
 uFBeoyesYJ5b2/jHIvH2y/a+s1Tgkny6giTtji4Y87KlLS4uI427Du1nQn9KL74zAM5s
 SNYq7PpROtL0LoE2OWdJlMQDUIJoCxs6dFs10ecYMD8/HPQwjpLXcpH0sJLh8qXFd9cD
 oLbxbuRGx8WKauKtq6C9iMGPZj/Xjj7i2SbxOjzEjbYFpd016C0gk84dBeCRyV6i4/Gg
 cPLw==
X-Gm-Message-State: ABy/qLaGrkHSmPBEUhjQzURtcEffFaDcjP7z20InQ/BXxHK0P2MRjrZe
 MAO1fvQkthK+wXKj55p/CMomnnGZ9Yb8NRWiYlk=
X-Google-Smtp-Source: APBJJlGm0m+W+yJ99J/kwdV4+LjIii3sHzHd4W9kkAyPfyWE5MAxsTdDXomXktnD2kp2Xzw7m2ORZw==
X-Received: by 2002:a7b:c8c2:0:b0:3fb:e189:3532 with SMTP id
 f2-20020a7bc8c2000000b003fbe1893532mr1693571wml.20.1688482246078; 
 Tue, 04 Jul 2023 07:50:46 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a7bcd97000000b003fbb2c0fce5sm17802986wmj.25.2023.07.04.07.50.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/19] hw/timer/arm_timer: Rename SP804State -> SP804Timer
Date: Tue,  4 Jul 2023 16:49:59 +0200
Message-Id: <20230704145012.49870-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Following docs/devel/style.rst guidelines, rename SP804State
as SP804Timer.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 8a2939483f..41045de8ed 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -192,9 +192,9 @@ static ArmTimer *arm_timer_init(uint32_t freq)
  */
 
 #define TYPE_SP804 "sp804"
-OBJECT_DECLARE_SIMPLE_TYPE(SP804State, SP804)
+OBJECT_DECLARE_SIMPLE_TYPE(SP804Timer, SP804)
 
-struct SP804State {
+struct SP804Timer {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
@@ -214,7 +214,7 @@ static const uint8_t sp804_ids[] = {
 /* Merge the IRQs from the two component devices.  */
 static void sp804_set_irq(void *opaque, int irq, int level)
 {
-    SP804State *s = opaque;
+    SP804Timer *s = opaque;
 
     s->level[irq] = level;
     qemu_set_irq(s->irq, s->level[0] || s->level[1]);
@@ -223,7 +223,7 @@ static void sp804_set_irq(void *opaque, int irq, int level)
 static uint64_t sp804_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
-    SP804State *s = opaque;
+    SP804Timer *s = opaque;
 
     if (offset < 0x20) {
         return arm_timer_read(s->timer[0], offset);
@@ -255,7 +255,7 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
 static void sp804_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
-    SP804State *s = opaque;
+    SP804Timer *s = opaque;
 
     if (offset < 0x20) {
         arm_timer_write(s->timer[0], offset, value);
@@ -283,14 +283,14 @@ static const VMStateDescription vmstate_sp804 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_ARRAY(level, SP804State, 2),
+        VMSTATE_INT32_ARRAY(level, SP804Timer, 2),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static void sp804_init(Object *obj)
 {
-    SP804State *s = SP804(obj);
+    SP804Timer *s = SP804(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(sbd, &s->irq);
@@ -301,7 +301,7 @@ static void sp804_init(Object *obj)
 
 static void sp804_realize(DeviceState *dev, Error **errp)
 {
-    SP804State *s = SP804(dev);
+    SP804Timer *s = SP804(dev);
 
     s->timer[0] = arm_timer_init(s->freq0);
     s->timer[1] = arm_timer_init(s->freq1);
@@ -310,8 +310,8 @@ static void sp804_realize(DeviceState *dev, Error **errp)
 }
 
 static Property sp804_properties[] = {
-    DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
-    DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
+    DEFINE_PROP_UINT32("freq0", SP804Timer, freq0, 1000000),
+    DEFINE_PROP_UINT32("freq1", SP804Timer, freq1, 1000000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -405,7 +405,7 @@ static const TypeInfo arm_timer_types[] = {
     }, {
         .name           = TYPE_SP804,
         .parent         = TYPE_SYS_BUS_DEVICE,
-        .instance_size  = sizeof(SP804State),
+        .instance_size  = sizeof(SP804Timer),
         .instance_init  = sp804_init,
         .class_init     = sp804_class_init,
     }
-- 
2.38.1


