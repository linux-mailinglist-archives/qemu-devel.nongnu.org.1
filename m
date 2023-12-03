Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E680282F
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:55:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLQ-00038E-MI; Sun, 03 Dec 2023 16:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLB-0002tZ-Gz; Sun, 03 Dec 2023 16:49:31 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uL9-0008KM-V2; Sun, 03 Dec 2023 16:49:29 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77f0316bc7cso97757485a.0; 
 Sun, 03 Dec 2023 13:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640166; x=1702244966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=lxzaWKbqMc2GgHe2frQu2yWq5ntawF5Knyz65ApeuxxCDeq11dQp9+34Cg4NLi2+U0
 jNTEmET4tpCaZHCAp8zZoauTDDhlJesdlMzImRjczPyYjiwPxo9sfXVQPYYQs1O3cxWZ
 skad/54DhJrNCd9DZE4+K64+J8cif6Mv3na2L/FxslJhuE7gw4mMwxTniEquQsGVvXsh
 6x4H1C/KjZKiUw6VmNdc63pct4VHi52fIwoMY4J/Tin5cYDcNg6gTYoRmHwgfsx/OcO6
 16OlfRArHwVcpYRtaPdSDmjXAJHmjEN7SOGd/eoiSn5p8L93NT712DQT3t4KSjpEC2gn
 +EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640166; x=1702244966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=tzPUh9qxLXZ/PW8PzspYZdMgToXkRHSWPn5Bwnv5YeAjwFPKh6N/ib1eo5Um4LCfNL
 mTmTJn3v3XYu1wptsai8QwvGR6V7PgqHHovvjuiJmEIrhTuGAFXC38LSg1Uk2DTxI4Y3
 ZBT4peGXdZ/PiJPXPdZWNc20sR9Zk+Vp6O23+YPfw/C5MqDG41fvaxzoeOzdMbY2+B3K
 nnLcGFDaa9Oi2utRoM41Agw0CqsxQDj4CMFScSj8OoM6EIajGFd7V32ULINKJcEQ3biS
 HSnKmpmGHKLo5JaQJ+c/rwq83cgRdfQG7rYYWHftxhUgo6xL3bfaiO01uFwBoeVZJ30j
 9CZw==
X-Gm-Message-State: AOJu0YxukIubRJMp3obauwJc3/VTFTztAmXfCTZx2TEIOTLMlqXekoB4
 x5sNz/LWM4vm561bdY1G7d5Y9rLDQTlhRw==
X-Google-Smtp-Source: AGHT+IHBblRZXRruBQ1yMzNWMnV/xyOZ/iB7QIBAS87UmjzyuowEmFDNUyCjAgTHqVfIwqz0zPFpVA==
X-Received: by 2002:a05:620a:8591:b0:77e:fba4:3a12 with SMTP id
 pf17-20020a05620a859100b0077efba43a12mr3526488qkn.104.1701640166217; 
 Sun, 03 Dec 2023 13:49:26 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:26 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 10/45] Add BCM2838 checkpoint support
Date: Sun,  3 Dec 2023 15:48:35 -0600
Message-Id: <20231203214910.1364468-11-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-10-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-2-sergey.kambalin@auriga.com>
 <20231203214910.1364468-3-sergey.kambalin@auriga.com>
 <20231203214910.1364468-4-sergey.kambalin@auriga.com>
 <20231203214910.1364468-5-sergey.kambalin@auriga.com>
 <20231203214910.1364468-6-sergey.kambalin@auriga.com>
 <20231203214910.1364468-7-sergey.kambalin@auriga.com>
 <20231203214910.1364468-8-sergey.kambalin@auriga.com>
 <20231203214910.1364468-9-sergey.kambalin@auriga.com>
 <20231203214910.1364468-10-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=serg.oker@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index c147b6e453..196fb890a2 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -22,7 +22,7 @@ static void bcm2838_peripherals_init(Object *obj)
 {
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
     BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
-    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(obj);
+    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(obj);
 
     /* Lower memory region for peripheral devices (exported to the Soc) */
     memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
-- 
2.34.1


