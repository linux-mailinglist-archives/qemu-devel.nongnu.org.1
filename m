Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3A79C7CB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:13:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxZg-0002TS-C3; Tue, 12 Sep 2023 03:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZe-0002Sh-PM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZa-0006WJ-7u
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso1994791b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502753; x=1695107553;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7F7+NLv/kDye49BEzHGwBsFDwGPnZ07cj6V5tEh+C4=;
 b=w+TCSya8Obit4cBJxxfe+tUKwArmjYQTVRY40lVhJFuN5nH4Agz4sIYjxO7LAfCmx3
 8OoDMGWxbvLonfzJ4WTNfzrRMHewMC5htBKpaNnsE+5rKpY5+QmLwOQeOG2FhBTV/hdO
 /spY+Z11qNIsRyyNVO6KOiWG6yTfHr28h6PDBg8NMzLI4TWjmfg+08n01WBcUkMEUbCD
 mS7/xv/Y1Cu3zqnKyq+lIRaBqKVLikH9SYNVuX7krZelix1XANWya+Z0A7xxVqzQKzLb
 yWBzuG3IIu1fpFSHJUn+Y5m7wrIST0x+PR/qDMioDY1gVrQMQ2suR6MCHaVP94rEpHN5
 iRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502753; x=1695107553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7F7+NLv/kDye49BEzHGwBsFDwGPnZ07cj6V5tEh+C4=;
 b=KOiLhU0pUfLTMlwg0Fkh5NruYAYXq/k8RBpzttRFWTb4a4NHFB4DOrtTDWKTFUd16q
 R8cwbtkrtjx78a1HTGVKcoAoSL7gcZtExmJKtJ7wkekpj0y20A77aZEWTnA+9RWy6UEx
 TJqzfuaR6iviTjTcnGB1KLupZ0En82pEiUHPqTMfC7cvcLQLTZdfHoEa4MRm48DgMuih
 xwZCuqTUm0O01wc6CEeOPHo66ynXLjzuMbysAHKjm6DuLj0GMICNiIkKNXu5eyCo6sUm
 iK1HFv96k4gPAXCN/DoZuUpsFo8tf5waHQlKUm4d4WlRKK/Iw99yOgsfPSU9khEaCkaC
 TDDg==
X-Gm-Message-State: AOJu0YwbbIbnUQ/6n8S0wIvPWjC2mpUiRXtXyvavNafSm+Ne+sOVj+UC
 x+1RW2JPGuEcsjFmcj5/M+uGVw==
X-Google-Smtp-Source: AGHT+IFdcqRsES2t1tdU4DsJSN8n/RHuHQ8CXz66apzeV6BW3l5xFPF0KsAieAWNZR0ELMyOcJrBRw==
X-Received: by 2002:a05:6a20:9706:b0:154:9943:732c with SMTP id
 hr6-20020a056a20970600b001549943732cmr9902987pzc.30.1694502752715; 
 Tue, 12 Sep 2023 00:12:32 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:12:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 04/18] gdbstub: Introduce GDBFeatureBuilder
Date: Tue, 12 Sep 2023 16:11:50 +0900
Message-ID: <20230912071206.30751-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

GDBFeatureBuilder unifies the logic to generate dynamic GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gdbstub.h | 20 ++++++++++++++
 gdbstub/gdbstub.c      | 59 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 071021415a..d9ef2ccbff 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -16,6 +16,11 @@ typedef struct GDBFeature {
     int num_regs;
 } GDBFeature;
 
+typedef struct GDBFeatureBuilder {
+    GDBFeature *feature;
+    GPtrArray *xml;
+} GDBFeatureBuilder;
+
 
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
@@ -44,6 +49,21 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
+                              const char *name, const char *xmlname);
+
+void gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
+                                    const char *format, ...)
+    G_GNUC_PRINTF(2, 3);
+
+int gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
+                                   const char *name,
+                                   int bitsize,
+                                   const char *type,
+                                   const char *group);
+
+void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
+
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
 void gdb_set_stop_cpu(CPUState *cpu);
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9044b44954..b7bb252908 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -420,6 +420,65 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return NULL;
 }
 
+void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
+                              const char *name, const char *xmlname)
+{
+    char *header = g_markup_printf_escaped(
+        "<?xml version=\"1.0\"?>"
+        "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
+        "<feature name=\"%s\">",
+        name);
+
+    builder->feature = feature;
+    builder->xml = g_ptr_array_new();
+    g_ptr_array_add(builder->xml, header);
+    feature->xmlname = xmlname;
+    feature->num_regs = 0;
+}
+
+void gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
+                                    const char *format, ...)
+{
+    va_list ap;
+    va_start(ap, format);
+    g_ptr_array_add(builder->xml, g_markup_vprintf_escaped(format, ap));
+    va_end(ap);
+}
+
+int gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
+                                   const char *name,
+                                   int bitsize,
+                                   const char *type,
+                                   const char *group)
+{
+    if (group) {
+        gdb_feature_builder_append_tag(
+            builder,
+            "<reg name=\"%s\" bitsize=\"%d\" type=\"%s\" group=\"%s\"/>",
+            name, bitsize, type, group);
+    } else {
+        gdb_feature_builder_append_tag(
+            builder, "<reg name=\"%s\" bitsize=\"%d\" type=\"%s\"/>",
+            name, bitsize, type);
+    }
+
+    return builder->feature->num_regs++;
+}
+
+void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
+{
+    g_ptr_array_add(builder->xml, (void *)"</feature>");
+    g_ptr_array_add(builder->xml, NULL);
+
+    builder->feature->xml = g_strjoinv(NULL, (void *)builder->xml->pdata);
+
+    for (guint i = 0; i < builder->xml->len - 2; i++) {
+        g_free(g_ptr_array_index(builder->xml, i));
+    }
+
+    g_ptr_array_free(builder->xml, TRUE);
+}
+
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
 {
     const GDBFeature *feature;
-- 
2.42.0


