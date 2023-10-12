Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112887C64D9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoZf-0001j7-NT; Thu, 12 Oct 2023 01:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoZd-0001ik-RK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:29 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoZc-00070R-4l
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:29 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-564b6276941so449089a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089767; x=1697694567;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4n/7HwjNSyGQv57ebpN9EafLdWwpUm2Oa878+0wJoU=;
 b=tmVChb0lp6zy8A7R9+trGvTh/NRUmYCSmaJfBmijfQb2gwXFO3tlUUIm1kSDULJEkZ
 V3sdhjj+KQCErtWU2LbLwiJawBfnrJoetwyfWqTgGMbo6DzIMITH7kueslYnfCmmd4vm
 C8JohKF+KLeWbHsZOWeXup628TqV557jhKvTnLuJnYiWQNTcYVYN6PyyOBpfsrPELH3k
 RX7+Mq2iGX82Nhjc53ke6nLHh49XYwJt7w1HCb29qsVWdu/Vnkt9ojRWYBIaTZgs8m2A
 /KT7D5ymlov11CB6hw3T+KTDEQWrcwZqNNxsU37jLv778+x4loJMXRQk0L6S3L/7sQI9
 Z5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089767; x=1697694567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4n/7HwjNSyGQv57ebpN9EafLdWwpUm2Oa878+0wJoU=;
 b=xF66y0VGiG1VAYCoBJpKGW2M0xwuR7T/Z52Yt8pi2Am4a5wUNadf1iudycQp3VCY6m
 NlA4GY1u1lKf3E0VSUYdSlQHIGezkLwHb6ikgKCaSkx0Esv0xb1DoVCNdaI1/sfQqe88
 j6PmbG75rCmkgvim3Ks8fCUkeMIeHkW7gxsciZSs0/CoT+14gl6vLtH/qzXW1Tyf/AAa
 Iqz2EFAwAQ9oFAaDzyNnQctdm1B/dKzDLe+8rUyb/9eWUSavNNhR+EdT5VF4gnvKzwei
 OKlV+7pJ2lC1WwTbF49vfC5P74LVcw826qD5GDWKeSAvS0mqi8sXaOB1XgKLdvg5udVx
 2ccg==
X-Gm-Message-State: AOJu0YxRCt9JGpFyu45qvrxhJGhUkm97CLeRpncXLx8l1Qx7ph4avCC9
 aJ54s3FW8pB9V9K5BJkm/26JpLZXAN5vwzBqS7o=
X-Google-Smtp-Source: AGHT+IF9tHlB87gBHdd1ywRaJZdDo3vE9MilnI/hP44hRLxInnDg0GukQT7NvdJv9U09OVXq6gVJPA==
X-Received: by 2002:a05:6a20:9188:b0:140:f6c4:aa71 with SMTP id
 v8-20020a056a20918800b00140f6c4aa71mr24607293pzd.8.1697089766828; 
 Wed, 11 Oct 2023 22:49:26 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 cu14-20020a17090afa8e00b00262ca945cecsm944358pjb.54.2023.10.11.22.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:49:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Thu, 12 Oct 2023 14:48:42 +0900
Message-ID: <20231012054902.38447-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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


