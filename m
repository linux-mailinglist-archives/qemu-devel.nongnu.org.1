Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8397435EE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hZ-0002BV-RB; Fri, 30 Jun 2023 03:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hJ-00023v-QR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hH-0005QL-Qf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:41 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-991ef0b464cso272013766b.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110658; x=1690702658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6dApJ7J8Z4QMs7bQhU3KSg7TWWxyrT4m6TvmkjO1Y8=;
 b=hygtFbNm9AFpvmsvBoXOm7U1ibViRW4nhS4YWMP7PRhXKY42EdmXDl+Oeqt/xBrpgG
 VcvEG8LFCt9qN7J5H4s1Zypzy3E7XZdI4iFogNin96lB/AaxD3s4QQpRGmgUN1agE7Is
 4ifANY4uibg9Itk6VERLL57WR+VYM7WSN40ZnuaPCaRTSmKTsqmq0Ca8pok1FWSzQOFF
 G2DtzY+D8znyweNfG8niKNQJSIgcmd8cWTabknwy3/G6YarpeNEQPIhkHeCP1CKZcYF/
 ZzYVWqP6YsKFKyU+X0sGJdiyZ0KsKtiUkssBsNSImnTKq/HyMJfTj8DxedSBLg9s/KnD
 hbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110658; x=1690702658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6dApJ7J8Z4QMs7bQhU3KSg7TWWxyrT4m6TvmkjO1Y8=;
 b=HdvBQjde30rvz8sG4lsTBaFniAqOu2Pe8lgJl/uP16DtZ2kgNOhQnZGH/Zv0E6D/AW
 W6d/QCZJtMXpO7eirbyDsvPnK6n7/jVmMXuZki+SxC1fdNG4v027lSe5INSJjTgj0Jua
 77bfXH+T84JD80GxRA9fGLu5jbb2VjnmtEOQWsvg6d5dLCwn5XjqHu595JSC5clFrhMg
 GXvA5tx3eyCeTVGgHxW4JFzOzQbhQvvXQIk+URR4CFtMi6+HH+RbyNbTAyMtfdcMcESY
 Hcxk7yft/jpISbSFOigo+fS2IO24qMvKoi8+BSyWn42a/vmYnAFTl/7bYmqWy3jSmCpN
 YG9w==
X-Gm-Message-State: ABy/qLYJre8QwFD0R41UszA45FoGVklf4ps9EZjf3a69MXyp/31Onu3B
 xSrcopacNrWDyIS3D6OXeu6Sv6HyTx8=
X-Google-Smtp-Source: APBJJlE63SFsOLGy112X/s8Z8l9Mwq0c53py6g2UROe3d4fDzPlYd9ovfboUurq8QPIouiRMOeo7mg==
X-Received: by 2002:a17:906:224a:b0:992:1653:3402 with SMTP id
 10-20020a170906224a00b0099216533402mr2786264ejr.25.1688110658263; 
 Fri, 30 Jun 2023 00:37:38 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/17] hw/pci-host/i440fx: Replace magic values by existing
 constants
Date: Fri, 30 Jun 2023 09:37:12 +0200
Message-ID: <20230630073720.21297-10-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/i440fx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index d95d9229d3..b7c24a4e1d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -276,8 +276,8 @@ PCIBus *i440fx_init(const char *pci_type,
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
+                             f->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(f->system_memory, SMRAM_C_BASE,
                                         &f->smram_region, 1);
     memory_region_set_enabled(&f->smram_region, true);
 
@@ -285,9 +285,9 @@ PCIBus *i440fx_init(const char *pci_type,
     memory_region_init(&f->smram, OBJECT(d), "smram", 4 * GiB);
     memory_region_set_enabled(&f->smram, true);
     memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, 0xa0000, 0x20000);
+                             f->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
     memory_region_set_enabled(&f->low_smram, true);
-    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
+    memory_region_add_subregion(&f->smram, SMRAM_C_BASE, &f->low_smram);
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram));
 
-- 
2.41.0


