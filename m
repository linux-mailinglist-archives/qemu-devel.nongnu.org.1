Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BA7D0169
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXi8-000247-05; Thu, 19 Oct 2023 14:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfY-0006u4-Gv
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfW-0000ps-5F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=WXcYonTkiBVqJ0BJx8kBYF93P4JEBZZo1N3DY6+on+vptVp4TnFNvYI0GIORBNbzItAq26
 IV9zNo9NWkIP8nl91qV+0hDPYMSZSkVjgFUfqWLmrTghwgJOjtALbyNiTiM6621WdtS3rA
 cYWabXYrn1XvkuS0aB60V6sDBvS6+Hk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-0XaymeZ9PqKgYw7Y734iwQ-1; Thu, 19 Oct 2023 14:22:48 -0400
X-MC-Unique: 0XaymeZ9PqKgYw7Y734iwQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d9a31dc55so3704102f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739767; x=1698344567;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=G8qYBiqZfqMuNXUMggl23nVVf8Se8O4TEm0JSKNsaUBGaLrRgwgRwoklf2GxJq+ThK
 9yvGBalKGtinlILlGbIw1IzcAzI0T0qOgcW6bq/EDL1M4LWt9Hf5cs2SsNhV4l+yO2kr
 E/aVENB/BnTfYibd1WtvaAFFXGT8C5DE8ds3T2ONpWJlFojhoDoZSg35Cl/CEfLQgy15
 vxMEEql33P3ZBsUWGdnYTCdrpba4gZCjR/Pu3BNtzE0taxDa9Mte856Cz5jx/ayZtHU6
 1oSIFdFZayJsTpxbHtP+F5M0OcljCD2/iMWsILyBdtPgQeCpRQUE1/lUNGbM7w5ZNBdf
 JETg==
X-Gm-Message-State: AOJu0YzVhLNE5AlM6/VWCFyqTHlkqp1AJgDsnWRmhCAfXYDkiBfDypOe
 mfGT6z9Ie+wql5ny6c8WonYt1iK7WNfQrxdcrKQxLs3NXRFoPVO/p+xtp1kk9Xe00oVbRbxfjYl
 +aJs2Z9I68otnxZFh/hDRSZ4KXiDoxcjlLLp0tpIiGM3tkaGee4Ix5eouOmMnFHkNzvHy
X-Received: by 2002:adf:f682:0:b0:32d:8cfd:5780 with SMTP id
 v2-20020adff682000000b0032d8cfd5780mr2390463wrp.27.1697739766854; 
 Thu, 19 Oct 2023 11:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+fG2DPbcbPmmwru9zexJQDD8jxNyHV5Sn064eO0i73tfd4ZRr0BZvrvgjFcmN2MLKS2VozQ==
X-Received: by 2002:adf:f682:0:b0:32d:8cfd:5780 with SMTP id
 v2-20020adff682000000b0032d8cfd5780mr2390444wrp.27.1697739766477; 
 Thu, 19 Oct 2023 11:22:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a056000055000b00326f5d0ce0asm5056028wrf.21.2023.10.19.11.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:45 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 35/78] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Message-ID: <59cce3602fc40aebf265ec74378d8be998d4d0cd.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

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

Message-Id: <20231004092355.12929-1-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3f2b27cf75..b0e1f074f1 100644
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
MST


