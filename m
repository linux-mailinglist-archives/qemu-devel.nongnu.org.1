Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B163A7EB28B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZF-0003DX-P5; Tue, 14 Nov 2023 09:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZD-0003A6-GP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:03 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZB-0007pD-Q5
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:03 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so8748935a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972740; x=1700577540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2i2PCnBLcbag3MdE1ImS65uDPosS8yIjq0X323T5yY=;
 b=p2MLQoMpeE6hKJkd9H/q22lEr3r2r6rGb46b+8xSF7n6UYGAW7SsbSHFvFTJvQkQ9T
 69iBCBEA9qfpYthNVcxWC9nEAIDXYbnSLsdVnYYHgz1MlQ5LX7AwyDfJXy/Pnhyr8fmu
 /kGJqimW90n8Wu7S4YOxPtzIyLH1TAvo8hI5Fx43PObOOzV1vIqqcVx4zOB8K0EmatzA
 0G7lkPzwuYNsc2KGdqmZqmtNWOphQ18dU4gaRF+shYB9ij6FLEMocQoxl77kDq04Gdjs
 M4ftz9EJGh5Z7PzHCusxT3FbQDiMmPPzzUors+NTUUq62P/asF4pzUc0IXGbUTHYwtSL
 kiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972740; x=1700577540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2i2PCnBLcbag3MdE1ImS65uDPosS8yIjq0X323T5yY=;
 b=ski0FYaaAng5NLDKNa7M5MlisynkHg5G7Y/Y0dZHPobrmtLP2sLUSzNVVsGgVIDaVY
 +r0vVkA3ygTmpDQDLAknksgxtppQU0xFj05cLnpE7F6kYk4QwiynG5+/ZW7B8/yJse3+
 wQQUhD36yjQTPIjeDdxohc1t8l9pou9ZKSWDb7A/gwRBbjAYhi6yvBpLyTaJsuNGgQ6P
 1F/JVtyQjTyBaOXuaLThDobhDvUv0AcCga4klVgJf2VfHLU/9nkZhcuFpxrPnC9voxZj
 R+uvWS6s34qJuFn5rVhCEfT/vaBK+Wimpac203/+bUakU/p04z4aSD7L4cZMH6PMxmaQ
 N2Fg==
X-Gm-Message-State: AOJu0YwC17fYhPjBcVz+kRBLl3DjH4I/aU3AxmR9Q0g3rQ1Gji2eN5lC
 eprAHRMIbFDLwP2LE5lQhp/O0g==
X-Google-Smtp-Source: AGHT+IHSJfSbRj04/mwMI7ongNHq1l4+SKd+JSAzh7MEswy3END/JCbC/d/lhlupvrq+nM36Jvq7cA==
X-Received: by 2002:a50:fb14:0:b0:53d:eca8:8775 with SMTP id
 d20-20020a50fb14000000b0053deca88775mr7423669edq.26.1699972740609; 
 Tue, 14 Nov 2023 06:39:00 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 b21-20020aa7d495000000b0054353639161sm5133902edr.89.2023.11.14.06.38.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:00 -0800 (PST)
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 v2 06/19] hw/pci/msi: Restrict xen_is_pirq_msi() call
 to Xen
Date: Tue, 14 Nov 2023 15:38:02 +0100
Message-ID: <20231114143816.71079-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Similarly to the restriction in hw/pci/msix.c (see commit
e1e4bf2252 "msix: fix msix_vector_masked"), restrict the
xen_is_pirq_msi() call in msi_is_masked() to Xen.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 041b0bdbec..8104ac1d91 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -23,6 +23,7 @@
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "sysemu/xen.h"
 
 #include "hw/i386/kvm/xen_evtchn.h"
 
@@ -308,7 +309,7 @@ bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
     }
 
     data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
-    if (xen_is_pirq_msi(data)) {
+    if (xen_enabled() && xen_is_pirq_msi(data)) {
         return false;
     }
 
-- 
2.41.0


