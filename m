Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A97D17A2
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLr-0007ot-7t; Fri, 20 Oct 2023 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLW-0007jT-T2
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLU-0008Ah-Ei
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso1217932b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834627; x=1698439427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ/zP1DZL3tOaBi0pMnG+Bu7Z8qJlO2g1403oqO8/6Q=;
 b=wuk7oFPqhIz3yPG/9A0KHnrSczKZRyia8Y0LPGe10rSnC62Dej9QGdsJ0oJDwEOxIO
 9k5GnaQSRL3sAMhJg+g08CuhgvX1vkKCM+uRx0PnmUn9hIKKgZNab8zz0KHZarb81G5Y
 ie0COGHczahwG28MLAbGb18PoqcAXLFVAXAa6ogLQ5TmMHSus+jCfobVLgPgyyh520jV
 1GU2C6fFXMxxP1e3DRba8u80zdotxalkPiYYxaJlr3oGdsnZLe8MV8EI1trcZgG5hiCD
 DyCcWRWQsU7V65y+uNbAPd9hgwrH7UrJeds5fHnLFsGwM2ahnREWRIk8okwP0leHAqKk
 4Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834627; x=1698439427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ/zP1DZL3tOaBi0pMnG+Bu7Z8qJlO2g1403oqO8/6Q=;
 b=QShsrzu6x9y9yIBJZLHbhP6jaKRioztcKfFWwFbhuA7/9CLSL7CG+ulGoSR5Gs8ilL
 nzK2PL0OkK9spP+MshLA1n+eAaOc+n45mJyDyFAjdsdPcRn4BiA9xFWCZ3toQrVf9N+g
 TstagrX5LwYsOeVYGMwyvddeo11rVsVnKrco1xVe/X7W2Pf5g/ZSD7ZQ5rQGylMGPlAT
 ipRI6Uwp2jMiJdhEsx67v3f1YGrHkJLEnphlgUPh/wyoG48wLbiWoK29QyVeJZ7ddzJ/
 hY1VcS1l7fc64JwSx3VqPJnbRv1ULYoX/wNHvO+DtZVdC4DOK5xxT6Y8EG+HFXJKu0Mo
 E1dA==
X-Gm-Message-State: AOJu0YxNcOj6tDYQitb59ZpDzWep98rjV3ul1/ct8iEtcJ+geZxV/ySw
 ERipmv1oRbaLfPw+qlvNEtLK3Nznhkygve5saRs=
X-Google-Smtp-Source: AGHT+IFKTcDkMXnrirOAXHvQ1Ye3kFGIj40uJHHsYoNZwCGqCBg6kM9epPkL+zhuZnhLo19Z/O5DDQ==
X-Received: by 2002:a05:6a20:5481:b0:173:e36c:6d03 with SMTP id
 i1-20020a056a20548100b00173e36c6d03mr3600808pzk.22.1697834626998; 
 Fri, 20 Oct 2023 13:43:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 15/65] target/hppa: Implement cpu_list
Date: Fri, 20 Oct 2023 13:42:41 -0700
Message-Id: <20231020204331.139847-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 60fdd9e295..e087879399 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -366,4 +366,9 @@ int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
+#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
+
+#define cpu_list hppa_cpu_list
+void hppa_cpu_list(void);
+
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e1293857f5..b063255b30 100644
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


