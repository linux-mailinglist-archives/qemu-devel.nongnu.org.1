Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E522F7C5D51
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeRH-0001HY-Kv; Wed, 11 Oct 2023 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRD-0001H0-B9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:07 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRB-0006nb-3l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53b8f8c6b1fso396002a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697050803; x=1697655603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95NXK9svro6UdjqzIzFp76/dqqWwIIEkSGDMLJ7hSbk=;
 b=YtEN4ryTGNfhG/2xb36yFPQD8ETa7d0Q0PK8I42HIVl7rDuCZgShq44+00X8h4kr4K
 QxPaoEMw0vGmlz62ZH0lnTuBRwfwshWLbUpRl8wcyTK2pr+KsaO+gF9clUaCM2vR+BFi
 9QiAxSOsZ1GdjtMizzaPKGWN6Tog8phOh3GUv36WJJQisOwW3Ftgt2wyK40oNIHxA4fA
 T8V3DjPUv7DHf3Qbl6e3M/zRIa1dWGj+x+WRBsl3a/vIv8OXHfl31pqcZVIPIPn7U1AI
 JM/XlxiSZBNGfSBU8lwP1I4bSDOm81rDNfEAvP5ENZ2qxDcpuph30k+FNX8muug1T4BD
 I+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050803; x=1697655603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95NXK9svro6UdjqzIzFp76/dqqWwIIEkSGDMLJ7hSbk=;
 b=tTzAhBDWZizoVUFxqNxK/SSZq8ZpL07jWaFtAXicwPoQvAdjrgBk4HyqkK2RuDi4ly
 02t2HvP3GWv6nMHrd7J6LHjHLdve11dbows/9mWtnZMJrxpUUcBNzHClCtOIWhVuj1NU
 WqnqJbSPFWNGWW5EQ3z7CmY3/Y8F/Gg7dZtYesHzaNvjlpgDBOXCXWGA+DHKMrh4pji4
 rSu2RTTeym27Q1z291rWYlfKpHeffORWTbp61UkN5sGUbxfWmXGyq1/YkeCsRnVsnU+d
 cJ0sFga1eP9PK0IUCJpJlg31lgWlUcNB9tLFZUbx7DcM3p47Td+DB7jrfx3nbKrqZTW6
 AvEA==
X-Gm-Message-State: AOJu0YyzrfK0K9c27y86pVflhdSenYWfARtE4tA0paVmjWTVZbxrYczn
 baq4+KLSRLRq2wmdLRjjJQnBSwtaOaUUpGvzOA8=
X-Google-Smtp-Source: AGHT+IEk9oOscv/3qH77NnycbqUsZAzX3z3XiPKXRafQcjhBH/UfRFuFepHmZH9vtdXw3Uz5zZs0Eg==
X-Received: by 2002:aa7:c409:0:b0:530:a925:77a6 with SMTP id
 j9-20020aa7c409000000b00530a92577a6mr19319492edq.8.1697050803034; 
 Wed, 11 Oct 2023 12:00:03 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 bm15-20020a0564020b0f00b005346925a474sm9218292edb.43.2023.10.11.12.00.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 12:00:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/4] hw/isa/i82378: Access memory regions via
 pci_address_space()
Date: Wed, 11 Oct 2023 20:59:51 +0200
Message-ID: <20231011185954.10337-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185954.10337-1-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

PCI functions are plugged on a PCI bus. They can only access
external memory regions via the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/i82378.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 63e0857208..95b45d0178 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -76,7 +76,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
 
     pci_config_set_interrupt_pin(pci_conf, 1); /* interrupt pin 0 */
 
-    isabus = isa_bus_new(dev, get_system_memory(),
+    isabus = isa_bus_new(dev, pci_address_space(pci),
                          pci_address_space_io(pci), errp);
     if (!isabus) {
         return;
-- 
2.41.0


