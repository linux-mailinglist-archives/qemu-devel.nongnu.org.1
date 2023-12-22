Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E43FE81CE3E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:01:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjon-0001xm-HU; Fri, 22 Dec 2023 13:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoj-0001wG-PT
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjog-0004Dn-Os
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7s0jK6bJNAtHzGSokaJe99gGv+xpwRRzeLCVxiueTc4=;
 b=Hlsax4nzpOLC1OJvIZ29QddgPAYspN5gUVjzoNzerDpKI1sPenSua20JpaZl/K3mt1WIqG
 L9ihHDNZwKXP+sYsgNYKOerhKRPf/TNhxUF9RXJk6+3czJIJ8GX79pegaescS4FbkT8H6b
 RKw9H9s4tJA/DVA3bcDmtRy7+Xb+dYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-TEIn5oLzNGmlQ0e_ZPN7pg-1; Fri, 22 Dec 2023 13:00:07 -0500
X-MC-Unique: TEIn5oLzNGmlQ0e_ZPN7pg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d37517936so16548645e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268006; x=1703872806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7s0jK6bJNAtHzGSokaJe99gGv+xpwRRzeLCVxiueTc4=;
 b=bUYAWctjEf72om2JyCSMR36hikc1Grej9N1kHAUhiWjm8oSyPnTI9/05yJy3uhkY6Q
 FIlgMukvv0epDdd+h0Dm33a5brTC+Rq8WYOtCTEidxBDBi/V+x0vjw6qxYNdjAXuximc
 7VE36leiA9/aR6CyfEQg2Qr52Tqm8A1kJNZQwIwU/iW5J5qW/0d5CaywldYKE5Gjr+0N
 ED0PacgWRf09kxK2x6zXQ2jn7nPTeSDqI/JaYhfXncJ+VyTjAfX7k3+2p9AcfFD0pktO
 ZYyc2i4nImCdhLbeEdWQ+cGuNbCverK6BRlOw9hXKxqFKBiDCsG4+lR35NXKJTAhOz48
 8JDQ==
X-Gm-Message-State: AOJu0Yy6DedYb+wwfgenLWZBkthZFgb7Bx24SgyeqTmU6p8z2TZdnQtz
 1e1563aYWDdL8/Fy6b+n8/b6RQz6ebPLFHSUT6e+2xi085Sm/lRpXwmutu+Q0QAyvvsdpjulYC/
 0IPYj6pU+g6srSrtLzp205Ca+oCktzSwSV5vaetLjsihQGVjxG7gzLs4fUeplkPBkDdmQtJRMcb
 kRiNpnRBw=
X-Received: by 2002:a05:600c:3513:b0:40c:36ff:7507 with SMTP id
 h19-20020a05600c351300b0040c36ff7507mr956759wmq.70.1703268005773; 
 Fri, 22 Dec 2023 10:00:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnPlrzjC4T9n9wHkzQPrqjb6Ma1wDQvcDH9VNQ+2R7Te3W+yTxgANKJtn3FFKTk00M7Bc6RQ==
X-Received: by 2002:a05:600c:3513:b0:40c:36ff:7507 with SMTP id
 h19-20020a05600c351300b0040c36ff7507mr956748wmq.70.1703268005417; 
 Fri, 22 Dec 2023 10:00:05 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c001100b0040d44dcf233sm3087189wmc.12.2023.12.22.10.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:00:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org,
	qemu-stable@nongnu.org
Subject: [PATCH 4/5] target/i386: remove unnecessary/wrong application of the
 A20 mask
Date: Fri, 22 Dec 2023 18:59:50 +0100
Message-ID: <20231222175951.172669-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222175951.172669-1-pbonzini@redhat.com>
References: <20231222175951.172669-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If ptw_translate() does a MMU_PHYS_IDX access, the A20 mask is already
applied in get_physical_address(), which is called via probe_access_full()
and x86_cpu_tlb_fill().

If ptw_translate() on the other hand does a MMU_NESTED_IDX access,
the A20 mask must not be applied to the address that is looked up in
the nested page tables; it must be applied only *while* looking up NPT
entries.

Therefore, we can remove A20 masking from the computation of the page
table entry's address, and let get_physical_address() or mmu_translate()
apply it when they know they are returning a host-physical address.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index eee1af52710..ede8ba6b80e 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -164,8 +164,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = ((in->cr3 & ~0xfff) +
-                            (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
+                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
@@ -189,8 +188,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 4
              */
-            pte_addr = ((pte & PG_ADDRESS_MASK) +
-                        (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -210,8 +208,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((pte & PG_ADDRESS_MASK) +
-                        (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
+            pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -238,7 +235,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -260,8 +257,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((pte & PG_ADDRESS_MASK) +
-                    (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -287,8 +283,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 1
          */
-        pte_addr = ((pte & PG_ADDRESS_MASK) +
-                    (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
+        pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -306,7 +301,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
@@ -335,7 +330,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 1
          */
-        pte_addr = ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_mask;
+        pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.43.0


