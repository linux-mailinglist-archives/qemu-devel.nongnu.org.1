Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC0756EFF
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsN-0001yo-IQ; Mon, 17 Jul 2023 17:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVsL-0001ye-C1
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVsJ-0007zl-NT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31590e4e27aso4523991f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689629722; x=1692221722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UWwa1uuZikYOyZrtVyQHLSGe/yJoGLD5CEgAH5+Sh8=;
 b=PAvLYQZ7rjAmuseppjocnQrUuVjQO05jar+REvDJa4waB3eIlKi6Mvk80jY9dP1Cwu
 gLx7T6AMEZqGKhakOIgE68Pa/Qb6OvPaCl/q5UoxpA0ttMR2+GDL1wP2pwruCnnQhE15
 u3MZKuaL02YVjxgA97fKtBxztIzAXOWTqR4slj4hAvyTd/I9VYdEqXUmz8+t8S7UsO+L
 sbJKShP5PxYBrhDLupidqMlBLWo6izOpLPk7tTlqOSrmJv9CZ74uT2Vy1fQqRogkBNbY
 lfoeTu+EELCMLo34i34ak2ZPgwecTADHkFihgBFMhqMBBKwUS+SKbsJ4hV1q5aVxKPzL
 kXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689629722; x=1692221722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UWwa1uuZikYOyZrtVyQHLSGe/yJoGLD5CEgAH5+Sh8=;
 b=e3VQAS30Nw7qxN+xAug9t3fFVaqS8RktxmRvVhNVh6aob+hgoMqmZFRjJswS/Ee6hK
 BxiTvEnusg7hX83vHGtocfkwPVYNFpkFhkmWyDsBQU318h7Ce8YgDq1wbRlprOLijqxq
 Dz6cHpWbP/mZtRDMuVYc54Y+0TQEXlOJBQxTYXbUWgZKbU0xolOC2a6mzDoDA1AZrtI1
 hQmwr5Y90BPpo/xlub+n2w7eXij1TvKMDGHqizNqsKRpzVGfmCSGIvv7lBxXi+dG7vag
 u+9swABX1oTVTqlKEj7Gro1DVsEahPwXkgxJwI49QzzFgtTXvVgI2/jS20hU6R3TO9hm
 o5yA==
X-Gm-Message-State: ABy/qLb4n3l1n7dZjEcIWTqGXlGBu5FOdhpk9H9k5XG6Kd5ihOiviB+4
 pCIo7xBoYFXhxNv0dyHI412jXRtai00tNPzr7X0=
X-Google-Smtp-Source: APBJJlGLgSYtHg+d8UKceGcpXoAgDOZhhiLNW5W7hy7aQxylwPKhAR2hliynwgfd6vbVz6RvfUWKig==
X-Received: by 2002:adf:d092:0:b0:314:220d:7 with SMTP id
 y18-20020adfd092000000b00314220d0007mr272277wrh.45.1689629722084; 
 Mon, 17 Jul 2023 14:35:22 -0700 (PDT)
Received: from localhost.localdomain ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4850000000b00313e4d02be8sm475148wrs.55.2023.07.17.14.35.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jul 2023 14:35:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-8.1 v2 2/2] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
Date: Mon, 17 Jul 2023 23:35:04 +0200
Message-Id: <20230717213504.24777-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717213504.24777-1-philmd@linaro.org>
References: <20230717213504.24777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Coverity points out that in page_table_walk_refill() we can shift by
a negative number, which is undefined behaviour (CID 1452918,
1452920, 1452922).  We already catch the negative directory_shift and
leaf_shift as being a "bail out early" case, but not until we've
already used them to calculated some offset values.

Move the calculation of the offset values to after we've done the
"return early if ptew > 1" check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[PMD: Check for ptew > 1, use unsigned type]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


