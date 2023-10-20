Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF67D14B0
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt5s-0000zt-NM; Fri, 20 Oct 2023 13:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5q-0000z4-VK
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5p-0004WC-3R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so8383385e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697822123; x=1698426923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BLTImRtSBPYrMBQyYLLw+0mHiY20kiyEXYbycXjLtY=;
 b=FvYQfxXabcpk1sW37/1ctcNOMYI+jZc+XfiGHeuJkLiREPPhUNMzp7A2bEsW5lRDZb
 yuJc1qwKGKqjb7cBNPESwBWFNdJNCVhozAGR4BrdiqSP6L72YEUq804cFPC42kO+AVPu
 CgGWrZl5l832XnuL1b2V7XokiB5/c4b66DOTyp9OSQcOOcg4hoIn4o4tG6gT+VvNf2PI
 SpAhZIf6iIp7kJzagdqwKcp3jAI5oLVYJQm8M2AKLz983VHHT5j62CYb1YZBHbyiBLuc
 xLVkl/ffppTYonldbR851nV5P9Gqr1EnyRkbh4Mf4/aa/AKX+w13JDl6mbyHK0G4Sc2c
 Agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822123; x=1698426923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BLTImRtSBPYrMBQyYLLw+0mHiY20kiyEXYbycXjLtY=;
 b=UieQVLvn3CgO/3fU3krOIm0Jeld/tENzgOEq1W+yfuN/tV9fl+9SlsIQ+P7dD2hlXU
 4rNSM8F5bAHcfQcj9ugP3EpZDVkKhcPz248BkA2dwCY2cJpC+a4Sq4n2nvg9hsw4nvS+
 OxdWCPGvW9Wrqpkucu6xUs4NyMWVir9lDZ32lvTTiv3OCb+zEDm2tdUSyEdpY+JAi7ct
 ktvX85inYd6HE+8kG7XnpaJyzE/z/OuJHW3RANraPqAlmiCfHsD2SoJwSF5EzFCSKLxh
 Y3eP+GpJT/hxkWgBQzYjQlhmGFvZBfka9DzzTMKU67g4l+h5uH40VfFKM3x9umy8mSXV
 DaUw==
X-Gm-Message-State: AOJu0YzWyni0O/39Yr5QreifzltlJ+5kc0CrSby7w3C4M4YHKNyEwIwI
 Wd+5iuVVziA8BD1DPryR1wjtxxfZWEjRKFtbNqM=
X-Google-Smtp-Source: AGHT+IGQ7qQaAUwIVHspX4Si/uARKERy3huLQOahx2b+7rO1hWKE4ff24tdeKwZXSG8uGQRb9mdYoQ==
X-Received: by 2002:adf:fd4e:0:b0:32d:89c5:45b6 with SMTP id
 h14-20020adffd4e000000b0032d89c545b6mr1803987wrs.38.1697822123574; 
 Fri, 20 Oct 2023 10:15:23 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 g7-20020a5d6987000000b003232380ffd7sm2087145wru.102.2023.10.20.10.15.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:15:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/4] hw/i386/pc: Propagate error if HPET device creation
 failed
Date: Fri, 20 Oct 2023 19:15:06 +0200
Message-ID: <20231020171509.87839-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020171509.87839-1-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2481c11e83..6750ed427a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1235,7 +1235,9 @@ bool pc_basic_device_init(struct PCMachineState *pcms,
         if (!compat) {
             qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
         }
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);
+        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), errp)) {
+            return false;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(hpet), 0, HPET_BASE);
 
         for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-- 
2.41.0


