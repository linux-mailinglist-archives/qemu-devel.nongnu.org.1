Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382174B83C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGY-0004r7-0g; Fri, 07 Jul 2023 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGO-0004ph-DO
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGM-0004oc-OA
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so2412540f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762469; x=1691354469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rcUcYz/ENHU71nYFSKtvNzNb/+e+Z1fgOhw2rx254o=;
 b=ALrpDHm1yixuEDx84oh/VAWyOmAdn+xln8TIxt/+JACL7ScSF+xrsSW7MKV2K2u75j
 A+cDe40s/6reaI8XT6rJTTdutml0TPdMXpwDODuwU0iNlOOKamit2kayfizBmFkyy5or
 2nsNljUZCtRcSyFcZ2bbhAa4yaEpCu/15QssKFy7Vj2ZKsrUw24M1W9El40hnxi4LAUP
 7RSiW9mFi+GIcl/sgd13VX1SgiLj03JCYK6HIMwopj34sDXfu7gphyMbJnw8FPAfoN5D
 xINizRUaGhWptXS1ZFTvyMOdiqskEnSxSIUfE5qln1Evc31cK7jbPB3WeEpD31JFyOrR
 GkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762469; x=1691354469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rcUcYz/ENHU71nYFSKtvNzNb/+e+Z1fgOhw2rx254o=;
 b=Mi81ssTLTrnWgwHF8SK1dBgtPx/iE8Nw0TPulxbyZpYq2wVDOqf+21qBIpklZ4SQ4u
 BRRLbd3gCSdi5tslWHXU9Z3sUBTSsfun2xubW+0ZQs0ug/yh4JZzE+xnHDZEr7aHAUtW
 k7EhVkpfDsJeHYRMDmUQMopJarDD88iDfryHH+0FAZKtvS0UKu9fT5zvEGn/Wp2MH5iQ
 beu1UObEYUyhRdhV09SU9XhnXNmbiIiUKRIavXGyd2RBvywsipGODloEd/X7MVPcCjNa
 1yAfCD1pnsngnD9gxPSmcwouwjSKd9JiBHRyTyDqEzlHkb5js2N/H29j0ca+DbNyl8gE
 G+iA==
X-Gm-Message-State: ABy/qLabN00x+6iNVFCJiLKEdErgzgPkGcvapJxobshZKaX1/84dHOEw
 5SVAoalcN8I8CV+KVYZD5NCfAmhPrD+dgVCtaItfzg==
X-Google-Smtp-Source: APBJJlF5BeQvfiUn6cM3aPxYiOCTMHWAX8mnXHiZ1dTFjWZYRpEzATlrZ5fu/PRl5rAC3QNlhvL6bg==
X-Received: by 2002:a05:6000:104c:b0:313:e55f:b78c with SMTP id
 c12-20020a056000104c00b00313e55fb78cmr4711529wrx.21.1688762469252; 
 Fri, 07 Jul 2023 13:41:09 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 18/24] linux-user: Rewrite mmap_reserve
Date: Fri,  7 Jul 2023 21:40:48 +0100
Message-Id: <20230707204054.8792-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Use 'last' variables instead of 'end' variables; be careful
about avoiding overflow.  Assert that the mmap succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 68 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 67a117823f..6b030dac42 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,47 +722,63 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong size)
+static void mmap_reserve(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
-    abi_ulong real_end;
-    abi_ulong addr;
-    abi_ulong end;
+    abi_ulong real_last;
+    abi_ulong real_len;
+    abi_ulong last;
+    abi_ulong a;
+    void *host_start, *ptr;
     int prot;
 
+    last = start + len - 1;
     real_start = start & qemu_host_page_mask;
-    real_end = HOST_PAGE_ALIGN(start + size);
-    end = start + size;
-    if (start > real_start) {
-        /* handle host page containing start */
+    real_last = HOST_PAGE_ALIGN(last) - 1;
+
+    /*
+     * If guest pages remain on the first or last host pages,
+     * adjust the deallocation to retain those guest pages.
+     * The single page special case is required for the last page,
+     * lest real_start overflow to zero.
+     */
+    if (real_last - real_start < qemu_host_page_size) {
         prot = 0;
-        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
-        if (real_end == real_start + qemu_host_page_size) {
-            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-                prot |= page_get_flags(addr);
-            }
-            end = real_end;
+        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
+        }
+        if (prot != 0) {
+            return;
+        }
+    } else {
+        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
         if (prot != 0) {
             real_start += qemu_host_page_size;
         }
-    }
-    if (end < real_end) {
-        prot = 0;
-        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+
+        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            real_end -= qemu_host_page_size;
+            real_last -= qemu_host_page_size;
+        }
+
+        if (real_last < real_start) {
+            return;
         }
     }
-    if (real_start != real_end) {
-        mmap(g2h_untagged(real_start), real_end - real_start, PROT_NONE,
-                 MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE,
-                 -1, 0);
-    }
+
+    real_len = real_last - real_start + 1;
+    host_start = g2h_untagged(real_start);
+
+    ptr = mmap(host_start, real_len, PROT_NONE,
+               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+    assert(ptr == host_start);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


