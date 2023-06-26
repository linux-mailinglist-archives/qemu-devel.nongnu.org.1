Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A264373E3CD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKc-0000wT-MV; Mon, 26 Jun 2023 11:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0000Ig-NB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJm-0002qK-Ab
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3112c11fdc9so2961150f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793992; x=1690385992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2+Hm6IjSv/mwZjS2+GOqKio9bezVgYj0L4FRTARgNA=;
 b=hGILxFjwJtIhseih/uysF5RsAegiGk1RBOFlnldVg1vk4yclWbTrsPBq/oz0KZjoyo
 XsTu1JtC5bfxjQ6VSvQZ1TwItJvoPsny/wUVU1N9alHNyaBJiPlQqmYHsh9oaa61jtl9
 kMRx7d/kpUFTEgm2cR5y/usl03lZd3ABXE9W757pIAAWBbndUUn+ymve2jvyuF/uR/45
 AgNjFU23U2lXyZ5scwMX/c5O0eVLqJxhqD2B8dHXELSwKExVhTj3yIpZYPAPIgoHFtiH
 JrbDcqXF3DvLOkWImIVoOP9iH2ONaTQUXwzbLQ9TuzIfEFXd/a01b078QwVsut21gb+B
 1zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793992; x=1690385992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2+Hm6IjSv/mwZjS2+GOqKio9bezVgYj0L4FRTARgNA=;
 b=HrGjNR0qML6jXZKOoY5YlVU+Iwt+c+Gf6ZdETTjGPViw7H0bR6CFYHzMMRDGfVq+hY
 rv7LsFwopR8rgAT/hMDo39459BIe366kXWIwTr36L3aYpY6r2hvxM4IFjc5ux4/qnVgL
 +0bhuFWGDCDRE8cj3LjBrFeO9RRYyQDe3V85PRLkEgAY9chABCYJcwa3IJjxtzKcD3VT
 tnGioydhK5GYtYAy0eOu0gqE7lltlWw3z3Obfm1ybnIe5jghyTdGsg0JXV0P7ShwkFTA
 qprNETAQFPms983yHhuX6dkJ2/zLupf++h2nyd2/Bf8BDwWmWWKrjPJqyOUBdw0Wc7oG
 akhQ==
X-Gm-Message-State: AC+VfDzTEDntXgZMl7jolGFyVYU4M5KvA7jTrTA0i6FwNEBYh7ysKwdM
 7b7+IbvfjzxqSjKGqe+ViviVwKPzfe3VKoJ/dIXcXzu8
X-Google-Smtp-Source: ACHHUZ67BvjBqUa5POOew411goDjPj+13nrkX6pEJ5gsBN4WUM1c8ksz4JF9uqF1jAqCHqT0gKuDlQ==
X-Received: by 2002:adf:ec45:0:b0:30f:c9f5:7370 with SMTP id
 w5-20020adfec45000000b0030fc9f57370mr9754314wrn.25.1687793992077; 
 Mon, 26 Jun 2023 08:39:52 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 09/22] accel/tcg: Replace target_ulong with vaddr in
 *_mmu_lookup()
Date: Mon, 26 Jun 2023 17:39:32 +0200
Message-Id: <20230626153945.76180-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

From: Anton Johansson <anjo@rev.ng>

Update atomic_mmu_lookup() and cpu_mmu_lookup() to take the guest
virtual address as a vaddr instead of a target_ulong.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-10-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c    | 6 +++---
 accel/tcg/user-exec.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d873e58a5d..e02cfc550e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1898,15 +1898,15 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
  * Probe for an atomic operation.  Do not allow unaligned operations,
  * or io operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               MemOpIdx oi, int size, uintptr_t retaddr)
+static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+                               int size, uintptr_t retaddr)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
     uintptr_t index;
     CPUTLBEntry *tlbe;
-    target_ulong tlb_addr;
+    vaddr tlb_addr;
     void *hostaddr;
     CPUTLBEntryFull *full;
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d71e26a7b5..f8b16d6ab8 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -889,7 +889,7 @@ void page_reset_target_data(target_ulong start, target_ulong last) { }
 
 /* The softmmu versions of these helpers are in cputlb.c.  */
 
-static void *cpu_mmu_lookup(CPUArchState *env, abi_ptr addr,
+static void *cpu_mmu_lookup(CPUArchState *env, vaddr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
 {
     int a_bits = get_alignment_bits(mop);
@@ -1324,8 +1324,8 @@ uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
 /*
  * Do not allow unaligned operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               MemOpIdx oi, int size, uintptr_t retaddr)
+static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
+                               int size, uintptr_t retaddr)
 {
     MemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
-- 
2.34.1


