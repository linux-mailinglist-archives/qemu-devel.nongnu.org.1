Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600D7FBBBC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yIB-00022q-M4; Tue, 28 Nov 2023 08:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yI9-00022T-Vs
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:22 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yI8-00088B-Ag
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:21 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a03a900956dso1030857066b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178699; x=1701783499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peKa62xUsod/edNIYUpkMuF8n0prRBNW2awRUt91oBs=;
 b=LbAnZXgaoxF9OaPVqGHvYHvjK3zskXNd9NiWOmxPOWhw1VVjS6rJl9hOfyq8uiEbtQ
 jCd5Zn0NL89iaynSXS3SbcgP07WPir6C9a7ZDMhlls6qwpCmPYq5Bsxr9+1lWb76JfCK
 wMHQqGHAOqcTiwJketdwBIrqGG3lHjviqYERr5ctW5/3s0ife8ACkS8jpwwTkAMKLQfm
 4//oxzdNrASYNHpP2dstE/yUhy8I3teFwmsiKe9kJhiRZ62ZtPjFqpelPpXANCXiQOsY
 9ukHXABBTVhTLVaFqfxh0+R8nEi5/CyjNEIoEQC5q5Im5Yv9yfzsJBCaxSfiozqVJnw+
 /1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178699; x=1701783499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peKa62xUsod/edNIYUpkMuF8n0prRBNW2awRUt91oBs=;
 b=DtE6jLTojFnEn/TPCoce+QZCQaZCp+KOvVJnMojft3QnPwUMh8JU2ybO449QTIGe1n
 h9X3N+lidwli1lBVFi58icdTv90iKBIVGHNOfwUu/K5ZbWzcjerBrnySU9OUml+MCGIa
 y6MPHxkrFNzY3ybMIADi1XEAZ1GOfqLEZLNSgz9pRJtYLSvdXDvds4AYG63mId/OCK4h
 N6/SpUcrr+umnOq3DZ6eg5DURmEcdG3eBxYUguMNqcYNmmvgg23PAAVVsWp0Y60AOqhg
 w6EPerOFGZx6QmEm9r5uxF/YzDV614qYlzqc/vQ50a8TUsFJF/9y8Pyo8ZZq9p4uOTu9
 j10A==
X-Gm-Message-State: AOJu0YyLqkdrDiXVfohZDaljv4ugMAE8a6py9sgV0ZdJr9qr53eZ9uIz
 0oOVuSiD4h7LsRQd91mVZwTX0hhGkcFYQY1fHiI=
X-Google-Smtp-Source: AGHT+IHXs9TvCJCJ6Opq0VNRw/iNFvEnutEDCISq3W96dQ8yyYngqYKmic/SXOwifg2PGLpZ85BEkw==
X-Received: by 2002:a17:906:7398:b0:a0f:e0fc:c41d with SMTP id
 f24-20020a170906739800b00a0fe0fcc41dmr5591613ejl.34.1701178698932; 
 Tue, 28 Nov 2023 05:38:18 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 f3-20020a170906c08300b00a0a25541153sm5049993ejz.93.2023.11.28.05.38.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:38:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gihun Nam <gihun.nam@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/7] hw/avr/atmega: Fix wrong initial value of stack pointer
Date: Tue, 28 Nov 2023 14:37:39 +0100
Message-ID: <20231128133740.64525-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Gihun Nam <gihun.nam@outlook.com>

The current implementation initializes the stack pointer of AVR devices
to 0. Although older AVR devices used to be like that, newer ones set
it to RAMEND.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/cpu.h |  3 +++
 hw/avr/atmega.c  |  4 ++++
 target/avr/cpu.c | 10 +++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 8a17862737..7960c5c57a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -145,6 +145,9 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUAVRState env;
+
+    /* Initial value of stack pointer */
+    uint32_t init_sp;
 };
 
 /**
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index a34803e642..31c8992d75 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -233,6 +233,10 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
+
+    object_property_set_uint(OBJECT(&s->cpu), "init-sp",
+                             mc->io_size + mc->sram_size - 1, &error_abort);
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 44de1e18d1..999c010ded 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
+#include "hw/qdev-properties.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -95,7 +96,7 @@ static void avr_cpu_reset_hold(Object *obj)
     env->rampY = 0;
     env->rampZ = 0;
     env->eind = 0;
-    env->sp = 0;
+    env->sp = cpu->init_sp;
 
     env->skip = 0;
 
@@ -152,6 +153,11 @@ static void avr_cpu_initfn(Object *obj)
                       sizeof(cpu->env.intsrc) * 8);
 }
 
+static Property avr_cpu_properties[] = {
+    DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -228,6 +234,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, avr_cpu_realizefn, &mcc->parent_realize);
 
+    device_class_set_props(dc, avr_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, avr_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
 
-- 
2.41.0


