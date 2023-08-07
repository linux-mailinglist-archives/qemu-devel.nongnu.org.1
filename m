Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DF772B26
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3Ea-0007Yv-Ks; Mon, 07 Aug 2023 12:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EO-00076J-GD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EM-0002iJ-NP
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso40640755ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426237; x=1692031037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37Oa1Q6Q3bF0gL9Um9Xifn0V/D4ohTtQq5asniTUIIY=;
 b=GCKh8Cay5DJtgXhZ5sxRPiapN3ly1+VFPoH4828ht5vYjyDxgaj7/svl6v958AtbtL
 xA4aHW7bQyqg6E76O6+n1d+qc9bYRZNcuplLnEFlxklqCpKYrMrbD49PjzvzCStSCU4f
 c7Tqpkphb3jvlKxUTveOxzpGw4LtAZ1bV/9Qa3bAA2sWAgrdNa71lgLpU/jfTHiESNMr
 +XqVUMbfcPKRqkDNCF3jkEyx9gTySEx91Xb5+jCpk+Gt42EqsnsWEJPos8dMX+OgDrve
 1X3x0sMyqKpkYcOcwbCYJaX1wPl3k1RB2qsK9OJb9eJ+FbsZEK+8gA1fnEYKAgTC1Voa
 JwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426237; x=1692031037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37Oa1Q6Q3bF0gL9Um9Xifn0V/D4ohTtQq5asniTUIIY=;
 b=DVq+3sHACpgPpfCs2Dj8pwTUenAvM6M/gKM/3fpHJnwuyF/a1bmQ9ECyp3q0LMhUVv
 YwsE5JtKKCRns2sjdt6syyBaGKbUtE1dzWdhN06n6EQDikS8S/P1r71Xm5STk91LMW1n
 CPEKFqF6P/GrpFkWwPY+pnYJL4EiVAdkt+HngIFGVh418doww9j2QUcJVEwHaBmo+5Ro
 zvsvo7F2Tz+G89Nen9v2IYTm+SAIfvHheohFvA+Xmxg9hdlm9y4Flfe4emnZv4zVWWcc
 Vj8J8YCtlz6gqNH3rF+JigR09mWW38E3a6rDlmCjApZko1icDNqSrtVsvWf3+E31/y/p
 2jfQ==
X-Gm-Message-State: AOJu0Yw0RU0gqNyHFvqGXy8uLzf3OA+jP9zCj22iyeNQbZeEN7SezLq8
 nK7WEU2/KMRGWBRUxw3Q0/26HLL5J6zgGci2Lcc=
X-Google-Smtp-Source: AGHT+IGkHKdo+Is/br6rKfETposGU4axBth0BVSSrPBJ0FYACOPR5n1CIriTNQ3UHGwAABiEKyAckg==
X-Received: by 2002:a17:902:d3c5:b0:1aa:d971:4623 with SMTP id
 w5-20020a170902d3c500b001aad9714623mr9888148plb.38.1691426237352; 
 Mon, 07 Aug 2023 09:37:17 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 12/14] linux-user: Consolidate guest bounds check
 in probe_guest_base
Date: Mon,  7 Aug 2023 09:37:03 -0700
Message-Id: <20230807163705.9848-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The three sets of checks are identical, logically.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 50 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 400af4a4c0..484ab7131a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2527,25 +2527,6 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
         exit(EXIT_FAILURE);
     }
 
-    /* Sanity check the guest binary. */
-    if (reserved_va) {
-        if (guest_hiaddr > reserved_va) {
-            error_report("%s: requires more than reserved virtual "
-                         "address space (0x%" PRIx64 " > 0x%lx)",
-                         image_name, (uint64_t)guest_hiaddr, reserved_va);
-            exit(EXIT_FAILURE);
-        }
-    } else {
-#if HOST_LONG_BITS < TARGET_ABI_BITS
-        if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
-            error_report("%s: requires more virtual address space "
-                         "than the host can provide (0x%" PRIx64 ")",
-                         image_name, (uint64_t)guest_hiaddr + 1 - guest_base);
-            exit(EXIT_FAILURE);
-        }
-#endif
-    }
-
     /*
      * Expand the allocation to the entire reserved_va.
      * Exclude the mmap_min_addr hole.
@@ -2696,13 +2677,6 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
     uintptr_t offset = 0;
     uintptr_t addr;
 
-    if (hiaddr != orig_hiaddr) {
-        error_report("%s: requires virtual address space that the "
-                     "host cannot provide (0x%" PRIx64 ")",
-                     image_name, (uint64_t)orig_hiaddr + 1);
-        exit(EXIT_FAILURE);
-    }
-
     loaddr &= -align;
     if (HI_COMMPAGE) {
         /*
@@ -2768,13 +2742,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
     void *addr, *test;
 
-    if (guest_hiaddr > reserved_va) {
-        error_report("%s: requires more than reserved virtual "
-                     "address space (0x%" PRIx64 " > 0x%lx)",
-                     image_name, (uint64_t)guest_hiaddr, reserved_va);
-        exit(EXIT_FAILURE);
-    }
-
     /* Widen the "image" to the entire reserved address space. */
     pgb_static(image_name, 0, reserved_va, align);
 
@@ -2801,6 +2768,23 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
     uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
 
+    /* Sanity check the guest binary. */
+    if (reserved_va) {
+        if (guest_hiaddr > reserved_va) {
+            error_report("%s: requires more than reserved virtual "
+                         "address space (0x%" PRIx64 " > 0x%lx)",
+                         image_name, (uint64_t)guest_hiaddr, reserved_va);
+            exit(EXIT_FAILURE);
+        }
+    } else {
+        if (guest_hiaddr != (uintptr_t)guest_hiaddr) {
+            error_report("%s: requires more virtual address space "
+                         "than the host can provide (0x%" PRIx64 ")",
+                         image_name, (uint64_t)guest_hiaddr + 1);
+            exit(EXIT_FAILURE);
+        }
+    }
+
     if (have_guest_base) {
         pgb_have_guest_base(image_name, guest_loaddr, guest_hiaddr, align);
     } else if (reserved_va) {
-- 
2.34.1


