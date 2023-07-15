Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F77548F1
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjU-0004yk-Uh; Sat, 15 Jul 2023 09:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfib-00048t-R6
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiX-0001KM-JM
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-316f4abb1e1so479560f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429226; x=1692021226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRxmyw2NI294w3E1OCW/a4A3Z0jUfk7Gsk9X8Q/8iho=;
 b=VC7koQuyjgHQXSPTy9LGtOYxd4WOq0UBnxDbFmrTkJ1ArlrRJmJKREDoqfluyEGd4r
 ScyyC4ah3Js1nFT2XsJFxD38bp9bSl1aMfnN3tdcED6nfWmfgz/x16ADJ6q7YC1T3VeJ
 +mLirTAqWA+Fq8GWt4Qq4MMD/toG7i+MUoyrPqTJQvmI7QTUF4xkyvgIEzGJBYruqyZq
 JnGzePNAkPtha6kRgjfCeaY41uQaq5yi9jLYqepNb9BMlyucj5K33v5xV+8adjt8uOzV
 Ga9ZUIkPCFQSFgacXQF4z45sNFS6E/D/2sY9PEb5Ety7wduhAS8GDsVvTnNqQGHTbSdk
 g0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429226; x=1692021226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRxmyw2NI294w3E1OCW/a4A3Z0jUfk7Gsk9X8Q/8iho=;
 b=MSWKHpTzpUsaUZI/Ftq7cQutz7+/uoSEgknbXGv3l8zml7YdBUuGWcPKXMv7Q7702r
 0Xj1/eWVfVQuPbyIdr6wxdSws4slpruIjK2OrCi2x86r4QPBq+rYQxEXQxFSVrOThDwQ
 ImxvUCsU+WTG+wjK4rT1tgGL37C43MBvLTG0X5YB0JeSbgNUMsiECDZlXKjtsNJ4XYP0
 Ap5nNumEuR4C66v3q69RLwZaYE4xqbPqzIEoAKD8We48y6XHTN1YTB6uZlJEMnf10gVb
 n3RW2Ae8RCOQxaa0BtzF/T0XCTL6eiCd8dRJMj75S04TJB8Uzi2J35OMy+TXY9ZMkKTe
 UtzA==
X-Gm-Message-State: ABy/qLa7/i7QZa/E6YZMKI7BIVwGedmiv3kesSj7oi0llppreZt4IYAQ
 yHrQQkO+2Oa1kLJw7Znhx/+Cl/PD8bux4r6xbjKhcA==
X-Google-Smtp-Source: APBJJlEa6lpCIO9vXY66exIpPkjThliDqiC7C8AOOVxEIEjKORbQO5yR6oVg337ZP5ozFP1LN2lEPA==
X-Received: by 2002:a5d:4564:0:b0:306:46c4:d313 with SMTP id
 a4-20020a5d4564000000b0030646c4d313mr6321855wrc.28.1689429226122; 
 Sat, 15 Jul 2023 06:53:46 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PULL 34/47] bsd-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Sat, 15 Jul 2023 14:53:04 +0100
Message-Id: <20230715135317.7219-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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


