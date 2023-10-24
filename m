Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604657D58A4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKNZ-0002CQ-E4; Tue, 24 Oct 2023 12:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNE-0001xq-RL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKN9-0004ML-SB
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso38745685e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698165314; x=1698770114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V1oMrg7qxzgr5UV6tTr5kRpEnk47K095nUSDvFl0pXU=;
 b=n9zfBuLWF2ALn0GZWk+bmaQeH5miYkvUZ5pZWv9jQswZwQynEiZt7VfBMNWTDnUW74
 2h9Mx0g2Bqkza5krLq+6rADjzDgoI06a70/KkUBjoC0gy59TcY629grKxNKRdIxptNxg
 WGoINd8mYZVr8xNX320yrqg/AU7lkvg1CbSuw05GftYI9t2PkTC1VWguSbIpY0v/WKJx
 wmOe3nKJieDVa8KNyqNUJTPVBiRgvt5d3vIN2pw6lJNGaWQUYhOez+0DKdasWe7nhKVM
 31iSsOMkjwXR08SRA9nGmnnY4FBmn+19NsjvbXKk1cPOmaNgvF85KoEX0dsXhGF7pNc5
 fdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165314; x=1698770114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1oMrg7qxzgr5UV6tTr5kRpEnk47K095nUSDvFl0pXU=;
 b=GWq9CgoPv10bSlOCJ50rc/WrqSrxQgUWA5jR/qtLSjk3gqfiCELRjTRbIk4hOQ+wcn
 JXSysc7q5rFZHhFbnZSNfuHVpLLdyf/VDjljdt9EjhOYcJXWwivhCcRaL2s0BGxppobB
 V24/k7x5zUWH1ttdbnJXbT031ks5sX5lAsSwzEcGNueZ9IqXucW2QN0QqSgGyPCWn3rH
 pSTMCSIp8Cxa1OHSNJSPGLIp2sq02GHtMPEz+MJdEgVkbLKswtH/kRMlNsPpFSGqyeGN
 LVYs3n+5Ugy6v2NUk3qjNJ5vMvnaS94mPTlv/BCs9Meh+jtbAkVoBVKy8aEcwTwp/8sG
 vyhw==
X-Gm-Message-State: AOJu0YyXi07zOb1vLquUG435znNd4PC6Mzha7kxsC5gVXucogTo7cI0s
 NT0YVclJ02c947vvCXGLjn8YAg==
X-Google-Smtp-Source: AGHT+IF3vks8AOffXuexpkCrOLhSCnrEJ0OA8cQtpHd2Oei+ZwpIbNo6MDs2iB+TgkMco9DwDvLyng==
X-Received: by 2002:a05:600c:3508:b0:409:c1e:7fe8 with SMTP id
 h8-20020a05600c350800b004090c1e7fe8mr2315214wmq.19.1698165314249; 
 Tue, 24 Oct 2023 09:35:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm16860101wmh.11.2023.10.24.09.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:35:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests
 together
Date: Tue, 24 Oct 2023 17:35:06 +0100
Message-Id: <20231024163510.2972081-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024163510.2972081-1-peter.maydell@linaro.org>
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Our list of isar_feature functions is not in any particular order,
but tests on fields of the same ID register tend to be grouped
together.  A few functions that are tests of fields in ID_AA64MMFR1
and ID_AA64MMFR2 are not in the same place as the rest; move them
into their groups.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index bfc9bfafe70..fc85a8fe130 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -641,6 +641,21 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
+static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
+}
+
+static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
+}
+
+static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+}
+
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
@@ -676,6 +691,21 @@ static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
 }
 
+static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+}
+
+static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
+}
+
+static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
@@ -794,36 +824,6 @@ static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
 }
 
-static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
-}
-
-static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
-}
-
-static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
-}
-
-static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
-}
-
-static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
-}
-
-static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
-}
-
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
-- 
2.34.1


