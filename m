Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14774B830
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGR-0004qB-SJ; Fri, 07 Jul 2023 16:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGM-0004oj-Sc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGL-0004mi-5a
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso25265845e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762468; x=1691354468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiFBqOav2YcGHKvTnJ77ytzLXJE7Ik+NidTUqHroIfU=;
 b=sVuOsFi4B0MTOTW82lsGjgcUiO0FfrFjm9YLeoJ2bqc5UFqIBl8bOZyTdByuZjnAaT
 j4AlrXkMkkji2OyW+MLNiLyTYjA5O+amD3OvQw3pIlomFBj0rALDdhYUufQidE9LYMKv
 ri+pcb7JVHCFOaB33j7uoq05rnXjwDqdCvZbhdxqvYdCWxrfql5fuSma1iSxM2enoQIe
 IfR3Wrz/f2SsGJ5TDNlNvgic94Ekz8TKu3Q2Nlfm1bu3S/3QWtbgR+Hfuh22qaZkNrKZ
 QtdZdOvHruC2C3edPq5qNXX8fcgJmfRSVS7TABILOGNOOAwxZs590agkYZ7NSx7Lvxb5
 fI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762468; x=1691354468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiFBqOav2YcGHKvTnJ77ytzLXJE7Ik+NidTUqHroIfU=;
 b=CvrvBQ5QG49EnITLkCa715WDFEuC0glJTXSd6pyMtHtRjkWVT7iTHnBlMBNLfdYzjD
 XsnOeNmpqx4w6lYsRIoe1lhXWnyqXcjr0YCJ2XfTjXpZyrPVRKiLLi6pqNPQNcTYaLNc
 CXCDCQTR9wjRVXTWJ6qbR3BYUbGD3Bvm17IAOYptldsuwjYpmMiRCdYW1nj8TDHD6XDZ
 aA9yZftC38F5zbGK3+L103NlR0w4V1EQjqZDIfcmYyQMMADFmMMxXw/dv+m1BeGkkLmY
 4kiQvyV3ndUtHIiUnC2wDf4FrlGfnx3j2mpdH/kCsSmfnZepjsa/PEVQO6HqPiN15X9b
 rDNg==
X-Gm-Message-State: ABy/qLbSFmbahPeBjDnLFLNVznhw5g1zmeE329Xd6KQihe8ilD05ERq9
 gyM+9LnQYyArQ1sX9bznAS4V6Oks3oU6u1lV6rYgvQ==
X-Google-Smtp-Source: APBJJlFZCXSND7lteau3q72nIL2KN/B8+Buakk5/UIb+VCsQW9rBmA8U6CGkyz4pQBX4NxYAyeyO+Q==
X-Received: by 2002:a7b:cc86:0:b0:3f9:c8b2:dfbd with SMTP id
 p6-20020a7bcc86000000b003f9c8b2dfbdmr3576182wma.19.1688762467883; 
 Fri, 07 Jul 2023 13:41:07 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 16/24] linux-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Fri,  7 Jul 2023 21:40:46 +0100
Message-Id: <20230707204054.8792-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
---
 linux-user/mmap.c | 52 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index db4705e049..6ecdf9e56d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -317,55 +317,15 @@ unsigned long last_brk;
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


