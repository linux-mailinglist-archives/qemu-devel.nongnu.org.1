Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7208251DE
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:26:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNh-0007me-HH; Fri, 05 Jan 2024 05:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNf-0007lu-Gu
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNd-0004M6-Ut
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d894764e7so14739445e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450283; x=1705055083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4O3zLDFQ6ZlP/1FwL4rg4zmPOXbZNJoyi4V6XF7xMA=;
 b=PXtIzZHxueOGIPZcUTGNJNfMyx6AXtXTvxouyBp0zzVj93IDoWY3QdZqkO4Afxkj/S
 ShDxpCiZGxf13/QtXe7VSBQvK3QV17J79WlDREuoyc+m2aHcQE8S9dfxAtWnpZBfLv0U
 wE03fLZvdtRohgZ1rKxwu6g4oaY8lEY4LPH2/le/kORcjsoWicNrkHiEvVnMQf9iJ9dX
 XL+dW5LZEUz3ADEX9IQPVTpaI7tfLER1UA5mrg7VQN9Lf8ZOwikEyUgxUtu4wn23/ZEe
 DhMJ0j8FJtONUS0iHO6W22uQe5AzYuH8tVM5VFoktbqjQ3eYPj9Yn0lthq9WhkXCXYCl
 +frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450283; x=1705055083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4O3zLDFQ6ZlP/1FwL4rg4zmPOXbZNJoyi4V6XF7xMA=;
 b=b0J+9p7s3qlWFBPSCBQLVbL/f2b3v3gXrrvvm1dA74pdQQ9WedQoKAEh3x0rYLjWlW
 BafhcjpcX2gAZ9zy/Ns9vFmYF/qaMgVj681pAf/oh/jp0vN21uJgJUEXNRBAlbgWUKF1
 xTD1CBgnjUzNZH9ZsjdPAp+QqdUKwMi5sr3V4RNU3nFhzMPN/nkt1XZJVa+uaHzW5lEB
 2KYgL/MI5faZSLb1eQF8e786BHoOMh+NELMhAilgInFqtfh1cvKSuJLBoib+pP+PfI0b
 ldCyPKD7EuQEsscOxphxM6N4jFtqrqKC/0ofbmhuNl0wrDllaYsj56iodkchoiz4uAWW
 C35w==
X-Gm-Message-State: AOJu0YzoGVgEr7JQYJ2J3zfW+gnzeI7WiJ/Z7F5yVEFpwfG85eZPjGE4
 1kKpjEbnoZ/KPaDqesWgMglBa2MINX+AifqcGOgmjwc/sQ==
X-Google-Smtp-Source: AGHT+IGdOVGRypPWbYhgGZUcXklD8OVeRUYGfUYOWFHPBuwnoFFSY6IPjF9DMAHiC6CkHg1FZTPN2g==
X-Received: by 2002:a05:600c:1552:b0:40e:34ed:2a35 with SMTP id
 f18-20020a05600c155200b0040e34ed2a35mr668539wmg.119.1704450283065; 
 Fri, 05 Jan 2024 02:24:43 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:42 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 6/9] target/sparc: simplify qemu_irq_ack
Date: Fri,  5 Jan 2024 11:24:18 +0100
Message-Id: <20240105102421.163554-7-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x336.google.com
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

This is a simple cleanup, since env is passed to qemu_irq_ack it can be
accessed from inside qemu_irq_ack.  Just drop this parameter.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c            | 8 ++++----
 target/sparc/cpu.h          | 2 +-
 target/sparc/int32_helper.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 94d8ec94b0..6019fc4c2d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -166,10 +166,10 @@ static void leon3_cache_control_int(CPUSPARCState *env)
     }
 }
 
-static void leon3_irq_ack(void *irq_manager, int intno)
+static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
     /* No SMP support yet.  */
-    grlib_irqmp_ack((DeviceState *)irq_manager, 0, intno);
+    grlib_irqmp_ack(env->irq_manager, 0, intno);
 }
 
 /*
@@ -211,9 +211,9 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
     }
 }
 
-static void leon3_irq_manager(CPUSPARCState *env, void *irq_manager, int intno)
+static void leon3_irq_manager(CPUSPARCState *env, int intno)
 {
-    leon3_irq_ack(irq_manager, intno);
+    leon3_irq_ack(env, intno);
     leon3_cache_control_int(env);
 }
 
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
2.25.1


