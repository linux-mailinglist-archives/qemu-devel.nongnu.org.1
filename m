Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FA744777
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVx-0007YD-Q6; Sat, 01 Jul 2023 02:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVv-0007Wa-Dm
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVt-0007GD-Hb
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so24377305e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194520; x=1690786520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+qtKArYQsrn/b+NQpVzVpVv88M5134YWuGW3InQxAY=;
 b=cAZnbS3BQNJwY0a1ELCkEpvhj8/hYssPgwQk1GF1cuHbY1XVNqKzy0H6kO7ZyaGDRs
 tY8le5Ov4apcusKs9G4349GneSyuJ4h7spledhwUMujROPtQI/HQXTN3n0Zk+8THyRlD
 5JiPbPK3+btqICAnxTKCt5kUpLUvooJ64G2sPvluAF+gIeWhIhDBZDo5HGunGXbxEylV
 P0Z8Ti9x6lfbW8eticMphotCT7CP9wHMkfLDfPgpD9MRod7yuQzFg5G8H1Q4012fZk3P
 du6o0oSPD4+NOo//PvN8z0PiGVQTYjXMVHmS9kp90ZH8ckGO63iT2kGRjqZqwZGh8pUL
 i1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194520; x=1690786520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+qtKArYQsrn/b+NQpVzVpVv88M5134YWuGW3InQxAY=;
 b=Diq47pCWTDzuK7NNpQIPbUn9ML+AozOB83H5z/yA7QrvzaLGTLZJVUrvIUcrPsVBT2
 XsbhwTeLTR206qLlB7iV3OXXObz5+wRL28Wjay53U4CeSsioVj9vOuQu49gcWiax3ANB
 jsu2Wxbx+35QA5cTx5QxMHWTajZlPq6DkpTlSQI/mXpNgTAwaUrQsDxwRL/WbyV7u4Uy
 SiFYjDDPaPP0n5OIwmcjvibv/09zrdD/aeV3AlzXsl/qZLUm3qJ1fIJSXaueL7AUaL8I
 nZpRL6kGL8xjXg4QZdoPVCNp++4UWA1nqD4Q4aZOiLWww3M0453XYfBbN4laAiOxxfcO
 pwJQ==
X-Gm-Message-State: AC+VfDwZgz5h8mpL+LJPGPk5Qn1BaoWKWMrUVcNguaJAa4UE1PZ1J+aW
 gbN2Ova6oetr7+42IJ3ecDeMVSxDTXxN4voG7EI1tg==
X-Google-Smtp-Source: ACHHUZ6tLHYBTi0aeTx4soXS//fxIqkikatLPTS9jaYnAN+YS14GXa+UGVZaFMIUHNXAJyDDYGf6ZQ==
X-Received: by 2002:a1c:7908:0:b0:3f8:fb7c:6793 with SMTP id
 l8-20020a1c7908000000b003f8fb7c6793mr3248980wme.24.1688194520279; 
 Fri, 30 Jun 2023 23:55:20 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 11/11] linux-user: Avoid mmap of the last byte of the
 reserved_va
Date: Sat,  1 Jul 2023 08:55:10 +0200
Message-Id: <20230701065510.514743-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
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

There is an overflow problem in mmap_find_vma_reserved:
when reserved_va == UINT32_MAX, end may overflow to 0.
Rather than a larger rewrite at this time, simply avoid
the final byte of the VA, which avoids searching the
final page, which avoids the overflow.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1741
Fixes: 95059f9c ("include/exec: Change reserved_va semantics to last byte")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230629080835.71371-1-richard.henderson@linaro.org>
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


