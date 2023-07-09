Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2174C720
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEE-00052V-34; Sun, 09 Jul 2023 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE0-0003cP-7Y
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDy-0004HP-NF
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so19655015e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927613; x=1691519613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRxmyw2NI294w3E1OCW/a4A3Z0jUfk7Gsk9X8Q/8iho=;
 b=Owl5H1sHBMbZEz/AJsmVnI8Pxc5Sm9o908wqmw5nqZScNiDYcJxe9LnazFZqnye1HZ
 Ri1jRZqald3TGzUARdgTKa2JFhFQ99phScy/YkT9aEzWro11pth83nhsGgy5fyQGVOAt
 Azq1X5Yo/ZBCGYiTr5BB/mzcozPxz263OS1lS/0BBmA3SfoygfyDWtjFVZKRgwzQNOlF
 hR0SIaCbLlH58CiCQhxI//QuIiOYSNsz49bHmV3dRqE46rs4SaaAgywJd8UV83V8sfy4
 aon6FBX8G6Y20RCWC2JDUIDiHbTZzv9gICKjzO0cF+MJ371hOJPazmFnfU0D2bwg5rnZ
 0JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927613; x=1691519613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRxmyw2NI294w3E1OCW/a4A3Z0jUfk7Gsk9X8Q/8iho=;
 b=Ga7kKIPWMmLksG7lx86Ufj6KuzWrLTQUu6FzZEqCnC6GXNhJ9bYso96RysKxlZKYvn
 Khr0PeKcdDs0mAaAKTrL2Hcft+zVsoE82iai8qyb8j5BnZGGAuv6z7c6IYrBJ8aGvbtz
 pXFg3jATXEu2kNSP9G2Qw5uC7CaunyWWR9cdgSvfL/v3OH0AnzXcfkSzQ+uEKxS+/yDN
 o6msye9dcjhk6Y5grYPJ9YaxuTFgWiC4hn1Kk0XGy1yx/fLiZbXcpGyHfADjplI07UcE
 7KSc17e91lPGl0Leq7dnNmXETas0z0zp8vGI1Y44D4kZ7de6m4uq505EkOLw2M/pbnIb
 K+CA==
X-Gm-Message-State: ABy/qLbZq3KuBu5CpHky1AwKoaT3+A0ERmP+74LrvAEwrWlnM3q8yJc9
 ifEOsdLMEwKbFS3V2uyMlvU/otu4vlzY/OhMNAHZ+w==
X-Google-Smtp-Source: APBJJlHl5iMaGkAe2NImhnaCjOYXzcVWZct54sc7siFRofZ3y1wcZHUdfwWmCd/NjJzYfxA2RZRqFA==
X-Received: by 2002:adf:e4cb:0:b0:313:e88d:e6d3 with SMTP id
 v11-20020adfe4cb000000b00313e88de6d3mr13286461wrm.14.1688927613516; 
 Sun, 09 Jul 2023 11:33:33 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 34/45] bsd-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Sun,  9 Jul 2023 19:29:19 +0100
Message-Id: <20230709182934.309468-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Use the interval tree to find empty space, rather than
probing each page in turn.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-bt: Warner Losh <imp@bsdimp.com>
Message-Id: <20230707204054.8792-18-richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 48 +++++++-----------------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 07b5b8055e..aca8764356 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -222,50 +222,16 @@ unsigned long last_brk;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong addr;
-    abi_ulong end_addr;
-    int prot;
-    int looped = 0;
+    abi_ulong ret;
 
-    if (size > reserved_va) {
-        return (abi_ulong)-1;
+    ret = page_find_range_empty(start, reserved_va, size, alignment);
+    if (ret == -1 && start > TARGET_PAGE_SIZE) {
+        /* Restart at the beginning of the address space. */
+        ret = page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
+                                    size, alignment);
     }
 
-    size = HOST_PAGE_ALIGN(size) + alignment;
-    end_addr = start + size;
-    if (end_addr > reserved_va) {
-        end_addr = reserved_va + 1;
-    }
-    addr = end_addr - qemu_host_page_size;
-
-    while (1) {
-        if (addr > end_addr) {
-            if (looped) {
-                return (abi_ulong)-1;
-            }
-            end_addr = reserved_va + 1;
-            addr = end_addr - qemu_host_page_size;
-            looped = 1;
-            continue;
-        }
-        prot = page_get_flags(addr);
-        if (prot) {
-            end_addr = addr;
-        }
-        if (end_addr - addr >= size) {
-            break;
-        }
-        addr -= qemu_host_page_size;
-    }
-
-    if (start == mmap_next_start) {
-        mmap_next_start = addr;
-    }
-    /* addr is sufficiently low to align it up */
-    if (alignment != 0) {
-        addr = (addr + alignment) & ~(alignment - 1);
-    }
-    return addr;
+    return ret;
 }
 
 /*
-- 
2.34.1


