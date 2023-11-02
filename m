Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB187DEA05
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:31:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXj-0005ii-7B; Wed, 01 Nov 2023 21:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXZ-0005Xf-QV
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001Rd-8u
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c3077984e8so469183b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888621; x=1699493421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyJfb6Wojnqq08dXxiqAELvXf9aCz7pqkYhEssz6d0I=;
 b=XjU0JoYGg2opJ28XXYT32tKdiiLqZUWVsebbpCE973hdlT7o7S1bWGH9A7uVq0HUp2
 ToDlZUJt1Kz3JUQ757jK4qsJpYZtmu7VHVR1JDKziUmctKhqjuVfQYdaUcwCzt8zW8d+
 0HS/B5GV+B2K989jlmZgmam5YKjhvOqWK6DcmqHm6k5x2Z3gM/l3Pt/MlCI48GiQ9VuY
 1Qap6XUQZq7rSYbRwWHmNPKdLsmvE8a6Y1Z3qlDfUVniPeWAYOUWEmNJPXahJrV0lGkP
 286jYtoqQwlpXsU/tKpbGXmiju3uV9HSP1WT9JzEwZ0Z7OkZFawp3Eyqyh3odC0O4YNT
 xBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888621; x=1699493421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyJfb6Wojnqq08dXxiqAELvXf9aCz7pqkYhEssz6d0I=;
 b=CNeC+G2VVt1Pmj3wzLChyTHj4RUOEF5bpY0GQk3V/osUvGuO5ULtuXPJ3zO2oMeTXy
 hlHJUrd8EQDR82s6ll2nL0z9tflopcEfD+/rwmuainEe1BfMnfLLm+kG1KfaxswroCiG
 S2ZvGcHjQwLh3IBwd7UtUAuBth/HOvr02gsZATI5x2kS+PmVkZriRNufo5NZ2FUF32G1
 XVWHvr88pBHwH08PO5fskpKS9ODCUzOYThxB02MP02B5OCchNAsfqWgWSUUB+y5Z9wOD
 m15eUODTb1B0ekoTBOqdh7AiICAlVyGEQCp8Eoyq+xPWTEZgQgUbl9gU7IAqXnUw8lb/
 aetw==
X-Gm-Message-State: AOJu0YylzSeyEfilCSryUHkSBp5ckrxZUVQuRo2dZ2JnahPohySAk49C
 xkAHNbZFg1NFCnrbsp17cAlBhbsFN014mbbU49w=
X-Google-Smtp-Source: AGHT+IHpyMzlekhYaGVTn131tp/HNQ4ddwy6c1Ei/MlZCLshZv6qVfo8wbLUEs8OhEEoM+0AM0vfZg==
X-Received: by 2002:a05:6a00:1786:b0:6b6:1216:d8fe with SMTP id
 s6-20020a056a00178600b006b61216d8femr19527430pfg.27.1698888621029; 
 Wed, 01 Nov 2023 18:30:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 04/88] target/hppa: Always report one page to tlb_set_page
Date: Wed,  1 Nov 2023 18:28:52 -0700
Message-Id: <20231102013016.369010-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


