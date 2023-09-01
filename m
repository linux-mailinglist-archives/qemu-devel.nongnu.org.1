Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2978F70E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp5-0006Vj-34; Thu, 31 Aug 2023 22:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp1-0006UN-VH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtoz-0001Ol-8Z
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso1242457b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535018; x=1694139818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDM65t73LpAV7FxjJeTkMdvecmbGc18VHwUu48Q6+VY=;
 b=uo+K7wrCdKhpTjcOIeEC/ZXL5DbD1tokKmA+gfBO85bS9UiqfS9Wn3b883UrzX5jzU
 21aq+Hvjh0DNLPE4lGfN3ySZjDVBNHMu3WJfNy5yR4p6SOJdfYXIOHwe8HrmkZdsHsyP
 /+vlZYGkHbtVFjILiBTnaPWBftCOdmaddOqSHRSDPPMSFJvsfRX09BO8bohUJA81Xd7Q
 xthNrXJXM6HHSA58/9dToex85+DPOj04YUrt0XpqSwDt5t+//4ESNZpv0tC0/4c3pjcu
 vX3sNEQE61Jz6ZR53SwubruClD63Tb7kkx7+VlxVCRxOjNStN/h44W8R+Ek55jancgx1
 dw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535018; x=1694139818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDM65t73LpAV7FxjJeTkMdvecmbGc18VHwUu48Q6+VY=;
 b=jqjKaFjZxY76kda0yOR6Q8qcsW0VwiSHLcjqvD97zrowRt7vmAz1VrkImufIaTftDR
 G9nzVdZVF9bBJwdEaJrmPopZTniutUBxI7FLx8mEvjrQDuzenHya0oNdYWpKUdIy1ybc
 rDQD9527+nFbYP7wgldh0k9jWF2T2Wh8/7cUJJhsWAaad8vCwNGn5MRZc6SZF5u/zicd
 Z8GHgPCR5lOKHdV9umMR8psPEmWxRDHD1NFR4RbtYRMPxgH0S5O+GJo1aCUTnFVJYU9h
 4uNXtzVKlJn5Cm+gnA/h1DydC6qDwKjJCSbrhlrUN3qvEc3zqpDPxHH3o25XLOQnIbNj
 ZmCw==
X-Gm-Message-State: AOJu0Yw3miDhrHtJRbaSbjZD55rkmBwo8pIQuvw0vRPGiLKOH9I1KNdk
 yktvgeDI+RMkZo8Z+6Fi0AEcyoOX6RUaRNDqdjc=
X-Google-Smtp-Source: AGHT+IFqBUNjB+MAj0nYewPOfITbqmjroSiF9X/fm1P4yXg3bknp7m/NAndyLif+uIXF65lUb7UkUw==
X-Received: by 2002:a05:6a20:1605:b0:14e:b4d5:782d with SMTP id
 l5-20020a056a20160500b0014eb4d5782dmr1811145pzj.2.1693535018510; 
 Thu, 31 Aug 2023 19:23:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 07/33] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Thu, 31 Aug 2023 19:23:05 -0700
Message-Id: <20230901022331.115247-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index 025747a15c..a575e811d0 100644
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


