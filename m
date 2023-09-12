Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F679C7D5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxa6-00039f-M8; Tue, 12 Sep 2023 03:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxa4-000366-Ed
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxa2-0006eT-6Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so783129b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502781; x=1695107581;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEKtDuASEWKDvEP+xkUOZezCbwlPMpFkAjXmA+mjC/E=;
 b=r4CMOwG+yuKy6Jx0F6jMaxaYZYDW8pD9lLMFRNNIvQrECuch+DAcmnd/ci6e7www4S
 s8JUulE/y3z9CdcMxC+Z9mxoVn8FR6qoRZLKJgHEqjVRtERMzq181wY9SqmB0FzCSEeV
 ILaMXLhwVnKxhgWtj3qCafnF7TVazvDawcaMhpAbvMP7lEiLNEwHd7h3ac3Ocun/Tjyx
 Dau3AeKduGxL2Crs7uFk2DYB+5WtFo/IP6nTU20cUCgP7uEh/HtHOTHptrB3TcDvXGrV
 wWSEw7duN2HP5pGUMfk4ydsg+oILfCjmnk+c/1UaKpgABNYg8YoCbjddcYvhJCdogXPN
 Ek+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502781; x=1695107581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEKtDuASEWKDvEP+xkUOZezCbwlPMpFkAjXmA+mjC/E=;
 b=GJacXXHDhOcsU+247MCX0JM8fytlqMG22xC9ZdBS0YBK1f2MMdzWPqTrySl9hQ1loh
 8jJM1NqlCFr0HXT0WXInbID54Aq7C+T1evfi4WvDTfXfZvkCTlnubr6i4nrGLDntkNZY
 QTroPMPAJBUb6wh8ChytXzkgKzqoOrxPr4EEqIOoMD9i1phACuahL5S3jorbQ/xrmM2X
 YHybJolIyVDZXtJ6phn9Sb5IwxGsO9Zj6XJydUzhYd1uEr3pciKrm6DNiOgM0iaHFIjp
 1be1ig2NDt/NWbWP68hJyRpovOGaMI9SGaZrv7Wlo1dUqB7WVkn9pFaN3p+NGDxRkytG
 aQzg==
X-Gm-Message-State: AOJu0YxWnuhrqYXB8LcJTupLkmNYMlJRpp4WovIJlhLOFohMClH6t1tM
 U05z221dBBliddwGPOzLtyMKdz47tMkXqyzrhPQ=
X-Google-Smtp-Source: AGHT+IGm3JEK1jdqBzv8DJLPHLnpVZ3XigDkMy4s5I4nrD0mkX5tUFyvv8wbBgollAt2MMNBOkO7pQ==
X-Received: by 2002:a05:6a20:158a:b0:13f:de94:fb97 with SMTP id
 h10-20020a056a20158a00b0013fde94fb97mr2185870pzj.27.1694502781090; 
 Tue, 12 Sep 2023 00:13:01 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:13:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 13/18] gdbstub: Expose functions to read registers
Date: Tue, 12 Sep 2023 16:11:59 +0900
Message-ID: <20230912071206.30751-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

gdb_find_feature() and gdb_find_feature_register() find registers.
gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  5 +++++
 gdbstub/gdbstub.c      | 50 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 340ab35d74..e6ba2a2886 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -69,6 +69,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 60faae8b2b..fc780ae6fe 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -492,7 +492,55 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    GDBRegisterState *r;
+
+    if (!cc->gdb_core_feature) {
+        return -1;
+    }
+
+    if (!strcmp(name, cc->gdb_core_feature->name)) {
+        return 0;
+    }
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i + 1;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const GDBFeature *p;
+    int base_reg;
+
+    if (feature) {
+        GDBRegisterState *r =
+            &g_array_index(cpu->gdb_regs, GDBRegisterState, feature - 1);
+        p = r->feature;
+        base_reg = r->base_reg;
+    } else {
+        p = cc->gdb_core_feature;
+        base_reg = 0;
+    }
+
+    for (int i = 0; i < p->num_regs; i++) {
+        if (p->regs[i] && !strcmp(name, p->regs[i])) {
+            return base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
-- 
2.42.0


