Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B97415D7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUr-0006cG-Sw; Wed, 28 Jun 2023 11:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUm-0006UI-6x
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUk-0008OW-Cw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso706465e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967653; x=1690559653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcuFvVHrtiBIfmEzaXESWb3QLl867zmkzFHov2yyCzs=;
 b=rS011PW1jxhOdWGnZUpEK6rMSAm74FMZdQq0W6MoVDa6SKL8pqQQRjLWpa22rGNJXz
 MIsphXZGDj3QFqbKJ1BabeExOf2C9ODHJkWiqA5EdN5O4q+1n2Vx8sRT2X7wXl2wZeqg
 56RLt69dnOZWIDpt5BLnny4jMbCD+CqAKBF2DZLlznxxl8PtSqykSrV0a40Py2D08MtZ
 vzg0lCUoFfr4fOlESBGgx4vnU7DEWLZq+SaoVUnSINlwG5C+iO0Uc9CRFXbpDsyzYLRN
 DtvwP7Y9hPxKJz5Yj85tuWgRcGO3wzeiwGDntzHa7/Edg1Fb9R1bWRThKU1GQSkajyMX
 oEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967653; x=1690559653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcuFvVHrtiBIfmEzaXESWb3QLl867zmkzFHov2yyCzs=;
 b=E3/SUMSvCouEq2wHRR+Zv/+rWWpMFFjIoi3fEQDWlWprAHIWKnNkyv0FZ79eyj0bDN
 7HB8r26hnFPfsrVGHuJ3hK4zDphKJzqMf/a2DamGoC8T14cujwyg5fY0sZ0fukFiv9lR
 p+V8W6/4RkUUReVuSOt0skw32rQcpl5Z48YAZo15CGSDJrV/uFF3mVrSNm08pRo9giqE
 yDNuxNRtGUgQ5jtx5K/XTLlOAxV+PYyUpKTiL6iZZYdqEYJu0zBnMTFviYMsl+h/lr6u
 MMU40iDx6HhmS9NUR1ol6GgTGqYb+G2aqmexRxbqm9e/VLrYqyXtn6x0DD0l510H0D9N
 ceDQ==
X-Gm-Message-State: AC+VfDyuqaltIGQjlcWJw4G+ssXWDxtMO0srb75rePfH3jNDoN6M5XgJ
 jREeix1gXRBOqTOYnRHYbnmHrFslPnNO4JEOXaI=
X-Google-Smtp-Source: ACHHUZ647QKyjq8biVb1to8KRCbbLYKZsRUZmvNmksxF+I1KlysCEEzhKi5VGqU+BJzU8o9gdtPCUQ==
X-Received: by 2002:a05:600c:230d:b0:3f6:d90:3db with SMTP id
 13-20020a05600c230d00b003f60d9003dbmr2062020wmo.3.1687967652892; 
 Wed, 28 Jun 2023 08:54:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a7bca55000000b003f4248dcfcbsm17077325wml.30.2023.06.28.08.54.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/30] accel: Move HAX hThread to accelerator context
Date: Wed, 28 Jun 2023 17:52:53 +0200
Message-Id: <20230628155313.71594-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

hThread variable is only used by the HAX accelerator,
so move it to the accelerator specific context.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-9-philmd@linaro.org>
---
 include/hw/core/cpu.h           | 1 -
 target/i386/hax/hax-i386.h      | 3 +++
 target/i386/hax/hax-accel-ops.c | 2 +-
 target/i386/hax/hax-all.c       | 2 +-
 target/i386/hax/hax-windows.c   | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 45e30911e7..476b39e42e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -338,7 +338,6 @@ struct CPUState {
 
     struct QemuThread *thread;
 #ifdef _WIN32
-    HANDLE hThread;
     QemuSemaphore sem;
 #endif
     int thread_id;
diff --git a/target/i386/hax/hax-i386.h b/target/i386/hax/hax-i386.h
index 4372ee596d..87153f40ab 100644
--- a/target/i386/hax/hax-i386.h
+++ b/target/i386/hax/hax-i386.h
@@ -27,6 +27,9 @@ typedef HANDLE hax_fd;
 extern struct hax_state hax_global;
 
 struct AccelCPUState {
+#ifdef _WIN32
+    HANDLE hThread;
+#endif
     hax_fd fd;
     int vcpu_id;
     struct hax_tunnel *tunnel;
diff --git a/target/i386/hax/hax-accel-ops.c b/target/i386/hax/hax-accel-ops.c
index a8512efcd5..5031096760 100644
--- a/target/i386/hax/hax-accel-ops.c
+++ b/target/i386/hax/hax-accel-ops.c
@@ -73,7 +73,7 @@ static void hax_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
     assert(cpu->accel);
 #ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+    cpu->accel->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
 }
 
diff --git a/target/i386/hax/hax-all.c b/target/i386/hax/hax-all.c
index 9d9011cc38..18d78e5b6b 100644
--- a/target/i386/hax/hax-all.c
+++ b/target/i386/hax/hax-all.c
@@ -206,7 +206,7 @@ int hax_vcpu_destroy(CPUState *cpu)
     hax_close_fd(vcpu->fd);
     hax_global.vm->vcpus[vcpu->vcpu_id] = NULL;
 #ifdef _WIN32
-    CloseHandle(cpu->hThread);
+    CloseHandle(vcpu->hThread);
 #endif
     g_free(vcpu);
     cpu->accel = NULL;
diff --git a/target/i386/hax/hax-windows.c b/target/i386/hax/hax-windows.c
index bf4b0ad941..4bf6cc08d2 100644
--- a/target/i386/hax/hax-windows.c
+++ b/target/i386/hax/hax-windows.c
@@ -476,7 +476,7 @@ void hax_kick_vcpu_thread(CPUState *cpu)
      */
     cpu->exit_request = 1;
     if (!qemu_cpu_is_self(cpu)) {
-        if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
+        if (!QueueUserAPC(dummy_apc_func, cpu->accel->hThread, 0)) {
             fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
                     __func__, GetLastError());
             exit(1);
-- 
2.38.1


