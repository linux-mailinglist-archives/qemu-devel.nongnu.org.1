Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121808256FD
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:47:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmMo-0005DM-Gn; Fri, 05 Jan 2024 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMh-0004rg-7i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMa-0003Cq-Un
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0c4dso17351955e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469439; x=1705074239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJixAs+R9evY25N/DNdQZkg5UuMmYpP4W3heU6glhRE=;
 b=dXDd3JGIuaPHal0zUrDxlITmM54qS28iLzvT+rq/Gkdm52HjQzg0GEOVMF9jClL9sV
 eDFlkkG6cUlEIoojkUW2po6dEB4zi5vkfgdMqE1zNAfZ8IPEGvIr+FqDArz/n7YKTmaT
 pX9qcPhG/F+DmmejqoCM8uVfAAGJoeFaZfNCR7lXiVE1NZIWSiRAK6YQ6f241GbAtg+Z
 r8gCue8Kl/YsHkLZ8lnr0UGvzc2xQ8MZqw5qz4LsGD/PCGyATYNCI9yhWThtdEJ5sqfZ
 NjtHaygNVrWm6Qd3fTZnFUFL6Z5nvT7OGIZtCCOeuRLa8gJQxJj2Q5o1eKNEtf7tV6Ts
 lgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469439; x=1705074239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJixAs+R9evY25N/DNdQZkg5UuMmYpP4W3heU6glhRE=;
 b=H5ZzPywx2Rhdi0dBuq9Fc9vNbcT2wvnbYhWZsRISO7weOZXB9Pzq+HPC5q3mVG4A2i
 f0I4wQonvcom8aCFZisPGJPkSI/ZeAfR4mmbJzHZRhwsP7o6Hmw0RB5pPIfiLEJ7hzJ8
 xfRrFn/DMVjhew226//YibTSTWN8i7JR/trq+USk1muoaT+BAFT7Ca/hLaWkW45QE6we
 y1mmT2Z13qd+Mshvp9sVztdcEUgljVxiWKZmAf07UYMS4Lc16YVxb3+1MfLk6iVOb5iH
 p5NoKlcetVaRNYDja3to7vnvn+Ft2vEKnTkdQ2JWq5hlByNqAD9kJias6tayU0TUWoxr
 iGTA==
X-Gm-Message-State: AOJu0Yx/HdB97sGAXI8Tt2XSe2tc/McZUzRxnagG3UtpMzq5wmt6onyd
 +qO5CBa3o63lul8ZGWrphfFCwa03Mm93XM6R1yuSqPSJJc8=
X-Google-Smtp-Source: AGHT+IFoMWPlhBCtOmnYSXXJFu3jd4UtzUg6fxaXJ1pqnm8v3TQFe5yIc0clOVbJSI2P5kt4INIb/g==
X-Received: by 2002:a05:600c:13d6:b0:40d:9336:2991 with SMTP id
 e22-20020a05600c13d600b0040d93362991mr1231609wmg.129.1704469439492; 
 Fri, 05 Jan 2024 07:43:59 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c3b8c00b0040d62f89381sm1929866wms.35.2024.01.05.07.43.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:43:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PULL 09/71] target/avr: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:02 +0100
Message-ID: <20240105154307.21385-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

[gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
avr5-avr-cpu
avr51-avr-cpu
avr6-avr-cpu

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
Available CPUs:
  avr5
  avr51
  avr6

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231114235628.534334-10-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/cpu.h |  2 --
 target/avr/cpu.c | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7960c5c57a..7d5dd42575 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -184,7 +184,6 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
     env->features |= (1U << feature);
 }
 
-#define cpu_list avr_cpu_list
 #define cpu_mmu_index avr_cpu_mmu_index
 
 static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
@@ -194,7 +193,6 @@ static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
 
 void avr_cpu_tcg_init(void);
 
-void avr_cpu_list(void);
 int cpu_avr_exec(CPUState *cpu);
 
 enum {
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3e478294a6..f5cbdc4a8c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -362,21 +362,6 @@ typedef struct AVRCPUInfo {
 } AVRCPUInfo;
 
 
-static void avr_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    const char *typename = object_class_get_name(OBJECT_CLASS(data));
-
-    qemu_printf("%s\n", typename);
-}
-
-void avr_cpu_list(void)
-{
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
-    g_slist_foreach(list, avr_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 #define DEFINE_AVR_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_AVR_CPU, \
-- 
2.41.0


