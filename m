Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E574B83E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGc-0004zS-1T; Fri, 07 Jul 2023 16:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGM-0004oG-DQ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGK-0004m8-Ro
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so24480915e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762467; x=1691354467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKe+fUX0NmdphUHrFTyrG/qLSqkF3tQdOsXgmGYWYgc=;
 b=hqkcjVrjecW9ZGOCxywyxtkSkvDxsHfzboWDqkQozjmmZlpNf4L6Lci466McRPMknX
 UZwT4OFF5rE4nlPv5DabmD0C3J6HdZ25OPT7fDFsu4p2tV/eeYOjd+YBXN4jFmwoPKeZ
 zxboOLhK3s5VLVj1dBrTtY4u2hbA4YPtn7q3Xuv79kyc+b8PywoalbHupzCSS0dE1/T4
 eP6v70sfJ2JrPQSBd8uAfCdO/hB+bEAnLNz2+OCM3opQNTdHIoYz1NuoDMtvIJ4lpFp4
 Lg/aJiYXq+x3Oek1TDjwvYUyBjgzoTgdUeuC6bFzGpua2YXpB+fNMKvst1XAvDPuvNGI
 jL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762467; x=1691354467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKe+fUX0NmdphUHrFTyrG/qLSqkF3tQdOsXgmGYWYgc=;
 b=jirhNnmA1HZdmoxV5EihpO7I+Ldpq8wty3xajhv+QkLfbVyny/Bj49KHKdGvrqc1zx
 mtk0qRv4nkw3ircz8BU1jA5T/gAY9l2OW6Av9FdRB19E267buYiL1KKZYxSfMg0x7QvH
 PgtjR0BSow0XYQGmG5dA5jTNe/efoq0x4xVOBm8vC2jUTCcSrneLvQjrt0hUQiZ7sc2i
 BD8O1rCzrfPtl4nA4UYH/7wAr1+eua1xG8/uOTzHTlv5XDCKZ/jx4ob3u9/WsxMr0rQk
 MQ1/PlbmaLpr3sMdh6hRHBboMJh/ASqZO3IVSCWYEYhs9KwXQPv5gd1NPZ8744eQv06Q
 Z3Sg==
X-Gm-Message-State: ABy/qLYOP626dwRKRTPh+ec8IaKJPaeVw9SULIfkE2CHEfwoFJVPgpgs
 UrZxiSWVfW+YFZEGAgw+kp6jnf3yiFWItFpFd/3C+w==
X-Google-Smtp-Source: APBJJlGlPCvH3LRM76glRH3cgdTwkgI+B/kZI6oGFdLSs8IoGumHtdAGysma7AkmYD/tagmllAyOHw==
X-Received: by 2002:a7b:cd8c:0:b0:3fa:991c:2af9 with SMTP id
 y12-20020a7bcd8c000000b003fa991c2af9mr4826847wmj.16.1688762467409; 
 Fri, 07 Jul 2023 13:41:07 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v2 15/24] bsd-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Fri,  7 Jul 2023 21:40:45 +0100
Message-Id: <20230707204054.8792-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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


