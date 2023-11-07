Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B527E33FA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPL-0000CH-EY; Mon, 06 Nov 2023 22:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COP-0006qA-U0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO8-0000ft-3x
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so42166785ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326263; x=1699931063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kCzE9vIK3Nn7Qq8eXaj04fpM94BoNvhV6PxkUb5Tir4=;
 b=pt5thI+LYafecUrPP0gGQRX7n6SgVnrJv/80txQ4Tg+FVzNk9kqkkDgYVrEusNs6mx
 QjK3s5UloK1kr615BRQPIfqWLksm+ed4SUM3uafUqzo4koDGhalm/HcoYj2l0A4CW0Fj
 9TUr9o2dGhrlzHyMUv2R8xN+0wumSjFBptXIUHTRabqrDGf5aAK6e3Um+99fF/q8Wf2w
 7/w8PoI+sDyBaZTk0wLRFnIldJJU27yD6XOHWFBa81dvvhZ/yCOosnH36wbughSsvirj
 K72wlsSLwRRguDww/FKQk4n+/9nKbNpzZ1mZNBPebBwrZbTq/7sM4tN9YTEYhVjqL+lp
 NmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326263; x=1699931063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCzE9vIK3Nn7Qq8eXaj04fpM94BoNvhV6PxkUb5Tir4=;
 b=bM3dJ85t95yz23bPhADzKzIQHdBgPnQb7HEHeBdKvaha4b7eX80kdConJ7oafmNBr+
 W/qlUo7qHvQyG0F86B+kZnihTKxpmcZfEGw33+451vmy24dstfwgk00JKe0ytBie5Cv8
 Mtt0mifRnf4bQQgfuhyvpLJUlxYpvd3zlCkEGhOWbVCIL4kex5eAh6/d8hhyhjJbZ08O
 XubMS0GFKg6OcfYxIdTNY7CjmVD81QTfI8wKsKECqGpY+nDqjTm30aVnxd9OXuCnFVQf
 c6p3VLBvTCjV/tzzDmvttfA9friOPzXmy7AhsOcXk8A8+56dZmHfr4165Hc+ig4U5hOX
 IJXg==
X-Gm-Message-State: AOJu0Yz32NGLXySoBNGupbJAX3NfkKw00nyfFaGKzgWCzAWXgrIjqPZ+
 NO1eQQzCYiVkR7WRbFzyLbigpIuI98r95HG5xpE=
X-Google-Smtp-Source: AGHT+IHktNru29D+jL/++C73Jkx0KMjGT7+UOP+sJ/3Or88OjRUs7NoYPt6noY43tUjPEfWjKYmW+g==
X-Received: by 2002:a17:902:ea0c:b0:1cc:56a9:e8d5 with SMTP id
 s12-20020a170902ea0c00b001cc56a9e8d5mr21320899plg.15.1699326262923; 
 Mon, 06 Nov 2023 19:04:22 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/85] target/hppa: Implement cpu_list
Date: Mon,  6 Nov 2023 19:03:01 -0800
Message-Id: <20231107030407.8979-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


