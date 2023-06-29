Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290277421CE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmhm-0004af-2E; Thu, 29 Jun 2023 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmhk-0004aA-65
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:08:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmhi-0005yI-C4
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:08:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc060a4d4so964595e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688026116; x=1690618116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9eMAB43Rqt4O7Kkto7G7nYb0ls8Z9zu/GUhcxBLdkTs=;
 b=Bm6SjvWzv4K7j+CYyFpBxSWfvx51jHCc75c4YCJSvwJvWrpMBAYYMdddbSu3U7l2Rb
 FsmyxmSmmWITfWULMZG3Wm3Z45nsmPudtcG3yXq/vErqu96pdB/WeABcXHXHPSpnQeHV
 VZ9pG0aw74sD7hsfpVyQXT/eu3uSesM2pvQwiqT4k9fCShOFKZ6729OBROjoi/FumRBD
 Hh9zxx0INbPC9LNwDY6o7ZHb01P/ujFfhnp+HdBndlm1oH6ILr+Zt0J9q+SSz/GCRvUR
 DRg3UwFdKW90uSN46ZNhNCPrIDPxJ3pMEh/WI5FDxOCHtfEBjlAOT+3x2OLcPgCDC5hH
 s87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688026116; x=1690618116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eMAB43Rqt4O7Kkto7G7nYb0ls8Z9zu/GUhcxBLdkTs=;
 b=O4i3BeLC7DZsqI6PIshXmaPE4iZrQiPASGyxUDr/gSemk76CRqM6sUrmXvpN8WTuDA
 IhL/y5JZ1G2lvcZv3uaDOCozjDZsy/Ql6WayPJVkbpVyTLfhBuOsavNb3FC0Q8Rsm21Q
 c7u/ToItEAaKHCXqRFdMer6QmShExMvkW2WSBRoS8xShKY4iLodHQssnQ6C/2IhYcAPB
 Tjo5LeBcxqZNF4YDFEjEOog38T/3rqJs0KuE48osZBvOcF1vEpJvkKTvFbvJeZITz3mB
 umDGFAZqFcNMJYS9WNXOPTcn+olDSthrUk8XdyBjSwId8ctHnLtYVfihsjIbdXCFihoo
 jK0g==
X-Gm-Message-State: AC+VfDwd9uUKWGvf+Xdw+I9jk0Rw/TPWiikpSl8IaqYKUGFSq2/4c1bW
 c+sFxGP7Oh6o6P6qlTY6/xS2YozINaTSzNiDXLTFC+q4
X-Google-Smtp-Source: ACHHUZ4gZuZ9GY+TgVy9V+AknTuGx/febbT/XSs/64qNFK1coAgUpj1ZI2GZ5T9t8/nTq8znlPZ9UA==
X-Received: by 2002:a05:600c:22ca:b0:3fb:a917:b769 with SMTP id
 10-20020a05600c22ca00b003fba917b769mr4945398wmg.21.1688026116363; 
 Thu, 29 Jun 2023 01:08:36 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adff312000000b0030fb4b55c13sm68976wro.96.2023.06.29.01.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 01:08:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	qemu-stable@nongnu.org
Subject: [PATCH] linux-user: Avoid mmap of the last byte of the reserved_va
Date: Thu, 29 Jun 2023 10:08:35 +0200
Message-Id: <20230629080835.71371-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

There is an overflow problem in mmap_find_vma_reserved:
when reserved_va == UINT32_MAX, end may overflow to 0.
Rather than a larger rewrite at this time, simply avoid
the final byte of the VA, which avoids searching the
final page, which avoids the overflow.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1741
Fixes: 95059f9c ("include/exec: Change reserved_va semantics to last byte")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0aa8ae7356..2692936773 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -281,9 +281,15 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
     /* Note that start and size have already been aligned by mmap_find_vma. */
 
     end_addr = start + size;
+    /*
+     * Start at the top of the address space, ignoring the last page.
+     * If reserved_va == UINT32_MAX, then end_addr wraps to 0,
+     * throwing the rest of the calculations off.
+     * TODO: rewrite using last_addr instead.
+     * TODO: use the interval tree instead of probing every page.
+     */
     if (start > reserved_va - size) {
-        /* Start at the top of the address space.  */
-        end_addr = ((reserved_va + 1 - size) & -align) + size;
+        end_addr = ((reserved_va - size) & -align) + size;
         looped = true;
     }
 
@@ -296,8 +302,8 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                 /* Failure.  The entire address space has been searched.  */
                 return (abi_ulong)-1;
             }
-            /* Re-start at the top of the address space.  */
-            addr = end_addr = ((reserved_va + 1 - size) & -align) + size;
+            /* Re-start at the top of the address space (see above). */
+            addr = end_addr = ((reserved_va - size) & -align) + size;
             looped = true;
         } else {
             prot = page_get_flags(addr);
-- 
2.34.1


