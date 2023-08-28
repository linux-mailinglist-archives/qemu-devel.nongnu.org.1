Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0E78A6A8
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWna-0006Vp-AO; Mon, 28 Aug 2023 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnU-0006Tl-5p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnR-0004JN-UZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso17664815e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208184; x=1693812984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlQwOv5k0qgcpbp2WOyNSYWRjL1JVN9nnZMS2sL7pc8=;
 b=KYITN2o8EvZoomWh33I7HsM09y1uKv9Z0vypbuq5gMhuviAzQ1yt0Q5yrdtItx14No
 iy5zkmVaMIcwmn+ww/8efK5fIHJ90ZU3plHQVNO2UGZ+RwdakJiN31SBp/Sd73uVhEaE
 VDDQkyl4l0VP0bubHI1Ztv4ZZ+yDtGkxuEx9PFO1WaeqR+3pLVGSDePj/ITMwDCof3By
 X05iXv1U40nG7/67z5IyJwCP+mVKI9FPkkvFR2MKZD4G7RQDFxc/mB1OY8SzqThfd1JM
 8/E/Y7WXGhJnzzuoB8sn847RWaANWzNeaR6AJx1unZZD6wYBHZn7FI4+Yhbfp4J04pWs
 ddMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208184; x=1693812984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlQwOv5k0qgcpbp2WOyNSYWRjL1JVN9nnZMS2sL7pc8=;
 b=ectIBVtWWBfGC0CD3dw4lbzjrpJ/8bZHwHkjiNSTdPhD5x8UTWVdtvzszVr3wgqjLu
 NY30E2IZOFhEjwq19KWWqgdAHFMtpWWClAXsosz1cgaiJ8Wi2DU0ExRrFPmzc5iCZ2hw
 ZryKX8nPYWFplavuTX7EHLrmvD/XiKZTFU/2+r3PmhLuXJk1NtkUDGoUfsLSSOPTJi3q
 fsgARjCRyqvdG8nPClGABz4nRAOk9nrvwefb2VqNwvs68BuX0xoOihpN0XIYIw2DbkMa
 yieyoDMPsSw49vXyQaLjxMcJCM/If1fJCnOzQTlkQ1qhgCMP5eFCZ8Ihz186mwW9p3ST
 3a6w==
X-Gm-Message-State: AOJu0YxxKIIQu9Y4WSybT7suWPSHlOqhZZTwbJXVomdUoCdkev28N/Qf
 RJLGdM9Nk5TNFSgZGjG8uyd8ZoRazZ630w==
X-Google-Smtp-Source: AGHT+IHDg9H6PT5mF+/EPNtC6msjPmq1JnyFG0AiOhtCQu7fy2yMtjXlgp16VqO+q/oyfR3+amf46A==
X-Received: by 2002:a05:600c:1e85:b0:401:bcec:be3e with SMTP id
 be5-20020a05600c1e8500b00401bcecbe3emr4715264wmb.17.1693208184168; 
 Mon, 28 Aug 2023 00:36:24 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/8] hw/acpi/acpi_dev_interface: Remove now unused #include
 "hw/boards.h"
Date: Mon, 28 Aug 2023 09:36:05 +0200
Message-ID: <20230828073609.5710-5-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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


