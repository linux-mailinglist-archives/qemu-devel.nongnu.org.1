Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7823743CA6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4h-0007bn-EX; Fri, 30 Jun 2023 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4f-0007b0-61
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4d-0003Mo-2c
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2129631f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131325; x=1690723325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6xb79Qrwr3/yCfe4b5zEEhfS7DawccD4GjG/Ycn2cY=;
 b=OXfFuGDo57Y97RTz+mQ69erMGcanLkMYWqneaVI7r1QbQShfQ3SpYku3MbuV9fTEkr
 zupgUQFpWZBNlB8JzdAY4BfP3afWTtutURoICQlNeAQOo77ZWAzdKvEvnLVg+QLMMWGu
 KO9wP85Gx6n2Hiqis28B8r61FjFwwjyTzjlDUURyie+3cb6vc6nLNaS6ZnStrXKmgy+B
 noaXxXNJ6gj/d6MQG4jvT+ESsRNBx9s7+4CLqc5LFxIpqkhZnIswkUX4aEu1fJsdfEsC
 W1ssDiq3FzFJD4MFvtF3jrfNEiJ1PMG8oBytxMAM5oZIztwHpn8hGQ0wwax7lT93nOkh
 AEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131325; x=1690723325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6xb79Qrwr3/yCfe4b5zEEhfS7DawccD4GjG/Ycn2cY=;
 b=gFyLVnPOq/EBazcP+AuFRsFyCv6e4mH/vaqcuDlqAOfMTju/ls+CkQk/kMIp3vlDs0
 KEEtK3gHpOSe0bdeAbLIPzXmkK4nS2bDOdQg5f2OLys11h1HqJQtQLyTRKigzjzeiCb0
 ld6eFhVu5vVAAI7X4rE2OH71yLkrTOcZhkaAHymABrzrJA8gAa9XSKbtE8PecJlf4E4/
 7FZii/aHE5WEhrN4XXRCzuOaYjrEn9Pwa4PkgIMjMVPtVpH8CX8dsxeRHTg2524mQEuE
 5YgYQWIFUx+m5nyRECAu4kvQRQR6M99HrsHLC/PpnBJSTa/cDkeTMm63D1V8AsId6JMj
 RjkQ==
X-Gm-Message-State: ABy/qLbZU3H41uTVYhfpqp1jp3CQt0VPDh93+qhBTxKxxadwbsTWXZ32
 DYwL2C5R4tpaaTO5MVPOifFXt7aYCwXS47vb8eJgXQ==
X-Google-Smtp-Source: APBJJlEGp1+mLJXZOXtJ2zb1Q5sBqGHac4eTOReG+nv8JDBef8XVz2XldHwZ70zIra2AnyxUwjd1aA==
X-Received: by 2002:adf:fecb:0:b0:314:1031:aa96 with SMTP id
 q11-20020adffecb000000b003141031aa96mr2050541wrs.50.1688131325571; 
 Fri, 30 Jun 2023 06:22:05 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 06/24] linux-user: Populate more bits in mmap_flags_tbl
Date: Fri, 30 Jun 2023 15:21:41 +0200
Message-Id: <20230630132159.376995-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Fix translation of TARGET_MAP_SHARED and TARGET_MAP_PRIVATE,
which are types not single bits.  Add TARGET_MAP_SHARED_VALIDATE,
TARGET_MAP_SYNC, TARGET_MAP_NONBLOCK, TARGET_MAP_POPULATE,
TARGET_MAP_FIXED_NOREPLACE, and TARGET_MAP_UNINITIALIZED.

Update strace to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c  | 23 ++++++++++-------------
 linux-user/syscall.c | 18 ++++++++++++++++--
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 566396d051..af5c5f135b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1094,28 +1094,25 @@ UNUSED static const struct flags mmap_prot_flags[] = {
 };
 
 UNUSED static const struct flags mmap_flags[] = {
-    FLAG_TARGET(MAP_SHARED),
-    FLAG_TARGET(MAP_PRIVATE),
+    FLAG_TARGET_MASK(MAP_SHARED, MAP_TYPE),
+    FLAG_TARGET_MASK(MAP_PRIVATE, MAP_TYPE),
+    FLAG_TARGET_MASK(MAP_SHARED_VALIDATE, MAP_TYPE),
     FLAG_TARGET(MAP_ANONYMOUS),
     FLAG_TARGET(MAP_DENYWRITE),
-    FLAG_TARGET(MAP_FIXED),
-    FLAG_TARGET(MAP_GROWSDOWN),
     FLAG_TARGET(MAP_EXECUTABLE),
-#ifdef MAP_LOCKED
+    FLAG_TARGET(MAP_FIXED),
+    FLAG_TARGET(MAP_FIXED_NOREPLACE),
+    FLAG_TARGET(MAP_GROWSDOWN),
+    FLAG_TARGET(MAP_HUGETLB),
     FLAG_TARGET(MAP_LOCKED),
-#endif
-#ifdef MAP_NONBLOCK
     FLAG_TARGET(MAP_NONBLOCK),
-#endif
     FLAG_TARGET(MAP_NORESERVE),
-#ifdef MAP_POPULATE
     FLAG_TARGET(MAP_POPULATE),
-#endif
-#if defined(TARGET_MAP_UNINITIALIZED) && TARGET_MAP_UNINITIALIZED != 0
+    FLAG_TARGET(MAP_STACK),
+    FLAG_TARGET(MAP_SYNC),
+#if TARGET_MAP_UNINITIALIZED != 0
     FLAG_TARGET(MAP_UNINITIALIZED),
 #endif
-    FLAG_TARGET(MAP_HUGETLB),
-    FLAG_TARGET(MAP_STACK),
     FLAG_END,
 };
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83..459a2d8bc7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6002,9 +6002,16 @@ static const StructEntry struct_termios_def = {
     .print = print_termios,
 };
 
+/* If the host does not provide these bits, they may be safely discarded. */
+#ifndef MAP_UNINITIALIZED
+#define MAP_UNINITIALIZED 0
+#endif
+
 static const bitmask_transtbl mmap_flags_tbl[] = {
-    { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
-    { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
+    { TARGET_MAP_TYPE, TARGET_MAP_SHARED, MAP_TYPE, MAP_SHARED },
+    { TARGET_MAP_TYPE, TARGET_MAP_PRIVATE, MAP_TYPE, MAP_PRIVATE },
+    { TARGET_MAP_TYPE, TARGET_MAP_SHARED_VALIDATE,
+      MAP_TYPE, MAP_SHARED_VALIDATE },
     { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
     { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
       MAP_ANONYMOUS, MAP_ANONYMOUS },
@@ -6022,6 +6029,13 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
        Recognize it for the target insofar as we do not want to pass
        it through to the host.  */
     { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
+    { TARGET_MAP_SYNC, TARGET_MAP_SYNC, MAP_SYNC, MAP_SYNC },
+    { TARGET_MAP_NONBLOCK, TARGET_MAP_NONBLOCK, MAP_NONBLOCK, MAP_NONBLOCK },
+    { TARGET_MAP_POPULATE, TARGET_MAP_POPULATE, MAP_POPULATE, MAP_POPULATE },
+    { TARGET_MAP_FIXED_NOREPLACE, TARGET_MAP_FIXED_NOREPLACE,
+      MAP_FIXED_NOREPLACE, MAP_FIXED_NOREPLACE },
+    { TARGET_MAP_UNINITIALIZED, TARGET_MAP_UNINITIALIZED,
+      MAP_UNINITIALIZED, MAP_UNINITIALIZED },
     { 0, 0, 0, 0 }
 };
 
-- 
2.34.1


