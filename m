Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919977F61B2
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ArN-000275-KX; Thu, 23 Nov 2023 09:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqt-0001sV-8k
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:47 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqq-0002Sf-AC
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:47 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c8880fbb33so12509531fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750322; x=1701355122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pOWYkpnIyztLHOzwZOLJUZ7Drb6F2CHVis+xLrcWw8=;
 b=L3qKQx0328ylmhzgiJSfH3QQoAKzDtOEzbAtaXc61OoOoUsd6nydro6xNZMetDRtCk
 n4ZkXQ2TJv9H2ghrwxkd0gLZVAp5VqOMx3U5Dz/WDk0d31gyDkFgqxpv/NDY4OMNkAnA
 AuqiDi+j6rXYoHPK9TIX+Yq//m5rnU3HOhZ6UqLXEptAaPLuZxPodmUnEqQ9Q598T1uN
 LWZnby19lv4xGV8mXGhMP6wBCTk+LIugzS6S4nXxsMqZTW3mWUWV8T1Pw5titUF9K01R
 kpgtjw1XrA22gZlIHCPXZcObIOlF0gtXSx0U8SC2tLnqIrF085hFjtdfj6Rw+6kE/qcc
 XmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750322; x=1701355122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pOWYkpnIyztLHOzwZOLJUZ7Drb6F2CHVis+xLrcWw8=;
 b=cAKw/Takw6bM89ZiBkjW3KFW1Cd/WwJ0c79JFqPrvlNBBa+3W441gIsQodMu4IA6wv
 M5JWkWR7aPfM5iZRVEurcAAEnOlaDFnbWTJawN7sOIDAk7g4YxAMiZ8abj0hGaC1WqPy
 amWJhV3PmQcQFnTa/ZyXcLO8TS8eq7MaLpOMXKTEt9j1Xr8lb+pgibsiYn1b5DZv+56q
 52zGzbGyjMEIOMtTkFCcuB9iMJbxE6MnUnEtaXSzK9MHJGji6JAZcsLS0snxrog7Aft1
 cSbR4ciUWrxy2s222809k57TNXc0juFmYt2ZbTrZdU4pMxzTUBfqwppuQhXv8FaGI9OW
 zNOg==
X-Gm-Message-State: AOJu0YwZxzQDwfdD9EaaHMDNRY6MZtsr7tvXbPXo/SNQoFcEg2MrHvvw
 X0EXEBQJMGRrXz2gdq3hTPT6uA==
X-Google-Smtp-Source: AGHT+IEN8p8oWi9ZHHDWNeMbIovntvWDsH8MUJMojP9vT0zjry2SU7j2fqXYwprj5EgN6af28BuOZw==
X-Received: by 2002:a2e:960c:0:b0:2be:54b4:ff90 with SMTP id
 v12-20020a2e960c000000b002be54b4ff90mr3797036ljh.53.1700750322683; 
 Thu, 23 Nov 2023 06:38:42 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c1d0e00b0040b34409d43sm2188494wms.11.2023.11.23.06.38.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:38:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH-for-9.0 v2 3/8] hw/arm/bcm2836: Use ARM_CPU 'mp-affinity'
 property
Date: Thu, 23 Nov 2023 15:38:07 +0100
Message-ID: <20231123143813.42632-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The 'mp-affinity' property is present since commit 15a21fe028
("target-arm: Add mp-affinity property for ARM CPU class").
Use it and remove a /* TODO */ comment. Since all ARM CPUs
have this property, use &error_abort, because this call can
not fail.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index a1bd1406e1..289c30e6b6 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -127,8 +127,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
+        object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
+                                (bc->clusterid << 8) | n, &error_abort);
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-- 
2.41.0


