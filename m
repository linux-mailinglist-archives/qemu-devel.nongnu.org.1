Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF07CFAB8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSuN-0000ms-3b; Thu, 19 Oct 2023 09:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStt-0000Dp-W6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:29 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSts-0003nq-A9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso13920672a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721438; x=1698326238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRgAKCtq8bs3zdxIMikNghO5SYRHJ/8vyzXAPjSdrHo=;
 b=mZevWkHWEBeYT7H9I8PIiSLyUE5pb3x8y+2YNZv5qwuY2OLKNfUYZ9ySrjUSfQBBJS
 iV3RQKrCn2awbSNut69Vdj5dEimdZDo9cj6rkz363oOjAsSFL67+2MdzJ6y5Z16SHnCd
 bO0IR+EuGwqkb/2MgxgjhsDYyjpwnyEQ0OoTQcECmsdZ6z44hwNM0LQ9Y+rS8jhVBd9F
 RP9goknSi2rs4lNT0siAxmv2BTER0mgzJSrnW7Q6DrJniKsqZb4sNw5OTW8vkf4oZlYv
 atnl22JUkqy+KbJlOR9FRq8+ij6SLtYgb1F59YZyU4iTWsF88tc+VvoVw1TyVJkwqFRD
 SHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721438; x=1698326238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRgAKCtq8bs3zdxIMikNghO5SYRHJ/8vyzXAPjSdrHo=;
 b=k0BCEoKvJF2jEm4VRAFS1XzJsnYgkuS2i929+zRt7H8YAnwms8CfiLAMNCpFGCLzZy
 P4/NC7h2QL8M9LYki7ILeR5GxIo/6lH0JMdD5JdoKgBBODJf3NfDsmml/jN74jvtZ44D
 7EkFaf45G9Fdy8UMGFkv+96oycRlYNJOe1DqsCdEkHqjYO5zMLDeACW93R7Wju4b0yJI
 ljbdBZlZv7HUr4Sc4CiCsISTHB1gUoO5ht/XxFD4PHPOhkoKSaltX7kTXG1owVDR1XzG
 7TmfzWP5XnnRm8HER6ZQMXuLrm+sDqyvPemihd7/KGYGAfDmF480y9sjblpi+WP/wJNp
 ydeg==
X-Gm-Message-State: AOJu0Yy18uT/tCcvGpuxEZR8fgnOGdh2uU6IT+PuGTeEwR541YiwcXil
 RUTDK/OyiQ057njt6aN9y7iz7cDvJJ+bZjFv02l+Fw==
X-Google-Smtp-Source: AGHT+IGHBsTQn8chnZ05vBAm8OA+DgjZE6BXmfM0cTspS3pAJSQ5u9fe+gVrjSPBnwFcTDlw7tcSBw==
X-Received: by 2002:a17:907:745:b0:9bf:1477:ad82 with SMTP id
 xc5-20020a170907074500b009bf1477ad82mr1960583ejb.76.1697721438491; 
 Thu, 19 Oct 2023 06:17:18 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00536ad96f867sm4489928edi.11.2023.10.19.06.17.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:17:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/7] hw/ppc/pnv_xscom: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 15:16:44 +0200
Message-ID: <20231019131647.19690-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
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


