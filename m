Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045A7A2DC4
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM15-000646-KE; Fri, 15 Sep 2023 23:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM12-00062t-6I
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM10-00084E-II
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso2611285b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835037; x=1695439837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfL9tsiO63q76WeotUMTf97+/PGlHSdV7QTLkU9d9lQ=;
 b=ppFVV7KhBaNqSSWD7p0oqv+MWOn/kbtW4EffH7bcRNMjcfGtLHHFECu8ZQo6Cdq0yI
 dXXlXVa6zZ+LYdMF7qAvM54H+7bjKGTPe9ek8jrwdEYkOVMmLK+6MrTUQYha26xjj2OT
 3L5BSnhRHx6aSNkyUlFJBRmsuGulSZLEA2ZhULYmnL0Sz8y8K6schbbcaPfCjQxTsjck
 IwKp0AG8UJQ2vRDSph9CpCeuJSDc5b2fSWqn/9XWHPq750iOn1VfnJ9cua7W8DKdosDa
 I91ZO/qJEY53o+bRzMggfe96W63uVchrwsPCgxYE6zm596FNLw/lcF8VrolqeAHTRxhN
 xbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835037; x=1695439837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfL9tsiO63q76WeotUMTf97+/PGlHSdV7QTLkU9d9lQ=;
 b=f/Vp2XCsjkLrqcYDH1EcRG+G4OzVSBscxV9rujkAcj0a0n7SS4GtgVj6Vx3Xp5g/29
 3y7iKVY7Io8fZb1iLbpry9MN4MTeQQkM/RBynVK3EwR1LLobuwl56QFTC6zCvsjttihF
 LUHReMIwZiJtX9HpBS7vQY7OeaetRRfxbNFJKS+z5UlewUttcZjokKFLuexGzuIGxbT8
 qCwthD1cu8Wmn/OHGd+T7Rqpj4A45/hOCVUIN8klEtCsJSNjwGl8AKSGpgYaj0t3TZW8
 OQJwcRHk5ocrHh5nkraJ0/ajMhfHf0oS53601E6qaT/7EvuKWK76uRb7ULla7RiSvjeD
 C/Gw==
X-Gm-Message-State: AOJu0Yx8CX0GDXGtfI8UNEfjpIZDGe1jOBZGV3FJMpm8u4Z13iJYwIXt
 7T10zE7H0A+u2CYqAD228HS4AcDPRVImJH9TrL4=
X-Google-Smtp-Source: AGHT+IEEpZFX9rWalx/Cv6E23LMfTFWCQIzsrMJFy9ROzqxz/yIc+elLxFbeg9buq8v0XJEd2FTVCA==
X-Received: by 2002:a05:6a00:2484:b0:68c:70f:ee3f with SMTP id
 c4-20020a056a00248400b0068c070fee3fmr4258627pfv.13.1694835037199; 
 Fri, 15 Sep 2023 20:30:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/39] accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
Date: Fri, 15 Sep 2023 20:29:58 -0700
Message-Id: <20230916033011.479144-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ae4ad591fe..a46be6a120 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1388,13 +1388,9 @@ io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
 
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
@@ -1420,7 +1416,7 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
 
     if (r != MEMTX_OK) {
         io_failed(env, full, addr, memop_size(op), access_type, mmu_idx,
-                  r, retaddr, section, mr_offset);
+                  r, retaddr);
     }
     return val;
 }
@@ -1445,7 +1441,7 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
 
     if (r != MEMTX_OK) {
         io_failed(env, full, addr, memop_size(op), MMU_DATA_STORE, mmu_idx,
-                  r, retaddr, section, mr_offset);
+                  r, retaddr);
     }
 }
 
-- 
2.34.1


