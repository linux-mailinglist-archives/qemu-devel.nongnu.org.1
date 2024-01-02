Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FD821641
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:01:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3c-0003dc-9Y; Mon, 01 Jan 2024 20:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3T-0003XI-6D
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:55 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3R-00073e-Ix
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:54 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6dc02ab3cc9so3595964a34.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160732; x=1704765532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKRPPYNauFVdl96BCtCoGjZgyH5GMNCuP4SDa2Vhch0=;
 b=hGjqh8EQtDOqDomytn/TRuQYx0vKuasDwt8jikwaUu0ZkrdnYOB8W/bV1K3ANlBXhM
 6yyB1jbgZxQvbUKpEfbNXasvBDKHblgB7KTkkRznPUbShaHKC4TpAonQVgdbsq6m0SJo
 hwDunXp2fpP0KiMvOKOgElHIAf8AHsq8uCcHie6wgIAMMNi08W125TmE6OjhVcjh2pOX
 VcaA9DcLnjHWuI5/sBWvUx6CUFr0HG3HBKUBb32A5m/46L2nLXYMJsztPU1b0705Jo5N
 VhCDrwOj8rNYEKn5+QBEQOJokngIUSDN4NEDzg1/Q4gRMOClRtkqhqLx0fO5DXfTwNQt
 L0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160732; x=1704765532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRPPYNauFVdl96BCtCoGjZgyH5GMNCuP4SDa2Vhch0=;
 b=S6cG/HrdvyxwLKOHilwJoAsZWlxF/zeZ5qUPWta9SZ9tS9TIAmCQD5sklzpNp48UaT
 1CoeEvY2b/tNCkDycavOurEK4YHgWbCacOGJwH3de4Tw4Lu/bm3TGDlQe5+0rfbuXtiY
 4V+qP/nMPUKVFtmnzytr7eVLT4VPZlleoSSRc685ynbGRX6rYTl/d/5aPc9fkgpObccJ
 7vvuRA0rLfWixBaVglzaOs3kMymhygbC1SH1QchMV7EueM+Gjj8cdZ+b4oSJlTW9P4/H
 I/8OGY5s1raN/woFSkwzt06F5KCidfSNOsL1DisA5upPuaR8bF0efm67qtdMGrBC2ohW
 YtjQ==
X-Gm-Message-State: AOJu0YzE2ZQhcLJ/yYN9Hi2gw+3/oBBZExiIIblYvcu4yIs+cXpqkvsX
 P3LmExbiw4k7DJEVYSR4TMbT1JE/gsrHaBMRUTiEBnilw4g=
X-Google-Smtp-Source: AGHT+IHajtkrpVBsApKCNlShAchPHZiqyAyNzvdVUxp6YKNt2ABxYRbhk/OQgcrWCxtzglnQmC4kzw==
X-Received: by 2002:a05:6808:6543:b0:3bb:d7ff:982d with SMTP id
 fn3-20020a056808654300b003bbd7ff982dmr9579468oib.98.1704160732598; 
 Mon, 01 Jan 2024 17:58:52 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/33] linux-user: Split out mmap_end
Date: Tue,  2 Jan 2024 12:57:54 +1100
Message-Id: <20240102015808.132373-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Use a subroutine instead of a goto within target_mmap__locked.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 71 +++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 48fcdd4a32..cc983bedbd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,6 +490,43 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
+/*
+ * Record a successful mmap within the user-exec interval tree.
+ */
+static abi_long mmap_end(abi_ulong start, abi_ulong last,
+                         abi_ulong passthrough_start,
+                         abi_ulong passthrough_last,
+                         int flags, int page_flags)
+{
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_ANON;
+    }
+    page_flags |= PAGE_RESET;
+    if (passthrough_start > passthrough_last) {
+        page_set_flags(start, last, page_flags);
+    } else {
+        if (start < passthrough_start) {
+            page_set_flags(start, passthrough_start - 1, page_flags);
+        }
+        page_set_flags(passthrough_start, passthrough_last,
+                       page_flags | PAGE_PASSTHROUGH);
+        if (passthrough_last < last) {
+            page_set_flags(passthrough_last + 1, last, page_flags);
+        }
+    }
+    shm_region_rm_complete(start, last);
+    trace_target_mmap_complete(start);
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        FILE *f = qemu_log_trylock();
+        if (f) {
+            fprintf(f, "page layout changed following mmap\n");
+            page_dump(f);
+            qemu_log_unlock(f);
+        }
+    }
+    return start;
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -632,7 +669,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
-            goto the_end;
+            return mmap_end(start, last, -1, 0, flags, page_flags);
         }
 
         /* handle the start of the mapping */
@@ -643,7 +680,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end;
+                return mmap_end(start, last, -1, 0, flags, page_flags);
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,34 +727,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end:
-    if (flags & MAP_ANONYMOUS) {
-        page_flags |= PAGE_ANON;
-    }
-    page_flags |= PAGE_RESET;
-    if (passthrough_start > passthrough_last) {
-        page_set_flags(start, last, page_flags);
-    } else {
-        if (start < passthrough_start) {
-            page_set_flags(start, passthrough_start - 1, page_flags);
-        }
-        page_set_flags(passthrough_start, passthrough_last,
-                       page_flags | PAGE_PASSTHROUGH);
-        if (passthrough_last < last) {
-            page_set_flags(passthrough_last + 1, last, page_flags);
-        }
-    }
-    shm_region_rm_complete(start, last);
-    trace_target_mmap_complete(start);
-    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-        FILE *f = qemu_log_trylock();
-        if (f) {
-            fprintf(f, "page layout changed following mmap\n");
-            page_dump(f);
-            qemu_log_unlock(f);
-        }
-    }
-    return start;
+    return mmap_end(start, last, passthrough_start, passthrough_last,
+                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


