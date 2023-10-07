Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AD47BC7AC
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aj-0003As-Oy; Sat, 07 Oct 2023 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aR-0002sH-PS
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aQ-0002mS-A6
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:15 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso522987366b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682352; x=1697287152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6WBEEOvTEHc9GnSM9GFDttTzrfpmZsBm44Xss0CXqY=;
 b=hZn2aBqAoTVk+V4iifnST31t446a9y2/+3m3DY1iHZLppXLoX8PyIwt9DDZub5VTVw
 jRDs0pZ9yZNwLRCJ0LT37Vcyrzl3h7psRFxu2pav6VDEZjEJJaYhAKllGwYcVAkTmdTs
 8Ef7jYPFmq+TtfqrMg63UPr298N25XK4CAad9ZHy9FjDcRJWeboL8qP+ugWRxlMTZPqI
 kZVtkKi5cpzilR1GVTRzT8MPYHshlUTnWO3kR6th5bOSSmXKDdsdIff6Ex+Suekhtg2Q
 y9dJ1A/pvul2mkk9PHz4SKm8OJ+NZ7AP5vVkG22WpddBGe5Jn9+1qZfVmBMYpeTMwH22
 fehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682352; x=1697287152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6WBEEOvTEHc9GnSM9GFDttTzrfpmZsBm44Xss0CXqY=;
 b=XTsV50UGHQhd+tcUO9kq4WmW2mwMuBeoasUHk6Nk5W5eWd/uUG8LOqZabGNPBA3/bN
 xC6lp29JGqC/D6mrwCpfw9Oe0h9VZ9riK1qoWf0qySHxBcZio0DiytWlWPmVLToHb1jr
 UcRP6zUx5XC0aXGrDU5Zo5wIQlW3krMrRAyy1v2nDU+aVhDpPwdusdRo5pmaZf8LkChg
 tOYFA2MP17Sh5BNyqLkcXFc1KMSnz6fszGouhZSHA9/LX6Oh6mW7kpl1ya10sgcviAzj
 DyaLlNTg8VLjU6GX1ADLMUr4mi+rmIey0tGr7512sHrxG5xxXzWret4g+YOCauVEt0lF
 kmRA==
X-Gm-Message-State: AOJu0Yx4B9aLvXp8Axs5jERtn1wUuTkFnGpK7XVeL+pvnpFVMEi/1DR9
 ThcE97cDsBXjSAd6toCGoUgiWeHhpnM=
X-Google-Smtp-Source: AGHT+IGj10qYt7fk3Ppr18/E/mMVEGdm3G1ESAOdjSgCSZtFWhURdhfxkzI6sQhdofb6Yyni7rrVrA==
X-Received: by 2002:a17:907:724b:b0:9b2:b9ff:dc35 with SMTP id
 ds11-20020a170907724b00b009b2b9ffdc35mr10429364ejc.70.1696682351929; 
 Sat, 07 Oct 2023 05:39:11 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:11 -0700 (PDT)
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
Subject: [PATCH v8 17/29] hw/isa/piix4: Rename reset control operations to
 match PIIX3
Date: Sat,  7 Oct 2023 14:38:25 +0200
Message-ID: <20231007123843.127151-18-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

Both implementations are the same and will be shared upon merging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix4.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 9c8b6c98ab..eb456622c5 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -148,8 +148,8 @@ static void piix4_request_i8259_irq(void *opaque, int irq, int level)
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
-                            unsigned int len)
+static void rcr_write(void *opaque, hwaddr addr, uint64_t val,
+                      unsigned int len)
 {
     PIIX4State *s = opaque;
 
@@ -161,16 +161,16 @@ static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
     s->rcr = val & 2; /* keep System Reset type only */
 }
 
-static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len)
+static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned int len)
 {
     PIIX4State *s = opaque;
 
     return s->rcr;
 }
 
-static const MemoryRegionOps piix4_rcr_ops = {
-    .read = piix4_rcr_read,
-    .write = piix4_rcr_write,
+static const MemoryRegionOps rcr_ops = {
+    .read = rcr_read,
+    .write = rcr_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
@@ -194,7 +194,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
                              "intr", 1);
 
-    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
+    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
                           "reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
-- 
2.42.0


