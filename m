Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E58256EA
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:45:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmN9-0006Ls-C4; Fri, 05 Jan 2024 10:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmN7-0006Ca-8r
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:33 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmN3-0003JZ-Ds
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:33 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33686649b72so1469411f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469468; x=1705074268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3F01YLhzgjTdtmytUy5rbru1eD+VsYVlRXqJFlFh/Hg=;
 b=DTGr9hZhGcXyItA9vjUOyMeef6a4deRm4PvKLmdkqvVLo5dIUmdsBNIeLo5GiLEvlA
 yhhnyjCuWApfTCU0EOFfPQegTY0Bp80Wd2xdRDjDCR/gmiWMMw9S4ujpGbmJG+aK7HYH
 hQ8xRgCXSRP+7yYh+ni8aNJm28sVXPXIHg2HJilj9y1LZbzQUJ06vXuMge1IPwX/4x61
 xDHddJih7EkNZ7xb8Kd79m4dEfcZLGzbLIWvlsDjDYuRF72T9yDjwptWP7gl+wKlsFTC
 QMxEpwke8fUiNJ8q6uatKNyD8bashtpV58ZCf4IwBPiJX+uSrdAfriE3KWVs4nGBh7Vv
 wt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469468; x=1705074268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3F01YLhzgjTdtmytUy5rbru1eD+VsYVlRXqJFlFh/Hg=;
 b=sJeFHKHlcVP493XwEMGpCU6EZrHV3Mv0JXTWcnaQbXiVa7pfzLBNmTNI73Y5ux9sYQ
 ww9CfMcDklQKXhRvQ9zFt6mUE59A9hW++yvhQt3dG4ejjSnnusAz8ztVEePXgVkJoUUJ
 vunxsgthe8B5kIFhtawFC7ue+rpEKuN9+wua/kDJyUmmya+b6AaG9IX6sd/y5wmD0M0c
 PN7YD4z7VmDp96i4wcAIGNrQEJw+JW3L0m/g6B/QSti5BJ7Aigp2oXiuvhvBWQyWe/RK
 dPTTAawr0MCosRGOPLo45pfdDr+0bftFG8jTV1varcu3bOvPwlLvkq9FFwm1GNkg4Jvy
 s+2Q==
X-Gm-Message-State: AOJu0Yx5vMx3OPY+WdlwiqPLzxaNZKURxDixCS2Vayv5nM+F0muVjIeL
 c2VIEBRiLO+j33rMwEunb4m0WvJ7qcYcsuEA/y2fnVA7XoE=
X-Google-Smtp-Source: AGHT+IHMrcC1y2jYMjaUBGOkIrrl9VgB3ASJ4FlwlNIejdtyL0PRqwm0EGOmSzw5lO3COmQNqU6NDw==
X-Received: by 2002:a5d:638d:0:b0:336:95d2:c649 with SMTP id
 p13-20020a5d638d000000b0033695d2c649mr1282677wru.125.1704469467904; 
 Fri, 05 Jan 2024 07:44:27 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 p17-20020a5d4e11000000b003365951cef9sm1605022wrt.55.2024.01.05.07.44.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:44:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 13/71] target/loongarch: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:06 +0100
Message-ID: <20240105154307.21385-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Gavin Shan <gshan@redhat.com>

Before it's applied:

[gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
la132-loongarch-cpu
la464-loongarch-cpu
max-loongarch-cpu

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
Available CPUs:
  la132
  la464
  max

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114235628.534334-14-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h |  4 ----
 target/loongarch/cpu.c | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 00d1fba597..0c15a174e4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -466,10 +466,6 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
-void loongarch_cpu_list(void);
-
-#define cpu_list loongarch_cpu_list
-
 #include "exec/cpu-all.h"
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 81f2d8d8ed..87dfcdb0a5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -483,21 +483,6 @@ static void loongarch_max_initfn(Object *obj)
     loongarch_la464_initfn(obj);
 }
 
-static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    const char *typename = object_class_get_name(OBJECT_CLASS(data));
-
-    qemu_printf("%s\n", typename);
-}
-
-void loongarch_cpu_list(void)
-{
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_LOONGARCH_CPU, false);
-    g_slist_foreach(list, loongarch_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 static void loongarch_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-- 
2.41.0


