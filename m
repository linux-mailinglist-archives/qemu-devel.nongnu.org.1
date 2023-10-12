Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F67C63D4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4N-0004LK-Pz; Thu, 12 Oct 2023 00:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4H-000433-7U
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4E-0002bD-M5
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso431607b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083977; x=1697688777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXntgmebh7Py+U2IQFPgAEj5TBfbWSDqGlhqwgUvzqo=;
 b=mSWwm02KxIYI3IZvD70bvgAFpd3ryPk2zwlZr/KFt0z9fDcv+7YCres7gp+cMUSLRx
 p/VUqzv//+SQLpLkTaRk5D3LSfKt1LqSZqqnTWqDP7n8QtElxSO70uV/eGl/GLB0BSQZ
 3VPgEMHfk8ZruCn6HGMSoM0ExcJjDmER0ViXT1yExkwrH62AAeI5elOQdatwbgSWT2Ft
 qTR/ewizG2kNIPns/89G5NOU5IEWjTypH2l9sWLygwLzLnwQCIzPLUcrZGU5eEu1xkTp
 F8cnWG4cnVAPO5yLllke8PcIM40AFj2kOosKFLSVw2pRjkI/HBuA9mkDqssKZ4WESqUG
 Rjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083977; x=1697688777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXntgmebh7Py+U2IQFPgAEj5TBfbWSDqGlhqwgUvzqo=;
 b=Ax/K5X4rkD+ll0uTTiT8JMNv73K3QXyOciEO77CbfG61ENWUEM9dhIadAP+kXyU1do
 HQkoS64D31+WHuGWYOqRGhoLPzmauVce/nAL13tVynidRaAUzT2gyhGbDUYF2h/uXeF7
 VcCE59hIYNMhEncPU1L1sAW/TrZwgQUMu6zKjuElP5qKJJzEWtys6ZI7KxUfaKNNz/WC
 XtU9VyJgfNTBntsNxsz4GN2wYdg37oXGCvhr8WIm709b3O6LZi3R00CPvg0iXqIeKiBb
 vr9k0cRdUd3OHh3+6X2Lp5vhl7vAnPQpoQU9SsY7Xpwb0NAA8WDfTUfLsh3XCd/OJbvx
 0rwg==
X-Gm-Message-State: AOJu0YwO4/BiAvaUilt8g3lASEe+rAEtSVUMX56JbRGlraSXX1BMIngk
 vCAK3GdPIcKIgBMVflBWfHZZzscvdXRgaQ==
X-Google-Smtp-Source: AGHT+IHsX48RN0lsGaNai9HHQzW/P6+1ydRV73VHGwQ6IoYGjA3CAO0HWPLU+V4OacRxLCqolhobUg==
X-Received: by 2002:a05:6a20:f3af:b0:134:30a8:9df5 with SMTP id
 qr47-20020a056a20f3af00b0013430a89df5mr22416973pzb.43.1697083976930; 
 Wed, 11 Oct 2023 21:12:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/54] target/riscv: remove kvm-stub.c
Date: Thu, 12 Oct 2023 14:10:29 +1000
Message-ID: <20231012041051.2572507-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This file is not needed for some time now. Both kvm_riscv_reset_vcpu()
and kvm_riscv_set_irq() have public declarations in kvm_riscv.h and are
wrapped in 'if kvm_enabled()' blocks that the compiler will rip it out
in non-KVM builds.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index b4ded65e41..b30ebf5795 100644
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


