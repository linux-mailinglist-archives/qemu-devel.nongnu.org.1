Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6C8256E9
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:45:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmMU-0004dk-KX; Fri, 05 Jan 2024 10:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMS-0004cz-F5
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMQ-0003AO-9J
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso19526265e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469428; x=1705074228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLV8uDs3E9nSqverOGkh+8mNeXXqUDlTZQBJE1rP3g0=;
 b=SKcVvpLX5hYD/oCShDsCadOdmGIZpC29ktiYlOnsidG8LcdFmOvFmSH1QEuhh/qESa
 YYPGBWkW2a1rPzYYFglCaIbw7bnOZJw0joqB5Kudwh1BN3duuCilg9ORZ4/nGBnXCjA5
 BKZKh9/wDUHQIbVidQMa9V9a6t/iO9S+jU7y4NC9ecaLfJxJ/0uOaoffaKvLR75JTPJt
 +IpnIYY5Cdtv3zgFUSH1U3xry7p0AYApE0oc9BCO/SAavCZaIv9RUgjp2ARlmcKOwB9T
 vxjD/J/1iAdHvdCqXWaKzR3pb0QbEjR4EFELolDRJAFV7ufficbheNvpRmMPHhto/OXv
 KjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469428; x=1705074228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLV8uDs3E9nSqverOGkh+8mNeXXqUDlTZQBJE1rP3g0=;
 b=naGuM6t1v4v1oqIDrss44Mm9+iNDrU4orwTFC1qW8D6/GjZ064ga140FimuAxj+hBD
 ptLlDo5F1V/f9+KddI5Z61ETODKu/Vcu5NvlEN7jgjwtWka3jm3a3/kvaDFJ9RNKr/ow
 Jm+Oc5Kq+jdOzrDqbR+7f4mCG5UCaxyDf9Vjo7hF/V5Z06HbfHVlVcInDitBEP8GwREt
 ieS9XNN36pg9DQYbHyulGjQdIz21SujewSudTcO8N5rIRi2agit/hxFWHzFGWcDVLnng
 xRHJ+SfMscrwHUWowh75KaumYmUDa3idDIU0uqXJsSKA8iYW47I6p/X4ZsDLPAEn/Qix
 DwYQ==
X-Gm-Message-State: AOJu0YzsxTNIP2d+gdt9xgzkEKQCYL9bEnkMHmyRRtpAPUGk+rJ9wLOH
 jlTMq/3gallDIsdz5z/rNHcw92K5k/K0hqg0cGx98/SzrH0=
X-Google-Smtp-Source: AGHT+IE9W+bwzv81LqReK2b8RnuBqkC9QkppVRtHF2hIbPI72uabkye4qhdaPPLzE+C38Xw8L+SGMQ==
X-Received: by 2002:a05:600c:a45:b0:40e:3511:2c39 with SMTP id
 c5-20020a05600c0a4500b0040e35112c39mr1353505wmq.172.1704469428691; 
 Fri, 05 Jan 2024 07:43:48 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 k7-20020a5d6d47000000b0033725783839sm1599738wri.110.2024.01.05.07.43.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:43:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/71] target/alpha: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:00 +0100
Message-ID: <20240105154307.21385-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

[gshan@gshan q]$ ./build/qemu-system-alpha -cpu ?
Available CPUs:
  ev4-alpha-cpu
  ev5-alpha-cpu
  ev56-alpha-cpu
  ev6-alpha-cpu
  ev67-alpha-cpu
  ev68-alpha-cpu
  pca56-alpha-cpu

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-alpha -cpu ?
Available CPUs:
  ev4
  ev5
  ev56
  ev6
  ev67
  ev68
  pca56

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231114235628.534334-8-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.h |  3 ---
 target/alpha/cpu.c | 17 -----------------
 2 files changed, 20 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index d672e911dd..ce806587ca 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -292,8 +292,6 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-#define cpu_list alpha_cpu_list
-
 #include "exec/cpu-all.h"
 
 enum {
@@ -441,7 +439,6 @@ void alpha_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
 
-void alpha_cpu_list(void);
 G_NORETURN void dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 G_NORETURN void arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 83345c5c7d..b8ed29e343 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -87,23 +87,6 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     acc->parent_realize(dev, errp);
 }
 
-static void alpha_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-
-    qemu_printf("  %s\n", object_class_get_name(oc));
-}
-
-void alpha_cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_ALPHA_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, alpha_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 /* Models */
 typedef struct AlphaCPUAlias {
     const char *alias;
-- 
2.41.0


