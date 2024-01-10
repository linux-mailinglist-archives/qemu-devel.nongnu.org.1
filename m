Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C09829593
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQ5-0001uI-If; Wed, 10 Jan 2024 03:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQ2-0001m5-4P
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:38 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPz-0003ew-TQ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:37 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9bec20980so2059486b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877114; x=1705481914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9DX/yABn7H6D8nkaYlAn5VHOefnwsEy2Xf0wkIOOCU=;
 b=jfaf2wXsQ+uQaoU1enibRoZ9p453EefpIJ1MqGfpF7unsIYzZsO7IZA6Q/Jyj0875N
 +ktELMiCsVGdm2nPma4HT+qmTvQM9yReW88+tC10BgiYysBKevwR2qc9ImUbgxcSo3RQ
 AbIMkjDZqpQGZX4mH6WgLkO9KTjBAf/y/XLY2BSk4HEzqQY/dE8oYIqoC0+DAJ8becdn
 K/o0uuTQRvEzFHhYAWZNjdiSXd8cplg0/Rd6nMtoBoHeUFWXPT2aEO/+M806VhJuNiwN
 DEuKFR+Y4nJFpnYdwJER8CWUhYrGcxYKP4LDhgpco+JDidBWTkDIcdt1IMXiVqrXsdIX
 LkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877114; x=1705481914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9DX/yABn7H6D8nkaYlAn5VHOefnwsEy2Xf0wkIOOCU=;
 b=X/veLTzhZd9mQwxgCEqZIokbBL62OsgzoJVYczxSxdMYyhoV30kN7VciUkt1yRNlv9
 Okup2oGMYCEasrhdAIhdMn5QRxjdZpUkSQ38kqnkWZ1XF39TGFJX8oFyql8op8yaQr3s
 f316QJ3Rz0uhVWzvv95b3Z5KyDFCG0duvCl7plM+Ro8NJ/UvWpBXHOmuQPT8Ez8oyIXm
 ZkteTVISSgqqRuiNCDds/fKiaMuOCp2aeSV6CnfWfsNry1+eT6cd6mOjcNYUNM/hDkuw
 pVupXogF59/pGCZiyL+Ta4cKbzQDGrBkmw5DVjHX9rf3m0Fi7wEjqvpkJo3U5bOYXAb3
 4Txg==
X-Gm-Message-State: AOJu0YxNeKEV8RrBmyZ42mhVm276CMezNi4A9sMazUkDEr03snBDHJ6C
 DnmX3w8Tdqs7mQwOrL1TjHJK7i/ThgcDnXu/
X-Google-Smtp-Source: AGHT+IG1XJreQvhQuZlbuSrRHMrrshDH48htiAs0oGdGbGEb1Q+z2jGDCtF9wOHfSToKiLz4T17Y2g==
X-Received: by 2002:a05:6a21:3290:b0:199:acea:3ad5 with SMTP id
 yt16-20020a056a21329000b00199acea3ad5mr478180pzb.48.1704877114215; 
 Wed, 10 Jan 2024 00:58:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 14/65] hw/i386/acpi-microvm.c: Use common function to add
 virtio in DSDT
Date: Wed, 10 Jan 2024 18:56:42 +1000
Message-ID: <20240110085733.1607526-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

With common function to add virtio in DSDT created now, update microvm
code also to use it instead of duplicate code.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-4-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/i386/acpi-microvm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 2909a73933..279da6b4aa 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -37,6 +37,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/usb/xhci.h"
+#include "hw/virtio/virtio-acpi.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/input/i8042.h"
 
@@ -77,19 +78,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
             uint32_t irq = mms->virtio_irq_base + index;
             hwaddr base = VIRTIO_MMIO_BASE + index * 512;
             hwaddr size = 512;
-
-            Aml *dev = aml_device("VR%02u", (unsigned)index);
-            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
-            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
-            Aml *crs = aml_resource_template();
-            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
-            aml_append(crs,
-                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                     AML_EXCLUSIVE, &irq, 1));
-            aml_append(dev, aml_name_decl("_CRS", crs));
-            aml_append(scope, dev);
+            virtio_acpi_dsdt_add(scope, base, size, irq, index, 1);
         }
     }
 }
-- 
2.43.0


