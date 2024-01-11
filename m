Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2BF82B208
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:45:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxF4-0008P6-Ft; Thu, 11 Jan 2024 10:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxF1-0008LD-TR
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:45:11 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEz-00083B-8p
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:45:11 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cdf76cde78so2900249a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704987907; x=1705592707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1Phwl5iEaNYDkGmeu0roJ9iyiA9Wh7jvJNiLmeHbiI=;
 b=Fmwtt25nudBb0VTecGE+lNtp0/ZqBI/zOg+kNe28Px8vJkW3pZm/kYbemUDHtbg2VG
 bzh6CYStfs2Le21mCllAYVZWfoiQnTnJ9/mF1nKBgRBTNJfGsWmWte39HiaaOl0uvjfh
 xh1S+bbWRFLALvsRQN+2Ij/1sAHC2A1Q87a3DXOy79azBcr2ywyO6HvMY4yuZLodL05o
 AtHKNpuXW8PqUfFsFN1dRVPjimsX6OxrjjHqZfAqn1ZnyciR/70iP6TM/Qaqj849M5Gf
 l3kaZTQVpy+iqz7d+J8NVycFRYicN+9MyzKnRjQhIQ1Ip9+mL0RlI2UHJ7t5I5vXIrOY
 IvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987907; x=1705592707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1Phwl5iEaNYDkGmeu0roJ9iyiA9Wh7jvJNiLmeHbiI=;
 b=T5i0nnHrKDpH3V3uDQks+rKRuOh3DEysQ+uNJkVW0QyF4+K1bQMboaquePN24TuAWS
 2oGBZonynJGykq1Z51762kRm4UjGknJKcL+asVZO3seBTF2vH6dSd+IIrRKWg+Und55s
 tnHmTGTPLA69jP2DStjhnnxfgS9AXZD2oqqGfLt7OgQ6k/07bZFTFStF1a0wyhI9j1bJ
 3LeXF0M9BIteDxwXcW8sU0jJf87bTmN1goTvxnu7BtnUeUMY/5cQcV24e0+c/84h85rE
 g9PWKCt2lINnuT8sYxem7NdMFmX3ONtxNir9mjfnH3/d1Z1gHCxYnoL+VXP54iTdgAG+
 BlkA==
X-Gm-Message-State: AOJu0YzbGy2iwkf4gX+fBRm44Lb1QLNfHgKfFRyCi5SiojLiDeyn/6A3
 3Z6a/1lUMsvq0QIEqKWcOKwg9ic0XILn/0sk
X-Google-Smtp-Source: AGHT+IEn+6liyj1xgUP1VjYlCz/UTjY0empz3Vufgx5jXV/tx4X1RkY/Fy0nm8l3a+GdRevzhXC1Pg==
X-Received: by 2002:a05:6a20:1614:b0:19a:552e:beee with SMTP id
 l20-20020a056a20161400b0019a552ebeeemr21083pzj.33.1704987907437; 
 Thu, 11 Jan 2024 07:45:07 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:e868:3e48:c113:4a7f])
 by smtp.googlemail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm1317887pfb.126.2024.01.11.07.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:45:07 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v12 7/7] test: bios-tables-test: add IVRS changed binary
Date: Thu, 11 Jan 2024 22:44:04 +0700
Message-Id: <20240111154404.5333-8-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111154404.5333-1-minhquangbui99@gmail.com>
References: <20240111154404.5333-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Following the instructions in bios-tables-test, this adds the changed
IVRS.ivrs binary.

New IVRS differs in length, checksum, it enables EFRSup in Virtualization
Info and adds IVHD type 0x11 with the same device entries as in IVHD type
0x10.

ASL diff:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/q35/IVRS.ivrs, Wed Nov  8 21:39:58 2023
+ * Disassembly of /tmp/aml-2ODND2, Wed Nov  8 21:39:58 2023
  *
  * ACPI Data Table [IVRS]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
-[004h 0004 004h]                Table Length : 00000068
+[004h 0004 004h]                Table Length : 000000B0
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : 43
+[009h 0009 001h]                    Checksum : 74
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]         Virtualization Info : 00002800
+[024h 0036 004h]         Virtualization Info : 00002801
 [028h 0040 008h]                    Reserved : 0000000000000000

 [030h 0048 001h]               Subtable Type : 10 [Hardware Definition Block (IVHD)]
 [031h 0049 001h]       Flags (decoded below) : D1
                                      HtTunEn : 1
                                       PassPW : 0
                                    ResPassPW : 0
                                 Isoc Control : 0
                                Iotlb Support : 1
                                     Coherent : 0
                             Prefetch Support : 1
                                  PPR Support : 1
 [032h 0050 002h]                      Length : 0038
 [034h 0052 002h]                    DeviceId : 0010
 [036h 0054 002h]           Capability Offset : 0040
 [038h 0056 008h]                Base Address : 00000000FED80000
@@ -108,25 +108,129 @@
                                   LINT1 Pass : 0

 [060h 0096 001h]               Subtable Type : 48 [Device Entry: Special Device]
 [061h 0097 002h]                   Device ID : 0000
 [063h 0099 001h] Data Setting (decoded below) : 00
                                     INITPass : 0
                                     EIntPass : 0
                                      NMIPass : 0
                                     Reserved : 0
                                  System MGMT : 0
                                   LINT0 Pass : 0
                                   LINT1 Pass : 0
 [064h 0100 001h]                      Handle : 00
 [065h 0101 002h]       Source Used Device ID : 00A0
 [067h 0103 001h]                     Variety : 01

-Raw Table Data: Length 104 (0x68)
+[068h 0104 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
+[069h 0105 001h]       Flags (decoded below) : 11
+                                     HtTunEn : 1
+                                      PassPW : 0
+                                   ResPassPW : 0
+                                Isoc Control : 0
+                               Iotlb Support : 1
+                                    Coherent : 0
+                            Prefetch Support : 0
+                                 PPR Support : 0
+[06Ah 0106 002h]                      Length : 0048
+[06Ch 0108 002h]                    DeviceId : 0010
+[06Eh 0110 002h]           Capability Offset : 0040
+[070h 0112 008h]                Base Address : 00000000FED80000
+[078h 0120 002h]           PCI Segment Group : 0000
+[07Ah 0122 002h]         Virtualization Info : 0000
+[07Ch 0124 004h]                  Attributes : 00000000
+[080h 0128 008h]                   EFR Image : 00000000000029D3
+[088h 0136 008h]                    Reserved : 0000000000000000
+
+[090h 0144 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[091h 0145 002h]                   Device ID : 0000
+[093h 0147 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[094h 0148 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[095h 0149 002h]                   Device ID : 0008
+[097h 0151 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[098h 0152 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[099h 0153 002h]                   Device ID : 0010
+[09Bh 0155 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[09Ch 0156 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[09Dh 0157 002h]                   Device ID : 00F8
+[09Fh 0159 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A0h 0160 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[0A1h 0161 002h]                   Device ID : 00FA
+[0A3h 0163 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A4h 0164 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[0A5h 0165 002h]                   Device ID : 00FB
+[0A7h 0167 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A8h 0168 001h]               Subtable Type : 48 [Device Entry: Special Device]
+[0A9h 0169 002h]                   Device ID : 0000
+[0ABh 0171 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+[0ACh 0172 001h]                      Handle : 00
+[0ADh 0173 002h]       Source Used Device ID : 00A0
+[0AFh 0175 001h]                     Variety : 01
+
+Raw Table Data: Length 176 (0xB0)

-    0000: 49 56 52 53 68 00 00 00 01 43 42 4F 43 48 53 20  // IVRSh....CBOCHS
+    0000: 49 56 52 53 B0 00 00 00 01 74 42 4F 43 48 53 20  // IVRS.....tBOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 28 00 00 00 00 00 00 00 00 00 00  // .....(..........
+    0020: 01 00 00 00 01 28 00 00 00 00 00 00 00 00 00 00  // .....(..........
     0030: 10 D1 38 00 10 00 40 00 00 00 D8 FE 00 00 00 00  // ..8...@.........
     0040: 00 00 00 00 44 00 00 00 02 00 00 00 02 08 00 00  // ....D...........
     0050: 02 10 00 00 02 F8 00 00 02 FA 00 00 02 FB 00 00  // ................
-    0060: 48 00 00 00 00 A0 00 01                          // H.......
+    0060: 48 00 00 00 00 A0 00 01 11 11 48 00 10 00 40 00  // H.........H...@.
+    0070: 00 00 D8 FE 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0080: D3 29 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .)..............
+    0090: 02 00 00 00 02 08 00 00 02 10 00 00 02 F8 00 00  // ................
+    00A0: 02 FA 00 00 02 FB 00 00 48 00 00 00 00 A0 00 01  // ........H.......

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tests/data/acpi/q35/IVRS.ivrs               | Bin 104 -> 176 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/q35/IVRS.ivrs b/tests/data/acpi/q35/IVRS.ivrs
index 17611202e53a32f7da8e4925d6955b384670b8b1..7f9e91aabc0b7777a7efc9f219587a4f91f0edb1 100644
GIT binary patch
delta 63
zcmd1Uz{uqp78JaJfq{XsWFnUoBjZF>XH`K#4+a4S2cY1Me?S5bE^ES>3=9)pl>vea
B3FiO+

delta 22
dcmdnMn8D>478IPpz`(%hJdsO^kzt~$GXOlo1j7IT

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ac420db6b7..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/IVRS.ivrs",
-- 
2.25.1


