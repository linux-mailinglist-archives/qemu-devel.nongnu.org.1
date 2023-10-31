Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E01D7DCE1F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:47:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp3g-0000vh-VP; Tue, 31 Oct 2023 09:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3V-0000t2-Tu
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3Q-0006e1-3Y
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:17 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507b96095abso8160152e87.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698759909; x=1699364709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wr1aUy3gMjeaD7/VlG6DQ3APXY4QAmvlIeAUSCdCi1U=;
 b=DA5Dtq+geAkFrbab2qEnWBB1X/InP00omlKIjehKYY1/rTTGTbP2IVKglQunmVhMXw
 yu2OGbaBHrd/GaW3Hiv5HXVP+l0n2BvXZ+zfij4oSIOaaXuxhwiYfftNe2rTfV9cZ8BA
 eBih+F/3OAbJhNOV4XLQTBzXdoq/ljJKCj77pgeps73WvlSx6p3xIKCEMkdevvxpqWmF
 MxZqRAqnOU5V4UxXvObFEMTabdM9uyDq/Pqyd6Cvmf4d1Ha9faZes8pPhhDgpP54aCaT
 KTfwH7WLYCKq6C0uWIZVhxl1+V8gLeQMUzSBi2PrhwLNDpeXbe6QnNbtRfbc9Us5A0p6
 9wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698759909; x=1699364709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wr1aUy3gMjeaD7/VlG6DQ3APXY4QAmvlIeAUSCdCi1U=;
 b=iH0wmzwaTViXi8981JVcUZCZ+CSjE+ruOu+42z3q4VKCG5QDpwgPcJY/fc5PASdLIC
 9/RvsWbBU7lUuYqmnhfjHiM2EiWjDGtfnWbdvDl0mEeFdx2GUCfHtPI0S7Nz6ym/TBGN
 z9AgTfM1E557dEUSgv64ci1fXW8DWag/XdKv0Go96Yb9IYWqLPBq/Gt2IIqUbPYiNRxQ
 vFSRRKtC3OyrZHepDc8YTSvp1eH19Iqgq/mfJCsr5r2Wj2sVxl4SXy8cX8xdE9uzWEhm
 ItWiBe4kW2Rj9jp9zdAEDwwwX9vtMCl0aKmheGsX6RRAWEvjp6NiP2d2JIeCQUJtRxSt
 SGrQ==
X-Gm-Message-State: AOJu0Ywj+qNvKPfPhA7zBEL4S2dloyHnWYc9RiQFT7E87KWq68IluGtS
 SmgzhQnstr2GABr6wTXBQj9q9jmuHxEKOntruE4=
X-Google-Smtp-Source: AGHT+IECSYo1GuHwGUJzYUSsV0CVsdxu1atGfm9Jsjo4PH6lh7e2VXQyxvJRPQRJhQ1iKD0AkrLm7Q==
X-Received: by 2002:a05:6512:2345:b0:507:a766:ad29 with SMTP id
 p5-20020a056512234500b00507a766ad29mr12071115lfu.12.1698759908771; 
 Tue, 31 Oct 2023 06:45:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1754989wmm.46.2023.10.31.06.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:45:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v2 3/3] tests/qtest/bios-tables-test: Update virt SPCR and
 DBG2 golden references
Date: Tue, 31 Oct 2023 13:45:05 +0000
Message-Id: <20231031134505.4110877-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031134505.4110877-1-peter.maydell@linaro.org>
References: <20231031134505.4110877-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Update the virt SPCR and DBG2 golden reference files to have the
fix for the description of the UART.

Diffs from iasl:

@@ -1,57 +1,57 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/SPCR, Tue Oct 31 12:55:58 2023
+ * Disassembly of /tmp/aml-BA1ND2, Tue Oct 31 12:55:58 2023
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
 [004h 0004   4]                 Table Length : 00000050
 [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : CB
+[009h 0009   1]                     Checksum : B2
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]               Interface Type : 03
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
-[029h 0041   1]                    Bit Width : 08
+[029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
-[02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
+[02Bh 0043   1]         Encoded Access Width : 02 [Word Access:16]
 [02Ch 0044   8]                      Address : 0000000009000000

 [034h 0052   1]               Interrupt Type : 08
 [035h 0053   1]          PCAT-compatible IRQ : 00
 [036h 0054   4]                    Interrupt : 00000021
 [03Ah 0058   1]                    Baud Rate : 03
 [03Bh 0059   1]                       Parity : 00
 [03Ch 0060   1]                    Stop Bits : 01
 [03Dh 0061   1]                 Flow Control : 02
 [03Eh 0062   1]                Terminal Type : 00
 [04Ch 0076   1]                     Reserved : 00
 [040h 0064   2]                PCI Device ID : FFFF
 [042h 0066   2]                PCI Vendor ID : FFFF
 [044h 0068   1]                      PCI Bus : 00
 [045h 0069   1]                   PCI Device : 00
 [046h 0070   1]                 PCI Function : 00
 [047h 0071   4]                    PCI Flags : 00000000
 [04Bh 0075   1]                  PCI Segment : 00
 [04Ch 0076   4]                     Reserved : 00000000

 Raw Table Data: Length 80 (0x50)

-    0000: 53 50 43 52 50 00 00 00 02 CB 42 4F 43 48 53 20  // SPCRP.....BOCHS
+    0000: 53 50 43 52 50 00 00 00 02 B2 42 4F 43 48 53 20  // SPCRP.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 03 00 00 00 00 08 00 01 00 00 00 09  // ................
+    0020: 01 00 00 00 03 00 00 00 00 20 00 02 00 00 00 09  // ......... ......
     0030: 00 00 00 00 08 00 21 00 00 00 03 00 01 02 00 00  // ......!.........
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................


@@ -1,57 +1,57 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/DBG2, Tue Oct 31 12:55:58 2023
+ * Disassembly of /tmp/aml-V80ND2, Tue Oct 31 12:55:58 2023
  *
  * ACPI Data Table [DBG2]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "DBG2"    [Debug Port table type 2]
 [004h 0004   4]                 Table Length : 00000057
 [008h 0008   1]                     Revision : 00
-[009h 0009   1]                     Checksum : CF
+[009h 0009   1]                     Checksum : B6
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   4]                  Info Offset : 0000002C
 [028h 0040   4]                   Info Count : 00000001

 [02Ch 0044   1]                     Revision : 00
 [02Dh 0045   2]                       Length : 002B
 [02Fh 0047   1]               Register Count : 01
 [030h 0048   2]              Namepath Length : 0005
 [032h 0050   2]              Namepath Offset : 0026
 [034h 0052   2]              OEM Data Length : 0000 [Optional field not present]
 [036h 0054   2]              OEM Data Offset : 0000 [Optional field not present]
 [038h 0056   2]                    Port Type : 8000
 [03Ah 0058   2]                 Port Subtype : 0003
 [03Ch 0060   2]                     Reserved : 0000
 [03Eh 0062   2]          Base Address Offset : 0016
 [040h 0064   2]          Address Size Offset : 0022

 [042h 0066  12]        Base Address Register : [Generic Address Structure]
 [042h 0066   1]                     Space ID : 00 [SystemMemory]
-[043h 0067   1]                    Bit Width : 08
+[043h 0067   1]                    Bit Width : 20
 [044h 0068   1]                   Bit Offset : 00
-[045h 0069   1]         Encoded Access Width : 01 [Byte Access:8]
+[045h 0069   1]         Encoded Access Width : 02 [Word Access:16]
 [046h 0070   8]                      Address : 0000000009000000

 [04Eh 0078   4]                 Address Size : 00001000

 [052h 0082   5]                     Namepath : "COM0"

 Raw Table Data: Length 87 (0x57)

-    0000: 44 42 47 32 57 00 00 00 00 CF 42 4F 43 48 53 20  // DBG2W.....BOCHS
+    0000: 44 42 47 32 57 00 00 00 00 B6 42 4F 43 48 53 20  // DBG2W.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 2C 00 00 00 01 00 00 00 00 2B 00 01  // ....,........+..
     0030: 05 00 26 00 00 00 00 00 00 80 03 00 00 00 16 00  // ..&.............
-    0040: 22 00 00 08 00 01 00 00 00 09 00 00 00 00 00 10  // "...............
+    0040: 22 00 00 20 00 02 00 00 00 09 00 00 00 00 00 10  // ".. ............
     0050: 00 00 43 4F 4D 30 00                             // ..COM0.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/virt/DBG2                   | Bin 87 -> 87 bytes
 tests/data/acpi/virt/SPCR                   | Bin 80 -> 80 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 6673e2c4c13..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/SPCR",
-"tests/data/acpi/virt/DBG2",
diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/virt/DBG2
index 86e6314f7b0235ef8ed3e0221e09f996c41f5e98..f9005b5b01a41dbd5a39eb34bdfc4291a23f0021 100644
GIT binary patch
delta 37
ncmWF!=W=m!HwtF}f^8GIEJYL;n1D=95T8MSfx+3|*MI>4b3O$3

delta 37
ncmWF!=W=m!HwtF}g7Xu(EJZjN7=cVq5T8MSfx+3|*MI>4bG-!j

diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/SPCR
index 24e0a579e7d73f432a614380e29aa95113344186..e3bca0ada02c966c867ac91b501260808d6978f1 100644
GIT binary patch
delta 23
ecmWFt;0g|K4hmpkU|`xbkxQOgfq`kFjtT%gQv{~~

delta 23
ecmWFt;0g|K4hmpkU|>2ukxQPLgMo3PjtT%g(gddf

-- 
2.34.1


