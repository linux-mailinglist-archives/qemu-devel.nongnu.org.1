Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8287E3375
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COF-0006M2-SU; Mon, 06 Nov 2023 22:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO1-0006KZ-1T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:17 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNx-0000dF-4o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:16 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso41529965ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326252; x=1699931052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YyJfb6Wojnqq08dXxiqAELvXf9aCz7pqkYhEssz6d0I=;
 b=pSBZ7yDZ5JOm28NqFlnRPzsnCPK1R2amZqwZLm0NoOHP45FS7mLmEcA+cGtcxa3src
 3z2Cvyya8s+CKES97BYejd6sqFvAvcHcOQFJ3dBf/SgCQBIlXpMTJtBvoAAatUfJc9yL
 irGjRNJHMVPzM2ovpo8HiCMMzWqAF3QK+aU8lp0yaF9WjGVEh3HWpRCYFxLFrpqCQ0Yz
 wcMpZJQIQlhvittE2IP0obr2WkmFKaZyz6BfLc6qqUwCAPukz/VPyfWNe2PA3uGZHXoR
 UMadnwrtK613qQqTbFGFdyof+jMEtNxDjgQdtxeUOEps86fpfcd2APJvu7n5vkAKMYie
 HCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326252; x=1699931052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyJfb6Wojnqq08dXxiqAELvXf9aCz7pqkYhEssz6d0I=;
 b=LZ0AtNZHnjQ5w4b4l4bHMOJsdtSX3MS6IXGVd3wZ74iZsfFJMUZQoTjYT3FHHRyZ7t
 TgmDjfh1VsrZmiGppAjO5821QdMUUGnNsHcJrRKeo/7r56jCwmMuxGnPQ+ju2l2ee8g7
 xWoi6cEFhfuG1aF8iNjt/3q9V6V8qWpHkW1XcOHa25hFe/PELugnlC09zpYQ6w5w09PN
 rGV13807V370sFmXwBbq/cYBBxn9t1oKEKRZSoJyyoRD8dNpNsA/oHjW8RUl6c2iAQ/U
 L3DFvNsacL2YpbO9Y53p3Bvhf3VopRaz4rklCbDAsG4IQpS6ZTx0ekONFFMd2nHakJVu
 OZmg==
X-Gm-Message-State: AOJu0YwBnSOmV9C6Mp+a6RnfKHTidpwpsu2To6IZqhnS+zlpLLOjXiBK
 ++AjYARAHgmNICwi93HtVwqS6EQRI6Ddy8edf8E=
X-Google-Smtp-Source: AGHT+IG5NV+BPQsmdDWf36mLVLVXo8XLPUzOmfeo7IuA2qy0LeMOqvUVvJU+Dbr3MNoM9xe/8d1zyQ==
X-Received: by 2002:a17:903:41c6:b0:1c9:9fa6:ce5b with SMTP id
 u6-20020a17090341c600b001c99fa6ce5bmr1846947ple.16.1699326251827; 
 Mon, 06 Nov 2023 19:04:11 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/85] target/hppa: Always report one page to tlb_set_page
Date: Mon,  6 Nov 2023 19:02:46 -0800
Message-Id: <20231107030407.8979-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

No need to trigger the large_page_mask code unnecessarily.
Drop the now unused HPPATLBEntry.page_size field.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  5 +++--
 target/hppa/mem_helper.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 84bb6edc60..1480d0237a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -179,15 +179,16 @@ typedef struct HPPATLBEntry {
     IntervalTreeNode itree;
 
     target_ureg pa;
+
+    unsigned entry_valid : 1;
+
     unsigned u : 1;
     unsigned t : 1;
     unsigned d : 1;
     unsigned b : 1;
-    unsigned page_size : 4;
     unsigned ar_type : 3;
     unsigned ar_pl1 : 2;
     unsigned ar_pl2 : 2;
-    unsigned entry_valid : 1;
     unsigned access_id : 16;
 } HPPATLBEntry;
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 687ae44ed0..60cae646cc 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -268,9 +268,16 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 
     trace_hppa_tlb_fill_success(env, addr & TARGET_PAGE_MASK,
                                 phys & TARGET_PAGE_MASK, size, type, mmu_idx);
-    /* Success!  Store the translation into the QEMU TLB.  */
+
+    /*
+     * Success!  Store the translation into the QEMU TLB.
+     * Note that we always install a single-page entry, because that
+     * is what works best with softmmu -- anything else will trigger
+     * the large page protection mask.  We do not require this,
+     * because we record the large page here in the hppa tlb.
+     */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-                 prot, mmu_idx, TARGET_PAGE_SIZE << (ent ? 2 * ent->page_size : 0));
+                 prot, mmu_idx, TARGET_PAGE_SIZE);
     return true;
 }
 
-- 
2.34.1


