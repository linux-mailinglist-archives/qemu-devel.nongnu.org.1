Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA1802913
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:44:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w6i-0006yc-8E; Sun, 03 Dec 2023 18:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6a-0006qE-3z; Sun, 03 Dec 2023 18:42:33 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6Y-0002jQ-2v; Sun, 03 Dec 2023 18:42:31 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d400779f16so19867197b3.0; 
 Sun, 03 Dec 2023 15:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646948; x=1702251748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=HKredU3O03Bo9duIfdvD9UTmAulAgkIh1b9DLKwtxOYbdZ8NGSMPeLxSYj6O6wJ7Om
 jGrlmigOOi5dktKy5XevEc24g9PEkepn4gISltxWjJI1i8Ad5sfwvvITtBu+mS0kzH1f
 HR874FV3h2NkI7/DoculgubqibjRTkE26+vtT1mfvqwd+XIlauWByTiwtBQlMQ34TZrc
 1aYv3S0MEMPRDyxqYj0LxxQm2ZrQ51BZaB1Yu0Z2LGhPCLcl4rNQhFJ4Di+Iywhh92sJ
 hxzVJTslIj+qwNqms0ceQhhhWkyXXb7Yq5YWosx99F67ZUN1FwP38QVATmfV5eJIjELg
 LeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646948; x=1702251748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=h849vR/pbjTzXf0kP13eQW0spELqY7veuSBEuNCX3ALw9SyieQLbekgSYL/1PKS4Bl
 nPIhwSGAKWFfu3H1a3p0Zm7mcanTLcWMEN8blvfZobHCPeOT5QT3YR39qMlkJ3XES4p1
 Uo0Tizj1iMFmZZckyPSokA+c+2Tm9u/L1Q7gHQbUKyRcmRuJV4VlIPvloiImZ2UII2Mq
 aXQNam+yqKa6RQ9IvY1vcaElKXXHWFSP3G6lr/VwjanC9+9/jUpzIwj7W550JhCgjt2R
 e1wL39ThhGnxsfXJIfVTnDmh0d3PzQ+bZALi4/GzGdtpNTUapm00UKPf3mytsMtN4q0b
 8Ecg==
X-Gm-Message-State: AOJu0YwxRP6a38zm0BLbst5c2V/JPjFaRCpVJuU9fEZloDpV8xmFydAo
 M8d8DJq3wpRimsQByUQo4Snb+ePNwJrprA==
X-Google-Smtp-Source: AGHT+IFcWi8EP+O/SUB1uZeRw+qVOqt1hjQnXoPqFeuX/YS4dGIQWoxqZ82k/U2JtnYLrrsOqZsHyg==
X-Received: by 2002:a05:690c:80e:b0:5d7:f227:55d0 with SMTP id
 bx14-20020a05690c080e00b005d7f22755d0mr904769ywb.42.1701646948201; 
 Sun, 03 Dec 2023 15:42:28 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:28 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 10/45] Add BCM2838 checkpoint support
Date: Sun,  3 Dec 2023 17:41:38 -0600
Message-Id: <20231203234213.1366214-11-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1130.google.com
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


