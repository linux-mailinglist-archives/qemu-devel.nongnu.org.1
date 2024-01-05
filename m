Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1D825749
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:56:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTe-0003wr-Sv; Fri, 05 Jan 2024 10:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSU-0000A7-JZ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSR-00011a-MZ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:50:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e3b43173eso2095825e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469801; x=1705074601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDwxzH3vS9V/d1nX5dyRUP+IK7/Bx5gX/AEs8zKaqSE=;
 b=serQmlLIe01mZ/Q4/bElvfh9EQf7ZBvIKcZy4qmSldLsvUS859MG0lwpZ6amaLkSp3
 uDJIkL+28oYOdcbODmN9PVgUBfF1NFIJ0Pr8yr4HOODW3jDzAI5hbQx/ZhGn1LPXtHDN
 Y7X0uuVB0zmqSs1qOoMWZOff5Y2sQqgKu3IQTwYs6HSVIAmc+Pfr2wrA/KaI4jcqOqO3
 t8TbqnqowaqijPSJDiZOrg7B9XHEENzZT+JjBvWjrnpCabOBrAkiO+DVEQhoXS7q22/O
 6PdULmvbzC5lG13RZEK7cYrqfnAlnzG/iQ2nBEXaCaJ84PpcomS+B7Bl6jR6UYLXMiar
 Vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469801; x=1705074601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDwxzH3vS9V/d1nX5dyRUP+IK7/Bx5gX/AEs8zKaqSE=;
 b=DUOOgbMMe3OgBnMi+cyrBOMGy1UDQk3UFDzweBXT4Piba4cr6mkJaZCKnEVGyBm6Ib
 0Q9Eh02sMV/z5dzJRaOXsagX2dEjFTJ3k8mA808FYV8gm8amLgPhaMMqD1dZLz51NY+e
 LWDPeBvqCx0gR5zE6ISNKeg/CVx7FlzZkvoJATs3eNBQaYjkH0kJJmtoEatamr6kSK2Z
 ayux8bZySfkkI+u4GsyEuRTdnYauW5GESTHUkihdAiIskBgWiUyhoqfMdBkIjdT1rX3v
 1mVFRCaRHjg96ePNDM/ZU33PKg3FuYBTCoJr4Nk/dK/1EQiM/r9vmNoZqRkseaP81JKe
 nmMg==
X-Gm-Message-State: AOJu0Yyk2kyammQrOLJwOdMo2JIOA4Anx+ah1nVIOwFam68fYDc6cpex
 2uPhkubWzjYgUTgiq384lAHxlhhFQHDZJoELL9nnf/7S/ys=
X-Google-Smtp-Source: AGHT+IHZhgpsMlbsYpnIF6g74vkVM44Ykg89QYw29B5DlHtEOAZm73Uhln07VdUJ0jn4/p0BBuuaKQ==
X-Received: by 2002:a7b:cd96:0:b0:40d:5821:5148 with SMTP id
 y22-20020a7bcd96000000b0040d58215148mr934968wmj.67.1704469801572; 
 Fri, 05 Jan 2024 07:50:01 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 b1-20020a5d4d81000000b00337405c06a6sm1621048wru.48.2024.01.05.07.50.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:50:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PULL 68/71] hw/pci-host/raven: Propagate error in raven_realize()
Date: Fri,  5 Jan 2024 16:43:01 +0100
Message-ID: <20240105154307.21385-69-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-26-philmd@linaro.org>
---
 hw/pci-host/raven.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index f71d4872c8..c7a0a2878a 100644
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


