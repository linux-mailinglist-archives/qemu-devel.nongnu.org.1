Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D97DEA47
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXp-0005kx-Py; Wed, 01 Nov 2023 21:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXi-0005ij-Mp
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXh-0001a8-87
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso456202b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888639; x=1699493439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Exykv+xKuErtsZmUvO9DLpku6Bz9Jw3PAqZ735n9fU=;
 b=C+1pZnEQK2LLMu7qmDJ6UUNMUqCcnjXLk53F9sALIWf1l80KGdluEQXTiteqSKmewb
 ga3MS3sSY/FJV+uSHlOeSvX+SD3XcAfqhvbSRTxM1mpb12j8dVE2VcGx0HvJ/+qoRDwa
 C9GN3Jbzo4Qta4lqt7m7JzpdAsXFbjBNAYgUjeuJGjBJfMl0SENQsF5aKxaLfnP5zIDH
 jeRiI40li15oSx6i2eP8H4QWSCPwJf5TLzuEVPTql677pm0Gp74C7Vfke1/zknzxir0l
 xIBdpli+P94ga2Pw9bnhPvnef9fwcxjk7bVtDzRadxJ0FjH/OvqPk7Nvz3cbRPMuT5ao
 Xb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888639; x=1699493439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Exykv+xKuErtsZmUvO9DLpku6Bz9Jw3PAqZ735n9fU=;
 b=mTReqgIDFtfwup+orDU5a+VmywQYsRHT/nrzlow/FXNbgsaqvKRa0fetJY0ypr9wlI
 QpAUZpNGqABk2pXVrp5XUB9wpXANNJtr6dKVEHuJpCX5QnIS2guJEYKqFF/dbFi5QggF
 TVRjThzLrvDeqQgjbHsX4+OZx0CRQV0WMDVVc/dKZJ8oK4ueP6Dmh6oi5RD93h6gfRl1
 +Vvks+NS/k0Rigi1THQdn5zsW+iaBZCzcxyeMNel6fV0AffDQtm84+g6xZnwrI2T8lxy
 9WhH9fFcZa6SFl97bSfqFjuoupaYXOwNwV6gxqk9Ho1VAmUZ8zCysmL5DFn8+UoZgm3G
 r/Ag==
X-Gm-Message-State: AOJu0YxyvKYZrYAp81vAYKfVHB0ZNRFIty45Wc5BOCLLHCuhMw/qEhKU
 8G+P5jdfSvt2Cpi7XmD+QR9XlfFhhXHdcAucRS8=
X-Google-Smtp-Source: AGHT+IFRApAQbGiGzHYnJKX4kIoMYByG59hozKyurXwc9AJh6g9wb/gNAYtWpkvn+l5CpqXWxafNpA==
X-Received: by 2002:a05:6a20:8e2a:b0:174:63a9:293 with SMTP id
 y42-20020a056a208e2a00b0017463a90293mr17273056pzj.48.1698888635809; 
 Wed, 01 Nov 2023 18:30:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 22/88] target/hppa: Implement hppa_cpu_class_by_name
Date: Wed,  1 Nov 2023 18:29:10 -0700
Message-Id: <20231102013016.369010-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/hppa/target_elf.h |  2 +-
 target/hppa/cpu.c            | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 82b4e9535e..19cae8bd65 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -9,6 +9,6 @@
 #define HPPA_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "any";
+    return "hppa";
 }
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 27c74f0d27..70ce0c3b99 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -158,7 +158,15 @@ static void hppa_cpu_initfn(Object *obj)
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
-    return object_class_by_name(TYPE_HPPA_CPU);
+    g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
+    ObjectClass *oc = object_class_by_name(typename);
+
+    if (oc &&
+        !object_class_is_abstract(oc) &&
+        object_class_dynamic_cast(oc, TYPE_HPPA_CPU)) {
+        return oc;
+    }
+    return NULL;
 }
 
 static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-- 
2.34.1


