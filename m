Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408672B16E
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IOy-0006RE-Sx; Sun, 11 Jun 2023 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOx-0006Qi-BE
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOv-0008I5-PX
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:27 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so484136766b.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479664; x=1689071664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbGaNTD1IiXPDweFUBn/7X2i4gmueAx1RXqG2cvrBCM=;
 b=J2ysbB3mZVPs7medY+IPzMt124R/Vk12WdLWE/O23brKy0HjHmuZXHAO/RMlgPUPBq
 5NzEVy0JoEgrsLcgixsHRE8mvivkrSPZ0iqAwPgoVO8ZnUXysWeAy4Q9dKY4e6fNeEWx
 kYtY6jDyez4YbnZW5grXm4kOE8YaSeVLPBbPzMZLei5M8eSfWrJdi0Hv0pV/SFl5exYB
 N979yqB4P4FCbes/p8TB7MwCXeBe8ZBSojKkudQMttPT0Y29OZPdykF21oheQvgKbu7+
 R1DQ88UKX6w45ta7Y61jhnnTN5D09pD4IigKV5HZ2GhF38jGNwaOh9tF+qk7pWsOMGpl
 KNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479664; x=1689071664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbGaNTD1IiXPDweFUBn/7X2i4gmueAx1RXqG2cvrBCM=;
 b=F27zQKYZyAT9547in5lrRsl/+WoG2Xs1UZ6hwDbZKI64Jvu4qmrtm/Ehb+TFVP0zMq
 K+90FXQNSIPM2tDkjtT5j32E+g0DlVvc2dsRuLdZbR2bQEsTWNY/9cGkBgtrdZBlX3iu
 3FApfvR+/ZP72X2J3pjSKTN8mt8SNBjm1jjfPd/7BYweNGA9UPQt+7ld9WEiF1fEr1RZ
 1zMIhuDCSNi/d6xIJcDUpfyzn3vdcrPnKEoK+OWDOWCeWqVaxIkEe4Pas0YeaJhvuPnL
 KeiG6AEjcdLgbmeMS01LqWaz+0UFPTASlDUx+vUK2wzWS4tcxuVS7Emg/fvCbnECrljd
 0gSA==
X-Gm-Message-State: AC+VfDz6M/clpfBK4yvjNY3WsQbbgXvY6b+PfzUUUEHs5fDf4E81yjPp
 7ZrkfMySsQSQYcLF+4A66o1M3TRohlw=
X-Google-Smtp-Source: ACHHUZ5KrOflEEgInb0aycF4pDsgiJOL8zliXTGqd0MpGYWuuY8WRizxDAzIVbTBlugVLymJqzE+kg==
X-Received: by 2002:a17:906:eecb:b0:978:9ad7:e736 with SMTP id
 wu11-20020a170906eecb00b009789ad7e736mr6492343ejb.39.1686479663998; 
 Sun, 11 Jun 2023 03:34:23 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/15] hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU macro
Date: Sun, 11 Jun 2023 12:34:01 +0200
Message-ID: <20230611103412.12109-5-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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


