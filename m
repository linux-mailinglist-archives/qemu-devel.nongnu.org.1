Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0D78D6B2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaP-0001G9-0x; Wed, 30 Aug 2023 10:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaK-0001Dq-Hh
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaF-0000lH-9L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so53705235e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407254; x=1694012054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIIWkIImEVUr1vcFkZ9mfJXCWjjR9U+tUkLobigHVPM=;
 b=T7COO35S88ANfT8GnupCiA0KH+UMe9X8yaUpz37HbEqx+43UjLJO7hTTNMeHTJVIjy
 AUgb7IHyPebTNiwk9H7REK+c2NNZipQJq3NJtZGT3+BASie6ed7QkWGlJcJdWGNVC8tL
 rOtbDwk5VqcnY3ik8kRYye/Jd5BKjGC3IXKBzPuqGyi30vL5ubdf2ifGIRkQ69G3MnZ1
 9UNBFqdZma7ZQ3koFd9uDlD83gyDXIJH133jUkUweRlbghBWUatrppDDPcScxSF3jxW1
 uLzfWfn/pBB3e4PHgdylVTEVpkOrjKlUkLokku9dn35B8ML7VfCot4M4VGGr3NkjRs5a
 TzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407254; x=1694012054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIIWkIImEVUr1vcFkZ9mfJXCWjjR9U+tUkLobigHVPM=;
 b=NaTtjg20o6zwrrB0tuii5Y9q8TF2bc1WC/3ILL1NTdihxUHLZ6V3Xp0nPPH4oti98y
 FR61B2CMPOzY/ddJ42o/vzi8ICiXEJ1xc6lR1LOerGrSfrE2Es+CDay+iMWvyyX2/Pps
 oPVXrMTasaGmjrnZOhPsn0O1OTNs2QJ0YOPipTiyw+K6P/LRDC4POhifEiKwKMvWi2FU
 6UYIkWE/u6STI+jifnX3oBn/OhCk0WCPfThGYjD670AzfnUrq5zTHNYm9zqWjNN4pPeE
 epFIrK6SK+L+abmPy8COFvQkurAmq/MtPHJh7JsMVXIiCROfYRAMou6Mkh3083MEpAnZ
 4dFg==
X-Gm-Message-State: AOJu0YwKyU96z9BSBn2Sln//CT28RQoODIotHpQ49o07Z72pu051yh7J
 DifbqvXMvAcoqafP8I7qz9vToQ==
X-Google-Smtp-Source: AGHT+IHGHcet/8iGTfC3vzIvHbGUcMB04gwTy2C38mu/ucSFQGJdLu9hiEWUb8mmVWCJGC0s7TZxDQ==
X-Received: by 2002:a05:600c:b50:b0:3fe:c7fe:206e with SMTP id
 k16-20020a05600c0b5000b003fec7fe206emr2253566wmr.16.1693407253709; 
 Wed, 30 Aug 2023 07:54:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a7bcbc8000000b00401d8810c8bsm2501252wmi.15.2023.08.30.07.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE1081FFBD;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 11/12] gdbstub: replace global gdb_has_xml with a function
Date: Wed, 30 Aug 2023 15:54:06 +0100
Message-Id: <20230830145407.3064249-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-12-alex.bennee@linaro.org>

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
index 729e54139a..fdebfe25ea 100644
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
@@ -1084,7 +1087,7 @@ static void handle_set_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1105,7 +1108,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 {
     int reg_size;
 
-    if (!gdb_has_xml) {
+    if (!gdb_get_cpu_process(gdbserver_state.g_cpu)->target_xml) {
         gdb_put_packet("");
         return;
     }
@@ -1572,7 +1575,6 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
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


