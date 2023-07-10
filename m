Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECD74D5D5
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq7Q-00026v-OA; Mon, 10 Jul 2023 08:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6t-0001bi-3v
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:23 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6r-0005Kh-2j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:22 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a3eae37625so1260215b6e.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992518; x=1691584518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jdinUoq3Kem1ap8svXWcq5DD03xKhm9t8fEevN1iJs=;
 b=GAHPc9aOeSXdeXO/LQTmilqrHRjF8CecHea+PJ98e22JQ7ODBUzXNc+CRFwua9vs/t
 NkHXF6m3Yc8uhgBlwIITyuzH+RNO5eV/M5Bu+wuPnDA89Qn9cxE5+Mz02fFO5BmCWHJn
 kkxxaJZ6R1FopL2vb1V0dy0aQ/PNfsmY4xJg8TIpkqPvqYUpOHqLPyjGVeV9ebYbGaG/
 YoL/6HfenE95EIInDY49s+2L8BJT5XE/Hp6c07YRAw1mDBsUjqPOUUneWas4Jpu7OnkG
 y4wzATOorfdKdgxLoojmDPD+HMVOcq6lRVxzUYvKzt76yOo5AgeVleNhQ2dzfWuhwFK3
 fxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992518; x=1691584518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jdinUoq3Kem1ap8svXWcq5DD03xKhm9t8fEevN1iJs=;
 b=bgep0JyGYXe4FLnUsrPfzhKiRkJEBQhKo1jDr4cuU75Go/nuzpeMlXtYeOime0q6xT
 G3IF/8hpVbe4Cp+a7yApwfr+jKwePLm5SsiTmnUuSPDBwCTw1d04S/IjwZtKNUHnbfKw
 MxkAh2AIZ7fH6tLkX6A5GAIRV9LEWHVPHSLbY7p6H1w7EAfJg+DFV5usnWxPIq2FnT+w
 QkaiiilDfBUSFuJYvBEZA+5d4UNd5thL+BYtpMRR8nny0dGStvOwvz1VaL1mFNpR/SUS
 gfdfMrG79buPh/wQzErz7DmTRYH13NYrsBIyOcg47JzWyP6vr3Icnang6iIUrcvwGcL8
 o9SQ==
X-Gm-Message-State: ABy/qLZk/EYwjTq2tNu2F+XHDNNIVhMAIHL8EJ7pAHaw+6AiS7UabtiK
 DJuODwRmnL7uRfbEo6hs3dhtBdufcETEVQ==
X-Google-Smtp-Source: APBJJlFzbj+QljzkuYEPb5ihZwYA3Br4S+6PzeJpCHai4KJr57mRNai3IaymBcLyTBVztrz0DULIiw==
X-Received: by 2002:a05:6808:d48:b0:3a0:5a6b:25c with SMTP id
 w8-20020a0568080d4800b003a05a6b025cmr10065707oik.33.1688992518523; 
 Mon, 10 Jul 2023 05:35:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:35:18 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/54] target/riscv/kvm.c: add kvmconfig_get_cfg_addr() helper
Date: Mon, 10 Jul 2023 22:32:03 +1000
Message-Id: <20230710123205.2441106-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

There are 2 places in which we need to get a pointer to a certain
property of the cpu->cfg struct based on property offset. Next patch
will add a couple more.

Create a helper to avoid repeating this code over and over.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-20-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 4d7476cf15..fd22ef4162 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -215,11 +215,15 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
 };
 
+static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
+{
+    return (void *)&cpu->cfg + kvmcfg->offset;
+}
+
 static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
                             uint32_t val)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     *ext_enabled = val;
 }
@@ -227,8 +231,7 @@ static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
 static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
                                 KVMCPUConfig *multi_ext)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     return *ext_enabled;
 }
-- 
2.40.1


