Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DD82AD22
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:14:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssZ-0001Rs-MK; Thu, 11 Jan 2024 06:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss9-0001M2-HT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss7-0004QY-LE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337874b8164so359055f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971113; x=1705575913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7B/8lPK1MV7k06ckol/zGTOa+v925bmxBrmmGd2s5s=;
 b=lMdQ6KlH9D1xcB4PL4MD0/UD6UOgg5PwYhQ3RgCoea8T/btwxvcAirG3xHsVFBPX/p
 JoNMiZYzJ1TfRSXExVTdQtURkgPMycDTVfmOh72Doi51G0Pc195YiXv796ygH3BrpMLk
 OGZbY8uoSSXsx3L6OqgSd3q1KWAz8604MXA0IWqzjNVzKsnn3L/OmhqoCZvPH0h+i/R+
 A65aurv/0UMvfjC5smMSsmmNpQTYWCqx4iNNKPG+4wQeUuMKBlcnE+G31GmFuCsGngoC
 HlbuS6Fu+5S7PHtp1UrrCjtOJYFr4xsYIEHyECBIWRfE10W/L7vKsQfKMfqnYVzxl8uF
 tONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971113; x=1705575913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7B/8lPK1MV7k06ckol/zGTOa+v925bmxBrmmGd2s5s=;
 b=fKV92kXtbekHf/VfhZquDaunlQPemNQzUjrESQdJOxuhQUXCEw9awHLeVpdjVo0MBT
 7VjY7QTHHCgN3oh1UFyp4h9mlR3ROTQDaB9WOwuLk5EI6JbTa4jBI0JxrXKYPdDWkYxB
 1rrTmLxDUciN5hYVZ0TaAGEdKaPufs1xy+xQHsjX3YDZ5qUmKPmeAIY/9g/3Q7s1R5rJ
 Ue9Unb5b6ooFp7PW+whyY8duT22J/b9sJtBHbcQVKy4mgl41IYF2ojlzH06ZHPvqi2uF
 hm6vFFPjxl5HuCctKB7r2aBTpjkYsDNJ/iRGoR1nrn/or34qqUCMRy8JTOHRYEhJy+25
 57Hg==
X-Gm-Message-State: AOJu0YyqvcCI7uBq3f52vzLx3AZeh5etW/DOyWwiFlsnKBmTxV2AOput
 XXRN8mepBYnpHrVYP5zEuFrX0p3dMo1MtTH/ZhQDPTPX4kw=
X-Google-Smtp-Source: AGHT+IEbPVU9UaxIQF/4tPfqHZVn3GBAkkclkZ8a7CbX0aj2A58gDlJtYylo1GVJwpBxrPF3zFBKqg==
X-Received: by 2002:adf:ce83:0:b0:336:7790:6a36 with SMTP id
 r3-20020adfce83000000b0033677906a36mr542344wrn.129.1704971113683; 
 Thu, 11 Jan 2024 03:05:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] target/arm: *_EL12 registers should UNDEF when
 HCR_EL2.E2H is 0
Date: Thu, 11 Jan 2024 11:04:40 +0000
Message-Id: <20240111110505.1563291-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

The alias registers like SCTLR_EL12 only exist when HCR_EL2.E2H
is 1; they should UNDEF otherwise. We weren't implementing this.
Add an intercept of the accessfn for these aliases, and implement
the UNDEF check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpregs.h |  3 ++-
 target/arm/helper.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f1293d16c07..e748d184cb6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -937,7 +937,7 @@ struct ARMCPRegInfo {
     CPResetFn *resetfn;
 
     /*
-     * "Original" writefn and readfn.
+     * "Original" readfn, writefn, accessfn.
      * For ARMv8.1-VHE register aliases, we overwrite the read/write
      * accessor functions of various EL1/EL0 to perform the runtime
      * check for which sysreg should actually be modified, and then
@@ -948,6 +948,7 @@ struct ARMCPRegInfo {
      */
     CPReadFn *orig_readfn;
     CPWriteFn *orig_writefn;
+    CPAccessFn *orig_accessfn;
 };
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc2471eda7e..797b7518f61 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6535,6 +6535,20 @@ static void el2_e2h_e12_write(CPUARMState *env, const ARMCPRegInfo *ri,
     return ri->orig_writefn(env, ri->opaque, value);
 }
 
+static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool isread)
+{
+    /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
+    }
+    if (ri->orig_accessfn) {
+        return ri->orig_accessfn(env, ri->opaque, isread);
+    }
+    return CP_ACCESS_OK;
+}
+
 static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 {
     struct E2HAlias {
@@ -6648,6 +6662,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         new_reg->opaque = src_reg;
         new_reg->orig_readfn = src_reg->readfn ?: raw_read;
         new_reg->orig_writefn = src_reg->writefn ?: raw_write;
+        new_reg->orig_accessfn = src_reg->accessfn;
         if (!new_reg->raw_readfn) {
             new_reg->raw_readfn = raw_read;
         }
@@ -6656,6 +6671,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         }
         new_reg->readfn = el2_e2h_e12_read;
         new_reg->writefn = el2_e2h_e12_write;
+        new_reg->accessfn = el2_e2h_e12_access;
 
         ok = g_hash_table_insert(cpu->cp_regs,
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
-- 
2.34.1


