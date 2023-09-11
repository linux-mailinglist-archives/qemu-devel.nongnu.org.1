Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B916879A868
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMV-0005qA-Mu; Mon, 11 Sep 2023 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMT-0005oR-Qb
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMJ-0003AU-Qw
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3635730f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440425; x=1695045225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u1Sxay0lp7tBIXUdn25IytxwGH8GR+kgQRzldh5/VB4=;
 b=BCfb8zw9jAvGrNBelKWG1jLTGU/fgpV2Ufd/fsFX5xrNyWAyaySnqpRU5SU0bQqqMC
 xdoxdDDSqYHlIuKoSvxoupY+zJE0U7POME5QdHUb4edp0I0FoP0fB0Vo8uq+GanNE7+F
 liFAAreGR9t1okaBuKra5i08V4ldw/YwQMUG7RdnOfDJ88lEDJhpyVXdAtk20TnrnQWM
 DwZvzgH3pl0tMZfJc+gYDo2cS7kqSsY6eQqIPrgnVpOLhfBy1/sISoTJLD7QceyJUI1o
 olusJbX/wSBYM9ULWCMRn8CToyVAjjJU507/GdXNYYWHC2qDtNCRm8H3Zw9DztMK/HVo
 Jb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440425; x=1695045225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1Sxay0lp7tBIXUdn25IytxwGH8GR+kgQRzldh5/VB4=;
 b=SrClPXnzolXnRpPdV+4aFTh10CROAZSiJrwbEuLoOvJpQBWwMndRb2PNyrA55dpFv+
 GqsjPHwZfFtkqE13xtRpaKrIZ8Q4XdGIW2hjOP47CruCazAXtUtfqc62mtml6cnFyIRv
 cVxaDXgdTflwIneaqVLyIy4wfs+Z5aNjdmiHro7puVPmrYxD/CMzQqQbMMow2NHUhuHG
 fqC3qPES0UkdmXMUOU7L/4xzMSQxfhIOKPnfNvxd4b54qKn2GSTWcew3g8lHcbtJIipI
 pZzuB9b9w9I4wSvO04nQNeKFTOBYAR3sJHSFDmFLNlGe+BIqjfxJtqdUcqLD6GX2wnCi
 wQFw==
X-Gm-Message-State: AOJu0YwPbni6dRa4Zcb72IOGpgzptmOoTYOzv7L21XwbjUeV2R8n8Ht0
 ZKcs15RNPVObqZRm7qm4Rd8qvA==
X-Google-Smtp-Source: AGHT+IHFX6oTijBB0X2/hDEkrL9z5/Yn0JT1p86dnC57QDjmUupgyqZ7B5TrJpME9Ze1VuKtJ9YtZA==
X-Received: by 2002:adf:fc12:0:b0:31c:e933:9593 with SMTP id
 i18-20020adffc12000000b0031ce9339593mr8238197wrr.6.1694440425287; 
 Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/arm: Update AArch64 ID register field definitions
Date: Mon, 11 Sep 2023 14:53:38 +0100
Message-Id: <20230911135340.1139553-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
---
This is intended to allow updating the set of ID register
fields we expose for user-only mode, so I have only
updated the AArch64 ID registers, not AArch32.
---
 target/arm/cpu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e637796fd83..eddf2d3b72c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2165,6 +2165,7 @@ FIELD(ID_AA64ISAR0, SHA1, 8, 4)
 FIELD(ID_AA64ISAR0, SHA2, 12, 4)
 FIELD(ID_AA64ISAR0, CRC32, 16, 4)
 FIELD(ID_AA64ISAR0, ATOMIC, 20, 4)
+FIELD(ID_AA64ISAR0, TME, 24, 4)
 FIELD(ID_AA64ISAR0, RDM, 28, 4)
 FIELD(ID_AA64ISAR0, SHA3, 32, 4)
 FIELD(ID_AA64ISAR0, SM3, 36, 4)
@@ -2199,6 +2200,13 @@ FIELD(ID_AA64ISAR2, APA3, 12, 4)
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
@@ -2226,6 +2234,12 @@ FIELD(ID_AA64PFR1, SME, 24, 4)
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
@@ -2257,6 +2271,7 @@ FIELD(ID_AA64MMFR1, AFP, 44, 4)
 FIELD(ID_AA64MMFR1, NTLBPA, 48, 4)
 FIELD(ID_AA64MMFR1, TIDCP1, 52, 4)
 FIELD(ID_AA64MMFR1, CMOW, 56, 4)
+FIELD(ID_AA64MMFR1, ECBHB, 60, 4)
 
 FIELD(ID_AA64MMFR2, CNP, 0, 4)
 FIELD(ID_AA64MMFR2, UAO, 4, 4)
@@ -2278,7 +2293,9 @@ FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
 FIELD(ID_AA64DFR0, BRPS, 12, 4)
+FIELD(ID_AA64DFR0, PMSS, 16, 4)
 FIELD(ID_AA64DFR0, WRPS, 20, 4)
+FIELD(ID_AA64DFR0, SEBEP, 24, 4)
 FIELD(ID_AA64DFR0, CTX_CMPS, 28, 4)
 FIELD(ID_AA64DFR0, PMSVER, 32, 4)
 FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
@@ -2286,6 +2303,7 @@ FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
 FIELD(ID_AA64DFR0, TRACEBUFFER, 44, 4)
 FIELD(ID_AA64DFR0, MTPMU, 48, 4)
 FIELD(ID_AA64DFR0, BRBE, 52, 4)
+FIELD(ID_AA64DFR0, EXTTRCBUFF, 56, 4)
 FIELD(ID_AA64DFR0, HPMN0, 60, 4)
 
 FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
@@ -2299,9 +2317,13 @@ FIELD(ID_AA64ZFR0, F32MM, 52, 4)
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


