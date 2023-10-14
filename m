Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704B7C9292
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVVR-0001mx-2U; Fri, 13 Oct 2023 23:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVO-0001ml-Rx
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVN-0004cW-5d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:39:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d5c71b4d7so103127a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254796; x=1697859596;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZodVX+tMlxt3knPGnvYQ895sik26pud1EQJo+hdGN8=;
 b=E686/Ar7yvzvHxI8VyrgefRPFxLD70SmEl7/OzCUVcvlRZSljcqRAmQmk5ftT8TqAM
 2190Qj7p3vMbolaAbMLWDIySWhcuLXoUSpXTojn0lI/Td2gHYS06XfyUoJ/MAh/bDfDp
 6doXgoCuxNvJ2mPS2kHB7ed6IWD+bAAoJRkXMFN5MSfuSdH2oU/RBYSAv3JYUrrNl9gc
 9DloAqRzPJtTTnVfn9xBMUhNdqZ+ClzU7puhBaN7K3d1UsF72OTcVi2y8xcHzb/R/0dG
 3orhXCbLYYSB2tiF5MRtv9XZPlrO4tn1R3HCKp1iSzZ3G+cXp5ffKZO0j2VrJ+JyK4LY
 oQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254796; x=1697859596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZodVX+tMlxt3knPGnvYQ895sik26pud1EQJo+hdGN8=;
 b=bSETdr23VwIyER5jsuiGXpzraOBONpClRvqjpYNJywbr1j3M55iZex5OUi4AuK7Wg9
 HbxdzXiVbrg4zN/gxOKhgAlEmPU0UxVI8kPkCxx+6o8jNNt61L6edPLjadKvO037PLKi
 YwYRi6KtuaYt6uXxohC+hPKuvWs1C1aKxYgcqoAGgmMEuu44JhZMUyZ/Ql0MKnlRnXjt
 w/8By7Hf7/xKpnQM3/ec0DO+Cz6Ze1eKGRYSUyvuZ/O3DDlRBGKxOecjmvlDm3RC0Bij
 pfrw8gGCfjc5mmDJhaltjfGHNNVH9ALbX/BNEjVHH8Ekmx6Wva3mrEdvIlSJNh1b7Toh
 wnTg==
X-Gm-Message-State: AOJu0YxXsVAs7fwOA7GMpqMKJPl/I41qvoIRXzfqP6oVPD7mLuhCdDpR
 KZ1B9J4K33LnV2MzB7c2t+vaDIRwKZUvliCPeueXPQ==
X-Google-Smtp-Source: AGHT+IGUZvbd0cmdYUWZmSxC7tfxT55e3RR2RABvYFGlvXUDkYLkiwHNHoccCSmI33lHGV2IECrShQ==
X-Received: by 2002:a17:90a:4298:b0:27d:12e1:7e2c with SMTP id
 p24-20020a17090a429800b0027d12e17e2cmr2956332pjg.19.1697254795791; 
 Fri, 13 Oct 2023 20:39:55 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a10-20020a170902b58a00b001b9d7c8f44dsm4568251pls.182.2023.10.13.20.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:39:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 03/18] gdbstub: Introduce GDBFeatureBuilder
Date: Sat, 14 Oct 2023 12:39:22 +0900
Message-ID: <20231014033940.15679-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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
index f7f9566740..8994e7c1ea 100644
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


