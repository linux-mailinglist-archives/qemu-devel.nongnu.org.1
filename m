Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB91774C86
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx3-0007jw-Uh; Tue, 08 Aug 2023 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx2-0007jN-8C
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:12 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx0-0005xU-9m
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2681223aaacso212544a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528949; x=1692133749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TQ+ng9YK2iHiUzqlLMSJnh2uowz6Q550xji3/gr0BY=;
 b=eEWbJJCdoaCUkmRIhkYdrZjrWCm1uUf6acv38Rml9ApkhCqDcPWr2Sh0fDqO3HtC5F
 KLHz28TiSXtlcSY+/3ZZjZ/8gRx/DoFEaCnJh3tik4UXSAlSpYH9DNilITb9dCkn62wq
 COUAyIKGIWLWBuoSLN5QzIf21lkM63mht5v6Me6LSp9xd83gOxf3cXmLd4yktlOBSjIx
 UdvJo0FX35q1YdX0XzBr9ssbVyPgAsYbYFlRSGS4kriJHGxvcw0uq76S1Hb39KiteNBa
 PgaxZJgfKtguGylHId7CkgRwQwPfYt91AbtMxuePAhIgVK/3usVH1lUrPcHTIa25WXb6
 cqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528949; x=1692133749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TQ+ng9YK2iHiUzqlLMSJnh2uowz6Q550xji3/gr0BY=;
 b=aBLu18lhNvCDqO79C9nzbFQYP9XnB5rns76Dgifh65Q1t7X0lh44nEQg+jlaxNWcEV
 QlR6KQox5EnoDyELUJwaYuPd0WUaaV+OQK3i1kRPpTLBcGSxgGoLNbCOf5FJ0sN+fR1c
 /W+SmSC0UU3b3rqRfkCZSFtt7Z0BWvjs+LZ87QzL47WmbLlNTQhf4D5NL314p6gmkvBJ
 4HPwIHEsGtlt6vE+N0tPlcKyKjrMrnIWGCK3kkTJyIZvgJWOXg4uaYWA99pRE1WAsAf/
 eH2zRc/lPzGyjHxk/tqFDvPULkIHmH+apWJv/61umhWxuUqTTSlqrZ2dnlMtqQt42fi7
 3HfA==
X-Gm-Message-State: AOJu0Yzu40I5eAR/A0uNpIfmLv2u/nChCU06xo5v5OfWZdu9lh+WG7bT
 TzTm1kEd7zr9Xw6QdNZpxTEk/ohzsvUprC34OKA=
X-Google-Smtp-Source: AGHT+IE/hIGZ0YgPKWT25P9PF7w4OEUOYvP5GI0uePy49XHXDOJrjLT0JG8pRRGn5a1RcqJ9n/nYUQ==
X-Received: by 2002:a17:90b:1990:b0:268:8ff2:5c0d with SMTP id
 mv16-20020a17090b199000b002688ff25c0dmr1110601pjb.17.1691528948854; 
 Tue, 08 Aug 2023 14:09:08 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/14] linux-user: Consolidate guest bounds check in
 probe_guest_base
Date: Tue,  8 Aug 2023 14:08:54 -0700
Message-Id: <20230808210856.95568-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 50 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c14139a5fc..06d81f83b1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2525,25 +2525,6 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
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
@@ -2694,13 +2675,6 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
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
@@ -2766,13 +2740,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
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
 
@@ -2799,6 +2766,23 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
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


