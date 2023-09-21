Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481617A9846
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNck-0002DZ-BQ; Thu, 21 Sep 2023 13:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNci-0002D3-7y
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcM-0007hA-1i
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso12892155e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317853; x=1695922653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TtwEtjp3KEwvsq3yjTwyNthKzsgdN8hPlxUQdpQeNjE=;
 b=eAu+IgiD1noTz2kplEgJ8yU76gQdYv0erYX4qHnS75Y1RkK8kOVYkr0BYvbDlw1bdD
 5a0T/lIAGriWQbV2k2Ljtwur+T/ZxOiiPOpgLJSvkar/aQxNbFP23uMU8LzqKyW/2Q+Q
 iuJYhkwVU3PmmDnEiycrpvpG6fMEd759er03kp3FD/roSWsM9JHbsYYi5WoFbccUzQWm
 xt/BUj0aZrkqrVNr8U1aUiw04CWrnM0GkC4L+TT7wRqeRV4HBLIM4PSRA410t58/mcV3
 QHcCl2lJ+KqoMFV54qV3lq1EoM2XUqN3crfT6K/9uDpytzv8x5T19smeEDCFnQpiLUDL
 M8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317853; x=1695922653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtwEtjp3KEwvsq3yjTwyNthKzsgdN8hPlxUQdpQeNjE=;
 b=BtrBmeIe2QJowqepepd6WqBiu18Grio13YKQDEUCTPE7p6DIVNMMXxAGKMFxt5sdrx
 j8SqNx094Mg3B8A8i9iNnBMC8lf42BleRdkX6dBjfPQdbRLNhEkiEwy7JJ2lxM1v+ex3
 +DROk1Egyo3Q4fFu2Dx3rSP5uZfMVm1ScxlNY/VYkl1OLHSKqQjRFyHEsi22i3VthuLa
 kMzXaTbcl1MOSP7230y0eUzoJVPuw4vKoLUceHPWZM/KU7/ZWa9nyKIBQBtS0/uxKw45
 6z0bMSObn+/a291/Zd6Z6n+QNK4vJZ9sYD835ISzE5t1dsV1/NU+XDzNQxq+b+p+dIFW
 cVTQ==
X-Gm-Message-State: AOJu0YzCxg1Jnl4BLiEedrhnhQkjhVdzWDwHdvSI6EpTsW4Am74SEKfc
 D2g/lM75Z+aPG8JBND2B7psSNI4OP4piAe/0F7U=
X-Google-Smtp-Source: AGHT+IFJRHtqYdMWxwYv/28J8JBmygD098slB/M1IIopr+daLnPEOL7+EhPk4I9umWod/185RNw+CA==
X-Received: by 2002:a7b:c415:0:b0:3fe:22a9:910 with SMTP id
 k21-20020a7bc415000000b003fe22a90910mr5846737wmi.14.1695317852751; 
 Thu, 21 Sep 2023 10:37:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/30] target/arm: Enable FEAT_MOPS for CPU 'max'
Date: Thu, 21 Sep 2023 18:37:12 +0100
Message-Id: <20230921173720.3250581-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Enable FEAT_MOPS on the AArch64 'max' CPU, and add it to
the list of features we implement.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-13-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/elfload.c          | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1fb6a2e8c3e..965cbf84c51 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -58,6 +58,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 203a2b790d5..db75cd4b33f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -816,6 +816,7 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_i16i64, ARM_HWCAP2_A64_SME_I16I64);
     GET_FEATURE_ID(aa64_sme_fa64, ARM_HWCAP2_A64_SME_FA64);
     GET_FEATURE_ID(aa64_hbc, ARM_HWCAP2_A64_HBC);
+    GET_FEATURE_ID(aa64_mops, ARM_HWCAP2_A64_MOPS);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 57abaea00cd..68928e51272 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1028,6 +1028,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
     cpu->isar.id_aa64isar2 = t;
 
-- 
2.34.1


