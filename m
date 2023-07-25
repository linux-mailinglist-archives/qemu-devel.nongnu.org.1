Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF100761C8E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVS-0003eK-IT; Tue, 25 Jul 2023 10:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVQ-0003Xr-6y
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVO-0001Eo-Iw
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so42440175e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297157; x=1690901957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bJCBZZCEPCtzonH3X6oi/HIov7CTT54+j4YPc7XUYQ=;
 b=k1yQs1VrxTLtmBjlGpSGj5HvLaN4LLWHxP+h/uZCP4LPny2pQZndZlBLsP3JKID6Ho
 stsOkQHK/dlmzwbXmdyGgmRw1cLt9tSN5t8QO4WBUXSmZ7bJ8JSBvjGvRx02Insz+eLF
 Zl+upnppy95hO/+6ShukF+8+JLrITJQ27ZqUX4NnSsauBZ0+/BZGRMLuWQAgFrwwkamH
 m65IDWGN1hSJz/odO2AXBq+JTcTvvGzNwWoSjcs28JWGryBmX10FprOjOfecQ+lswidh
 SNHyaOk9eD/B9jnA5a8725m19bay2K7RPp6dAKGMwylarawOaZplLbmxI9mXJIHqCwXF
 ollg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297157; x=1690901957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bJCBZZCEPCtzonH3X6oi/HIov7CTT54+j4YPc7XUYQ=;
 b=jMn7hOoquBtOqfqmnNf/3pxCxIR7GDWKS43xtqyTn/fv0gwrjxdnsdvpAmh2Pwo/37
 NDJlK+x5TsvNSBq9s7YsZEcMhiNFUp+uCVZwQwNypItND0UzZl9fwu6yNnIzSa1Ozovz
 PxQ8C3NBf65cIqSCxuDudSAxG/pIHsEjuURrp2s2yncdxWYZwlBCt639ofUnwlSrZtlH
 cCz3p6+3VF189ZlTOL0b4xG03gW9FdfZz2vVXuhKzG5rhvadAVpzxPTX/8GuFyjdVH+M
 qJxHR9XRCLznztMq6fGpiUXmJZSoJDWMUJ83CTitplUAyqbNFVmJmrx6ejN9oZWHux2n
 gQ2w==
X-Gm-Message-State: ABy/qLYIjTzBvkqxM7jA1Lues8sg02EbpM/K08VYT4TqeD4sVBx5wosl
 F7cGa1lVYlAF87aB5MUGGWKjISPiYMTiiFJNwXo=
X-Google-Smtp-Source: APBJJlEymD+ibTxrXajkgievA2OX0cO+ewyTxQSFFD5BlQ57w2PQ+QjyLUl+yQoFGvNtcOZmovHvDQ==
X-Received: by 2002:a05:6000:8d:b0:30a:e70d:8022 with SMTP id
 m13-20020a056000008d00b0030ae70d8022mr2254173wrx.26.1690297157043; 
 Tue, 25 Jul 2023 07:59:17 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d4411000000b003176eab8868sm1851191wrq.82.2023.07.25.07.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
Date: Tue, 25 Jul 2023 16:58:27 +0200
Message-Id: <20230725145829.37782-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that in page_table_walk_refill() we can
shift by a negative number, which is undefined behaviour
(CID 1452918, 1452920, 1452922).  We already catch the
negative directory_shift and leaf_shift as being a "bail
out early" case, but not until we've already used them to
calculated some offset values.

The shifts can be negative only if ptew > 1, so make the
bail-out-early check look directly at that, and only
calculate the shift amounts and the offsets based on them
after we have done that check. This allows
us to simplify the expressions used to calculate the
shift amounts, use an unsigned type, and avoids the
undefined behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[PMD: Check for ptew > 1, use unsigned type]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230717213504.24777-3-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e7be649b02..7dbc2e24c4 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -624,7 +624,7 @@ static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
 static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         int directory_index, bool *huge_page, bool *hgpg_directory_hit,
         uint64_t *pw_entrylo0, uint64_t *pw_entrylo1,
-        int directory_shift, int leaf_shift)
+        unsigned directory_shift, unsigned leaf_shift)
 {
     int dph = (env->CP0_PWCtl >> CP0PC_DPH) & 0x1;
     int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
@@ -730,21 +730,11 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
 
     /* Other HTW configs */
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
-
-    /* HTW Shift values (depend on entry size) */
-    int directory_shift = (ptew > 1) ? -1 :
-            (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
-    int leaf_shift = (ptew > 1) ? -1 :
-            (ptew == 1) ? native_shift + 1 : native_shift;
+    unsigned directory_shift, leaf_shift;
 
     /* Offsets into tables */
-    int goffset = gindex << directory_shift;
-    int uoffset = uindex << directory_shift;
-    int moffset = mindex << directory_shift;
-    int ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
-    int ptoffset1 = ptoffset0 | (1 << (leaf_shift));
-
-    uint32_t leafentry_size = 1 << (leaf_shift + 3);
+    unsigned goffset, uoffset, moffset, ptoffset0, ptoffset1;
+    uint32_t leafentry_size;
 
     /* Starting address - Page Table Base */
     uint64_t vaddr = env->CP0_PWBase;
@@ -766,10 +756,22 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         /* no structure to walk */
         return false;
     }
-    if ((directory_shift == -1) || (leaf_shift == -1)) {
+    if (ptew > 1) {
         return false;
     }
 
+    /* HTW Shift values (depend on entry size) */
+    directory_shift = (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
+    leaf_shift = (ptew == 1) ? native_shift + 1 : native_shift;
+
+    goffset = gindex << directory_shift;
+    uoffset = uindex << directory_shift;
+    moffset = mindex << directory_shift;
+    ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
+    ptoffset1 = ptoffset0 | (1 << (leaf_shift));
+
+    leafentry_size = 1 << (leaf_shift + 3);
+
     /* Global Directory */
     if (gdw > 0) {
         vaddr |= goffset;
-- 
2.38.1


