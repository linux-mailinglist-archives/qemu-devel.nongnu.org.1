Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D475C786C15
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ep-0007ys-TI; Thu, 24 Aug 2023 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eE-0004Yq-Rz
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00052B-Mw
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so17947265e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869332; x=1693474132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cb6ko/hJLTrWCjWa2FYGoqsOrH337RJKxsjYS/YCyLg=;
 b=oSp7Z3gnCh/SkfJLtwYBoW7IcfB74JHq89K8jnid/YT8TGU4B8MiquFsW5xBVqNR0I
 88Eh+2W1WpwhPXbDK/nX1wKEqTfedaAyM6IRbv8iqnJQRUeOo/wjI+FaS9Tu3gRK9BQd
 bTpBZAyEneD9n/4dmxW+yAGTnUSyW8VRMr5+coWHOHXbZz4dhj13JV0KsZCrTIOdu8+Z
 7DbZaRt2KABBWgfSRUqY3wwD+8wwUyi/eR9yuOHaLqsWeqOjv448RR4soqGKUfd0v3VN
 g5lwY4QM+VcCQk8feKxwJ5UeyLKYw/s3u896HGjDcVnc6vsmKNn+ZorukRO0j7s8mhHm
 J28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869332; x=1693474132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cb6ko/hJLTrWCjWa2FYGoqsOrH337RJKxsjYS/YCyLg=;
 b=Q3W4r2I7sjG0Vae2gXgXhiUqLfbNthHO1AJfisvrsDPXgWv6DiDz0a9taA9dngbGkO
 h9geiNi5LByOtZaKT7/gJVcwZhEpV0xJABvJJMm4+uiGVN3xuo+Nb64IPY3qqlLM2NGu
 b66xmGbHP7wgf17sQpTKrkh01RzKVUIc2egkaPm9BGkLkgJyS10cljrsO4FZZ5/k8z75
 QG0cmE7CTV0EBpbEJX0JSG6v3nZ+aFPNa28A/cCXQ3GaX5/gxy4fvYoutmdKp2ZiqYjx
 wVXksNVOFem+Jz7HJGqp5cYz7JaJA4hwwEcqzdYl4HNusRaMg8bi3kw/8+PJ50qn4ZfZ
 zjDw==
X-Gm-Message-State: AOJu0YzVD2kwM9EbWKGW9M/3aQhm0dPqyC5lyYoS0nhliJVngJ60LLUR
 yqGmwlEf12eR44URJAErfJjvK1X57YSzAAK80LM=
X-Google-Smtp-Source: AGHT+IEqG5FfqcQTI0ddHdfVCU/XW9iD4x0UWM/L5TjigDd2PYa/3NHs5jyOa//WoDAqWMVeNt35Sw==
X-Received: by 2002:a5d:6745:0:b0:31a:cc98:a39b with SMTP id
 l5-20020a5d6745000000b0031acc98a39bmr11124549wrw.40.1692869332343; 
 Thu, 24 Aug 2023 02:28:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/35] target/arm: Skip granule protection checks for AT
 instructions
Date: Thu, 24 Aug 2023 10:28:31 +0100
Message-Id: <20230824092836.2239644-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

GPC checks are not performed on the output address for AT instructions,
as stated by ARM DDI 0487J in D8.12.2:

  When populating PAR_EL1 with the result of an address translation
  instruction, granule protection checks are not performed on the final
  output address of a successful translation.

Rename get_phys_addr_with_secure(), since it's only used to handle AT
instructions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230809123706.1842548-4-jean-philippe@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 25 ++++++++++++++-----------
 target/arm/helper.c    |  8 ++++++--
 target/arm/ptw.c       | 11 ++++++-----
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f01bc32a8a..fc90c364f77 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1190,12 +1190,11 @@ typedef struct GetPhysAddrResult {
 } GetPhysAddrResult;
 
 /**
- * get_phys_addr_with_secure: get the physical address for a virtual address
+ * get_phys_addr: get the physical address for a virtual address
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
  * @mmu_idx: MMU index indicating required translation regime
- * @is_secure: security state for the access
  * @result: set on translation success.
  * @fi: set to fault info if the translation fails
  *
@@ -1212,26 +1211,30 @@ typedef struct GetPhysAddrResult {
  *  * for PSMAv5 based systems we don't bother to return a full FSR format
  *    value.
  */
-bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
-                               MMUAccessType access_type,
-                               ARMMMUIdx mmu_idx, bool is_secure,
-                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+bool get_phys_addr(CPUARMState *env, target_ulong address,
+                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
 /**
- * get_phys_addr: get the physical address for a virtual address
+ * get_phys_addr_with_secure_nogpc: get the physical address for a virtual
+ *                                  address
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
  * @mmu_idx: MMU index indicating required translation regime
+ * @is_secure: security state for the access
  * @result: set on translation success.
  * @fi: set to fault info if the translation fails
  *
- * Similarly, but use the security regime of @mmu_idx.
+ * Similar to get_phys_addr, but use the given security regime and don't perform
+ * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr(CPUARMState *env, target_ulong address,
-                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
+                                     MMUAccessType access_type,
+                                     ARMMMUIdx mmu_idx, bool is_secure,
+                                     GetPhysAddrResult *result,
+                                     ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 808f35218a2..e8a232a1f89 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3365,8 +3365,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
 
-    ret = get_phys_addr_with_secure(env, value, access_type, mmu_idx,
-                                    is_secure, &res, &fi);
+    /*
+     * I_MXTJT: Granule protection checks are not performed on the final address
+     * of a successful translation.
+     */
+    ret = get_phys_addr_with_secure_nogpc(env, value, access_type, mmu_idx,
+                                          is_secure, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7a69968dd76..ca4de6e3999 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3420,16 +3420,17 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
-                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                               bool is_secure, GetPhysAddrResult *result,
-                               ARMMMUFaultInfo *fi)
+bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
+                                     MMUAccessType access_type,
+                                     ARMMMUIdx mmu_idx, bool is_secure,
+                                     GetPhysAddrResult *result,
+                                     ARMMMUFaultInfo *fi)
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = arm_secure_to_space(is_secure),
     };
-    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
 
 bool get_phys_addr(CPUARMState *env, target_ulong address,
-- 
2.34.1


