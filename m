Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E64AE7CDD5F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6e5-0007qi-O8; Wed, 18 Oct 2023 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dy-0007hr-VP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dw-0004k5-2Y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so5321022f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635881; x=1698240681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/OzLFcKSh0UPM5Lh64d1MpdKJAnWvLj8FsUJLUNjvo=;
 b=VYVsTTWeNDrE4l/vtCPuXX8NUI+4C6lNbImc9WVJd3Jo5YZIuv8vCPlbXWdCsQC6Dz
 sURxUyujmp1aE73D+fy7CT4L/8Xq2A6Jwg9KNSdANG0mREhanQi7PGKS9Y7rSy3d8Oa3
 MONCTX/Jp5oTKKLa+niQ+AQ1Y5mPq3f0/78eIwRCdMVbDRrpNuBLEwIMTfqhvro8N4/F
 fWtOjVGE0GyJsCFiTZ1FrJbk1vnv5s1y/i2Td1WFV36wHmPZi85PF6p1fjNZPvM+DpuF
 3YiEyj10B4TzNZqIxOBLcBqD7ZZOIBjMldftpTEOUCNutdcihyHDzfP5AAQN6l3MB/By
 Fh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635881; x=1698240681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/OzLFcKSh0UPM5Lh64d1MpdKJAnWvLj8FsUJLUNjvo=;
 b=GbKuUx6pm8HO27rrbOFWzmQ3Ugch/JHlgDuhdgoddAb2Gy1u7VdSO5SuDw3TTiDlw3
 J1PppEptUKjqTrfmENKBjFhohwI5LMDw2EP+hoFx5cvYDksgy19iCfs6R97CHTwUvcsd
 2K6Ra+Asja3aAtU1blmLVDgv5smg597tOOjlRYIOsMhz7Y5fXBnoSBtzwIP9YtTaeMNW
 TKKdud4hCaLECTSNZKgVoWUei0uKu+bW67p9vJjzazeagqrTcgeQHWrMtyxzROXCMcKl
 wfsrFXExQAyz2FFOEwgGmmdtp4EdVzEzYzfY2cP5K+5VQ2ndKmwLaPoeIWrjggJnGwih
 cn2Q==
X-Gm-Message-State: AOJu0YweSKJDy8ZpfNj/E+nETEtR4faoRFz9b03ohWnwWaqyGANBh7CO
 7//O3CCyVnEaLc5NHZ3hnOkE3EfyHkAYbw6kFHE=
X-Google-Smtp-Source: AGHT+IHsgV4PzEBsYH1psVLwaff1VJl3OmiviOP4eeuhxOuFo1IIuUZpLReUOyt8uDoVUQI9Jp/36g==
X-Received: by 2002:adf:f982:0:b0:32d:b06c:80b2 with SMTP id
 f2-20020adff982000000b0032db06c80b2mr4791674wrr.0.1697635881371; 
 Wed, 18 Oct 2023 06:31:21 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfcc8e000000b0032db1d741a6sm2128974wrj.99.2023.10.18.06.31.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO
 region
Date: Wed, 18 Oct 2023 15:30:56 +0200
Message-ID: <20231018133059.85765-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pnv_xscom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cf892c9fe8..805b1d0c87 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -223,14 +223,12 @@ const MemoryRegionOps pnv_xscom_ops = {
 
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
     char *name;
 
     name = g_strdup_printf("xscom-%x", chip->chip_id);
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_ops,
                           chip, name, size);
-    sysbus_init_mmio(sbd, &chip->xscom_mmio);
-    sysbus_mmio_map(sbd, 0, addr);
+    memory_region_add_subregion(get_system_memory(), addr, &chip->xscom_mmio);
 
     memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
-- 
2.41.0


