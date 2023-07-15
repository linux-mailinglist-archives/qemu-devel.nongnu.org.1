Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C97548F0
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiv-0004M7-4S; Sat, 15 Jul 2023 09:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfib-00048X-1m
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiT-0001Jo-BN
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31590e4e27aso2768387f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429224; x=1692021224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N9gguT3TBruptKaq1lWfbF+0g4+LhgVIPeZNOW/uhRg=;
 b=gNLS2Mv0rgcoBt9ZiMRNzYNOPVmiUz2GqFWQDpE2Ba+PDT8gOXsoBLvyfFtysJhUai
 4i08Zjt/hjPQA/DgrAjw/KQGxBRt2OlrPI/3NT9zSADAVm0lSHQqToFHHRhty08+O3kL
 eq0SWhfUl94zTW4RtXEAXbEyGLUwOwnAoBJ1X7L6gXuSwcpXTbV1JO6YXwRe4IAbJdoO
 moDXkN/vC4mFJvXtWABEdiCxytoVFaEXBGze+If/PIogYOi1IyyOUEhjwCsUCocmrIAZ
 RvXk075g1s12iRRsXgtHK29jZaRL4fTSJ+cD2sgtJaZ6lQnNraYfZN01HCY/VRTgyoQa
 rMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429224; x=1692021224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9gguT3TBruptKaq1lWfbF+0g4+LhgVIPeZNOW/uhRg=;
 b=f2F9YWE2bKbek9sMveaXG4pgDuML0SaTFTVCxY2ljJ/YSBCXuGVsA308Xk6oai3i+H
 YjDoWh8e3wD+Zh2JkGgxkYF4uid+kK4i0nD0e8A4OBfOffoOHg2i9qWk7YFy77HglWPv
 9jKquoqRiU6PG+o3KtNdT5rC6I5MJUL58Hqy+8mFQxQt60D42P/iB5QsRxgBjWg4aGzu
 dPXX9aZ20qtY46D6Cwh7wGmckPavdwuqay527ZCrGli0tAfly2wO4/vbnLD9Y2vEcU5m
 4/W3D4Fj/b7KPbTy/eKmCYLsxpi/vTW8bhOAssji343IQidyDIXo7s9grksSJZ0imZJr
 5BDA==
X-Gm-Message-State: ABy/qLbLr1axHWb/89cIhkuRL/sN94Gakh99McO+ZnO3XYdPIIVNR/eq
 DMOLZFYUP14H9uDWgbR+w6wsRJnRK3pBC0XIW9NZ+g==
X-Google-Smtp-Source: APBJJlGnUOt1T5iu4GEE0ax4gkebh8CNhnLsjmHKRyIlUd/sFZne1vNQzIjruSC+9d9y7E/D/5P4DQ==
X-Received: by 2002:a5d:658e:0:b0:316:f25c:d0c0 with SMTP id
 q14-20020a5d658e000000b00316f25cd0c0mr2696891wru.16.1689429224055; 
 Sat, 15 Jul 2023 06:53:44 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/47] linux-user: Rewrite target_mprotect
Date: Sat, 15 Jul 2023 14:53:01 +0100
Message-Id: <20230715135317.7219-32-richard.henderson@linaro.org>
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

Use 'last' variables instead of 'end' variables.
When host page size > guest page size, detect when
adjacent host pages have the same protection and
merge that expanded host range into fewer syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-15-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b2c2d85857..d02d74d279 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -120,8 +120,11 @@ static int target_to_host_prot(int prot)
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
-    abi_ulong end, host_start, host_end, addr;
-    int prot1, ret, page_flags;
+    abi_ulong starts[3];
+    abi_ulong lens[3];
+    int prots[3];
+    abi_ulong host_start, host_last, last;
+    int prot1, ret, page_flags, nranges;
 
     trace_target_mprotect(start, len, target_prot);
 
@@ -132,63 +135,88 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     if (!page_flags) {
         return -TARGET_EINVAL;
     }
-    len = TARGET_PAGE_ALIGN(len);
-    end = start + len;
-    if (!guest_range_valid_untagged(start, len)) {
-        return -TARGET_ENOMEM;
-    }
     if (len == 0) {
         return 0;
     }
+    len = TARGET_PAGE_ALIGN(len);
+    if (!guest_range_valid_untagged(start, len)) {
+        return -TARGET_ENOMEM;
+    }
+
+    last = start + len - 1;
+    host_start = start & qemu_host_page_mask;
+    host_last = HOST_PAGE_ALIGN(last) - 1;
+    nranges = 0;
 
     mmap_lock();
-    host_start = start & qemu_host_page_mask;
-    host_end = HOST_PAGE_ALIGN(end);
-    if (start > host_start) {
-        /* handle host page containing start */
+
+    if (host_last - host_start < qemu_host_page_size) {
+        /* Single host page contains all guest pages: sum the prot. */
         prot1 = target_prot;
-        for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+        for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a);
         }
-        if (host_end == host_start + qemu_host_page_size) {
-            for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-                prot1 |= page_get_flags(addr);
+        for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+            prot1 |= page_get_flags(a + 1);
+        }
+        starts[nranges] = host_start;
+        lens[nranges] = qemu_host_page_size;
+        prots[nranges] = prot1;
+        nranges++;
+    } else {
+        if (host_start < start) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                starts[nranges] = host_start;
+                lens[nranges] = qemu_host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+                host_start += qemu_host_page_size;
             }
-            end = host_end;
         }
-        ret = mprotect(g2h_untagged(host_start), qemu_host_page_size,
-                       target_to_host_prot(prot1));
-        if (ret != 0) {
-            goto error;
+
+        if (last < host_last) {
+            /* Host page contains more than one guest page: sum the prot. */
+            prot1 = target_prot;
+            for (abi_ulong a = last; a < host_last; a += TARGET_PAGE_SIZE) {
+                prot1 |= page_get_flags(a + 1);
+            }
+            /* If the resulting sum differs, create a new range. */
+            if (prot1 != target_prot) {
+                host_last -= qemu_host_page_size;
+                starts[nranges] = host_last + 1;
+                lens[nranges] = qemu_host_page_size;
+                prots[nranges] = prot1;
+                nranges++;
+            }
         }
-        host_start += qemu_host_page_size;
-    }
-    if (end < host_end) {
-        prot1 = target_prot;
-        for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
-            prot1 |= page_get_flags(addr);
+
+        /* Create a range for the middle, if any remains. */
+        if (host_start < host_last) {
+            starts[nranges] = host_start;
+            lens[nranges] = host_last - host_start + 1;
+            prots[nranges] = target_prot;
+            nranges++;
         }
-        ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, target_to_host_prot(prot1));
-        if (ret != 0) {
-            goto error;
-        }
-        host_end -= qemu_host_page_size;
     }
 
-    /* handle the pages in the middle */
-    if (host_start < host_end) {
-        ret = mprotect(g2h_untagged(host_start), host_end - host_start,
-                       target_to_host_prot(target_prot));
+    for (int i = 0; i < nranges; ++i) {
+        ret = mprotect(g2h_untagged(starts[i]), lens[i],
+                       target_to_host_prot(prots[i]));
         if (ret != 0) {
             goto error;
         }
     }
 
-    page_set_flags(start, start + len - 1, page_flags);
+    page_set_flags(start, last, page_flags);
     ret = 0;
 
-error:
+ error:
     mmap_unlock();
     return ret;
 }
-- 
2.34.1


