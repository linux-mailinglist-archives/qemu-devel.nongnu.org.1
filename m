Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22974B845
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGK-0004mg-DM; Fri, 07 Jul 2023 16:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGG-0004j7-KZ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGE-0004e2-Rm
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so25328905e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762461; x=1691354461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2kxpoTo/D6lAeqPJxWGsbdox8UTpGN/fykOYkONe80=;
 b=eSf0ydDeKFGinF4i7T4iQAz0VkndFzqqlUdrTnjvGdATg2a01+ecgaVy4ZM61YCOW6
 GFGJSczA382gPKWJeYUmH+6CkbSnbM4ZDOpM7vZ23+wiX/Kplp16XUZUV7ku55uBL3BZ
 uxa4GEBGM9vicrJiJEcDcbG3NbrCXUgazYr3vgf9t+ss21iG37SdK1ZCTyMBi7BulyfB
 7aPj3xaSHwKdM4fDWcmqRwlhHulNRkN2d9NQLRo3RdSNoUrfSMGZeTg1dFbzCWmzgWwU
 ppa8bUZRvsJkZy0JyFuFbFBjmrdUxzKX/pufbxzm6BhuuLNn37nHOEnc6EfX2UzLgNRR
 FuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762461; x=1691354461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2kxpoTo/D6lAeqPJxWGsbdox8UTpGN/fykOYkONe80=;
 b=UE8Oi9P8R2Fey+ZYEog56qPYTsLVBmAMVwltGOxT51iYgE8umWFHPEdPfKTmQnrldU
 GhlLM2DLi7UQ2B8IKx/P6sT+gAkwpQc7K+pvOjY8mcrdtllMWzaHoPIWl/rr3L3Eeyar
 mop5f07QwkRcg8akMlRYluk0/IyxP5xTtoP1ZbzyNhskVsQDRoie76sK4TSM6hNN/CWn
 /TZp4OCxCciz9CTGuIeygCtKdV2WyEQek0ne0kAPAloAEkfVVLeH+wx5TOdJGG82N9Q9
 3NSbmY2XPZveDTd9DcHfNMuWhxhJfCs90lx3l+dmAms/RmntzOco3+Hf+mRDOMz9idBy
 UQZQ==
X-Gm-Message-State: ABy/qLZrovdObEgLvS+9gkvlRo+V1PYyviImlGPik/QzOZG8hWSNfRGh
 783edkjffizAxIOuDiNuvoG1p4M5pDtXpn15frbGjA==
X-Google-Smtp-Source: APBJJlFBdR0vxWE1oTcdfGJYmQ5PPt/tmtedQgF+kmbmth25PGvjVuhC1gkJGt5eqGtL8hl6BMBEqw==
X-Received: by 2002:a05:600c:210a:b0:3f6:58ad:ed85 with SMTP id
 u10-20020a05600c210a00b003f658aded85mr4664061wml.10.1688762461345; 
 Fri, 07 Jul 2023 13:41:01 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 06/24] linux-user: Populate more bits in mmap_flags_tbl
Date: Fri,  7 Jul 2023 21:40:36 +0100
Message-Id: <20230707204054.8792-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
index 08162cc966..2c0c6e745e 100644
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


