Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7B7548FA
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfj1-0004Wp-Rn; Sat, 15 Jul 2023 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiR-000465-3E
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiP-0001Ig-H8
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31441bc0092so2962726f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429219; x=1692021219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EchJl5hjgKZgeWYuYg1q+jxNR3MablBrvDvJkqZmCU=;
 b=eNv6KoKlNQZZMsoIMzJoL+ZzExXw342ELL1HrpWXaxhSq1wgs3OdvUrAME6urpVk/s
 NyoP6qRJ0er9XrBvzVrjSGDEb5uVMu5H4nJDKte1H+Abu731gBbDz1p65JuaBgO9ebdO
 mMkORZSBc8WdkkfgqVBfC2jhz6h2dfxIevdPSY8NJd8hq0zbhjn4/ufHSlKWpHT4Bx8u
 aRopsMf24KYiLczFIXnfwnhbiRUe6c5vuZd9qYzA3FwF3EVYM0Varasgqnr9+cQHS3Bs
 U998R2wyexEW9vxtsRIo5iUGZO5DgeRkxh/yh5357H0SAWBPw3nLII8XQLm0KdRSc82e
 2e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429219; x=1692021219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4EchJl5hjgKZgeWYuYg1q+jxNR3MablBrvDvJkqZmCU=;
 b=E08KIpcUcmmV8kA+bT3ki8evTMXiOj5H+LwO1XvM2Z/9ABc1k5JAcwW68bJTTkBsMN
 6L4DJpWd7CERnQGmWM4RK4lN3khBM1ywpPcWD3mzyE17235ZNP+CayIeb6Fq3K90vuE9
 b/kfnBACpEjlComPIK6sXHOFb8OoqT4qgS685H3XVluPP4ZTzRE4aMRV5eqoslDhwsdA
 Lb1ptysBhq3MTcc++mFW2RoZIM29Gz8KLetUp9bKeaeYwWbXSj7NIHn8rpuaqk85bCDN
 Z/qBZ8A4RrHFAVG4Xbj6GRWCx9990NTLbIxxW+OIQ/VuS7tjHU3Vl5D/d7l+vYyBWoC+
 KwIQ==
X-Gm-Message-State: ABy/qLavtrrKrNiwAo0LvwZ+jPWksCVfhFddR1v1C9eBQKT85rbyKnKb
 KmuhaGKa+q6MPEcbNI1dLM6IBJhAITiD+5NI44PKrA==
X-Google-Smtp-Source: APBJJlHTcm+vm/IvK7TCIwERWmnXfXvAYLhzbie20HUteHf+IyFimDi5SF2alttYkp5wlDqQpFGqlw==
X-Received: by 2002:a5d:5505:0:b0:313:f98a:1fd3 with SMTP id
 b5-20020a5d5505000000b00313f98a1fd3mr6977580wrv.27.1689429219290; 
 Sat, 15 Jul 2023 06:53:39 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 25/47] linux-user: Populate more bits in mmap_flags_tbl
Date: Sat, 15 Jul 2023 14:52:55 +0100
Message-Id: <20230715135317.7219-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-9-richard.henderson@linaro.org>
---
 linux-user/strace.c  | 23 ++++++++++-------------
 linux-user/syscall.c | 21 +++++++++++++++++++--
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9228b235da..bbd29148d4 100644
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
index 02d3b6c90a..3a89f6b408 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6012,9 +6012,19 @@ static const StructEntry struct_termios_def = {
     .print = print_termios,
 };
 
+/* If the host does not provide these bits, they may be safely discarded. */
+#ifndef MAP_SYNC
+#define MAP_SYNC 0
+#endif
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
@@ -6032,6 +6042,13 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
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


