Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C576595A
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3ak-0000ED-TN; Thu, 27 Jul 2023 12:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3aj-0000Dm-AW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3ah-00046Q-Kp
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so8800205ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690474310; x=1691079110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mlAaXL3bxV/cTeXm/tHUXfFmU7oIzFbeSbiCq9TZf/A=;
 b=h2oGLtGJb3Kc1jlBvVxBTqrgzHayr6U5xH642Ot3kUuqEWro062QMG0LNoYubhWPZ5
 zTJruWFh9wKK4S508YtDoqWuToHdX9W9XiQIEn/0nse3r+feAQAb1SSiwGbKThM5EiME
 oCnA39xqsZoMLIa6TDqzBnigQCZYQUFS2OOSTjcGQbTIVbuwuwSbAneZOsaEJveGLbWb
 dtK5TlCGDD64S+1X6UO/1OGQ11KQ7Cqi1bgnvDG0on0Kh43O6b7FGEn6s0MTgupuffwn
 komR9oIaCRAJRnCcVfu8WjXT/jOY0bD3baeCnxFcjeaBa6nrVjTzj7W/owJ5ZoSMc9gH
 XBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474310; x=1691079110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlAaXL3bxV/cTeXm/tHUXfFmU7oIzFbeSbiCq9TZf/A=;
 b=YpbU+sFMe9JmMCOeeNCxi72N011AlpNormCxouVsR9L/pWCRf9xSL7o24wwomTWB3J
 LdtSj9xyb7b5skDZ54m+2CI9PjNI3b64jN7513cakN27qHECWSiK8dvgdDnGM2oLqabQ
 Tt8F/0ZkVHUUqq73/Qh84io82MHw2nwV0lCMbosgqed1rEbxPNbUgS39iamsfUPR/OiH
 La5EoiuMZFq1xZHtghRTRliXyuMENWR9Pur197pBIjTHMNsQb7EE8+hmbre60zmroRbV
 bl7k10zIqGk6QCemzT8lxywcVYAyvdRNUfXjoCzQsz5uQ/a+uFdZKoX4ODr87pfTBRHA
 5WPQ==
X-Gm-Message-State: ABy/qLb9atH2aMEUnh91GY4UifFbE/la7iUR81Ng+smwtWfFsfQHGdwd
 Zm9gvYAj8o35eolMkg2SBW7aoMNijctUkOY9eD0=
X-Google-Smtp-Source: APBJJlFsdTjsuDI+0RDdc0fiI//FtdRIyLHVzuLESflhuqzZxsAP8tHFeMe8CfIXWHJMm4e2I/+4dQ==
X-Received: by 2002:a17:902:7792:b0:1b0:6038:2982 with SMTP id
 o18-20020a170902779200b001b060382982mr4827166pll.41.1690474310220; 
 Thu, 27 Jul 2023 09:11:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001b9be79729csm1834329plc.165.2023.07.27.09.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:11:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: [PATCH] bsd-user: Properly allocate guest virtual address space
Date: Thu, 27 Jul 2023 09:11:48 -0700
Message-Id: <20230727161148.444988-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Do not hard-code guest_base at 32GB.
Do not override mmap_next_start for reserved_va.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Hi Warner,

With the blitz-trial branch you provided, the host libc allocates
thread-local storage within the [32GB, 36GB) region that you currently
assume is free.

The armv7-hello program happens to map on top of this thread-local
storage, and then we crash later accessing some host TLS variable.

While the linux-user probe_guest_base is significantly more complex,
we are also trying to handle 32-bit hosts.  I think freebsd is always
assuming 64-bit hosts, which makes this simpler.


r~
---
 bsd-user/main.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index f500ec292b..9760aad9f6 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -50,20 +50,8 @@
 
 int do_strace;
 
-/*
- * Going hand in hand with the va space needed (see below), we need
- * to find a host address to map the guest to. Assume that qemu
- * itself doesn't need memory above 32GB (or that we don't collide
- * with anything interesting). This is selected rather arbitrarily,
- * but seems to produce good results in tests to date.
- */
-# if HOST_LONG_BITS >= 64
-uintptr_t guest_base = 0x800000000ul;    /* at 32GB */
-bool have_guest_base = true;
-#else
-uintptr_t guest_base;    /* TODO: use sysctl to find big enough hole */
+uintptr_t guest_base;
 bool have_guest_base;
-#endif
 static bool opt_one_insn_per_tb;
 static const char *cpu_model;
 static const char *cpu_type;
@@ -522,10 +510,6 @@ int main(int argc, char **argv)
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
-    if (reserved_va) {
-        mmap_next_start = reserved_va + 1;
-    }
-
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
@@ -543,7 +527,24 @@ int main(int argc, char **argv)
      * Now that page sizes are configured we can do
      * proper page alignment for guest_base.
      */
-    guest_base = HOST_PAGE_ALIGN(guest_base);
+    if (have_guest_base) {
+       if (guest_base & ~qemu_host_page_mask) {
+            error_report("Selected guest base not host page aligned");
+            exit(1);
+        }
+    } else if (reserved_va) {
+        void *p = mmap(NULL, reserved_va + 1, PROT_NONE, MAP_GUARD, -1, 0);
+        if (p == MAP_FAILED) {
+            const char *err = strerror(errno);
+            char *sz = size_to_str(reserved_va + 1);
+
+            error_report("Cannot allocate %s bytes for guest address space: %s",
+                         sz, err);
+            exit(1);
+        }
+        guest_base = (uintptr_t)p;
+        have_guest_base = true;
+    }
 
     if (loader_exec(filename, argv + optind, target_environ, regs, info,
                     &bprm) != 0) {
-- 
2.41.0


