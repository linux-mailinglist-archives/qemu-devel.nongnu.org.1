Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CA79CFF7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1bg-0004N2-4h; Tue, 12 Sep 2023 07:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bc-0004M2-5J
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:57 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bY-0000tS-2k
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:55 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-501cba1ec0aso9065609e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518250; x=1695123050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aSlGFqA9ubhB7ZC5gHBqxQU1rcWLkqloVAzPG4iLCg=;
 b=f/UwKA3kemM72cVDiT+KeUcY2sJtPXAtf4cxQvs+bb+0OesP4L9bz5LLF3uBYJRHbR
 ZsN46VjhkeOLep94WXvL9I2L7Fw895r/ZW7PyQFd3waeJuSqU8G6XzZcqEKDLyb/Z/vH
 CkWp2UH9JYWVMOXaqi+QRuBYI8jOkmMdHOVpimvR+u6k3xOVATVUrg1mlE/OrNgdeX0z
 MMxK+N7O6tffYhi4WBtHERZUdjLn/qrYifJIgxzhJ0uJJ/PIalBC0is556aY6PO5An9G
 cuUsSO3WFCbTpuVEWMm+W2+PCFZMhFGJu5l1XhUoTcyKmQ9twVNBsEJkhUi2hutNujNm
 UTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518250; x=1695123050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aSlGFqA9ubhB7ZC5gHBqxQU1rcWLkqloVAzPG4iLCg=;
 b=EhIbU7AcMrlVWPQe/D9/592UFHj9oBmVYlqldYoogNWHW2X04H3tT/lEsvfrlSRxHC
 D/zSnCeM+FLfkBi/VmILSxIpRFzn+eXJwewDY7DbWUgb65reDGeBFmcV8BddJ3sw9evJ
 xDj4L+Mj5Rv/GZmAlx4NhqXVI+IaBgKUA0Q0AU9t3tzJ8WItY36xlwe1IjTEFFExBF0c
 QGumTSwCTkeyX75tAoM+Q1+sYqfB1wUcuPLumKt3idAZwY6dc+ntEYz1Vi7AQ5ZGyM3G
 RnSAuiHDGmDn98bAN0aYjFqxs04DzejIlfCDwDyRKW4OM6HjpZdaYaCOMsBMRJe2F92A
 ZdQg==
X-Gm-Message-State: AOJu0YyO6teqNO6r9KfYZVukDTSEK3cpNbPzlGCsC0BrNPAqTXMGMhRe
 3ZWBVSw3WGWw8YkTvcrsKI/h+Cjd/3vSnB+7vq0=
X-Google-Smtp-Source: AGHT+IH1nDDr93QicJYxAxgnTc7nY/JwU0DHitp5fHJtl0TRbIOcDKW6MuHF8lvcCHq4T8Tl9fsYHA==
X-Received: by 2002:a05:6512:32d0:b0:4fb:7675:1ff9 with SMTP id
 f16-20020a05651232d000b004fb76751ff9mr11429892lfg.9.1694518250011; 
 Tue, 12 Sep 2023 04:30:50 -0700 (PDT)
Received: from m1x-phil.lan (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 m16-20020aa7c490000000b005236410a16bsm5839285edq.35.2023.09.12.04.30.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Sep 2023 04:30:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/ppc/e500: Restrict ppce500_init_mpic_kvm() to KVM
Date: Tue, 12 Sep 2023 13:30:25 +0200
Message-ID: <20230912113027.63941-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912113027.63941-1-philmd@linaro.org>
References: <20230912113027.63941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Inline and guard the single call to kvm_openpic_connect_vcpu()
allows to remove kvm-stub.c. While it seems some code churn,
it allows forbidding user emulation to include "kvm_ppc.h" in
the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c          |  4 ++++
 target/ppc/kvm-stub.c  | 19 -------------------
 target/ppc/meson.build |  2 +-
 3 files changed, 5 insertions(+), 20 deletions(-)
 delete mode 100644 target/ppc/kvm-stub.c

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d5b6820d1d..d0e199fb2c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -834,6 +834,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
                                           IrqLines *irqs, Error **errp)
 {
+#ifdef CONFIG_KVM
     DeviceState *dev;
     CPUState *cs;
 
@@ -854,6 +855,9 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
     }
 
     return dev;
+#else
+    g_assert_not_reached();
+#endif
 }
 
 static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
diff --git a/target/ppc/kvm-stub.c b/target/ppc/kvm-stub.c
deleted file mode 100644
index b98e1d404f..0000000000
--- a/target/ppc/kvm-stub.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * QEMU KVM PPC specific function stubs
- *
- * Copyright Freescale Inc. 2013
- *
- * Author: Alexander Graf <agraf@suse.de>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "hw/ppc/openpic_kvm.h"
-
-int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs)
-{
-    return -EINVAL;
-}
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index bf1c9319fa..44462f95cd 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -45,7 +45,7 @@ ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
 ), if_false: files(
   'tcg-stub.c',
 ))
-ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
   'compat.c',
-- 
2.41.0


