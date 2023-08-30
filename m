Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB478D6AC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaJ-0001CA-7U; Wed, 30 Aug 2023 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaH-0001B3-Ab
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaC-0000k0-UG
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so15201555e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407251; x=1694012051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQNWyEt/hAb1sq6x2ShrI2jNVdnDYAzqYtnrYXK/jhc=;
 b=SPvRqdfednxicQJHYxe6VAFjOAnT7bseLZ4FcO+tKM2EQqwgWiTUlZ+C13A1zqYLpl
 /wMC3AJ2kNJu+mtnfwlLthKiFHrSacgNmJN1M46wsEXrrFYcspj8ryoysFbQvbC+CqgQ
 j1PWl77YFu5v8SWlNYqhyWLWnwnCMqiC458oQXwsbmqO1HOkDIZhO9btraVIzlf5++vO
 eQkc7krN8snfJpstF48F4rNCQGAaTvaEZ0CV+y+HcMJvp271wfOWPls+/4GuptjZrY0w
 4yaTlr8bhJ0y8BTwHOXkEfeG9EDpCJucY3e1l3bHc7C1gED+8yX14pev6To/Ss1i5vIy
 Z9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407251; x=1694012051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQNWyEt/hAb1sq6x2ShrI2jNVdnDYAzqYtnrYXK/jhc=;
 b=Q6y3t2REKOgyUn9cnbWoJrlsdsGr2/IYfwO45k07Daw7VrYz4mBshaRfVz0qzfhGfT
 fdSzPr0x9cx3QIDv1syO7aNOW7qon8NgDE14vdbH1hCr7djeboXfMoSG8DFpDFaKunQT
 hCN2NrwmjAUdqDnOF6TmOk51cRBIdZ15QlW8L4PEPGp8GGcWM8VDFXCcxMOj2FMygBCI
 LHJXKiwdxvCK4fpFiMf7plP+lmQZEGL/i4iRORCGiKVpa8n0uPRH0AHhIKi2W1Xe1IQM
 brsfj0ZiGsUru+rpFvH0+BcvQZW2z+2LcVbKjdW/3x+R8vLRRgUzuW8HbiXPc9ubcixv
 55Ww==
X-Gm-Message-State: AOJu0YyKlzw48F1mqFOMMxTKBoxYa9WVdEmn73d1NlNNrFtEQYk13CgX
 UE4iMse7kL0BvQ2bIDlEz2L4bw==
X-Google-Smtp-Source: AGHT+IGZ62lDvrQNEeYJa7B2J22la/c9PAmImIspgf/3iekIFnyM+VZTFc7Lk5AXHhlItZy1nKp4rw==
X-Received: by 2002:a1c:6a03:0:b0:401:b652:b6cf with SMTP id
 f3-20020a1c6a03000000b00401b652b6cfmr2081629wmc.13.1693407251610; 
 Wed, 30 Aug 2023 07:54:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c210700b003fee8793911sm2521092wml.44.2023.08.30.07.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B76831FFBC;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/12] gdbstub: refactor get_feature_xml
Date: Wed, 30 Aug 2023 15:54:05 +0100
Message-Id: <20230830145407.3064249-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
  - fix up style of xml_builtin and invert loop

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-11-alex.bennee@linaro.org>

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
index 8e9bc17e07..729e54139a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,64 +354,67 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
-    size_t len;
-    int i;
-    const char *name;
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    size_t len;
 
-    len = 0;
-    while (p[len] && p[len] != ':')
-        len++;
-    *newp = p + len;
+    /*
+     * qXfer:features:read:ANNEX:OFFSET,LENGTH'
+     *                     ^p    ^newp
+     */
+    char *term = strchr(p, ':');
+    *newp = term + 1;
+    len = term - p;
 
-    name = NULL;
+    /* Is it the main target xml? */
     if (strncmp(p, "target.xml", len) == 0) {
-        char *buf = process->target_xml;
-        const size_t buf_sz = sizeof(process->target_xml);
-
-        /* Generate the XML description for this CPU.  */
-        if (!buf[0]) {
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
+    /* Is it dynamically generated by the target? */
     if (cc->gdb_get_dynamic_xml) {
-        char *xmlname = g_strndup(p, len);
+        g_autofree char *xmlname = g_strndup(p, len);
         const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-
-        g_free(xmlname);
         if (xml) {
             return xml;
         }
     }
-    for (i = 0; ; i++) {
-        name = xml_builtin[i][0];
-        if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
-            break;
+    /* Is it one of the encoded gdb-xml/ files? */
+    for (int i = 0; xml_builtin[i][0]; i++) {
+        const char *name = xml_builtin[i][0];
+        if ((strncmp(name, p, len) == 0) &&
+            strlen(name) == len) {
+            return xml_builtin[i][1];
+        }
     }
-    return name ? xml_builtin[i][1] : NULL;
+
+    /* failed */
+    return NULL;
 }
 
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
@@ -2245,6 +2248,6 @@ void gdb_create_default_process(GDBState *s)
     process = &s->processes[s->process_num - 1];
     process->pid = pid;
     process->attached = false;
-    process->target_xml[0] = '\0';
+    process->target_xml = NULL;
 }
 
-- 
2.39.2


