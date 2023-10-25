Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D07D7095
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfap-0005W8-28; Wed, 25 Oct 2023 11:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfan-0005Tx-05
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfal-0003fD-8Q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so5803679b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246881; x=1698851681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npJ2K69OOSsKJtanlFl7eXChj2RfZqQfMPOCGuCNX+0=;
 b=HcIN8buqXPyvo7Lhc5+Ao1VjxdWA1j4tqVD1vcGDBXok2OU5hWb77nOf325QkZSGVE
 9ZkIh3AeaGJBKr4xWWGc7hO4j9oMHPkXQwfAPGLk4qifj0/M0wDLQJzPec+8z2H0jYIJ
 QIMR2BoKmEC6is55C92s9yE3iXhnD49w2PRDBi1fCBNWAIHBgmNIJW8ACaFV4Sc080h/
 OkKbsbk/k7uV0DgzSvkJE7fG6Ts1c4rlPPxid57XmJaCsG8G98f2EcG0QbPGBfGpXQoL
 WIhbildAi9z/+KcZU2JT14txeYoJXPixX93xBSXOYx/5/N8ZHrwLvXm8HbzODsvOn4QW
 72Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246881; x=1698851681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npJ2K69OOSsKJtanlFl7eXChj2RfZqQfMPOCGuCNX+0=;
 b=vQlanZljIhQrUp6aZEg1BoZYmmkBvDWe8R/2k550Lv3ISVkMRrRn9Zo/tZiIAm/SzY
 ML8F0E/JjTuUe/aXDB56qVB5TIJEhLDaNJ9h/ypz430pyHCAsy+taRCLSc09vllMX62m
 bUrbzz7+D3cixs3ki2Z4N1wMKVIcpfxU2qb8OaoaSmQIKOLxIGJYsLp/4ehlqjNkw0W+
 3cbxYOPLfwxYLcoZGESWR/4aD3BRPKOfHvTbxpjqTcMUW1ZwdLhpQYbKj7BH3i49TNFw
 dYaqw9JN6JtG+H6BeaksQvLIBfZN7ZIgKnCSaTVE/xP3ER39FncB2L3KaEEqCnfoRDVp
 gSTw==
X-Gm-Message-State: AOJu0YwUvx8QsAo2eC/kZ6AZ6w3hxKWdDd8hcfbK4T8fm9jD8uKkJX4t
 nl2MX2FGU59Ci8DYNJ7KF7KNBXKgu95SdrLwdNBMJEgeLWNCRXAYw1XEeRJF5qPDxIXX3Lg3HeE
 1ETL1pN5ehOr+dz9uBc+Dy1yXA+QlcuVVfOOYw3rgiZ9e1Uw4u9KuVWwTDmMBAQ38A/YJGRl5st
 hO
X-Google-Smtp-Source: AGHT+IGxeT1XYysuWhzP+XGjVchb7sQ76Y9lFVuO/ahOs9u4ssberv2hYxI/vPlJz08p3CKKT1+D9A==
X-Received: by 2002:a05:6a21:788d:b0:13a:6bca:7a84 with SMTP id
 bf13-20020a056a21788d00b0013a6bca7a84mr6707340pzc.44.1698246881497; 
 Wed, 25 Oct 2023 08:14:41 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:41 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 08/14] target/riscv: Add cfg properties for Zvks[c|g]
 extensions
Date: Wed, 25 Oct 2023 23:13:32 +0800
Message-Id: <20231025151341.725477-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vector crypto spec defines the ShangMi algorithm suite related
extensions (Zvks, Zvksc, Zvksg) combined by several vector crypto
extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu_cfg.h     |  3 +++
 target/riscv/tcg/tcg-cpu.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fd07aa96a27..7b0ca657a6a 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -99,6 +99,9 @@ struct RISCVCPUConfig {
     bool ext_zvkn;
     bool ext_zvknc;
     bool ext_zvkng;
+    bool ext_zvks;
+    bool ext_zvksc;
+    bool ext_zvksg;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e460701a13c..f9023ca75c7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -519,6 +519,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
     }
 
+    if (cpu->cfg.ext_zvksc) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
+    if (cpu->cfg.ext_zvksg) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
+    }
+
+    if (cpu->cfg.ext_zvks) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksed), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksh), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
+    }
+
     if (cpu->cfg.ext_zvkt) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
-- 
2.34.1


