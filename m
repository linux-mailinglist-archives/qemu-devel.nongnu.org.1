Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4182574E
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:57:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTZ-0003jg-7O; Fri, 05 Jan 2024 10:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSl-0001mu-8i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSi-0001I7-Db
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso19623095e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469818; x=1705074618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GKplYO/5yXOUvt6X4002htySDt5oqr2bCk1Sg6HTjA=;
 b=dO5G6zc+IJBx5gVHi6xy/48X3lWQopv8xi+eAd78hQdyPLLRWNO5prpvnWCUjPImjA
 hfgcgtmqGuSqxTwDFqsRGq/jnmDFmwZDOQplgeKz/a6SrCb5ItgN/JCjeDMd8P8U6feG
 4TVls0yAnhvpBwEkNP4bcT2Kx+Gb5mz58rli0gJE66gyHlpSp+ksQahDI267jZuHPUZd
 v8CbUnqcRIfa7KRS3DeU8FDsXxtwkx/p0SwDzEPusr/QKLQulZdOwrgP5HztC3OICm1H
 kTnPlMTrb5VEko3e4eUm9SS/nBXzQTykq5ezDqeyfI2cHSml1C6Qub7TsdvXg86CWIcP
 2n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469818; x=1705074618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GKplYO/5yXOUvt6X4002htySDt5oqr2bCk1Sg6HTjA=;
 b=T6Wr6ugOTSWwnMwnRYFnBzmC6XGP2kpzh5jJYTwAl2bOTkt6VmxAcr3DMNmq1UenSR
 qIxJGzSOXIkZ6Nc7XYTPnQIU1tz7kBR9XwT1rVKoY0/KFsSzLifg8M28BFauToJBhywA
 JlcoGF5Ghut4n0wXYkK8AXzsqX/u/g/xpyELlMo0kHYN+weK9nxw7gxdA10Xx/r31y2p
 vPWk1zDPwhd91cGqAx0CZcLPZfaoX29IAGoaWz3gsYYI4MzuOeXPX6xVUNLbkvMjC2Pn
 raemRMXNoD0LYVrcIwttdx6cAxcS/v0E4TppQILCqIomu9Ncw6eo7BkbHOTyoh1wJnmG
 As6Q==
X-Gm-Message-State: AOJu0YyZ+ZV4GMxtZ7+MCZ9uDsyPDTWlsqO7X6LTx3JgV969GzNQCA64
 H3o363gyC0SYCOVl4QOYg8Nn2zmLDDDo048uOj7eGx+iC7M=
X-Google-Smtp-Source: AGHT+IH8UJYSR/lIhiCcHQA6HiNCMXVAShe4Y4YBQ49ltwPzGBu/udU/l8S6x0L26MAEn2kIIua62A==
X-Received: by 2002:a7b:c8cd:0:b0:40d:6c48:a1b4 with SMTP id
 f13-20020a7bc8cd000000b0040d6c48a1b4mr1359736wml.29.1704469817815; 
 Fri, 05 Jan 2024 07:50:17 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 w5-20020a05600c474500b0040e34835a58sm1933611wmo.22.2024.01.05.07.50.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:50:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 71/71] target/sparc: Simplify qemu_irq_ack
Date: Fri,  5 Jan 2024 16:43:04 +0100
Message-ID: <20240105154307.21385-72-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Clément Chigot <chigot@adacore.com>

This is a simple cleanup, since env is passed to qemu_irq_ack it can be
accessed from inside qemu_irq_ack.  Just drop this parameter.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240105102421.163554-7-chigot@adacore.com>
---
 target/sparc/cpu.h          | 2 +-
 hw/sparc/leon3.c            | 8 ++++----
 target/sparc/int32_helper.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 6999a10a40..12a11ecb26 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -549,7 +549,7 @@ struct CPUArchState {
     sparc_def_t def;
 
     void *irq_manager;
-    void (*qemu_irq_ack)(CPUSPARCState *env, void *irq_manager, int intno);
+    void (*qemu_irq_ack)(CPUSPARCState *env, int intno);
 
     /* Leon3 cache control */
     uint32_t cache_control;
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 1e39d2e2d0..2dfb742566 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -164,9 +164,9 @@ static void leon3_cache_control_int(CPUSPARCState *env)
     }
 }
 
-static void leon3_irq_ack(void *irq_manager, int intno)
+static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    grlib_irqmp_ack((DeviceState *)irq_manager, intno);
+    grlib_irqmp_ack(env->irq_manager, intno);
 }
 
 /*
@@ -208,9 +208,9 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
     }
 }
 
-static void leon3_irq_manager(CPUSPARCState *env, void *irq_manager, int intno)
+static void leon3_irq_manager(CPUSPARCState *env, int intno)
 {
-    leon3_irq_ack(irq_manager, intno);
+    leon3_irq_ack(env, intno);
     leon3_cache_control_int(env);
 }
 
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 1563613582..8f4e08ed09 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -160,7 +160,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     /* IRQ acknowledgment */
     if ((intno & ~15) == TT_EXTINT && env->qemu_irq_ack != NULL) {
-        env->qemu_irq_ack(env, env->irq_manager, intno);
+        env->qemu_irq_ack(env, intno);
     }
 #endif
 }
-- 
2.41.0


