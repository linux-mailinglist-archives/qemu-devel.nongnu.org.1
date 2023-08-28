Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AC78B7B3
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahPB-0000rs-VZ; Mon, 28 Aug 2023 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP9-0000rQ-L6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP7-0002Sa-CZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26ef24b8e5aso2282742a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248960; x=1693853760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q52YryY77MZ2LmC1AwinyEGqkvB+2AbO6eV6neuXedY=;
 b=gDR4y1GM4p6ymFuZdvFKhpQUY8CeIu7itJ0Mo7YMk0FABEwHdlpawQbZVADkHdH/5T
 z6wQvAOJAkkwHewMYqcS57bXmoHKD3twileIqCmBpWxNxE05df77N07bvBps1heApkI0
 WE3awanwadjzqIEKoT6wLEveu8/XtyXVq5eaxXNWmUslrB35xXvt+TCMsr9ap3Fvechm
 cPqZCEVvHKk3ybhsv33VCOHCBdrme0on7O8iJxpuq87fG3LINaHOF5Jv9gibolZKWvrV
 Z6ImsIHfwotvWbMEE8gFehq7iOeI2Isgptzy+GdvIpxfxnmv09Wq52c66NvUHC0YV49H
 Zfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248960; x=1693853760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q52YryY77MZ2LmC1AwinyEGqkvB+2AbO6eV6neuXedY=;
 b=Izv2/t9bfY9+5+w7imj/LA0YBPj9UpccrJ9/BkfHm1oJUkSEonYD4T5sUs1rYLj4RA
 Qr+wnq7f5jS+9YSNB/tsHDKFxq0ffpU5V9qCVhxg3dwy04xWXefXiq5YyaJR5k+iNKMq
 FXHYCaK5Ij7Cpd2Sw1gSfMgEmkjrw461kHG3sQWAHJ+TUbh0LeTv9YgI4HGcDlwMkmTs
 LZ2qIVfuPtIG2gryjQIVuGUvwE1l0UOs0/MOKWjryGplAchBhXyVLQdGHfJNvgWkpj6p
 /cR8yhO2pt3RvM8X98mGu81aTO1bGIEZrxRX40BkUV/JBPyRMMcSU6fOQp+VuDxxdwJ5
 wWgw==
X-Gm-Message-State: AOJu0YxWnIO393GSBk6FPO/6szUL+dvMP64EBbF1ounRvEuspw9kooYE
 wNcxwn+IljAC1MaqPnS1s1ssXNGM7FycCh9Zltg=
X-Google-Smtp-Source: AGHT+IGxBMIFEKlp4ugpfLZz3ZnaamjU4yn718eki0bVDlrDF0tsv499IMFE2CpcRLswMUoCpUeslA==
X-Received: by 2002:a17:90a:b395:b0:26f:6a0c:8210 with SMTP id
 e21-20020a17090ab39500b0026f6a0c8210mr21014529pjr.41.1693248959965; 
 Mon, 28 Aug 2023 11:55:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 08/10] accel/tcg: Merge io_writex into do_st_mmio_leN
Date: Mon, 28 Aug 2023 11:55:48 -0700
Message-Id: <20230828185550.573653-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
One call to do_st_mmio_leN will never cross pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 82 +++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f4772b5c5d..cf80add4b3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1385,30 +1385,6 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
-                      int mmu_idx, uint64_t val, vaddr addr,
-                      uintptr_t retaddr, MemOp op)
-{
-    MemoryRegionSection *section;
-    hwaddr mr_offset;
-    MemoryRegion *mr;
-    MemTxResult r;
-
-    section = io_prepare(&mr_offset, env, full->xlat_section,
-                         full->attrs, addr, retaddr);
-    mr = section->mr;
-
-    {
-        QEMU_IOTHREAD_LOCK_GUARD();
-        r = memory_region_dispatch_write(mr, mr_offset, val, op, full->attrs);
-    }
-
-    if (r != MEMTX_OK) {
-        io_failed(env, full, addr, memop_size(op), MMU_DATA_STORE, mmu_idx,
-                  r, retaddr);
-    }
-}
-
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
@@ -2679,39 +2655,41 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+    MemoryRegion *mr;
+    MemTxAttrs attrs;
+
     tcg_debug_assert(size > 0 && size <= 8);
 
+    attrs = full->attrs;
+    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
+    mr = section->mr;
+
     do {
+        MemOp this_mop;
+        unsigned this_size;
+        MemTxResult r;
+
         /* Store aligned pieces up to 8 bytes. */
-        switch ((size | (int)addr) & 7) {
-        case 1:
-        case 3:
-        case 5:
-        case 7:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_UB);
-            val_le >>= 8;
-            size -= 1;
-            addr += 1;
-            break;
-        case 2:
-        case 6:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUW);
-            val_le >>= 16;
-            size -= 2;
-            addr += 2;
-            break;
-        case 4:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUL);
-            val_le >>= 32;
-            size -= 4;
-            addr += 4;
-            break;
-        case 0:
-            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUQ);
-            return 0;
-        default:
-            qemu_build_not_reached();
+        this_mop = ctz32(size | (int)addr | 8);
+        this_size = 1 << this_mop;
+        this_mop |= MO_LE;
+
+        r = memory_region_dispatch_write(mr, mr_offset, val_le,
+                                         this_mop, attrs);
+        if (unlikely(r != MEMTX_OK)) {
+            io_failed(env, full, addr, this_size, MMU_DATA_STORE,
+                      mmu_idx, r, ra);
         }
+        if (this_size == 8) {
+            return 0;
+        }
+
+        val_le >>= this_size * 8;
+        addr += this_size;
+        mr_offset += this_size;
+        size -= this_size;
     } while (size);
 
     return val_le;
-- 
2.34.1


