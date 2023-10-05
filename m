Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF317B9A60
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFI2-0006Ol-Ue; Wed, 04 Oct 2023 23:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHt-0005uZ-Tl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHm-0000IB-TR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKGCCnmqWzFiFS2Xm/PXYhwhVbskQX1u9fUtGauWkBQ=;
 b=cGLcEYGQ4hP0e2X9OvL8SN2XK8S1cbzi5SYnelsYgpSEWsoP0a1qh63KHlDwoOBnivuloK
 dMoqU/VUNysjox9KwwuglqghmCbTfFaCo2EHd4eGBIKVW3tABH3d28idknXJt2BimVWl4v
 dEdku2qt0PYHOVevpDu1oyKdGxgkyFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-_-_zCnPlPVGwB0xhVKd-Vw-1; Wed, 04 Oct 2023 23:44:25 -0400
X-MC-Unique: _-_zCnPlPVGwB0xhVKd-Vw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32320b3ee93so382916f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477463; x=1697082263;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKGCCnmqWzFiFS2Xm/PXYhwhVbskQX1u9fUtGauWkBQ=;
 b=a5gSYxGH5bJYl4hKfQF0aphoYj49fvvUJ/tOc2LtZmCFFyjRybUEzowulgxheQRkFW
 /HeWFsWXORBVHlzX1jlN2es/FrhivQm2jbliqkUjSoZxKeYMkkMGlYit11T2Tq3t9Gwm
 J/MdqA1hyWwWS+vZJwNrtdkJK5dv3RqGnabaa5NYMxSCREW8p91SprPiDPZx9ELk3WPI
 A6BjdOC6TGcD8pHD2w3+FNnj7hsc/a6lWtfZ920E4vMlq6k672HCdu3JC4kdRqnQ8By2
 BHCLISQUg2dj6bdjvM/G68po4Ag4VLdTnU1WQDEa919YjvAzqWk84ctz8nsskbmiifNm
 R3KA==
X-Gm-Message-State: AOJu0YygR/tA/9cXl5xAPkbsIZQ8Na2kCTMDKV4Ynv6NBBQDQ8QF5QSG
 XIEWRulTE5ucUqTqWX+Ho1FUlKIcy89FZ27bM3E0W0e4mVL5cpmHLkarNCYmWllsSZbWIBWxKvd
 GAmgMH5rTWYrlnyEnyaZv3U1mTtBnD3K4TfnDVcQ4aRfMMyx/x53jshK+hln3bb7D5EAD
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id
 x1-20020adff641000000b0031fb6eaaf48mr3590154wrp.49.1696477463327; 
 Wed, 04 Oct 2023 20:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYr5po5Vza7CChdNadPIMbbNtsC017NjGGu+zLxjYUrgLdvGtmujx+eA11bkdshonTucn2w==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id
 x1-20020adff641000000b0031fb6eaaf48mr3590141wrp.49.1696477463053; 
 Wed, 04 Oct 2023 20:44:23 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b0031c6581d55esm625752wrs.91.2023.10.04.20.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:22 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 28/53] hw/acpi/acpi_dev_interface: Remove now unused
 #include "hw/boards.h"
Message-ID: <4f70dd5f6366ac04b0f67d026ee2e17eb35daa45.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


