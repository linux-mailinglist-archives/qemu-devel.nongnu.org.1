Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 087BD7CEA7A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESb-0001a9-T8; Wed, 18 Oct 2023 17:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESF-000172-VA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESE-0004Ox-AI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso5392605b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665908; x=1698270708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHeZQ0Lg4r7zm7nc2BLDD9ln4Dja/Hc81cMiyiTh6zw=;
 b=AhUp6N7kuWu2/psqdAuyMZUv40+lHb/uAkK8tVvF6wqkIaQnaXVrb9JzrC+lUFHtIk
 INiUrquQM64Szykrl8Exj8Gf3N6WfddGgv3lizC0om/yXtOAFz+ENJcQOWM3AouNOXP8
 vsDkVG93DZLq40m5KuiFmpxPigznWT0hndPJi5xrpAjCZmztViyNKCwPJjNoeyAOct8/
 agSYvyeySjWFY+2xChzAqDLP5peIMv3iFlCIofQmF0zX/hyv2jDS6xbFFnAckEtjbxyN
 5IC0CJKJHU0UCOpRXyJD7wfyNAQc6/hlIBIIjPBHm6quUuImJc109GeHGsG0aB7lzH1p
 b4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665908; x=1698270708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHeZQ0Lg4r7zm7nc2BLDD9ln4Dja/Hc81cMiyiTh6zw=;
 b=J4r0W8bYg1p/KP2L7l1SewdgcxmMzxbGtx8+AlkyuK+DMCNLGgoppxy6FJ5KlmRCqI
 zY6NMAYj/S/ZQhyNs4ML8AIXsW5J4PZ8VrvVtjTq5uA8ZALs/JIeHQavqo7JZkxUvpqp
 1v/XdGYP7CZAEmqRdVM+lYBguZTCwmlJ+v0AaJaZYsqUDmXQRzLc68B4/2Q7TU0DqN2G
 6l4ZbgoGbQ5JVButuXtqvGHYVjZ/qOR8BzKzaiFPo6OgAm6psVbkopZFbTcsZM0yaQ/e
 Yj0S+YqUW1/5FHYqzyeGGRDW9Pg4jSm4bOWmCF7oFFtHpfP3k44sWnyn97g2h7D+AD38
 TpJQ==
X-Gm-Message-State: AOJu0YzyLs7++w25+3fSCLCeI+vplC9e1S6BGPCWhiMBEw1BUvjAAjW1
 F56GU441mR/BHpDIHsac+T9cG4/IUgPTFtJ5AKw=
X-Google-Smtp-Source: AGHT+IGJ5zb5kHuZnp8OGMekbDsn/PmPflEOkpzuhsu6Lo1jH2cD9ODy+X4zUkLVk/vUJ4wJBUgl2Q==
X-Received: by 2002:a05:6a21:7741:b0:133:d17d:193a with SMTP id
 bc1-20020a056a21774100b00133d17d193amr382198pzc.59.1697665908207; 
 Wed, 18 Oct 2023 14:51:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 14/61] target/hppa: Implement cpu_list
Date: Wed, 18 Oct 2023 14:50:48 -0700
Message-Id: <20231018215135.1561375-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 22690e351d..30010858a9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -365,4 +365,9 @@ int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
+#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
+
+#define cpu_list hppa_cpu_list
+void hppa_cpu_list(void);
+
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 41abdb04d0..1975aa9621 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -162,6 +162,30 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
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


