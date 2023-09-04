Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB2791B32
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCr-0002rj-VQ; Mon, 04 Sep 2023 12:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCl-0002pp-9L
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:35 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCh-0007Zx-4L
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so2047625a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844009; x=1694448809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0uZGrdkSgs5HoqGdgWfurGjAeEUVFxD0ugElwq2vSc=;
 b=fGaeBDz6BeK83pMOfPUigZjh5JMCFiUrnDcZu91OGQVK3L9LfOqh6DDuR9eICEhjii
 9o1EgJqhSmhbYWJpN/93/gPIGGDsRubRsB9/Xeclw8YMaBaQL7vr78zXc7TJh2aqJT4N
 ZcRbbLNAG0pOEm6mfmnOw1YtrXaNKI484PrMtc5JO/aEhvlczf0LLzyxn9+USTW1k+jx
 mDbxcU+O3wUMpKPMvqwEB56UjMDg/vFSShhjTWqr5bmHPkVvHSpq+tSjO0+6y9HHxNlT
 2sPqmqRbn+wNgaFwG92uoyJYbjtEuxe2foR9/d9iZ+Dhu02sVfo1sdfizVw61yy39wtG
 j6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844009; x=1694448809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0uZGrdkSgs5HoqGdgWfurGjAeEUVFxD0ugElwq2vSc=;
 b=kV0kfsbI9iiocRrJP1cYcBYDtRjPb9UDE/A/IU6HAeJD5Oh4e3hf2shmBdGx1gC2/2
 D/3zBLV+8oc2AYYLK6ljxlrY8RLSM14ryUNbC64nlLYZOGcsqECsmamyT77rQ1t8ngCG
 NMqCrUEPRAKlw0XW6lUN3/BDWhhEMkxzF934L7HPd8U2AoV6c4HqpDa1BM1gwSEJV0qQ
 Iw/dvQ+28Ig7vytevyDa0V6A82fNIj4bdQzm+B6QmlvtWo1jJWCT6qPyz8Z8ljpJoqxz
 +MibViDsL4OkPlj7/zLhCBnpP73Q/ENnbz/EX5gwd5Mdh60O0PkRlAGcHWJmItqJE/9b
 Q0hg==
X-Gm-Message-State: AOJu0YyOxAZz/EfAiCp8a/wmvU7ImsohZaQjVrTeyvJ5r8FhbTt7NWli
 g428/dSOHuQdIv2ZwMYONB6FyA==
X-Google-Smtp-Source: AGHT+IHUA3rONFS7VEh5z+UJ5vSZqxLkiY/qA45lbN73k2C8+T3RcvbVMY71kY9d7dk5cN9l/lWXMw==
X-Received: by 2002:a05:6402:2b9a:b0:52e:585a:e94 with SMTP id
 fj26-20020a0564022b9a00b0052e585a0e94mr464702edb.2.1693844009181; 
 Mon, 04 Sep 2023 09:13:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a056402074b00b005231e1780aasm5959553edy.91.2023.09.04.09.13.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH v2 09/22] hw/arm/allwinner: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:21 +0200
Message-ID: <20230904161235.84651-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Fix:

  hw/arm/allwinner-r40.c:412:14: error: declaration shadows a local variable [-Werror,-Wshadow]
    for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
             ^
  hw/arm/allwinner-r40.c:299:14: note: previous declaration is here
    unsigned i;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-r40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 7d29eb224f..a0d367c60d 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -296,10 +296,9 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
 {
     const char *r40_nic_models[] = { "gmac", "emac", NULL };
     AwR40State *s = AW_R40(dev);
-    unsigned i;
 
     /* CPUs */
-    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+    for (unsigned i = 0; i < AW_R40_NUM_CPUS; i++) {
 
         /*
          * Disable secondary CPUs. Guest EL3 firmware will start
@@ -335,7 +334,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
      * maintenance interrupt signal to the appropriate GIC PPI inputs,
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
      */
-    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+    for (unsigned i = 0; i < AW_R40_NUM_CPUS; i++) {
         DeviceState *cpudev = DEVICE(&s->cpus[i]);
         int ppibase = AW_R40_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
         int irq;
@@ -494,7 +493,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
 
     /* Unimplemented devices */
-    for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
+    for (unsigned i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
                                     r40_unimplemented[i].base,
                                     r40_unimplemented[i].size);
-- 
2.41.0


