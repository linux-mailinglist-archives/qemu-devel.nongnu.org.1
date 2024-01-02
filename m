Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808A82164B
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU33-0003FU-31; Mon, 01 Jan 2024 20:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU30-0003FB-DK
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:26 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2y-0006zi-Vw
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:26 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-204a16df055so4590524fac.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160704; x=1704765504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=78dfRtxu5FZmtTcGt9x+K6ObYYej+Dd79lpS+g2uV20=;
 b=KoPkmBNn3fsTzzfZDDBD4glny9XDdl280EzeqRlta+qii6RVGKRu2WVo59pwr0vGLS
 TyguKSLoNiKXI0Zj0v7YxptX0FXycyZ/qAs1GVY2cZFYKX7KcKOkivlcKXODD5pnRSgR
 zxr51xGeDa/xSkiuRndef+WN2/iSb5GClkA/FS8a8borZNyqf/4qKWxWivWT29VIZQ3x
 ehJGQiqcmsaP7LPSHbElyHJz5utRwix0Nle4P0JIJ68Izm7GRjJhI7l5oJOhxDyOoztZ
 YF6FrRByE35gO7dcwO7Cx16FNIFoSaaMryZoEuCw5/3wdEINRVQKkcD4jjK478AA8cLP
 YyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160704; x=1704765504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78dfRtxu5FZmtTcGt9x+K6ObYYej+Dd79lpS+g2uV20=;
 b=qH1SS7e8mJ/mPH4sLG+fnOT/WPzIi57Lj1zzVXREl+2MrSCW2Qx+jyeRWVzljMusZI
 n1Cx5uqR1D/T7d6mTSAMApQHVQjUxjpDz1/nQJZG0uYmD0/z+KjHJtGiUpRQtDQUrpqa
 tJjUx7vQK2mfsOoWnYVeJpkvByjCCDBo+EGYMUTy4u+9o5UMeal5Ek8OfFM7O6PJSQex
 kZDLnFgODJ0+TdaMbYLT0sxJdDU+NuJYPyp+trR0+6dK/ko0RrEKAf4Bdh1wCuVHbnTH
 YM1m+unoZ5nqpG8qO50K7OGY5L8XrQ+ehpQwtE1TX3zy2gKwH58jnLMjeGBjBGXGMufd
 9HSg==
X-Gm-Message-State: AOJu0YwOSp3IYIE6odHEXqltDx2XhaGZa0yAie9SvTqD+xWEz8BfdjoM
 f0tAnKb0S5fzmYeGgcAx2z26+hb1OAcf9xsITQSHBiUTgTQ=
X-Google-Smtp-Source: AGHT+IEKcu6Oot8nb2g1mvV+10w5DCuNUI80lw1mQ+rZ3vv5cqmuKCdtRwqAtD8cWnFSaYjhfOL78Q==
X-Received: by 2002:a05:6870:558c:b0:1fb:e34:e31c with SMTP id
 qj12-20020a056870558c00b001fb0e34e31cmr21828007oac.37.1704160703516; 
 Mon, 01 Jan 2024 17:58:23 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/33] linux-user/hppa: Simplify init_guest_commpage
Date: Tue,  2 Jan 2024 12:57:40 +1100
Message-Id: <20240102015808.132373-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c166faabab..96d8d4f84c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1969,16 +1969,21 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 static bool init_guest_commpage(void)
 {
-    void *want = g2h_untagged(LO_COMMPAGE);
-    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        int host_page_size = qemu_real_host_page_size();
+        void *want, *addr;
 
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, host_page_size, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


