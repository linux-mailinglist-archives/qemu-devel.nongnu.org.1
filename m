Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019874C75B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEO-0005qr-7a; Sun, 09 Jul 2023 14:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDm-0003IB-HP
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDk-0004B4-RE
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3141c8a6f30so3699994f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927599; x=1691519599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIuxSLqMoIpVaPV7oBSzF0bXGsGWX5Yu9PjHzEifuto=;
 b=pqKf6mnb2pIUuQOfxWaLusZV7eZHaTzGBLyRe4PtGrxHTGKxPbMMjOq0NTyJLVmxQc
 MYwfCw9/jW/j+jeD5lCFN4hD8xGRleO+rRLLkdMWMRfW+7pzIgsHc5xrFvQX21QlFeJ4
 JJER3YDaNJnmOH5uWjUUXoZExXHOssyYBa92lfPsTggSHbsSE/r+Exxkti8OvHXx1gui
 4Q432ivqlx1575EUg/gQV5c5DK5WmrnWHRltOwhELJ4/8srU33AdZK9KISBZjq3visEf
 Qv+pXcF4cM+MfbJGZqU12+hdUC8UN2gGCDYJ8HXUZsEn6zPyjrx5gLZL4oVX3XBPG/e8
 310w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927599; x=1691519599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIuxSLqMoIpVaPV7oBSzF0bXGsGWX5Yu9PjHzEifuto=;
 b=UT/7eLFDeiz/tgl1BUY+VAgCI6sNtKV+Inptff2kfgcC5HyuuHzRNWd3KHBMQD6y5b
 20bVHpGOxYmQYRd3VP8Y6GpzqdDSx/XeIPNJLeOz7IKogLcSPTtv829X+HhED3VRstC1
 ZXNeliXciJZryo/Kd1tDipy+1ANK9DFfCMa3m/5kZu860BKOcibR35sCYETlSHH4EGZO
 j2T9fV6QbQIJsafgUuUHZPdmlw5tHsaV3/fte6QaKjTsEiQ7WXJ59Wut50dzVYkYU6WD
 ZE9yap3agnIJKr9Fwr3Skxj87evHxZPDBOXRZE5YfofoqstVcI+hdNSJOcnP2vdFEU61
 ayQA==
X-Gm-Message-State: ABy/qLbYeAw5RueLCLmu5icr0XcDn2c3EpsYoCuwuO9CH7jPjEQMZmKD
 kS6ynNE54IzM1ncIzu3sKi6HJ2CRfR8fapRuljGEPw==
X-Google-Smtp-Source: APBJJlGeyWR21v6B2u0GmXVd717UDJosX1Xu8/pO/YdQ8zwMWreCp0rKT0TjPu6zDRDo0H1okZegeA==
X-Received: by 2002:a5d:44c7:0:b0:313:f33c:24c4 with SMTP id
 z7-20020a5d44c7000000b00313f33c24c4mr6710114wrr.39.1688927599104; 
 Sun, 09 Jul 2023 11:33:19 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 25/45] linux-user: Populate more bits in mmap_flags_tbl
Date: Sun,  9 Jul 2023 19:29:01 +0100
Message-Id: <20230709182934.309468-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
index 04e07cf261..36c4d88793 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6002,9 +6002,19 @@ static const StructEntry struct_termios_def = {
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
@@ -6022,6 +6032,13 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
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


