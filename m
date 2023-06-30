Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BDC743CAB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4h-0007ba-8f; Fri, 30 Jun 2023 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4d-0007ah-Nn
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4a-0003MQ-UM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1646851f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131323; x=1690723323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/lN5cy8mvBZHCXHBxQGLZc7gXDGj90XuXQ2MKd1eIg=;
 b=NJcD9Z3Vx0DORqxD5zGnNTJuAnjz7S5I2l3ygdXCuFi0bXb6K5jePa4Xc+d77yqce9
 ZIN2cJAJ+5C+Ejeyuh/zz5FH1ugVVQuAJ5JThk6cS/C4rIwcSAGJoSvRkVCce0PzzmYQ
 5ZHvaS51ZIIEcFAzdqh8UfkI/I0xvTsQkG1pYyeuQwZBezVrLfosLxZb+wTz9rvcdAZh
 BwJNSyKFb2sIXfQAEBcE0m/LXp1/GLdN0TSLXPGraRMB311OlV4DfKZEe+OzAc9xlN8S
 OcSWt1zbnINy5NSi+E1/EVecucQ/QDgipETsafpmUMeVsrYEfOV2+kR+dgmkLQt1CGef
 ttig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131323; x=1690723323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/lN5cy8mvBZHCXHBxQGLZc7gXDGj90XuXQ2MKd1eIg=;
 b=jLu8SYQuy7WyjRsBVffWeV7g93qX7e+tcIKlr6VyrtyBKYpOTSJg935aEwwaCCc5yZ
 HGJzNStF15qgri70V8v53n256NSQ/2waKAwUHa2A7ht2Yzghu+7Do+13uHBH+RRqIFwg
 ZPyB+Zp8FB63I1PAu5Vkc9otO+192bSF0PfCHtRe8+W4qZbgPVCernSxLrWnKZrwSDTJ
 8k04Bcgm6F76+ze7zGDLZFudRAFR5su12uc67Jd2amoJWy0avqdZHiKVWwIeouOHgx9E
 4z9wCAQVhBdEHy5bpNIozIbrMcgpCFM3rXzEujIxEDqgxNPfDo6Mtmbc+xQTLJL20oVr
 c50g==
X-Gm-Message-State: AC+VfDx6p09B5HQvohf8Da+L2+D0+LzYXuMSEKBAI1Wszo+U4aPVCYh4
 R6WLsmORfcCL4ew2/94VMjY3D7EIP0t5jHiWXw1xvw==
X-Google-Smtp-Source: ACHHUZ6X6twbIGyw57WHjYNFfmlU2BWcEzM0AcF5EkTet1/w43dHmSfflOafG4klxEe1fRtUlDbiHA==
X-Received: by 2002:a5d:548e:0:b0:311:360e:ea3a with SMTP id
 h14-20020a5d548e000000b00311360eea3amr6855682wrv.34.1688131323486; 
 Fri, 30 Jun 2023 06:22:03 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 03/24] linux-user/strace: Expand struct flags to hold a mask
Date: Fri, 30 Jun 2023 15:21:38 +0200
Message-Id: <20230630132159.376995-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

A zero bit value does not make sense -- it must relate to
some field in some way.

Define FLAG_BASIC with a build-time sanity check.
Adjust FLAG_GENERIC and FLAG_TARGET to use it.
Add FLAG_GENERIC_MASK and FLAG_TARGET_MASK.

Fix up the existing flag definitions for build errors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index aad2b62ca4..566396d051 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -46,15 +46,21 @@ struct syscallname {
  */
 struct flags {
     abi_long    f_value;  /* flag */
+    abi_long    f_mask;   /* mask */
     const char  *f_string; /* stringified flag */
 };
 
+/* No 'struct flags' element should have a zero mask. */
+#define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
+
 /* common flags for all architectures */
-#define FLAG_GENERIC(name) { name, #name }
+#define FLAG_GENERIC_MASK(V, M)  FLAG_BASIC(V, M, #V)
+#define FLAG_GENERIC(V)          FLAG_BASIC(V, V, #V)
 /* target specific flags (syscall_defs.h has TARGET_<flag>) */
-#define FLAG_TARGET(name)  { TARGET_ ## name, #name }
+#define FLAG_TARGET_MASK(V, M)   FLAG_BASIC(TARGET_##V, TARGET_##M, #V)
+#define FLAG_TARGET(V)           FLAG_BASIC(TARGET_##V, TARGET_##V, #V)
 /* end of flags array */
-#define FLAG_END           { 0, NULL }
+#define FLAG_END           { 0, 0, NULL }
 
 /* Structure used to translate enumerated values into strings */
 struct enums {
@@ -963,7 +969,7 @@ print_syscall_ret_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
 #endif
 
 UNUSED static const struct flags access_flags[] = {
-    FLAG_GENERIC(F_OK),
+    FLAG_GENERIC_MASK(F_OK, R_OK | W_OK | X_OK),
     FLAG_GENERIC(R_OK),
     FLAG_GENERIC(W_OK),
     FLAG_GENERIC(X_OK),
@@ -999,9 +1005,9 @@ UNUSED static const struct flags mode_flags[] = {
 };
 
 UNUSED static const struct flags open_access_flags[] = {
-    FLAG_TARGET(O_RDONLY),
-    FLAG_TARGET(O_WRONLY),
-    FLAG_TARGET(O_RDWR),
+    FLAG_TARGET_MASK(O_RDONLY, O_ACCMODE),
+    FLAG_TARGET_MASK(O_WRONLY, O_ACCMODE),
+    FLAG_TARGET_MASK(O_RDWR, O_ACCMODE),
     FLAG_END,
 };
 
@@ -1010,7 +1016,9 @@ UNUSED static const struct flags open_flags[] = {
     FLAG_TARGET(O_CREAT),
     FLAG_TARGET(O_DIRECTORY),
     FLAG_TARGET(O_EXCL),
+#if TARGET_O_LARGEFILE != 0
     FLAG_TARGET(O_LARGEFILE),
+#endif
     FLAG_TARGET(O_NOCTTY),
     FLAG_TARGET(O_NOFOLLOW),
     FLAG_TARGET(O_NONBLOCK),      /* also O_NDELAY */
@@ -1075,7 +1083,7 @@ UNUSED static const struct flags umount2_flags[] = {
 };
 
 UNUSED static const struct flags mmap_prot_flags[] = {
-    FLAG_GENERIC(PROT_NONE),
+    FLAG_GENERIC_MASK(PROT_NONE, PROT_READ | PROT_WRITE | PROT_EXEC),
     FLAG_GENERIC(PROT_EXEC),
     FLAG_GENERIC(PROT_READ),
     FLAG_GENERIC(PROT_WRITE),
@@ -1103,7 +1111,7 @@ UNUSED static const struct flags mmap_flags[] = {
 #ifdef MAP_POPULATE
     FLAG_TARGET(MAP_POPULATE),
 #endif
-#ifdef TARGET_MAP_UNINITIALIZED
+#if defined(TARGET_MAP_UNINITIALIZED) && TARGET_MAP_UNINITIALIZED != 0
     FLAG_TARGET(MAP_UNINITIALIZED),
 #endif
     FLAG_TARGET(MAP_HUGETLB),
@@ -1201,13 +1209,13 @@ UNUSED static const struct flags statx_flags[] = {
     FLAG_GENERIC(AT_SYMLINK_NOFOLLOW),
 #endif
 #ifdef AT_STATX_SYNC_AS_STAT
-    FLAG_GENERIC(AT_STATX_SYNC_AS_STAT),
+    FLAG_GENERIC_MASK(AT_STATX_SYNC_AS_STAT, AT_STATX_SYNC_TYPE),
 #endif
 #ifdef AT_STATX_FORCE_SYNC
-    FLAG_GENERIC(AT_STATX_FORCE_SYNC),
+    FLAG_GENERIC_MASK(AT_STATX_FORCE_SYNC, AT_STATX_SYNC_TYPE),
 #endif
 #ifdef AT_STATX_DONT_SYNC
-    FLAG_GENERIC(AT_STATX_DONT_SYNC),
+    FLAG_GENERIC_MASK(AT_STATX_DONT_SYNC, AT_STATX_SYNC_TYPE),
 #endif
     FLAG_END,
 };
@@ -1481,14 +1489,10 @@ print_flags(const struct flags *f, abi_long flags, int last)
     const char *sep = "";
     int n;
 
-    if ((flags == 0) && (f->f_value == 0)) {
-        qemu_log("%s%s", f->f_string, get_comma(last));
-        return;
-    }
     for (n = 0; f->f_string != NULL; f++) {
-        if ((f->f_value != 0) && ((flags & f->f_value) == f->f_value)) {
+        if ((flags & f->f_mask) == f->f_value) {
             qemu_log("%s%s", sep, f->f_string);
-            flags &= ~f->f_value;
+            flags &= ~f->f_mask;
             sep = "|";
             n++;
         }
-- 
2.34.1


