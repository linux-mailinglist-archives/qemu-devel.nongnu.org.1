Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC157CDD68
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6e7-0007yX-Rm; Wed, 18 Oct 2023 09:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6e4-0007nM-1j
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:32 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6e1-0004l1-9q
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:31 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso70301451fa.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635887; x=1698240687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lu/LAV3gHNQX3jkZpzINwdsDxIlwSvdZerkbZ9OixCM=;
 b=Flwtg+G381XLPe8uX9Qnes0U+mWxW26DggCSREM3Om6K5MyyYaeaBEC4KFhWwp4WNZ
 MyFj2RuB8kPT01kvzn8K1a00GJQiVz2EdpuN61W6rRDopB0KCMcO6v/j3MwqkUAwnmcC
 1J8o/lR8FbNqXuPwKRQ5OyrULVq88Qpw/EtigmUlC7xl4PWylPLibS2Psa2S6VO4YzYf
 qDeOthmt9XeCCtBopzgpG69pCN1UiqWnKGoJbXMfnscUthf+RNABD+jT0Z8oo+YX73Da
 KejyulFn5c8HWFCfNlT3QjQKU4D+yT8pfY3TdfHgjWKtWqKiuzDcgrlGouHlXjxSKSOP
 M5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635887; x=1698240687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lu/LAV3gHNQX3jkZpzINwdsDxIlwSvdZerkbZ9OixCM=;
 b=NFgin2qaQa4qnZ2Xl6fVEmUKFO7gqq3qRAR/ZDt0RpZX2s8ZcS6NzFg94nhgttuL8x
 HDkAVZQhY4F/CNcCEWYS9Ik0h83m3jz5Er511Exjm0tYkFrrGcYmUD+5jTN9bTORRmbt
 WNZ5s5hXFDUeNFw7e3kxTht84K7Zh//QyAx940P73wAkpmNfVbdNKEHHt+my2qF9dtx6
 dqIaXk/uSQs9tcvfm36rWpUXRoYEnjqkRn5/ZlaM23OG2H2Y3cRP80QeiccOJ7ySC3id
 gvduwJ1o9vLM3NiwMQYH128lHrn47Zxb4G379VHhTJduUBSujPJl59iVcQSVj7VTs8x8
 C6nw==
X-Gm-Message-State: AOJu0YwTNpUHckA4cXxnyGO1bFi5amMMtJvRom9oof7fkDNwv9TQYg+g
 Ydho9wYJjmp7c7I4kARA05odxO/piGikelEhrI4=
X-Google-Smtp-Source: AGHT+IGIFCzR94M+GERBn5gvDvTexmVFoJjkQXqILgYsAGPeTOLKM2xlrb6NmZxLj4WqKMU5SqoILg==
X-Received: by 2002:a2e:b558:0:b0:2c5:1ad0:e306 with SMTP id
 a24-20020a2eb558000000b002c51ad0e306mr3437827ljn.8.1697635887546; 
 Wed, 18 Oct 2023 06:31:27 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm1709424wms.46.2023.10.18.06.31.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/ppc/pnv: Do not use SysBus API to map local MMIO region
Date: Wed, 18 Oct 2023 15:30:57 +0200
Message-ID: <20231018133059.85765-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pnv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 10158f7684..c0e34fffbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1217,10 +1217,9 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
 
     name = g_strdup_printf("icp-%x", chip->chip_id);
     memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
     g_free(name);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
+    memory_region_add_subregion(get_system_memory(), PNV_ICP_BASE(chip),
+                                &chip8->icp_mmio);
 
     /* Map the ICP registers for each thread */
     for (i = 0; i < chip->nr_cores; i++) {
-- 
2.41.0


