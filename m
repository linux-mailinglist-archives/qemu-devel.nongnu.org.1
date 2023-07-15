Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D254B754910
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjn-000738-KM; Sat, 15 Jul 2023 09:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfid-000497-Su
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiZ-0001Kh-OQ
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2876698f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429228; x=1692021228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LwsEQEgJb6LbDaZv4vgO4Dp17xTKrnyDcX9Cf57n7+Y=;
 b=PK6NCBQ11EP0lR00GNVRNRVEUJBe5UKTgcyP6kURdm3MgvaUhca6ycc8EhwpbZDq7v
 KGeu0WpGDi/3/9XMmdVS6ljII9JqQUHtZBBCsVAoT8HurlsX26Y+MDjxCVlyQIsWwWez
 ayIr6bF22eZaRW6vnCJMla6TQePATSgLW78WntuU00w+qoWqZkNPEDRXwGNGBQMlwSeS
 knkz4xq3/+RRvI+juKG/pGTXrV2n9wXjY8QJsrst2abcC7hrOfLZg1uJUnDeMqMjix1c
 LrbrFly5WQm384Ngq80AoIruqea93BGwkvizffz2aa6i82E2DJpaQaQEqiFXLBpNPlkC
 PcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429228; x=1692021228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwsEQEgJb6LbDaZv4vgO4Dp17xTKrnyDcX9Cf57n7+Y=;
 b=VxmFLdZEPyf9Dlx5cPbLG5hol5eKoE9AMw0C37ys+3MOlFuYlH4DO/F0uZvtlY/m/H
 RPz++NSLGk6l84QOruNIXU9jFpa5wpdlENO9ZwBI302I6ACVw+5hKYlizE8a9Fl2QAwv
 czCKAxzy/hPcmrxd6yZzGx6I4rC+DDLx9pb9nQE5hUnzKRv9N0Agsd16YZdVOxZoEnjb
 HRgq0EwdsCbydKG3Rn94uQ/P7/PxTIP1xc3x+22hmAW56WdbvkRQ8jXH+1Lhd+55BsDD
 DpfbhzGq8sFxEJiusew66Gxg9YynTyFfeyIqUgz3T/hh20bPJZi5LND9vsxmpCrA2yLg
 kDvA==
X-Gm-Message-State: ABy/qLb94hOFwQMvIMzDbR9lpmqpmcPC6QbCddEFth+COAm+QmObQ7Gb
 OE5tpy+v8vwE2G1anMQOSWEz+PxnORNKoIrML3ywzA==
X-Google-Smtp-Source: APBJJlEbdwWb+lpGM3JTsDErOePndQgWtFQcJXuZEZ/MP5bOn29kKPDPAXbwQ/dGbASrvwlfYjZVpA==
X-Received: by 2002:adf:de8e:0:b0:30f:c56c:b5b3 with SMTP id
 w14-20020adfde8e000000b0030fc56cb5b3mr6760789wrl.4.1689429228141; 
 Sat, 15 Jul 2023 06:53:48 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/47] linux-user: Rewrite mmap_reserve
Date: Sat, 15 Jul 2023 14:53:07 +0100
Message-Id: <20230715135317.7219-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-Id: <20230707204054.8792-21-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 68 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index bb9cbe52cd..6308787942 100644
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


