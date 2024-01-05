Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938DD8256E8
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:45:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmM7-0004QK-EW; Fri, 05 Jan 2024 10:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmM1-0004Id-Ii
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmLz-0002zA-8y
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:43:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5ac76667so12842245e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469401; x=1705074201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrhO0fF/4wCYRBDkij/JpNIZFZJdEux3joJ/5vLZ4GY=;
 b=bwi3kpzGGNXCOg+20oW7rcdO6hXQlCRbkxobFttj7cxuRBleMFixnF2Ffg1G7TqmrC
 zyWrEFwzJZGrK8EdQzJLdfazNeoKvWs7HZK2MNvl+tD56VzMbScGxjlhxq6K0NZAIP3H
 GIt1Fq4zu/EwWdj/2oNgAA9VaZWUBLEADJkyV34Oyt+MtzQ+plYOnI4DGDXL8SentVz0
 upHwkNMV60xGHNiqhX1Bq7nmm3M+3eanaKYgES8SO3B+eS6NqQ5jw0UFfxIL8aa6EwxO
 YHBPIxJlKa+zxEEMbe4jnbi4w2Oy/+63Hkwin2DLwSWNVdOesNH0kVhn7t2w5Pc9YWgd
 Q7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469401; x=1705074201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrhO0fF/4wCYRBDkij/JpNIZFZJdEux3joJ/5vLZ4GY=;
 b=Cn/l0Q3ntTjnh7ez5KmpVWZ1ED+XoS16rJzqm3YMBJv1dyP5GHo99bpxDyZ7OWe2le
 HQsk2511spyUlRhL4MSJMDuJvEdGE12Jz+JOD+euyxWh3LC5xe2XgxY2ZW6IEAZLwt/2
 xNt+Jdej/aiJPT1hV1J5h/ozM3ccmPYb5BDILZf8ClaW3HKo6MQFN5JEQI0XrUBWasil
 L1dwZexkhJPPr8Q5qNTaVHz2QF+UGSqpXMCJS+8IR6230dfmlp4F9PIIn5jVdgvyjD7m
 nJK+TYUXpNxVemaI0T2A9Im0q2dij03hTl78V+u/okFtPIpnd41FiJgdQEha5PgrhGES
 2OBg==
X-Gm-Message-State: AOJu0YwlwbvmQhgNaVb8HiBOj3094WCcyI8yV+87zOBkbVLTSIBOtdMP
 paRia0zJ+QJguhI3r9TePUq2ZXz74AimxZi/sCt5c2ROfb8=
X-Google-Smtp-Source: AGHT+IHxztSSE/NnhY4IOTid4JhG7CbAzUhLc9/SoRCe3oHUBTcxxyGJGlHE4o66X9PU5RD/GKJPIw==
X-Received: by 2002:adf:f282:0:b0:337:39e3:3b71 with SMTP id
 k2-20020adff282000000b0033739e33b71mr1335279wro.74.1704469401108; 
 Fri, 05 Jan 2024 07:43:21 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 f11-20020a5d50cb000000b00336ebf27d59sm1602952wrt.78.2024.01.05.07.43.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:43:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 02/71] target/alpha: Remove fallback to ev67 cpu class
Date: Fri,  5 Jan 2024 16:41:55 +0100
Message-ID: <20240105154307.21385-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

'ev67' CPU class will be returned to match everything, which makes
no sense as mentioned in the comments. Remove the logic to fall
back to 'ev67' CPU class to match everything.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114235628.534334-2-gshan@redhat.com>
[PMD: Reword subject, replace 'any' -> 'ev67' on linux-user]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/alpha/target_elf.h | 2 +-
 target/alpha/cpu.c            | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 344e9f4d39..b77d638f6d 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -9,6 +9,6 @@
 #define ALPHA_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "any";
+    return "ev67";
 }
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 39cf841b3e..91fe8ae095 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -141,11 +141,8 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-
-    /* TODO: remove match everything nonsense */
-    if (!oc || object_class_is_abstract(oc)) {
-        /* Default to ev67; no reason not to emulate insns by default. */
-        oc = object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_ALPHA_CPU)) {
+        return NULL;
     }
 
     return oc;
-- 
2.41.0


