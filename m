Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E652E739E9A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHdL-0002zn-Cd; Thu, 22 Jun 2023 06:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdJ-0002za-LM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdI-0007Wv-2X
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7IUm9nDj0mwjHgvbdeVxQ5wEqkV4UtqePO/Ykqyr/0=;
 b=gjNMLgDNWlDY8kkBtrn/6kbj/UftpBQUOBwiz8luJasUA+motiSRgtsomPRV4IldPH6fz1
 yBKZTaiekxFXD9dQDXy3JzxT96DLpr8MONyjTMSbndxtG539pu0PVvSUaRA5YHaWkeFLeq
 yABe4LSRLPJ9aMq4pkwaN7DnpmrmBtw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hhG2G5E2NLKfrFNCbbrg3A-1; Thu, 22 Jun 2023 06:33:42 -0400
X-MC-Unique: hhG2G5E2NLKfrFNCbbrg3A-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-39eaf330648so5240993b6e.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430021; x=1690022021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7IUm9nDj0mwjHgvbdeVxQ5wEqkV4UtqePO/Ykqyr/0=;
 b=H9c21bwaWjEQG4W2X5tykVo4snvWh2uzqKN7ugKZzG8FP4UZUF62FWUY/4vqDIqW51
 L7Oi6NAzkxkC+rPolrLSCHd4x/y/2nCEkQMTRfQGSjcxPSIuBBrJX1kZ5hzXtmc5XrT1
 X1mdsRNMcas+9Bq8ubw2aeWJ1e9s/ct6ZgUIf8SSSL87KnaPe4F2aFO5xBBLD1Xs0fVn
 EOrX1dXj3V6IVG/Xq6F/3jE5Drr4QWqa4kMJIkaP4fJ2qVeeNbR/N/WIK3tuPGNphyRO
 X5idalLOMMCBzz15m/IECeK5G0PWBlREqmeVNCW0VVnAtxsh4JsWSjNsYOkQM7BAAfSS
 sZRg==
X-Gm-Message-State: AC+VfDw3ieRkLmjBKFqpux0RN7QAjJ1bxgU2Q4N8kqgVdV7kgEKOf9b3
 mh9qwP2+3uOvxNxWzbvxiuEPJ0OMvD2PUKxFoa79LMehM13hvBAhCiI+cF7aFoJztK0qWV5woHX
 sSgGDunL5FxCkttl7KzbAqzywfJQrodpLBbEwWIKnS6eqz5TY7T1e1hFjUTE214GZTR3LFUj8sz
 U=
X-Received: by 2002:a05:6808:130c:b0:3a0:4636:d095 with SMTP id
 y12-20020a056808130c00b003a04636d095mr6133515oiv.59.1687430021349; 
 Thu, 22 Jun 2023 03:33:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vc+1eMGDo7yCfGqth97J98vo1SVEVhz6hu19MEGR4mJ6H/FQXyPvhihuHa4Nj2yxF70EZ3A==
X-Received: by 2002:a05:6808:130c:b0:3a0:4636:d095 with SMTP id
 y12-20020a056808130c00b003a04636d095mr6133492oiv.59.1687430021070; 
 Thu, 22 Jun 2023 03:33:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:40 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 3/5] tests/acpi/bios-tables-test: update acpi blob
 q35/DSDT.noacpihp
Date: Thu, 22 Jun 2023 16:02:53 +0530
Message-Id: <20230622103255.267289-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622103255.267289-1-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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


