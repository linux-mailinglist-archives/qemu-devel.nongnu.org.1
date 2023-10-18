Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D597CE27A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8va-00074f-8F; Wed, 18 Oct 2023 11:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ub-00048b-90
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uY-000772-1N
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=XxT4y1Q+f0Xw2mkLxneGc6wD23ceLwtjcsvSxios5FytaXfQdfPxob0lFGLPZLDpLE/TYq
 2nhJ6Y2H68xlsLctrGXZ65ljrXuDCNEAGID3xa1KuFOTEQEQKjuG/vJZ8RcocHgoGOCEgO
 rq6+Bh1gxKTyCg6O3DiJnPoBbG1cCOc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-PHG2fDefMhivwpQy28yBjQ-1; Wed, 18 Oct 2023 11:56:28 -0400
X-MC-Unique: PHG2fDefMhivwpQy28yBjQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079c865541so5173488e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644587; x=1698249387;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=GKhSAW+C0etILP+ZaeaffMtKaRMS0RztwpE9q2NxggFfPOdtqaq7JqXDKvUosV5eCL
 et2yfasL6pehIReGWQIrq8TgNjfixxWJLhwmyOI6N0l4fJiqhkTmwtuZz9wBHCDgJF3b
 gNZ5Nqj31Ed2A70Cdeko5kCgiYIjPAFXdR6fi3SneDsLVVvFmDJKBrcf9cX8B7G380yE
 0p+2ows7gy/1iQqaX+LqGeDfj/vKT43ij9nbFQkE9OQhsq+Vl045gdkLVfBNXdmZPOaS
 SUubI5sJ5/bzaVxDBZsms98jqCdsvq3/EeIDHS4q2nwnAld1nyHn+1Tfqj5HT+mtGaE/
 4DaA==
X-Gm-Message-State: AOJu0Yy88Zgf/9eBgNuMv6eJzAaq7Cg05DaSXwyoAACmihteY6ExAa++
 ujk7j/L53rgSCW4x2bF3SwMbGF8OEdJr9srzaxuAzGPZs6WvT9LWbQqTzuc/FqSBduUjCN5Y9Ia
 JYE/5CT4kzKOhbkDg3LUVf4h7ftjw8JzKn1uwxJFK214Ohz6yJh/CzqSt2O6ltXaRbh7cu7o=
X-Received: by 2002:ac2:55bc:0:b0:507:a96c:e76 with SMTP id
 y28-20020ac255bc000000b00507a96c0e76mr4418628lfg.21.1697644586819; 
 Wed, 18 Oct 2023 08:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26f17YTSp1BywFsAAcKHhAcN5haKhpJ/GGhsjBCwWxbk1SZKvWOw8LT5Bi3rZoidzKwBcag==
X-Received: by 2002:ac2:55bc:0:b0:507:a96c:e76 with SMTP id
 y28-20020ac255bc000000b00507a96c0e76mr4418609lfg.21.1697644586507; 
 Wed, 18 Oct 2023 08:56:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a5d664e000000b0032d687fd9d0sm2439179wrw.19.2023.10.18.08.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:26 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 40/83] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Message-ID: <88638e868aa507c6047f8b3a51b1b73aa51ba3a1.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


