Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9E781156
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31Z-0008AQ-2L; Fri, 18 Aug 2023 13:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31W-00087j-LE
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31U-0007vg-1W
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc73a2b0easo9418285ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378750; x=1692983550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X0ddZs7bYg6jrh/HugPDxFYzx9+2rJ0wZJYAYZEah5o=;
 b=VGk7PeKLqdfF72ht+ndfGJS6D5wz2xV5SX3aiX+ZYJdjq6NcR3J8+P9VlEfaWWqN8z
 jhsvmkugVfWSGnQUMdbFFOx4aIAaIgSRyO+0tSjZkO+zt0TSOfl6VefUkmq/VJZCuo0S
 pEdjM+5tSP2TenVFo87YuOXGN8+96mPNsgFOfuxPQJq106jxBRrM4ty2sdIXuPmlCk4j
 o1EldJvvzcNn/a9OXEixKzVevb0JoLDNJ7Ikcgc07SXr+RwZzrPxPwzyKdciV+LX7O0V
 P8+twHTEqopfaVsSVqh8cP6smG8+cpbWqH0rV9CWxb/YqIyK4COOmEMMHhnTgd4PFeIY
 Im3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378750; x=1692983550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0ddZs7bYg6jrh/HugPDxFYzx9+2rJ0wZJYAYZEah5o=;
 b=bfKR5DMRYEuSdLvrGOlve6vRbQwVPBSgCPHCicTXfp3pvOSN8h82fW2KDhVdPiBl/h
 9/0Y5Iez3jaTTjVR1Ps7oNQPEDIOsUzY37jxwc8klLSGo/VhCL7P+snTRLFocXHpqfJZ
 8kH2FTyIDWjgYVYYr5/5qADJSgExjQsda4r5Xl4O5eLBnF5gu3+PPWcCECKMJy8JLLQ7
 Ezk/RP9/OZ3oiEZStPfz7Cw0uAoCacW01TeFlZU2GeOCsN508ZIWup16R5Bj/GT+F22d
 vlgW8Qg3BHlwvySjxcDrrll/MQ/FdNiy09iacMhdAxCbjfFbxgJSYRPHwaU68HL2HZ4t
 444Q==
X-Gm-Message-State: AOJu0YzIOn7K5bvLQx7UyZAr/RWtiRRb3aYILbmQsJPxpZ4Zw/eKuz7i
 DnChrqdKxO5jdTN1rabaHucsM+JQTLJWg2iQpYM=
X-Google-Smtp-Source: AGHT+IGbPEGxTYtAZV6NVxZbrjd7kdICly5peN+nKHcpwXU2vi69nnFBi+I4cdkjsL9Tx4TCpwW4Mw==
X-Received: by 2002:a17:903:249:b0:1bf:20dd:786b with SMTP id
 j9-20020a170903024900b001bf20dd786bmr3774704plh.31.1692378750364; 
 Fri, 18 Aug 2023 10:12:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/33] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Fri, 18 Aug 2023 10:11:55 -0700
Message-Id: <20230818171227.141728-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use qemu_real_host_page_size instead.  Except for the final mprotect
within page_protect, we already handled host < target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ab48cb41e4..4c1697500a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -650,16 +650,17 @@ void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
+    int host_page_size = qemu_real_host_page_size();
     int prot;
 
     assert_memory_lock();
 
-    if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+    if (host_page_size <= TARGET_PAGE_SIZE) {
         start = address & TARGET_PAGE_MASK;
         last = start + TARGET_PAGE_SIZE - 1;
     } else {
-        start = address & qemu_host_page_mask;
-        last = start + qemu_host_page_size - 1;
+        start = address & -host_page_size;
+        last = start + host_page_size - 1;
     }
 
     p = pageflags_find(start, last);
@@ -670,7 +671,7 @@ void page_protect(tb_page_addr_t address)
 
     if (unlikely(p->itree.last < last)) {
         /* More than one protection region covers the one host page. */
-        assert(TARGET_PAGE_SIZE < qemu_host_page_size);
+        assert(TARGET_PAGE_SIZE < host_page_size);
         while ((p = pageflags_next(p, start, last)) != NULL) {
             prot |= p->flags;
         }
@@ -678,7 +679,7 @@ void page_protect(tb_page_addr_t address)
 
     if (prot & PAGE_WRITE) {
         pageflags_set_clear(start, last, 0, PAGE_WRITE);
-        mprotect(g2h_untagged(start), qemu_host_page_size,
+        mprotect(g2h_untagged(start), last - start + 1,
                  prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NONE);
     }
 }
@@ -724,18 +725,19 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         }
 #endif
     } else {
+        int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
         int prot;
 
-        if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+        if (host_page_size <= TARGET_PAGE_SIZE) {
             start = address & TARGET_PAGE_MASK;
             len = TARGET_PAGE_SIZE;
             prot = p->flags | PAGE_WRITE;
             pageflags_set_clear(start, start + len - 1, PAGE_WRITE, 0);
             current_tb_invalidated = tb_invalidate_phys_page_unwind(start, pc);
         } else {
-            start = address & qemu_host_page_mask;
-            len = qemu_host_page_size;
+            start = address & -host_page_size;
+            len = host_page_size;
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-- 
2.34.1


