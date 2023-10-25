Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41827D6128
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWSK-0005Cs-1N; Wed, 25 Oct 2023 01:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWS5-0004tL-Ts
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:10 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWS2-0001Fv-E4
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso3304938a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211743; x=1698816543;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6j0l4pFqSQGnzpTGvGolk8sQRFNuK5/112JHoxpOOo=;
 b=shzhaxPxKzTzUfXzEiwKkbIoSR4iS+kf54uH20HkzkoqqqCxCoe2GfolhxM+4IK+UN
 VBxfd5L69nIJCPaf3VlOrgwmyTAYDHtS3cwVIqxn7eu5pKwcJF5C5E/GdKaxqqHpWqPR
 XDsx4VeZzd5iS8Zj4XrgwZ2+ZE40A/EByaoDw+0dingVYJmrWzjhrUCfck3vLzonqKoV
 lG0dlrW1Q1vrEvNhXns58bl29lN2Pan/45HAj4mzqqntlwrEzs2OHMdd2gqhGTYuoTn+
 I6PNbP2jKmlDMefQ+waYorJ5CbAeva1TH0h1gG+LLsevVHqURbrSJU8O8TzTB6elgrc4
 0hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211743; x=1698816543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6j0l4pFqSQGnzpTGvGolk8sQRFNuK5/112JHoxpOOo=;
 b=Zp+l4wdQtHyi6IVGkA6aGy2fysE7s7CBYV/5gj9vPdQWbgDRcPlhzmh4yRajeL39+N
 3PVLJo8Msb39b6YWmXW7Xfo3PBiozU9PEUzgWFJ1K2SRCSzBhgMEzz7JEKHkX+9l+iq5
 jrzxqBYHB1/7xOXl7c1CjKi4JCPOtktUOqifo2Trh6FS8aQZJsD3XJzCUPauUxWYPYi7
 2z70SbngX2hYXe+37mH63q6ytoGgcmjXLq2Jx/R+bldryEMUxvtgK8bXNMGLnObyy5NG
 mSKczlLzbm+b8MZn1+DwruONa2Bgo0yHbkiWbPy7Kof08RNhdrqGMdZES4YE1Wh9zzWg
 51YA==
X-Gm-Message-State: AOJu0Yz0b3v8MZwR4+C9hQX4lCW9J0Jb+lR+ByBYgFyc7Raq4l64Bbba
 hkbUXeY8zflY41fc+6i28R/bkA==
X-Google-Smtp-Source: AGHT+IF8MdfnpeWcmd37mAG7UgdmlcBClhblwQj4Y45zgZWfJP78t3zWWfLG9wRfaa7se3eTabkgbw==
X-Received: by 2002:a05:6a20:2451:b0:134:2b31:e2a9 with SMTP id
 t17-20020a056a20245100b001342b31e2a9mr4662530pzc.0.1698211743604; 
 Tue, 24 Oct 2023 22:29:03 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 pw4-20020a17090b278400b0026f4bb8b2casm9849830pjb.6.2023.10.24.22.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:29:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v15 14/19] gdbstub: Expose functions to read registers
Date: Wed, 25 Oct 2023 14:27:36 +0900
Message-ID: <20231025052744.20697-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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
 include/exec/gdbstub.h | 29 +++++++++++++++++++++++++++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c..12336cb600 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,35 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * gdb_find_feature() - Find a feature associated with a CPU.
+ * @cpu: The CPU associated with the feature.
+ * @name: The feature's name.
+ *
+ * Return: The feature's number.
+ */
+int gdb_find_feature(CPUState *cpu, const char *name);
+
+/**
+ * gdb_find_feature_register() - Find a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @feature: The feature's number returned by gdb_find_feature().
+ * @name: The register's name.
+ *
+ * Return: The register's number.
+ */
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+/**
+ * gdb_read_register() - Read a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the read register will be appended to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * Return: The number of read bytes.
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7d7d887817..ad62cb3f7a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
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


