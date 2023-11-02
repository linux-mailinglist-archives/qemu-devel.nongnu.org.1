Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40457DEA55
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:45:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXg-0005eU-Tx; Wed, 01 Nov 2023 21:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXY-0005Ur-EA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:32 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001SP-8s
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:31 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2ea7cca04so261083b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888622; x=1699493422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ez2Z78a8l3Rct3xuqmIfMNHaaKAnGMRqCCq6D0MIJeY=;
 b=DhzL42zmJgVmEruVEx3Go8xFh98hTOBMBjdz0tmL8UTMxccejpVDrK/qw7snmj+4y0
 HeXCDRIbIOkAzqUdELSB0L750ycqg4F3Q/dIulT/Cs1YLg2HeIIJVCP5N1Ueo4uUaAV3
 aduMNJaUToiEJ6fXHqeqQVgjghvgn96+FhvkkmJELn09Rfjhe0lK1tWJdjrq7LSdeK1Q
 V6mGUh7dgef4L/4mLPitfK9TLcZ67trkp3FhMXyOdeId2XM1mtKGBScz+CFhP/0QcMhr
 br7ugA2O0ZtDI81Kju00Ydr6CGucfbQGHdgvTs+Xn+WcESBfYlrksmfIv5TpKdEnxWov
 XLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888622; x=1699493422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ez2Z78a8l3Rct3xuqmIfMNHaaKAnGMRqCCq6D0MIJeY=;
 b=ea4ZyhT5psv9q8lfyp7nDu4CCGfYLmtz9b8cxMOudIsdQYTsEVHRgWx9nPTyoqQs1G
 IyScYV0PJBOD/lOTByXci6RHy53eQASrEWQRw3CMP7+v7E+VIn2YjLOWqpBYj3q8wuJU
 /vHw+6M4ELOrvVgV54yobgu2D+iEulCT+SrbAzbTf0kvktsGFBRHPponpZ796EB4f19Q
 Xms4TcBt46jPUJyeQQkOOqYnbuxP0Wfqmr1QpGq6u+XG3J7Oaac3xuT+O7nW8s0+/89S
 xF1zL1fB7RAU07TgfMHJTSZI5auIt+CdWvFweSza2g8of527QjbcqdDK3cYZrK0s4bqn
 ZLuw==
X-Gm-Message-State: AOJu0YxCBA54XAsfIM+9VH7BLOdTeWrTCj+7ODwRPl7b2EF7fofO2EvH
 4CaFqU5gmEn1zutoyTiwNkQjTWoPbsRPqDRU+OI=
X-Google-Smtp-Source: AGHT+IER4+4l2k68R2KVqPQ691uQYFeQPVBoclzg0adMP869+05qMtTyq7JQBxMybnak7nCW5RDlKA==
X-Received: by 2002:a05:6808:bc6:b0:3b2:ec66:d868 with SMTP id
 o6-20020a0568080bc600b003b2ec66d868mr22524295oik.41.1698888621865; 
 Wed, 01 Nov 2023 18:30:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 05/88] target/hppa: Split out hppa_flush_tlb_range
Date: Wed,  1 Nov 2023 18:28:53 -0700
Message-Id: <20231102013016.369010-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 60cae646cc..828cceb29c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -67,6 +67,25 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
     ent->itree.start = -1;
 }
 
+static HPPATLBEntry *hppa_flush_tlb_range(CPUHPPAState *env,
+                                          vaddr va_b, vaddr va_e)
+{
+    HPPATLBEntry *empty = NULL;
+
+    /* Zap any old entries covering ADDR; notice empty entries on the way.  */
+    for (int i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
+        HPPATLBEntry *ent = &env->tlb[i];
+
+        if (!ent->entry_valid) {
+            empty = ent;
+        } else if (va_e >= ent->itree.start && va_b <= ent->itree.last) {
+            hppa_flush_tlb_ent(env, ent, false);
+            empty = ent;
+        }
+    }
+    return empty;
+}
+
 static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
     HPPATLBEntry *ent;
@@ -284,21 +303,11 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    HPPATLBEntry *empty = NULL;
-    int i;
+    HPPATLBEntry *empty;
 
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
-    for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
-        HPPATLBEntry *ent = &env->tlb[i];
-        if (ent->itree.start <= addr && addr <= ent->itree.last) {
-            if (ent->entry_valid) {
-                hppa_flush_tlb_ent(env, ent, false);
-            }
-            if (!empty) {
-                empty = ent;
-            }
-        }
-    }
+    addr &= TARGET_PAGE_MASK;
+    empty = hppa_flush_tlb_range(env, addr, addr + TARGET_PAGE_SIZE - 1);
 
     /* If we didn't see an empty entry, evict one.  */
     if (empty == NULL) {
@@ -306,8 +315,8 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     }
 
     /* Note that empty->entry_valid == 0 already.  */
-    empty->itree.start = addr & TARGET_PAGE_MASK;
-    empty->itree.last = empty->itree.start + TARGET_PAGE_SIZE - 1;
+    empty->itree.start = addr;
+    empty->itree.last = addr + TARGET_PAGE_SIZE - 1;
     empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
     trace_hppa_tlb_itlba(env, empty, empty->itree.start,
                          empty->itree.last, empty->pa);
-- 
2.34.1


