Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451FC9D8C12
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 19:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdbo-0001Fk-NE; Mon, 25 Nov 2024 13:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbW-000194-MD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbT-0005CO-W6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso3552904f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732558470; x=1733163270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKiSAmW0YTZOm2et5NElSEWiWu4k/YmN4d8Ua0BroHo=;
 b=TizCsPU5vEAWkVR1OpR28FRSDPbYNGOkm8kuhsygy4+5uCpHxbUQW4fM+MwV8azUUQ
 vpzf0uDKmVNEr4l4r3R6SOUP2n+PV9LeZtPzhRTNP8leuhF4BucjJwIHy1sv7Oy1+Ctm
 7ke6V6dMvlxNKmdAq9iYxeG8Fklh7MjUsoKj/Fn55Tkdfc/mPkXjbWU6KMKkB66giE8k
 ZTGqGGXgeTLuQp/0RafdQWYRfskkI/2ma5bbCARCSe3bVc2/9zcv3UT5JgHOCW7InhdS
 QVqjSogQBr4iCOwLXYl7eHmB4qNVg71x5J6TF7LXUMDUMJzkXLhHyF/wbEKBqrKkgms3
 W2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732558470; x=1733163270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKiSAmW0YTZOm2et5NElSEWiWu4k/YmN4d8Ua0BroHo=;
 b=sDWT4szV8m/rp6x979iuY3FsID+DU548ejnBrqF6zHpx7yAVWY3V1ROw5s32j4XOV3
 bkaOw/zBdJcr6+QBd7QqfCpp0BPgqADYN8H8rCxzZKCFNT/2nmYu4GcfVgtfkJtlJexA
 n8NBFic8Ui/RCgnxP1uUVegYnHf9vtK4We89DdDB74CDdQ91hnb4pGedkg/44CGW/bes
 sJloleETU45zI+tOpATEnBU2ZzK99QFeS0FidGdtZuUAjZDBY0umsSNtQyQXLJMrm2q5
 2+t7Wi5SGUrzWtL+JkC4fX3hgBLQcR/W2emmxb4pcfp2U8W+A3P3KE1+P6L8hiHvfxjL
 Y+KQ==
X-Gm-Message-State: AOJu0YxMbuFu/aYKtCyGt7lToBf7MZoGBec6nOIluD6bGwJdMOntfotl
 DIewJfVu+j3c0FYF4LYloAihI6MhjCvsTGWyO7I/8Tj+s//BbqMFYwzgpjZLD3QiH2NYV9+3oQq
 D
X-Gm-Gg: ASbGncvmoBHRaHsB0RQoH1x9zFdXC7HXq9xPwp1OHKBEuXPoEaJ/ouNBFA0W1sgm0c6
 P0Pud/nXx5JYWt7AUIPw8+9MLloZ+Syu3lZIWI0YC1ZQlxq56SzAp2TrtL/IIl9nWFEkoJS43bT
 UtYUkMjZJiYte/c1A9iqOJQlIV4TUrZon+XqPpmAyHnm5uJygDvxagZjgYwzTB/+YOY71k/4CLH
 V/JpxcLBQDH3HTtjJX5XuDkjw72yPZdIM7GB3AqyX8gpPtIJJYrmNtuPDSraThFjDLkDMVd
X-Google-Smtp-Source: AGHT+IFM0gSZqEMpVDD1uZtS66lPh3LCuQsv20JxGOIuVaDeweiqVcNsQtSVTGBjwpN96APWXvP5aQ==
X-Received: by 2002:a05:6000:2d0b:b0:37d:5141:ee91 with SMTP id
 ffacd0b85a97d-38260b5e278mr7949691f8f.18.1732558469949; 
 Mon, 25 Nov 2024 10:14:29 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2760asm11040421f8f.52.2024.11.25.10.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 10:14:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 1/3] hw/boards: Convert no_sdcard flag to OnOffAuto
 tri-state
Date: Mon, 25 Nov 2024 19:14:18 +0100
Message-ID: <20241125181420.24424-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125181420.24424-1-philmd@linaro.org>
References: <20241125181420.24424-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MachineClass::no_sdcard is initialized as false by default.
To catch all uses, convert it to a tri-state, having the
current default (false) becoming AUTO.

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h        | 2 +-
 hw/arm/xilinx_zynq.c       | 2 +-
 hw/core/null-machine.c     | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 system/vl.c                | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36fbb9b59d..86fcf9c81f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -283,9 +283,9 @@ struct MachineClass {
         no_parallel:1,
         no_floppy:1,
         no_cdrom:1,
-        no_sdcard:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
+    OnOffAuto no_sdcard;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7..76bab2499f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -463,7 +463,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f586a4bef5..b93056c0f7 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -53,7 +53,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fe03f716f3..8b40b87899 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -747,7 +747,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->smp_props.books_supported = true;
diff --git a/system/vl.c b/system/vl.c
index 3bb8f2db9a..4a7c29a8ab 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1350,7 +1350,7 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
-    if (!has_defaults || machine_class->no_sdcard) {
+    if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
         default_sdcard = 0;
     }
     if (!has_defaults) {
-- 
2.45.2


