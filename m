Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959AB7D9C19
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO08-0007Ck-Fr; Fri, 27 Oct 2023 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-0007C4-TL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO05-00087L-AK
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso16183655e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417588; x=1699022388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G4T7dDLrOJKZDU+ds04tfI7Pw4la8fB/BtcixevuJFg=;
 b=tVA3Lty62IvMHv+ILnItuAmvEh/iiJIq/nnuPzWCIxyZyaK20rhqUnLINdFxL9NJnV
 M8HPcBrpic9hYCgZGEkxggSfcgB4/cG8ijEnPc+7e2IYVqtXoUyCOLO3NMwbAgyGq2nO
 UtiWOidHReKEK8jJBz5YVtMmSXhIOPxvvgEcc0x8Xh3FdjtTzdDAxOcVjMrCEb1blZDM
 NInqehJi7euH3+Y9rR6nUhuHrqlF9Tf20sszo/ys5zbQL63y1eMdy2ZIxhSRJ3CQQZml
 7rqxQioZVj3GMT7mBHMzGosu6nJ+Zq4clEQcjKF79WT4M2OXTcCuvQaitcI7AFbGMvMb
 WHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417588; x=1699022388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4T7dDLrOJKZDU+ds04tfI7Pw4la8fB/BtcixevuJFg=;
 b=Dfmw/Jn6iJdOS+wMPhD61b/MOpz/Ai350HXFZocy1Q6irtse/ZCSYFZin155C9DJiS
 E93FmWZwngNRxmfau5/NacY5YoCmfW2sHgP5DjINb4RldEXoNuCgWQJfLGcr3bGcilON
 5tPUD1XHvalRVUT7oSkhIUQL/azRvmWz7WX0vTuvUq+bR5WtG7B6tMnXtQA0cnyHmPmr
 S8FzrhXJ7XjlqB/zVHZujXQHRUp4Ss4yCcqrTVf0+ffOiZ08G52aw0zkEljZC70FJJGC
 yKl9OJ+B4y46GJx5ANqMGo+9E1Y8pI5rki0kjIw+WoD5EsQkutmVnr5o0ZUwOGvV/cFB
 UzrA==
X-Gm-Message-State: AOJu0YykfEHHx0B0pK+2s6RdTM9lvaXwQVpDUJmg4YlLTxfF4q8y3CTL
 tjYbB7fb3KHf6T+c4DPGfhu3dhokxWDsD0vYfyo=
X-Google-Smtp-Source: AGHT+IG03v6QOC4xXsOvH9fa6S90dqaWiDowquJ1hdRfAhikl0VnjSQBKy5WBnX9dIm46Qp5z/RQUw==
X-Received: by 2002:adf:ef90:0:b0:32d:a0b6:1860 with SMTP id
 d16-20020adfef90000000b0032da0b61860mr2473780wro.49.1698417587958; 
 Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] target/arm: Move ID_AA64DFR* feature tests together
Date: Fri, 27 Oct 2023 15:39:09 +0100
Message-Id: <20231027143942.3413881-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Move all the ID_AA64DFR* feature test functions together.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-7-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 0ed05b8b19e..66212cd7ecc 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -857,6 +857,11 @@ static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
 }
 
+static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
+}
+
 static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
@@ -922,11 +927,6 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
 }
 
-static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
-}
-
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
-- 
2.34.1


