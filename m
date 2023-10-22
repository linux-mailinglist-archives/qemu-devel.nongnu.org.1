Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E927D2233
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:26:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgH-0004U8-Ba; Sun, 22 Oct 2023 05:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgE-0004HZ-Jo
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgD-0000Os-29
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=OjEFPWY4YRFtSv/8yf/NASoDdKGQg4qYg3xl/OdiCi4Z4JyJZ5eUjeu76oHSXy6dp81wF6
 eu4uy0wFiqyG/sQDM+4NLGk2XWNl37bFH4cldq8TioEQdmKuHuNBjWx3krB2lYHCxY29Uy
 SZL1b/Dp+MTSUnXqYCLYx/z6wC/9Yfw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-eNJzUT5FM9KfEwsSVXFt2A-1; Sun, 22 Oct 2023 05:23:26 -0400
X-MC-Unique: eNJzUT5FM9KfEwsSVXFt2A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so13525325e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966605; x=1698571405;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsFr5HTvA8+mbntnG9MNra2wwSZ6tjasq8RRYVZ+VPU=;
 b=YBhVUPXmIF/sGNkwpdSyGW0zyI3V7vCReBfmbJsHbHNlgYQtJGBOJxzG2h6u72mGm2
 h+gNV8bwFe/G31DUa3MMeG77fB/PvjqCLgkc1bAMquU5WI3Cb7uHEbB5wRjeDryx9YCU
 5SYLWlOdXhxydWZYOQ6bnJOMfQXT0zHjsXA5E1edre9gauv19tgiiKLivW5Nm5HX84a2
 WzeIa57ynleTOH8tQ8KIF/2TI9Ly4UEQESH/KQVRXJv5/at8wUv7NdTZzZpvBfJXyW5Q
 2qLRKWw3Sy8YP2bQhSM6W+VP7B0XChv59l4lEMU8dhoLqAu/pF6c6ltg0Anvu7cztseU
 +Z1A==
X-Gm-Message-State: AOJu0Yx8HeXqVhMtf8xqarIpVgWUn1PsrGuyRQyA1wqfaSI8HgwWDXh1
 aqxvsqnZ1dlyXWFQP92jnlg7VtRBKkNOBCPCt1y1t9Ne7znbiUQBmWvlhasSzb1Z2A1Dj8ejK6m
 L/dtTaRA6pbqG45Rjm65HU45mpejm4OnbJ/d8bVNpV8fX/yl42XbEJryq/hFHyO4SVc0u
X-Received: by 2002:a05:600c:4585:b0:407:6911:447c with SMTP id
 r5-20020a05600c458500b004076911447cmr4992398wmo.4.1697966604843; 
 Sun, 22 Oct 2023 02:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRGRrVLz7nL2tzHUjT75xHJEAmRUU69SHXxKVVIHEe34UEDw9u8/5uOFbbCVdcfW44UJL0fA==
X-Received: by 2002:a05:600c:4585:b0:407:6911:447c with SMTP id
 r5-20020a05600c458500b004076911447cmr4992373wmo.4.1697966604267; 
 Sun, 22 Oct 2023 02:23:24 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0032ddc3b88e9sm5339267wrs.0.2023.10.22.02.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:23 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 19/62] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Message-ID: <bd7a6d88ec900a9a2c5b3ef09f941558908d3cda.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


