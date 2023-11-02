Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87C7DEA1B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYK-0005q3-4S; Wed, 01 Nov 2023 21:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXl-0005kX-2m
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:45 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0001Yp-6r
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d9a398f411fso398504276.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888635; x=1699493435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCzE9vIK3Nn7Qq8eXaj04fpM94BoNvhV6PxkUb5Tir4=;
 b=p75C7dVNmLwWrgC8uSEzYc5VXZKrvjZWZxSlzBaw7mTb8Xc5wNYJguBlKK+fyIaKgw
 BeuOfzi0Db+SBrgXsl2jX/HzLF4Oa6jI9vn2PNjR89jHM6Uglz+XuxzCiRI5P3yL5kji
 UQRCObYAeGMZGZfdsD9SX4sb6TZBoszrcTmF6B/wdzJpPM8tc1PKUoSoMoupcyjEE/jd
 E3lNHyQP+HMLN7KGcUxDjMws93BFr6NiSkKL8xaN/RhQHYrMK5oTcGV2PCWA2m+zGa3r
 xd5Cq+2cI2WmECSaI6gZWCzCX0nH55G32ni3cwoHE7mC3zWhAWScD+nD/jR6tiwMXg7g
 xGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888635; x=1699493435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCzE9vIK3Nn7Qq8eXaj04fpM94BoNvhV6PxkUb5Tir4=;
 b=cZW1Sy+YCAPYShTy6zaPtpBst3O6R/hevwBOivtLDhEaUq3riXjiKvZfXWWBFoblrv
 IYtvDn2kRZ522pcQzP2wa6kzqbt0jeE7qFjEhgDF9cAo1xzDILKzau+J1Zsefadd7g5m
 e0Rw1sSrQWD4uJm13h1ZYTGhwIMKZmXnK85eGBIsjW/oKDWIy1P9DvRAb6pAQlX145/i
 ejPLgPAoKj3wf6e+drHCl1FHTbFeTfd5D8jQ8MXd39jqmHrirPHnW2ZMys6rYWS9oKJc
 ZRGanDfpShwOs1JGOo1oq1Xk81PPy9MXjqmUIF9hTy2EshLPeZfsf1K+IvwDfSnLgtX8
 OIlQ==
X-Gm-Message-State: AOJu0Yx2HsbvDI78VA8Fts4u6fAZbUnjbEIPB6LtYBaZXTB0nQX/M17U
 MqjAZ9aeTEj+gDCHzV6Ab0+9UDUd/zP27I66QIk=
X-Google-Smtp-Source: AGHT+IFOJEUclkJcjJ8x6g2gMpsIXPWtvudRj8wpblRjDeQ0EeSRlcf1UziPf0ln26Bvr2jgR8oqwQ==
X-Received: by 2002:a25:d113:0:b0:da0:3938:7ac6 with SMTP id
 i19-20020a25d113000000b00da039387ac6mr14799693ybg.15.1698888634975; 
 Wed, 01 Nov 2023 18:30:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 21/88] target/hppa: Implement cpu_list
Date: Wed,  1 Nov 2023 18:29:09 -0700
Message-Id: <20231102013016.369010-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h |  5 +++++
 target/hppa/cpu.c | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 48ddcffb8a..301c82114a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -396,4 +396,9 @@ int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
+#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
+
+#define cpu_list hppa_cpu_list
+void hppa_cpu_list(void);
+
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07fae42bb8..27c74f0d27 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -161,6 +161,30 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
     return object_class_by_name(TYPE_HPPA_CPU);
 }
 
+static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    CPUClass *cc = CPU_CLASS(oc);
+    const char *tname = object_class_get_name(oc);
+    g_autofree char *name = g_strndup(tname, strchr(tname, '-') - tname);
+
+    if (cc->deprecation_note) {
+        qemu_printf("  %s (deprecated)\n", name);
+    } else {
+        qemu_printf("  %s\n", name);
+    }
+}
+
+void hppa_cpu_list(void)
+{
+    GSList *list;
+
+    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
+    qemu_printf("Available CPUs:\n");
+    g_slist_foreach(list, hppa_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
-- 
2.34.1


