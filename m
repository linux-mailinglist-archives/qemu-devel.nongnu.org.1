Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811E7CDC39
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5vo-0007LK-67; Wed, 18 Oct 2023 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56P-0003wO-CD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:41 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56N-0001Ak-Sq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:41 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c53c5f7aaaso23942911fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1697629957; x=1698234757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ELDyLuwVctu4VdhuDRUgD/j2w95dUA1duJhkxZjjSY=;
 b=BSRjJ4da6WiMvVzXOLzOCeKJjVkfKgGHhe3ENR7gF1HFdxmSQZJj1dtoAtsXvmALK0
 SfUVdnqP9UfkTIhsRlNkX7ow11MI82LzeK+YULKzeFClkTrKO7Yj/dcbWtwvQltsg7U6
 H3lddpYglyX8JjeIWG6ay7oxKyvm36mcyMDcsImGMQ12To9l9yBSSzFhEzBkvv7ZfUBd
 SlvmpMaU5OtHx0REKyd/hCkVUXB1CsyyuG4dUsW893bIxxKyLMkz2NGsaOgAm1k69R4n
 HU1qdzkM97j+qjH70jMNOpKvXxc2VeUmniNIA5TNOTVsrTnX5iXlWgIWaH+XaQWfRKlI
 y45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697629957; x=1698234757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ELDyLuwVctu4VdhuDRUgD/j2w95dUA1duJhkxZjjSY=;
 b=xQgyX693H/FQewP55s9Xs6lRyuyZsqHs3S+Qtwrc6hSrOz9guwFP7xXTvJ9Z+08tIZ
 wCAbISuAJwRTsavp3xFQjh2dHwpkKx6eXgbZFHuzNy4/ukzOmk0ubWwGrhdV5KGOlhHg
 fjABVFMKAmbn4W9xtgi1lb1XPf8UoPQlsqoYdJxqvvhz8wi1toGySNfIFOxmzw9ePje8
 T9lXoDtFCJM4kX3Ais/kAH7FAAmL7AgDefU39rcwJormA9Ri/JktwDRiXojBBIUxKltR
 CALOjxErO4rolnrBqKWzWGQJS6FUTPTpblqGigOOU4OPmpkjvGYdLpNyeQLw8Fz8SzqE
 Epqg==
X-Gm-Message-State: AOJu0YzrchIswiF2qN4869lQ4jHWWGHBEnjDtAmhy8pvSATHQU9je1/l
 HY2aFprTF7GKQOeaaYPUoYddDDHC4PqsTR6ohPO7eA==
X-Google-Smtp-Source: AGHT+IGl4fJRlYCzLGMtSOj8F5EgeJ+o6r+7+cr+xTyD57Q/aTMKP3KoxrIQlzgHTPjfI9oU+edFsg==
X-Received: by 2002:a2e:9f4a:0:b0:2c2:9414:7dc8 with SMTP id
 v10-20020a2e9f4a000000b002c294147dc8mr3589712ljk.36.1697629957362; 
 Wed, 18 Oct 2023 04:52:37 -0700 (PDT)
Received: from fedora.9e.network
 (ip-078-094-000-052.um19.pools.vodafone-ip.de. [78.94.0.52])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm1455303wmp.40.2023.10.18.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:52:37 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 3/3] hw/i386/pc_sysfw: Do not create BIOS region if MTD is
 present
Date: Wed, 18 Oct 2023 13:52:31 +0200
Message-ID: <20231018115231.3547102-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
References: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=patrick.rudolph@9elements.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Oct 2023 08:45:43 -0400
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

The newly introduced ICH9 SPI MTD controller creates the BIOS
region itself as it needs to update the mmaped BIOS region as
well when the MTD device is updated though the SPI controller.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 hw/i386/pc_sysfw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c8d9e71b88..b98077422c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -211,6 +211,12 @@ void pc_system_firmware_init(PCMachineState *pcms,
         x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
         return;
     }
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        /* SPI flash and BIOS will be emulated by MTD controller */
+        pc_system_flash_cleanup_unused(pcms);
+        return;
+    }
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
2.41.0


