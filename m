Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB974190C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDF-0004hQ-Ed; Wed, 28 Jun 2023 15:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDA-0004gM-UX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD9-0005iC-F8
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:20 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-986d8332f50so25154266b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981936; x=1690573936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zxuFy1nKO4CI4FNaygwtRvNzJbOGIkhIVlB0FND1xI=;
 b=iNk9AerB1EuR7lMgwcmm81Z/3vVFueV6R0Ojb5oQgjTczIPhVl3PmrTBesMyU17MJF
 AFrAX6iEtu1Ni4U7nYUfrELKJnrItqUGbbtRaoY/pywbiQELK+nES/swA2qOGw7t+omF
 PTa1szS8JmQjdtb7JuaMG2VGhEyYTx51aVEN0VhhtIBQ+cTxpZKyFHm6wgpYvPWlhw7v
 CVIXHHlbndOSLME4Ojwi4IBjAS7qFkPFGvDg04zu0YxSCmfQ6xYsUL6/DovsL5h1DLXt
 VFLE2D5Or24Ccenu6+6oMXRT3U1xDdkhz5uq2jqaTb4wRlsOuGZnMxFzvv1x//X/yP+U
 +Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981936; x=1690573936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zxuFy1nKO4CI4FNaygwtRvNzJbOGIkhIVlB0FND1xI=;
 b=Z4EGX88r+LVkn5FzSmcc+xmSJiBkUhfKiEwp5dC58Q7kJYtUCGq/HN+7ENjAtF0oLq
 ZXOv5r6oZtDqupLlnROpLb66QQwHYbELKPgi2/lybiot8e4JIFzoXKNeoEmpLIZ02gRQ
 wK5yLLEoYyxZ6upTnPUsARp8CMVWbuiql9owVCHT3kvutzQsjTjy8z5hylBCi2cEEnbl
 HIOgVEnYMIuW3co6a+ebKhlD8azpxhlIdUKOvFynvhauTuf64g9H5TzTusjbI+VYAoon
 5ErLj3o2clN+CylSVj4Ldnh3II1xG2Algl708XfwOoJWKp/4gVyB0CgMcmg9aJ9hTb/l
 tKDg==
X-Gm-Message-State: AC+VfDzkvF+ICM7fxArvXDIWxI6Y14QYe0GtL/MM6cR3C3dQF/jep9iZ
 iz9O6Wht1XxkMPVhXERv8os3/Dzuukc=
X-Google-Smtp-Source: ACHHUZ431JrQQMgBSIZJcOVcHnwOtvvMiYgS8LSLFoGfl0VoHsYQ1r6d83AONOucJaN2BJ1tbFA0iA==
X-Received: by 2002:a17:906:3c06:b0:991:e17c:f8fa with SMTP id
 h6-20020a1709063c0600b00991e17cf8famr5059546ejg.61.1687981936341; 
 Wed, 28 Jun 2023 12:52:16 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 04/16] hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU
 macro
Date: Wed, 28 Jun 2023 21:51:52 +0200
Message-ID: <20230628195204.1241-5-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
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


