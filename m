Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78555774C7C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx1-0007iJ-4O; Tue, 08 Aug 2023 17:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwy-0007hK-DM
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:08 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTww-0005wh-La
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:08 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2693640dfa2so2057220a91.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528945; x=1692133745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSqlJaXSE2kMrCNQmu7hR6r1H+eIl/aIUEieOM1aKCY=;
 b=jDpzr2BuiFX/zR7wyE3kyMfnzy+78UMnhmdUFZu6yRECO4gvZPvcRug3D+f57HxNki
 xOVMYEf5Fybxg5MwCRsO0At0qbtQ7C09gCqzX5IjspDNQuSjBO6nW9Yrt5u3Gk/MKSXJ
 DPpddx/HPs5sUsOhka6HQPGckHc6CWpios23Ws6H8ufSVUFU9U3jKbknQdU1HbSXAob4
 SEtS+WrWIbj68y4ac8fcFZFaBKZznOgUnGqKp8DuR9+nVrrGitv1zqzTsBINK5aNgMNY
 7lzbhpMFegnlm+am+zrIPXRQVz1HurHhdDm0U0qjNO2SM/QhGSjRWdFE/ce8P3lG6hgi
 PFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528945; x=1692133745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSqlJaXSE2kMrCNQmu7hR6r1H+eIl/aIUEieOM1aKCY=;
 b=Db60ncksprBOXvvmSckA5Fc9ZdDnVOWI0fAUGNUlsUJGIFf6fCnXGU44KRg6OX4YnR
 kXpPpSMTuT66wsss+lSLTJ6EquKPaxfY1OrecVs9M27Y4dZ/470BBDcB547CflvD2rQu
 PYjjTSj7gocpd/K80FKDysMl3WMSFoY78u0Q9wh9qryqiALRvy+GhqueklIoaS6Amq6P
 LSdhw883c2u3s4RVshvyrgx4qgRf9WojC2dIVcvnaq0ZJRDGY81W0di0oGwY3NLJE34L
 jorr9suGLvxpveudE8BT6Y2p/nYjv0ebu5O5Lj2UrjToY7+utmLkUgla0T/n7IK7xH9K
 m63g==
X-Gm-Message-State: AOJu0YwQRu5M+9hoKOOFZmfFbJgwUBYo0Earm88rMTAYLPw9WQiWYOMb
 ZgKTrh2Bl7OZOH2e9ua0Fee5O+BOGl5CNWgNhBg=
X-Google-Smtp-Source: AGHT+IFSZIsWAjVjck0ZtLIhTYZAQeVtNYW4wbT1rRX05Y4/jgEhO5YyKVjEPBDepdE+bsk9GVK9eA==
X-Received: by 2002:a17:90a:ea0a:b0:268:b66b:d9f6 with SMTP id
 w10-20020a17090aea0a00b00268b66bd9f6mr642944pjy.18.1691528945302; 
 Tue, 08 Aug 2023 14:09:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 08/14] linux-user: Do not adjust zero_bss for host page size
Date: Tue,  8 Aug 2023 14:08:50 -0700
Message-Id: <20230808210856.95568-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Rely on target_mmap to handle guest vs host page size mismatch.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 63 +++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 964b21f997..881fdeb157 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2211,47 +2211,37 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
     }
 }
 
-/* Map and zero the bss.  We need to explicitly zero any fractional pages
-   after the data section (i.e. bss).  */
-static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
+/**
+ * zero_bss:
+ *
+ * Map and zero the bss.  We need to explicitly zero any fractional pages
+ * after the data section (i.e. bss).  Return false on mapping failure.
+ */
+static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
 {
-    uintptr_t host_start, host_map_start, host_end;
+    abi_ulong align_bss;
 
-    last_bss = TARGET_PAGE_ALIGN(last_bss);
+    align_bss = TARGET_PAGE_ALIGN(start_bss);
+    end_bss = TARGET_PAGE_ALIGN(end_bss);
 
-    /* ??? There is confusion between qemu_real_host_page_size and
-       qemu_host_page_size here and elsewhere in target_mmap, which
-       may lead to the end of the data section mapping from the file
-       not being mapped.  At least there was an explicit test and
-       comment for that here, suggesting that "the file size must
-       be known".  The comment probably pre-dates the introduction
-       of the fstat system call in target_mmap which does in fact
-       find out the size.  What isn't clear is if the workaround
-       here is still actually needed.  For now, continue with it,
-       but merge it with the "normal" mmap that would allocate the bss.  */
+    if (start_bss < align_bss) {
+        int flags = page_get_flags(start_bss);
 
-    host_start = (uintptr_t) g2h_untagged(elf_bss);
-    host_end = (uintptr_t) g2h_untagged(last_bss);
-    host_map_start = REAL_HOST_PAGE_ALIGN(host_start);
-
-    if (host_map_start < host_end) {
-        void *p = mmap((void *)host_map_start, host_end - host_map_start,
-                       prot, MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
-            perror("cannot mmap brk");
-            exit(-1);
+        if (!(flags & PAGE_VALID)) {
+            /* Map the start of the bss. */
+            align_bss -= TARGET_PAGE_SIZE;
+        } else if (flags & PAGE_WRITE) {
+            /* The page is already mapped writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
+        } else {
+            /* Read-only zeros? */
+            g_assert_not_reached();
         }
     }
 
-    /* Ensure that the bss page(s) are valid */
-    if ((page_get_flags(last_bss-1) & prot) != prot) {
-        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss - 1,
-                       prot | PAGE_VALID);
-    }
-
-    if (host_start < host_map_start) {
-        memset((void *)host_start, 0, host_map_start - host_start);
-    }
+    return align_bss >= end_bss ||
+           target_mmap(align_bss, end_bss - align_bss, prot,
+                       MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) != -1;
 }
 
 #if defined(TARGET_ARM)
@@ -3255,8 +3245,9 @@ static void load_elf_image(const char *image_name, int image_fd,
                 /*
                  * If the load segment requests extra zeros (e.g. bss), map it.
                  */
-                if (eppnt->p_filesz < eppnt->p_memsz) {
-                    zero_bss(vaddr_ef, vaddr_em, elf_prot);
+                if (eppnt->p_filesz < eppnt->p_memsz &&
+                    !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
+                    goto exit_mmap;
                 }
             } else if (eppnt->p_memsz != 0) {
                 vaddr_len = eppnt->p_memsz + vaddr_po;
-- 
2.34.1


