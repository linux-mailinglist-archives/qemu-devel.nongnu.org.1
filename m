Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5777A7A4F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivGS-0005hg-59; Wed, 20 Sep 2023 07:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGQ-0005gZ-3u
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:02 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGO-0002Dh-G8
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:01 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bdcbde9676so4377739a34.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208859; x=1695813659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iqSa97kifihOyS34EWLsGufneSccwIDqZP7TtE5e2Q=;
 b=EqR9JlfI9e632rfM6pcv9J7pcEcrq2ObyjKoRgiNunArdBqtJ3GyFxg4RWfyId0uJ0
 pEh3t+pDKtg3C6G24yef6FxviOyIo+kKPbuME/HCtZS/3Kp9XqdP1YKy2wxwGt5AAxdx
 ZIgzh3rs+/CGWZ6q8FWH+x5vrJxMCKRu7b9Ox8xsZ6oGnpGspHyPdLhuIWjeTmjS2Gsc
 eiS5mwAfHl3P/RXOg1Ow/HLPNPsqyZezB6Le9wOiYTRL8DYeoEg7pqHoftkOltf7r8AW
 PgBgsqX98h92vjt+EUyPWzVf7qBZYv4UtMPoKEdisFPWSmobg9tqp5+xFjP+QhHDwC3/
 qbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208859; x=1695813659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iqSa97kifihOyS34EWLsGufneSccwIDqZP7TtE5e2Q=;
 b=EbfoFVFISpiVdQcvySZdckOC6Y2HpN0vQB3Gv56s/7qnEYI4d8up3/Xg5lgudqDg1a
 MvCVu3NAJ9+F/JzW9RQ76kxuhiE6fo96agNDHcQpYKJHPBliz6yrgyyVsV/xLvBToEIU
 6y9ZRZh6Ji3Ojy0ySO52WZZKo74HLVuoHZKh0K2My4r9A5mS3vJOYGncpEAAx+f5hIA1
 t3W5OrFAZd5p5FkKzhpfbY69caKQh4+H34sdnuWdCfg12fsztgLs9EVP7c/q7LTasWuu
 r6Zv8wY9/mKeKGlH6VVfQ/dWuJJN0i0/IaQ9JdFLzPZnq//5UlMmZ0pobt9v7FE7wiwX
 8fcA==
X-Gm-Message-State: AOJu0YxZS/UsrSNq0Cvd9iy8lEB+51Ymkdy2pF/2XkMf9VJdPfh/lGC8
 szu8h4VHYLpAizMa28O1GP52HcIlgZZ+y71jxZU=
X-Google-Smtp-Source: AGHT+IEcb8XdQEI5zLF+FWFQgsPNcu5TX8hZZ0rDFMQ2Y8cqvqZ5fRTQm/XaVHp/s5YOGm0lDL3qAg==
X-Received: by 2002:a9d:6f06:0:b0:6b9:1af3:3307 with SMTP id
 n6-20020a9d6f06000000b006b91af33307mr2184051otq.17.1695208859263; 
 Wed, 20 Sep 2023 04:20:59 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 10/19] target/riscv: remove kvm-stub.c
Date: Wed, 20 Sep 2023 08:20:11 -0300
Message-ID: <20230920112020.651006-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
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

This file is not needed for some time now. Both kvm_riscv_reset_vcpu()
and kvm_riscv_set_irq() have public declarations in kvm_riscv.h and are
wrapped in 'if kvm_enabled()' blocks that the compiler will rip it out
in non-KVM builds.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm-stub.c  | 30 ------------------------------
 target/riscv/meson.build |  2 +-
 2 files changed, 1 insertion(+), 31 deletions(-)
 delete mode 100644 target/riscv/kvm-stub.c

diff --git a/target/riscv/kvm-stub.c b/target/riscv/kvm-stub.c
deleted file mode 100644
index 4e8fc31a21..0000000000
--- a/target/riscv/kvm-stub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU KVM RISC-V specific function stubs
- *
- * Copyright (c) 2020 Huawei Technologies Co., Ltd
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "kvm_riscv.h"
-
-void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
-{
-    abort();
-}
-
-void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-{
-    abort();
-}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index f0486183fa..3323b78b84 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -24,7 +24,7 @@ riscv_ss.add(files(
   'zce_helper.c',
   'vcrypto_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-- 
2.41.0


