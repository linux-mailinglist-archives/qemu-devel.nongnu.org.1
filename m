Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA07F7E9FE4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2YlF-00022Q-7d; Mon, 13 Nov 2023 10:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlD-00020t-LE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:59 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlA-0003Hb-MO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:59 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so698887966b.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888915; x=1700493715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaPh59FgiGsmC+pCYaCOTA7yQ1Mp2MwkOCCJHlQNKqo=;
 b=e4PfonWaQs7X3U06BSowYvq0dQPP6eTuxH6Thty4VKtNxBwEGln13DUMcmwq1Y6wUb
 KtC5ISXDHpD5MOFx+riWxVwD8rGPxS/i2p2z6lmq0ohyE+GGDw3iR/ijx8sKnnamJPn4
 gr0iK4wED28IANtou66q6UTid7eD16XCR4w5rX3PmWr2l2bAfPrGMtUN9OvvJWppj4ud
 imwcyasqF26JR3lBD25QYghWTnakc/GhidggW3GJ0S5Tq4iSQEz8ku8dFqQ9GVu3Zp2F
 OQpCDpjaP89g/oR2WgEq72sBD48ZyKoh+hXR6OaA27gRrMbleNEnXEMRTuVXd+5whDJn
 Ekmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888915; x=1700493715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaPh59FgiGsmC+pCYaCOTA7yQ1Mp2MwkOCCJHlQNKqo=;
 b=GSZHaLHonNQOUAgVvHp8aP6VknaCJ00DynAKMzPI+zX70kIFyPOgHquyEFqzrWONrt
 gDXjSdx7e6eObVYX1geX4dMzLWd6hSkUW3phJ6vZKCtzwCf1oNwIAAdEndXMX3WT/Rfi
 fX07ie2JtI6E2N4bpNurX+NV4jtIbUCPER4v3MHgLhaOy1RNNKR8DRDzUjxFl6DXqwUf
 rO7DrSNKJdlLS65bGCcd15651bkZZh0XxNqFAaJgb1lvviOQTc6VdsNSkXpOtYEwfbJv
 wMjBmuHzyj9Hg7leZoujBTuF6d9To24KQXgBbrm3yidt7s9ByPtSRTdwfFiWTkYRtYXJ
 izRw==
X-Gm-Message-State: AOJu0YzjwaGYGPPDEgIgGfCxV0cuJlmVQgYPQvaLwziw2OpW31xFUY9u
 QJnTOBpgM1bahWmnwUfnNQl5vQ==
X-Google-Smtp-Source: AGHT+IH3RjReylXfRQh/wsJfTu2jHnqkMqs+PQHcbPoh+QyiOeqF9Xb3+QdjFCNga0xDu80xIHTeww==
X-Received: by 2002:a17:906:fb8b:b0:9e6:59d5:8228 with SMTP id
 lr11-20020a170906fb8b00b009e659d58228mr4946396ejb.27.1699888915206; 
 Mon, 13 Nov 2023 07:21:55 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a1709062c1600b009de11cc12d2sm4197707ejh.55.2023.11.13.07.21.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 06/10] hw/xen: Reduce inclusion of 'cpu.h' to
 target-specific sources
Date: Mon, 13 Nov 2023 16:21:09 +0100
Message-ID: <20231113152114.47916-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

We rarely need to include "cpu.h" in headers. Including it
'taint' headers to be target-specific. Here only the i386/arm
implementations requires "cpu.h", so include it there and
remove from the "hw/xen/xen-hvm-common.h" *common* header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h | 1 -
 hw/arm/xen_arm.c                | 1 +
 hw/i386/xen/xen-hvm.c           | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 734bfa3183..ca941fd3eb 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -4,7 +4,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 
-#include "cpu.h"
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
 #include "hw/xen/xen_native.h"
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index c646fd70d0..2c97d6adc8 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "sysemu/tpm.h"
+#include "cpu.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index aff5c5b81d..369d738b50 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -22,6 +22,7 @@
 
 #include "hw/xen/xen-hvm-common.h"
 #include <xen/hvm/e820.h>
+#include "cpu.h"
 
 static MemoryRegion ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
-- 
2.41.0


