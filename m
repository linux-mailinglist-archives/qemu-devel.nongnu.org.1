Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4317E41C2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0H-0004Lh-QQ; Tue, 07 Nov 2023 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzw-0004EP-HI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzu-0007Zy-CT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fe1a29010so368037f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367044; x=1699971844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suLqpGfBVG7ThOgluqJcKn5BkWpm3J+H+wT05/2ihKs=;
 b=Cznd68PXxEL7z4536zKvT++fj9n8RO6iWRMHjidE7WuRnTqtUPEVavj9lOoWigUi4d
 ggrzbvs4wLpDgtGXSTlSewi0YJB8G6gTsNghbvhHqqj686i9/xBDF9SKlT0i8L9JXLN8
 30VzxIJ8I5hJTuai6qp/RCVc/M8K4BZO467yrfZDa0gOewfWjnZJdTp7nUVKkZkzzkbV
 yCvpPoF+3LPUEiIa2nVXYWcbjBc9SfbJWP7L28F+VBsj/jS/btUINid9eFeZsYbHVKQw
 LUQzWp6Lx4fnZrWo7GvfSlWjjyizaCBW5FseF6Ooq4lYJ4KMNeoMz7lyARfmGxsj72Un
 tEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367044; x=1699971844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suLqpGfBVG7ThOgluqJcKn5BkWpm3J+H+wT05/2ihKs=;
 b=AX3C7GHxUp03dLEYjiKWaC1VQEgonp33Syo14DCtRtdGv3IZ+7Ws8OxHjaWyJA/eRs
 Nfa26oRJ/yB6TpvDCbRcN3mS9HKjmdDANEBt4KJysIxfSR7BvxItZTLbP8Mstb8MrvVs
 BuFXcwXMcHMfEzFmJT/C3XL9Ff8sQyL6NYlny+Yywt5uKEe6pJd7JQHe3eOx6liKND32
 xVfc+ihAdKhJ5/2r2/pf6fDXDsrzBGCTQPkc7xCJn8Hh0h+XKHrkvZa8f85XHtJWLvam
 76raY6caqdzr12KsiA/ATaj5russlp2KUbRTu1pfGw/gtjbrI3eKqTi2T4M1Qe/0hlF2
 upUg==
X-Gm-Message-State: AOJu0Yy9ijaxiYfURrZ33I2gEtzxnV4C2Hkc9aXTJMtcB161Tlv4XyW7
 j4RU/QeoYJGkShGfEl/fCJ9IMtHbZmvWm9+xHbjwTw==
X-Google-Smtp-Source: AGHT+IHeTXbWBDNTzOC/eVcBG4Fodiejunaa/nTrFLntnTKFfMJzmDi8WIeDLjkD3DjzuD/YXgzcgw==
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id
 j17-20020a5d6051000000b0032da4c4f700mr22864163wrt.38.1699367043779; 
 Tue, 07 Nov 2023 06:24:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l2-20020a5d4bc2000000b0032da319a27asm2497290wrt.9.2023.11.07.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82E4765760;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/23] gdbstub: Introduce GDBFeatureBuilder
Date: Tue,  7 Nov 2023 14:23:41 +0000
Message-Id: <20231107142354.3151266-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDBFeatureBuilder unifies the logic to generate dynamic GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231025093128.33116-4-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-11-alex.bennee@linaro.org>

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
2.39.2


