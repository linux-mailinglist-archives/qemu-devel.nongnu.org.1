Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA8C772B3D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EX-0007MR-Aj; Mon, 07 Aug 2023 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EK-00075f-QV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EJ-0002hT-5B
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so15798455ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426234; x=1692031034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3Tim9UDK/YyEXiyy7lP2/6WWteP8ml5X65zqKKrj48=;
 b=KqZHxkLHdIPHZ19qpKR9NfMlver6K4bSX9dOxh0jkZ+p+lZxHOZh21T/H0sQV2r/Ly
 zPBeydIGVId82Ie81xOjcpqM+xqajc2dsEFcJHNDGu4vOo2AD8wtSZ5wDeJ/19ZQaWHy
 0Qtz+jHGiF8ARfBHMb06nz6JNKTuiFQDWv2CZny9RZBMavAFfJOQLHj3Ptm5N1TGQHBu
 lmAJEGgob4/Qg4Jk7isxAw2tYrS0nCAQFQA4JcAhulorzXR32SRmc2Ca5Lro30e+hyoz
 7Y0CAHn2OfxZ0heKjQGMrPrUOXECdiJnHO+3qKTuQ91p8cgcq+qeFkasjfRPwsWZCHcS
 vCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426234; x=1692031034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3Tim9UDK/YyEXiyy7lP2/6WWteP8ml5X65zqKKrj48=;
 b=brg7W2j8XVLEtb/kKxH3wi4cBquRpYSPUGXFb82C9yzB5CxmVbSOtub6JMfCV2J18e
 7Mboa+AtIvRnrky55MQGbhwjHp7we5QEVUsFDRx8TaTVaAgg/MR9rl4LLnX5KAaOEwks
 vLjnPA3iYJTz57vdupCscpQ3ovsk/0gzIunnFczuMJxkN6OzwUiSymbElE7/OtEURr2C
 1NcPlW5KEXc2NPBOVmSdsHA3mkEG9l/Uc8YxRaH34l/hk84j/YWExp5gHINq0mngSQOW
 WHGDhLwhxPWJ0z9dFk7lJ2kyh51fxPz0Ko49dh+Bu8WrTTljoRho4mhlPQJTrBuYwjCv
 VLKA==
X-Gm-Message-State: AOJu0YxgbEbgMYg15R12eP5OOC+mm1HAUV71oidMJY0h1mXvli2VAsuJ
 mkl4T/L5ULvQb6fCwsdae5ox3fKTOzrf2frDZM4=
X-Google-Smtp-Source: AGHT+IGm0Z/67eQotMRdBPa5dTnq+bKsWxznahSN9+D95i07/WGNqxgJPddjykZdzsOpIrsFqMRiHg==
X-Received: by 2002:a17:903:1ce:b0:1b8:88c5:2d2f with SMTP id
 e14-20020a17090301ce00b001b888c52d2fmr12125907plh.64.1691426233899; 
 Mon, 07 Aug 2023 09:37:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 08/14] linux-user: Do not adjust zero_bss for host
 page size
Date: Mon,  7 Aug 2023 09:36:59 -0700
Message-Id: <20230807163705.9848-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index 964b21f997..6c28cb70ef 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2213,44 +2213,36 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
 
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


