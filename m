Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EECC73E3BA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoK2-0000IZ-PW; Mon, 26 Jun 2023 11:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJn-0000Gu-V0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002ny-Ks
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so977629f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793989; x=1690385989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpxr3zkfID0ollRatRL8kSP2CPxnrAD0tKJHuPeeYkc=;
 b=meS3brkLRBHFXnc1reyevzuCSUQtVC3AMhCCG8yKmR7CvKJ+OhTl3bPyHaRh4apbLv
 f8xtqXay8jkwRApXiSNMY8DG2voPEuugEQZgvqnqy//RZIKV7rmdy1YiP1LAeLODvWI+
 3//Co2hQE64yT/quVIuYlCr7kDTHYjfCiW//1r1wZM3ra2C9K96plKJTR5sHmXYZv42d
 7UtP0NRcCbsuM5NuTVAgXSjvfTSgzxgKfMrwaWRvnSghvbEeAk9acRHX7Ff2iVeHcnj9
 JpjqwwFsL4+g3GDKpyx1d/9Pwt/Bke7mX5OTT1kQ5Xo8ydKja6BSGIS2v8c0Al+B069x
 QyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793989; x=1690385989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qpxr3zkfID0ollRatRL8kSP2CPxnrAD0tKJHuPeeYkc=;
 b=LeTCUE+UcSR2ffWaUo4fxwv3BpkkYq8o6J6Nr9medkVuUyBJc+stf2HVLfOC6TmS7i
 6hCE4tklgt0HnvWzfizhGN/8v51St7hzd2c5bybNE8YzXN5sCBFsJoGxVhZ7Co2cRMpC
 f0CY6MaEEor4i+wretgS0ipf0BBrvQT+5tciSXxxWZiBTmLxi3s8W+5deqP37UHxJkFt
 GBo+arBBjHOJm3kjqmQSW92fBjhUCfPjtf3CzotECSPpZFFQ5w6tnq3sXXjCft7F0t1q
 yZ/mXKImhRQfaYF45f18/5VgqXOWv24g1n2pRh4SrRFZ1Oj41uolYn7j+xfhFR+QBD59
 GVPw==
X-Gm-Message-State: AC+VfDy3odBgdkv1xRHCcODp/crHbNnJU8CXLhxHfm3KHCRU56R8kmjb
 r++jyIo//W/lFevqXvvwrKE+mcUi/42bMMsEaFQMWzZf
X-Google-Smtp-Source: ACHHUZ6CgdlMdI1jn+fQjFMAH4Dsdxs/3SmMeNJCrUyG/aUTenSDoFamCavkAgL3UmAuDfqQI0lBJQ==
X-Received: by 2002:adf:f748:0:b0:313:f00b:f03b with SMTP id
 z8-20020adff748000000b00313f00bf03bmr2949722wrp.22.1687793989667; 
 Mon, 26 Jun 2023 08:39:49 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 05/22] accel/tcg/cputlb.c: Widen addr in MMULookupPageData
Date: Mon, 26 Jun 2023 17:39:28 +0200
Message-Id: <20230626153945.76180-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Functions accessing MMULookupPageData are also updated.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-6-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ac990a1526..cc53d0fb64 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1729,7 +1729,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 typedef struct MMULookupPageData {
     CPUTLBEntryFull *full;
     void *haddr;
-    target_ulong addr;
+    vaddr addr;
     int flags;
     int size;
 } MMULookupPageData;
@@ -1756,7 +1756,7 @@ typedef struct MMULookupLocals {
 static bool mmu_lookup1(CPUArchState *env, MMULookupPageData *data,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
-    target_ulong addr = data->addr;
+    vaddr addr = data->addr;
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
@@ -1796,7 +1796,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
                                MMUAccessType access_type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = data->full;
-    target_ulong addr = data->addr;
+    vaddr addr = data->addr;
     int flags = data->flags;
     int size = data->size;
 
@@ -1827,7 +1827,7 @@ static void mmu_watch_or_dirty(CPUArchState *env, MMULookupPageData *data,
  * Resolve the translation for the page(s) beginning at @addr, for MemOp.size
  * bytes.  Return true if the lookup crosses a page boundary.
  */
-static bool mmu_lookup(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     unsigned a_bits;
@@ -2024,7 +2024,7 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, MMULookupPageData *p,
                                MMUAccessType type, uintptr_t ra)
 {
     CPUTLBEntryFull *full = p->full;
-    target_ulong addr = p->addr;
+    vaddr addr = p->addr;
     int i, size = p->size;
 
     QEMU_IOTHREAD_LOCK_GUARD();
@@ -2333,7 +2333,7 @@ static uint64_t do_ld_8(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
     return ret;
 }
 
-static uint8_t do_ld1_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint8_t do_ld1_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                           uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2352,7 +2352,7 @@ tcg_target_ulong helper_ldub_mmu(CPUArchState *env, uint64_t addr,
     return do_ld1_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint16_t do_ld2_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint16_t do_ld2_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2383,7 +2383,7 @@ tcg_target_ulong helper_lduw_mmu(CPUArchState *env, uint64_t addr,
     return do_ld2_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint32_t do_ld4_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint32_t do_ld4_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2410,7 +2410,7 @@ tcg_target_ulong helper_ldul_mmu(CPUArchState *env, uint64_t addr,
     return do_ld4_mmu(env, addr, oi, retaddr, MMU_DATA_LOAD);
 }
 
-static uint64_t do_ld8_mmu(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+static uint64_t do_ld8_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi,
                            uintptr_t ra, MMUAccessType access_type)
 {
     MMULookupLocals l;
@@ -2460,7 +2460,7 @@ tcg_target_ulong helper_ldsl_mmu(CPUArchState *env, uint64_t addr,
     return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
 }
 
-static Int128 do_ld16_mmu(CPUArchState *env, target_ulong addr,
+static Int128 do_ld16_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2617,7 +2617,7 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, MMULookupPageData *p,
                                uint64_t val_le, int mmu_idx, uintptr_t ra)
 {
     CPUTLBEntryFull *full = p->full;
-    target_ulong addr = p->addr;
+    vaddr addr = p->addr;
     int i, size = p->size;
 
     QEMU_IOTHREAD_LOCK_GUARD();
@@ -2808,7 +2808,7 @@ void helper_stb_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st_1(env, &l.page[0], val, l.mmu_idx, ra);
 }
 
-static void do_st2_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+static void do_st2_mmu(CPUArchState *env, vaddr addr, uint16_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2837,7 +2837,7 @@ void helper_stw_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st2_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st4_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+static void do_st4_mmu(CPUArchState *env, vaddr addr, uint32_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2864,7 +2864,7 @@ void helper_stl_mmu(CPUArchState *env, uint64_t addr, uint32_t val,
     do_st4_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st8_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+static void do_st8_mmu(CPUArchState *env, vaddr addr, uint64_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
@@ -2891,7 +2891,7 @@ void helper_stq_mmu(CPUArchState *env, uint64_t addr, uint64_t val,
     do_st8_mmu(env, addr, val, oi, retaddr);
 }
 
-static void do_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
+static void do_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
                         MemOpIdx oi, uintptr_t ra)
 {
     MMULookupLocals l;
-- 
2.34.1


