Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B47E8792
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crQ-0002Ke-I1; Fri, 10 Nov 2023 20:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crN-0002CN-5K
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:29 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crL-0001cO-2Y
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:28 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-58441865ffaso1483708eaf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666346; x=1700271146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNGROZeVUOQseOR8lBT2AY8/u5jAx6va8TZMpF8TVmg=;
 b=bptRZL6wn0FLJ8hFNrppZVrQbw9nkKFeJ7wiOjByHTF8Afnn1DVpbC+/HXUqzr7IY1
 gb++5NFuYASjqKTSprzhX10qgGHo9IbishfAz1V6wXgbnHBQTMz2mOT/WXggL4AKW4Qa
 FEZU8jlIuvIdieUhdJ5BR8ZWEvly5v6DYE1Dwgwife+pJiGCAejW1ihHxMsYITbQCGFe
 Tn/B6YEUSfMbg4OEL8p8RniFHHrHAeqz/AB9ZMNE5VGHChbMRcKTrl+tJ6mRyBuyQKXk
 jxB6/bZLYiVM1W9PgI0TDm2nzwXOOco0f09b14bna+jyvcljCoITnY70uAY7znC8EqOj
 xXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666346; x=1700271146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNGROZeVUOQseOR8lBT2AY8/u5jAx6va8TZMpF8TVmg=;
 b=gcod9WBxpV/q1FYZWPxzA8utQdMDiFlk7l5pgi5M1gsw1/THEzYKFt8vibbT0RBaqm
 706wSxkljp8A6ZAh/ATTdSuKugqejGAf9hTsem/JuI7TOJ9pkgZucfFYJpLEXlt+F7+U
 3YQqjQ7n9rjDuXidK9IcD3dOP5HTvSxOkhU/RzzabvP9RXNQa010bJkhsQ76Gpv5JgEh
 rCoWSziiqaqyIjQD4RDQHiHBCBVyj3MTUZ9wRcrHSZm1O9qES+hympKcJuOhvLemJw+N
 AuD3E3nIMGScn6cGxhlp0vWT747Z3gJOu5InTNSsgCy6mzPNxsSaLzG2MfGy+k7TllAZ
 i3CQ==
X-Gm-Message-State: AOJu0YwlIrY3UNA0g/bpEPy9/pmz2iD/Vx7lnuKXt5M3iG/RcIsXQTN5
 BPpRbuetawv+AagGzCOwO8oLPq0SkZr3HnCtc00=
X-Google-Smtp-Source: AGHT+IGm9FMxbmxGhiI4wQcSB/HRNtXEXUNOsjjbfOZgmiAU3Yblxt9DYeOi+z7wI17jb4RkZQ+YeA==
X-Received: by 2002:a05:6870:e40a:b0:1f0:870e:930d with SMTP id
 n10-20020a056870e40a00b001f0870e930dmr1026784oag.59.1699666345692; 
 Fri, 10 Nov 2023 17:32:25 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 10/11] target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 44
Date: Fri, 10 Nov 2023 17:32:11 -0800
Message-Id: <20231111013212.229673-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

This is the maximum that was ever supported, in the PA-8700 thru
PA-8900.  If we support a larger address space than expected, we
trip up software that did not fill in all of the page table bits,
expecting them to be ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-param.h  |  2 +-
 target/hppa/mem_helper.c | 50 ++++++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 6746869a3b..7a8b216133 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -14,7 +14,7 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #else
-# define TARGET_PHYS_ADDR_SPACE_BITS  64
+# define TARGET_PHYS_ADDR_SPACE_BITS  44
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


