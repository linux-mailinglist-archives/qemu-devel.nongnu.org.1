Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068F7E9FE6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ykq-0001ca-RW; Mon, 13 Nov 2023 10:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yko-0001br-HO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:34 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Ykl-0003E0-KX
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:34 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso7123532a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888890; x=1700493690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3bxfGqI5yyGuHTvJ252KdxHxDRKsvIzu9uNKMF+2iI=;
 b=K+wHkT9TQ02DcnET7hfBhQXJMtbruAMVY1FgpK1CdXTMbL+iPJvcRo9neirpUpo9UC
 9Ez/91fAuDnqYcIHD/GkF4A98N5jGDk8WpJ6riGfKcScQq68oSqLAVen6vyUDF9dZaC3
 iLtikgsf+NPEIplVMXIAWTPSroquYBITLTV+lcqaYxs7BWkJpz1rJSnxCb4pRUIfo3np
 mEhgxu17QmqgwgYT5Kg/LnKl2m1Rm8sSg9NNkCiVgqyprXqU/7cIxyXFx4j5naxXFqoM
 yLzVQQFJ2i/6cAyVS++KLcSFokmfD6gbsed5GJNh1UKq4frLgqzel+zEdRuhfgRNQn6D
 aJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888890; x=1700493690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3bxfGqI5yyGuHTvJ252KdxHxDRKsvIzu9uNKMF+2iI=;
 b=uK+sjjc5rILLBzmq9XfGwsxuTI3f2Xth96ghwggjtgQl73oO+jQWWVe8CCQDNEYqLS
 kuRHf3cFvZGbVEnZ+GTiuC+M5RdPHl5LAaDEdo5TU6JxMgVqTJXsNdmNOuGXbqbTw7XA
 ei26OAcxZ3Sz+CS69PrHrbeeU2NFhciTL1WscGlqGo4lLesWusVIHoN1BEyFHh0mqceK
 GFc9ZQl+9Hfzy8n0YVTPfxeneOctSs9g/RQumGlBTm98PpofQEro6M5KLhua4Sh22KWg
 w6LNOVACiXDcwllIQWOLL2E6+P4FWpIQcKfycB+lkpkYKyf2+fqYVRvm8XA7jRO1cz1/
 smTQ==
X-Gm-Message-State: AOJu0YyanCxUZlSmlj2mYeZv6o6YYHTSkT8UXdTyz8Culjgf9kcfO4xi
 irGDnylAe3wPNORLOK8k4K+6Sg==
X-Google-Smtp-Source: AGHT+IF709HFmNxhzIc8XnNuz+a2oAKUrEHD5dHSaR8itUuUqXulXss7tknv1cuy4PMkZKxP4RsDmw==
X-Received: by 2002:a17:906:3049:b0:9bd:f155:eb54 with SMTP id
 d9-20020a170906304900b009bdf155eb54mr4125199ejd.6.1699888890200; 
 Mon, 13 Nov 2023 07:21:30 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a17090611d700b009829d2e892csm4243243eja.15.2023.11.13.07.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:29 -0800 (PST)
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
Subject: [PATCH-for-9.0 02/10] hw/xen/xen_arch_hvm: Rename prototypes using
 'xen_arch_' prefix
Date: Mon, 13 Nov 2023 16:21:05 +0100
Message-ID: <20231113152114.47916-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Use a common 'xen_arch_' prefix for architecture-specific functions.
Rename xen_arch_set_memory() and xen_arch_handle_ioreq().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xen_arch_hvm.h  | 4 ++--
 include/hw/i386/xen_arch_hvm.h | 4 ++--
 hw/arm/xen_arm.c               | 4 ++--
 hw/i386/xen/xen-hvm.c          | 6 +++---
 hw/xen/xen-hvm-common.c        | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/xen_arch_hvm.h b/include/hw/arm/xen_arch_hvm.h
index 8fd645e723..6a974f2020 100644
--- a/include/hw/arm/xen_arch_hvm.h
+++ b/include/hw/arm/xen_arch_hvm.h
@@ -2,8 +2,8 @@
 #define HW_XEN_ARCH_ARM_HVM_H
 
 #include <xen/hvm/ioreq.h>
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void arch_xen_set_memory(XenIOState *state,
+void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
+void xen_arch_set_memory(XenIOState *state,
                          MemoryRegionSection *section,
                          bool add);
 #endif
diff --git a/include/hw/i386/xen_arch_hvm.h b/include/hw/i386/xen_arch_hvm.h
index 1000f8f543..2822304955 100644
--- a/include/hw/i386/xen_arch_hvm.h
+++ b/include/hw/i386/xen_arch_hvm.h
@@ -4,8 +4,8 @@
 #include <xen/hvm/ioreq.h>
 #include "hw/xen/xen-hvm-common.h"
 
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void arch_xen_set_memory(XenIOState *state,
+void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
+void xen_arch_set_memory(XenIOState *state,
                          MemoryRegionSection *section,
                          bool add);
 #endif
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..28d790f4ce 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -129,14 +129,14 @@ static void xen_init_ram(MachineState *machine)
     }
 }
 
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
+void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
 
     return;
 }
 
-void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
+void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
                          bool add)
 {
 }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e674..ffa95e3c3d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -659,8 +659,8 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
     }
 }
 
-void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
-                                bool add)
+void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
+                         bool add)
 {
     hwaddr start_addr = section->offset_within_address_space;
     ram_addr_t size = int128_get64(section->size);
@@ -700,7 +700,7 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
     }
 }
 
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
+void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     switch (req->type) {
     case IOREQ_TYPE_VMWARE_PORT:
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 565dc39c8f..1d8bd9aea7 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -65,7 +65,7 @@ static void xen_set_memory(struct MemoryListener *listener,
         }
     }
 
-    arch_xen_set_memory(state, section, add);
+    xen_arch_set_memory(state, section, add);
 }
 
 void xen_region_add(MemoryListener *listener,
@@ -452,7 +452,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
             cpu_ioreq_config(state, req);
             break;
         default:
-            arch_handle_ioreq(state, req);
+            xen_arch_handle_ioreq(state, req);
     }
     if (req->dir == IOREQ_READ) {
         trace_handle_ioreq_read(req, req->type, req->df, req->data_is_ptr,
-- 
2.41.0


