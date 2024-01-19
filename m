Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB2832910
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAX-0002m1-WB; Fri, 19 Jan 2024 06:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAV-0002gi-7r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAT-0001sk-Ht
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e9e96edd1so4733835e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664172; x=1706268972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNW2fCmz3vLZacxmspFmUgZW6wt1zZjsUlXpiy/aG9E=;
 b=wudcmL2NOP+d+0Pq0DeHE+6qytv59retL2d6FnPiUUJ/sUnOgE1r199Z5R6wP8d83x
 8nNmINcW7TNrKE1Whzvd8mKYqXDRiTGrhSPx7l5DoILDeJsebsTzMjReNmdI2AKigZ5Z
 8m3vdZCs071W53p6UKANYkleGqcBjq0KI9Y/Fk64evPW7H3Ltlm6EfahIZ7AOA37eK7d
 jYBxufya6i8e986/nuIgd0cDgk1+Nf1wLjXxzhlppzKa/P8ylewX1i85GHPm6zwSFDKW
 ehuvhpWwgFZBtHdOiQ6oZz+D9clD76h+rpbRIYrk4LEYMJIEIWeRiyTkBLTCvSWNC5jY
 ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664172; x=1706268972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNW2fCmz3vLZacxmspFmUgZW6wt1zZjsUlXpiy/aG9E=;
 b=c6fz99PBmzxtRhbbVcBiAXii7cLkRxICWjcOU6xkFXiHR5yXx6JNLuI/1yme20ZnTc
 4kIAC8GctYe/HJn+KOQDJrgewJYpgtYRwoZ9ov0brRr1V5vv+dhEC5OJ1Xbm9EALOghq
 V5v8ShsirYP4hvbNoiCK21GlCgtNt6GB2zrrwzLQprd3uk8+lwI6i2JLqpybOjLItkL4
 G3sO7qPeEh8qEY6wWP5y56ds3u3ZsTxISvFM95cGoItIE17H0jThW06NNSj+OVh7v0+9
 CcaDOQcufupLoX09EEYUOUL59QSrQTYr8ZFjp9k4Vx7c0cQ+OhLYnPsaBHOwj85UZaWC
 q0yA==
X-Gm-Message-State: AOJu0YyyC26q7V2yFVqLhOcWBCH1FccRDwpS328jnsltzdjU7f7/fV8g
 cZeblI7VEXKMT6OWbqJqj0WvNMihvBUJd2f5yarWnbv9WiFHHOIWVUomagBBA/vNG6CaL6QgUNh
 +OtRLrw==
X-Google-Smtp-Source: AGHT+IE9gUU+fE/GY6s5RXTEQA/ZE1GGZwIb+NMV7PiXdey5RrE820r0VFS7Z98Tf6Ry3nn4fPSXhA==
X-Received: by 2002:a05:600c:19c7:b0:40e:6688:2527 with SMTP id
 u7-20020a05600c19c700b0040e66882527mr657905wmq.291.1705664171877; 
 Fri, 19 Jan 2024 03:36:11 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 p1-20020adfe601000000b00337bf461385sm6297076wrm.26.2024.01.19.03.36.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 14/36] util/async: Only call icount_notify_exit() if icount is
 enabled
Date: Fri, 19 Jan 2024 12:34:43 +0100
Message-ID: <20240119113507.31951-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231208113529.74067-6-philmd@linaro.org>
---
 accel/tcg/icount-common.c |  4 +++-
 stubs/icount.c            |  2 +-
 util/async.c              | 16 +++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index f0f8fc7f1c..a4a747d1dc 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -495,7 +495,9 @@ bool icount_configure(QemuOpts *opts, Error **errp)
 
 void icount_notify_exit(void)
 {
-    if (icount_enabled() && current_cpu) {
+    assert(icount_enabled());
+
+    if (current_cpu) {
         qemu_cpu_kick(current_cpu);
         qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
     }
diff --git a/stubs/icount.c b/stubs/icount.c
index c2c10dfb6b..1eb35b10a8 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -45,7 +45,7 @@ void icount_account_warp_timer(void)
 {
     abort();
 }
-
 void icount_notify_exit(void)
 {
+    abort();
 }
diff --git a/util/async.c b/util/async.c
index 36a8e76ab0..0467890052 100644
--- a/util/async.c
+++ b/util/async.c
@@ -94,13 +94,15 @@ static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
     }
 
     aio_notify(ctx);
-    /*
-     * Workaround for record/replay.
-     * vCPU execution should be suspended when new BH is set.
-     * This is needed to avoid guest timeouts caused
-     * by the long cycles of the execution.
-     */
-    icount_notify_exit();
+    if (unlikely(icount_enabled())) {
+        /*
+         * Workaround for record/replay.
+         * vCPU execution should be suspended when new BH is set.
+         * This is needed to avoid guest timeouts caused
+         * by the long cycles of the execution.
+         */
+        icount_notify_exit();
+    }
 }
 
 /* Only called from aio_bh_poll() and aio_ctx_finalize() */
-- 
2.41.0


