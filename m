Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFCB59A24
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Sep 2025 16:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaY-0005uR-AO; Tue, 16 Sep 2025 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa9-0005k3-4B
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWZz-0008I0-Rg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-25caef29325so48616095ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032564; x=1758637364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=942WePPhlrG9gooEEWu4vpO7ddNWZ/8t+XFAij4Q59o=;
 b=u/DU9OewFJy7IbV5ga++dqIY61fLGRcnrkhD+0cRnlrKHoLeSgfkuoBPE96iWYKKUz
 64ug5ukVdKPtvofhB7NHE+TlYfwiGf7JdEN1GXRWDXW5vW6ryVIhiOdbcOJ1xS2sjYQO
 7tl4X48PipYGNWmUg2uAkHxM5GOq00bGQQ7RXi7CEP+6LmF9Pc9JV/5taB4FsU2rjGbW
 tGk/Kp83tN9aOQt42v1Ige0naPIv+ImMEEU/20iK1d/2wW2l8DunwlHgyDKSkpeMLxYT
 Lrh445s9PK1dZJZBK+1UwvsbFRrSsoNgGGGqCwDx4sAo+uhdk7ritf/IjSarKM+XJEzV
 g6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032564; x=1758637364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=942WePPhlrG9gooEEWu4vpO7ddNWZ/8t+XFAij4Q59o=;
 b=tFWP8ROP07lDuY462yFmA8tUfnnarUgeLF/Pch4nPrLSuSU4Y6XGRPL5RdMmyKZDHG
 Wy86rSGBCh0DpI//tFstWxEObp2PANaSyHR20O84tmjRZ8unUlw6+WFBPFCPM9RnWeJZ
 79MG8Y88Z+mOSKPRYvuPRonNvHfn3RSkAlT7U/z6fqScosmjB2i4Mu+Gu+pdBDNUR2qc
 rctu+QjIhzOaFeF82BNbnrmW/NHvglALzZPxn6oSkqIOr4uJw9YX9Kpcr9Rb5dG4oIVT
 AZHV8uNOHgCz6gu3eqdm0ZbKslPPQSt+Ys0+H75HyUTOAInz2xwzlVud5qIfyzkjqV/0
 r3rQ==
X-Gm-Message-State: AOJu0Yxe29BzyX2jtf6rehFioj7BGWyqQ7NY148sIGf3qsUeDWeIRtYi
 M9LgNKEQuSp6aDD+UOecDnFK2eRgTYVcP7vvUGKfHfBTJKNXnbpA0epZvR21lQFUCpUCL4dyDU0
 F4o/t
X-Gm-Gg: ASbGncurFzjC+NVAp5fV3JX2TggDpbN9u8TyXb/IsM7mwJOSmDVWzTGrpi83xKVrcbQ
 vAsOkFZkrUJHfA9WKM0y2WoB9TDZFNXhBdqa1KIJF4OKZrarfZswbOAGgC9x09Askkf+d6O7Psq
 ByuPhfsSWBXxA2qhPHhhL4IuPBY3SKjGEayDalkNKgPB6jiMhL94/hF4lwojDiLquGP8UsmsUuK
 upS6sjcI1PLHVRAqrHsiAAywaejRsW/r0o0CVSUVb/D2kbxS4v+PFOW/+ANkDX8TiU5OqUTmMP0
 XZI04Ar1yJOd2AGRB04UsnTNxmjPAFf1f/LFv0pN7Oi7a/T9GTj1jWqQwCQt/8Rwskt5skDseOE
 jlfHfj1R1T4X4pdBghztEzN5fyz9+
X-Google-Smtp-Source: AGHT+IGdYWVdIEa78m98YvcoyTCHCMVdHpV5j6yYuZj3bqQgSrnYbYzMkVNFQeMLuh/tItOoSEMPVg==
X-Received: by 2002:a17:903:240d:b0:267:ba92:4d3a with SMTP id
 d9443c01a7336-267ba924f53mr54058185ad.6.1758032563384; 
 Tue, 16 Sep 2025 07:22:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 04/36] target/arm/hvf: Reorder DEF_SYSREG arguments
Date: Tue, 16 Sep 2025 07:22:05 -0700
Message-ID: <20250916142238.664316-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

The order of the parameters in the Arm ARM is

  op0, op1, crn, crm, op2

Reorder the arguments of DEF_SYSREG to match.
Mechanical change to sysreg.c.inc using

  sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\1,\4,\5,\2,\3/'

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        |   2 +-
 target/arm/hvf/sysreg.c.inc | 224 ++++++++++++++++++------------------
 2 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9f8e3083b4..f68924ba1f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,7 +403,7 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
-#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
     { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
 
 static struct hvf_sreg_match hvf_sreg_match[] = {
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 222698f1d1..f2276d534e 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -1,146 +1,146 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 2, 0, 0, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 2, 0, 0, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 2, 0, 0, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 2, 0, 0, 0, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 2, 0, 0, 1, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 2, 0, 0, 1, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 2, 0, 0, 1, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 2, 0, 0, 1, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 2, 0, 0, 2, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 2, 0, 0, 2, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 2, 0, 0, 2, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 2, 0, 0, 2, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 2, 0, 0, 3, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 2, 0, 0, 3, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 2, 0, 0, 3, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 2, 0, 0, 3, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 2, 0, 0, 4, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 2, 0, 0, 4, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 2, 0, 0, 4, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 2, 0, 0, 4, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 2, 0, 0, 5, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 2, 0, 0, 5, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 2, 0, 0, 5, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 2, 0, 0, 5, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 2, 0, 0, 6, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 2, 0, 0, 6, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 2, 0, 0, 6, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 2, 0, 0, 6, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 2, 0, 0, 7, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 2, 0, 0, 7, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 2, 0, 0, 7, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 2, 0, 0, 7, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 2, 0, 0, 8, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 2, 0, 0, 8, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 2, 0, 0, 8, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 2, 0, 0, 8, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 2, 0, 0, 9, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 2, 0, 0, 9, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 2, 0, 0, 9, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 2, 0, 0, 9, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 2, 0, 0, 10, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 2, 0, 0, 10, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 2, 0, 0, 10, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 2, 0, 0, 10, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 2, 0, 0, 11, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 2, 0, 0, 11, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 2, 0, 0, 11, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 2, 0, 0, 11, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 2, 0, 0, 12, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 2, 0, 0, 12, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 2, 0, 0, 12, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 2, 0, 0, 12, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 2, 0, 0, 13, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 2, 0, 0, 13, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 2, 0, 0, 13, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 2, 0, 0, 13, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 2, 0, 0, 14, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 2, 0, 0, 14, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 2, 0, 0, 14, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 2, 0, 0, 14, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 2, 0, 0, 15, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 2, 0, 0, 15, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 2, 0, 0, 15, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 2, 0, 0, 15, 7)
 
 #ifdef SYNC_NO_RAW_REGS
 /*
  * The registers below are manually synced on init because they are
  * marked as NO_RAW. We still list them to make number space sync easier.
  */
-DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
-DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 2, 0, 0, 2, 0)
+DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 3, 0, 0, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 3, 0, 0, 0, 5)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 #endif
 
-DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 
 #ifdef SYNC_NO_MMFR0
 /* We keep the hardware MMFR0 around. HW limits are there anyway */
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 #endif
 
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
 
-DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
-DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 2, 0, 0, 2, 2)
+DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 3, 0, 1, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 3, 0, 1, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 3, 0, 2, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 3, 0, 2, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TCR_EL1, 3, 0, 2, 0, 2)
 
-DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
-DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
-DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 3, 0, 2, 1, 0)
+DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 3, 0, 2, 1, 1)
+DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 3, 0, 2, 1, 2)
+DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 3, 0, 2, 1, 3)
+DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 3, 0, 2, 2, 0)
+DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 3, 0, 2, 2, 1)
+DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 3, 0, 2, 2, 2)
+DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 3, 0, 2, 2, 3)
+DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 3, 0, 2, 3, 0)
+DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 3, 0, 2, 3, 1)
 
-DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
-DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
-DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
-DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
-DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
-DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
-DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
+DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 3, 0, 4, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ELR_EL1, 3, 0, 4, 0, 1)
+DEF_SYSREG(HV_SYS_REG_SP_EL0, 3, 0, 4, 1, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 3, 0, 5, 1, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 3, 0, 5, 1, 1)
+DEF_SYSREG(HV_SYS_REG_ESR_EL1, 3, 0, 5, 2, 0)
+DEF_SYSREG(HV_SYS_REG_FAR_EL1, 3, 0, 6, 0, 0)
+DEF_SYSREG(HV_SYS_REG_PAR_EL1, 3, 0, 7, 4, 0)
+DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 3, 0, 10, 2, 0)
+DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 3, 0, 10, 3, 0)
+DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 3, 0, 12, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 3, 0, 13, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 3, 0, 13, 0, 4)
+DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 3, 0, 14, 1, 0)
+DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 3, 2, 0, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 3, 3, 13, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
+DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
+DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
+DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
-- 
2.43.0


