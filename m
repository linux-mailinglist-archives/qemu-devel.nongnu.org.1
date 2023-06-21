Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE5A73864C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByVV-0006rv-7H; Wed, 21 Jun 2023 10:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVK-0006pg-Ef
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVI-0000K0-Te
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687356492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7IUm9nDj0mwjHgvbdeVxQ5wEqkV4UtqePO/Ykqyr/0=;
 b=giGlRJ3yWgfZLrCIDvIqAiWq5PMd2J7S/Jdd3VzNYHNJtdiGl1fKCjkUwT2o8Bx8wKh7Vg
 holL+uQi1lNemZOMldw1ji8P9vZttTGILiQoqa6QNjMaXtDFZaL0U6kHBw1LSvalhPydLU
 aTceeS546cJ/JHDMXH5vhc7hHOYsh6o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-j1vK8Gt4NaeBa0-eX6MPkQ-1; Wed, 21 Jun 2023 10:08:06 -0400
X-MC-Unique: j1vK8Gt4NaeBa0-eX6MPkQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b5465a79edso18825375ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687356469; x=1689948469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7IUm9nDj0mwjHgvbdeVxQ5wEqkV4UtqePO/Ykqyr/0=;
 b=YRC76Ass07lPGq1/uf+svErZwdKfk28upuccn8wPici+fxDkh2/nfVE2bZhmBvljoC
 szh3cIGoMiyodPeCOrB72kgVvLdX47caXv9QcWiGnx29mcqjSTKpPZP/XJ90QoOIf3r7
 fSXg4dy1ijPsgz/qeSgQf1347DP7dEa+q8468JvPmogtjQpVhwsX1Y7wNPzbDxpRN80T
 k9Lgnf9Zor+xL+52njUWCfMMbcOOKNxQTaFDvDml3leESLGqOfLlw15mljFePJKPHKHq
 AH5KkW+Gw/d28bMNdF0JPOXeXiDYvfLUvL0AsJEYumnwCEIjnluctvdxQDlgjCBPhoxQ
 DRgg==
X-Gm-Message-State: AC+VfDyP3rqfZCRR9lWr/eTeCQDW7iFP01LzndLAUk/zZnB3GPnDWWtO
 nE6B8WfFFJlFM9CXuzQw6Qp2ifmcw78JBugc4fsPLXL4IJYA7Fv9BNIRMDAB0rStW7n/b9xWSNr
 MkwR2o2e+HYNKA3c=
X-Received: by 2002:a17:902:f802:b0:1b3:dbaa:f3fb with SMTP id
 ix2-20020a170902f80200b001b3dbaaf3fbmr9322111plb.22.1687356469606; 
 Wed, 21 Jun 2023 07:07:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EVjpGu86avFsjYxRvr+vXjlzhAQGn/zgwqfDsTns8UU2l0ER1P9LCiQ7xumSNCK4lnoq6UA==
X-Received: by 2002:a17:902:f802:b0:1b3:dbaa:f3fb with SMTP id
 ix2-20020a170902f80200b001b3dbaaf3fbmr9322095plb.22.1687356469280; 
 Wed, 21 Jun 2023 07:07:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.199.101])
 by smtp.googlemail.com with ESMTPSA id
 y7-20020a17090322c700b001b4fee3ea25sm3502427plg.277.2023.06.21.07.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:07:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/acpi/bios-tables-test: update acpi blob
 q35/DSDT.noacpihp
Date: Wed, 21 Jun 2023 19:37:23 +0530
Message-Id: <20230621140723.462220-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230621140723.462220-1-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 tests/data/acpi/q35/DSDT.noacpihp           | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

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

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 31df9c6187..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.noacpihp",
-- 
2.39.1


