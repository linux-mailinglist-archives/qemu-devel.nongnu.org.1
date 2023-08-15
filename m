Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9977CE8A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOv-00064A-RB; Tue, 15 Aug 2023 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOd-0005uK-Qo
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOP-0006I4-Sk
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31965c94001so3072417f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111092; x=1692715892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33wawR2LWoaAut+i9ZrgbT27fp+Dc7BzTfoXKJW1L3U=;
 b=eIHHwVeTQPuAcSfKRmsKRID5y/XpQUWI2xgmcMSXI24nWBNsBpp/Adco4lB8gNpSaM
 eL8WmafJs0spUViBPZ2xRXdl5bxxM0Gth58KXcBsdjsPb3M7Bg99+pWW2dSSh8aijYjM
 q/JwTOKmy3s3IiPU0BHtdT2v/W20PdxquOgC7LREdDvLR+Gu/pSiA2GdcvdeoExyrwWS
 zvtyb7XJWzJCUfD9WOf+jAVTA/D55v8nLDHvI7C7+12Fx0fjnGrBO5LCfdur84d/Rrm9
 coiTmnOAVE1uORun3dx5/dR5XjK35pZxJQQ98jP0hIXgQNr1ZitvAcvfgh+Vsd11FCYX
 oYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111092; x=1692715892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33wawR2LWoaAut+i9ZrgbT27fp+Dc7BzTfoXKJW1L3U=;
 b=LwX+7HpAegv28e0/I9kbtSHaoywn9YZMG6mZjdeJIoDOw4Z6aL9iuLYU5/4to/voUw
 /S9wLW+jO2PpDo4ebklCZrFLgOr4tfOCAPh6VvTv0GfzuLATEnLW9qQxxv0QgDxxXP7r
 xcqcKdoU97Oz5d2dvkDbO9qpQ62BWMZGP9sQOq+Lg4Te0hCBo71vOtYowfJIUdPNPSbX
 ZycJgEiILhpEe1JipCpGaj+Q7tYFAPLe0BtAKfOvJxMzTXjko4v/WkRYfXWwZE1SEcew
 5eXJPlOarJGJ8QD/PAfav36IQlHaetoZ2La4ziLA7uIOlB+QaOumy6U23VTjCf0OaQst
 2Alw==
X-Gm-Message-State: AOJu0YwS2i2CGSQUgW2ocC6YTo5I/u7NxLwDwk/4CaMtGSk3s3OZ8bxC
 fw0ru8IzgDvU5rrDiiwulgU3Cg==
X-Google-Smtp-Source: AGHT+IFpSFk/JvRo38vo0cQ/cxUUFpx2A9j+6iLGNJa8IwGWSpUSlgJaketHmqdx2hpCagffqrIcNw==
X-Received: by 2002:a5d:53c3:0:b0:317:5c82:10c5 with SMTP id
 a3-20020a5d53c3000000b003175c8210c5mr9856910wrw.17.1692111092139; 
 Tue, 15 Aug 2023 07:51:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfcd04000000b003176eab8868sm18259844wrm.82.2023.08.15.07.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C73DD1FFBB;
 Tue, 15 Aug 2023 15:51:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/9] gdbstub: refactor get_feature_xml
Date: Tue, 15 Aug 2023 15:51:25 +0100
Message-Id: <20230815145126.3444183-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
 gdbstub/internals.h |  2 +-
 gdbstub/gdbstub.c   | 62 ++++++++++++++++++++++-----------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

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
index 8e9bc17e07..0f9032d793 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,54 +354,52 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
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
+        g_autofree char *xmlname = g_strndup(p, len);
         const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-
-        g_free(xmlname);
         if (xml) {
             return xml;
         }
@@ -2245,6 +2243,6 @@ void gdb_create_default_process(GDBState *s)
     process = &s->processes[s->process_num - 1];
     process->pid = pid;
     process->attached = false;
-    process->target_xml[0] = '\0';
+    process->target_xml = NULL;
 }
 
-- 
2.39.2


