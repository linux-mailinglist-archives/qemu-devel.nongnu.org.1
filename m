Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DC78B7B1
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahPB-0000rp-SM; Mon, 28 Aug 2023 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP8-0000qn-Uo
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:02 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP6-0002SP-Hf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:02 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26d54d3d984so1646919a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248959; x=1693853759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mz6E+/wbBE5eFwC0E1gYDTq5fpYP+E2DwEXnYpjQuQ=;
 b=ev9AcvLorCgsfvAPYLODTxwYRpY0ernGMzjQB++gjzdCOF7m/7rUDNg8MtMbyTUjpG
 sEQoIiYdyYa/VdZuCFiin5MtkDuIY7PIiDrz7ayWegFUQRwSLQOWwSZySn1ibVk9GGLN
 b/NgkvRG7k8kcx7gTBm8m447g9RLjaSxdj907kleSk4IdghmJK8x1e8CSe4vTEj+c7Yq
 4XW2AsVLMtcY+0B3gETglvPay6SszOF158e89Q6vQSrT9nbuRQu/hCKcXdKS/hS5f+bi
 iBqmQKxSAjbQlcXyn3QCMJxpJ4mSnJzs9cecIJGKmc03QTwobRvbCUd8/tKVBXjGs7kS
 gegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248959; x=1693853759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mz6E+/wbBE5eFwC0E1gYDTq5fpYP+E2DwEXnYpjQuQ=;
 b=AJwr0nPKL2k6DTHFLB8CevzXLgpqtNv425UCqv5pPX15wXaCEYjY/bW1S0Id0arNKn
 Uq3vtTzb71CRCwTBjz6+zyzN4McbNq7/2wAV7j0gSteKEdTmfdhfmClzyKv/XLyfYUrn
 fe76HAFuoOMVtnODpuz07qyzrfAjP2Tv355GtLyTeDiC0pBcAIgPij5TuGcyzqHtpa+T
 u9ygfEyDMsiorvON8kpdhSpiG42FkTMNzIfPY2l4MsFs7on1xPY8IaK9jwYSRXmWwu6c
 3mKFA+6+LhDeo93lj80xvn6pfY8RqbBbsjbdu9N6cqE3AJXEvc4Bx59b4EkYAmK23jCT
 Es7A==
X-Gm-Message-State: AOJu0YyDfVdi/mmWmldmRqRHnkpkDBi+TX50jqyDHcwIViqLUC+cmqPN
 1xwC1VzS/wARUAkzYbQcf95ap/Jo5RJZxhFlTWU=
X-Google-Smtp-Source: AGHT+IEr8Qx5d/fi8EQl9DjRP972Nn9e/2ecbFR5JUM9YEXWwO2F6F3+lJ2O8cRcvUjdte6ve/WXsw==
X-Received: by 2002:a17:90b:4a46:b0:26d:4421:854d with SMTP id
 lb6-20020a17090b4a4600b0026d4421854dmr20741968pjb.37.1693248959019; 
 Mon, 28 Aug 2023 11:55:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 07/10] accel/tcg: Merge io_readx into do_ld_mmio_beN
Date: Mon, 28 Aug 2023 11:55:47 -0700
Message-Id: <20230828185550.573653-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Avoid multiple calls to io_prepare for unaligned acceses.
One call to do_ld_mmio_beN will never cross pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 84 +++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 54 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6a7f6bf701..f4772b5c5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1385,32 +1385,6 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-                         int mmu_idx, vaddr addr, uintptr_t retaddr,
-                         MMUAccessType access_type, MemOp op)
-{
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-    MemoryRegion *mr;
-    MemTxResult r;
-    uint64_t val;
-
-    section = io_prepare(&mr_offset, env, full->xlat_section,
-                         full->attrs, addr, retaddr);
-    mr = section->mr;
-
-    {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
-    }
-
-    if (r != MEMTX_OK) {
-        io_failed(env, full, addr, memop_size(op), access_type, mmu_idx,
-                  r, retaddr);
-    }
-    return val;
-}
-
 static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
@@ -2059,40 +2033,42 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
-    uint64_t t;
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
+
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
     do {
+        MemOp this_mop;
+        unsigned this_size;
+        uint64_t val;
+        MemTxResult r;
+
         /* Read aligned pieces up to 8 bytes. */
-        switch ((size | (int)addr) & 7) {
-        case 1:
-        case 3:
-        case 5:
-        case 7:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_UB);
-            ret_be = (ret_be << 8) | t;
-            size -= 1;
-            addr += 1;
-            break;
-        case 2:
-        case 6:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUW);
-            ret_be = (ret_be << 16) | t;
-            size -= 2;
-            addr += 2;
-            break;
-        case 4:
-            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUL);
-            ret_be = (ret_be << 32) | t;
-            size -= 4;
-            addr += 4;
-            break;
-        case 0:
-            return io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUQ);
-        default:
-            qemu_build_not_reached();
+        this_mop = ctz32(size | (int)addr | 8);
+        this_size = 1 << this_mop;
+        this_mop |= MO_BE;
+
+        r = memory_region_dispatch_read(mr, mr_offset, &val, this_mop, attrs);
+        if (unlikely(r != MEMTX_OK)) {
+            io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
         }
+        if (this_size == 8) {
+            return val;
+        }
+
+        ret_be = (ret_be << (this_size * 8)) | val;
+        addr += this_size;
+        mr_offset += this_size;
+        size -= this_size;
     } while (size);
+
     return ret_be;
 }
 
-- 
2.34.1


