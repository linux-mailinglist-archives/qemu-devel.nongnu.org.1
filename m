Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F974E1EA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwK-000238-QK; Mon, 10 Jul 2023 19:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvq-0001Xy-6v
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvo-0004Y3-FE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBRCyVMXtwE/vLnlZhU8V6LGVN3Foijz8hViuua/bjw=;
 b=At4FuimgIBDpR2F5Y4lIoYbreyK3WQ4sIxQLtPpelKpJZAoLgfIV+KBF+kipqd2OgG8Ikd
 kee5qIujys+viZFcY5zmAhJgYA2/izIZY5omRHLDtSaZNw50oSQ6hC/T8BrKtVVxNhWka7
 sElrYK9s1SOzeFtz8RhMDgStuakoVcs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-P1QvxD6sOD-nPmO4dB9sCw-1; Mon, 10 Jul 2023 19:04:34 -0400
X-MC-Unique: P1QvxD6sOD-nPmO4dB9sCw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc0094c1bdso24645065e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030272; x=1691622272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBRCyVMXtwE/vLnlZhU8V6LGVN3Foijz8hViuua/bjw=;
 b=cru/dtHrNk9+BQSsgYB2bUFAhCdKthPVbFNBjh8MnO9k3oxVTrabZabARPHFms/xZr
 DDArTOQXQ9iwkj70iGeo+tfGfHYKFu0NdKqJ2Vsa/4fxdvIMxE0iVS+F6YnEvNi0hUxd
 Y3qZLKgkrxehW6TctmNGRp5mr9sY4T+D2a7bQP1ZYtyRfdZmO91ysGrPKHJycB5yaWdv
 Tsxs8qxBycjPu1LIOWs3bWh+iA7PVf1zpZnWyi2KlO51CUUTW+/6PBMfLF8su7v814xc
 gotnanBkrvuTXii8s8B2TQlbSzqp6fRSO5FkqbJx4n+1hzhI+PtIDXxgE3Pou5X/Cf5s
 W11g==
X-Gm-Message-State: ABy/qLaO4OeAlNBi6ArwKZHgUV+UHVJerPdQwi1xlzBxbSQU9ceGwtrc
 n6SDI6VN2O1fJSm6KQOO/Bc3e63O0VcDKljdMSLLMz5S3H+zGcN6+bm5ka776LqoZ7gfrHiOy0S
 /92VkpBcanIhfAw3DP79qiWeq6H8Pj+dXTvZJ58dji0HyPTS6YjGaAeKdsqCYgnsVfVnT
X-Received: by 2002:a1c:6a1a:0:b0:3f8:c70e:7ed1 with SMTP id
 f26-20020a1c6a1a000000b003f8c70e7ed1mr13627816wmc.20.1689030271861; 
 Mon, 10 Jul 2023 16:04:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+QSZUKvpxpkcuTBo1GJ58lfKbe0gtmq3ok6gidV1TRZ4gGct0Y9wZHYEZeA/bGJy17xr/MQ==
X-Received: by 2002:a1c:6a1a:0:b0:3f8:c70e:7ed1 with SMTP id
 f26-20020a1c6a1a000000b003f8c70e7ed1mr13627795wmc.20.1689030271559; 
 Mon, 10 Jul 2023 16:04:31 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f11-20020a7bc8cb000000b003fa98908014sm11534848wml.8.2023.07.10.16.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:31 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 43/66] tests/acpi/bios-tables-test: update acpi blob
 q35/DSDT.noacpihp
Message-ID: <bac4711b07ef92be45628ae7b399a09d850ee596.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ani Sinha <anisinha@redhat.com>

Some fixes were committed in bios-tables-test in the previous commit. Update
the acpi blob and clear bios-tables-test-allowed-diff.h so that the test
continues to pass with the changes in the bios-tables-test.

Following is the asl diff between the old and the newly updated blob:

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20210604 (64-bit version)
  * Copyright (c) 2000 - 2021 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/q35/DSDT.noacpihp, Wed Jun 21 18:26:52 2023
+ * Disassembly of /tmp/aml-O8SU61, Wed Jun 21 18:26:52 2023
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00002038 (8248)
+ *     Length           0x00002031 (8241)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x4A
+ *     Checksum         0x89
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

@@ -3148,48 +3148,48 @@
                 {
                     Name (_ADR, Zero)  // _ADR: Address
                     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                     {
                         Local0 = Package (0x01)
                             {
                                 0x01F5
                             }
                         Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
                     }
                 }
             }

             Device (S40)
             {
                 Name (_ADR, 0x00080000)  // _ADR: Address
-                Device (S41)
+                Device (S01)
                 {
-                    Name (_ADR, 0x00080001)  // _ADR: Address
+                    Name (_ADR, One)  // _ADR: Address
                     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                     {
                         Local0 = Package (0x01)
                             {
                                 0x0259
                             }
                         Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
                     }
                 }

-                Device (S48)
+                Device (S02)
                 {
-                    Name (_ADR, 0x00090000)  // _ADR: Address
+                    Name (_ADR, 0x02)  // _ADR: Address
                     Device (S00)
                     {
                         Name (_ADR, Zero)  // _ADR: Address
                     }
                 }
             }

             Device (SF8)
             {
                 Name (_ADR, 0x001F0000)  // _ADR: Address
                 OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
                 Scope (\_SB)
                 {
                     Field (PCI0.SF8.PIRQ, ByteAcc, NoLock, Preserve)
                     {
                         PRQA,   8,

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230705115925.5339-4-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/DSDT.noacpihp           | Bin 8248 -> 8241 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 31df9c6187..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.noacpihp",
diff --git a/tests/data/acpi/q35/DSDT.noacpihp b/tests/data/acpi/q35/DSDT.noacpihp
index 6ab1f0e52543fcb7f84a7fd1327fe5aa42010565..8cab2f8eb9ae94e0165f3f17857ec7d080fb0e13 100644
GIT binary patch
delta 109
zcmdntu+f3bCD<jzP=SGgv2!Dri!7J3UQB$jQ@nt;?&b(tDMlAZ)?gEZc#e2SmmnSn
z1`dYkCY4|VLx=#Qh(x?gurE)65Gx~hBvZl?S0FDVGb=kGx=AwFzzCv>i)r&-xoSoL
DyqFtK

delta 94
zcmdn!u)~4NCD<jzLV<yS(Q6}@i!7IyUQB$jQ@nta-sT8dDMm#P)?gEZc#e2SmmnSn
k1`dYkCXHYdL#O~FP+)SuoHV~ou!#j+5huguZF1F&02bsG6#xJL

-- 
MST


