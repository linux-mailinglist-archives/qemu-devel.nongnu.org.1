Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F084821631
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3T-0003VH-T7; Mon, 01 Jan 2024 20:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3P-0003Lj-7U
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:51 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3N-00072u-Hi
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:50 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so4527187b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160728; x=1704765528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnSJisjhmOEPjG/usSlqH7jpNx1heRPl0XkUSpAoUU4=;
 b=aDr1PqNlVmx4prsdKZJYRIm1vVLFrlbT6SY+3REZiZoWHYh3Oj+ALdajLfoNkPsZh7
 PUx6vukihpxMCfj0LC0oRtdffGQukkr80+Egwfr6iE8lzzLGYtjqlKy6vNGA01kyF7Tg
 RyzeiFyIClFuFE97n/IymEcNvGUmBlIUR+hmNzAcj6WfVP+7om1Bvfm2ODNkrZUP/Goy
 rxd9w8cUPUl+pAMHEGyOA6/C6rP/AMhq0TCLUDBpMP1vuy9QOc1dLcZ2v1loOFhasIpo
 G1Yj0MVvUGy6np5T0Eof3ZI82ryXuFCYhbSZarF2GJyQzy2tNNa/KrbGF1hJo3dCGzhd
 MvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160728; x=1704765528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnSJisjhmOEPjG/usSlqH7jpNx1heRPl0XkUSpAoUU4=;
 b=MEB1pD6rQCL/PwJDuhOsNwFhns2lJ2ZkJIrLxq432uvz3jj+Mx1wAZit4SR1eF9jZf
 vRl0bXcz6k2panp6KnG0uSIQ54SgFN9Fww7vebqQYhk38+9Pp1dH87oF++J8HyISsg4g
 QWmy71O+7hcmo1/tYfb2webZwEByx9B1xdpxTg288oot5prnsmk57OSARQ64JvhiQvOK
 4Ou+K5cwlDRfg1gshaYsRplqJ+zdqvZJf5b20epDobtJYPp/Lkp/XbgJMTbBuGxGOVl4
 4D0i1lHUOfJYxs2xy94BJo1Dn3Aqyg4Yb7hzeESXOsHDt0cCbaJ3vbCSCsXFA8cagwaV
 Qbag==
X-Gm-Message-State: AOJu0Yz40f9+oiqNHmSysAPvqJuGXeV69CriohRRvGsB3IwFCZBPAD/5
 VchgXQ3pkEMs80ATrPt4o0VosRi5PtMcIB/aNr4FrS8p/2w=
X-Google-Smtp-Source: AGHT+IEAGlexuAg3lxm+T1XIQe1a0LOV0XxZb3TleOCDXhLfRg4LkVgcjkmJOnp+ilwF+MBVdDVeVA==
X-Received: by 2002:a05:6a00:1d96:b0:6d9:af31:293b with SMTP id
 z22-20020a056a001d9600b006d9af31293bmr17005737pfw.61.1704160728179; 
 Mon, 01 Jan 2024 17:58:48 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/33] linux-user: Move some mmap checks outside the lock
Date: Tue,  2 Jan 2024 12:57:52 +1100
Message-Id: <20240102015808.132373-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Basic validation of operands does not require the lock.
Hoist them from target_mmap__locked back into target_mmap.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4c3cc65aa..fbaea832c5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -491,52 +491,14 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
-                                    int target_prot, int flags,
+                                    int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
-    int page_flags;
     off_t host_offset;
 
-    if (!len) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    page_flags = validate_prot_to_pageflags(target_prot);
-    if (!page_flags) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /* Also check for overflows... */
-    len = TARGET_PAGE_ALIGN(len);
-    if (!len) {
-        errno = ENOMEM;
-        return -1;
-    }
-
-    if (offset & ~TARGET_PAGE_MASK) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /*
-     * If we're mapping shared memory, ensure we generate code for parallel
-     * execution and flush old translations.  This will work up to the level
-     * supported by the host -- anything that requires EXCP_ATOMIC will not
-     * be atomic with respect to an external process.
-     */
-    if (flags & MAP_SHARED) {
-        CPUState *cpu = thread_cpu;
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
-            tb_flush(cpu);
-        }
-    }
-
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
 
@@ -616,23 +578,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         passthrough_start = start;
         passthrough_last = last;
     } else {
-        if (start & ~TARGET_PAGE_MASK) {
-            errno = EINVAL;
-            return -1;
-        }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
 
-        /*
-         * Test if requested memory area fits target address space
-         * It can fail only on 64-bit host with 32-bit target.
-         * On any other target/host host mmap() handles this error correctly.
-         */
-        if (last < start || !guest_range_valid_untagged(start, len)) {
-            errno = ENOMEM;
-            return -1;
-        }
-
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
@@ -778,13 +726,64 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
     abi_long ret;
+    int page_flags;
 
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
+
+    if (!len) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    page_flags = validate_prot_to_pageflags(target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    /* Also check for overflows... */
+    len = TARGET_PAGE_ALIGN(len);
+    if (!len || len != (size_t)len) {
+        errno = ENOMEM;
+        return -1;
+    }
+
+    if (offset & ~TARGET_PAGE_MASK) {
+        errno = EINVAL;
+        return -1;
+    }
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (start & ~TARGET_PAGE_MASK) {
+            errno = EINVAL;
+            return -1;
+        }
+        if (!guest_range_valid_untagged(start, len)) {
+            errno = ENOMEM;
+            return -1;
+        }
+    }
+
     mmap_lock();
 
-    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+    ret = target_mmap__locked(start, len, target_prot, flags,
+                              page_flags, fd, offset);
 
     mmap_unlock();
+
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
+        CPUState *cpu = thread_cpu;
+        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+            cpu->tcg_cflags |= CF_PARALLEL;
+            tb_flush(cpu);
+        }
+    }
+
     return ret;
 }
 
-- 
2.34.1


