Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DB81AD1D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:18:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Yi-0007F0-UG; Wed, 20 Dec 2023 22:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yh-0007Er-Jx
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:15 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yg-0003fu-0b
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:15 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78101108e3fso19637885a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128633; x=1703733433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP22ASds0dKq3upA0SbpqniwHlNMzWgmAUGbg1galUQ=;
 b=vgxdsKXH1z6uvERBtZIBOTFbboV6blJ57OqZO1yuKmbe0uElOqNAxW8XG+2j/sti7O
 BsYd3s/W+wHAoJprCLve80u1m+7EVtypP0TreDKt4hhPbXHignCE4auD50weagcmgXnQ
 VX3AxE+cl+QPs5LT3f3JxuG40Tw8lO5IeYyvmXa7JCJ5SKXU2IOd5KGuuH3c2KEBQbt7
 JmOFlrhc89/puaP5nrsyI6saJ9X7unCQk3APfH8HktqL7EKBYZLWdGQWnddCNR0IzjUi
 hlAN7DdAZgMScJBKr3eagJ6RJrEZ1fErJQShAYSGSBcelSmq0UppsrP40rv1FW3Xz0l4
 2/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128633; x=1703733433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hP22ASds0dKq3upA0SbpqniwHlNMzWgmAUGbg1galUQ=;
 b=udJ/+EaJKl6w+1WU/97AbIPwS+306tEfjEotUCshvPy4ppXgF5HcWzw86Uqwyr6ZuW
 IsLNcKzQn0ZGcAExd/IrNMohu+O9epKyWWqUwbfpqyzB7l7QKlGEwAvyYAy+HkuQqljv
 BenzxxF2VLZAcFfY9cRvRphI5pHWN8Ben0tjDDsA/DFHmX+6/Cpf/X9cqwwa961CSH0V
 EVl5Wk6D7LpHL9uP4M1UrVKIKH+H+p7ga0+KS4SamCWvSxpgIvdcrEaGewbfayLvrJrD
 gObs0TUh1LlOZpDfmY6ZV1FlQic7txqZqWzEN2UVwX60mVsNQuh0h5MCk3aZRAR+T0XE
 yPig==
X-Gm-Message-State: AOJu0Yxoujk4S7kNuMP5/FwGxswPjqz/iAryoE6VHCjqK3W5vhc51PKt
 gXPdqei9xB+GIz/eht/GqgHRYx3Fqkl9Aw9VpgSImGgj
X-Google-Smtp-Source: AGHT+IHWIvomV1ykT3fSzl8Tq7qHrVAcE09iNmtraIhgY/7GH6pCoceJ0jSf34F7Pkshsx54QInCbw==
X-Received: by 2002:a05:620a:98d:b0:781:2021:ce93 with SMTP id
 x13-20020a05620a098d00b007812021ce93mr178741qkx.125.1703128633144; 
 Wed, 20 Dec 2023 19:17:13 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 01/71] migration: Make VMStateDescription.subsections const
Date: Thu, 21 Dec 2023 14:15:42 +1100
Message-Id: <20231221031652.119827-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

Allow the array of pointers to itself be const.
Propagate this through the copies of this field.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/migration/vmstate.h |  2 +-
 migration/savevm.c          | 12 ++++++------
 migration/vmstate.c         | 14 ++++++++------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9821918631..294d2d8486 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -209,7 +209,7 @@ struct VMStateDescription {
     bool (*dev_unplug_pending)(void *opaque);
 
     const VMStateField *fields;
-    const VMStateDescription **subsections;
+    const VMStateDescription * const *subsections;
 };
 
 extern const VMStateInfo vmstate_info_bool;
diff --git a/migration/savevm.c b/migration/savevm.c
index eec5503a42..39148636cc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -551,11 +551,11 @@ static void dump_vmstate_vmsf(FILE *out_file, const VMStateField *field,
 }
 
 static void dump_vmstate_vmss(FILE *out_file,
-                              const VMStateDescription **subsection,
+                              const VMStateDescription *subsection,
                               int indent)
 {
-    if (*subsection != NULL) {
-        dump_vmstate_vmsd(out_file, *subsection, indent, true);
+    if (subsection != NULL) {
+        dump_vmstate_vmsd(out_file, subsection, indent, true);
     }
 }
 
@@ -597,7 +597,7 @@ static void dump_vmstate_vmsd(FILE *out_file,
         fprintf(out_file, "\n%*s]", indent, "");
     }
     if (vmsd->subsections != NULL) {
-        const VMStateDescription **subsection = vmsd->subsections;
+        const VMStateDescription * const *subsection = vmsd->subsections;
         bool first;
 
         fprintf(out_file, ",\n%*s\"Subsections\": [\n", indent, "");
@@ -606,7 +606,7 @@ static void dump_vmstate_vmsd(FILE *out_file,
             if (!first) {
                 fprintf(out_file, ",\n");
             }
-            dump_vmstate_vmss(out_file, subsection, indent + 2);
+            dump_vmstate_vmss(out_file, *subsection, indent + 2);
             subsection++;
             first = false;
         }
@@ -831,7 +831,7 @@ void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
 static void vmstate_check(const VMStateDescription *vmsd)
 {
     const VMStateField *field = vmsd->fields;
-    const VMStateDescription **subsection = vmsd->subsections;
+    const VMStateDescription * const *subsection = vmsd->subsections;
 
     if (field) {
         while (field->name) {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index b7723a4187..ef26f26ccd 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -452,13 +452,15 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 }
 
 static const VMStateDescription *
-vmstate_get_subsection(const VMStateDescription **sub, char *idstr)
+vmstate_get_subsection(const VMStateDescription * const *sub,
+                       const char *idstr)
 {
-    while (sub && *sub) {
-        if (strcmp(idstr, (*sub)->name) == 0) {
-            return *sub;
+    if (sub) {
+        for (const VMStateDescription *s = *sub; s ; s = *++sub) {
+            if (strcmp(idstr, s->name) == 0) {
+                return s;
+            }
         }
-        sub++;
     }
     return NULL;
 }
@@ -517,7 +519,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc)
 {
-    const VMStateDescription **sub = vmsd->subsections;
+    const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
     int ret = 0;
 
-- 
2.34.1


