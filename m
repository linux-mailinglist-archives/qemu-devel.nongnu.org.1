Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90978EADF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBP-000461-SM; Thu, 31 Aug 2023 06:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB3-0003RD-Sy
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAy-00042b-HX
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so487597f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478722; x=1694083522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zu723NqO5csexGltvqwm/VR8QzDnvxeiqLGXpa9N4pc=;
 b=iWLGQauJhDnrprfvNSTZgwF8EPejP+9OuENDLwCm9ja1VbwenkyZ5+0zKqvlvARmXN
 O5ErTHwULLla+IFQl2/ZAJUiBW8WKMrAogD5/wV+OikWmDL8fJK7nDHYmzGB4shFeTeo
 oXeWJgx7UvKf/9RjXIrlJGk+d9ZhC2RHJEkeVgNKs2qh5JEjftzfco2f77pfzPMUcSp8
 MLBNil0t66qxoJUpG5h6znt4mVPhJaUrSNuKCfqx1Stv8czRQ4249nGn9piIUnH1S4ME
 MuMQz191QKOWPiek2woQ1RobsZcZbc2dpSDdCvY6WbNcdudgl9xUnP7VrPpryePhT1GY
 cYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478722; x=1694083522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zu723NqO5csexGltvqwm/VR8QzDnvxeiqLGXpa9N4pc=;
 b=blRYDSNbKk0vlZJMhB79vH/H6JR3CsfFZBj2CSYDfHU3sXc73PJEL1GSxWhkgZyR7Z
 1WWOHHX1wsMLvnRQIt8fCirn25OOZdczjslP7712JrpbKHgsuT6OLJ9AfcLT3vjzFlAL
 srp2oinsNPLXev0RXBLpz4WnltzZ0Plw8FcAmHvRmh1exxw+hpgkfXFpuXHhUq3BZBPl
 BWPDcvR10XTVJfrTxpSwPNWTJH1PkDpUnp7XzDLiut16MEOguBccQvgj4jBS/A0Jdp90
 WNYwsmF4C1nFVBKHoDTOGQai+7r733siwpTXiF38Gm+h00SHdO9KNzKZawB07ncn8Vft
 jaXw==
X-Gm-Message-State: AOJu0Yy3WkrTfAzFWBLMhc0b9Gct0ELDuBSWw20pOJaN4yPylJQ6DvfK
 Mu2aXNgq+sELj/SYpmT6SBvVXK+RvtaMHeIA788=
X-Google-Smtp-Source: AGHT+IFzRxu9YEWApYDLGAPVTsLV+h2jbCTV+TOvQgHX5OgrkpWson76fML6052xode6qnj3olP6KA==
X-Received: by 2002:a5d:4c84:0:b0:30f:bb83:e6f4 with SMTP id
 z4-20020a5d4c84000000b0030fbb83e6f4mr4349409wrs.0.1693478722555; 
 Thu, 31 Aug 2023 03:45:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] target/arm: Introduce make_ccsidr64
Date: Thu, 31 Aug 2023 11:45:00 +0100
Message-Id: <20230831104519.3520658-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not hard-code the constants for Neoverse V1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 48 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4cd73779c80..00f39d42a8c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -24,9 +24,36 @@
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
+#include "qemu/units.h"
 #include "internals.h"
 #include "cpregs.h"
 
+static uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
+                              unsigned cachesize)
+{
+    unsigned lg_linesize = ctz32(linesize);
+    unsigned sets;
+
+    /*
+     * The 64-bit CCSIDR_EL1 format is:
+     *   [55:32] number of sets - 1
+     *   [23:3]  associativity - 1
+     *   [2:0]   log2(linesize) - 4
+     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+     */
+    assert(assoc != 0);
+    assert(is_power_of_2(linesize));
+    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
+
+    /* sets * associativity * linesize == cachesize. */
+    sets = cachesize / (assoc * linesize);
+    assert(cachesize % (assoc * linesize) == 0);
+
+    return ((uint64_t)(sets - 1) << 32)
+         | ((assoc - 1) << 3)
+         | (lg_linesize - 4);
+}
+
 static void aarch64_a35_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -651,26 +678,15 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values,
      * but also says it implements CCIDX, which means they should be
      * 64-bit format. So we here use values which are based on the textual
-     * information in chapter 2 of the TRM (and on the fact that
-     * sets * associativity * linesize == cachesize).
-     *
-     * The 64-bit CCSIDR_EL1 format is:
-     *   [55:32] number of sets - 1
-     *   [23:3]  associativity - 1
-     *   [2:0]   log2(linesize) - 4
-     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
-     *
-     * L1: 4-way set associative 64-byte line size, total size 64K,
-     * so sets is 256.
+     * information in chapter 2 of the TRM:
      *
+     * L1: 4-way set associative 64-byte line size, total size 64K.
      * L2: 8-way set associative, 64 byte line size, either 512K or 1MB.
-     * We pick 1MB, so this has 2048 sets.
-     *
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
-    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x000007ff0000003aull; /* 1MB L2 cache */
+    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB); /* L1 dcache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];                 /* L1 icache */
+    cpu->ccsidr[2] = make_ccsidr64(8, 64, 1 * MiB);  /* L2 cache */
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
-- 
2.34.1


