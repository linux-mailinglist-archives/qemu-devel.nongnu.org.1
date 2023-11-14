Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BD7EB2A2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:42:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uaj-0005Xw-5G; Tue, 14 Nov 2023 09:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZx-0004gR-21
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:51 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZs-0007x8-Vg
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:47 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso8722528a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972782; x=1700577582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzmBSObK1PNYaVxHm2kQdQrWhNegSVRCuy1/LpCCkxs=;
 b=Jz/pllyKRJPiVH7RjS82U4GzKIcwbx3dlVHm6eYOzTT5lGpHiH5o7IFtTrksrVF3OF
 8zVexe3gvMioxv1MQ72x2BRuoWoGTNOVTALyCmu6ziIL5DLSqvIbsGbvSizcqrOGY4Ot
 WxlfIcjMiMxeBf6z4eUWSodzMO/moP7ztw8aWOxSa2G7eJ8V6oC/QIBUEAChcZN5G8Bb
 k7TzKu/hm6/QTT3qKjVFGUK/hvpIHqIxAk0Umn1gzc6YjdNtkUhBdSx1vPpckiV+ATDM
 UwEsgaLxt+8ETrt0/4j9y1bz0pRmYYKAjr7C3AbGQr2GporrXTT6kWUD4Q0drrMeqo4Y
 61Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972782; x=1700577582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzmBSObK1PNYaVxHm2kQdQrWhNegSVRCuy1/LpCCkxs=;
 b=JmlusyMbCmxS46Jn5kHgMluvFWoNgez9xYhG/5/FjJPQlexPzCtM4REzWzHn0L0A4C
 wxYWjShxD/fHD7hlbA/7A2O6MgKnvTwrGxZyrfu7iJPsFjcbh6JIz63wIAgBwB4PEMGg
 s0YtcFGhDgEIHzZCO99eFToMInup+jI+hBv2ld6TFbwEMgOiLJwQ6X+6GLSO/jpUTcLQ
 jGAo7LdPKQCiPjRqKoqZ60/R5jcC5aFFkLJXJ1xdnHlvNJOCpqYmq7T/GgTPVMDNnjT0
 /jBIVD7sQu8sqOYaz4vF5mNdDp3p5cZkrGpu2NdDm9jKQ44MAOID6FSI6fCm6c9CS/Tw
 Xu0Q==
X-Gm-Message-State: AOJu0YysXY1t7yYjYCrTRNf020GUF70rOTPOGHUuR3tOmV6VXhAYEY/U
 wanYNbNsRf88DH4wBzcSRQ2GHQ==
X-Google-Smtp-Source: AGHT+IExeFq34FYS8TGI99eGSAGJR2PT8yf3hsSWiq8DkOxV7jzDuNfy8kK0Izfgi0PzWhH+ZoIHKg==
X-Received: by 2002:aa7:d050:0:b0:540:3286:d2e8 with SMTP id
 n16-20020aa7d050000000b005403286d2e8mr7060069edo.18.1699972781909; 
 Tue, 14 Nov 2023 06:39:41 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 k25-20020aa7c059000000b0053dd8898f75sm5155063edo.81.2023.11.14.06.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:41 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 12/19] hw/xen: Merge 'hw/xen/arch_hvm.h' in
 'hw/xen/xen-hvm-common.h'
Date: Tue, 14 Nov 2023 15:38:08 +0100
Message-ID: <20231114143816.71079-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

We don't need a target-specific header for common target-specific
prototypes. Declare xen_arch_handle_ioreq() and xen_arch_set_memory()
in "hw/xen/xen-hvm-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/arm/xen_arch_hvm.h   |  9 ---------
 include/hw/i386/xen_arch_hvm.h  | 11 -----------
 include/hw/xen/arch_hvm.h       |  5 -----
 include/hw/xen/xen-hvm-common.h |  6 ++++++
 hw/arm/xen_arm.c                |  1 -
 hw/i386/xen/xen-hvm.c           |  1 -
 hw/xen/xen-hvm-common.c         |  1 -
 7 files changed, 6 insertions(+), 28 deletions(-)
 delete mode 100644 include/hw/arm/xen_arch_hvm.h
 delete mode 100644 include/hw/i386/xen_arch_hvm.h
 delete mode 100644 include/hw/xen/arch_hvm.h

diff --git a/include/hw/arm/xen_arch_hvm.h b/include/hw/arm/xen_arch_hvm.h
deleted file mode 100644
index 6a974f2020..0000000000
--- a/include/hw/arm/xen_arch_hvm.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_XEN_ARCH_ARM_HVM_H
-#define HW_XEN_ARCH_ARM_HVM_H
-
-#include <xen/hvm/ioreq.h>
-void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void xen_arch_set_memory(XenIOState *state,
-                         MemoryRegionSection *section,
-                         bool add);
-#endif
diff --git a/include/hw/i386/xen_arch_hvm.h b/include/hw/i386/xen_arch_hvm.h
deleted file mode 100644
index 2822304955..0000000000
--- a/include/hw/i386/xen_arch_hvm.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef HW_XEN_ARCH_I386_HVM_H
-#define HW_XEN_ARCH_I386_HVM_H
-
-#include <xen/hvm/ioreq.h>
-#include "hw/xen/xen-hvm-common.h"
-
-void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void xen_arch_set_memory(XenIOState *state,
-                         MemoryRegionSection *section,
-                         bool add);
-#endif
diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
deleted file mode 100644
index c7c515220d..0000000000
--- a/include/hw/xen/arch_hvm.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#if defined(TARGET_I386) || defined(TARGET_X86_64)
-#include "hw/i386/xen_arch_hvm.h"
-#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
-#include "hw/arm/xen_arch_hvm.h"
-#endif
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index d3fa5ed29b..8934033eaa 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -96,4 +96,10 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
                         const MemoryListener *xen_memory_listener);
 
 void cpu_ioreq_pio(ioreq_t *req);
+
+void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
+void xen_arch_set_memory(XenIOState *state,
+                         MemoryRegionSection *section,
+                         bool add);
+
 #endif /* HW_XEN_HVM_COMMON_H */
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index bf19407879..6b0e396502 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -33,7 +33,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "sysemu/tpm.h"
-#include "hw/xen/arch_hvm.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 5150984e46..0fbe720c8f 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -21,7 +21,6 @@
 #include "qemu/range.h"
 
 #include "hw/xen/xen-hvm-common.h"
-#include "hw/xen/arch_hvm.h"
 #include <xen/hvm/e820.h>
 
 static MemoryRegion ram_640k, ram_lo, ram_hi;
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index cf6ed11f70..bb3cfb200c 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -7,7 +7,6 @@
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen-bus.h"
 #include "hw/boards.h"
-#include "hw/xen/arch_hvm.h"
 
 MemoryRegion xen_memory;
 
-- 
2.41.0


