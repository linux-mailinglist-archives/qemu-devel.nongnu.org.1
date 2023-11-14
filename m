Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9167EB29D
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZD-00035R-40; Tue, 14 Nov 2023 09:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZA-00030k-1x
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:00 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZ6-0007nq-8q
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:59 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso855452666b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972734; x=1700577534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuAolXSNCEGrTS5m5CRvskBDG9NQVZE3kWB97Se1m9g=;
 b=mNLXw3AGowHLOpHa8Tr9DXaLIR/+dOtSPgSjyltu3csK7kyHmu97zjlRbcbOtC2oxO
 gnLI64OapS+qbPN4R78Gg+AgMgdGEPTjdpdrQhaYfgy7onTvvRxrtEhOnkFhFhKRW8nI
 jaOIeJd83fyqap7MlefFYbkSoSMSIZkACqkK+ejqn+nnQdMmQ2ngvLEtxrgyhnE1CQue
 ovbtc/UR3c49PcFuKk4OP/a23kd1WbbGXjxzzD+dnLmKA3vqVaZn2Wn4Jd4SW+KDeICr
 lNF35tv27P1AAwSLnJ8Yu96gwTlP0by7/7iyQoizOiNLyoFPKjJajTUplNj4AZb5Qx02
 oDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972734; x=1700577534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuAolXSNCEGrTS5m5CRvskBDG9NQVZE3kWB97Se1m9g=;
 b=sXcLaXwjKa7YldSJ0TE9GNLRSSd9OUxpqc1zyW+7s2FD/rJ040wFYIjAvRrr5NNt5C
 7Y9kfqx7te2xXr/Wb//xS4FQ8YdPApwJ+mOJDxcjHupGsr1TaW8E7WlipADHygPELrKH
 CFI/XpsOxsyhspjpcr2jPyDi+ga1dmd5/E5whFNkSmPGfvwmrnPzrOgiRxLWEYaf9Xf1
 xti5Pbqr1hLcB7nWAJHin9p6zFYLLiroPA/lizf5IVfWZgeaqGrtYVYzJUk4mGBA0edS
 OqIZy4XtJrzcO7L++1bqOFvUaaJtGhGms7Hw5AlWkN4w5KUdFX8d3MGz/r5sQn97+WnK
 AfLw==
X-Gm-Message-State: AOJu0Yw/UtQSrhqgQdYgwGD/uTAYSFk/AC2mGIO0+KZrlq45diQFVTzQ
 DzxFaP9KzyqtTqsdVNFs5e0aSQ==
X-Google-Smtp-Source: AGHT+IEd2vTLeg2GpIsCyOKyOB5sACh8KieliOs//U/3JH0fTJ/5IoDfAGItJdrYHg+Wv8sdCg7VbA==
X-Received: by 2002:a17:906:b78c:b0:9bf:f20:8772 with SMTP id
 dt12-20020a170906b78c00b009bf0f208772mr7590866ejb.26.1699972733904; 
 Tue, 14 Nov 2023 06:38:53 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 un1-20020a170907cb8100b009a9fbeb15f5sm5549367ejc.46.2023.11.14.06.38.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH-for-9.0 v2 05/19] hw/display: Restrict
 xen_register_framebuffer() call to Xen
Date: Tue, 14 Nov 2023 15:38:01 +0100
Message-ID: <20231114143816.71079-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Only call xen_register_framebuffer() when Xen is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442..f9cf3d6f77 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "sysemu/reset.h"
+#include "sysemu/xen.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "hw/display/vga.h"
@@ -2223,7 +2224,9 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
         return false;
     }
     vmstate_register_ram(&s->vram, s->global_vmstate ? NULL : DEVICE(obj));
-    xen_register_framebuffer(&s->vram);
+    if (xen_enabled()) {
+        xen_register_framebuffer(&s->vram);
+    }
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     s->get_bpp = vga_get_bpp;
     s->get_offsets = vga_get_offsets;
-- 
2.41.0


