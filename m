Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3187EB2B4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:44:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ubC-0007FN-4k; Tue, 14 Nov 2023 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaG-00055Y-SD
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:08 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaC-00082U-DZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:06 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so8864656a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972802; x=1700577602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfmEPJkfg9xcA7W0yB07+uhlzLrR51RZZmvLOIuALj0=;
 b=SA6nQRmTgy8MkaNM4fBrI/2NU8BE+cq/9Z/3HDm+r4Ucx5AJ1zrTo4F7p5mFkKScUS
 wbTeMv8C75IQRUwO+XTTZCd0XByVG5P06FYQqt0s7wMfGGO9sw2nrJXb0HVNFJoGcmcC
 dhxCxGfcsTDPVjbVMlCEJAJVR3n0rFbfiDzp2qWBaVYlNuRzB41xHFS1PEOBP++LIct7
 1S2tTQMuKpooeazZhohafzPTct3E0stcS3BTgg5cf69OOShfGHJ+F6+c3ldBppa3wy8c
 q92n6Z3ljxtvoln2WGFRLI8XEqXdDPL0m/9j1nuYoRpprK8Ml4M7j3X3kWI8R44SpH/s
 IEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972802; x=1700577602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfmEPJkfg9xcA7W0yB07+uhlzLrR51RZZmvLOIuALj0=;
 b=cdJNtwaaaQIM1sBrhUQ5a2EL1dKJ84n0d4e0jHWj124m8lrc3P7dWdbbiF5aTxw1+f
 E2z7qHHvwSwik5UmW0vCelfKmRrJ3/+r57aGNdneB9Q3n+2gNqO2kc+TLN6pWmHvv+go
 WD1nA847pebid3XZ+IxIfyBULlccpN6QrveqCqoXhPbh9nY/n7cUQHWrI0QCZC9Vlp4I
 OQAhQweuj28I7WCcS1KXjn6KhldcHtYkuuU4rChpjKrbGCj2o/z6cNf95vfrxuYMX67H
 vBIh9gvYD/Y/ewjm2vSXBFKRVeXG4p6tM96AYXOljfwggYnaD+id/QOZW/i8PMrcBlqk
 qEcA==
X-Gm-Message-State: AOJu0Yy5jvBIAEdF4Pxn4t1edWxZm2/98xowAdadikNl4HcSXMBdNi2q
 WZTmDzESBrJozjmgksbi97c2Rw==
X-Google-Smtp-Source: AGHT+IFr1fCG0rC/823Fjj2RnGPLFEJJu5Vypm0crh2s8xGJ38WYt9mRvWNiRlcZ2yw4Up2Qw1V1LQ==
X-Received: by 2002:aa7:d704:0:b0:53d:e0cf:cb95 with SMTP id
 t4-20020aa7d704000000b0053de0cfcb95mr7775616edq.21.1699972802002; 
 Tue, 14 Nov 2023 06:40:02 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 r30-20020a50aade000000b005434e3d8e7bsm5309632edc.1.2023.11.14.06.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:40:01 -0800 (PST)
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
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 v2 15/19] hw/xen: Reduce inclusion of 'cpu.h' to
 target-specific sources
Date: Tue, 14 Nov 2023 15:38:11 +0100
Message-ID: <20231114143816.71079-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/hw/xen/xen-hvm-common.h | 1 -
 hw/arm/xen_arm.c                | 1 +
 hw/i386/xen/xen-hvm.c           | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 8934033eaa..83ed16f425 100644
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
index 6b0e396502..b478d74ea0 100644
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
index 0fbe720c8f..f1c30d1384 100644
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


