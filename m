Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C97DCE20
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:47:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp3i-0000wi-C7; Tue, 31 Oct 2023 09:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3d-0000vU-Qa
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:26 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3Q-0006dq-38
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:25 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso81754131fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698759908; x=1699364708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiFROgJijL5DjDbI11XzUMIENgV6n09PNh0JnejpBco=;
 b=AZJGCYXmLfSFLGcn3Zb9WBK9RmUwRB6dJqTqViCfJ7oiWmK0ipajMUNrP8ie/66RFx
 vV5IuVb3D//F2g+Cd9FOv0bWmzvfke+/UTCiw/7cRYXItAi1kMiOu96j433AJUMuRYsW
 c/O8+Gn6Y/LY+K6C3anEYnpIczkrML1V2sGr272iFDUmTySZa7+O9lmCFrtuFt+5QPEu
 Q1txVgEajMTJzBo8U5Z/VSUL24B67Q9dzwcoA9FZxcrz5MJabS8pJr5LUqwvHegqSAX3
 FS0epFugo9vsdkaB3+gFBEUXaXnU4W0QLB94synl3SAs/GNrnLtTCRbbaVey7ytG2pLb
 hc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698759908; x=1699364708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiFROgJijL5DjDbI11XzUMIENgV6n09PNh0JnejpBco=;
 b=FcV1L9fY95TeiG87j7XPvCSGTO4HlMuUNkI4pRThNJLMdsrG2QYtZhvoyd2tLq62FY
 46arXngtShEwI0Xi0bv4jsxoHqlSrMkse7sf6/Vvnv5e0b4VHtGZSIIDwzllBKqzWvFy
 6eoR/a9Ori7jmR2oD/rHn1l3zr8+dJ/E50CHg7Y1tZ6zbZS0YhJ4zMFNjiUlNqJAbyAZ
 pvzJ9yZfgLoVvC+3xUaHESfUsHdQT/NS7cKaP80b7QgZCcpLN7GnZLTTBYn6ppmsrDMU
 LbzmhM0rjmm9qBskSkLGiYSHuYgifTxbMJ4aV7oh70K5Y0RAH4G5U+CDlmciLhbdBLYS
 8T9g==
X-Gm-Message-State: AOJu0Yxu1ePjQytnMYVQh6E+RxZHeeeudSLaJYakuSlxzOycHs02ryNl
 /9Zh5llLyleeO9W7WlPoQqECew==
X-Google-Smtp-Source: AGHT+IEkqqnJ30a+ua8wQ/QqXlKCJ9IafnWV0vaod0w/gwJCl6IQNOThB0S0vr3BPleii1D1jMDfaA==
X-Received: by 2002:a2e:86c6:0:b0:2c5:488c:aedf with SMTP id
 n6-20020a2e86c6000000b002c5488caedfmr10392898ljj.37.1698759908269; 
 Tue, 31 Oct 2023 06:45:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1754989wmm.46.2023.10.31.06.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:45:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v2 2/3] hw/arm/virt: Report correct register sizes in ACPI
 DBG2/SPCR tables.
Date: Tue, 31 Oct 2023 13:45:04 +0000
Message-Id: <20231031134505.4110877-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031134505.4110877-1-peter.maydell@linaro.org>
References: <20231031134505.4110877-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Udo Steinberg <udo@hypervisor.org>

Documentation for using the GAS in ACPI tables to report debug UART addresses at
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
states the following:

- The Register Bit Width field contains the register stride and must be a
  power of 2 that is at least as large as the access size.  On 32-bit
  platforms this value cannot exceed 32.  On 64-bit platforms this value
  cannot exceed 64.
- The Access Size field is used to determine whether byte, WORD, DWORD, or
  QWORD accesses are to be used.  QWORD accesses are only valid on 64-bit
  architectures.

Documentation for the ARM PL011 at
https://developer.arm.com/documentation/ddi0183/latest/
states that the registers are:

- spaced 4 bytes apart (see Table 3-2), so register stride must be 32.
- 16 bits in size (see individual registers), so access size must be 2.

The PL011 documentation does not mention whether 8-bit accesses or 32-bit
accesses to the registers are also allowed. Because a standard PL011 (not
the SBSA version) is connected via a 16-bit bus using PWDATA[15:0] and
PRDATA[15:0] (see Figure 2-1), using 16-bit access is the safest choice.

For SBSA-compatible UARTs the DBG2/SPCR table should report a different
subtype (0xd or 0xe) instead of 0x3.

Linux doesn't seem to care about this error in the table, but it does
affect at least the NOVA microhypervisor.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1938
Signed-off-by: Udo Steinberg <udo@hypervisor.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: minor commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9ce136cd88c..91ed7fc94a1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -482,7 +482,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
     /* Base Address */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
                      vms->memmap[VIRT_UART].base);
     /* Interrupt Type */
     build_append_int_noprefix(table_data,
@@ -673,7 +673,7 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 34, 2);
 
     /* BaseAddressRegister[] */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
                      vms->memmap[VIRT_UART].base);
 
     /* AddressSize[] */
-- 
2.34.1


