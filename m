Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA477435E8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hP-00023o-1C; Fri, 30 Jun 2023 03:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hE-00022c-8P
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:36 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hC-0005PN-FP
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:35 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso168596866b.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110652; x=1690702652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zxuFy1nKO4CI4FNaygwtRvNzJbOGIkhIVlB0FND1xI=;
 b=Xr3EPxkfgc/aI13yvkPkvJj7vcrFYNIYfIX92iYccNiEANusSUOZj2q3jRVz+VjPwV
 AJaTgzsOy9151Tglz16uFwMUB1u2irpGB2w39R0aL4a6tBqdetr8WM2JhbeCppkOrQbD
 Of1Yk8vQNZo329ZCvRTMBscj+2PU1i/NeaCY3k0hgl0eTnnK6gW/yJ8IWwzQuIWQKX5u
 ihf2nMXDWJghKrebEL+7uJlCpRXSHWraxD4WewDYFbKXZGLVEs6LnNdxNI3I9/CY7QiJ
 lutBEZrAckARU44+aAzA2subsba+PkfGd5JAe2E0d44VphsMZwuh2yp1XDWV1iXR8vvO
 Cevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110652; x=1690702652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zxuFy1nKO4CI4FNaygwtRvNzJbOGIkhIVlB0FND1xI=;
 b=DzUCGoSb7gBxkI8F+JmgDgskP6Jp5Mg27OYSy6cTGB43oJItA3UyVPlBu9oJOKjgcb
 McQHp3JbbgUY+48xjIsTMKFdQQf4v83yxQQax5MLUq92yi/BAuicgc/myMGDVF8vKZCi
 z+tAriv58CEQtjIY4V5d7wrICvRpR4IPFAzZt7xKF6nkyunS3zIRUR5bM/9WWOFjBKgl
 nHJCLA+3yunP368YJ5c1wO1mgB6DxOZ51mXjpd7XeRHP3j1oyNkWG32lGU+oF1a/jEV+
 RjuE5GxLZMlMTGmpckapJ2tESfDa/pVDg2SBRem/R6nECx3gYdAu7F0vcqo3wD77evpl
 TfdA==
X-Gm-Message-State: ABy/qLZhdIrqK6SGOjqrOhoWra1QOLc7kD7qd2raNjFiNK8NcX9TwpCx
 QQGBWPuFNHe49Q+5KE3ZP2JluyBmXH0=
X-Google-Smtp-Source: APBJJlGZpb7VEK94oJSk+fOZrzfelapHmja8xwo2Qg7UU9vcKxtLN832ZNePWCqah7O/Mi80Pwxtmg==
X-Received: by 2002:a17:906:fa89:b0:988:7d1:f5a5 with SMTP id
 lt9-20020a170906fa8900b0098807d1f5a5mr1231593ejb.28.1688110652512; 
 Fri, 30 Jun 2023 00:37:32 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:32 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v3 04/17] hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU
 macro
Date: Fri, 30 Jun 2023 09:37:07 +0200
Message-ID: <20230630073720.21297-5-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Introduce a macro to avoid copy and pasting strings which can easily
cause typos.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/pci/pci_host.h | 2 ++
 hw/pci/pci_host.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index c6f4eb4585..e52d8ec2cd 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -31,6 +31,8 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
+#define PCI_HOST_BYPASS_IOMMU "bypass-iommu"
+
 #define TYPE_PCI_HOST_BRIDGE "pci-host-bridge"
 OBJECT_DECLARE_TYPE(PCIHostState, PCIHostBridgeClass, PCI_HOST_BRIDGE)
 
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfd185bbb4..7af8afdcbe 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -232,7 +232,7 @@ const VMStateDescription vmstate_pcihost = {
 static Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
-    DEFINE_PROP_BOOL("bypass-iommu", PCIHostState, bypass_iommu, false),
+    DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


