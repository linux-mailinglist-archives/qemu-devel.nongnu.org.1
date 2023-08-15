Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA077CE7B
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOy-0006A8-43; Tue, 15 Aug 2023 10:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOf-0005uW-0l
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOP-0006HM-TH
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-317716a4622so4849034f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111091; x=1692715891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnhFXoZukvu0YTKINuH5NG1+Wifue15VPIsTSt2x950=;
 b=NyWwrUJuXI47oT1v3vectwWeFS1dHpFy7c+RG+EoyQUAaGP2yyIrjBN35TY1+9xjA9
 azgh/Y082aH5ogcj7sL7wlapH3IrqyzmijpMNTt7k4UQiAo/DhJMKsf20eIrcy7fgUXt
 lXZV7MR0UsvL/HyZafZB/UYX17DCe1CCX9EfbQ0Mka2Kelz3LWXuXL0EHuPvsMJqqb50
 YdMJYJwc0Txiw096WepY7ICdoxZf8VvVlJBKq1bcg0LIh3UYMPXjw1fAMl5HlHEC4yTN
 xAPT1D2Wc1Nnji3jwUjl3fLgcgN87tZbDT25eHgBUtaVxJwzS5TeduFzAi4uCiA0LrG7
 Wpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111091; x=1692715891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnhFXoZukvu0YTKINuH5NG1+Wifue15VPIsTSt2x950=;
 b=QpqSNeGU8elYJmKNVB7PfSKKd0M0uQbnGT1nOhM3lw58raZK81t+vZvUGoLzSP4F8L
 s4H6u3Rfiohb3VADdMd8PPeZLzO//06n8pPC6QBdoSog91U5KSMNARxSYZ75wicquIKc
 H788ss+7hYGtiyeEQPR33WLZzJDcKeyhx2YEjY6Zz8iNVi4gXvZPF27d4bvyMe0ljMXM
 euk2MHJBLRkYRAulQmGSiDfzmgrROksBWAwduLDYXo/c02wf1fPZl8bFSxQRxIf7zO6i
 IXMFI4aoq8vH024Un7arSQrmF7LFYtyXiiEidFZBdQnzoI7l+6IoF0inmBHkXT2lLNCx
 mYQA==
X-Gm-Message-State: AOJu0Yywz/jYye51lPUNSzRaSSP0EwNGjrFTg52gAHVVgYZy28xMgrjg
 cGw+Hd5W5yS4rXyrmCXvqKYJJA==
X-Google-Smtp-Source: AGHT+IGw0GWeA9nFWx8tdWlnhRSh9bZ380WFgLe85zPUu2xpuOAYGoPWj/kUfxzDOV7sQcwDL+RvPQ==
X-Received: by 2002:adf:e685:0:b0:317:6a7c:6e07 with SMTP id
 r5-20020adfe685000000b003176a7c6e07mr9683309wrm.32.1692111091141; 
 Tue, 15 Aug 2023 07:51:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a5d4528000000b0031779a6b451sm18191537wra.83.2023.08.15.07.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE8A71FFC3;
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
Subject: [PATCH 9/9] gdbstub: replace global gdb_has_xml with a function
Date: Tue, 15 Aug 2023 15:51:26 +0100
Message-Id: <20230815145126.3444183-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Try and make the self reported global hack a little less hackish by
providing a query function instead. As gdb_has_xml was always set if
we negotiated XML we can now use the presence of ->target_xml as the
test instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h    |  1 +
 include/exec/gdbstub.h | 10 +++++-----
 gdbstub/gdbstub.c      | 12 +++++++-----
 gdbstub/softmmu.c      |  1 -
 gdbstub/user.c         |  1 -
 target/arm/gdbstub.c   |  8 ++++----
 target/ppc/gdbstub.c   |  4 ++--
 7 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 4876ebd74f..fee243081f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -33,6 +33,7 @@ typedef struct GDBProcess {
     uint32_t pid;
     bool attached;
 
+    /* If gdb sends qXfer:features:read:target.xml this will be populated */
     char *target_xml;
 } GDBProcess;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 7d743fe1e9..0ee39cfdd1 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -31,12 +31,12 @@ int gdbserver_start(const char *port_or_device);
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /**
- * gdb_has_xml:
- * This is an ugly hack to cope with both new and old gdb.
- * If gdb sends qXfer:features:read then assume we're talking to a newish
- * gdb that understands target descriptions.
+ * gdb_has_xml() - report of gdb supports modern target descriptions
+ *
+ * This will report true if the gdb negotiated qXfer:features:read
+ * target descriptions.
  */
-extern bool gdb_has_xml;
+bool gdb_has_xml(void);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
 extern const char *const xml_builtin[][2];
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0f9032d793..88a4b6a06b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -75,8 +75,6 @@ void gdb_init_gdbserver_state(void)
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
 }
 
-bool gdb_has_xml;
-
 /* writes 2*len+1 bytes in buf */
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len)
 {
@@ -351,6 +349,11 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
     }
 }
 
+bool gdb_has_xml(void)
+{
+    return !!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml;
+}
+
 static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
@@ -1079,7 +1082,7 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1100,7 +1103,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1567,7 +1570,6 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
         return;
     }
 
-    gdb_has_xml = true;
     p = get_param(params, 0)->data;
     xml = get_feature_xml(p, &p, process);
     if (!xml) {
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index f509b7285d..9f0b8b5497 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -97,7 +97,6 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
 
         vm_stop(RUN_STATE_PAUSED);
         replay_gdb_attached();
-        gdb_has_xml = false;
         break;
     default:
         break;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 5b375be1d9..7ab6e5d975 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -198,7 +198,6 @@ static void gdb_accept_init(int fd)
     gdbserver_state.c_cpu = gdb_first_attached_cpu();
     gdbserver_state.g_cpu = gdbserver_state.c_cpu;
     gdbserver_user_state.fd = fd;
-    gdb_has_xml = false;
 }
 
 static bool gdb_accept_socket(int gdb_fd)
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f421c5d041..8fc8351df7 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -48,7 +48,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     }
     if (n < 24) {
         /* FPA registers.  */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return gdb_get_zeroes(mem_buf, 12);
@@ -56,7 +56,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     switch (n) {
     case 24:
         /* FPA status register.  */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return gdb_get_reg32(mem_buf, 0);
@@ -102,7 +102,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
     if (n < 24) { /* 16-23 */
         /* FPA registers (ignored).  */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return 12;
@@ -110,7 +110,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     switch (n) {
     case 24:
         /* FPA status register (ignored).  */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return 4;
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ca39efdc35..2ad11510bf 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -56,7 +56,7 @@ static int ppc_gdb_register_len(int n)
         return sizeof(target_ulong);
     case 32 ... 63:
         /* fprs */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return 8;
@@ -76,7 +76,7 @@ static int ppc_gdb_register_len(int n)
         return sizeof(target_ulong);
     case 70:
         /* fpscr */
-        if (gdb_has_xml) {
+        if (gdb_has_xml()) {
             return 0;
         }
         return sizeof(target_ulong);
-- 
2.39.2


