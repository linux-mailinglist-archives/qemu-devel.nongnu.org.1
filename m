Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E577137A
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaI-0003jc-2u; Sat, 05 Aug 2023 23:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaG-0003j8-LU
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:36 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaF-0007ay-3Q
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:36 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2685bcd046eso1672424a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293054; x=1691897854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQhgJn+xuWrfht0tZgQrit41wBeRtDQVHgOUdbJWgEM=;
 b=Hacv99WmJ9BnWfmFp/KhMmwj27f+9kUpj9WVeOdQwkjTRsabZU+Z8OKIraTjTaCJt4
 oERBS4vAQxs/RzbtQiG5IsNLPvSEkWzdtDkX1sHwSTFAXRmtKRZNjVi6HZufhiva7OCq
 sfSd827Gt9D+lY5ZwCnDaIRJSMPbqLt5WCQGOlcr4v8hA1gZ16Z5k9iDbU0LDNDSiw29
 EzZ/MuekqQr1Z/kJaMjeuzTSrKstVkuzSqRWG8qR+2Wq/fG6VJnIN/j8S5UpBawWje0m
 9o7X/q1mmccpACQc4l/cf30RnxM6F3JFZnBhz9qwFhvbUXVuCVP9i/pbKUfwaycAdVv6
 0JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293054; x=1691897854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQhgJn+xuWrfht0tZgQrit41wBeRtDQVHgOUdbJWgEM=;
 b=CL92eM0R6lmEE1m+Tt3OMRH0zviwnvB0LchPUODD/pd2uHWPWd4tN9PflIQfGb3vuy
 7ey9NC5LIZimwukM7CG6UO8bh49NPtUy8HXVo6uUHLRLSxsU336SKN1xaE8kkxkjly7P
 HMtygs1PD5c097+/6ebyeog9jzLJT8q1BmE2csPJ5Je88OMl4DmvbDFzl7RIYAXc62as
 QvDfVgD5W6vtsnDZa3Qb9qQmBscBMDI1mDoxbJ1Jfu2zThhGGDgpuHgaKnLGtyQ5jOF4
 TjtqtdRwUuSz2EVG1FJd62Q4MjO9DSlii9eGNsGAikrUIRWTNq9G1HGZEKrs7Rgzz/P6
 tgIQ==
X-Gm-Message-State: AOJu0YxUbP7QQ2kw/JfVrstC/i01vNaND/aYijzKeKXIff9WlG6Y4jDM
 Pwj8tsLi21gKAAwlVFm9rqfOasalUBXyXFnEoVk=
X-Google-Smtp-Source: AGHT+IH/Pw3Iksvmc5NVxNyRQpyaOlLnBqEN/Bf2QuTCSjV4ldvWwhoPueZQLSp5DvfieiXVjsBXMA==
X-Received: by 2002:a17:90b:ed4:b0:262:df91:cdce with SMTP id
 gz20-20020a17090b0ed400b00262df91cdcemr4447858pjb.23.1691293053748; 
 Sat, 05 Aug 2023 20:37:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 21/24] linux-user: Do not adjust zero_bss for host page size
Date: Sat,  5 Aug 2023 20:37:12 -0700
Message-Id: <20230806033715.244648-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 linux-user/elfload.c | 54 +++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e853a4ab33..66ab617bd1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2212,44 +2212,36 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
 
 /* Map and zero the bss.  We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  */
-static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
+static void zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
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
+    if (align_bss < end_bss) {
+        abi_long err = target_mmap(align_bss, end_bss - align_bss, prot,
+                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
+                                   -1, 0);
+        if (err == -1) {
+            perror("cannot mmap brk");
+            exit(-1);
+        }
     }
 }
 
-- 
2.34.1


