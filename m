Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE877875AD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDN0-0006a6-9u; Thu, 24 Aug 2023 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMx-0006Ym-Tk
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMe-00089V-Bs
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c71898109so1179611f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895159; x=1693499959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7n08jET4sLnSCRFO+uf5UKlQj+0C0tBz07A/O5rXTPI=;
 b=AULp9ltE+Upm0Zre8jkcTgPU+A9Gye0v54BDFw2rxzq2XLwYSVAkNr1xZVteEC4y0T
 J06x0UhcaORGFiPCpN+QG69ccZge7skEiIMEyu5WfDRT9XjE9G9ZqDlePKKMTdq9xWMW
 RzhwLo6FnI0POZ1Y34l+saOalojyJbp5OOBJjD7Y92W8P1kAYMLYb7C21yZxk4dYztgd
 +0A/vRG8kz4nHRxJxWDkpxocTIkQAiXCdSGIgrO8xHECyYBHgUuzFGphy1oSYeZNcwqS
 v0fcbxRNr4Ldgj1qYIDv5EAADPrkFMur17fPjx3RPU2/qd9Kfuba9WmljjlUOJOLGbYB
 DWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895159; x=1693499959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7n08jET4sLnSCRFO+uf5UKlQj+0C0tBz07A/O5rXTPI=;
 b=BSqMLkhtQKY/CMIV4qtkDm+Gw6wFh54ScBOkbhhha0S+Qdb9VA9SvZz7zK/cYsKL20
 4NtFnhVDDWB7VjQ3003Dq86DkHWtYxXFXewWtZOfPuj648DmX3jIzalk8QbjWD49wZ4p
 oYZddAiutY9CbrPOnqGSNCqNL/uQlGUsXKoDb+7PRdlXiOvpkejp8MtsC+F7SO4KXWKY
 4BSWeTjintuNNcbTel3LFMs584f5aWa8KDji6O4oG+lLxpnEV6OyiNWItf3eEczXLheV
 MwNDk0ExI3tmDeVNYm9pG3Y59B9UHOLCJPZ/1JYhQ9SbUYavOIUmEiXq4uDDxgvkX0D5
 9tDA==
X-Gm-Message-State: AOJu0YxHf3NnDLkMY8r7FOsnKtor+cQq2gaebF7Jr09OYGPenjDYb+2t
 2km6G22RRufMXhrdhm5zVFb28Q==
X-Google-Smtp-Source: AGHT+IE/uT6AAWjY+YJfQ3CQBWsLmndNLh5bKVdNARnSbDWwuz1WOne4sa5zPgTupWDDPbYqNrxoIg==
X-Received: by 2002:a5d:4e4b:0:b0:319:7a91:7107 with SMTP id
 r11-20020a5d4e4b000000b003197a917107mr12172529wrt.48.1692895158833; 
 Thu, 24 Aug 2023 09:39:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i12-20020adffdcc000000b0031ae8d86af4sm20385986wrs.103.2023.08.24.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67CBD1FFC5;
 Thu, 24 Aug 2023 17:39:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 10/12] gdbstub: refactor get_feature_xml
Date: Thu, 24 Aug 2023 17:39:08 +0100
Message-Id: <20230824163910.1737079-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Try to bring up the code to more modern standards by:

  - use dynamic GString built xml over a fixed buffer
  - use autofree to save on explicit g_free() calls
  - don't hand hack strstr to find the delimiter

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - avoid needless g_strndup for copy of annex
---
 gdbstub/internals.h |  2 +-
 gdbstub/gdbstub.c   | 63 +++++++++++++++++++++------------------------
 2 files changed, 31 insertions(+), 34 deletions(-)

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
index 8e9bc17e07..31a2451f27 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,54 +354,51 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
-    size_t len;
     int i;
     const char *name;
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
-    len = 0;
-    while (p[len] && p[len] != ':')
-        len++;
-    *newp = p + len;
+    /* ‘qXfer:features:read:annex:offset,length' */
+    char *term = g_strstr_len(p, -1, ":");
+    size_t len = term - p;
+    g_autofree char *annex = g_strndup(p, len);
+    /* leave newp at offset,length for the rest of the params */
+    *newp = term + 1;
 
-    name = NULL;
-    if (strncmp(p, "target.xml", len) == 0) {
-        char *buf = process->target_xml;
-        const size_t buf_sz = sizeof(process->target_xml);
 
-        /* Generate the XML description for this CPU.  */
-        if (!buf[0]) {
+    name = NULL;
+    if (g_strcmp0(annex, "target.xml") == 0) {
+        if (!process->target_xml) {
             GDBRegisterState *r;
+            GString *xml = g_string_new("<?xml version=\"1.0\"?>");
+
+            g_string_append(xml,
+                            "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
+                            "<target>");
 
-            pstrcat(buf, buf_sz,
-                    "<?xml version=\"1.0\"?>"
-                    "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
-                    "<target>");
             if (cc->gdb_arch_name) {
-                gchar *arch = cc->gdb_arch_name(cpu);
-                pstrcat(buf, buf_sz, "<architecture>");
-                pstrcat(buf, buf_sz, arch);
-                pstrcat(buf, buf_sz, "</architecture>");
-                g_free(arch);
+                g_autofree gchar *arch = cc->gdb_arch_name(cpu);
+                g_string_append_printf(xml,
+                                       "<architecture>%s</architecture>",
+                                       arch);
             }
-            pstrcat(buf, buf_sz, "<xi:include href=\"");
-            pstrcat(buf, buf_sz, cc->gdb_core_xml_file);
-            pstrcat(buf, buf_sz, "\"/>");
+            g_string_append(xml, "<xi:include href=\"");
+            g_string_append(xml, cc->gdb_core_xml_file);
+            g_string_append(xml, "\"/>");
             for (r = cpu->gdb_regs; r; r = r->next) {
-                pstrcat(buf, buf_sz, "<xi:include href=\"");
-                pstrcat(buf, buf_sz, r->xml);
-                pstrcat(buf, buf_sz, "\"/>");
+                g_string_append(xml, "<xi:include href=\"");
+                g_string_append(xml, r->xml);
+                g_string_append(xml, "\"/>");
             }
-            pstrcat(buf, buf_sz, "</target>");
+            g_string_append(xml, "</target>");
+
+            process->target_xml = g_string_free(xml, false);
+            return process->target_xml;
         }
-        return buf;
     }
     if (cc->gdb_get_dynamic_xml) {
-        char *xmlname = g_strndup(p, len);
-        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-
-        g_free(xmlname);
+        const char *xml = cc->gdb_get_dynamic_xml(cpu, annex);
         if (xml) {
             return xml;
         }
@@ -2245,6 +2242,6 @@ void gdb_create_default_process(GDBState *s)
     process = &s->processes[s->process_num - 1];
     process->pid = pid;
     process->attached = false;
-    process->target_xml[0] = '\0';
+    process->target_xml = NULL;
 }
 
-- 
2.39.2


