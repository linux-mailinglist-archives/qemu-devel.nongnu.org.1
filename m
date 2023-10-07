Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B657BC7A5
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aq-0003l8-BC; Sat, 07 Oct 2023 08:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aQ-0002sB-L6
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aN-0002m0-Cz
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:14 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso529235266b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682349; x=1697287149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAj6teEkNdflzmCr/vlbRRvGVOWgOuzImtd+RPlYf5g=;
 b=d6mkiqhZ/QEhYyQTUc216ZPBAUW9RdCHPlDOhVc0r46x1XVMS9Pu71PgQu29PupNEU
 cae5VpGAF2X6ECeI0gLRLDnrz5MqdPM00PNph8Tr8iyB36i0ySecAvGOxSw5CeW/a0Db
 lUQ4CXFTZ6QlxYO1ZQiSLiUspiSBKMZl2685W3+9+4lFYfd8LtMvWtckuW8fjsQQ4B49
 vdDQc5KOPUbFxtWEUzTSDYg5Kt2VT5v4P6NLNYqYP+WJKIc2mGM7rargbelWQsqtrrHc
 blM3bVT6NWzNGgH2bsP2klR7hvD1VFDhbl18xQvLZIhg+y4cL6QOOQklYdBY9zabSokm
 GixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682349; x=1697287149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAj6teEkNdflzmCr/vlbRRvGVOWgOuzImtd+RPlYf5g=;
 b=ZPGeYkpnZSmWusS7gys3EmBrcrlUHVfXcsJuURaR+A6rs0HX3d/0KdFIbzMlAEandh
 Lqv3C/lvOnyGk6MQFZIApdFzct/NmBrXj4Us7pm+XmscMoPoydUokQ19Lnuy74YF2Oz+
 d0vz+Qwe5ZJYk32dF7s2CeiTV6CFz3kD9MbVED8qhmcYtdK2WTlYxu8+maPHvFT+Z0p/
 XgSmX5njh1K09KAOD6FtxAzOnqg3QKaY/6enn/Hc7tLkMgCgmS10IwpWr0COJAAhXLnk
 7a+HUHJURsCdp+Q3/iBmVhc+3c6Atg1GUginrnh9p6u7ROtlfssI/76+rNlfUXd+7nTl
 c9VA==
X-Gm-Message-State: AOJu0Yx2x2ZJasS0Z0VTVQKuUfDJpCkzWEhZomum3L7eGeg22KAv6tTw
 xDH+a8HxhE94JZMFIj8ASMpNlNYCYGc=
X-Google-Smtp-Source: AGHT+IHC7XCUEux96+luo/SbKXorEINESVXRc6eehKkRF9r1WjVokffFsXLZ371y+av5rzTinPCXLQ==
X-Received: by 2002:a17:906:10a:b0:9ae:3e2f:4d00 with SMTP id
 10-20020a170906010a00b009ae3e2f4d00mr12244297eje.70.1696682349529; 
 Sat, 07 Oct 2023 05:39:09 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:08 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 15/29] hw/isa/piix4: Remove unused inbound ISA interrupt
 lines
Date: Sat,  7 Oct 2023 14:38:23 +0200
Message-ID: <20231007123843.127151-16-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

The Malta board, which is the only user of PIIX4, doesn't connect to the
exported interrupt lines. PIIX3 doesn't expose such interrupt lines
either, so remove them for PIIX4 for simplicity and consistency.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix4.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index e0b149f8eb..3c3c7a094c 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -148,12 +148,6 @@ static void piix4_request_i8259_irq(void *opaque, int irq, int level)
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static void piix4_set_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIX4State *s = opaque;
-    qemu_set_irq(s->isa[irq], level);
-}
-
 static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
                             unsigned int len)
 {
@@ -197,8 +191,6 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259_irq,
-                            "isa", ISA_NUM_IRQS);
     qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
                              "intr", 1);
 
-- 
2.42.0


