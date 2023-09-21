Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3797A9865
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcN-000211-LI; Thu, 21 Sep 2023 13:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcJ-00020I-Mi
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcG-0007f4-As
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4053c6f0d3dso533725e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317845; x=1695922645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4t8raamjkiKMFho/Exbq5puDMqJZ2LBIGrDxmNB/Oe8=;
 b=wFtpOJf0RaeeADR9N+fGgodSD1Q3LGZaT3zSidc/MRrbaIqcCkToJSxVaFuDrUGGHt
 BpxLL6IOBztbwm1Xd2JbnhUtsV442jTLyD8vSzLndb0MwkjH5dfdwXKD+jfyYE/QkAMZ
 J1VNl8FWCHwBi7XPcjOOaH4z0jtJ017z/F4aL6Rs9WxhBneSyw8tqd6YhmGZiGuqIVZ9
 Lir9cd5QJB+vpVABi0SbkGID07o3ycWLofWIsU5jek3eguTMUx1gwz8R1vrLB04WDqj0
 f2jj/apzRs4AykYOvi7VL7wxEyX+lttw5J8bphPHKmu0JpTGRLh5ImDq/BJuAM9/6UQS
 HHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317845; x=1695922645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4t8raamjkiKMFho/Exbq5puDMqJZ2LBIGrDxmNB/Oe8=;
 b=ip51TzKU0manho6tNb/vf28yjiZDBw3hwtrufj9k+FNlpdUERBtTYl6m+GlHQLhM4n
 n6LKToIJxJxrUobxYV9Sq7wxZ4Sr+x5mBZdA0CHtQQZ3UOb4VQxvAOlYwnBHZobQTpyC
 kTfoKP6hDgEkqLe48tmDNb0tcAWjRoxvEG6SRGFuQj1dR/BlPAT8R3dtMSPJUZWc5Pd9
 jgZQSjfKXca/sPPHmsJAm7c76uSTwGO9swcVRPa+5qFfWM2htNoxlburOVLrMNR3js5q
 Z9MVTTfyFsUT8LboJ6jOBEv1D81jRW2Me4t6nXvAZqtr3k3vlILP8nhJOXtWlKdk82nj
 jmhg==
X-Gm-Message-State: AOJu0YxSAfDU2pzVorfoXg9pxXymrWascrHH0axEOIOUSahFdXMB8b5l
 Mf4oN4AgTk0xgHMEYcV+RL2qSyaJVfIA8cur13k=
X-Google-Smtp-Source: AGHT+IEv3rzgWDGdkPEPg5umUvyavz9U9zaNrrRgE/sZ0DzutnbW9ZO9Nak80Cqh975CoNGbHMEKJw==
X-Received: by 2002:a1c:f204:0:b0:404:fc5c:15ed with SMTP id
 s4-20020a1cf204000000b00404fc5c15edmr5418152wmc.35.1695317845578; 
 Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/30] target/arm: Update AArch64 ID register field definitions
Date: Thu, 21 Sep 2023 18:36:57 +0100
Message-Id: <20230921173720.3250581-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Update our AArch64 ID register field definitions from the 2023-06
system register XML release:
 https://developer.arm.com/documentation/ddi0601/2023-06/

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f2e3dc49a66..7ba2402f727 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2166,6 +2166,7 @@ FIELD(ID_AA64ISAR0, SHA1, 8, 4)
 FIELD(ID_AA64ISAR0, SHA2, 12, 4)
 FIELD(ID_AA64ISAR0, CRC32, 16, 4)
 FIELD(ID_AA64ISAR0, ATOMIC, 20, 4)
+FIELD(ID_AA64ISAR0, TME, 24, 4)
 FIELD(ID_AA64ISAR0, RDM, 28, 4)
 FIELD(ID_AA64ISAR0, SHA3, 32, 4)
 FIELD(ID_AA64ISAR0, SM3, 36, 4)
@@ -2200,6 +2201,13 @@ FIELD(ID_AA64ISAR2, APA3, 12, 4)
 FIELD(ID_AA64ISAR2, MOPS, 16, 4)
 FIELD(ID_AA64ISAR2, BC, 20, 4)
 FIELD(ID_AA64ISAR2, PAC_FRAC, 24, 4)
+FIELD(ID_AA64ISAR2, CLRBHB, 28, 4)
+FIELD(ID_AA64ISAR2, SYSREG_128, 32, 4)
+FIELD(ID_AA64ISAR2, SYSINSTR_128, 36, 4)
+FIELD(ID_AA64ISAR2, PRFMSLC, 40, 4)
+FIELD(ID_AA64ISAR2, RPRFM, 48, 4)
+FIELD(ID_AA64ISAR2, CSSC, 52, 4)
+FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
 FIELD(ID_AA64PFR0, EL0, 0, 4)
 FIELD(ID_AA64PFR0, EL1, 4, 4)
@@ -2227,6 +2235,12 @@ FIELD(ID_AA64PFR1, SME, 24, 4)
 FIELD(ID_AA64PFR1, RNDR_TRAP, 28, 4)
 FIELD(ID_AA64PFR1, CSV2_FRAC, 32, 4)
 FIELD(ID_AA64PFR1, NMI, 36, 4)
+FIELD(ID_AA64PFR1, MTE_FRAC, 40, 4)
+FIELD(ID_AA64PFR1, GCS, 44, 4)
+FIELD(ID_AA64PFR1, THE, 48, 4)
+FIELD(ID_AA64PFR1, MTEX, 52, 4)
+FIELD(ID_AA64PFR1, DF2, 56, 4)
+FIELD(ID_AA64PFR1, PFAR, 60, 4)
 
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
 FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
@@ -2258,6 +2272,7 @@ FIELD(ID_AA64MMFR1, AFP, 44, 4)
 FIELD(ID_AA64MMFR1, NTLBPA, 48, 4)
 FIELD(ID_AA64MMFR1, TIDCP1, 52, 4)
 FIELD(ID_AA64MMFR1, CMOW, 56, 4)
+FIELD(ID_AA64MMFR1, ECBHB, 60, 4)
 
 FIELD(ID_AA64MMFR2, CNP, 0, 4)
 FIELD(ID_AA64MMFR2, UAO, 4, 4)
@@ -2279,7 +2294,9 @@ FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
 FIELD(ID_AA64DFR0, BRPS, 12, 4)
+FIELD(ID_AA64DFR0, PMSS, 16, 4)
 FIELD(ID_AA64DFR0, WRPS, 20, 4)
+FIELD(ID_AA64DFR0, SEBEP, 24, 4)
 FIELD(ID_AA64DFR0, CTX_CMPS, 28, 4)
 FIELD(ID_AA64DFR0, PMSVER, 32, 4)
 FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
@@ -2287,12 +2304,14 @@ FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
 FIELD(ID_AA64DFR0, TRACEBUFFER, 44, 4)
 FIELD(ID_AA64DFR0, MTPMU, 48, 4)
 FIELD(ID_AA64DFR0, BRBE, 52, 4)
+FIELD(ID_AA64DFR0, EXTTRCBUFF, 56, 4)
 FIELD(ID_AA64DFR0, HPMN0, 60, 4)
 
 FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
 FIELD(ID_AA64ZFR0, AES, 4, 4)
 FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
 FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
+FIELD(ID_AA64ZFR0, B16B16, 24, 4)
 FIELD(ID_AA64ZFR0, SHA3, 32, 4)
 FIELD(ID_AA64ZFR0, SM4, 40, 4)
 FIELD(ID_AA64ZFR0, I8MM, 44, 4)
@@ -2300,9 +2319,13 @@ FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
+FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F16F16, 42, 1)
+FIELD(ID_AA64SMFR0, B16B16, 43, 1)
+FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
-- 
2.34.1


