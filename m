Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE875781D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2l-000411-JV; Tue, 18 Jul 2023 05:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2i-0003zm-Cy
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2f-0004CR-MD
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUeQPtP30wQxP8JoXzo3N+r7lwBqLZRP2oscgHfdIWQ=;
 b=AkclXmw4Pxxb/v5M0xG9dnKvXLY4H/suGXtIHHAch/pMy8gOm1W5i4bmsN4o0sIFA+nzO1
 UHt79kqR63srLHJZo4vW8yLxaV0QOxevFOZgt6Kug8mwi4VLEmHl8tbgg7OHcqYKuaP4T7
 4a2UAELr7q37Y/FSGp02C4sUaZuKB38=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-XkMLJHCEPVubQb8t753U7A-1; Tue, 18 Jul 2023 05:30:45 -0400
X-MC-Unique: XkMLJHCEPVubQb8t753U7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 636E12A59542;
 Tue, 18 Jul 2023 09:30:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85F352166B25;
 Tue, 18 Jul 2023 09:30:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 2/8] linux-user/elfload: Fix /proc/cpuinfo features: on s390x
Date: Tue, 18 Jul 2023 11:30:34 +0200
Message-Id: <20230718093040.172145-3-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

elf_hwcap_str() takes a bit number, but compares it for equality with
the HWCAP_S390_* masks. This causes /proc/cpuinfo to display incorrect
hwcaps.

Fix by introducing the HWCAP_S390_NR_* constants and using them in
elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
missing nnpa, pcimio and sie hwcaps from the latest kernel.

Output before:

	features	: esan3 zarch stfle msa

Output after:

	features	: esan3 zarch stfle msa ldisp eimm etf3eh highgprs vx vxe

Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str() on s390x")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230627151356.273259-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/elf.h        | 66 +++++++++++++++++++++++++++++++-------------
 linux-user/elfload.c | 41 ++++++++++++++-------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 2f4d0e56d1..ec9755e73b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -596,25 +596,53 @@ typedef struct {
 
 /* Bits present in AT_HWCAP for s390.  */
 
-#define HWCAP_S390_ESAN3        1
-#define HWCAP_S390_ZARCH        2
-#define HWCAP_S390_STFLE        4
-#define HWCAP_S390_MSA          8
-#define HWCAP_S390_LDISP        16
-#define HWCAP_S390_EIMM         32
-#define HWCAP_S390_DFP          64
-#define HWCAP_S390_HPAGE        128
-#define HWCAP_S390_ETF3EH       256
-#define HWCAP_S390_HIGH_GPRS    512
-#define HWCAP_S390_TE           1024
-#define HWCAP_S390_VXRS         2048
-#define HWCAP_S390_VXRS_BCD     4096
-#define HWCAP_S390_VXRS_EXT     8192
-#define HWCAP_S390_GS           16384
-#define HWCAP_S390_VXRS_EXT2    32768
-#define HWCAP_S390_VXRS_PDE     65536
-#define HWCAP_S390_SORT         131072
-#define HWCAP_S390_DFLT         262144
+#define HWCAP_S390_NR_ESAN3      0
+#define HWCAP_S390_NR_ZARCH      1
+#define HWCAP_S390_NR_STFLE      2
+#define HWCAP_S390_NR_MSA        3
+#define HWCAP_S390_NR_LDISP      4
+#define HWCAP_S390_NR_EIMM       5
+#define HWCAP_S390_NR_DFP        6
+#define HWCAP_S390_NR_HPAGE      7
+#define HWCAP_S390_NR_ETF3EH     8
+#define HWCAP_S390_NR_HIGH_GPRS  9
+#define HWCAP_S390_NR_TE        10
+#define HWCAP_S390_NR_VXRS      11
+#define HWCAP_S390_NR_VXRS_BCD  12
+#define HWCAP_S390_NR_VXRS_EXT  13
+#define HWCAP_S390_NR_GS        14
+#define HWCAP_S390_NR_VXRS_EXT2 15
+#define HWCAP_S390_NR_VXRS_PDE  16
+#define HWCAP_S390_NR_SORT      17
+#define HWCAP_S390_NR_DFLT      18
+#define HWCAP_S390_NR_VXRS_PDE2 19
+#define HWCAP_S390_NR_NNPA      20
+#define HWCAP_S390_NR_PCI_MIO   21
+#define HWCAP_S390_NR_SIE       22
+
+#define HWCAP_S390_ESAN3     (1 << HWCAP_S390_NR_ESAN3)
+#define HWCAP_S390_ZARCH     (1 << HWCAP_S390_NR_ZARCH)
+#define HWCAP_S390_STFLE     (1 << HWCAP_S390_NR_STFLE)
+#define HWCAP_S390_MSA       (1 << HWCAP_S390_NR_MSA)
+#define HWCAP_S390_LDISP     (1 << HWCAP_S390_NR_LDISP)
+#define HWCAP_S390_EIMM      (1 << HWCAP_S390_NR_EIMM)
+#define HWCAP_S390_DFP       (1 << HWCAP_S390_NR_DFP)
+#define HWCAP_S390_HPAGE     (1 << HWCAP_S390_NR_HPAGE)
+#define HWCAP_S390_ETF3EH    (1 << HWCAP_S390_NR_ETF3EH)
+#define HWCAP_S390_HIGH_GPRS (1 << HWCAP_S390_NR_HIGH_GPRS)
+#define HWCAP_S390_TE        (1 << HWCAP_S390_NR_TE)
+#define HWCAP_S390_VXRS      (1 << HWCAP_S390_NR_VXRS)
+#define HWCAP_S390_VXRS_BCD  (1 << HWCAP_S390_NR_VXRS_BCD)
+#define HWCAP_S390_VXRS_EXT  (1 << HWCAP_S390_NR_VXRS_EXT)
+#define HWCAP_S390_GS        (1 << HWCAP_S390_NR_GS)
+#define HWCAP_S390_VXRS_EXT2 (1 << HWCAP_S390_NR_VXRS_EXT2)
+#define HWCAP_S390_VXRS_PDE  (1 << HWCAP_S390_NR_VXRS_PDE)
+#define HWCAP_S390_SORT      (1 << HWCAP_S390_NR_SORT)
+#define HWCAP_S390_DFLT      (1 << HWCAP_S390_NR_DFLT)
+#define HWCAP_S390_VXRS_PDE2 (1 << HWCAP_S390_NR_VXRS_PDE2)
+#define HWCAP_S390_NNPA      (1 << HWCAP_S390_NR_NNPA)
+#define HWCAP_S390_PCI_MIO   (1 << HWCAP_S390_NR_PCI_MIO)
+#define HWCAP_S390_SIE       (1 << HWCAP_S390_NR_SIE)
 
 /* M68K specific definitions. */
 /* We use the top 24 bits to encode information about the
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a26200d9f3..861ec07abc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1621,25 +1621,28 @@ uint32_t get_elf_hwcap(void)
 const char *elf_hwcap_str(uint32_t bit)
 {
     static const char *hwcap_str[] = {
-        [HWCAP_S390_ESAN3]     = "esan3",
-        [HWCAP_S390_ZARCH]     = "zarch",
-        [HWCAP_S390_STFLE]     = "stfle",
-        [HWCAP_S390_MSA]       = "msa",
-        [HWCAP_S390_LDISP]     = "ldisp",
-        [HWCAP_S390_EIMM]      = "eimm",
-        [HWCAP_S390_DFP]       = "dfp",
-        [HWCAP_S390_HPAGE]     = "edat",
-        [HWCAP_S390_ETF3EH]    = "etf3eh",
-        [HWCAP_S390_HIGH_GPRS] = "highgprs",
-        [HWCAP_S390_TE]        = "te",
-        [HWCAP_S390_VXRS]      = "vx",
-        [HWCAP_S390_VXRS_BCD]  = "vxd",
-        [HWCAP_S390_VXRS_EXT]  = "vxe",
-        [HWCAP_S390_GS]        = "gs",
-        [HWCAP_S390_VXRS_EXT2] = "vxe2",
-        [HWCAP_S390_VXRS_PDE]  = "vxp",
-        [HWCAP_S390_SORT]      = "sort",
-        [HWCAP_S390_DFLT]      = "dflt",
+        [HWCAP_S390_NR_ESAN3]     = "esan3",
+        [HWCAP_S390_NR_ZARCH]     = "zarch",
+        [HWCAP_S390_NR_STFLE]     = "stfle",
+        [HWCAP_S390_NR_MSA]       = "msa",
+        [HWCAP_S390_NR_LDISP]     = "ldisp",
+        [HWCAP_S390_NR_EIMM]      = "eimm",
+        [HWCAP_S390_NR_DFP]       = "dfp",
+        [HWCAP_S390_NR_HPAGE]     = "edat",
+        [HWCAP_S390_NR_ETF3EH]    = "etf3eh",
+        [HWCAP_S390_NR_HIGH_GPRS] = "highgprs",
+        [HWCAP_S390_NR_TE]        = "te",
+        [HWCAP_S390_NR_VXRS]      = "vx",
+        [HWCAP_S390_NR_VXRS_BCD]  = "vxd",
+        [HWCAP_S390_NR_VXRS_EXT]  = "vxe",
+        [HWCAP_S390_NR_GS]        = "gs",
+        [HWCAP_S390_NR_VXRS_EXT2] = "vxe2",
+        [HWCAP_S390_NR_VXRS_PDE]  = "vxp",
+        [HWCAP_S390_NR_SORT]      = "sort",
+        [HWCAP_S390_NR_DFLT]      = "dflt",
+        [HWCAP_S390_NR_NNPA]      = "nnpa",
+        [HWCAP_S390_NR_PCI_MIO]   = "pcimio",
+        [HWCAP_S390_NR_SIE]       = "sie",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.39.3


