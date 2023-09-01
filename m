Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D453C78F701
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp0-0006Tw-4D; Thu, 31 Aug 2023 22:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtoy-0006T9-6X
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:40 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtov-0001OE-Tv
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a41035828so1182246b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535016; x=1694139816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3P9EWl1tJVitUp2HhYjFwCQR4+GDFyi+Ud4oCYb+o1w=;
 b=B/oA+yTs3oM6YKSyum0INh9zx8bBLMRuuL3+qa40XYle9TdovYY/CsGO6EfNHv8YHD
 beK4afvtISr2ElNhk+krN20aRjPiEjaWz53N+aM9InqMqTW/Th10II3akXBNWlJMJn2C
 jDaFHKI7ART9ds/vOrUQ3qBR3QBLfgTXpJhsZmiF1BPozRFkJBF92sKH/GClwvptILOg
 o1gVaEqw9ENiC4SrOA7yPoUvy63VbUkl/075dA8QHQzOc2aOIT5fMU3DQNqvtBl3AjZL
 eKKYwzA/3HDKsv6LNJCHyJpfoNakA0EnnlNY34cJQMCmIFeoMH0n0bWytx+cFAOMI5sr
 x2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535016; x=1694139816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3P9EWl1tJVitUp2HhYjFwCQR4+GDFyi+Ud4oCYb+o1w=;
 b=j19lQGHYq6eccR4wAWRP8BF7xfN/69UZgOtz+/opc04UYnmBqUY9gsKgBjZAckaZ9x
 yqRAYVVNG5X0auY8lQy2eHvz1EFAjm0Op2nAaScSC0Eh3L8ijcRABeavWGj8eQDo/vUa
 jTQuqXUQ5euk8FUlZxUusnpqC6iIFVV87yVPSKKlu1JJzlsbYqEun9BUxRGWACrL2Mcl
 sTFLogwaZj5RUT+1/EZeoyggqA4WZ9BSN+StLL4sy+hKEBursHhRD0XJ4tHKsDPyriNg
 xjmeBVMazNJ2Ysa0dNApbKoqYI31pa65a3R3JzqqhTaDLA1rNPbiIPBLY1NC7vfXpuT4
 mlBQ==
X-Gm-Message-State: AOJu0Yyd/q8J3K1mFfOX4XU/b961kbgyWWjvWW0tHO9z590yWRmXqGAV
 54YOKCxHC+xnSuMnjSfQusjEm71bWZ0kyvhuxD8=
X-Google-Smtp-Source: AGHT+IEVEcEjOMSFnapwxf/hgd2mTaEqdPYEiqRuqyrWmRx8i4VEPp95mrT44AgBlzUuSJ+lKLgenQ==
X-Received: by 2002:a05:6a00:848:b0:68c:478:de31 with SMTP id
 q8-20020a056a00084800b0068c0478de31mr1581083pfk.12.1693535016518; 
 Thu, 31 Aug 2023 19:23:36 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 05/33] linux-user/hppa: Simplify init_guest_commpage
Date: Thu, 31 Aug 2023 19:23:03 -0700
Message-Id: <20230901022331.115247-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 885566c798..939c9b4df1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1812,16 +1812,21 @@ static inline void init_thread(struct target_pt_regs *regs,
 
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


