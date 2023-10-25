Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C57D7086
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfaJ-00051b-00; Wed, 25 Oct 2023 11:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaC-000510-TK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaB-0003Xw-Af
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso5628149b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246846; x=1698851646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61ZMS3NPRFqHZKTu/SPe5ruHdrWMd68xp2LyStvCuls=;
 b=Y2xMztVz1GhUUYr7hYt+79DIKvkPIKvY2ryCkAyObgrU/ivnB48nq43dTYnUMS5iLF
 Ir1rEnJjmIZz4i2SRn5Mydv5Kk9LpTZCMcnNuaxGtQojHiCwitSjTiZ4zPuyCCj3ZGA8
 9tNEOW6Xz1hX9b0u9kdAvpADaqwBmdD2qEiuekJ8vD064Dyv1h6h7MefcCakItNv9/s3
 L29eQLZoH5E09W7UAoxNCk1namEaqShuAZwOkxLuC4ol/8egAl7R7/FTcjnK1wYQPzwA
 U9PFFL1VLA0hkL4EbuIJNsArV2QG/21kEI3zLWY/LTAtDeZP4GIDYqQuaHwliEhGhf02
 TwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246846; x=1698851646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61ZMS3NPRFqHZKTu/SPe5ruHdrWMd68xp2LyStvCuls=;
 b=tlyiUKb4qgg6Qh+zKoknYdO+4wwfoo7GcR+Ug3MoOAzbAs8eO0JKW1/dOseDaP6YLv
 xhe+T5KkSuIEB181wMWBermysgb+1TOR3T1fruvQ3pGULwwcw/uXYRi52Xkw8viAMs6S
 UF4EN9zQ/iMb38ARc1UnF4CezWU6ngu44Pr4NoKiaayPdVycjcYO9y3wVjeNhq23HcUS
 SkuFOXTFLqMmlUs0xXB8BHGzbYlBxerq3tDrCsdZNwQH7fyKVdD0Qv4mdzUW48U2cG+y
 37fX/KjmqJn3EIIppCVb8JMGPZpsPJb6CGxniHG7c0FnZ9nkpQRxBsXzkLzfq9yrF0LS
 +WiA==
X-Gm-Message-State: AOJu0YyCUEbwMV9RprocV5ZbOt5uBZzFANfrMR+Blj02rBO/+ONW1xyL
 OfJWzOIt4BB2lVB97gsDuMHEhm93AbChAs68pTjSFUmKoGp4y5Uq8l/lHHMl0cZy11EUfZZbOrp
 KvDcW7jilAmYT2HvAS63HO8eX610zOyVkar0af4x0hslAD9rqCEXDRyTQruWE2GEtbwnWCj8MYd
 l8
X-Google-Smtp-Source: AGHT+IEiZaBibfJjXgeYOIzow0HGKRHEHmn10Wvam0gdTpMZaOpjYwWX7CmQSUqlWiU8m+rbFvs/1g==
X-Received: by 2002:a05:6a00:c82:b0:690:41a1:9b6a with SMTP id
 a2-20020a056a000c8200b0069041a19b6amr18819599pfv.5.1698246845703; 
 Wed, 25 Oct 2023 08:14:05 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:05 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 01/14] target/riscv: Add cfg property for Zvkt extension
Date: Wed, 25 Oct 2023 23:13:25 +0800
Message-Id: <20231025151341.725477-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Vector crypto spec defines the Zvkt extension that included all of the
instructions of Zvbb & Zvbc extensions and some vector instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e7ce977189c..d8d17dedeed 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -94,6 +94,7 @@ struct RISCVCPUConfig {
     bool ext_zvknhb;
     bool ext_zvksed;
     bool ext_zvksh;
+    bool ext_zvkt;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c5ff03efce9..b9eaecb699c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -499,6 +499,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvkt) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
     /*
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
-- 
2.34.1


