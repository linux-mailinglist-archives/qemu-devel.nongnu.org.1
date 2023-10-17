Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6F7CCBE0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspS4-0004fu-6Y; Tue, 17 Oct 2023 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspS1-0004Wx-Mf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:57 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspRz-0001bi-T4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:09:57 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1ea48ef2cbfso1521442fac.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569789; x=1698174589;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9N+BmhVfVwjiXC6odceMFXxubXlk+h8qUb9Oc4DEJsk=;
 b=orO9LHgiKaKNxp9h9bZHEI17SXGRNHdwalRKQ+FgkvB5H+r/CkULvmlunRkeVHVLfP
 DP3imJBEuZb1Wnyp0WBstRW9yu38K45oSA15E4WasaFpzC1t3mtK41uTIfo6IDvrl5lC
 CGnEAnaObcRcBflKcjAq3hnbkXYhqwML4/1Rnc8M8YXn6Uv7alOf+aY+/9ux6LrpANrM
 aVcZfpAOYuL9/BOpdPEVwhPjCXbnqYQVWBjLWXOoxrIdT9IeRVWz91gkGvoPiySBbsTC
 tN5NzxYkRorNzJDYVa4DXA4hoLzL5npi31DpjTe0GQ6vYyNydV55UbCC8YC+WHTUxtgW
 EUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569789; x=1698174589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9N+BmhVfVwjiXC6odceMFXxubXlk+h8qUb9Oc4DEJsk=;
 b=Z4y7kAuV/Xg7GPVrCUh3jk16yUt/yTIQt/+2+GUgo65SIhsfChBGjvvo6+DNj1CDxX
 nTo6LC5CLwKqSHtUSIcfMWepJAPoYfVd2V2OCTHvObw9qZZDlTr/IP3h3xjpunwrYdqk
 YdSaaJLgk0u0SkFsM9AuGLLk7P8wVp669rwGsnPq3od2evE6nzGaeg3VO3jJM2OoSNYR
 5txwvwEKucM6iDSrE5cCc0bMjDlJ0pnukM6c0kF3Bur5VRGLzB1xm1ouwRTX95jWTukm
 /xNGnKArOZpuxlIm2Lw+EocK6RtZXEgGPbU/EQo2Rfu9DhF10Kz8eOzZeZrV1S3VKgW/
 jL4A==
X-Gm-Message-State: AOJu0YyQT2zCAxV2lIWHhC0P0frQgBgyb+1lMgeYEyqNCztuQOTomc2m
 VagF3pWGijCwJy1dISUmtwC3pA==
X-Google-Smtp-Source: AGHT+IG7zA8pG0JAl+0yj1eTtDHrt6tElb4LN+B422HroYo9nY3A3V/D+IOMzehAnipvwaUswbj0SQ==
X-Received: by 2002:a05:6359:3114:b0:135:5ede:f352 with SMTP id
 rh20-20020a056359311400b001355edef352mr3435992rwb.8.1697569789531; 
 Tue, 17 Oct 2023 12:09:49 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 fa36-20020a056a002d2400b006b2e07a6235sm1800053pfb.136.2023.10.17.12.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:09:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v13 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Wed, 18 Oct 2023 04:09:13 +0900
Message-ID: <20231017190931.16211-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2b.google.com
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
index ae24c4848f..11bdad1c28 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -422,6 +422,65 @@ static const char *get_feature_xml(const char *p, const char **newp,
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


