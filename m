Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 382587EA1E1
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao1-0001Uz-8L; Mon, 13 Nov 2023 12:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ant-0001TV-EU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anm-0000vj-B7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so32818785ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896765; x=1700501565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+GwbR4dsSiGVMQ1CzBoRUVbGp1VEzLCfQOKdm4FvWwo=;
 b=ryto3rRV7NCFPYSY6nIaRfDCV9Mbk6g2B2VVu+Gi3PKfpCkGt49GwjaopYKpBkm8N3
 B52MlRWTahz2BTrpTEWb11WRx9wuKlYVxSTZKlgI6xgZXLCWeDAvS56uKcrH0ZHJPbG+
 EYtGTQIejpvGKVRRIRSPVBUpmRLQWWVjTig6x0/4O2C7e2Q5C5L/S4b10QF5jkbQYlOL
 XMfpHM20RYBS3VYPJzz5xV5fmHu6AZzdDoNpLJu9kBImYv7FvpPIOlbHLynsP0Yd5593
 RRMoWfJ6gGU9Ev1+kkNVPwMmPq7pypfeZa9wr9NARnIMyM8xumYsGFia1pk6US+omCzl
 MVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896765; x=1700501565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GwbR4dsSiGVMQ1CzBoRUVbGp1VEzLCfQOKdm4FvWwo=;
 b=NSD81+dC/fm6CL4ZEJlnmBen/gumQ9+mkHUYUURq/15ECc1HbI+w9vLmS03q7zcUIB
 NtbNRXZhMAIkrGLvr+ozCK7y6vVC1lqoyXfrdhZ1zTCAQ8iCGKDs5k70Dm8GZ1cmUxWK
 J5tnmD9Oa4AUrUkzp+bjiSxKyduWQo/PC0DqfGpMmI/t56c0mgEungFCoi6nLS7W4c8E
 qEe21NfSiyrvHh35QXdAY77QK8PHn/c9ppRXWc/PqsqskO/Db/LYdLPPeKCecXxaZB2a
 yZs0lI6UoY8OIybzX59vbIIu8YqMEwdxr9Ke4MmGeGWXUuUYZSr2oYmmbvvlf7D5662R
 EdBA==
X-Gm-Message-State: AOJu0Yw00+eL2wiYl5tZ1v4CRcXtgiulTlEZT15QHoyGspa4KQE//h82
 Ihef1EMY5xPo6yQ1E/naTTmGgXSVRTz0+joShzY=
X-Google-Smtp-Source: AGHT+IHOAk47Fa/BmldwSxQOn6DdXHrvHMhRHF6EEYORbC34YxBmNMAznWitZMKRwr5PYnm8FF58aA==
X-Received: by 2002:a17:903:1c6:b0:1cc:4ffb:26f4 with SMTP id
 e6-20020a17090301c600b001cc4ffb26f4mr329806plh.1.1699896765089; 
 Mon, 13 Nov 2023 09:32:45 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 40
Date: Mon, 13 Nov 2023 09:32:33 -0800
Message-Id: <20231113173237.48233-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This is the value that is supported by both PA-8500 and Astro.
If we support a larger address space than expected, we trip up
software that did not fill in all of the page table bits,
expecting them to be ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-param.h  |  3 ++-
 target/hppa/mem_helper.c | 50 ++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 6746869a3b..bb3d7ef6f7 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -14,7 +14,8 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #else
-# define TARGET_PHYS_ADDR_SPACE_BITS  64
+/* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits. */
+# define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  64
 #endif
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 7bc456d4ee..08abd1a9f9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -27,30 +27,39 @@
 
 hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
 {
-    if (likely(extract64(addr, 58, 4) != 0xf)) {
-        /* Memory address space */
-        return addr & MAKE_64BIT_MASK(0, 62);
-    }
-    if (extract64(addr, 54, 4) != 0) {
-        /* I/O address space */
-        return addr | MAKE_64BIT_MASK(62, 2);
-    }
-    /* PDC address space */
-    return (addr & MAKE_64BIT_MASK(0, 54)) | MAKE_64BIT_MASK(60, 4);
+    /*
+     * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" describes
+     * an algorithm in which a 62-bit absolute address is transformed to
+     * a 64-bit physical address.  This must then be combined with that
+     * pictured in Figure H-11 "Physical Address Space Mapping", in which
+     * the full physical address is truncated to the N-bit physical address
+     * supported by the implementation.
+     *
+     * Since the supported physical address space is below 54 bits, the
+     * H-8 algorithm is moot and all that is left is to truncate.
+     */
+    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
+    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
 {
+    /*
+     * See Figure H-10, "Absolute Accesses when PSW W-bit is 0",
+     * combined with Figure H-11, as above.
+     */
     if (likely(extract32(addr, 28, 4) != 0xf)) {
         /* Memory address space */
-        return addr & MAKE_64BIT_MASK(0, 32);
-    }
-    if (extract32(addr, 24, 4) != 0) {
+        addr = (uint32_t)addr;
+    } else if (extract32(addr, 24, 4) != 0) {
         /* I/O address space */
-        return addr | MAKE_64BIT_MASK(32, 32);
+        addr = (int32_t)addr;
+    } else {
+        /* PDC address space */
+        addr &= MAKE_64BIT_MASK(0, 24);
+        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
     }
-    /* PDC address space */
-    return (addr & MAKE_64BIT_MASK(0, 24)) | MAKE_64BIT_MASK(60, 4);
+    return addr;
 }
 
 static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
@@ -460,7 +469,14 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
 
     ent->itree.start = va_b;
     ent->itree.last = va_e;
-    ent->pa = (r1 << 7) & (TARGET_PAGE_MASK << mask_shift);
+
+    /* Extract all 52 bits present in the page table entry. */
+    ent->pa = r1 << (TARGET_PAGE_BITS - 5);
+    /* Align per the page size. */
+    ent->pa &= TARGET_PAGE_MASK << mask_shift;
+    /* Ignore the bits beyond physical address space. */
+    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
+
     ent->t = extract64(r2, 61, 1);
     ent->d = extract64(r2, 60, 1);
     ent->b = extract64(r2, 59, 1);
-- 
2.34.1


