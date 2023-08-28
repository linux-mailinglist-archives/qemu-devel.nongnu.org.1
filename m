Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEF78BAE5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakV7-00072t-Vd; Mon, 28 Aug 2023 18:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakV5-0006oI-8G
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakV0-0004IE-Vc
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:14:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so3204158f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260856; x=1693865656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OR2t1S0ttCGvBFU5E6vcS7ExCprp94yTFLK0sZMvoOs=;
 b=S/ZQcSkVLgX19BJ+tgcVctbK7w2mjfIqpChSOf2Q9B2GI13xVls8DefVwpOXZtkBN6
 UNTxPFK0GZKi8XcC6UB7cV/REOHocM8L25wMvAQVAlejRO1X4GEXvzmwmntDA1Qx2M/e
 0I9TD0wk1JuENiQGX5pDMnykq/oL4/ppbWzAJi0VAr2jVxODyZjVgp1N4w70KtG58x63
 XXHtgSlRwcQ4kl7EqVEG26uENC1BJdt0CarqLF0vAcv+2RbTRCxfSOdT4AJQTXD/6kT4
 qTmQiSMjrca/6mQFI3x/jfZv8rZe9UO7aAqMLyCEriyinKt5jTThWowyD7fydVOV/0NQ
 P//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260856; x=1693865656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OR2t1S0ttCGvBFU5E6vcS7ExCprp94yTFLK0sZMvoOs=;
 b=H4R3h5lm7dmJEu3W+SkOZbZfZ7VZTMsINMpt1hmAZIrGwVzA5I5beNO2AQiHluvc8A
 THTQFVR8x3wOtOxyi/n0LllcyVREvjVmEuoEjt0p8wqDDK6N+Fi7ng2mDqMcK658eNwd
 GwPMxb3KVs2oqHpbeHmQnSf9a42jcPKa1cVz3D65VDmBp5na1+rMS35MXKJJ1SqIpKoi
 ln6fuorPGtB04Nl+UOHyo3+H73eZZipPwjY2OmtQgFXFUM3IDVN/XjHmR/yShidJxeFd
 MwF3yBDz1FTqaBU1povH4ZDc1gw2rehq0DN118DR/i6ev/FaRvJp+XzHFUYeRqeYI552
 4bXw==
X-Gm-Message-State: AOJu0YyG5JfLnNoeelH0/LkCxr0EZBlGSEYSS9pQF9dutcc424BMQwbi
 DjZRww1bICQynx2j0opd3Ih6ZEJUkUf2KHDe62A=
X-Google-Smtp-Source: AGHT+IEVm4JmspE62irAxgd9zW4r9QXDwSL+8p3PuMUoqH0cJNJq8bcZPVLx12KHrLa9Z4AJ+Nex7Q==
X-Received: by 2002:a5d:5101:0:b0:317:e515:d623 with SMTP id
 s1-20020a5d5101000000b00317e515d623mr19508673wrt.60.1693260856203; 
 Mon, 28 Aug 2023 15:14:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfedd2000000b0031934b035d2sm11710874wro.52.2023.08.28.15.14.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:14:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/11] target/xtensa: Include missing 'qemu/atomic.h' header
Date: Tue, 29 Aug 2023 00:13:12 +0200
Message-ID: <20230828221314.18435-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828221314.18435-1-philmd@linaro.org>
References: <20230828221314.18435-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Since commit fa92bd4af7 ("target/xtensa: fix access to
the INTERRUPT SR") these files use QEMU atomic API.
Explicit the header inclusion instead of relying on
implicit and indirect inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/pic_cpu.c        | 1 +
 target/xtensa/exc_helper.c | 1 +
 target/xtensa/op_helper.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 6c9447565d..8cef88c61b 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
+#include "qemu/atomic.h"
 
 void check_interrupts(CPUXtensaState *env)
 {
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 43f6a862de..91354884f7 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -31,6 +31,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
+#include "qemu/atomic.h"
 #include "exec/exec-all.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 03e2c1889a..7bb8cd6726 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -30,6 +30,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "qemu/atomic.h"
 #include "qemu/timer.h"
 
 #ifndef CONFIG_USER_ONLY
-- 
2.41.0


