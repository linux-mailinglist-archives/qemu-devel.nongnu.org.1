Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D1718B57
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SYg-0007k0-N9; Wed, 31 May 2023 16:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYc-0007W1-Po
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYb-0003IX-78
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6e72a1464so921185e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565391; x=1688157391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bApdHpHvphQGH6iJkkAkav6K47Z8aVKSZsLKgEzGjI=;
 b=SjC2KJW26ls1HD58kz7BecXkM9dZ1U5aqRtnlE3a8cX3dLlv10QWAO5aBM5LhxY6Bx
 Vr7E3QsiG+GmAb5ODU9i7ZhRbmF8ZlGzfQQjqsyX8Ay654cpOdtqoKSVquN81hhbVV01
 u2Ymvw/N5Dyg0l2n3R7guL1BbiB18b1OI2FiBrlRKh6TOASo593nt7qg6FuxVKs2FB5G
 38rWFyguhjusV/ZcSjnEO+3v34GaU+DLtVmWbrBhZ0XhuVYFsJwS6eNtBa/xWnOaRaKT
 14KiOLb3cSjf5QuzWlK99B+tW8PmJGkmEPrUD4h09Bk6D+QQ/0N11ZjaZZzbIktelvgm
 ViBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565391; x=1688157391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bApdHpHvphQGH6iJkkAkav6K47Z8aVKSZsLKgEzGjI=;
 b=eiIe1It456ARR6yMRXKhhwmRt5SiSyFbKlpPjB4l0GAhQi9JuTSYV2ks183MGYivhv
 /awnv+QwmQNqoRVZh0DqAQ8imtE8TvtcNgN4A57Pe1f09fKSJY0yWDu+gRHojtTk4uhc
 Ouu+LBVcEvIWx9j8SooaQ3JAMbyIgXlzSMjknKZMYKjmnbNODBXQ3+M5BK/B6SUJuRBj
 EH/8yhaMTjPLgHHb78UUBmfiLTwgI3ralzhnc3jHf1nAo7T/7GFT5a26m0FnnwSPUWB4
 Oq8DOf0MOfYyPcZMwcGKCo3kDOV/1EoIM2zjmbLFyTurzm6/FBaIZrq4kQHvPabypQkt
 J0dg==
X-Gm-Message-State: AC+VfDzXfr8A+s+AYmgWxpK/llK8iV+KIuGYjawiDSApp7sp8qT3HWOP
 GX49BXBNxN6R+gXdTed2y4/AbHnuQwZGBqznbtQ=
X-Google-Smtp-Source: ACHHUZ715afNrjdshuSitYG2Pf7FgralJ4vDvkvh+fTW6vxsZ0Z3ZKrE329y5pBYPkvRcMgRr8b2gQ==
X-Received: by 2002:a05:600c:3658:b0:3f4:2328:b5c2 with SMTP id
 y24-20020a05600c365800b003f42328b5c2mr260494wmq.35.1685565391086; 
 Wed, 31 May 2023 13:36:31 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c028900b003f42a75ac2asm22049206wmk.23.2023.05.31.13.36.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/15] hw/timer/arm_timer: CamelCase rename icp_pit_state ->
 IntegratorPitState
Date: Wed, 31 May 2023 22:35:49 +0200
Message-Id: <20230531203559.29140-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Following docs/devel/style.rst guidelines, rename icp_pit_state
using CamelCase as IntegratorPitState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 3dda3a73f8..fc8d25b0dc 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -337,9 +337,9 @@ static void sp804_class_init(ObjectClass *klass, void *data)
 /* Integrator/CP timer module.  */
 
 #define TYPE_INTEGRATOR_PIT "integrator_pit"
-OBJECT_DECLARE_SIMPLE_TYPE(icp_pit_state, INTEGRATOR_PIT)
+OBJECT_DECLARE_SIMPLE_TYPE(IntegratorPitState, INTEGRATOR_PIT)
 
-struct icp_pit_state {
+struct IntegratorPitState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
@@ -349,7 +349,7 @@ struct icp_pit_state {
 static uint64_t icp_pit_read(void *opaque, hwaddr offset,
                              unsigned size)
 {
-    icp_pit_state *s = opaque;
+    IntegratorPitState *s = opaque;
     int n;
 
     /* ??? Don't know the PrimeCell ID for this device.  */
@@ -365,7 +365,7 @@ static uint64_t icp_pit_read(void *opaque, hwaddr offset,
 static void icp_pit_write(void *opaque, hwaddr offset,
                           uint64_t value, unsigned size)
 {
-    icp_pit_state *s = opaque;
+    IntegratorPitState *s = opaque;
     int n;
 
     n = offset >> 8;
@@ -385,7 +385,7 @@ static const MemoryRegionOps icp_pit_ops = {
 
 static void icp_pit_init(Object *obj)
 {
-    icp_pit_state *s = INTEGRATOR_PIT(obj);
+    IntegratorPitState *s = INTEGRATOR_PIT(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     /* Timer 0 runs at the system clock speed (40MHz).  */
@@ -409,7 +409,7 @@ static const TypeInfo arm_timer_types[] = {
     {
         .name           = TYPE_INTEGRATOR_PIT,
         .parent         = TYPE_SYS_BUS_DEVICE,
-        .instance_size  = sizeof(icp_pit_state),
+        .instance_size  = sizeof(IntegratorPitState),
         .instance_init  = icp_pit_init,
 
     }, {
-- 
2.38.1


