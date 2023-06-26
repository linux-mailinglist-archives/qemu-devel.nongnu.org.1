Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02773E3B8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoK2-0000IS-QJ; Mon, 26 Jun 2023 11:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJn-0000Gm-RA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002oI-Ki
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f58d6652so810884f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793991; x=1690385991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv3gPH6s0OE3PjFPgTi8pMQisc8pYxjYjhVnRHERxkM=;
 b=eTQucsj4gU+DI+WKrTP0xa7hB2fAmZ7TmmLODDcs/OCW55DGiCT0WYsyQD6DDbDlWZ
 sdzXuXawbuXRlSKgMuKPAopn5S96Z+Oovskq2ouQI3ny0h8fcvzovDPkVtieBuOjAP7g
 4EGVjB+2+sKptmIjnH8xxiavD1hVR0H6sjjR1ip/92029P8Wb8ZCx3ajLxX039HnqQ1d
 P5iMPPKM0tAyixbPOeu+9r5HGnVzC0Z0dDE5EXt0ct+NDZ4t8450S0Kwjuuqr6Cd9fsH
 RZPiGdh9BmctiBJGNM1JzGe3yZHfUd6TJIstjF88wNJyNOQEKeCPAF2sZQllbMKWYZ0t
 yMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793991; x=1690385991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kv3gPH6s0OE3PjFPgTi8pMQisc8pYxjYjhVnRHERxkM=;
 b=APblx4QHek0Td23x41GUpms10enP+Gw38hY5wuOqQpaF90LS58WnMu93wq/3jOhYd7
 uxJyZ6cJGbEjN11zGjN05Lv3mntzsKIG45XMSMBOIAgQrmdbIZmVO342DF7/Y8HKMYRx
 rQaVhI7dRCSnRyYEh0ALZWstKAn4pCcFaA6rXWbXe4F9jfEkilZUxak5nkrtxmJeI6ke
 9NKxja9NVhHREyWwTZL1XVY+PjKbZxAq0IORlFNNjvYSfaEBsZwG5N/+Hzxq8wFnuyX2
 njkolSTbHajNdia0SXb1fqDTGQoKJ9WcysAbJDBJFBI/b+t7fbn/VkRdzFLcgdoTO0yz
 rsdw==
X-Gm-Message-State: AC+VfDxmEid2rfFzf6udcTF0cOfTHTf15lU69DUsG6ZVAG1GMBeQPrn2
 jcTDJeUzXvnqFp5Bik/0XAzDDqRWrLesdfPmFMDL6M9F
X-Google-Smtp-Source: ACHHUZ6eCdjr2EILHVhBukJ1617ala/81tYqNoy3o7oLa97foMN1x87LetvB2VQslqBA5iceSXFw2g==
X-Received: by 2002:a5d:468d:0:b0:30a:f2a0:64fa with SMTP id
 u13-20020a5d468d000000b0030af2a064famr25636524wrq.10.1687793990871; 
 Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 07/22] accel/tcg: Widen pc to vaddr in CPUJumpCache
Date: Mon, 26 Jun 2023 17:39:30 +0200
Message-Id: <20230626153945.76180-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Related functions dealing with the jump cache are also updated.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-8-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-hash.h      | 12 ++++++------
 accel/tcg/tb-jmp-cache.h |  2 +-
 accel/tcg/cputlb.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 2ba2193731..a0c61f25cd 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -35,16 +35,16 @@
 #define TB_JMP_ADDR_MASK (TB_JMP_PAGE_SIZE - 1)
 #define TB_JMP_PAGE_MASK (TB_JMP_CACHE_SIZE - TB_JMP_PAGE_SIZE)
 
-static inline unsigned int tb_jmp_cache_hash_page(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_page(vaddr pc)
 {
-    target_ulong tmp;
+    vaddr tmp;
     tmp = pc ^ (pc >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS));
     return (tmp >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS)) & TB_JMP_PAGE_MASK;
 }
 
-static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
 {
-    target_ulong tmp;
+    vaddr tmp;
     tmp = pc ^ (pc >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS));
     return (((tmp >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS)) & TB_JMP_PAGE_MASK)
            | (tmp & TB_JMP_ADDR_MASK));
@@ -53,7 +53,7 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #else
 
 /* In user-mode we can get better hashing because we do not have a TLB */
-static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
 {
     return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
 }
@@ -61,7 +61,7 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #endif /* CONFIG_SOFTMMU */
 
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
                       uint32_t flags, uint64_t flags2, uint32_t cf_mask)
 {
     return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask);
diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bee87eb840..bb424c8a05 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -21,7 +21,7 @@ struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
-        target_ulong pc;
+        vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
 };
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cc53d0fb64..bdf400f6e6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -99,7 +99,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
     desc->window_max_entries = max_entries;
 }
 
-static void tb_jmp_cache_clear_page(CPUState *cpu, target_ulong page_addr)
+static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
     CPUJumpCache *jc = cpu->tb_jmp_cache;
     int i, i0;
-- 
2.34.1


