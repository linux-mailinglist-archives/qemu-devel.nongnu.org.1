Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16A79E455
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMZV-00058v-3m; Wed, 13 Sep 2023 05:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qgMZN-00057l-Fk
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:54:02 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qgMZL-0001Qu-8e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:54:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 87572B8224E;
 Wed, 13 Sep 2023 09:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667FBC433C7;
 Wed, 13 Sep 2023 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694598829;
 bh=lMC9fwkpn5xWfNEcwZzLXSPlfHS2thRrwL2OjWwWbZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oXNhYrRnXYmnn0z0Myqw6gAmhntVvaVHtACaCwS7QPg03Boc2wis0rApLbn5/JuEp
 XmXSxE38GJhLHxuYQQnOapJ/FCskhHtdBz1N7pxtnqrbRdxVYqTbqUrMvM6MR5cK8l
 WJo/fWtGd8fC3zIC8e1aMHnG0SCoGiziwBr3aKaejwfH6b+aCkuNusS6GiEESeGqu1
 wxFxTw1shSx0TI1L6kFhiVwldg0c3t7t1OuV7iPjMto3hi8eiwCLPQOyUM2jo0yoP/
 eEcC7drPXp0rcI8gfnLhmTgQPDnoiYL59GSgOygdVds6+xdiCUfhTcMdqc8yHvjdln
 MRRoQyqzcjo6Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 3/6] target/hppa: Provide qemu version via fw_cfg to firmware
Date: Wed, 13 Sep 2023 11:53:37 +0200
Message-ID: <20230913095340.32951-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913095340.32951-1-deller@kernel.org>
References: <20230913095340.32951-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Report the new number of TLB entries (without BTLBs) to the
guest and drop reporting of BTLB entries which weren't used at all.

Clear all BTLB and TLB entries at machine reset.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 866e11d208..cf28cb9586 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -133,14 +133,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(HPPA_TLB_ENTRIES);
+    val = cpu_to_le64(HPPA_TLB_ENTRIES - HPPA_BTLB_ENTRIES);
     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(HPPA_BTLB_ENTRIES);
-    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
-
     val = cpu_to_le64(HPA_POWER_BUTTON);
     fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
                     g_memdup(&val, sizeof(val)), sizeof(val));
@@ -433,6 +429,10 @@ static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 
         cs->exception_index = -1;
         cs->halted = 0;
+
+        /* clear any existing TLB and BTLB entries */
+        memset(cpu[i]->env.tlb, 0, sizeof(cpu[i]->env.tlb));
+        cpu[i]->env.tlb_last = HPPA_BTLB_ENTRIES;
     }
 
     /* already initialized by machine_hppa_init()? */
-- 
2.41.0


