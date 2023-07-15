Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B577548F6
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjp-0007Aa-Pf; Sat, 15 Jul 2023 09:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiX-00047p-Qy
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiR-0001JC-Qc
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so25773525e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429222; x=1692021222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QVp7bvOVNX9kOQlZjcnMWNBhc4o39/6I/4Tb+lJViFc=;
 b=XtKFtlKtko5uNMNACbbQ8r4U2tisRfWIEcBb7Hisl4tuzSAwhWmJUppQ+Wo75Ra0OP
 0aLh6cpShYGhnrovksSTlYIfe9jgyrerjJimiIPUzL9tT5LhwWNT0Ts9JKLtNFSzEr26
 lb9wg9q5jVyRJyiU4ve3H5DRlmkGC7IC8zwrorouHPqrlqTzlve6gY9vOXWaDKGDGb3s
 kH4Hy7N8i9tD6ag/FHbInrfnW9YtDwyQEY+up6SKoLpJopqrItwW8q6V4cbnuc65yVDu
 qtN4jfcPbhow2pX+0l/q9lreJnUf3IxLmtLvnaUMXjnFsrEDI3ZO3N6hMCABXVFNU9d9
 iFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429222; x=1692021222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVp7bvOVNX9kOQlZjcnMWNBhc4o39/6I/4Tb+lJViFc=;
 b=QTKZv7axUHLiPxrehzkLOpHKyDF0hN1sjQuL/TaH5JgsPBtchHWOpN4m0zvYAAdZmM
 X889mS1pL8pYcincts2RGf+xzmoY/PzqM8VCcQEmswTuHBUdw5cWlBE8G248OVbx2YUz
 qJD6s8vowGxBkQSXMFNZpm11zJkIy2NrDnS4A2i9wWxhdhWDAaiwrXNFkPTEp6v3AyG7
 5gsEaLf2qTiE4G1sSVCQG2qPgWixTg3OElDtR74C+Bg47F/wHIpQgPl90DSO5mKlGiVB
 1QGlZVvY6rRKv3ZaOn5PpDbemyPcjNkWQCmOIRLqhA1fjgJvV2C6nLlqf2i3Q09SvAqa
 auew==
X-Gm-Message-State: ABy/qLb0303xeDByTMbbLGJgisbCzFaSeD3pVZhY5EmG9OALkkO6oeEH
 JXCjh5kguOzoK/fI30WlrWlYr4Mo/PkeqpTk55mE4Q==
X-Google-Smtp-Source: APBJJlGSCr2CCquuP7eEWPGNXinkfP4tEbeVzXIWvV/6oMRj5XXHXa0DGhc7Ti3fhAJfQziAMVaAhQ==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr6080779wrs.27.1689429221787; 
 Sat, 15 Jul 2023 06:53:41 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/47] linux-user: Implement MAP_FIXED_NOREPLACE
Date: Sat, 15 Jul 2023 14:52:58 +0100
Message-Id: <20230715135317.7219-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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


