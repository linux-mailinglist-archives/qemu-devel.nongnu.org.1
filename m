Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B8763F1D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMh-0000Yi-Tp; Wed, 26 Jul 2023 14:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMd-0000Mb-Oh; Wed, 26 Jul 2023 14:35:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMb-0008HR-Hc; Wed, 26 Jul 2023 14:35:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b9cdef8619so677755ad.0; 
 Wed, 26 Jul 2023 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396556; x=1691001356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77fSGNGo6S4pQfx5yDcXmMMJ9f/I3cVQmostFkDgDU4=;
 b=grM163GTsmG603K2ykbGuZSHmUOdG+54jAnaESRpZSN0UfGSwpn1aGKEyS46IjFm35
 b501Pv8i4m/sxVDLG0rjhHEeHFMpmKrlIPnh+0kKRR8geIxhGPnZcjb4erz1Cf4Wk2Ae
 +HzPBcL4fqkRPqEKKoIbRcDOVK0xwzi7HsAeAJG6SlOVqoXmFp3lYEyE8f5Ct7XW8LCa
 1FdcbTqDdep8hobXcTepVQ51GEZ68cmozE6BbRTJWzIWgAtyqwsXlUIHsA13BwRsmSm1
 WljC4aXUQPtQl6XiJVJF7yHx9TRrUH5RHoVemGX4RXgDBuQSUzp+hcJ7FkT3kV5CHUml
 6N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396556; x=1691001356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77fSGNGo6S4pQfx5yDcXmMMJ9f/I3cVQmostFkDgDU4=;
 b=VzkFcryVDO/OIUwq986kuJWuwkHHMcDKMrqdrgT9t7biqEsk+ozST19or/BhasKgbC
 ztxICO4moZknTSvifRfYrW+067UcGVNmFvun/iQfubB8007UCwq4YJADk185OBM0a+0p
 Uacvi+a32MycfBljWxRVrvwVds9MLHbg/wTzghIPEwfWeYA7UXblJIuXH5Q32XR/ZoOn
 3fb4uvYrccYpvbF6XthJm9J1FPKW5/NNHqPhKw1QLU4Oj+rwLVE4DF1B9m2fVtC5bN8M
 WJ86wD2ZIsYXRNy9kCOUHv/dGBy+t/xC+qcYIdFp5iKyl8V/CVMHOObdNaKNkQUtPQ3D
 DYSw==
X-Gm-Message-State: ABy/qLb7ehCBl55lDwUYtsZbiC4PKgT4ZBbD2iIVEd5+r0pn33Roa2Tv
 7TWcEemLzxqTJmrFMA8ydiEF02TJ2JM=
X-Google-Smtp-Source: APBJJlE3EZO1XKyi2cYl/qOcR8FU4p9OxaMCn2oouRlFZ6kvsNi2+URktYO6dGzLHrnZIyE3+hzTcQ==
X-Received: by 2002:a17:903:11d1:b0:1b7:c166:f197 with SMTP id
 q17-20020a17090311d100b001b7c166f197mr2909508plh.29.1690396555970; 
 Wed, 26 Jul 2023 11:35:55 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:35:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 3/7] spapr: Fix machine reset deadlock from replay-record
Date: Thu, 27 Jul 2023 04:35:28 +1000
Message-Id: <20230726183532.434380-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When the machine is reset to load a new snapshot while being debugged
with replay-record, it is done from another thread, so the CPU does
not run the register setting operations. Set CPU registers directly in
machine reset.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 20 ++++++++++++++++++--
 include/hw/ppc/spapr.h |  1 +
 target/ppc/compat.c    | 19 +++++++++++++++++++
 target/ppc/cpu.h       |  1 +
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a7..7d84244f03 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1322,6 +1322,22 @@ void spapr_set_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
+/* May be used when the machine is not running */
+void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
+{
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
+        target_ulong lpcr;
+
+        lpcr = env->spr[SPR_LPCR];
+        lpcr &= ~(LPCR_HR | LPCR_UPRT);
+        ppc_store_lpcr(cpu, lpcr);
+    }
+}
+
+
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1583,7 +1599,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
     }
     /* We're setting up a hash table, so that means we're not radix */
     spapr->patb_entry = 0;
-    spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
+    spapr_init_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
     return 0;
 }
 
@@ -1661,7 +1677,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
     spapr_ovec_cleanup(spapr->ov5_cas);
     spapr->ov5_cas = spapr_ovec_new();
 
-    ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
+    ppc_init_compat_all(spapr->max_compat_pvr, &error_fatal);
 
     /*
      * This is fixing some of the default configuration of the XIVE
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 538b2dfb89..f47e8419a5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1012,6 +1012,7 @@ bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
+void spapr_init_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
 bool spapr_memory_hot_unplug_supported(SpaprMachineState *spapr);
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7949a24f5a..ebef2cccec 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -229,6 +229,25 @@ int ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
     return 0;
 }
 
+/* To be used when the machine is not running */
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        int ret;
+
+        ret = ppc_set_compat(cpu, compat_pvr, errp);
+
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 int ppc_compat_max_vthreads(PowerPCCPU *cpu)
 {
     const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 27532d8f81..40be0c362a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1497,6 +1497,7 @@ int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
 int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
-- 
2.40.1


