Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5567B7330
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmlY-0007JD-Ud; Tue, 03 Oct 2023 17:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnmlX-0007Ir-EX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:17:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnmlV-0002iO-V4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:17:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so260530466b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696367831; x=1696972631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M8Jq3E8JhHDPbXGfOfRZPIE3Vy3TEYgJjQxpurfmZ98=;
 b=VKSY7nN2Cu+FJyHkMwS+52RMXTpqbIOwmZL0J/Z8p8ta/WUwQ1s5QVDHEidcowrNSw
 rkx2aAYJs8f+koGv2znH57rOU/4BFyV64rO2N453qZSqADjrH7vo7KjsPo/Ug8zrQaL0
 ddQTOI6j6Pn/29u3KxIRMgmKxwq7VODjDdP32xPXK2EL1TCw4KsE6f29AT8TbAEqus+u
 sRdhhCaSjGociyWVacUcBHTc67SzFe/X+NksRBdXcxbcbxy/+fTOjeT6asZEKXhxjgJ/
 y3BFUJUgsnQ5t6EB3E+6GlUBp5VL6EytcHrhNQNdg9QQQmflp6VzPQ5PCMLGwVCzFyY9
 blvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367831; x=1696972631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8Jq3E8JhHDPbXGfOfRZPIE3Vy3TEYgJjQxpurfmZ98=;
 b=cV4upWuSPBAqWnUAPZA5MUKwlnYdtNLdP9L48OjoawfIxMiXW5JpgjfNJgeWP7rqvG
 F/3o6hQvorgx8znHVe/t0lrSJMk6nI4va7UC81JKKTtK2FjrWm46ueieMwHz+wHzdMHk
 GM0GpqAqjRMGpkKkLvdCSS+e398K/lzk3/zKC7Jk6OiraIylmFqC/Us2GwvGfJNIMMa5
 4tHccuysyCD6W8OOdoTUNz+ibT/ime7SmjIzxDQ2zlJ13iUJ0oDvdGwrQ5bjiWIgnerH
 PziTZo/NMkiYAVTIM+PUxx/J/PfSgH0hst+S3vsv3EIHOLx/jarfwmVUfBsuehGYeEyP
 dUKw==
X-Gm-Message-State: AOJu0YykdWNW+pc8pqcKXJOnQOAKMQKxfsPQ1QxH5/FrMDjRVw0U77Ke
 X4IaXhy5baHyc/Ko4QdCHnYq208z7Sc=
X-Google-Smtp-Source: AGHT+IG0a6pwSDD1H131uvbaSUwzxt/7wq1HKKzLyH6Q5UL2AHVy00ZFZIS3VwQrXDS6Ay1KvkT+SA==
X-Received: by 2002:a17:907:7817:b0:9b2:b7f3:6850 with SMTP id
 la23-20020a170907781700b009b2b7f36850mr279184ejc.62.1696367831426; 
 Tue, 03 Oct 2023 14:17:11 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170906340f00b009a13fdc139fsm1615245ejb.183.2023.10.03.14.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:17:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Date: Tue,  3 Oct 2023 23:16:58 +0200
Message-ID: <20231003211658.14327-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 6103451aeb74 ("hw/i386: Build-time assertion on pc/q35 reset register
being identical.") introduced a build-time check where the addresses of the
reset registers are expected to be equal. Back then the code to generate AML for
the reset register in the FADT was common. However, since commit 937d1b58714b
("pc: acpi: isolate FADT specific data into AcpiFadtData structure") the AML
gets generated for ICH9 only. There is no need any loger for the assertion, so
remove it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/acpi-build.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 95199c8900..6fff1901f5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -56,7 +56,6 @@
 
 /* Supported chipsets: */
 #include "hw/southbridge/ich9.h"
-#include "hw/southbridge/piix.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/pc.h"
@@ -242,10 +241,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_io_len =
         object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
 
-    /* The above need not be conditional on machine type because the reset port
-     * happens to be the same on PIIX (pc) and ICH9 (q35). */
-    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT != PIIX_RCR_IOPORT);
-
     /* Fill in optional s3/s4 related properties */
     o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
     if (o) {
-- 
2.42.0


