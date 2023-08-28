Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE678B7B2
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:58:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP6-0000pP-Jq; Mon, 28 Aug 2023 14:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP4-0000p1-R3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP2-0002RV-Hk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-564b8e60ce9so1664984a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248955; x=1693853755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXC5tTcUi0lmpfhMw90VKckGWB1iYRWY7/22QuukN5Y=;
 b=Kd1cLMLDbJlPQlmcLcuLYjtkG7ROMUJoSVcjc1Y2yY5ZivWdgP8FQHmF9bOonW8V/I
 J3mTuwSYQdYiU0uXQ9XowQI1ar6WrwLCtrAW/HJhlfEqfsCyB8QKztt7fnuoKYgDDs/O
 nq7jao+hCs/DKd4gHQosqLRrouZHv5QzCJNf3Rh90S8kAxXBLNg1gV0k9rGpYBzVBQWZ
 RQfvulioYJmPjzISsCbsKxhYgwofAgx5wfKRNxwEW3KYhqXB1iUhmoD+/FATUmHYvFYb
 MPFdODnk+sJO841ANvbNzh0EgbQACY1Pfi5c7BnCFT1SdTqWjzKXGF4Up9M8qQgkMxAZ
 0MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248955; x=1693853755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXC5tTcUi0lmpfhMw90VKckGWB1iYRWY7/22QuukN5Y=;
 b=XV7TAwt8+0WYiha2uY8rSibtFhaQ3P2ALFGZs05gRkqOVyd8igikFvt9Uxj2j/RjM0
 tscKccj+TWp8iWtHXWzlHxYssyxNGIwHp9O+sGi2liACoLixtro6ujJ4KKD+dxBjzu61
 rgTp77EzZ9Mx1HNACDsJra37DzCNNEpkJawDxDC9OGGYh18v9dPZnR9QUoTCNzF/ofJj
 0P7J8di2lLj8YKh4CbyaphwAosyQ8aWGCZx8WYAZRROoQORgt5NaoOG5DGHvy9uoX/tw
 VoV4j3iLy436jo28rX8yz0KPxtqChNnAwCQWYVX//OWFr9aajz0MqsXvcSFrABR8sF5a
 ZzJQ==
X-Gm-Message-State: AOJu0Ywf7/Nml3O7ZqL4TvGrhPswdif5Y19EMHESyGBHY/pfkLOCkYMB
 rOh7VVBMs6ZFqcTOWN8nS4YfmzaSh56oV8sQU8o=
X-Google-Smtp-Source: AGHT+IGgaSz+6lEpxa/DVXUokG50CdASoPWkhsEva/eVzM8g5bSfCuArgQo/dmi7sAPc+LTiAVBCyg==
X-Received: by 2002:a17:90a:2f47:b0:268:fc26:73a9 with SMTP id
 s65-20020a17090a2f4700b00268fc2673a9mr19645961pjd.40.1693248955001; 
 Mon, 28 Aug 2023 11:55:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 03/10] accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
Date: Mon, 28 Aug 2023 11:55:43 -0700
Message-Id: <20230828185550.573653-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Since the introduction of CPUTLBEntryFull, we can recover
the full cpu address space physical address without having
to examine the MemoryRegionSection.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 17987f74e5..fd6c956214 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1385,13 +1385,9 @@ io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
 
 static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
-                      MemTxResult response, uintptr_t retaddr,
-                      MemoryRegionSection *section, hwaddr mr_offset)
+                      MemTxResult response, uintptr_t retaddr)
 {
-    hwaddr physaddr = (mr_offset +
-                       section->offset_within_address_space -
-                       section->offset_within_region);
-
+    hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
     cpu_transaction_failed(env_cpu(env), physaddr, addr, size, access_type,
                            mmu_idx, full->attrs, response, retaddr);
 }
@@ -1417,7 +1413,7 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
 
     if (r != MEMTX_OK) {
         io_failed(env, full, addr, memop_size(op), access_type, mmu_idx,
-                  r, retaddr, section, mr_offset);
+                  r, retaddr);
     }
     return val;
 }
@@ -1442,7 +1438,7 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
 
     if (r != MEMTX_OK) {
         io_failed(env, full, addr, memop_size(op), MMU_DATA_STORE, mmu_idx,
-                  r, retaddr, section, mr_offset);
+                  r, retaddr);
     }
 }
 
-- 
2.34.1


