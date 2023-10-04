Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E63EC7B7B19
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxWO-0008Mg-MW; Wed, 04 Oct 2023 04:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVW-0007Qj-VV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVS-0002Bx-QF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKGCCnmqWzFiFS2Xm/PXYhwhVbskQX1u9fUtGauWkBQ=;
 b=TIFho6VEL9P04IefSZFwSPcBM/eLo6E2zPm+C3Fnxf6BB9Jkf71eZpwu5G2GajiksbWyoC
 EovoZyUWyN80PXUfV6mA8QuHjqWSUtKkZBZe/Z3CmgNO68CrdJyCHvDJpc8hieOe96Ayjf
 izk4VzpAKj22nNxyz8/J8DRqkPYQ/xk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZD4e8f3NMPeBMcPL52j7Sg-1; Wed, 04 Oct 2023 04:45:20 -0400
X-MC-Unique: ZD4e8f3NMPeBMcPL52j7Sg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50467783718so1796807e87.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409118; x=1697013918;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKGCCnmqWzFiFS2Xm/PXYhwhVbskQX1u9fUtGauWkBQ=;
 b=pe+TTuDbA/kS0HmjLoFJ2iy8adkTCxgZpo1VdVXWQn7EXx8XSMf/ZRZVT63lbPwGqC
 pgcuYPFBNG8X4kq5yXHGl1GAZPg9UFvY5/uacZB5RRnWcE/lWCz3OgJRysOvuziLyvWL
 67LsYwgbUNNCa/7invZJZX0ArFzQ0lrJOJZSPgmeZkgjmth2QVvlnapIhdshKibHQ36b
 KyGSIE31c5HeCQG0MzDTKkT9P91r1qoLM1v1a50wm61p2uN2IuGPowTWLw1B2XKdZ79z
 XAcgJM6v1z0iupQUafBsFkONEFd1sSgON8AYgSHUf1chAb/Cxw18p9gLRL+rkVNT+yUH
 EgkA==
X-Gm-Message-State: AOJu0YyEbfKSmUOGGn0Q4wOJgfj36iFOB8GPFOHS02JHeoNOeju7XujQ
 hXG7gYnOijuWoo68336vLvfQ7egqKMWPEZeKcxs2XGmoLvEpZgusoMwYeQW+PQnvmK4aqpzYwg9
 Ob1zUNuLcyH9ht8pOK+tJrPnMPby69zYmSpo3iiAJ+zErXOnE0uIKvz4/BumUxjdV1n4r
X-Received: by 2002:a05:6512:457:b0:503:35af:3058 with SMTP id
 y23-20020a056512045700b0050335af3058mr1188284lfk.52.1696409118747; 
 Wed, 04 Oct 2023 01:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd7TGcnbgZF1Qe5yxyZTPkIl11qpVVZtlhlaM6wTDN7x4qNeSdJBXv8MkgVJbyHkJYAnlAtw==
X-Received: by 2002:a05:6512:457:b0:503:35af:3058 with SMTP id
 y23-20020a056512045700b0050335af3058mr1188023lfk.52.1696409111887; 
 Wed, 04 Oct 2023 01:45:11 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c11-20020a7bc84b000000b0040648217f4fsm936294wml.39.2023.10.04.01.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:11 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 38/63] hw/acpi/acpi_dev_interface: Remove now unused #include
 "hw/boards.h"
Message-ID: <82969cc6fa0ae1f4df6f553eea78d417b82a3340.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

The "hw/boards.h" is unused since the previous commit. Since its removal
requires include fixes in various unrelated files to keep the code compiling it
has been split in a dedicated commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.h                       | 3 ++-
 include/hw/acpi/acpi_dev_interface.h | 1 -
 hw/acpi/cpu.c                        | 1 +
 hw/acpi/hmat.c                       | 1 +
 hw/acpi/memory_hotplug.c             | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index b57f0e7e80..fd989cb661 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -27,7 +27,8 @@
 #ifndef HMAT_H
 #define HMAT_H
 
-#include "hw/acpi/aml-build.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "sysemu/numa.h"
 
 /*
  * ACPI 6.3: 5.2.27.3 Memory Proximity Domain Attributes Structure,
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index ca92928124..68d9d15f50 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -3,7 +3,6 @@
 
 #include "qapi/qapi-types-acpi.h"
 #include "qom/object.h"
-#include "hw/boards.h"
 #include "hw/qdev-core.h"
 
 /* These values are part of guest ABI, and can not be changed */
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 65a3202d3f..011d2c6c2d 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/cpu.h"
+#include "hw/core/cpu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-acpi.h"
 #include "trace.h"
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 2d5e199ba9..3042d223c8 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "sysemu/numa.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/acpi/hmat.h"
 
 /*
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index d926f4f77d..0b883df813 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "migration/vmstate.h"
 #include "trace.h"
-- 
MST


