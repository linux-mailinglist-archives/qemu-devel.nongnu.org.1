Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9270AE10
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iDT-00023C-7x; Sun, 21 May 2023 08:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDQ-0001yf-EB; Sun, 21 May 2023 08:31:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDO-0001lf-FC; Sun, 21 May 2023 08:31:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96f818c48fbso358628266b.0; 
 Sun, 21 May 2023 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684672265; x=1687264265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj9iMJlnfsZl0y994uDUqQP8GlhWz8JYM2DM6z9egg8=;
 b=Bsk+EFSWhN87gQmh/2YI+frpd+xI5KJ+1IvPCgVsUuxMolieHPkgC5gRZlVFox3E0y
 tZiQem1Q82TXamAGA9gSplTP8x3stNl84IgFq3F+7ooLncC2FF14MKOeObOIH61uJqu5
 fRIvtHDM9tV3bgYj26BzVVXbuexjLqZ/OM5wu2pC0yIBgkLTHUmvqfLOFc+e3kVVqSR7
 +xf+sPJ5N+MTGFWQ/qPgcS4fmXukP92tyEwTQH5xPpfgWTIjbeAtKOrIB7eNpDb/oYZo
 YfARHM+dF659bkIhJOyOawOzvUqlWsK09KWKbABldtUz1wN2oq5uiZ4N0rDUihvuzMsN
 d7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684672265; x=1687264265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vj9iMJlnfsZl0y994uDUqQP8GlhWz8JYM2DM6z9egg8=;
 b=HBYE+K/bviD1o2XsJE1l0UjYpagVRD+8U9TwCPNLYObnpO9f8yxpMyh2dL4+gfr9vI
 5POUNrTJuw7YCAHKMgsGTslUi/wl4NU0drwGCevOFdU4MThOm1PYLtQnh9wySGGf5HMH
 iHA5UrhKwhbS0ZnEgjK+uJWndjDFZITY9SgI1mVKVGx+xj9JnzKeLiCUgioBvlxz3QgL
 xXvhPRtt3KEP82SKtZDySE8M5kB8PRgw2kxa5nsY7xGmKQJGRKjQ0CPIdL+EXQSDnG58
 wDIC8g59b4GchNRpDjk+v6cM+8xMsUy2TZRDrv95LQmus7zZ1r7bNo5aSzXwmYlEMby/
 Ky6Q==
X-Gm-Message-State: AC+VfDw6wK+zp12+wxbG1ng1sgmtcL0qgMqz5Lb7nbn9fyXenjbosxYE
 fP5V2fjCifiERCbGjVhw1m6tfPx4n+E=
X-Google-Smtp-Source: ACHHUZ7BaqioxCuT/3WcbcwHkcrnEKJ0I++nnQipsDZ5PJ5ftHlNqHRlONwx3v/qTqZPehACvMfh1w==
X-Received: by 2002:a17:907:72cc:b0:96f:136e:eadd with SMTP id
 du12-20020a17090772cc00b0096f136eeaddmr8034634ejc.66.1684672264973; 
 Sun, 21 May 2023 05:31:04 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906729300b00965ec1faf27sm1882678ejl.74.2023.05.21.05.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 05:31:04 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 6/6] hw/char/parallel: Replace string literals by
 TYPE_ISA_PARALLEL macro
Date: Sun, 21 May 2023 14:30:49 +0200
Message-Id: <20230521123049.312349-7-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521123049.312349-1-shentey@gmail.com>
References: <20230521123049.312349-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rather than using a string literal which is prone to typos let's use a macro
instead which is caught by the compiler if mistyped.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/char/parallel-isa.c | 3 ++-
 hw/isa/isa-superio.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 1ccbb96e70..ab0f879998 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -13,6 +13,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "qapi/error.h"
 
@@ -21,7 +22,7 @@ static void parallel_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new("isa-parallel");
+    isadev = isa_new(TYPE_ISA_PARALLEL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index c81bfe58ef..3baa9777be 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -20,6 +20,7 @@
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/serial.h"
 #include "trace.h"
 
@@ -51,7 +52,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
-            isa = isa_new("isa-parallel");
+            isa = isa_new(TYPE_ISA_PARALLEL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
-- 
2.40.1


