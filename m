Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7FF7CF543
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQFP-0001GM-48; Thu, 19 Oct 2023 06:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFM-0001Fp-3d
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFK-0006Qd-CZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so54393355ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697711237; x=1698316037;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uu0ZHWaubZccEOHE3a8yVbCCnclWTJmr0N9+geMvNYc=;
 b=3KCH6DzbwlmS9LvtxM1T6jzsk08TtlAJ6KCdVkEHcBOzVZQFAzClvZmZgoHJf5YPMy
 Udo8Y8iQ4OdZggxloHTuE0uqYFubI2llytWswa2YzkpcvMw8jfLaEciS4+YO1Kszezm5
 rHkiqWC9Dfm2VK6QUZXiEwv+4SFE4L4x7NNuvhtfjFheV/G0ZT62HNdWQzQSBhRp5qJR
 4a/IyeSs4NXjdSmBo3NW4NC0KmmXZrFwwFgkv0FgCDZlr7hofVUOpQD0146VOv8j4J3W
 lhKpytkwe8pRnHNybadB6L3NHrSw5t18bD5altqRlU7KX63j2wo2nA3rgQuaO8e+60Kt
 6n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711237; x=1698316037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uu0ZHWaubZccEOHE3a8yVbCCnclWTJmr0N9+geMvNYc=;
 b=Ji9Sy/uQRnoiVhsKLBHLMYrGI/wgyXow++d8wo4YeKnz5X0REZ3NYBc1R3uSB8Tth0
 G+1Wwh0zCScjgIRzsLX0wnLC5cdMrQG2s3pHZW81EG3HaStctcKt0MKdLl5eMwOIy5Ld
 eJccYtGb1AduH1FGYp2GBe7VL47V4KIPhmtHJDZP/hcLsMDRvy90r+6hWWutZcBytPFl
 r47Fx9NKrVHXGthiZUXgoNx1efa2lOP0nLE9AEWcDuEqJixzGZ9sHDgI3kj6gNRGjncQ
 FgYAXY+V+8SbKIiNlLMeqMiC0n78jLunJooIiVxOTz59U/2TkPVMruXn3hoV1+iQdrXl
 kXYQ==
X-Gm-Message-State: AOJu0YyRMFyFyhFN4Nd3PeAH9r7VI7RhkXXr8shy0fTwCcCc3yItbxcS
 3xcf9NeJebbxVKa+tcPLMY2eBQ==
X-Google-Smtp-Source: AGHT+IE74Au0grkGe0kUMAuF3B/YdlT1wc9R+YoEL/QEm6sIGva0C7VLVpVyGdpeyR5iIXLEyLYTTw==
X-Received: by 2002:a17:902:ea0e:b0:1c7:8446:d65c with SMTP id
 s14-20020a170902ea0e00b001c78446d65cmr1768050plg.43.1697711237012; 
 Thu, 19 Oct 2023 03:27:17 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s15-20020a170902ea0f00b001c5fd2a28d3sm1581602plg.28.2023.10.19.03.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:27:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v14 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Thu, 19 Oct 2023 19:26:38 +0900
Message-ID: <20231019102657.129512-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019102657.129512-1-akihiko.odaki@daynix.com>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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
 include/exec/gdbstub.h | 23 +++++++++++++++
 gdbstub/gdbstub.c      | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 071021415a..97875634f3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -16,6 +16,12 @@ typedef struct GDBFeature {
     int num_regs;
 } GDBFeature;
 
+typedef struct GDBFeatureBuilder {
+    GDBFeature *feature;
+    GPtrArray *xml;
+    int base_reg;
+} GDBFeatureBuilder;
+
 
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
@@ -44,6 +50,23 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
+                              const char *name, const char *xmlname,
+                              int base_reg);
+
+void G_GNUC_PRINTF(2, 3)
+gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
+                               const char *format, ...);
+
+void gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
+                                    const char *name,
+                                    int bitsize,
+                                    int regnum,
+                                    const char *type,
+                                    const char *group);
+
+void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
+
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
 void gdb_set_stop_cpu(CPUState *cpu);
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ae24c4848f..ebb912da1b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -422,6 +422,71 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return NULL;
 }
 
+void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
+                              const char *name, const char *xmlname,
+                              int base_reg)
+{
+    char *header = g_markup_printf_escaped(
+        "<?xml version=\"1.0\"?>"
+        "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">"
+        "<feature name=\"%s\">",
+        name);
+
+    builder->feature = feature;
+    builder->xml = g_ptr_array_new();
+    g_ptr_array_add(builder->xml, header);
+    builder->base_reg = base_reg;
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
+void gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
+                                    const char *name,
+                                    int bitsize,
+                                    int regnum,
+                                    const char *type,
+                                    const char *group)
+{
+    if (builder->feature->num_regs < regnum) {
+        builder->feature->num_regs = regnum;
+    }
+
+    if (group) {
+        gdb_feature_builder_append_tag(
+            builder,
+            "<reg name=\"%s\" bitsize=\"%d\" regnum=\"%d\" type=\"%s\" group=\"%s\"/>",
+            name, bitsize, builder->base_reg + regnum, type, group);
+    } else {
+        gdb_feature_builder_append_tag(
+            builder,
+            "<reg name=\"%s\" bitsize=\"%d\" regnum=\"%d\" type=\"%s\"/>",
+            name, bitsize, builder->base_reg + regnum, type);
+    }
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


