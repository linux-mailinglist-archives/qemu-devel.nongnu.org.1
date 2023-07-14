Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831B753F50
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0r-0007Os-V6; Fri, 14 Jul 2023 11:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0d-0007MG-Tm
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0V-000783-CC
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-315adee6ac8so2179507f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349618; x=1691941618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BuUwbulU5zL9tN4hCYlIE1gc3ZvqjDoeI3CgFmuY05s=;
 b=K1xbhVUAuJ3hjYDrUvp8TvNkYxIkOhCMjVcqGXw5fqbgbEO62fH0/9sH5BByXWlaa6
 UZLJHpSHva0rC5fsnO2Wm1U8wk1JxHaNQ+ExSENQDbMw9nNniPsv33WEXUitKGkCnuoH
 qKs7YDS0HKCwemwhmQXYhqHx7x+XACsEkrf5WAm6qFbiGM3N5lUj0a0/KPjx9C2iDqqf
 0agY5PZOd5vyOMfX7Hu2cXGjxYVDF1AUMpqdW5vImUCeKdhjjGWa7ElMAP4EtJpv0YNk
 Zv7lTJBNSH2MRIjqgLb/cDjYdrbhzyR3tuAPpMgZz6zPSoMIK8cLJxRF/u4d9Hbyc5Dp
 Ghuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349618; x=1691941618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuUwbulU5zL9tN4hCYlIE1gc3ZvqjDoeI3CgFmuY05s=;
 b=StYF+bt2s5GLKXf1q/jHE3H47jlefqtJ1Fr2h11kqcBBXsg0psdBXNKJYnkQQ7wc2A
 ze8XhETkHoQT0/96cMFyt+0WCevV3Nnu50aaj/JkbnIdVn+aHFJ5VlbU9RpBfN9QVuhC
 0vFD3RD6j2in3RaAGlfpwy8HuXAJwRUG10ILVG4xgyi2bO0tHjjQ4NLMd4ItuOHjILFJ
 rAqZOYW/UYj6LimEUngoaKKRdD0wF0WUGbh0gMdhHeZi+2ioYsL8R20HCPo8tVM+E2yN
 AgpIAUGXny6BGfI/idhs3zAX1WhzXrLbzv1tI/oENSdYWBSjf5nrVAvsjhUgFH6gcgrS
 SIXw==
X-Gm-Message-State: ABy/qLZ9JPNG9jmZkBBV1IIIY4w7aJ/gt+PLXGqJz8z98eF8mioX+pBW
 RsMSSFhZI7XOwg1bK1dgmOr1GmOepJiu0hwV+/c=
X-Google-Smtp-Source: APBJJlHgk+aeDe8DnwQjjvvmKj/zpCJXOBYSY1tz0jLsvv3PWcoicZRSYoqzBbNsWL1caksGzzLUMw==
X-Received: by 2002:a5d:68c6:0:b0:315:9d61:6e66 with SMTP id
 p6-20020a5d68c6000000b003159d616e66mr4770217wrw.9.1689349617995; 
 Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/14] target/arm: Adjust PAR_EL1.SH for Device and Normal-NC
 memory types
Date: Fri, 14 Jul 2023 16:46:48 +0100
Message-Id: <20230714154648.327466-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The PAR_EL1.SH field documents that for the cases of:
 * Device memory
 * Normal memory with both Inner and Outer Non-Cacheable
the field should be 0b10 rather than whatever was in the
translation table descriptor field. (In the pseudocode this
is handled by PAREncodeShareability().) Perform this
adjustment when assembling a PAR value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e45fdb47c9..f9c00827018 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3342,6 +3342,19 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 #ifdef CONFIG_TCG
+static int par_el1_shareability(GetPhysAddrResult *res)
+{
+    /*
+     * The PAR_EL1.SH field must be 0b10 for Device or Normal-NC
+     * memory -- see pseudocode PAREncodeShareability().
+     */
+    if (((res->cacheattrs.attrs & 0xf0) == 0) ||
+        res->cacheattrs.attrs == 0x44 || res->cacheattrs.attrs == 0x40) {
+        return 2;
+    }
+    return res->cacheattrs.shareability;
+}
+
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              bool is_secure)
@@ -3470,7 +3483,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                 par64 |= (1 << 9); /* NS */
             }
             par64 |= (uint64_t)res.cacheattrs.attrs << 56; /* ATTR */
-            par64 |= res.cacheattrs.shareability << 7; /* SH */
+            par64 |= par_el1_shareability(&res) << 7; /* SH */
         } else {
             uint32_t fsr = arm_fi_to_lfsc(&fi);
 
-- 
2.34.1


