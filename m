Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB174B83F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGN-0004og-9p; Fri, 07 Jul 2023 16:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGK-0004nS-Mm
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGH-0004gx-2Z
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso24685945e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762463; x=1691354463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGV05zqZ+kYKrbzC2hjbmm/a6tBHPtbV1LUiCeA7Icg=;
 b=iNM8wBWftYTJNXz5D2VDQQjww9AvpUGEuDnbMzYBq4psrzbtXKaSl3rgByvXJap/en
 U5bnBRSht7q915qBoLI9byGyWp3rgURcD4zQcI23K1GmwxCNhOes4g+ConeyDNUfWTdB
 qKOigVkUw9l7Sbe6a1rUzeSxETFaYmSQXulDZID2uiW+Tx6f09ulLxZJTM5Y48YrFksr
 IGj9aOk6gQzyjXR/XSdxY8yURzucwjBeYgrVUnangyqhzqZ55gUTFG5Qe2HE4GiLM5UX
 j3B1NCvHGB5VIJ7exp1gYDJWyW8q/Us8mFSJhrO1SDo6NDwHHj625iHb3OYGtaUZUFdn
 nzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762463; x=1691354463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGV05zqZ+kYKrbzC2hjbmm/a6tBHPtbV1LUiCeA7Icg=;
 b=IQAV3zFSTyYJ10p1r8ycegnbwgzBXPOfsapznmlA9M7DeMsHykNt6iWRgdg7JcpaYx
 fWSmXyv4SUiHjPQW9XxXlXTRvU2FHhsseZSZ/S3cnZapklpk0t0noo18X+5PBNpQti4s
 Mlf03d8/hNrbkv8DPJNln+XY+3Keaa8pqoaRhL0ozcwV2h8W1ktVQJo5qXoO3VV/xH7F
 0vSq8rBX4xPlINYp8gu1IxPOTB57FjtvcK/yyOKyK27f7BWYmOIokFxkys+SDnj1fNnt
 3g6Mp7YLUV+0fQ0H23TSAkOTHwbTfqN6KlazwxtaigezBKC2sRv6lqQ0VhohFXwgXjEF
 svvg==
X-Gm-Message-State: ABy/qLbyAYDt+Byi0ykn5jewwdVUaNzL0TlYKaBP8OgiiULk/qHlni38
 Jdll+9auHKtXoVb9H1GdB6OzplWXUyaHh13tfk3GUg==
X-Google-Smtp-Source: APBJJlGUedQrSy6FU1aAmSFDpHtvZ/e/h3aIiG2HNnyL733I9so7inwVU9pp2adv0fROUcFSmWFSEg==
X-Received: by 2002:a7b:c392:0:b0:3fb:d1db:5454 with SMTP id
 s18-20020a7bc392000000b003fbd1db5454mr5373575wmj.35.1688762463732; 
 Fri, 07 Jul 2023 13:41:03 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 09/24] linux-user: Implement MAP_FIXED_NOREPLACE
Date: Fri,  7 Jul 2023 21:40:39 +0100
Message-Id: <20230707204054.8792-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 linux-user/mmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 12275593a1..b2e130e700 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -508,7 +508,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * If the user is asking for the kernel to find a location, do that
      * before we truncate the length for mapping files below.
      */
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
@@ -550,7 +550,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    if (!(flags & MAP_FIXED)) {
+    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         unsigned long host_start;
         void *p;
 
@@ -599,6 +599,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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
@@ -614,7 +621,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
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


