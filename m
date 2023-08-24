Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A30786AD8
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6AM-0007Ls-1l; Thu, 24 Aug 2023 04:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AJ-0007JC-EK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AG-0003ia-Lf
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+INQJt6rBrSed828xMroy0Krb0dhJ4qJKWssCfCbKWQ=;
 b=Bqt8nekOscncFpqOKca3fwBE5ejwoq5Adip9jf3yLI1+OS06ZcrzmjIV+0pLSUlNAN15gZ
 2zWBcfhBf4NxHjKs/Su+g8Fla2ybTon9n7AYp0niZX6ovj7IGGDDvEXP6LcJ4fdnmvdVPV
 XiRiRAMoWFHVCdHk3YJxX1DImGPY9aM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-v3ZjMGuEMG2ZfS5sO7-HKA-1; Thu, 24 Aug 2023 04:57:59 -0400
X-MC-Unique: v3ZjMGuEMG2ZfS5sO7-HKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9C8185A7A4;
 Thu, 24 Aug 2023 08:57:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46DF1492C13;
 Thu, 24 Aug 2023 08:57:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B6E941800632; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 2/6] detect physical address space size
Date: Thu, 24 Aug 2023 10:57:52 +0200
Message-ID: <20230824085756.66732-3-kraxel@redhat.com>
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check for pae and long mode using cpuid.  If present also read the
physical address bits.  Apply some qemu sanity checks (see below).
Record results in PhysBits and LongMode variables.  In case we are not
sure what the address space size is leave the PhysBits variable unset.

On qemu we have the problem that for historical reasons x86_64
processors advertise 40 physical address space bits by default, even in
case the host supports less than that so actually using the whole
address space will not work.

Because of that the code applies some extra sanity checks in case we
find 40 (or less) physical address space bits advertised.  Only
known-good values (which is 40 for amd processors and 36+39 for intel
processors) will be accepted as valid.

Recommendation is to use 'qemu -cpu ${name},host-phys-bits=on' to
advertise valid physical address space bits to the guest.  Some distro
builds enable this by default, and most likely the qemu default will
change in near future too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/paravirt.h |  2 ++
 src/fw/paravirt.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/src/fw/paravirt.h b/src/fw/paravirt.h
index 4e2e993ba9d3..62a2cd075d2b 100644
--- a/src/fw/paravirt.h
+++ b/src/fw/paravirt.h
@@ -31,6 +31,8 @@ typedef struct QemuCfgDmaAccess {
 extern u32 RamSize;
 extern u64 RamSizeOver4G;
 extern int PlatformRunningOn;
+extern u8 CPUPhysBits;
+extern u8 CPULongMode;
 
 static inline int runningOnQEMU(void) {
     return CONFIG_QEMU || (
diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
index 42abac8460c5..3aee4c0d4e6b 100644
--- a/src/fw/paravirt.c
+++ b/src/fw/paravirt.c
@@ -32,6 +32,10 @@
 u32 RamSize;
 // Amount of continuous ram >4Gig
 u64 RamSizeOver4G;
+// physical address space bits
+u8 CPUPhysBits;
+// 64bit processor
+u8 CPULongMode;
 // Type of emulator platform.
 int PlatformRunningOn VARFSEG;
 // cfg enabled
@@ -130,6 +134,58 @@ static void kvmclock_init(void)
     tsctimer_setfreq(MHz * 1000, "kvmclock");
 }
 
+static void physbits(int qemu_quirk)
+{
+    unsigned int max, eax, ebx, ecx, edx;
+    unsigned int physbits;
+    char signature[13];
+    int pae = 0, valid = 0;
+
+    cpuid(0, &eax, &ebx, &ecx, &edx);
+    memcpy(signature + 0, &ebx, 4);
+    memcpy(signature + 4, &edx, 4);
+    memcpy(signature + 8, &ecx, 4);
+    signature[12] = 0;
+    if (eax >= 1) {
+        cpuid(1, &eax, &ebx, &ecx, &edx);
+        pae = (edx & (1 << 6));
+    }
+
+    cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
+    max = eax;
+
+    if (max >= 0x80000001) {
+        cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
+        CPULongMode = !!(edx & (1 << 29));
+    }
+
+    if (pae && CPULongMode && max >= 0x80000008) {
+        cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+        physbits = (u8)eax;
+        if (!qemu_quirk) {
+            valid = 1;
+        } else if (physbits >= 41) {
+            valid = 1;
+        } else if (strcmp(signature, "GenuineIntel") == 0) {
+            if ((physbits == 36) || (physbits == 39))
+                valid = 1;
+        } else if (strcmp(signature, "AuthenticAMD") == 0) {
+            if (physbits == 40)
+                valid = 1;
+        }
+    } else {
+        physbits = pae ? 36 : 32;
+        valid = 1;
+    }
+
+    dprintf(1, "%s: signature=\"%s\", pae=%s, lm=%s, phys-bits=%d, valid=%s\n",
+            __func__, signature, pae ? "yes" : "no", CPULongMode ? "yes" : "no",
+            physbits, valid ? "yes" : "no");
+
+    if (valid)
+        CPUPhysBits = physbits;
+}
+
 static void qemu_detect(void)
 {
     if (!CONFIG_QEMU_HARDWARE)
@@ -162,6 +218,7 @@ static void qemu_detect(void)
         dprintf(1, "Running on QEMU (unknown nb: %04x:%04x)\n", v, d);
         break;
     }
+    physbits(1);
 }
 
 static int qemu_early_e820(void);
-- 
2.41.0


