Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230B78F705
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp1-0006UL-NZ; Thu, 31 Aug 2023 22:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtoz-0006Ta-0d
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:41 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtow-0001OS-QD
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:40 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a9f87adfe1so972085b6e.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535017; x=1694139817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nu15p4NzoIMDD0853qBh0z3WcT+BzXtXp1Q+7rXZXJc=;
 b=gBMSqB8qCPdmtqqqRjYAma8NCDNIrVEiLMrg4VyZCymxR9Uu1iibRoKomoX9NnMcTN
 D/4ha1+wh1MHTDKXghPbLtWcEezhyHEIVJ/Zz9PZoUusw3GB/S+w9VMHxoLjHO3xwSN+
 HXFV/tASdE2FzAXL0fr9z25MSxL034jSIdZO022hiYiLNXYwdb3CbKcQr7jnUOcTM+Ck
 ZayDW/5JAzdkSTuMWQ+yip9XuSKXnu1EiGW310pfubngtO5QpMbhyild54NEYOKXuz3Z
 Os/trERIu49InuI0rzIy2PtCsr8pnAhMAl13jY3fLotxGdB+pj/pEWnnAPN8sGtC2qLw
 4TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535017; x=1694139817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nu15p4NzoIMDD0853qBh0z3WcT+BzXtXp1Q+7rXZXJc=;
 b=FFLbaTKkD+ADQNwuf+JrjjzmJEVQMI7/rT40R727YpVX60B9GlDVAhYxc/Jui9Z2Ob
 Rw2tjXCKiygVMrjTDR6Kucrt8rcBkJBaeYA1W8ng0OADzpATmDsxU9C/u+Hzs38uSbQv
 5SYiiQu8R0q+fSuUeeeHMoOuIdYMtPq7u8gWA3Q6bqDNIHRjgTEGT3ssqsAMCk1tSWHz
 e/P5F3BHlYWQ/JR+4uOVxJASXBZxGd1VZuuObmlIkUqbBdFUQMc5eXQ3mMAs/y1pLr7K
 92P4BXJxfAzBw9IWtU68rRFsOhVqfPlOkwEFRYcansFzyX6awR1PXjXbLNtQt2tTbjW9
 wj3Q==
X-Gm-Message-State: AOJu0Yy/cxDSDQVakYxbxP4xDH2eELvhZnBTKUnkKChfirqGo78Xb6A1
 YRXHEGeI2r5lpLDb//ZGpGtzNOMw8VDnSbWa6JI=
X-Google-Smtp-Source: AGHT+IEPmheF9MfC0qMGWLitBk3CRaLMh4KHpjQBCvPh9/r/outUT/f4y93ExGoNRG/NKG/Y6T1A6Q==
X-Received: by 2002:a05:6808:612:b0:3a7:d857:c588 with SMTP id
 y18-20020a056808061200b003a7d857c588mr1291720oih.2.1693535017481; 
 Thu, 31 Aug 2023 19:23:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 06/33] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Thu, 31 Aug 2023 19:23:04 -0700
Message-Id: <20230901022331.115247-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
If !reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 939c9b4df1..025747a15c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1355,10 +1355,14 @@ static bool init_guest_commpage(void)
                  0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
     };
 
-    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    int host_page_size = qemu_real_host_page_size();
+    void *want, *addr;
 
+    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
         exit(EXIT_FAILURE);
@@ -1367,9 +1371,9 @@ static bool init_guest_commpage(void)
         return false;
     }
 
-    memcpy(addr, kuser_page, sizeof(kuser_page));
+    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


