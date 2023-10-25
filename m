Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730387D66D7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaFF-00022X-Rb; Wed, 25 Oct 2023 05:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaF1-0001s9-DK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaEy-0002Cd-4v
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so5215424b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226310; x=1698831110;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMcEMHG+7HXVzmrQD1704d0U7gASQWD53ECzPdoqDzw=;
 b=BK3Iz5CQJjFY2rdtM2nA7U87s00aJae/JYt67LFAt0ZvV+vCIrNgStPmXmNnj3KPj0
 UEidoEmtdwgOJ3HasFQeVqSAlghGqZI3/CZ8CzRMDm8rKnMaCn1x6xPEfjun/i6sXKuj
 16xV0OTLE/xwPAxz9JzJxJpmllGynmvI5RInjklCr3BJ7R467wxmbqfS8deRSlXRNyIO
 kgJAuJ02LVH/d1JlLO7VKF8dXxk/wCwc+0sbxnVfhy2n1EXgfhL//5UR1kQYOXV/sFtU
 OzVrBZChZ919lBeqbo42SNWVcmcwKwlMLMOigMgcp68b03ildUOrUH2B/rtp50VX+jP8
 up4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226310; x=1698831110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMcEMHG+7HXVzmrQD1704d0U7gASQWD53ECzPdoqDzw=;
 b=FWvRfYgyKdKMWpKooJJLRNMZMcSUfdk60v+8Fpvl22cPigDssreDT8SFqOejtWwKQw
 h4gvkR1kJbME/BBcS0tP8TzwOpjk1KC0XKSeWCy8Ehrg4nwesP/z4kAyknKdLogNm+CD
 HwmUmwVBopLZbRqtcNSeJUDBHE1oWsc/KB/hBagGCjyG/cW8emyewrPxUgMWF3MQ46Px
 Bcgxybz6TFrLu6WV7arw8wWL2vKVqHWiJeLmqYYYoGcxLTdHzqqOj1y66VcYzUKLCis1
 Y54BIaMiviujrPwX8AkZg0+qwaURXoBvu4S/0UTZSsqqIK2IIKJ+dFN6JamEdC43puTT
 hPWQ==
X-Gm-Message-State: AOJu0Yyh0fpdKKj+RWxnDBiNRbqaNCqRdM80+LsbhmtzjH8xTFlhbYnu
 vE6jtODo+Ng6QIh3dMAf6SCV3w==
X-Google-Smtp-Source: AGHT+IExpKQDb/XosYkYVHfWWWLCxkNmUkPBDL/woJvGI5OE9OAOc6pWtCUY+CVUOkjK03iLPtdNyg==
X-Received: by 2002:a05:6a21:1705:b0:16b:c20d:fcd1 with SMTP id
 nv5-20020a056a21170500b0016bc20dfcd1mr4910209pzb.21.1698226310599; 
 Wed, 25 Oct 2023 02:31:50 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 y22-20020aa79436000000b00672ea40b8a9sm9246647pfo.170.2023.10.25.02.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:31:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v16 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Wed, 25 Oct 2023 18:31:03 +0900
Message-ID: <20231025093128.33116-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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
 include/exec/gdbstub.h | 50 ++++++++++++++++++++++++++++++++
 gdbstub/gdbstub.c      | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 7fe00506c7..d8a3c56fa2 100644
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
@@ -44,6 +50,50 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+/**
+ * gdb_feature_builder_init() - Initialize GDBFeatureBuilder.
+ * @builder: The builder to be initialized.
+ * @feature: The feature to be filled.
+ * @name: The name of the feature.
+ * @xmlname: The name of the XML.
+ * @base_reg: The base number of the register ID.
+ */
+void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
+                              const char *name, const char *xmlname,
+                              int base_reg);
+
+/**
+ * gdb_feature_builder_append_tag() - Append a tag.
+ * @builder: The builder.
+ * @format: The format of the tag.
+ * @...: The values to be formatted.
+ */
+void G_GNUC_PRINTF(2, 3)
+gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
+                               const char *format, ...);
+
+/**
+ * gdb_feature_builder_append_reg() - Append a register.
+ * @builder: The builder.
+ * @name: The register's name; it must be unique within a CPU.
+ * @bitsize: The register's size, in bits.
+ * @regnum: The offset of the register's number in the feature.
+ * @type: The type of the register.
+ * @group: The register group to which this register belongs; it can be NULL.
+ */
+void gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
+                                    const char *name,
+                                    int bitsize,
+                                    int regnum,
+                                    const char *type,
+                                    const char *group);
+
+/**
+ * gdb_feature_builder_end() - End building GDBFeature.
+ * @builder: The builder.
+ */
+void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
+
 /**
  * gdb_find_static_feature() - Find a static feature.
  * @xmlname: The name of the XML.
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


