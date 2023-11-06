Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DAD7E28C9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b5-00082Z-UW; Mon, 06 Nov 2023 10:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ao-0007uU-Rz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0004NR-5D
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32f70391608so2387771f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284760; x=1699889560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o46GjiNGnFh5PFXpDP7cZHY+Rtqpr/iySpofJQGEQas=;
 b=Mp17wgKJ1QOfL7bgcNpbLlagl9uSSLKU1tUw1hUy8HrQhcd7Ak5cLTIet9XCrzRE7u
 xfosD6IW/Wkq3eSyn4/1j9NaudPsBdtXkOsHdhlahhcL0EVpfFZo+WL5cVK0HeaZq7tE
 3TCCuNGhFNXJnvSll1j8gs3IznzqtnEt3ie9fd7zvWssD8lPPz+deJpCYhMj3LGSPNwZ
 D+aSz4tI8uJwJHS/0UpZ1Fisub0QcimRdb9E0CjZ5e2QmNu9726uvgAUyWij4vXphrUa
 raLAzRYhjVtVSOHgyL5ztN6ThpzWn8TZNLh6hUO7e3ieBaOEF8r7wxBOxm4QouUnNOWW
 ePbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284760; x=1699889560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o46GjiNGnFh5PFXpDP7cZHY+Rtqpr/iySpofJQGEQas=;
 b=Uyq1sPb5YV4QejzZH1gTe/aNEUhA/HpRbmoSNR7p7wGfsscWO34jVh5jkI56i0pYr6
 skq8lj2sNL9ZlWJD7OUn6pY8FmYWVE+0aEA/elHuflR2bBC7m91ZZx5EsROIVAD52BPN
 JRP620Wbu+JLN1OixEyKSENPMw2psyDCYnr5zLwI6HiT29vHHsfncOROp2l8MbDZLNQC
 PDXFl/5iiLLICqoNl5MC9XRsCtWg7q0lv/A0qKiwzyVGFtHkdgqad15ujRk0m2yiwcYD
 pU3+QVqrOMyxxM2MM5FUKnBLAjUNbPJNIK5GU7s78P1ItZpszvsB7wsMhhDq3NQ3FoFL
 jWrw==
X-Gm-Message-State: AOJu0YzKUE8PHU9EGhrOYGee5QJCejrjEKIhFDAPdI07vt6Yxw+YIvmx
 XNaNQOkRWX4Hc1np9DjeS8J7IdOFX7TMv70aU6g=
X-Google-Smtp-Source: AGHT+IEhsO+lI4GUtLu8r0soW8hf+Ot3RWwNxqgq73ivVYCH9Lm/hIPUi/qgonZm7Au9pjWXfVKTYQ==
X-Received: by 2002:a5d:5b08:0:b0:32d:bb4a:525c with SMTP id
 bx8-20020a5d5b08000000b0032dbb4a525cmr35199425wrb.14.1699284760477; 
 Mon, 06 Nov 2023 07:32:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hw/arm/virt: Report correct register sizes in ACPI
 DBG2/SPCR tables.
Date: Mon,  6 Nov 2023 15:32:29 +0000
Message-Id: <20231106153238.1426649-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
- 16 bits in size in some cases (see individual registers), so access
  size must be at least 2.

Linux doesn't seem to care about this error in the table, but it does
affect at least the NOVA microhypervisor.

In theory we therefore have a choice between reporting the access
size as 2 (16 bit accesses) or 3 (32-bit accesses).  In practice,
Linux does not correctly handle the case where the table reports the
access size as 2: as of kernel commit 750b95887e5678, the code in
acpi_parse_spcr() tries to tell the serial driver to use 16 bit
accesses by passing "mmio16" in the option string, but the PL011
driver code in pl011_console_match() only recognizes "mmio" or
"mmio32". The result is that unless the user has enabled 'earlycon'
there is no console output from the guest kernel.

We therefore choose to report the access size as 32 bits; this works
for NOVA and also for Linux.  It is also what the UEFI firmware on a
Raspberry Pi 4 reports, so we're in line with existing real-world
practice.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1938
Signed-off-by: Udo Steinberg <udo@hypervisor.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: minor commit message tweaks; use 32 bit accesses]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9ce136cd88c..8bc35a483c9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -482,7 +482,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
     /* Base Address */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
                      vms->memmap[VIRT_UART].base);
     /* Interrupt Type */
     build_append_int_noprefix(table_data,
@@ -673,7 +673,7 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 34, 2);
 
     /* BaseAddressRegister[] */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
                      vms->memmap[VIRT_UART].base);
 
     /* AddressSize[] */
-- 
2.34.1


