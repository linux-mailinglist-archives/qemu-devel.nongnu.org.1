Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AB74C734
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEA-0004Ui-Gz; Sun, 09 Jul 2023 14:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0003Wp-DC
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDq-0004ED-9a
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so19654605e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927604; x=1691519604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVp7bvOVNX9kOQlZjcnMWNBhc4o39/6I/4Tb+lJViFc=;
 b=Te502nStAJsDxJZLfJsnaWCc+RMx+MF1zCZjPakbbQtsg/Rc1mtz0RnR/0CeANyusO
 gIRnBrABCPxdL14RfGVY/REJR7og2Y+sFJHPF8lIiGVbdbw8B+OGcNQ+pMKEHkHaLkw7
 tzEVrCxNxVq5llKILPE3bSqWAV2en3Q0cy5+XGRXn6z8UTTaCdg5rJdaNQhYqRUAFlto
 VN3WJypkEkEccQH4Lnb14C27MIWW4EF6C08dVQctBJIZSbu9GP6C8U8JozV5BbEG+8Fr
 G5PMvMiirbNzTok0x2PGGmQ9gg9uBdi8zVBWgGq68W4kMlUouNUlzz1dUwavC84g6nbV
 HQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927604; x=1691519604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVp7bvOVNX9kOQlZjcnMWNBhc4o39/6I/4Tb+lJViFc=;
 b=L55pMAj72HiEE7JikmKcs9pUrsr1uzpqJj11/2scs5GxQTuiVyFGDxgU9X5VW8BOMe
 TkKxme/FJBgQH8IHVekdvfRHJbO5n8qEcXePQgCd+FO1eJq5crO2gqdbzxYctlCMT18l
 emHOaBk9cfXhqPXQOdNiua/rGMy+asrtSBD/QJq+ZEEoet8oZ3tpDpYVKvnqPAJjdofb
 q7YWJhleyJdxJRb5Vy9EkAbVBJVg3b/7Rn5iuwMfppw5feBwY5CR/DAFeynAPiQgERjR
 wfwmhn5VAQZyWFTlUVZ0k2ZisAoDAhk+EHeLRhs/vM/U/hovNZMSAfTd4bW5UO5VFPMZ
 0vvA==
X-Gm-Message-State: ABy/qLZXdeLIyLctlSzvanNB8v2bBJnVaFY3IVecBnS0fgzOWTFSDJXv
 /3YUrCKpNSObOrZMl48/v5OAHRnS6WUl53EE+R7/fg==
X-Google-Smtp-Source: APBJJlFZ7htkh0QP1Rqbz+dp/JAzhvbVd0K91B/JFK3zjInJPK/9e4EuxS3C/FK39oTy5Yp1RBZuGQ==
X-Received: by 2002:a1c:cc02:0:b0:3fb:4064:7e22 with SMTP id
 h2-20020a1ccc02000000b003fb40647e22mr3602869wmb.19.1688927604024; 
 Sun, 09 Jul 2023 11:33:24 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 28/45] linux-user: Implement MAP_FIXED_NOREPLACE
Date: Sun,  9 Jul 2023 19:29:07 +0100
Message-Id: <20230709182934.309468-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-12-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 639921dba0..9dc34fc29d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -509,7 +509,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * If the user is asking for the kernel to find a location, do that
      * before we truncate the length for mapping files below.
      */
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
@@ -551,7 +551,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
         void *p;
 
@@ -600,6 +600,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
+        /* Validate that the chosen range is empty. */
+        if ((flags & MAP_FIXED_NOREPLACE)
+            && !page_check_range_empty(start, end - 1)) {
+            errno = EEXIST;
+            goto fail;
+        }
+
         /*
          * worst case: we cannot map the file because the offset is not
          * aligned, so we read it
@@ -615,7 +622,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 goto fail;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
-                                  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
+                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
+                                  | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1) {
                 goto fail;
-- 
2.34.1


