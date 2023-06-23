Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E232873B850
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMF-0000Q3-Kq; Fri, 23 Jun 2023 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMC-0000P3-IV; Fri, 23 Jun 2023 08:57:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMA-0006Q8-UE; Fri, 23 Jun 2023 08:57:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso424430b3a.1; 
 Fri, 23 Jun 2023 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525059; x=1690117059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tuemuz9+yMRA0aIIj5fzqEDX8XdmM6dDu+ce4c9JhTE=;
 b=bB4r7P9DM5+cpvZJaXk+5gX55lHPBFSmgZjsJVkTfX7sMB/tidp68n8bWYyy4FTqeQ
 XhLoCo+/H6tDP3lWJ1f2NGjk5FwstPZah5hQ/US+vtoCopMcc5xuQx+nA1hw+Z+AKcVO
 37wDGHJpT+4dEBXFiurYUs7061gKtIhQv9EaNAN23e5Bd8Tmf4clEAB3q8KnZRldmkEz
 FYrpahQws9tirQ4ELSaJFVDQRvoVvPx9LH4eM/lWAqmOkfbFuGcV7r4+Rc4BxypmS6v1
 tu/b4J/GEyFv1x9e11JBhofICt8Cu1MKC62unZ+81CaksMESpiGaFjz6SBl6qQcQieHX
 OqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525059; x=1690117059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tuemuz9+yMRA0aIIj5fzqEDX8XdmM6dDu+ce4c9JhTE=;
 b=BBJGrlaqdZs64kv3YNkncRpAqK2d2Ck1LUn8v+861a1odEGj4BgMCBeyqis0JifP9S
 DvagqKCKMSn6wmd38z+QlOkKofOzOBvh0sIBEMYU0eIH3WPxKrX6wncx9tCrtnZWR5/d
 1ioBxNskVWaIMvV5qnF2nNGY6q4jxv8X+ayCteImkabMjx7CXAp7hANYpnIO/Oi7evbw
 bHFR+NkZUKVzlmLRQabdGr/cblaujnYD6yzzcaaOXNOC7mhAykspBhqQKXmg3VM0EoAn
 2zN+vSa3vN5O/jTMXwEJ/ZGa/0NXEx5SZjv8enbQAsbbZAK7SbcssO3AbHRyJOvWkExT
 7heQ==
X-Gm-Message-State: AC+VfDxTZ0+BnJli55VbjEEsbhIaimPoB722fqH6o+/vHZhcavslkc61
 Bi9yhmi+URyAihtbEmpEF9bvbwqgFjU=
X-Google-Smtp-Source: ACHHUZ4TSiaX6Kevkrc3Lc13nd3arZd3KviKJoFcQnHDhswOtQtZa1y8XOXYST3MSCycXyDEXxb40g==
X-Received: by 2002:a05:6a20:548c:b0:123:100e:c8ae with SMTP id
 i12-20020a056a20548c00b00123100ec8aemr10576577pzk.52.1687525059285; 
 Fri, 23 Jun 2023 05:57:39 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/7] spapr: Fix machine reset deadlock from replay-record
Date: Fri, 23 Jun 2023 22:57:03 +1000
Message-Id: <20230623125707.323517-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 20 ++++++++++++++++++--
 include/hw/ppc/spapr.h |  1 +
 target/ppc/compat.c    | 19 +++++++++++++++++++
 target/ppc/cpu.h       |  1 +
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 677b5eef9d..d290acfa95 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1317,6 +1317,22 @@ void spapr_set_all_lpcrs(target_ulong value, target_ulong mask)
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
@@ -1578,7 +1594,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
     }
     /* We're setting up a hash table, so that means we're not radix */
     spapr->patb_entry = 0;
-    spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
+    spapr_init_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
     return 0;
 }
 
@@ -1656,7 +1672,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
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
index 0087ce66e2..a0f4cec606 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1496,6 +1496,7 @@ int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
 int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
-- 
2.40.1


