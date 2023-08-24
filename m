Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 403377875AC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMw-0006Vr-FO; Thu, 24 Aug 2023 12:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMu-0006TW-5p
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMd-00088s-IA
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso2462039f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895158; x=1693499958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8sZlZQ03i3sPTIpdxfGoCKoeJq6c1GtfjdswDhdAs0=;
 b=mpWjvtPN2/VrX9hgl8P6z0Vi4yDpwa7EaRnxmHfkpprX9dA6SJNPoIrJt31UIdsJmS
 qoY8ZRqCRGOWNFQfAA4H6eN9P39h7IjF54mncS52yG4MSSe8TJ0Zm94huWCxiu6mW9sr
 jxHt7tpq9YwO7/U4Pm3f73+ZWsoc+VvOtIkhn2/y9CzpaHIfaPgEkYmZRW9RxyoD6qTa
 C7XaEPhdBbCnDqZBlWPeDT3zNvXCYJGqJ3F0QXfbBHNS8JUCtCOqPhDN0LtQnRLkYE7A
 BvvM742wQ/K6n3upaPXllVYFmX54RbEINWcd13bx+e1YhZwkAefi6kyjoDRgcaXCwoE1
 QSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895158; x=1693499958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8sZlZQ03i3sPTIpdxfGoCKoeJq6c1GtfjdswDhdAs0=;
 b=O6/D8g407l+8L7+52LMgoCVEJISq7IXtyn9nU+mT1tjPBHeRB6h7rccjxg2iRP5rqx
 fvhVut/HIorG/hWApyfCo3PErmoLpHP12sNzOcAz7M+s4SEsjq5LdYDG5Mb58iSsMXd7
 7dmgKv30uXQhFscouZhnXuwXpyJSE3xVjd8qOzFdh5PvydQ66Y8QzPEYATa1Bu4dAvtU
 Vrs5w4/6FEbAZXyytqXzEwLcojffqUbWKaKt3wEPnEbmj8KCYjtb2N4nVc9954owjhjB
 AXNrYoIKoO7n+KssGbDZmSAig6x4tR7zxD/SzVitYZMUkD8ZdKT0InYrwy5NxXrcMVnc
 Y4Og==
X-Gm-Message-State: AOJu0YwlC9pBfd+TlHxv8B5mduPW3kffX200r5PDqXtxc5G86+6vGN1I
 zuq8b9b4pYzsyUXAbsW06+UjGg==
X-Google-Smtp-Source: AGHT+IF05Gqblbg12Z1Jpj9vJxezVTemgo4jMTW4T9cL9LWIi7oq4iwYSJaGodGQB01nUXMRlZfR7g==
X-Received: by 2002:a5d:5242:0:b0:316:f25c:d0b3 with SMTP id
 k2-20020a5d5242000000b00316f25cd0b3mr13566736wrc.22.1692895157798; 
 Thu, 24 Aug 2023 09:39:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x9-20020adfffc9000000b00319756d5b80sm22859712wrs.29.2023.08.24.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EB641FFC6;
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
Subject: [PATCH v2 11/12] gdbstub: replace global gdb_has_xml with a function
Date: Thu, 24 Aug 2023 17:39:09 +0100
Message-Id: <20230824163910.1737079-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
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
index 31a2451f27..10fb755390 100644
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
@@ -1078,7 +1081,7 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1099,7 +1102,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1566,7 +1569,6 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
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


