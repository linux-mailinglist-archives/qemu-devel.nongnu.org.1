Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2D74C735
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEF-0005Cf-3d; Sun, 09 Jul 2023 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE2-0003on-UR
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE1-0004IG-AW
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3834985f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927616; x=1691519616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+vFU351RDeVAwRNg/WDopVOnzTmK+ZtjZmF1Bh7abU=;
 b=eb82pVZK0qXY2jf957nkIICog1cf/S3GbH4wZXYGvKqx+3bwq3ywxeMG0GIruaw+sD
 LeHv3Ybddcgx/EFHb/6e7f1C8a0IvqCtWUl5ezTGJnX7Q2YyIlbNzqDwqZz1n3HRQBFU
 4RbSSVKX3A+80lEeGxzZYIc9JGu96lSWt3MkZ83MZLm76ItERgz6MakhPD59fXWI0uv2
 UiOAi4YgwsmekL9+IocbKi3itOAJOIDnjJkRpoPpIQGd7pDCjx49Tk7vnDHQY0Ifcyel
 fDsxpjLGRaJxoTpssVy7V/PR3Ys3PekYtytbTml0RPDPvd0ysfPaitGA8ZGm6huRG0XE
 KLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927616; x=1691519616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+vFU351RDeVAwRNg/WDopVOnzTmK+ZtjZmF1Bh7abU=;
 b=Jjpicz6+1YoxABuOOFhRPROz1FzvKMvNbK2xamAvqORjbmarL6jObevFikk/qvjQfv
 zEv6689ux4g9L4PbfQRs8mTeSDMkkUD9MfkMLdQ3fPAEITPRFvLh2k5xtQBca8zBpDb8
 4bocrvLxj0h3j6Q78f3Hcm88lyA/EhxjwEvxMGm28w6cNTBT1JDHcec5pjlINxaKQ+IC
 vhOCgDQ6yo/NmNCt4xL+3grZ1ehkhenXarymCAQP1g159wJqzt8zFMN82Vq6SgVn6kBv
 WwYl7fYuGaPzYlB//BBQAoLgOahtK0fwgAQ3NDjPjEA6bllqLBaW/XkbzRvocC/i6M1l
 NT3Q==
X-Gm-Message-State: ABy/qLaf3A0dKV1GZSuZKeXKD+yroYHfYPVLo9TVus3g0zSpdqWvHaC4
 0O/zYSGMKMSnzPmZo6NdAYXbSMyfK169kosSIOkxAg==
X-Google-Smtp-Source: APBJJlEuLkh2ziXjccOAscHh+uflx3coNsy1c7I/1Nj0QQfaQf67/TcoJ4SGpaZcgxjm/90hO44nMA==
X-Received: by 2002:a05:6000:1b86:b0:314:34dd:aaec with SMTP id
 r6-20020a0560001b8600b0031434ddaaecmr9477319wru.8.1688927616087; 
 Sun, 09 Jul 2023 11:33:36 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 35/45] linux-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Sun,  9 Jul 2023 19:29:22 +0100
Message-Id: <20230709182934.309468-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-19-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 52 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c4b2515271..738b9b797d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -318,55 +318,15 @@ unsigned long last_brk;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong align)
 {
-    abi_ulong addr, end_addr, incr = qemu_host_page_size;
-    int prot;
-    bool looped = false;
+    target_ulong ret;
 
-    if (size > reserved_va) {
-        return (abi_ulong)-1;
+    ret = page_find_range_empty(start, reserved_va, size, align);
+    if (ret == -1 && start > mmap_min_addr) {
+        /* Restart at the beginning of the address space. */
+        ret = page_find_range_empty(mmap_min_addr, start - 1, size, align);
     }
 
-    /* Note that start and size have already been aligned by mmap_find_vma. */
-
-    end_addr = start + size;
-    /*
-     * Start at the top of the address space, ignoring the last page.
-     * If reserved_va == UINT32_MAX, then end_addr wraps to 0,
-     * throwing the rest of the calculations off.
-     * TODO: rewrite using last_addr instead.
-     * TODO: use the interval tree instead of probing every page.
-     */
-    if (start > reserved_va - size) {
-        end_addr = ((reserved_va - size) & -align) + size;
-        looped = true;
-    }
-
-    /* Search downward from END_ADDR, checking to see if a page is in use.  */
-    addr = end_addr;
-    while (1) {
-        addr -= incr;
-        if (addr > end_addr) {
-            if (looped) {
-                /* Failure.  The entire address space has been searched.  */
-                return (abi_ulong)-1;
-            }
-            /* Re-start at the top of the address space (see above). */
-            addr = end_addr = ((reserved_va - size) & -align) + size;
-            looped = true;
-        } else {
-            prot = page_get_flags(addr);
-            if (prot) {
-                /* Page in use.  Restart below this page.  */
-                addr = end_addr = ((addr - size) & -align) + size;
-            } else if (addr && addr + size == end_addr) {
-                /* Success!  All pages between ADDR and END_ADDR are free.  */
-                if (start == mmap_next_start) {
-                    mmap_next_start = addr;
-                }
-                return addr;
-            }
-        }
-    }
+    return ret;
 }
 
 /*
-- 
2.34.1


