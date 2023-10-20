Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA37D0DFC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnAL-0006hr-9U; Fri, 20 Oct 2023 06:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnA9-0006Rs-Kt
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9w-0005IX-1U
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4084095722aso5578335e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799314; x=1698404114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWScBDjhmHe2mIRuU7IlnubQFDWtVdx50nOIOsC9Br8=;
 b=PvhVKT4R9ZlEcbhh+y7D3uPQdwy2b0Hr3MaGAUbAn+aWnuGb7+yo5iRrBHyTvloEyV
 8S8bV6ooJIxdJ5m7EX+gOuvWgA8Mfu+W/L5hiQdpjqqyva4wuYF6nHhAiUhnhZsuDoVN
 7X6Mo/9PqO8njxoQJCuhou3cHc3nNc0Ods4OgLRf4uIajg1o1Cba9t8T0fU50x23x2dX
 34ONIz19Da9JYJ4NTE7QWEtzLF1sx9qvYkYz28/+M/+xpj727ysIbgri11Q0OMHK2dk+
 erlCzylYN3ZaFTmCCEthOzVnX0vfK5jn2+CskWE4acpLyOY5ubrb/uMOIykCl+VBbKH3
 wLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799314; x=1698404114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWScBDjhmHe2mIRuU7IlnubQFDWtVdx50nOIOsC9Br8=;
 b=fsX+Ju0KK1ztyTwnF3Kr51gmRGcxlcmXf8bRes16ay4SPlowd2/ylImFBOxRsZMZSR
 T1uBgMyY7UjFtziOJQHoAYZInOuEPeBK+gwo/glCN5vcIGgpWAe2xE3Tx5BHoAnJj8Ue
 46uyPoyNgYCSVCZNaXDFdm98u0M4ccKTHXOh8NTLWGtFgECyDArO/vVeH13KIbL2PeUr
 KKRaW+j3JGnOEueEh/aXnKwD+dNqWBbrugAlqIVswWZ2mf4QmBR2szbYilFI1i/SKVN0
 dVswOuFZG088qOtSk2tGqDpvmUFsq8O2OSAVV4wZnUe+1WnzVqh4S2gu6MXoq0kevN52
 hv3g==
X-Gm-Message-State: AOJu0YywLiLRJVkM+eqphVfd16//DDK5Tj26C1cFNc0ag87aA07snnKR
 27TxCBKazySZ1kbggdEehLJr3K7+q9REO6oX7DA=
X-Google-Smtp-Source: AGHT+IHvpbA8OgwqrA4KhQLd9++FF2V13Bl53FUMz5QHZWoP1u8cMGg9oxqfmT9btKYb5MEFTdi9qg==
X-Received: by 2002:a05:600c:a44:b0:407:5185:192b with SMTP id
 c4-20020a05600c0a4400b004075185192bmr1136572wmq.36.1697799313939; 
 Fri, 20 Oct 2023 03:55:13 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 fa10-20020a05600c518a00b004064741f855sm1833486wmb.47.2023.10.20.03.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH v3 4/5] hw/isa/i82378: Inline legacy pcspk_init()
Date: Fri, 20 Oct 2023 12:54:45 +0200
Message-ID: <20231020105447.43482-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
References: <20231020105447.43482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/i82378.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 63e0857208..203b92c264 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     uint8_t *pci_conf;
     ISABus *isabus;
     ISADevice *pit;
+    ISADevice *pcspk;
 
     pci_conf = pci->config;
     pci_set_word(pci_conf + PCI_COMMAND,
@@ -102,7 +103,11 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
+    pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
+    if (!isa_realize_and_unref(pcspk, isabus, errp)) {
+        return;
+    }
 
     /* 2 82C37 (dma) */
     isa_create_simple(isabus, "i82374");
-- 
2.41.0


