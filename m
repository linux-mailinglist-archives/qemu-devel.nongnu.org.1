Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065037804D5
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqIy-00027G-7E; Thu, 17 Aug 2023 23:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIw-000262-RT
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:42 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIu-0005vb-JS
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:42 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-564b6276941so385971a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329859; x=1692934659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikhJZPeSQ6af3opQ0NADT01t876hnrjxBLN83G442nU=;
 b=07/qLFH4ytt09lwKN3MM+/4qpzm+PpCi43k8YLpGDfxHos2q59/uycnTdHNxGwyn0L
 AwYP2yiBQYlmgc7gRsMtlJ2uTTaqoPCjKnpX9iMr4z2X7EDbHkl5e4mh4oegjYZlXKBE
 0XHFt5j/nvzlQioOgiAvdbqrJDvk9vf/+fOpLwTBR0VKaAi5gf+F83ylHuR6ZfEiZCTH
 lwFwZAI63wsr4tVvWIhIURkDhpShmrXdo1uc/VqpsoVQT71q0E6Jde4zdxM7AkNchQCZ
 Vsgh2E4E8NCxokEWMU7+vouDk/4M8sEvhQh6+UiX4dvcSZpwz+dC6bNWbuGmY/J9Byx2
 aP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329859; x=1692934659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ikhJZPeSQ6af3opQ0NADT01t876hnrjxBLN83G442nU=;
 b=K3Qw6WXQe4X9OnXVuOs8u1gkZrPDxCdwNcaaDJnrI8RkbarIzvy5d5MbJZIyVwW3eW
 ABGyrhFRaUnFT+yUobzoQ3dI8eNJvo/3rcMqE8Saqen3saEZf9uknpas7/TcPpQmNtP2
 +pitCWr5tKiaNs4qdHCaEa4pqqCxl9T5n+9Pe+XGZs/5/Ej8muiH6pmClvsSKZhy184j
 589DmZodmcKYayK+pJzCAtJbOoJAWonLAZ+gkN+TSdIw6XItCmKxknCcGcnvUpZ3WX9O
 93wB/wxUOG5d+/eW+9qRzRQ7a/qJS5UOpl+DUCxXoXVacZmZ/ZTdO0ifp3Gig0YLu4rg
 LFmw==
X-Gm-Message-State: AOJu0YwEsouZJ7Ioon3I5cBRIeX6KlPJpMY/AIwgnNRGwJlfDm5xtlHb
 +3fiKpM6hjl3Xj/cR+PiXmuwlO0StfSV6rsD2Fs=
X-Google-Smtp-Source: AGHT+IGS42Ndf01oG6kR1iAseklLAnXwXbodzf33NhT7/1xNCdD+rcTjSD1QdmXBXoCDqswH39e38Q==
X-Received: by 2002:a05:6a21:3387:b0:138:1980:1837 with SMTP id
 yy7-20020a056a21338700b0013819801837mr2154534pzb.13.1692329859178; 
 Thu, 17 Aug 2023 20:37:39 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 14/26] gdbstub: Dynamically allocate target.xml
 buffer
Date: Fri, 18 Aug 2023 12:36:33 +0900
Message-ID: <20230818033648.8326-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

There is no guarantee that target.xml fits in 1024 bytes, and the fixed
buffer length requires tedious buffer overflow check. Dynamically
allocate the target.xml buffer to resolve these problems.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/internals.h |  2 +-
 gdbstub/gdbstub.c   | 44 ++++++++++++++++++++++++--------------------
 gdbstub/softmmu.c   |  2 +-
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index f2b46cce41..4876ebd74f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -33,7 +33,7 @@ typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
 
-    char target_xml[1024];
+    char *target_xml;
 } GDBProcess;
 
 enum RSState {
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5656a44970..031ad89c7d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -366,33 +366,37 @@ static const char *get_feature_xml(const char *p, const char **newp,
 
     name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
-        char *buf = process->target_xml;
-        const size_t buf_sz = sizeof(process->target_xml);
-
         /* Generate the XML description for this CPU.  */
-        if (!buf[0]) {
+        if (!process->target_xml) {
+            g_autoptr(GPtrArray) a = g_ptr_array_new_with_free_func(g_free);
             GDBRegisterState *r;
 
-            pstrcat(buf, buf_sz,
-                    "<?xml version=\"1.0\"?>"
-                    "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
-                    "<target>");
+            g_ptr_array_add(
+                a,
+                g_strdup("<?xml version=\"1.0\"?>"
+                         "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
+                         "<target>"));
             if (cc->gdb_arch_name) {
-                pstrcat(buf, buf_sz, "<architecture>");
-                pstrcat(buf, buf_sz, cc->gdb_arch_name(cpu));
-                pstrcat(buf, buf_sz, "</architecture>");
+                g_ptr_array_add(
+                    a,
+                    g_markup_printf_escaped("<architecture>%s</architecture>",
+                                            cc->gdb_arch_name(cpu)));
             }
-            pstrcat(buf, buf_sz, "<xi:include href=\"");
-            pstrcat(buf, buf_sz, cc->gdb_core_feature->xmlname);
-            pstrcat(buf, buf_sz, "\"/>");
+            g_ptr_array_add(
+                a,
+                g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                        cc->gdb_core_feature->xmlname));
             for (r = cpu->gdb_regs; r; r = r->next) {
-                pstrcat(buf, buf_sz, "<xi:include href=\"");
-                pstrcat(buf, buf_sz, r->feature->xmlname);
-                pstrcat(buf, buf_sz, "\"/>");
+                g_ptr_array_add(
+                    a,
+                    g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                            r->feature->xmlname));
             }
-            pstrcat(buf, buf_sz, "</target>");
+            g_ptr_array_add(a, g_strdup("</target>"));
+            g_ptr_array_add(a, NULL);
+            process->target_xml = g_strjoinv(NULL, (void *)a->pdata);
         }
-        return buf;
+        return process->target_xml;
     }
     if (cc->gdb_get_dynamic_xml) {
         char *xmlname = g_strndup(p, len);
@@ -2270,6 +2274,6 @@ void gdb_create_default_process(GDBState *s)
     process = &s->processes[s->process_num - 1];
     process->pid = pid;
     process->attached = false;
-    process->target_xml[0] = '\0';
+    process->target_xml = NULL;
 }
 
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index f509b7285d..5282324764 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -293,7 +293,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
-        process->target_xml[0] = '\0';
+        process->target_xml = NULL;
 
         return 0;
     }
-- 
2.41.0


