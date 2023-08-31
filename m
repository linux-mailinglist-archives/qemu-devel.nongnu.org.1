Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50478EABC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBF-0003in-Km; Thu, 31 Aug 2023 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-0003Yc-NX
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:32 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB0-00043E-BS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:30 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500cefc3644so1337371e87.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478724; x=1694083524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVOuGivkVkqx+z9AuvvbwwEp8j+j9CudGauQPKqJ+z4=;
 b=Ul281Byx4L6d9kX41iMTaNRW4X8HaIRHb2mtMCIDB4wgoAelGdSaNqZq1n6kil7s3q
 XOIlVCCFYTyljiP29JodVNqXAXnWQTdjDleaJdT0HOVvqmO3c4HPfsX77rb7+VVe3NOT
 w7H71sOLEEdwuUfqBXDrrr1eDmtsRfAXnZJZNW0K62zCokJPQO1VD9cjknZ7QNJuiSx0
 tBV3U12PQZwlAVTeD5Fee9+W4U1RP1ZEetlLVbyVqCKWWg1UJDiApgvynG3Bqii7xQer
 F0YrxTbClSWvCw5IDheoOGWmyLsIsUIn6hcQTYbNu9Xfte7UuHue8IxvZFFir6Vadgtv
 /H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478724; x=1694083524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVOuGivkVkqx+z9AuvvbwwEp8j+j9CudGauQPKqJ+z4=;
 b=MwUBk93RY4ixLf/9EomUbJvOkZZv/LDkKBQV9XL/9mbvQLLggch2hcORTG8uaFRX2p
 W+pgWT8Wg61Q7KmcJR1fluXLA/SdggLYTqDy5DBHMyEGHBUL6usbhoPpEeIarNg6BcOr
 I3jgIdFSpMicdpXUmcHGKfyQSaiMb9Jb3YgiMumX3+v3A9LdaBCedou1dsOlfuQalMMf
 kNA/qXV9GU+4NlyCgbuSB9rEWbUxg4MTSVHibVhqNVb/oYSKEKIlxaKVkhT7Dz6FMHkQ
 g+D+RIQGQ4ffWyFbMa4NdelW5Opk+Zq8Aj8Y9WGw81otqucLgC0V1zEg54FE/y+Ci69X
 D5jA==
X-Gm-Message-State: AOJu0Yx6NaXsyvfrm1ecIl3JLJlf9ebY4+PgB3mwoKzts2j0lZt8x3V6
 kVwmwrieRVqksMXjuHm6wiBslQpjtAOvIUxSv0w=
X-Google-Smtp-Source: AGHT+IGgLxujwfxheEb+litsZND+9orQgtHvA7BiZtNrJZcJejuhR2uyDw7g4DCfZvkBv8/zoO7OYw==
X-Received: by 2002:a19:7b06:0:b0:4f8:5d0f:c779 with SMTP id
 w6-20020a197b06000000b004f85d0fc779mr3382119lfc.40.1693478724348; 
 Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/24] target/arm: Implement FEAT_HPDS2 as a no-op
Date: Thu, 31 Aug 2023 11:45:04 +0100
Message-Id: <20230831104519.3520658-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

This feature allows the operating system to set TCR_ELx.HWU*
to allow the implementation to use the PBHA bits from the
block and page descriptors for for IMPLEMENTATION DEFINED
purposes.  Since QEMU has no need to use these bits, we may
simply ignore them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu32.c        | 2 +-
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bdafc68819b..2012bbf7c7c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -40,6 +40,7 @@ the following architecture extensions:
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
+- FEAT_HPDS2 (Translation table page-based hardware attributes)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 47d2e8e7811..1f918ff5375 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -62,7 +62,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr3 = t;
 
     t = cpu->isar.id_mmfr4;
-    t = FIELD_DP32(t, ID_MMFR4, HPDS, 1);         /* FEAT_AA32HPD */
+    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b0cac05be65..11e406d960e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -852,7 +852,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
     t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
     t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1);     /* FEAT_HPDS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* FEAT_HPDS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
     t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-- 
2.34.1


