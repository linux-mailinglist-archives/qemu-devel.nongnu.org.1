Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5453E825743
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmPD-0002yJ-2u; Fri, 05 Jan 2024 10:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNv-0001K3-4s
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:45:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmNs-0003hg-71
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:45:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so4014495e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469517; x=1705074317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35Qj0GQ7d4D1oUKsUxN1TKydmHhPRhj2Vw6etTCLPUc=;
 b=SXSzjN5zWyCXIfuZZULVsIf/YAdeDLpQCLtYiKQhEQtIHCOg/tCEsdJN/o+54bniXf
 yxCOPKOOmUMnEo+/5umcL85i2lGcovdlzX8xbcn9evrNe7kQR+4piIgVl1P9rldaiL9f
 Y10HYqmNWsjYgE/jhxw8Owjwv+s62l145nLxzWuyOZBAHgSyOfQ1VVmttTr6ns2New1C
 o8N0VNsBPdGTbDdABtt5Z4wW67LwmimbgAuCpVl7ZEe368NIYezMmtJ04nlc7koX8rmt
 gt8CHJ4ZFgksOIBFouDmTwHKsIg+Xy5CnWtA5RBSrstj4WzONT+nHi9cy7BdQI4oR7D6
 66mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469517; x=1705074317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35Qj0GQ7d4D1oUKsUxN1TKydmHhPRhj2Vw6etTCLPUc=;
 b=rI1PjeWD7HPnLNdjd/pv+ks14VynZnZDXcmh48ar9WE0uSKN4DiJrVxV2w0tY6j6p6
 IojGqhdjfIkkMKF7zgfV0JHHHtNJ23oXix4v6p582xZ+gVGFmrkPE4avyvaNThQ7CRnc
 5NDcpFGuqSy8ebSnwkC44erfo+6+1bbu7nhDGE2idpkN2Xx2gTTzCuAadGjgKOX1HNoO
 /beCDF187zW0ijGy9Cg19GyMHQNSYe7Sn5QSjTo4jeRWmNmVvb3afCUut4VbEvMBi/v8
 ujeBk/ctp2Fq3wnEWCS9Wpz8FWQfu+QBmUpHHEchoXesUAI+FcPsZGLVK92c5DZHkFyB
 zxFA==
X-Gm-Message-State: AOJu0YwK431/0YqEDl2g+u2f8i20qNYjn32GVNWS4wnhdjMbgLOh1aim
 rhtUmaXAr4w9YJDRjtu54mX9w8q25FPkDXMXmsERZ1iu0dk=
X-Google-Smtp-Source: AGHT+IFe4K4/RmO4+KF8oeY7r8n8T6mIXktmgY9KuOOOsrOrRMOXl/6b9lN4Esrd8XfJmPp0isCgPg==
X-Received: by 2002:a05:600c:3482:b0:40d:922c:3fa2 with SMTP id
 a2-20020a05600c348200b0040d922c3fa2mr1276114wmq.166.1704469517228; 
 Fri, 05 Jan 2024 07:45:17 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040d8ff79fd8sm1942471wmq.7.2024.01.05.07.45.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:45:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 20/71] target/tricore: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:13 +0100
Message-ID: <20240105154307.21385-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
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

No changes in the output from the following command.

[gshan@gshan q]$ ./build/qemu-system-tricore -cpu ?
Available CPUs:
  tc1796
  tc1797
  tc27x
  tc37x

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114235628.534334-21-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/cpu.h    |  4 ----
 target/tricore/helper.c | 22 ----------------------
 2 files changed, 26 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index de3ab53a83..2d4446cea5 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -246,10 +246,6 @@ void fpu_set_state(CPUTriCoreState *env);
 
 #define MMU_USER_IDX 2
 
-void tricore_cpu_list(void);
-
-#define cpu_list tricore_cpu_list
-
 static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
 {
     return 0;
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7e5da3cb23..174f666e1e 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -96,28 +96,6 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 }
 
-static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    const char *typename;
-    char *name;
-
-    typename = object_class_get_name(oc);
-    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_TRICORE_CPU));
-    qemu_printf("  %s\n", name);
-    g_free(name);
-}
-
-void tricore_cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_TRICORE_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, tricore_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 void fpu_set_state(CPUTriCoreState *env)
 {
     switch (extract32(env->PSW, 24, 2)) {
-- 
2.41.0


