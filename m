Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2A831AA5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:33:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSVW-0004xs-Te; Thu, 18 Jan 2024 08:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVT-0004x2-Tu; Thu, 18 Jan 2024 08:32:31 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVS-00022f-8o; Thu, 18 Jan 2024 08:32:31 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9cdd0a5e6so7110202b3a.3; 
 Thu, 18 Jan 2024 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584748; x=1706189548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp4VqctlcOHDSbky/1yqB0zizFgsvSyeOkwNaVp6158=;
 b=eQ7W85Fa5AXvFUo2xz826Kq4iheg+5mjI4PrBMzkTDhbbgnspEwfIB4+BnmxVhO35N
 kWk6bTnS9ddq3TwumhgwxzV5nNK9YIBg5gA03FOlXJholrBiVphcsvNryo0+7/CJxDsZ
 isAosXLXSrP0xhO9saFaJF78WhVdWs17xWw1h6724IsG2nEzgImRWST/fOOo82zpmaYB
 sr0QSx3rS60hCxDQCKEn+BbVCedt1KD7CfUR+s5wcJJ2BORxf0dmq2qW3oCgpl083XQW
 ZbSYhBQrF4dwDPP1G9PT74F9udRp63sh9YW95U2yYvVLNBMjOfswLn0dH6b8yu9XBX+U
 EmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584748; x=1706189548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gp4VqctlcOHDSbky/1yqB0zizFgsvSyeOkwNaVp6158=;
 b=b9BpwaTdcDoFb2aZjpyhyZP0d/+qlTEleY5uxyAjStHkTOBafecLimTntQv+nglT+t
 n6pJVDiZM0KRjVpeuvQOufcuqpDytKdlEZM2+qEV5Bkyq6DANudjJrpph03GZ5o7Pm0y
 GhhKSwsVLI4mDHqBv0fV61eswEawSbMiWLlSpjygQnmfdvXaBi0KIUWOf/qznlvY0LqK
 36oeSNUcTxcCpVhJApPkET+U+1ClpvSPsQuCvHipmBGQV26dych6Zqcy7Gvl3SgMuCix
 R8EI+F+EpVZHqimfRu8MtYENwLZVWNZL1F6pkz4BgDKV0VSffo0A6v4NaUjOyINqcM79
 xh4w==
X-Gm-Message-State: AOJu0YybrWN7U+FJPTsMC1J8BJi1x6JV9jdc2kTXfeQd/F0/cXcWzlK3
 FPucuWuBeMAwmhZ+jjzGHQgpBv6FWlqwfMeTzJFuaWAVCWsBVUjw4/vLjruF
X-Google-Smtp-Source: AGHT+IFket2fBfFvcn4kls2QA2T3MFAhU64/+ufwXxq40TCq0WFkOjapMQU0gOdhqT/msBXpnqlqbQ==
X-Received: by 2002:a05:6a00:2a0a:b0:6db:1038:ee52 with SMTP id
 ce10-20020a056a002a0a00b006db1038ee52mr905999pfb.16.1705584748103; 
 Thu, 18 Jan 2024 05:32:28 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa780d3000000b006daf1ded817sm3282551pfn.209.2024.01.18.05.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:32:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/ppc/spapr_hcall: Rename {softmmu ->
 vhyp_mmu}_resize_hpt_pr
Date: Thu, 18 Jan 2024 23:32:05 +1000
Message-ID: <20240118133206.158453-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118133206.158453-1-npiggin@gmail.com>
References: <20240118133206.158453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since 'softmmu' is quite a loaded term in QEMU, rename the vhyp MMU
facilities to use the vhyp_mmu_ prefix rather than softmmu_.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Pick a different name.]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h | 9 ++++++---
 hw/ppc/spapr_hcall.c   | 4 ++--
 hw/ppc/spapr_softmmu.c | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e91791a1a9..5b5ba9ef77 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -634,10 +634,13 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineState *spapr,
+target_ulong vhyp_mmu_resize_hpt_prepare(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
                                          target_ulong shift);
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                                        target_ulong flags, target_ulong shift);
+target_ulong vhyp_mmu_resize_hpt_commit(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong flags,
+                                        target_ulong shift);
 bool is_ram_address(SpaprMachineState *spapr, hwaddr addr);
 void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d7d523e6d..75c2d12978 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -124,7 +124,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+        return vhyp_mmu_resize_hpt_prepare(cpu, spapr, shift);
     } else {
         g_assert_not_reached();
     }
@@ -194,7 +194,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+        return vhyp_mmu_resize_hpt_commit(cpu, spapr, flags, shift);
     } else {
         g_assert_not_reached();
     }
diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index 2fade94029..b3dd8b3a59 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -378,7 +378,7 @@ static void cancel_hpt_prepare(SpaprMachineState *spapr)
     free_pending_hpt(pending);
 }
 
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu,
+target_ulong vhyp_mmu_resize_hpt_prepare(PowerPCCPU *cpu,
                                          SpaprMachineState *spapr,
                                          target_ulong shift)
 {
@@ -562,7 +562,7 @@ static int rehash_hpt(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu,
+target_ulong vhyp_mmu_resize_hpt_commit(PowerPCCPU *cpu,
                                         SpaprMachineState *spapr,
                                         target_ulong flags,
                                         target_ulong shift)
-- 
2.42.0


