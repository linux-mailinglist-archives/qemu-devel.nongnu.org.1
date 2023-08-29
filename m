Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2B78C980
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nr-00059M-7E; Tue, 29 Aug 2023 12:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1Nk-0004zI-1t
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NT-0004Qn-Qf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so41377755e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325733; x=1693930533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGuSlOFUAd6anPdd5Y5MZCMek8dhfbyzWA0wz58Vex8=;
 b=ZkemELLTwaRba0RloTHPtfkxAVroB/+6wJhKBgaKY+4/I+ckfY1JLV06QjsuUIKYHW
 g2MhgyDaE0+Y7huDAFwzkMQDg7N1UdwXAetKrBZBMMal1Cg7jUqW/tga8fH1iymqbCsw
 LmJX1vgQXdgU+Xeor8nr5OwdLmgZp8Iir9le4oLqyPrbCn1lBQK4QVdFTs4xmovtcDwV
 FWZ89Z7Mizwmissg2CIfK8ePo7AnF0YqfA6cQGy+RLMTlAIC0GC+xfEmxOQEhB2kc3ZL
 VBcr7RqN4hrsOSntNLPLCZlwVxu6gvsn2WqF2Nb9TniFqRaA1rVRRn0d6zlwG3FpG3Gk
 Xd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325733; x=1693930533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGuSlOFUAd6anPdd5Y5MZCMek8dhfbyzWA0wz58Vex8=;
 b=hiFtC/aMmSzFbBoaDpwox3ODAril276HP6k5M/OSw/bbtmRwo1kdSzhm9xfXTrK2KG
 Z5qpgFC9DaUR13Kh/FbbB0HTJXySyf2nbyK8jiSXMZ1PMQE0OvKWPKQfB3fnWLCxFLx5
 ftADuEON7GnFaeeyu6e3Gie5JQV4GGmm5mXE3PWT+0oqwVXEUjpsYlYLbjbNlLk5R7iH
 aP80DwyT23ZhW8pJql/2Ibe9/HYgsPUTmmzDo0D5UAzBbCnU0LBeB2w1V5KKpR+/2UMA
 d/Q7FBUIJZsxm0X0MxLPVq2f9iUvrRbFIfPdKi1tkiGKaEYqx8yIuAYRuiXl14USrnH7
 rLWg==
X-Gm-Message-State: AOJu0YxHd9wJmnDSr9RQKKB0MroO1cs9at489HSw0vNjQMWlKu+IgIk0
 yHVmsVz6hdNNdNvr/d8KrtETFw==
X-Google-Smtp-Source: AGHT+IFwfty2v0xOF9CMsFRfCAdFBAmU9R4tfu/jx0PdvIzN1aFXk/KBUSok+h9UvLdGJqq1tbAcuQ==
X-Received: by 2002:a1c:7303:0:b0:3fb:f0ef:4669 with SMTP id
 d3-20020a1c7303000000b003fbf0ef4669mr21407138wmb.17.1693325733334; 
 Tue, 29 Aug 2023 09:15:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bcb89000000b003fee777fd84sm14309471wmi.41.2023.08.29.09.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 681B11FFBC;
 Tue, 29 Aug 2023 17:15:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 10/12] gdbstub: refactor get_feature_xml
Date: Tue, 29 Aug 2023 17:15:26 +0100
Message-Id: <20230829161528.2707696-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
  - fix up style of xml_builtin and invert loop

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - also clean-up xml_builtin loop
  - use strchr and defere copy for only xml case
v2
  - avoid needless g_strndup for copy of annex
---
 gdbstub/internals.h |  2 +-
 gdbstub/gdbstub.c   | 81 +++++++++++++++++++++++----------------------
 2 files changed, 43 insertions(+), 40 deletions(-)

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


