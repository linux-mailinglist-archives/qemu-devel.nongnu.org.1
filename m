Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDDE7C6EDB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvOz-0001ek-7u; Thu, 12 Oct 2023 09:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvOi-0001bI-FU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:06:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvOf-0005AG-Te
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:06:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c77449a6daso7929085ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697115996; x=1697720796;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4n/7HwjNSyGQv57ebpN9EafLdWwpUm2Oa878+0wJoU=;
 b=HUaeoe+27HJo8v0hjeuhEq3R+VUrkyY2kCo3mFSjZC/PB18NcJxlkbo9AZJknQR3t+
 7I2YjXmgsa6G2u9kRHSWdBtwY9MvEHu8aRuQJ+edrjDJjDkmnzxdumCD+UJt5ZBX7Ixj
 Z4rQ+mCmNiy0YUELvvsij6kOEdFYcs8D58YMlCeIkqQzp1OFRrH7mM+G2L5tgVXNqTYc
 FL99AG+D2yGUUN44nHYlZvuv75HDT1ifcpA5yN/lDoEI4igbLRufU8KmksJHLt5UnGeQ
 pkr6CcsxjgXSuWZqmqN7x4Ocxh4UpmmGQNUtNGXKbYGo5gsiBq7TJ7GHZd0CHFjQcwT5
 C8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697115996; x=1697720796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4n/7HwjNSyGQv57ebpN9EafLdWwpUm2Oa878+0wJoU=;
 b=G2DED0yu7AOmvztGpBSZx+zF942LncsVH9go+WOazZLAxh6clnfu+0DiE2/TApLJMz
 Nd9+xMrjB3yTVzx0We7yGHEAJ90BWTC795CzdWWeDD/9vJz2EXKZ5+JtHKwcNsZAW70I
 fwRvnAsT5iubzivJfllfOMlJdEFcRqsXKMKb6Ym6qmZQpu6B9quX8uyrv6bna5n2hseR
 xWNDarh+bPdAJkJU/MQBjTe5upVQ3L68K5v4VOWldjQBXAUWv/9tvYpNNDGiYWa9fFHW
 hnDy2rYYJN79uWe0ONHS1J1/O1+AIyZl+SAOkxETr7EeCpK3DjaYiGvALZoknG7rpno3
 WrnA==
X-Gm-Message-State: AOJu0YyA/zV3/d7pYl/YPfN24aUJsiMtdcUDlM6iWwaaIbdr5syO3j15
 o1PJGSyBPLShu7OKzXxx9mUqyFYwlRl3xWgXr48Bmg==
X-Google-Smtp-Source: AGHT+IE+yf0/rUWZCBYOLWNiyYiD7bY0JhsG9DSnSERIZ0UAeM629J3C3Jb2HbtjtWitKLIXfNtTVg==
X-Received: by 2002:a17:902:bd47:b0:1bc:2188:ef88 with SMTP id
 b7-20020a170902bd4700b001bc2188ef88mr21176251plx.3.1697115996273; 
 Thu, 12 Oct 2023 06:06:36 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 jb4-20020a170903258400b001c76891b1c9sm1942410plb.10.2023.10.12.06.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:06:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v11 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Thu, 12 Oct 2023 22:05:57 +0900
Message-ID: <20231012130616.7941-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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
index 071021415a..cbd582260a 100644
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
+void G_GNUC_PRINTF(2, 3)
+gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
+                               const char *format, ...);
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
index 44c9167542..258dd54c90 100644
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


