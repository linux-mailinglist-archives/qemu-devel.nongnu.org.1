Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE5820198
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKKn-0006pr-CR; Fri, 29 Dec 2023 16:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKl-0006pK-Qa
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:23:59 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKj-0005ko-VD
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:23:59 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3600dc78bc0so14534985ab.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885037; x=1704489837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TEKLSsQIWfhjFxdaJnF+IoMYCW7TwDJB1ogBSn9TY8=;
 b=cQSOWbEhy8yLsndyVmdHi2E1P9DIMbzczCjXKOOLSJu3JZkUucV7g7fvwmqKx2XQp3
 oVSDNksuxqUDLBoDYukr0fE2OOZtw7ia4rG/c7qbdeZFmhinbCic7CSRSnWQAqhNd1Bf
 pc1JTwd7MmpxURLtj9vMjAB/V17jXgn8usNyrs2/Nka+i5QWl3qwd8vOf0SYbfFV+/Hf
 WVnojAJ+2Vi1EPl5M0GDHBaaSCSa3Cz8b0uhycnDjA2c+bi/6TNgYq6F29Pghenw0nIw
 lPQoRd5BpE9VL3p7EcwspIZOVPLnjhKMnJkaoLTg8BP4nGkCNi6+/qNDJkDcaWkGcz2P
 JbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885037; x=1704489837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TEKLSsQIWfhjFxdaJnF+IoMYCW7TwDJB1ogBSn9TY8=;
 b=D+zrFjKR0tTQgwfKvyX6kEo7zztKvuLgspQ8JX5+BUOE740mXIPefDbwqIplZ304TN
 xbBBBNai/WFtjmvTA446g5SLzSOuXBAJVdLHjKeaQO7oo8aXQ9F+pvTDUX4JfuVKeIex
 tUNmDTDPRhfgOTbFIImIjZGOr9mk65Em31kP+OH9kBIjIRpeSpFrldlq4yT2fGkQwdFP
 gvpkUMwXi07+B5bnER+wYKkYIqf3YHC4o0F+Np8uszfN99g2e1OZB2VSh1SVpuugGAuc
 ZJZkp4ixYSl+vuPLotMS+tyPs6xJ/FvaiXCO1JJw8jYOXjMS67t/fuOIMhyW8LHt5y0/
 MNEw==
X-Gm-Message-State: AOJu0Yyj4AP+7vXf8oKldSWbZn0n+FjWIhKBp08MS5XFS//RmNiZG/xp
 TRN7w52oRnyC8y8prNB21LmFWBI36H34ilYuncb5Kvsl5vCG8A==
X-Google-Smtp-Source: AGHT+IFGHOvoq/jOVGhtUrz1nH5OlpSG36vve5dFKXML/N860VTpBw/mq2Hg2f5OEGG0T82GW1Aojw==
X-Received: by 2002:a92:c241:0:b0:35f:af09:23d1 with SMTP id
 k1-20020a92c241000000b0035faf0923d1mr17263374ilo.28.1703885036856; 
 Fri, 29 Dec 2023 13:23:56 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:23:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 01/71] migration: Make VMStateDescription.subsections const
Date: Sat, 30 Dec 2023 08:22:36 +1100
Message-Id: <20231229212346.147149-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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
Message-Id: <20231221031652.119827-2-richard.henderson@linaro.org>
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
index 1b9ab7b8ee..eab62330b6 100644
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


