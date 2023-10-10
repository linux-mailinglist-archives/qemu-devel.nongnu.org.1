Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E27BFE80
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDBT-0007LC-2g; Tue, 10 Oct 2023 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBP-0007KY-1o
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:59 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBN-0001iW-HV
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so383263166b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696946035; x=1697550835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrwoFvKY1A9VObVBjO6qwtG9FanKz6ymVBR7FRz62IA=;
 b=YEWuG5pGkeO/tRohoIjAUNoeU/BywlfDfod2GtyKl04isIhp/cbcNFznr7SM/oPJ3K
 xYpwZGEAr2DMoHJNG3FljYstqMV2j+7a1TwXTAVtL6GOdcVcD/9BclTd5VW+AqkuIIz1
 /Nh44Qf8XpBuB4S1LsWUaZQcmymOMuUkSZ46Sm7cHFWAyeYY5MbPhWphZYvcdGLulnoo
 KVBqITxttHQ9w1zE0ZoTt8UvsjAKpLcsmGhaaLeeJ/AVB5ozH3f9oWl/K4+U+w7wKJ1Y
 9nLHDrlO0fKOSKFYxdBRNxSH1U0OlEWMo5cKzyMK0+Y493XYvYqdsqFtxOU90+AwMmsP
 yT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696946035; x=1697550835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrwoFvKY1A9VObVBjO6qwtG9FanKz6ymVBR7FRz62IA=;
 b=ZMPbVld/T7MkZXPO3RIdM4kgOw/SLePpe79tXBGIA4OKMQTeNj51KsttDh/fz1VYgQ
 HaMMN7hmx6GwS0PC0uSFCBPwd8W3w38p3QQug4IagUgKrPqWeIjBGG5s1WHARo8dlxG0
 /KqeL9J3teK8aoSTZ+cM5JCC54O9MA0nCjpYHXN/ezbgOip4bKWmkIJidwQBaqcFWsta
 o0vANaqu6usGNVWkXY++INtUldQmoiteANlgeAk8iQfo8mAHi0yoCx0z9PaTTXoFFtBB
 Kg9sbNKs42zKAOgk3dKhkRZPzeyBeHkgehGiPraffYllKVDCfh/ZQby5ludm+/Ex6JpK
 TGlg==
X-Gm-Message-State: AOJu0Yy1cJBu8VhgCIehHjP2OES+SaDRrIe7A0LCWMpxktY5IN56dAAQ
 3Y41ziUlY3l32bGSb/oAmrRmd90g0TpOcsQRcDBBlw==
X-Google-Smtp-Source: AGHT+IGA6Nuo/I+57/O2bOFSqmqc1e9humJzZ9X/moF/n/qXojxjwKVLaJbVPO4tfTI6lloqRh+83A==
X-Received: by 2002:a17:906:c5:b0:9ad:c763:bc7a with SMTP id
 5-20020a17090600c500b009adc763bc7amr14606861eji.23.1696946035588; 
 Tue, 10 Oct 2023 06:53:55 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 o12-20020a17090637cc00b0099bc80d5575sm8378427ejc.200.2023.10.10.06.53.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 06:53:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/loongarch/virt: Remove unused ISA Bus
Date: Tue, 10 Oct 2023 15:53:42 +0200
Message-ID: <20231010135342.40219-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010135342.40219-1-philmd@linaro.org>
References: <20231010135342.40219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The LoongArch 'virt' machine doesn't use its ISA I/O region.

If a ISA device were to be mapped there, there is no support
for ISA IRQ. Unlikely useful. Simply remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/virt.h | 3 ---
 hw/loongarch/virt.c         | 5 -----
 hw/loongarch/Kconfig        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index f1659655c6..674f4655e0 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -16,8 +16,6 @@
 
 #define LOONGARCH_MAX_CPUS      256
 
-#define VIRT_ISA_IO_BASE        0x18000000UL
-#define VIRT_ISA_IO_SIZE        0x0004000
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
 #define VIRT_BIOS_SIZE          (4 * MiB)
@@ -38,7 +36,6 @@ struct LoongArchMachineState {
 
     MemoryRegion lowmem;
     MemoryRegion highmem;
-    MemoryRegion isa_io;
     MemoryRegion bios;
     bool         bios_loaded;
     /* State for other subsystems/APIs: */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aed..91342ee3b8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -874,11 +874,6 @@ static void loongarch_init(MachineState *machine)
         machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
-    /* Add isa io region */
-    memory_region_init_alias(&lams->isa_io, NULL, "isa-io",
-                             get_system_io(), 0, VIRT_ISA_IO_SIZE);
-    memory_region_add_subregion(address_space_mem, VIRT_ISA_IO_BASE,
-                                &lams->isa_io);
     /* load the BIOS image. */
     loongarch_firmware_init(lams);
 
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index fcd5f2b4b6..5727efed6d 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -5,7 +5,6 @@ config LOONGARCH_VIRT
     imply VIRTIO_VGA
     imply PCI_DEVICES
     imply NVDIMM
-    select ISA_BUS
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-- 
2.41.0


