Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076178EE4F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhL4-0007VV-3B; Thu, 31 Aug 2023 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGs-0004ga-2o
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGn-0005zQ-4s
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so595246f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486768; x=1694091568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Occ8BC5H/FvkONSrz36OUIh3zPM4NWg3GVGnui/y/PY=;
 b=vV04mWAPJeIR0CGQpZ3qrfQ58XeCAoG0Ny49MobdXAFE6LarKEXdLOmdqe92uyxVxw
 qVSkAVRTrQEA3vxp9QGGcjUaIRbkNb5ia/TCBBxuVYW7EZf5Fvkw0fnOViRbhUphY1gf
 MaguKATs+C81+SC/r33L3Z695he65Iz9gq/uvaKiEjpySStT0UwcUQ/KJ9n7DMtLG/Dc
 Hymiiee2keG+jkvTxirknxquATr2y+vv0IlAbMcq5+/OXTmMH8cReexa1veXEh0dz51P
 qIv0czqYfuBnMyMPOuE1mzKUqzp237XHhGe/dhMQ5o45X9/SkJdsPdDMcqyFVtbg1Cpx
 7wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486768; x=1694091568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Occ8BC5H/FvkONSrz36OUIh3zPM4NWg3GVGnui/y/PY=;
 b=GpbtfV/gOdWMo+GhA8p/wjNfTc6CJU+UJ17PMRiWlIHGwF5bc3g8eSteDj6TbxtVzo
 s/8Icy9bUY8V4Ij3lmSesD5AV5n5DPtfmRiZAsqaG+VTo3eEUzuIzjXwnmesv0fcWmNc
 li/jFzmpw63Z37h0yUI+LxadhYA2x1C9Bfmgmz3yS7PtvkiQ2NznOGFWjNkMyOuS46iT
 M4gN86m3Vb/yB8nFkz1XyO5DgSM/7T3ItDoTqGVKtERfe90Hu/6f0kCT4Hq5WSGguPuw
 Iyesq11cL21u3vQCYXVUdhlWfrGD22qdzFjP++epJHx8Vx0LNQee41+/meBQpg7MWyA+
 k8fQ==
X-Gm-Message-State: AOJu0YyXInsLtJbgbOXCBYWN2v1VTQtMBNImFcFLA2E38HYpK4nXTHIC
 sDyIvF8e1XPWtsZKSV/3L3NXIUoCzduBQccbOOw=
X-Google-Smtp-Source: AGHT+IFSVDt/P5yNxkajecZs4wlfAieIoaOSAgAAJDNxaau3QVZt9rEOGXHa3vptW3RStl32iijQ6A==
X-Received: by 2002:a5d:6706:0:b0:319:63f3:c0cb with SMTP id
 o6-20020a5d6706000000b0031963f3c0cbmr4341696wru.40.1693486767862; 
 Thu, 31 Aug 2023 05:59:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c025000b003fee7b67f67sm1901789wmj.31.2023.08.31.05.59.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:59:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Titus Rwantare <titusr@google.com>, Corey Minyard <cminyard@mvista.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PULL 26/41] hw/i2c: spelling fixes
Date: Thu, 31 Aug 2023 14:56:28 +0200
Message-ID: <20230831125646.67855-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20230823065335.1919380-14-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/npcm7xx_smbus.h | 2 +-
 include/hw/misc/auxbus.h       | 2 +-
 hw/i2c/pm_smbus.c              | 2 +-
 hw/i2c/pmbus_device.c          | 2 +-
 hw/i2c/smbus_slave.c           | 2 +-
 hw/sensor/isl_pmbus_vr.c       | 2 +-
 hw/sensor/max34451.c           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index 3555e6836f..dc45963c0e 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -58,7 +58,7 @@ typedef enum NPCM7xxSMBusStatus {
  * @sclht: The SCL high time register.
  * @fif_ctl: The FIFO control register.
  * @fif_cts: The FIFO control status register.
- * @fair_per: The fair preriod register.
+ * @fair_per: The fair period register.
  * @txf_ctl: The transmit FIFO control register.
  * @t_out: The SMBus timeout register.
  * @txf_sts: The transmit FIFO status register.
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index b05799d2f7..03cacdee42 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -106,7 +106,7 @@ void aux_bus_realize(AUXBus *bus);
  *
  * Returns the reply of the request.
  *
- * @bus Ths bus where the request happen.
+ * @bus The bus where the request happen.
  * @cmd The command requested.
  * @address The 20bits address of the slave.
  * @len The length of the read or write.
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index d7eae548cb..9ad6a47739 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -1,6 +1,6 @@
 /*
  * PC SMBus implementation
- * splitted from acpi.c
+ * split from acpi.c
  *
  * Copyright (c) 2006 Fabrice Bellard
  *
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 8bc9d5108a..cef51663d0 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1626,7 +1626,7 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
         break;
 
 passthrough:
-    /* Unimplimented registers get passed to the device */
+    /* Unimplemented registers get passed to the device */
     default:
         if (pmdc->write_data) {
             ret = pmdc->write_data(pmdev, buf, len);
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index feb3ec6333..2ef2c7c5f6 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -2,7 +2,7 @@
  * QEMU SMBus device emulation.
  *
  * This code is a helper for SMBus device emulation.  It implements an
- * I2C device inteface and runs the SMBus protocol from the device
+ * I2C device interface and runs the SMBus protocol from the device
  * point of view and maps those to simple calls to emulate.
  *
  * Copyright (c) 2007 CodeSourcery.
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index eb344dd5a9..e51269f6b8 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -101,7 +101,7 @@ static void isl_pmbus_vr_exit_reset(Object *obj)
     }
 }
 
-/* The raa228000 uses different direct mode coefficents from most isl devices */
+/* The raa228000 uses different direct mode coefficients from most isl devices */
 static void raa228000_exit_reset(Object *obj)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index a91d8bd487..9db52ef677 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -734,7 +734,7 @@ static void max34451_init(Object *obj)
 
     /*
      * get and set the temperature of the internal temperature sensor in
-     * centidegrees Celcius i.e.: 2500 -> 25.00 C, max is 327.67 C
+     * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
     for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
         object_property_add(obj, "temperature[*]", "uint16",
-- 
2.41.0


