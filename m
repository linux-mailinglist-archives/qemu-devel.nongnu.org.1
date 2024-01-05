Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DAB8256FE
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:48:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmN2-0005ou-B3; Fri, 05 Jan 2024 10:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmN0-0005k7-6P
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMw-0003IG-LX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso16264625e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469461; x=1705074261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJb6ytKuwy0SF9EvoPkrRPYTidmv1mDxbmTN6G8AydI=;
 b=cfSamfYJHvttQZI8Hlw7NrxUWt7IHcgswNdOC/7jRPSGjPJHXM1phYlj9ij4zeBhbY
 Cya5Vxqm9tOIKMuuQxXhllcdJ7fzv9wPQyab0cL0ToP63txI8j1McsX3uSDkobRUmi+M
 iqGXG3/WJwfa9d/J4w9pXLFuqaz2OKeBUp3bRHlq2Zc3kjfz5kyEHDZyWXOeAdPaOl0o
 yCMjFSoy+s4iboDDITIqpKbW53XQuhMNijTUSUTE0bZPbPRv8yc90prpbWYGU7otXYws
 9n/huM3w2FpolaNrWj6MayhMopyZhsxHCh9btHLmZQAKa29BWrFwS9DdWYKZUKE7aPtL
 N7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469461; x=1705074261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJb6ytKuwy0SF9EvoPkrRPYTidmv1mDxbmTN6G8AydI=;
 b=ijxEVL+EazjW7E0xFb3m0BMRi4SO+NG2xWeWU+LCEGtKcRA4qFxYf7EDWlFNWL4P5H
 5qNF/9rc23eUrMRH5QKZf87aF9hBShqo41AFgqE+GT77+ZO9I3Kb9ntUmjWdtJSSOWH3
 myvwYm6ceay8epUu+HqUyLDzcoZiJrQBkxvNA2gMsZF8CRZafLCmMROetThZvf1KBQQf
 Aq+19zJfqM6ONVV1UTFFitC8K8HIT9+a3742H7mWPDGt/VLs8YVZG6XNiKPeCHlUL0R1
 tgDkIusLbmyulFN8GjU4aLSM5TX66fuTeVHfQJ24OIrhL0q45vVMvWBtuaK5m+ZSoLsw
 cxBw==
X-Gm-Message-State: AOJu0YxLpatEp35OAXmntXJm63Dza9iR9GqHrSboZwXcTapCuC7Y3dm/
 AyKbOxyxuNZGw8T7mDXP0xZuV93PCU0em9src+MVrQbnd0c=
X-Google-Smtp-Source: AGHT+IHbNwcC5okDDf21DaohbS/Vp64n4dA2Gl1RkPxFSRWlStomC5wqXhjZoxPUzXg5u/tF2EO4Mg==
X-Received: by 2002:a05:600c:a001:b0:40d:5e0e:8648 with SMTP id
 jg1-20020a05600ca00100b0040d5e0e8648mr1228913wmb.159.1704469460842; 
 Fri, 05 Jan 2024 07:44:20 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 l3-20020a5d4bc3000000b00336843ae919sm1609483wrt.49.2024.01.05.07.44.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:44:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/71] target/hppa: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:05 +0100
Message-ID: <20240105154307.21385-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

[gshan@gshan q]$ ./build/qemu-system-hppa -cpu ?
Available CPUs:
  hppa
  hppa64

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231114235628.534334-13-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  3 ---
 target/hppa/cpu.c | 24 ------------------------
 2 files changed, 27 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8be45c69c9..fd659ca88b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -402,7 +402,4 @@ G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-#define cpu_list hppa_cpu_list
-void hppa_cpu_list(void);
-
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1a5fb6c65b..e1f252cc45 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -164,30 +164,6 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
     return object_class_by_name(typename);
 }
 
-static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CPUClass *cc = CPU_CLASS(oc);
-    const char *tname = object_class_get_name(oc);
-    g_autofree char *name = g_strndup(tname, strchr(tname, '-') - tname);
-
-    if (cc->deprecation_note) {
-        qemu_printf("  %s (deprecated)\n", name);
-    } else {
-        qemu_printf("  %s\n", name);
-    }
-}
-
-void hppa_cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, hppa_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
-- 
2.41.0


