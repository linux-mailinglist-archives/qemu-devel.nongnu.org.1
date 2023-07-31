Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33876A25B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa25-0000t8-Lt; Mon, 31 Jul 2023 17:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa21-0000ql-LT
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1z-0006P6-Li
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb81809ca8so39340605ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837338; x=1691442138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i9wtzUb42CilMWSLYTGlUi5KdxK2jdYVPNnbOFMGOWc=;
 b=XEDB3HPo7xsOAgetbkrHgeVGIHD+tWXWpHbTLfPNKtfEbvO5VS3c8d0q3mHYlpUh/v
 YN89FaJGfHDmSPXIeGR/Cg/Eca5VUbHDnwKS9o2f5cS8C+WHHzCv2UbA+0AWIDD4WB6o
 fidVOQRUrAQJpwd0YI11nP4fQT02B77qH4Bfy1i1KIV91MFFkaucMm8EIsTzI7LVuP5s
 RVXuswHeWI7UkO3IIRBHKGYrm1hKA9pEeYdysVkXO2PWCqDWPxdWjIRW+ydEyDt7vhUV
 ZOGg2pNpef0hEuDreTBdxrRlBoxxM1CD2w3vRXfAv8k9vQsPdnBR70NfP2DlK39b5O13
 DrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837338; x=1691442138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9wtzUb42CilMWSLYTGlUi5KdxK2jdYVPNnbOFMGOWc=;
 b=hhiQPEELA7VS+xZyqAuNiezsx/zYnHh1QvtEb95h8SNij1TVOkOBlpJKIDp+99j79d
 qEBmIDVXo6hfq1JW4uBFgbZFO6XwttkeOHtoTqAWQtAoc9r5cJmQvG4V5F83rvIGCJmq
 yoCac4f0vtG9BhEq12io0XWmCQn1/iF1P1cqyCgUN+hgw3+VOHN+xmfbQJzf6vHzzg1D
 dEK3zKkwzO8fnj08y/kFsZRWIgdgQh3eqWtw7a1AaRZVhGOfRhY+Vv8VWTCcVom5u1iV
 dVTqX21GZCSo8VvEt57YnF1VwBNmWRSJx2+64dQ/ZYuu5WxYf0DJlLJEQqg9cllXjhUI
 ORng==
X-Gm-Message-State: ABy/qLZ3lmAoKsH++3S+W7JUr9ZjPvdZ9w8vNR2ptYUENALulceZRzn8
 2az/fkTm1w1jQfDQizK5Y/2CFXhTOBpbEYxOu+c=
X-Google-Smtp-Source: APBJJlFiKi1ARSQKr6+MJSi8at9EoHTt0aCVYYDS4POZdYEzEWXm+KYEHdX58/QlDx2kyJxWjb57lw==
X-Received: by 2002:a17:902:c947:b0:1bb:ab0d:4f76 with SMTP id
 i7-20020a170902c94700b001bbab0d4f76mr14105475pla.58.1690837338186; 
 Mon, 31 Jul 2023 14:02:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] bsd-user: Allocate guest virtual address space
Date: Mon, 31 Jul 2023 14:02:07 -0700
Message-Id: <20230731210211.137353-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

With reserved_va, mmap.c expects to have pre-allocated host address
space for the entire guest address space.  When combined with the -B
command-line option, ensure that the chosen address does not overlap
anything else.  Ensure that mmap_next_start is within reserved_va,
as we use it within mmap.c without checking.

Reviewed by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230727161148.444988-1-richard.henderson@linaro.org>
---
 bsd-user/main.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index b597328118..381bb18df8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -473,10 +473,6 @@ int main(int argc, char **argv)
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
-    if (reserved_va) {
-        mmap_next_start = reserved_va + 1;
-    }
-
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
@@ -494,7 +490,49 @@ int main(int argc, char **argv)
      * Now that page sizes are configured we can do
      * proper page alignment for guest_base.
      */
-    guest_base = HOST_PAGE_ALIGN(guest_base);
+    if (have_guest_base) {
+        if (guest_base & ~qemu_host_page_mask) {
+            error_report("Selected guest base not host page aligned");
+            exit(1);
+        }
+    }
+
+    /*
+     * If reserving host virtual address space, do so now.
+     * Combined with '-B', ensure that the chosen range is free.
+     */
+    if (reserved_va) {
+        void *p;
+
+        if (have_guest_base) {
+            p = mmap((void *)guest_base, reserved_va + 1, PROT_NONE,
+                     MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1, 0);
+        } else {
+            p = mmap(NULL, reserved_va + 1, PROT_NONE,
+                     MAP_ANON | MAP_PRIVATE, -1, 0);
+        }
+        if (p == MAP_FAILED) {
+            const char *err = strerror(errno);
+            char *sz = size_to_str(reserved_va + 1);
+
+            if (have_guest_base) {
+                error_report("Cannot allocate %s bytes at -B %p for guest "
+                             "address space: %s", sz, (void *)guest_base, err);
+            } else {
+                error_report("Cannot allocate %s bytes for guest "
+                             "address space: %s", sz, err);
+            }
+            exit(1);
+        }
+        guest_base = (uintptr_t)p;
+        have_guest_base = true;
+
+        /* Ensure that mmap_next_start is within range. */
+        if (reserved_va <= mmap_next_start) {
+            mmap_next_start = (reserved_va / 4 * 3)
+                              & TARGET_PAGE_MASK & qemu_host_page_mask;
+        }
+    }
 
     if (loader_exec(filename, argv + optind, target_environ, regs, info,
                     &bprm) != 0) {
-- 
2.34.1


