Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57048798452
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:44:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4u-00034s-RO; Fri, 08 Sep 2023 04:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4m-0002fm-9k
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4k-0004oZ-05
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so20566445e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162567; x=1694767367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40TYdQRGURs2OSPqGazrXlVNFjzIURb9yqVRn70WK7g=;
 b=FZ0enFe6godYx9YWVYQjplJegaJ1+Ojo3StKDahpYhGm20sSjfNQTXM+4rtaVe4KvE
 Rjk8fX+w78OpehqLrAuOmaIlxMfKQvNsLYfWA7VUWOVxzyYG6aSjVYRLI2ItJLPerDQg
 sV3rkc9SDddhyZSx807BOLr5GjCUxhJdGJcBSdYC476Yrzypb8MfMkBbrWLnwYfHbkjI
 BIjRjeftfHsueDzHdxLxB5/hZmwpN85SqycMJsrPSHvkD8eOnFFKjIZg3yFDf7xloGBl
 g+BBRjLWFAgtCiUQbnpR1XLUNrEcKyBWS9gYL89U8c1JCZneVoaw6XgX+1Z1reoQlWsZ
 6NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162568; x=1694767368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40TYdQRGURs2OSPqGazrXlVNFjzIURb9yqVRn70WK7g=;
 b=Vi2D1P6CLDvGWP3NqtEfbw/JKDX3b4jlPLP1KtZw4M6j0GNYMQpTxMIqNT6HW45Jcp
 82v3ehyKNCsesOaYBANu7iQqjOEyKnFPN3TapXG3CVOxtoanhGKcv9zqnN1x5hLBobaU
 x9oRtu9JvOJS23nfUoI14ON7pWgREnxnSbmYmrSP5ht/uQ25ikodoOFC9zjnOYxZx8Q0
 UhqFJFEJ77GCWMSjAifCiar0DyZkiAFi1GHtCZ0KqqWUdYiZEne6zpjaMDamVnpzwAf+
 7SbqmZK8SFRc8TvYHC307cbVBvlk4XkcGH4mUlQx4i3fhLHmNbEjFp7Jn/UVYr2o4hIV
 L+EA==
X-Gm-Message-State: AOJu0Yxjts6SWeavEg4USyhpSJ4vZvnXvWVNq5+L2igl4tOJPZH8wUuD
 kZMyHiYLHzxDKLEm1kPCv9somoRz7LY=
X-Google-Smtp-Source: AGHT+IGKWDl9UfHdoXNSFmLTHaT5rI8Ckoif9RKyxoU/7i7iyiJrPOzCNhVldO0VFJ9Ld0OiXIdtBQ==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id
 n17-20020a7bcbd1000000b003fc0a494c05mr1519404wmi.40.1694162567439; 
 Fri, 08 Sep 2023 01:42:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 4/8] hw/acpi/acpi_dev_interface: Remove now unused #include
 "hw/boards.h"
Date: Fri,  8 Sep 2023 10:42:30 +0200
Message-ID: <20230908084234.17642-5-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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

The "hw/boards.h" is unused since the previous commit. Since its removal
requires include fixes in various unrelated files to keep the code compiling it
has been split in a dedicated commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 3a6d51282a..d9de0daf89 100644
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
2.42.0


