Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4165775F50
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiRI-0002aW-SL; Wed, 09 Aug 2023 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRF-0002Xr-GZ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRC-0002oE-Ax
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3178dd771ceso5778559f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691584636; x=1692189436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhowOvdNoqNAM56f9usHlhnKbRslUqskM9I47IE0+fw=;
 b=EMjHJ1r+b8XiGXmjgO2S6RSoXBLpgmIRwJwCyUr6+VNB9YBM9dQUuN/wF2b9HdDfG6
 8dZ9DYaAliGK+yTGHsH/n3EJsbIiHVdk6gomzwM9XtT+FpBj+tdHT+dEUYJQ15640GPH
 uG41gQupG8CZHR3Zs4/h2ygWdMKd2hV/PjzY91RlrZkG0ELlAsvFsXX1/i6IrXExoD98
 icWIMvZYUxIIktlY680bBD0phZlVzPIb5OcivbjZGCJiOt0MP7GfOOSs9rQ9rCkVElzQ
 jJe/1Vk6aK0Hi3xp+gmtJ/aaUjYZqurACEp4TUDBk6I1KohdRlPP9yX44Uf8pzcJAxPj
 cEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584636; x=1692189436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhowOvdNoqNAM56f9usHlhnKbRslUqskM9I47IE0+fw=;
 b=H6X7t1z7N8jQLVQ/pCXiXkw4HKSXTulykkDWfJdZsGwPFr0N43a4Th4pMg0q4qHY3J
 Af99umrlaNb7k1aTi/CxF4AlrAWk6D+rlYE49v5GEGuJfxdShRSVsXkx7Wb7RFdVKwtf
 AHX7TncroA1c24xZLVciCyxtYxjuX71wSVjUW39SSgWOEDhN4dZUt1p5/qqnbHOFlcRG
 B38frX07Kf8BevKQIIqmDddcrTLCwNP2r47QyILO8IkKEK++S5IwmWCWGo/lj7EnpTS/
 9ChOkADRRwrX58Eoosc8shooACLvKzMp9QX6t31oM8TFErpefwCDWt+GBDahGPZgMIB+
 aW2A==
X-Gm-Message-State: AOJu0YyO7mLaB2jE+CkVNJfNr1i+Swc4tcnZB3qPxCSg5vf+xbS3h22u
 K5XZ1qf8jq1dEfj4LsxLo8echg==
X-Google-Smtp-Source: AGHT+IHePgkjLAKpBsJkB3idsd+1+oAM6Dfu8zE8XSD3fyxmXOGgG8uGbHWuyJnMFeItXNU0Y9U+3w==
X-Received: by 2002:a5d:4d83:0:b0:314:2e77:afec with SMTP id
 b3-20020a5d4d83000000b003142e77afecmr1664367wru.57.1691584636287; 
 Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5246000000b00317f70240afsm5617888wrc.27.2023.08.09.05.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 3/6] target/arm: Skip granule protection checks for AT
 instructions
Date: Wed,  9 Aug 2023 13:37:03 +0100
Message-ID: <20230809123706.1842548-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809123706.1842548-1-jean-philippe@linaro.org>
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42c.google.com
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

GPC checks are not performed on the output address for AT instructions,
as stated by ARM DDI 0487J in D8.12.2:

  When populating PAR_EL1 with the result of an address translation
  instruction, granule protection checks are not performed on the final
  output address of a successful translation.

Rename get_phys_addr_with_secure(), since it's only used to handle AT
instructions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 25 ++++++++++++++-----------
 target/arm/helper.c    |  8 ++++++--
 target/arm/ptw.c       | 11 ++++++-----
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f01bc32a8..fc90c364f7 100644
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
index a4c2c1bde5..427de6bd2a 100644
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
index 063adbd84a..33179f3471 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3418,16 +3418,17 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
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
2.41.0


