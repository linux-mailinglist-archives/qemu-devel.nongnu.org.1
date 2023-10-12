Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8E7C64DD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:51:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoae-0003OJ-38; Thu, 12 Oct 2023 01:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoaZ-0003Ez-Lf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoaX-0007RP-Uc
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso5165075ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089824; x=1697694624;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWuKUcnNqKUWxMqg1EexrTswIw3aaRaQhxy6IrnDyPU=;
 b=2RCQ4mTvDHfJznJOTdIicAgIPgJSwv+7a6O+hk68N4Btqqz8xjmT9oOE4kld6OQYgR
 fGG57sysphXsXG4sesVUTxSQq4p9kSeTshhRSyqzy77/OSO/U0X8c4TJ2jOUZEZBiDHn
 3+UdaZtbfKONVCgBq3zW1yKH+Bo8Y08i0yRCSMh53DR0Pzywz02nR1K+KbmEunfiu5ER
 mx8s65p1il4LeV+9wvQpzfRtpvL0yqgnzVLxh2PdVvU7+rUImSzfz5LEWkxgHFQvUCwz
 lTtbTvdcFCqnpQOUSxOrUif1I+l9yQ/5D5kC5F+HMGY7u0q5Z9hqbHLyOLmrRWTwfuRE
 gwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089824; x=1697694624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWuKUcnNqKUWxMqg1EexrTswIw3aaRaQhxy6IrnDyPU=;
 b=QzFGKeDfFdVXImdyX//AZZQ2j86F/3pvh2V/niD1jUE1VmNoM5ksKQUUSJ/c9p+apy
 g5dPTEmsfsXdfzfw3nUhrWhWHUOtqtooIGjv+phEJSuIw9G5p8poqzWH9pIw0SU9SrjE
 BjVkc11icXu9PgqHQ0ccqJjREmaht9CCGqRwub1xoO6i1DtweNRBI8zzdfMqhDVHwcU1
 VKdMyLlwZ8ck6PA0bNaFFigCPksUk7aWzUJBHYHOqGIED43I/tvQ6JlFQkfLgeuIJo4U
 dA+dD2hoatsUwuuGsmPd6Gh0UWKkR3Sb4aIW+9pV3O1+QvX0ESWoQPBNFCJLwEZeVIRX
 uPew==
X-Gm-Message-State: AOJu0Yw1OKeWltinGhCBHFlMRebbjE7Kvj2HbC/RbGr7zvRnOHub3967
 7C6quSZjRVIIZn7sDudHdTgvhg==
X-Google-Smtp-Source: AGHT+IEYT8uiajwtcYhIsk7QiNfcUqXDghwoM5cyTmoqhhmPD4c7J+tBXYAbWNFOng8FjbSwYT44Lg==
X-Received: by 2002:a17:902:da8c:b0:1c9:abca:79ec with SMTP id
 j12-20020a170902da8c00b001c9abca79ecmr8986529plx.48.1697089824571; 
 Wed, 11 Oct 2023 22:50:24 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 b11-20020a170902d50b00b001c5eb2c4d8csm940240plg.160.2023.10.11.22.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:50:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 14/18] gdbstub: Expose functions to read registers
Date: Thu, 12 Oct 2023 14:48:53 +0900
Message-ID: <20231012054902.38447-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 229fa382bc..b85f700c5f 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -71,6 +71,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 987af2298c..a3fc65ec86 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -484,7 +484,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.42.0


