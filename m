Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C17B7BF6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny6y-0007zJ-Ri; Wed, 04 Oct 2023 05:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qny6x-0007yW-Ms
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:24:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qny6w-00062D-2o
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:24:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso345251166b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696411444; x=1697016244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mw3xOxx34hNdoK5Uz/kOYjKHuoJB4owDbqWJtweo11g=;
 b=lizv+rmJTnZ6fJYPWxtUKS3vKlZ8Y+JzDbGzh5YMQ03shK3ZqnZGBcy+f9Efa2mHrJ
 plwnKiBMsdMuugABvDlftULq1YPsevhZujAXEtbbw7L8nR3tUPchEq65Ug8nAyPLvG+U
 kxnBa+By9cB1C1CmGQOSPS62KrN0coOvPT1U6YaNj4dcNlB+GdDAnHNyoWQhjQXrOPDl
 4is1Y2ITlB0opHYHlRtsd5Cmh5xVy7T6gXDFWyBcbv2669aSYzpCSkS8nl3rW/OSyDQ4
 yFjY4uxa8kMXkxXc/UxcqM9MWk7ZLiK8oj+V94S8AECnTt5ldYipST8MUuw1xaK5O0xc
 i//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411444; x=1697016244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mw3xOxx34hNdoK5Uz/kOYjKHuoJB4owDbqWJtweo11g=;
 b=Akm18UeNIIKteHM9Nyrtpe7RwvsMg5+4eDPUjUMA2y/n1bqsDk+oLwJFQNHJvvqXw/
 7HQsrrJBLsUPrnUl32oS4E/vjKT1DH0NTc1hEfZmBrW1dNf2jPabBRV2sa23p2oS2dn1
 OVi+/9ukMOFuu/EgQhs5VXMj9Y2bnptJZ8iXXvAi6/qIvOapnI/JF/xcb/XKp4FYWwZl
 6y0jTTvWa8/ILBW1jvf9DPdxnws4K2WI25xBjAzvuU032Mgmf03GMt2FP0H4W6PB+bzO
 nLRho3yeo52955hpvuwWPrHovxvHZ0lVrmgLXQMXvgMx+weNb1ZTSj5eRwenJXrFbXAq
 QrVw==
X-Gm-Message-State: AOJu0YwAfXk4e3jUnnkxrA5U0RFIEx/j6svTBunLWVtbvkS8eh2L4tti
 RBHMEd6ZEvz0vhVCQuktCFwgmA99hWM=
X-Google-Smtp-Source: AGHT+IGT43dytZSJ+CmYgS+QYEwiGwBk3n+K83N5eSOpYAr9JISlUHico6l3enwc3V5sid380lJs2A==
X-Received: by 2002:a17:906:32c7:b0:9a9:ef41:e5c7 with SMTP id
 k7-20020a17090632c700b009a9ef41e5c7mr1567145ejk.8.1696411443469; 
 Wed, 04 Oct 2023 02:24:03 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 a16-20020a1709064a5000b009b27d4153c0sm2512978ejv.178.2023.10.04.02.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 02:24:03 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Date: Wed,  4 Oct 2023 11:23:55 +0200
Message-ID: <20231004092355.12929-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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
reset registers are expected to be equal. Back then rev3 of the FADT was used
which required the reset register to be populated and there was common code.
In commit 3a3fcc75f92a ("pc: acpi: force FADT rev1 for 440fx based machine
types") the FADT was downgraded to rev1 for PIIX where the reset register isn't
available. Thus, there is no need for the assertion any longer, so remove it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---

v2:
* Fix justification of commit message (Ani)
* Fix typo (Ani, Philippe)
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


