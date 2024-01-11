Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C07482ACED
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssk-0001h3-Hr; Thu, 11 Jan 2024 06:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PK-1S
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssF-0004We-Kj
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso4417176f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971122; x=1705575922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fWlADWMhxcWSj2fBgtd1Encmql0Bt3u3mAlUopxgc3A=;
 b=Y/uDy4jSr9p1NXgu8wUCZVu2lXxMWjnFMpR3t8iZdkQSh5e5fqREpWxUQRWyueaSvA
 cX0DFZ0TYF9eRDl1F6axRldM8MxiFkZ3rE7EyCTMuCkHMiDBp8vRjPIsIUNjlOYVe/a9
 mdQHyzo7vOKj3oopt4r05MoVFbT6tLr4z0QCP4gifJr0bRHORmwf9d+z5XQIC4n3dhMR
 I+0WMM/eUTFwRgmfRvtD8UNc/YsBSfBmHiseL0hVDKzj1RXzdsacqcrg0jDQEsINv7lI
 5JsR/qo69fBgR3Nn5d/GFXYsFw0PPTUJBMIP+tdOz0P4arE90EUVjSpRHgQhZFgNv8K5
 hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971122; x=1705575922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWlADWMhxcWSj2fBgtd1Encmql0Bt3u3mAlUopxgc3A=;
 b=e9wVFyv/2dn+YmI4mRM213dgeBbeNkzjkg59qh4ECvEWHuvluyTpCG6IfEXtlI13+t
 d9hGtmus57SEGhJdzaVjuO5zRUOpU6APB+yTT6s7nSk3dJvAVTipAwWwej0N5ZxpBTHR
 WzbSe//oT+Xmx8YdWE0zWUJBm5l+ZIU1T775arDtSybYRVcHQ7GEVkmFqv/eWx7vsjAn
 OlTqJBZgxGlbrKIB1EgGbdKfQOwoYxifSggvw8c8hHlHDHAbtgQsPjDgzYTNdsOZ9rXF
 yFSbLgf96mjcubG8iUUFbdl2ci3lV9ruj/nv1JOBT1BzYkIsaKAJuQdy32j6MhXzQb69
 gSSQ==
X-Gm-Message-State: AOJu0YyxyDNuOSeq3uq1m3RI2w77rQFyyx8fEJFxrxR7mc7Z6GcoUftm
 K04zUaYori3XIk7XT9RqTVcR5r4A0v4Ntl5X7EpDhB3S3Cg=
X-Google-Smtp-Source: AGHT+IG268QGShFuZwW49gssS0NTDNqlYZO0RnnyBI+nNXIAHm07iIVi8DtDZtV/7z+Xczafwdt0jQ==
X-Received: by 2002:adf:ee41:0:b0:336:6dd3:bfcf with SMTP id
 w1-20020adfee41000000b003366dd3bfcfmr520267wro.121.1704971122007; 
 Thu, 11 Jan 2024 03:05:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] target/arm: Mark up VNCR offsets (offsets 0x0..0xff)
Date: Thu, 11 Jan 2024 11:04:58 +0000
Message-Id: <20240111110505.1563291-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Mark up the cpreginfo structs to indicate offsets for system
registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
the Arm ARM. This commit covers offsets below 0x100; all of these
registers are redirected to memory regardless of the value of
HCR_EL2.NV1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 93991c07b78..bc5a0810421 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6059,6 +6059,7 @@ static const ARMCPRegInfo hcrx_el2_reginfo = {
     .name = "HCRX_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 2,
     .access = PL2_RW, .writefn = hcrx_write, .accessfn = access_hxen,
+    .nv2_redirect_offset = 0xa0,
     .fieldoffset = offsetof(CPUARMState, cp15.hcrx_el2),
 };
 
@@ -6125,6 +6126,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
+      .nv2_redirect_offset = 0x78,
       .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
@@ -6209,6 +6211,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
       .access = PL2_RW,
+      .nv2_redirect_offset = 0x40,
       /* no .writefn needed as this can't cause an ASID change */
       .fieldoffset = offsetof(CPUARMState, cp15.vtcr_el2) },
     { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
@@ -6220,6 +6223,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
+      .nv2_redirect_offset = 0x20,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
@@ -6228,6 +6232,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "TPIDR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 2,
       .access = PL2_RW, .resetvalue = 0,
+      .nv2_redirect_offset = 0x90,
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
@@ -6323,6 +6328,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 0,
       .writefn = gt_cntvoff_write,
+      .nv2_redirect_offset = 0x60,
       .fieldoffset = offsetof(CPUARMState, cp15.cntvoff_el2) },
     { .name = "CNTVOFF", .cp = 15, .opc1 = 4, .crm = 14,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS | ARM_CP_IO,
@@ -6361,6 +6367,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HSTR_EL2", .state = ARM_CP_STATE_BOTH,
       .cp = 15, .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 3,
       .access = PL2_RW,
+      .nv2_redirect_offset = 0x80,
       .fieldoffset = offsetof(CPUARMState, cp15.hstr_el2) },
 };
 
@@ -6386,10 +6393,12 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
     { .name = "VSTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 0,
       .access = PL2_RW, .accessfn = sel2_access,
+      .nv2_redirect_offset = 0x30,
       .fieldoffset = offsetof(CPUARMState, cp15.vsttbr_el2) },
     { .name = "VSTCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 6, .opc2 = 2,
       .access = PL2_RW, .accessfn = sel2_access,
+      .nv2_redirect_offset = 0x48,
       .fieldoffset = offsetof(CPUARMState, cp15.vstcr_el2) },
 };
 
@@ -8155,6 +8164,7 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 2, .opc2 = 0,
       .access = PL2_RW,
       .writefn = vncr_write,
+      .nv2_redirect_offset = 0xb0,
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
@@ -8986,6 +8996,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
               .access = PL2_RW, .resetvalue = cpu->midr,
               .type = ARM_CP_EL3_NO_EL2_C_NZ,
+              .nv2_redirect_offset = 0x88,
               .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
             { .name = "VMPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
@@ -8997,6 +9008,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
               .access = PL2_RW, .resetvalue = vmpidr_def,
               .type = ARM_CP_EL3_NO_EL2_C_NZ,
+              .nv2_redirect_offset = 0x50,
               .fieldoffset = offsetof(CPUARMState, cp15.vmpidr_el2) },
         };
         /*
-- 
2.34.1


