Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9797ADE47
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpqC-0000gG-KL; Mon, 25 Sep 2023 13:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqA-0000fi-CZ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:50 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpq8-0002Dc-9b
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-578b4997decso5429170a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664666; x=1696269466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tWUy+Y3YjrpIBChvCNNHtWPQ0l+kZDqCFnD8gAcXHs=;
 b=ETTugtjFSbJBLMCxcMpV0Ikmas+q9fBXB+svUJ6K57uVn0+zS7dwWAOpbE2dHKCCYw
 AnsCT2hrGLwqgQDXj61aqarFQJlJzaFxiN6IBpwuuwDghYgdKbqP39+HvJSe4P+8hB+n
 6JN5QXEQH0bXQG1g17bWnzCggLCyOoPWYQrE9vwUjXmR3E+qKnFBnOb97nozkg+8VNeI
 3y1LXWUw/j5hoZzpjkTjIZvUQcQH53gqvJxUaKKtzhG5OiSEz5HyJSZ84vQLGObP4eYx
 sMmlzgfi9uINrTr7y9eFF1x9NM6RN4gF4AgQeyTSHGOmWWxNPQnckFjou9wierEioD/p
 joJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664666; x=1696269466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tWUy+Y3YjrpIBChvCNNHtWPQ0l+kZDqCFnD8gAcXHs=;
 b=vmZDeWPvvWA0ACxeMJozDony5Mc8DKcTyH5poZhfPoCDBAPX9NvzufLDMab+0BcVQd
 u8YLZc41NJHP/a60Jn2aX8wPBcH8ccnNvIDhmjuvF/CHjgwK62ZGVaMGnt1beSQX/x3y
 jJYFKnt4duZO0saS62daymkKy61EASNWr+jkgJWHAsRGXHBDTQywFQC3CN/RUvXQnR/U
 QAmsRYW2ap/PyNniQAuvJ9Bh3eZz2qj462I3l5sJkEjFT+B3LMjEZULAJzFZ+gGPPy71
 ouW5+Jrsu5SKp4tAYBIZ9+CqUiwd90d3+Xbmj+M89fCBXE24Bku3KeENVtmwoBUzyES5
 xCVQ==
X-Gm-Message-State: AOJu0Yx1vAAH3jmJCLYvvYeF3D2Mn9MkRQGY3aCsrWUEePbty/L7Ckq9
 TWirlBxc0bg88iI5YUJBTirJZhqpxqLl9vbmCWI=
X-Google-Smtp-Source: AGHT+IFouv1EeVQ6IF/T8kTz+c1M7MbDEfQYsj53W7J/d5FrM2oOyOwL/lVuqNOB0jkEmkMA/bSHLQ==
X-Received: by 2002:a17:90b:4ace:b0:262:f06d:c0fc with SMTP id
 mh14-20020a17090b4ace00b00262f06dc0fcmr6227116pjb.7.1695664666159; 
 Mon, 25 Sep 2023 10:57:46 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 10/19] target/riscv: remove kvm-stub.c
Date: Mon, 25 Sep 2023 14:57:00 -0300
Message-ID: <20230925175709.35696-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


