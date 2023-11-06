Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813D7E1AB5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:07:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZD-0004OO-8x; Mon, 06 Nov 2023 01:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZA-0004O4-VL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZ9-0001MP-6v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc9784dbc1so21373725ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253910; x=1699858710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KgC7l6+Ks9UAAd1eXGQex3KmmjQLxfw8YM2XKWIPZQ=;
 b=ynFGfCPFDl69Zj+9CrfjiMwnh3jeDsTw+WxklhXDMmqb5SJZRMxzlX5hyjv82dOv1J
 n+LXMnmmn4V+pwrIYskJ53qlGY9gDhG9Rq7FB/XL1uKycyfhUic6Uw/qlVJ+nFxsK/NQ
 ZF2jl0j3ZIXxfj5QEv2hps4mVyKqDJkwLYwNIyvQ8rGXPVObGZP8dmkocVlvA0brfRVw
 cCrvzzfvCxAL2d0X/JpC0Qxk6XOEA7PUBGYxNlfOH4jJ6ofqq8UOGxRoieYHO52b1m3e
 0zQ3SS2EmuT8O3ZgtaK32EVVg+HkUE2ttPir6AsWZJnfWu0uEd9HaK4M3lmesn+rbqvd
 6MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253910; x=1699858710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KgC7l6+Ks9UAAd1eXGQex3KmmjQLxfw8YM2XKWIPZQ=;
 b=EzPOD1Mp2o2CwhBJw5ifkHK1fgDs28fPwqjiJjc/0KOKcTgX+LA72ok5Fm0xanTHNb
 m8zC2BUcxaAa6Q9Uj2PeF0Q+k6xJJUCtET9SFkLkECgb2INXETQgQ9OoC+ImhpnKxv2c
 z8wcBCIrGf/QNoOvEae3rFSfg6Z/T469A/KAxZ8WbsSJH0ErOKwCmCKErSTyXCzqC+aQ
 ff4NRI1xdW3PHF7Urry+mMQlx326mUrZptBY6uQIYDXiQPZ1h2vZ1gLyeKV0X1anngkb
 xcXkXIm18mDS3uW2r6hD3mNcZGiXOZCC8oqkQ52+jIINbsA2yLLITnv8kWA1gc8SBo2M
 jbiA==
X-Gm-Message-State: AOJu0YxPhLOiWgl+rAlUtvPIJlaQ4lMK6jF9GleoRBykYJ3B7OcfCWAO
 ob4N1/WciXDcJFlBLuhZ/vANXJx8o2Mta7M+5H4=
X-Google-Smtp-Source: AGHT+IHPX9EDwzcpsrVimZ8QhM6hONVkhribI8fJG5xZ1ctSXvAZzHyDI/r7i0f/AjEQm5pYB8hFbA==
X-Received: by 2002:a17:903:245:b0:1c5:d8a3:8789 with SMTP id
 j5-20020a170903024500b001c5d8a38789mr27131552plh.4.1699253909800; 
 Sun, 05 Nov 2023 22:58:29 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 01/71] migration: Make VMStateDescription.subsections const
Date: Sun,  5 Nov 2023 22:57:17 -0800
Message-Id: <20231106065827.543129-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/migration/vmstate.h |  2 +-
 migration/savevm.c          | 12 ++++++------
 migration/vmstate.c         | 15 +++++++++------
 3 files changed, 16 insertions(+), 13 deletions(-)

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
index bc98c2ea6f..77a81937cd 100644
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
index b7723a4187..5876062d48 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -452,13 +452,16 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
+        const VMStateDescription *s;
+        for (s = *sub; s ; s = *++sub) {
+            if (strcmp(idstr, s->name) == 0) {
+                return s;
+            }
         }
-        sub++;
     }
     return NULL;
 }
@@ -517,7 +520,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc)
 {
-    const VMStateDescription **sub = vmsd->subsections;
+    const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
     int ret = 0;
 
-- 
2.34.1


