Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3D7B6212
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZSd-0001Ax-Gx; Tue, 03 Oct 2023 03:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSb-00018h-64
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSZ-0008RE-GM
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405497850dbso5796555e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316686; x=1696921486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgpXhinNPnFvZKdeMS+qc/3fubRg8oTbm/EUaTedB+8=;
 b=FTJaJ5m13lVjAGNs0BbqdWZxblDAF6SxcdhZa4W5Hf//I6P9GZUHT2zYRvBb5hXyK4
 lC5o7Sjs8r4jeWeKz0LmvMorLgFAicI6gMOnRbOWICeGpTeR+8La28BlB2EbdLwe2B65
 fRUbp7+t0ZQ3/3T5gofUpim7Lm6L0EJVJNPJdi/PFDBD/N1yoF2Te5fHE3lavigtL6kV
 4IcLggKSbNnJsAPsdGcGE8o46dRjZmCoPjClLzsk3Qhy1loKpzdX05pscPd1U+qAtf6S
 uqAQWaB3oSfW0+6XxMf2ARvhLJFLcv4ezx2TrirLmMQ4DuBzrI8QSMT1itXNpGbMpLl5
 QWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316686; x=1696921486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgpXhinNPnFvZKdeMS+qc/3fubRg8oTbm/EUaTedB+8=;
 b=g7ClaecQ/kzoTAaZmwfbDNML2fu9rnKUE1qrHVarUMKWi/J+/F7wuulI2YrATAgVhs
 fEnA84stq4f6bl7OGW1bg83Dz8cQOdboRK6BXlo+vG4TANIcTjC2aiqlOE82yq7nFlIT
 uzKXQhiQiKoxgeydfI2ChYPpCZLuEl0vihtSaiHnzF7lmsIVYOcUHmV0ihkdz+IvvUMa
 mwd9BjXQ7w/qSK0G1Khvk5zGlgt00ItxMkZBzFzQ8wEPVyeZhEueFaAwUPAHqmwCmGLH
 SBGeEWh8ZSJXvyAKI9GUO138tjGPaIQSestC6hIr5NK9b21oyfxVcFYCcOuDctFHkivo
 EqOw==
X-Gm-Message-State: AOJu0YxNGVEgxANDSCC6KxZnyLSKYzofzOWIYEdDyu5xq5QGN8WP9Spm
 /CfURj0A/98UFK8fWkXuRUTtEJ316nE+7dVqT63I4g==
X-Google-Smtp-Source: AGHT+IFbWPwhAeJVn1i9Pd2IS7QiJyQb6QTE0n/sRe1vRSJsLtP8IpfLi2Zi7CWQx7wnFWTnTIvUsw==
X-Received: by 2002:a7b:ce89:0:b0:402:f07c:4b48 with SMTP id
 q9-20020a7bce89000000b00402f07c4b48mr10778116wmj.28.1696316685763; 
 Tue, 03 Oct 2023 00:04:45 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a1c4b12000000b0040642a1df1csm548808wma.25.2023.10.03.00.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 00:04:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] hw/ppc/e500: Restrict ppce500_init_mpic_kvm() to KVM
Date: Tue,  3 Oct 2023 09:04:24 +0200
Message-ID: <20231003070427.69621-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003070427.69621-1-philmd@linaro.org>
References: <20231003070427.69621-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
allows to remove kvm-stub.c.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
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
index 4c2635039e..0bff3e39e5 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -30,7 +30,7 @@ gen = [
 ]
 ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
-ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
 
 ppc_system_ss = ss.source_set()
-- 
2.41.0


