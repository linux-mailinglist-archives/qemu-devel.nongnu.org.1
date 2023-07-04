Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29549747480
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNO-00050Y-TV; Tue, 04 Jul 2023 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMl-00043n-Nj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMk-00034Q-0W
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3143b70d6easo1844494f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482251; x=1691074251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++LZHEaYZEOc8RZ08zxDUSSEQLHOuupdFHCXT9e/i4U=;
 b=VAtWzy8R2wJexqrsjXQmkh7Smk7rfgCSMY3Z7gqb6rFMSWUGcc+4gTWiRNhP55MD5F
 HBwPgTRJpxTvag/FKKJBPZiwWL8bvI+/iITbsC0DXfOdjaA1gllr6evrmdUWd7q9qzvj
 wf4FBwQsMJjwEmWSai6+lJd6HhjneLDsyjBWHfrsx6liyEzAC4cBMwkg3MvJCdGl2CO2
 RuKJ/SPLd4FgE4ENfBgF/R6r9JV5EvJchVoEQFtrc7t044FmKXVZcuEvM44hBfZVOL0Z
 mlbygRPKrEdH33KqO/rEvNN0ojvIp0YRvF+w9YCX1aHOAF2GhwoH48I+BZ4BEAg34mPZ
 47UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482251; x=1691074251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++LZHEaYZEOc8RZ08zxDUSSEQLHOuupdFHCXT9e/i4U=;
 b=GVfA/2OpIVY9bR6gj/BqlZwxeCcP9yrSNgRX8ShiZFu9gpx3AOL6rPzIhhsyHIGH3t
 ufzldFQYHX6ofPzS/rf76Bp5Hkun3fx2LDIqp7htn7cOr10LzjA1/dT6a99zlNJWTyiu
 O7T7Go9jnu6unklLVPRkFjcVA8GFtjfFhlSbafUmonRND9Cy7SBiZ9ss5YjIOlYWQZOQ
 +cpiM/F93PUa++I5MzwL/U+PTwKqBwJqpKvmEmqZlvCnLim/enVKAdM0UkOZGp/zibk9
 hxO86w0dtJn+88KV/715Vqnl4lITpAaP/tFGnTkAW5R1T8b6lDwAnVFYLRJJQMrms4Ul
 lj4g==
X-Gm-Message-State: ABy/qLYCQ9SjqaS0X3csWgKWtKzow3mXrEB7R/FyhAcUU0o9okdWydGJ
 9a1QCRtEyd3C/kBrnnbDY1aqxCMmmZu1ccsjfIA=
X-Google-Smtp-Source: APBJJlFduYNS/+0UHfaCm5CUekJDFlEpziUdWLSTdk1BvOP5QK0VBKvh1MTa4RKvz3OJzFN4RVolVw==
X-Received: by 2002:a5d:6acc:0:b0:314:a3f:9c04 with SMTP id
 u12-20020a5d6acc000000b003140a3f9c04mr11478018wrw.59.1688482251286; 
 Tue, 04 Jul 2023 07:50:51 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b003140f47224csm16102776wrj.15.2023.07.04.07.50.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/19] hw/timer/arm_timer: Rename TYPE_SP804 ->
 TYPE_SP804_TIMER
Date: Tue,  4 Jul 2023 16:50:00 +0200
Message-Id: <20230704145012.49870-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Having a QOM object using its device type as suffix is
often helpful.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 41045de8ed..8dae845998 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -191,8 +191,8 @@ static ArmTimer *arm_timer_init(uint32_t freq)
  * https://developer.arm.com/documentation/ddi0271/latest/
  */
 
-#define TYPE_SP804 "sp804"
-OBJECT_DECLARE_SIMPLE_TYPE(SP804Timer, SP804)
+#define TYPE_SP804_TIMER "sp804"
+OBJECT_DECLARE_SIMPLE_TYPE(SP804Timer, SP804_TIMER)
 
 struct SP804Timer {
     SysBusDevice parent_obj;
@@ -290,7 +290,7 @@ static const VMStateDescription vmstate_sp804 = {
 
 static void sp804_init(Object *obj)
 {
-    SP804Timer *s = SP804(obj);
+    SP804Timer *s = SP804_TIMER(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(sbd, &s->irq);
@@ -301,7 +301,7 @@ static void sp804_init(Object *obj)
 
 static void sp804_realize(DeviceState *dev, Error **errp)
 {
-    SP804Timer *s = SP804(dev);
+    SP804Timer *s = SP804_TIMER(dev);
 
     s->timer[0] = arm_timer_init(s->freq0);
     s->timer[1] = arm_timer_init(s->freq1);
@@ -403,7 +403,7 @@ static const TypeInfo arm_timer_types[] = {
         .instance_init  = icp_pit_init,
 
     }, {
-        .name           = TYPE_SP804,
+        .name           = TYPE_SP804_TIMER,
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(SP804Timer),
         .instance_init  = sp804_init,
-- 
2.38.1


