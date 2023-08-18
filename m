Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40197781158
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31g-0008D8-Fj; Fri, 18 Aug 2023 13:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31e-0008CS-95
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31c-00080y-3n
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bda9207132so9550945ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378759; x=1692983559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7lc224yrZVrBl3W27R2ZX5OKeL2AGXuP1h02TB+QfsM=;
 b=HEbAU7yaoELpANIbWTTid3lkIvGx/UFYBCy9we7cUmYb5FshFV4wDrtyGpAEWiGTer
 SSFKza2nqZ/7wjUyVi9dIesBdEa9qgcnqHhrVp6eUolgSZNYbdZuBhl5dupftaHdIgz7
 P5vlA4FWrPe2Z47zD5vIVvnDRUWlS0mslMHIGIXgn58D+Br5fYWnCS2Qm2VtBY1i3PLo
 RRk13yF8yJ6wEBKvuyC/WikXKeeauTCSCIrcwMvGXbcHcWU+ZitH1olRN2s0nWZyTj6C
 f/AVLfOA7RAOlIpO3Rr4Tn5hJotvCgkjf5B/MtVjm/H87yDO0miTRhSNopB4TRryFWgU
 gqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378759; x=1692983559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lc224yrZVrBl3W27R2ZX5OKeL2AGXuP1h02TB+QfsM=;
 b=WUnW6/zDv7obHfEFfHjaZACzJpCk6448Bat037E2NH/KyERPJGpOAACluuu7S3xKXr
 UrlzT3n93O5CDeF/jjW3eB9sBrO7xU+RJIrPP3P4w3hAgK28dmr5WYKFCGCvvGeZSH6M
 4uyRpitWbNu0Iku4QGjtZ5dJf07RP9Wd4mjI0zL8CkEf+tWURVOy8Wm66tpDayLJg9a7
 VRU8rP9SyPL2DwjrH/Ttz+dtsa1ojOzzrHezadJpMgqeAiz7U5PQ1959OkejmTV0mS2H
 EPfd17EEnvtfdoFbeEMcL3LHA5D6/KJ240XSSoFbPZFM5jeY2vTseYqcPJ2ZEdNduuYJ
 eYNA==
X-Gm-Message-State: AOJu0Yx61vg64CKixQODj8qwbS+5DKOYZfZA+fN/Fg6t4yC68oBRcAW1
 ECjawCmKGWeHLRnOK6XV2Iz19iKYuFL7dnFeftg=
X-Google-Smtp-Source: AGHT+IHeam0HlLFIJRKmzhTLd+Cuv7pOZjCJCLe5UAiuMDoVOtCYxsMKdLz3aM+fuMsmGB4ykd8PVA==
X-Received: by 2002:a17:902:d507:b0:1b8:8223:8bdd with SMTP id
 b7-20020a170902d50700b001b882238bddmr3009052plg.59.1692378758668; 
 Fri, 18 Aug 2023 10:12:38 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/33] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Fri, 18 Aug 2023 10:12:01 -0700
Message-Id: <20230818171227.141728-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use qemu_real_host_page_size.
If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b3b9232955..7963081cd1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -450,6 +450,7 @@ enum {
 static bool init_guest_commpage(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
+    int host_page_size = qemu_real_host_page_size();
     abi_ptr commpage;
     void *want;
     void *addr;
@@ -462,10 +463,12 @@ static bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    commpage = HI_COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
-    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -478,12 +481,12 @@ static bool init_guest_commpage(void)
     /* Set kernel helper versions; rest of page is 0.  */
     __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
 
-    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
+    page_set_flags(commpage, commpage | (host_page_size - 1),
                    PAGE_READ | PAGE_EXEC | PAGE_VALID);
     return true;
 }
-- 
2.34.1


