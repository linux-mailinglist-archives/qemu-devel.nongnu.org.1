Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4372ED80
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B76-00024v-U4; Tue, 13 Jun 2023 16:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B74-00023j-Of
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:38 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B73-0006j5-9C
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:38 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-559409cc490so4170318eaf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689976; x=1689281976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8ASDdryGzeW4hp9SEkr1lUwKwLm1J02DfoYsDtoqkc=;
 b=UjinlDWB3gCmXc1MMpGtcHDA/5FwB5WXZWe+Ei0fDlbYPee+wJgYlYIwGqfmnPXGrg
 S9nUD2GmW/wejFP4pF3/iAxDEFRzGvhsHSof9WT/slQZMaqyd4kgPAT8VYu0hPpYzEYJ
 uBshTaksrZ524c0AIGzHu10J2HJlG9OxnFinp6sxM2RwUdzwGg5p1gHGlx7ouYkYd+F4
 w1yLw36cOD7Y5loEiZ8PVPTF74aSccskJgmtNSgqhxcHSx2hg/we4qO2y4gCoKWPg1zI
 y1diS+0XAeu4S+H+vYemV45k1YAoMo5k4R/U/c5cT4k7aypMvMeJ3SU7tYGpaztiBCzi
 qd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689976; x=1689281976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8ASDdryGzeW4hp9SEkr1lUwKwLm1J02DfoYsDtoqkc=;
 b=MLM244Wg0PLoJGHK9F0ATVD6qs6rRvY+Esm7tGfg7aUbclaqdkEJunr4R3V5xA7HvO
 wJi+KLGZ8vrasoetSi/rCJd2KhDp8aym224z7fYnKTm21HJdB1oW++deS3z1y2KsG0sJ
 Y1J8LzXBXjlWPo/QV7nUEbVlKg/d4CSa+T/+oS1+40rfjLx9Ti+6M0wP6TerdV6oDG++
 hmkd1rCrGSwkWbnWIxOI0Bczv2Ddp8vgyHfkJzY1pPoM4wXlI9RlVTP0OPrIzoAKO5dX
 po/HAxEzgzF/r08yERuR27zYA/NsBqQgL3IW1/IelmYtKINeb6CFuOCEsyVFM9HLVPl3
 Z4kg==
X-Gm-Message-State: AC+VfDynDO7C1aTGb9ZHxXIWu/ACJMCEim/Bk1I+pPmjEHJGNpHMfOU9
 9Tgn4kQ/YgkbfULFfYer57JKSxHvLYYmJe9TZNU=
X-Google-Smtp-Source: ACHHUZ41GFd+nj3Bi9072pQvD6FNFARj+UctTWaJXxiYR1lBp+Iai5ZSkxj0Xkpg9QAeYsG9yBCO1g==
X-Received: by 2002:a4a:ead4:0:b0:558:ae64:6533 with SMTP id
 s20-20020a4aead4000000b00558ae646533mr8663273ooh.8.1686689976037; 
 Tue, 13 Jun 2023 13:59:36 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:35 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/18] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Tue, 13 Jun 2023 17:58:46 -0300
Message-Id: <20230613205857.495165-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Allow 'marchid' and 'mimpid' to also be initialized in
kvm_riscv_init_machine_ids().

After this change, the handling of mvendorid/marchid/mimpid for the
'host' CPU type will be equal to what we already have for TCG named
CPUs, i.e. the user is not able to set these values to a different val
than the one that is already preset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 37f0f70794..cd2974c663 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -378,6 +378,22 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.addr = (uint64_t)&cpu->cfg.marchid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve marchid from host, error %d", ret);
+    }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.addr = (uint64_t)&cpu->cfg.mimpid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve mimpid from host, error %d", ret);
+    }
 }
 
 void kvm_riscv_init_user_properties(Object *cpu_obj)
-- 
2.40.1


