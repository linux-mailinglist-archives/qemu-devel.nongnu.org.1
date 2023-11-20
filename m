Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA67F1F5A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:41:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BzM-0004ak-TH; Mon, 20 Nov 2023 16:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BzL-0004YS-2C
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BzI-0004jw-Fp
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso3100388f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516362; x=1701121162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pno/XIMEfv6sc1E+e58IOA0UG1tXfCuf040vsihGJmc=;
 b=CF5RL0zUzCIFvd25ju57WC06acxPFagk0euQB638guaostgYaiLpfOgwgmAJRGdFZV
 0oR4IYmsELKTWdHuvUVeKMVhfYq6bpOom/TUGX3rRKKX/Jr1gbqz8BFcm/MjtCGHSneA
 URwaSPLB4K8ONTDvNImP4UZ2oE3ps9RK5fWeZVVLrKX9XQ/qcvoeKDxHz8u+3KGgX9SK
 qcyk2ipAMYF7VHyQmn39y3cISyR72kYPFQgJZQOi+1IkHMTic/vh1eKFEz1wqfsOkvOT
 tvtYysFZGzWlvJZaO+vvoyesgoftXzVcdRaBLfEzn5G+DU8ZIiQsV753M9sEjDVG9S7z
 X7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516362; x=1701121162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pno/XIMEfv6sc1E+e58IOA0UG1tXfCuf040vsihGJmc=;
 b=Gr4oJsNRPNXnak3iPcY7dleugfFplQDJP54Ru/pdPMy6cFu0zCQePfCDDBamdH5c5V
 3bPxcyOJzSZbqALewWU8mHvD3AejvxgTTNDemMdjD7GWpCdT1PP/t81o2/g/zswJOnSz
 4i/hGUWDvyzEafxuKUMSAd871A1E1SpxUYV5YUfk7qQDnDCOgmDfV9i7Gkhxl+Q1B5aq
 awnE6/93pac+tQJJ4BialhMQZWo7f1PoDqIY/1VcyUzR6B3YL9Qai9SKkWXJlzN5WOhE
 tTKNB3uwwxB6uF+yTPb4qXTolbOD5b35Y19ytiDvkV47Pfm9I8+oc6GX2/f0DO2k3P3q
 lyKQ==
X-Gm-Message-State: AOJu0YwI5sv8qwQ7dplgQTIJmK4g7cvwrM5r5BR+fv24dobGBvFbg3RO
 DZ0xNOGq3lva18YT2ESRuqcVHwONiA80Fp9OxIg=
X-Google-Smtp-Source: AGHT+IFCM+02LF5oMUc1iksLuflOO0zjBgB07scFQdjSvIns9p2PzVI764WMyZ2ToevDwTE52mnYJQ==
X-Received: by 2002:a5d:4012:0:b0:32d:8855:138d with SMTP id
 n18-20020a5d4012000000b0032d8855138dmr5261429wrp.66.1700516362036; 
 Mon, 20 Nov 2023 13:39:22 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 f10-20020adfdb4a000000b0032da35baf7bsm12234102wrj.113.2023.11.20.13.39.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:39:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH-for-9.0 25/25] hw/pci-host/raven: Propagate error in
 raven_realize()
Date: Mon, 20 Nov 2023 22:32:59 +0100
Message-ID: <20231120213301.24349-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

When an Error** reference is available, it is better to
propagate local errors, rather then using generic ones,
which might terminate the whole QEMU process.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 86c3a49087..e34ce47874 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -345,8 +345,10 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[PCI_LATENCY_TIMER] = 0x10;
     d->config[PCI_CAPABILITY_LIST] = 0x00;
 
-    memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
-                                     &error_fatal);
+    if (!memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios",
+                                          BIOS_SIZE, errp)) {
+        return;
+    }
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
                                 &s->bios);
     if (s->bios_name) {
-- 
2.41.0


