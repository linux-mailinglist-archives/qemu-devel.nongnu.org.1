Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DE770BBB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rN-0004xC-6c; Fri, 04 Aug 2023 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qm-0004bA-Fu
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qk-0001tE-PE
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:48 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bb140cd5a5so2226704a34.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186445; x=1691791245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esXvpi4eaSEXYu7hbvu9VsTfQefHdQqF7XtT9IOgTiM=;
 b=u218Qan5vcum+Rfw9vu5O76K4IUwz2kiqi9s99Ejp0bDKGmtDJ0iw7MOAqWRzrGGty
 QF9IeL9KwqAV2LTYojVBOJZzrH5l84NttRQ5MGlsQUf1dAGcVwyaet8CoyCenyD1xTB7
 tt+27SDUWs1IMis+P44keNwWtBE/1OE6hSejUisNudwhCzfoL5UE1EdXzfIF6AU28hIG
 XgcL0xAiPU7gNtn67Se5jNFtjtwwDNuwyEsXb3BbMvqS3KDgLVNbFwz1naJZbvcqcz6j
 yTPcICv3y37dBnfxkpX1yBOKqpzAAM5VvW7dsSTix8yvZobgEka2UBM8z71v/H95+Ipq
 GO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186445; x=1691791245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esXvpi4eaSEXYu7hbvu9VsTfQefHdQqF7XtT9IOgTiM=;
 b=EQYGtVXaxOVHRfHlbZgbAWGsT7yW18qYuvbt250UxdZ7U4aH5Gs0Bhtl++mp+t07o0
 usD1RZhd6vdonuLjCWrJ0RGVauMYrSM+S5I60IGS/LygXFdhZqUDxn8BTo3NOTM/lmkI
 RXZLRtRVdjkIMlzZ+nwSUwn0jtIy7lQvmO1F/tr15XjHu4qXQ45UVGZBbnCRb8/k0wil
 FCS0xEZyVTLeCTq4PaeOOmP2gUfEv8/Jl7KiICnufiQRsf0cNav8xQGWzvuVl/TKMReV
 79do1AkvHs2aYdJSusk9OGcDK3SYPDFRY6y6LbAGAP1SLbvnp62mgOqH9SKebd82JfyX
 8aLQ==
X-Gm-Message-State: AOJu0YzJo3PUtqW5MJXIlHcY+6DcFEVhyLUSjOqTJUWLhtc2fEVE8F30
 cUwx7DabsNTykEf8bUXM0od67twzAZx3kppsFBE=
X-Google-Smtp-Source: AGHT+IEfa8G0NoJQT7i13XtjrcsU/OJ9JyT4yBXVlmWDltnUuDAo+g9wiLEh1T16DZ2FKE9KqOw34w==
X-Received: by 2002:a05:6870:8a14:b0:1bb:75af:37b5 with SMTP id
 p20-20020a0568708a1400b001bb75af37b5mr3244079oaq.10.1691186444897; 
 Fri, 04 Aug 2023 15:00:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 13/24] linux-user: Adjust task_unmapped_base for reserved_va
Date: Fri,  4 Aug 2023 15:00:21 -0700
Message-Id: <20230804220032.295411-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ensure that the chosen values for mmap_next_start and
task_unmapped_base are within the guest address space.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h | 18 +++++++++++++++++-
 linux-user/main.c      | 28 ++++++++++++++++++++++++++++
 linux-user/mmap.c      | 18 +++---------------
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 7265c2c116..fd456e024e 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,23 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#ifdef TARGET_AARCH64
+# define TASK_UNMAPPED_BASE  0x5500000000
+#else
+# define TASK_UNMAPPED_BASE  (1ul << 38)
+#endif
+#else
+#ifdef TARGET_HPPA
+# define TASK_UNMAPPED_BASE  0xfa000000
+#else
+# define TASK_UNMAPPED_BASE  0x40000000
+#endif
+#endif
+
+extern abi_ulong task_unmapped_base;
+extern abi_ulong mmap_next_start;
+
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset);
@@ -26,7 +43,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
diff --git a/linux-user/main.c b/linux-user/main.c
index dba67ffa36..7ba7039988 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -821,6 +821,34 @@ int main(int argc, char **argv, char **envp)
         reserved_va = max_reserved_va;
     }
 
+    /*
+     * Temporarily disable
+     *   "comparison is always false due to limited range of data type"
+     * due to comparison between (possible) uint64_t and uintptr_t.
+     */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+
+    /*
+     * Select an initial value for task_unmapped_base that is in range.
+     */
+    if (reserved_va) {
+        if (TASK_UNMAPPED_BASE < reserved_va) {
+            task_unmapped_base = TASK_UNMAPPED_BASE;
+        } else {
+            /* The most common default formula is TASK_SIZE / 3. */
+            task_unmapped_base = TARGET_PAGE_ALIGN(reserved_va / 3);
+        }
+    } else if (TASK_UNMAPPED_BASE < UINTPTR_MAX) {
+        task_unmapped_base = TASK_UNMAPPED_BASE;
+    } else {
+        /* 32-bit host: pick something medium size. */
+        task_unmapped_base = 0x10000000;
+    }
+    mmap_next_start = task_unmapped_base;
+
+#pragma GCC diagnostic pop
+
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index eb04fab8ab..84436d45c8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -299,20 +299,8 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     return true;
 }
 
-#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
-#ifdef TARGET_AARCH64
-# define TASK_UNMAPPED_BASE  0x5500000000
-#else
-# define TASK_UNMAPPED_BASE  (1ul << 38)
-#endif
-#else
-#ifdef TARGET_HPPA
-# define TASK_UNMAPPED_BASE  0xfa000000
-#else
-# define TASK_UNMAPPED_BASE  0x40000000
-#endif
-#endif
-abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
+abi_ulong task_unmapped_base;
+abi_ulong mmap_next_start;
 
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated
@@ -391,7 +379,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
             if ((addr & (align - 1)) == 0) {
                 /* Success.  */
-                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
+                if (start == mmap_next_start && addr >= task_unmapped_base) {
                     mmap_next_start = addr + size;
                 }
                 return addr;
-- 
2.34.1


