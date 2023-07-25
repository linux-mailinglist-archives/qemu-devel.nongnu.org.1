Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B356761C66
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJUv-0002Ji-Ey; Tue, 25 Jul 2023 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUt-0002J6-4P
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUr-00013Z-LR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3176a439606so888610f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297123; x=1690901923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Kl1/XJm+nsk8XiPEGJ2hmrVRAWR21KAyzVWiw2Ygbs=;
 b=gOqlZKkFqdsig6Y8OXGnU/MheahSVybUX2RU1lfwAtCk7d4/yWV//O0a/U6Q90sSal
 iYS8q6rgehP+F+I9xyE5+G5mP9+wcoeVH+r/Qqw2rkR9t3FzkdUNFviYbWpNXjbE6RS5
 J+AZsRbiR8eYcWx+ENWqUpjgM0NhHl168JOO7m7LVCNDPUTHs3xJD9KG1AftRdxBACQd
 TEdl87mC8aTrUGHb9Axioc1NLCS91g3S/Xg9F1+BFSURmR+14zBrAKFaUjSmFxzANJjm
 mT1Ivwd6q4a3L8uQ1pB+qeTob+Arg/pkCCt2bbh0Ot/0LaS1BJTX00ce9iILsfgm+8UW
 a39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297123; x=1690901923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Kl1/XJm+nsk8XiPEGJ2hmrVRAWR21KAyzVWiw2Ygbs=;
 b=IoFACSWE3fdcBFIVATI6LWg1x/GXb7tYnv05MQtGjZn6tTS/gojx7zpJ5E86RqpC6d
 GKCzf6AvGyz8j00bbYtsNbqZfhaEuzfV2VWD1TeZIhlwmh/EyXhHllpdvP1vZeRaNoT+
 psqITVxTkoB5p0NXy2g6ZpmUdOxMdJPFpIg8nvOE06HisqPiwbER9HN6virjcgXhvZ7m
 iKtx6D1kMd3nLXLYWMYoO06dah0Qe8gnlEhiL5aY4E7Uz7mb3141hKF81Evq4JSeea78
 CRn/M187+IWiqm9vPgLAbKmbA2b/E7RGSDF00JhFbxPaVcIJtNSFQJJvGylDZtLN7Ms5
 iHaQ==
X-Gm-Message-State: ABy/qLa0/+zyXiCZ7PBmPgdFXvOz9Gmp+dyImIPRlirens2OLG+FtOli
 G8gWY0tndAn4wMQqHpK8gyhMJ3Ppk4YffSm9ZRk=
X-Google-Smtp-Source: APBJJlFigGe8x7xPoiNbY9WdeMpbkQW7MEFT1K3r83tCldmxEbQusMJ7cFH9vNhvHO0wIqzqKr3kSQ==
X-Received: by 2002:a5d:68ce:0:b0:311:3fdc:109d with SMTP id
 p14-20020a5d68ce000000b003113fdc109dmr8233456wrw.1.1690297123801; 
 Tue, 25 Jul 2023 07:58:43 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4529000000b0030fd03e3d25sm16615358wra.75.2023.07.25.07.58.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:58:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Date: Tue, 25 Jul 2023 16:58:21 +0200
Message-Id: <20230725145829.37782-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

It's possible to compile QEMU without the USB devices (e.g. when using
"--without-default-devices" as option for the "configure" script).
To be still able to run the loongson3-virt machine in default mode with
such a QEMU binary, we have to check here for the availability of the
OHCI controller first before instantiating the USB devices.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230714104903.284845-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4018b8c1d3..3ad0a223df 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,7 +447,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     pci_vga_init(pci_bus);
 
-    if (defaults_enabled()) {
+    if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
         usb_create_simple(usb_bus_find(-1), "usb-kbd");
         usb_create_simple(usb_bus_find(-1), "usb-tablet");
-- 
2.38.1


