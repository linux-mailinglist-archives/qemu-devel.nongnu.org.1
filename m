Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1882A14982
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 07:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNW-0000As-1c; Fri, 17 Jan 2025 00:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMi-0007nc-G5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMf-000671-MY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166360285dso33495455ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093470; x=1737698270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEANGHUgQrDTgbBIAl8bSLRH0F4F4Lc0kztM8Z3Amik=;
 b=ghqPPqzx8VkL4Ip62ULp6Ni1GNswQBouQ4JwshOsGDiju4kRT/K6C7PS++k5GZC3EO
 LG9rWJpQpesnLoxr4yMfCknmvq+ewtNOoECcsN4K3oM0+FvdBgCUMPWa8G228ES+OoNc
 LKtkrD13gZs/FQ+154vxJ6yaUJC1tWoCpTM8h33Je+fM1+55aI+zUNEuRs0n9giFocUL
 QUw9Oi6OVz+sAN3jUNOMmXMQ3TpU6tTtO0Qbz+6uw5iX94kPJNMbxWrgwbQbDfM7Bm82
 SQLLdBndSohzjlwK8sQyaJvgtdQ3IuAjbk8nFh+uxt6qDLOdHDqnZ0gbVsY7gW++ruEa
 ZEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093470; x=1737698270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEANGHUgQrDTgbBIAl8bSLRH0F4F4Lc0kztM8Z3Amik=;
 b=nMdm2Z98a7UqDruzihk9d//h2LwsU31FrDgmFS6NRuE+P7ZZA42Q9SyyDuWPMGycbQ
 wXvWNGzurkjmrSWCi33VhHd8YQhQuMiw1i/q38jvjl5f8ilC6AXkWPcAbltGliRGCLG5
 Etay/wp53LXsIphWXA6eKH4qHslf6zJzq1ixAmiJeytOOrNdx8xbnPCWS208s0+SaH13
 3vMhX9sd+tug2AaIFKmBqa2D0Mqix7k3vv1PVQbSgZ8yhg81bQB5DaXmfJ1gQl2rNXa1
 kVLDWppN5vA7L4agR9FcLEgr/8LuE9eV6ccX5zj2aNMBkT0bXNOBaRZzLeFzmptLtOuA
 0lYg==
X-Gm-Message-State: AOJu0YwW1CALTycyPNzgyUQkfYxCJoQd5fWetxyNgdd+ud94tHd5T3PN
 oHaoce6c51kHF6s46zKAHSlMgwHie+z1qnVJKy+dkGV6e/PdchEUkm2xhw==
X-Gm-Gg: ASbGncs6SPo9SjhOncUby8v2uteyD9AcGovQmJPTdXN1w/tAnYBno/+E1UM0AeNTZ74
 0o4lWmu2ocStlBON50D847lgTnavdIJOD7or+cPk2lZDuIqixkVp3RijSjjAnPeh7OVkm3+Ee0P
 y8WdgFMNZffJdmoHDQ0Z5N36zbdIay1BZVaSg6WiXHaHAzheuLiiOifncrsaZkisBLHhcBJt9oH
 b+70O5ijIS7Z/7ddpHqHl3wOPeAkVmQiu7wAdXKqdbGzShEOCYusPslLxb+3UeSWmCCx/QFLf4I
 JYCM2p0fTKgCDa4KAELNO/30SE18eq/wR4dz27APiendSQ3XhzkDqVednXsz
X-Google-Smtp-Source: AGHT+IG74gQvnlNWKgHaGy7C+EGwv7BAVgoy6KxkFJda+PUPyV0xHPqg2Wswk0LR5EpoE2hO3QfIZw==
X-Received: by 2002:a17:903:2b07:b0:21a:8382:fcbb with SMTP id
 d9443c01a7336-21c35544719mr20836515ad.25.1737093470136; 
 Thu, 16 Jan 2025 21:57:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/50] target/riscv: Add properties for counter delegation ISA
 extensions
Date: Fri, 17 Jan 2025 15:55:34 +1000
Message-ID: <20250117055552.108376-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Atish Patra <atishp@rivosinc.com>

This adds the properties for counter delegation ISA extensions
(Smcdeleg/Ssccfg). Definitions of new registers and and implementation
will come in the next set of patches.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-5-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 target/riscv/cpu.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 4fe2144ec7..561f5119b6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,8 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f5772ae5b..da40f68715 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
@@ -199,6 +200,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
-- 
2.47.1


