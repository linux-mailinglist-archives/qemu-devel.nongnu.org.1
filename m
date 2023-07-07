Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34D74AFDE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgd-0001sl-C1; Fri, 07 Jul 2023 07:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjga-0001qK-HS; Fri, 07 Jul 2023 07:31:41 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgX-0006WK-Jz; Fri, 07 Jul 2023 07:31:40 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b5d7e60015so1678129a34.0; 
 Fri, 07 Jul 2023 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729496; x=1691321496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3qzxIMecmb5azRaXKLvfbWMLaYzjXfeD9/Llgvh8Cs=;
 b=BenkYs1v1MoOaVWbW0h6uNrWW6gvrMwTxFWIQnpkhdLFnMiYyqCgJsPIkUh0x1VBA+
 ajjKBksy5N9KCXu8otLvpx+Yn995n/a5kqHdTCjq89BR+r/LTWyWhDM/yoWYefukbF40
 8pnI0l3a85I/AQJH+hYT7FtU3X1JMuyH6CdgFT1SN3wAo8eh0Z/aRyZInZcXHTFHQWR4
 M6LKQ2YZMclFxAzmBxSyxEf6ubETxTdK0/Z+3pcfHgSNDrQo6iOQNZiFkzbXbxBNt8vV
 xJcePrD8vqwMaIsOTlU3LNSi6jfLucEV+1+4VUY3e7vJ5q1VxCRvi4lX5EdcFmPHxD4l
 6OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729496; x=1691321496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3qzxIMecmb5azRaXKLvfbWMLaYzjXfeD9/Llgvh8Cs=;
 b=GFDD8BYcGtWgePHNJcvBLECycwRSBzAMcPk1Cn71Oabwjkm+UeFJw5DFDvAVQKPKhq
 k0XVK/V1xATXXEB72ffREuI0FIpRrIc7OWFQZwhOmdFGkkqVo2Q6YfwpyPHOijtaJLwK
 zFAN7ehTfjVf4U/O6lcqMliDW87loW5sSxdCphTVbgQpW21ak0SalyiVJ6D1fkQcqXYr
 gtnjGiY+xWtle8D8PqC0OZUNPN8j6NEp6gEHUBQykVG93VS2++J03ZMyrPalAwwlcbzS
 3Q4KomAusICiNknKnv9beQa/byPWXIdcH5CTGYVhimA8p9BqmsVZHQpX2NObR1Ui+Dzc
 XsNg==
X-Gm-Message-State: ABy/qLa7nKjdNt3w4V48K1q1+IzIOEqzGgcf8DfWbDT8fr3q7TwMH/on
 rQLxEk2SmHihMg3tK4O16Ufa8lt8KXA=
X-Google-Smtp-Source: APBJJlEyCAqMRFjS3OEWXg02EzwvOtoIrroP7/wNRgGPTRzAoffIdBrt/248TOQwyRWE18ltsRjsow==
X-Received: by 2002:a9d:6451:0:b0:6b6:9f34:e9a8 with SMTP id
 m17-20020a9d6451000000b006b69f34e9a8mr5547386otl.11.1688729496074; 
 Fri, 07 Jul 2023 04:31:36 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:35 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 05/60] mv64361: Add dummy gigabit ethernet PHY access registers
Date: Fri,  7 Jul 2023 08:30:13 -0300
Message-ID: <20230707113108.7145-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

We don't emulate the gigabit ethernet part of the chip but the MorphOS
driver accesses these and expects to get some valid looking result
otherwise it hangs. Add some minimal dummy implementation to avoid rhis.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230605215145.29458746335@zero.eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/pci-host/mv64361.c | 6 ++++++
 hw/pci-host/mv643xx.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 19e8031a3f..01bd8c887f 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr addr, unsigned int size)
             }
         }
         break;
+    case MV64340_ETH_PHY_ADDR:
+        ret = 0x98;
+        break;
+    case MV64340_ETH_SMI:
+        ret = BIT(27);
+        break;
     case MV64340_CUNIT_ARBITER_CONTROL_REG:
         ret = 0x11ff0000 | (s->gpp_int_level << 10);
         break;
diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
index cd26a43f18..f2e1baea88 100644
--- a/hw/pci-host/mv643xx.h
+++ b/hw/pci-host/mv643xx.h
@@ -656,6 +656,9 @@
 /*        Ethernet Unit Registers       */
 /****************************************/
 
+#define MV64340_ETH_PHY_ADDR                                        0x2000
+#define MV64340_ETH_SMI                                             0x2004
+
 /*******************************************/
 /*          CUNIT  Registers               */
 /*******************************************/
-- 
2.41.0


