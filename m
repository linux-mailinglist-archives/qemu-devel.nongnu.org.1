Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C50CD7737E4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDn-00082a-Gz; Tue, 08 Aug 2023 00:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDl-0007zF-Sy; Tue, 08 Aug 2023 00:21:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDk-0007pd-4u; Tue, 08 Aug 2023 00:21:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so3560067b3a.2; 
 Mon, 07 Aug 2023 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468482; x=1692073282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zhYuU1LPhkk5c/LHJ1SKaslbsMf0uSaFlo7cbMkXb4=;
 b=nxaQ9OT80N1SOxZYG09EDuFjJ3DcUB4qlOfKKKiTL3ZWLfLyHz/rJ/wm09GF0AycYD
 apjVZpztRbSIqaiuoiBrD+57SJiQwOc0jXSjrUBS+Ewu+HftM1vHN+vAYbiH2ASyUkpL
 ps8OM35PywL1eux8W5dMieR1iX1wZSdMY3KMw1LffbrwONsfoSKVKg87RcBFj2LCP9EX
 SCtYeZCI35mwT0MVdrVpYoCEIj7Z7D/LWJ8W3IGhu43M8/3V2/fRhjon2U4gWF83G9jY
 OfF9dT8auz0j9mqPqwux+kkcTDB667CkPuTLJip9dHqMnho7rZtCT3NDKbvA7Ch8aTDU
 JRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468482; x=1692073282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zhYuU1LPhkk5c/LHJ1SKaslbsMf0uSaFlo7cbMkXb4=;
 b=TEw6aFUi/t/zJOlrXw0JAy8PzDIodcm8SN5W3OZmSVFgbo+Wx9jtxi72O4cZzgmiX2
 Vh1bmVuuILXAKFmTVzigwD4JGVW2s0MF5hozWISGNKZF1RjcbtHJWsBPxhJoK5bOuEn2
 CTc27cbL1jqTJoYi9tgOEVV6Q1WDyRNUfmDeCS/kAfSYrHqzs8UbTJnoFO6M+7iK7fPz
 YFHVqr0ip+V22hRh9qhk1HqS7YbseYOXXS7jedec6v6YpqswIe5kcLCy49FNBlA9Ez8t
 NpJHMheShCXCob6Ca1biJ8gf5jKYrhMEi7voClEa+pE6QHjFvdIKp38wU6vKF/NuZntj
 BqDA==
X-Gm-Message-State: AOJu0YxHkfDgfJ02xbL1eTwwfghoXkJroP6Vq9ME3nYmLIQV1kHRlcpE
 lapkVScDYe1JvLRUlkI+UVQ=
X-Google-Smtp-Source: AGHT+IGwC/NipY6A6yji07yq4FAPm/suS09zvRxseHqE6p27WpYA76BEbHzkvsCx+I/XEJda7hQhiw==
X-Received: by 2002:a05:6a21:7888:b0:140:4efb:1c09 with SMTP id
 bf8-20020a056a21788800b001404efb1c09mr8210786pzc.55.1691468482268; 
 Mon, 07 Aug 2023 21:21:22 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 15/19] spapr: Fix machine reset deadlock from replay-record
Date: Tue,  8 Aug 2023 14:19:57 +1000
Message-Id: <20230808042001.411094-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index 9e491e05eb..f8fe0db5cd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1504,6 +1504,7 @@ int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
 int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
-- 
2.40.1


