Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA49F89C4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Dec 2024 02:56:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFg-0007WV-BK; Thu, 19 Dec 2024 20:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFH-0006zw-FU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:03 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFF-0004XY-89
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:02 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so1278803b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659759; x=1735264559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+u/esspkIM84/pIeM30BE8iVEgZ0neo/04y/t2IyJ4=;
 b=jAdztPi2d5p+V1pdHkmkJGjIpAR65P9EhWwzB2IhslWsw6I/BLEEkyOeVWAfFJXtFF
 VR1/9pQq4h+IxsxfqxxmxJ+NyL4qqHw6z9nRnhpBBxon0uAXIJaxqTQGxyZRGPFh71KV
 z3TdGe4S4qRyx2TqTKbGpMUDj0SHLBuH96h6fkVR2B7pG0gGhQDfe39pJYWuPyWAJjVy
 v3EYB9UfPP+5ptd+qISTvXJ5oqa/5UoS6g+cgqqt9EA+e1rROazyxgivCyMStazY+SwH
 ntLWWdtvmaxlAsSLC4BhGAhMtpvdLj3tExFnwVd8mV1A37EycNGt3csgRN0y7Uxzo+Cn
 fEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659759; x=1735264559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+u/esspkIM84/pIeM30BE8iVEgZ0neo/04y/t2IyJ4=;
 b=ZMaqeKW7jc2Ezm/iTt3Vu3G8CbNLVfY7PEP3g6ygxjgXgWBI8LA8aMVs5ka64MVtPB
 Gef5yN3ns5AB7jfKjMui/oyEGjicZSlL+b2W02W2uGd1f1tEktrbq1sknna+Jp/u1ju8
 3BJY4koctq9+y00EbsNgELff1NoQWJc11wnl+T/tn2PI5CFgefQ0PNTRdZTg39XXXJ6A
 gLVyiRLLXHcB+ZTwr6eT1D1vZXfRK9baBfi8/3IBaRlc6j5laP7nh7kSkzbj1u5g4zPP
 7U5xwd3DBFFsYkMK1Enkw/9VCIGsrEt9CP9j0J3E7lkb25gwRNuXKPFMGH1gIqBTfcOB
 ku7A==
X-Gm-Message-State: AOJu0YzoAhchjhgqhPP3UV8Ejlh9w0tLqZUX1f/Ix0oFTMzJs5PlGpkd
 +gih2ZsHWc3k3ze58hA2EhT0x5tMnRHNvJPIYihmmaQlKMrMrgA/bo9s5vnm
X-Gm-Gg: ASbGncuQDl7X48fNSsLTZ4VsNwHRGv4tk50+MlAwZ5LBcM/x1iNn12dhuyGfo49D9oA
 nq1+95uckLo3qgoKWu/4qcG7yL8u7+qDii4/o1QNNi7mF/2dXkgk3ra10sTXSKrKvlznOkxlEFp
 E6mLt3fKwzVVlsVszbTIMv/L1xlBmwWe0imSt5Jrp/Mqese/78sh2+zwzVwtKDMi/QYnw4yyQmZ
 qSqRDtAe3e+YzBuXt/AiniTC+t3t8B0lJOn8JvZVhiF/h4EXiUdYRvlSJ1AogzQYbJID5JcpCrd
 8FLDXsNCPv3jwSqjMPuqUJzD4OXMeBQOU2W692KPesMCFTJA/5BPoQvLiWAog9A=
X-Google-Smtp-Source: AGHT+IGsXbYo0VFEllg66DBB/FurrtlbZp4NAVlo35dQX5vc9RRIPsi4nKjeomFy2XrF31IZfO7/ew==
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id
 d2e1a72fcca58-72abdd7cbaemr1694132b3a.8.1734659759536; 
 Thu, 19 Dec 2024 17:55:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:59 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 22/39] tests/qtest/bios-tables-test: Update virt SPCR golden
 reference for RISC-V
Date: Fri, 20 Dec 2024 11:54:22 +1000
Message-ID: <20241220015441.317236-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Update the virt SPCR golden reference file for RISC-V to accommodate the
SPCR Table revision 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository. The SPCR table has been modified to
adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:
/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Wed Aug 28 18:28:19 2024
+ * Disassembly of /tmp/aml-MN0NS2, Wed Aug 28 18:28:19 2024
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
-[004h 0004   4]                 Table Length : 00000050
-[008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : B9
+[004h 0004   4]                 Table Length : 0000005A
+[008h 0008   1]                     Revision : 04
+[009h 0009   1]                     Checksum : 13
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   1]               Interface Type : 00
+[024h 0036   1]               Interface Type : 12
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
 [029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
 [02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044   8]                      Address : 0000000010000000

 [034h 0052   1]               Interrupt Type : 10
 [035h 0053   1]          PCAT-compatible IRQ : 00
 [036h 0054   4]                    Interrupt : 0000000A
 [03Ah 0058   1]                    Baud Rate : 07
 [03Bh 0059   1]                       Parity : 00
 [03Ch 0060   1]                    Stop Bits : 01
 [03Dh 0061   1]                 Flow Control : 00
 [03Eh 0062   1]                Terminal Type : 00
 [04Ch 0076   1]                     Reserved : 00
 [040h 0064   2]                PCI Device ID : FFFF
 [042h 0066   2]                PCI Vendor ID : FFFF
 [044h 0068   1]                      PCI Bus : 00
 [045h 0069   1]                   PCI Device : 00
 [046h 0070   1]                 PCI Function : 00
 [047h 0071   4]                    PCI Flags : 00000000
 [04Bh 0075   1]                  PCI Segment : 00
-[04Ch 0076   4]                     Reserved : 00000000
+[04Ch 0076 004h]             Uart Clock Freq : 00000000
+[050h 0080 004h]           Precise Baud rate : 00000000
+[054h 0084 002h]       NameSpaceStringLength : 0002
+[056h 0086 002h]       NameSpaceStringOffset : 0058
+[058h 0088 002h]             NamespaceString : "."

-Raw Table Data: Length 80 (0x50)
+Raw Table Data: Length 90 (0x5A)

-    0000: 53 50 43 52 50 00 00 00 02 B9 42 4F 43 48 53 20  // SPCRP.....BOCHS
+    0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
+    0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <20241028015744.624943-4-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/riscv64/virt/SPCR           | Bin 80 -> 90 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 4da9daf65f..09617f8793 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
-- 
2.47.1


