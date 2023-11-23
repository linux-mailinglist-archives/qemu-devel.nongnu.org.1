Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF07F61AC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Ar0-00020T-75; Thu, 23 Nov 2023 09:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqm-0001od-Fq
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:41 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqi-0002RU-Sw
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:40 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso1326275e87.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750314; x=1701355114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77fFdvJTmm2pNTXteaORtoV0izbQYF6N9SGikVs/zTs=;
 b=hsUBkAF15u2tF6OaS0hC6R0TUs+duo0yNyVuE+uBDj02b3LY9nm2WDm7BjuNN7uxZ0
 xGg8Ja7cPXljTX6Axmxqwmb1BIFHVnvTI7BugnD/5SIiO72UZvXpuAR6flM7Za8X8YE0
 G0au7mLeFJKbiKhMgAQgOk/yZdaq8NJOrFIFXEi+5IunjSffwPY7Un7hyyNy6FPtdzMb
 xnxTGzmJXaFyHXjsbyF7DwF/uTwWFU4Dt+2bDaryx84TlJxWfCBXOR/KT7drc9ty8xPS
 VURozB1UzQ1RoS5lsvZE72UjaMlMldoQCDDvhrvzz27a9poDcFseJqsr4UPbCTmSLk7J
 0ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750314; x=1701355114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77fFdvJTmm2pNTXteaORtoV0izbQYF6N9SGikVs/zTs=;
 b=hF2e4o47EISeqak5YqwfMWIZlaBz+8faPJQGnx5w7q04431VRfXuzqII2g+gmWW4xy
 RRitD6pIZvq9WS2EIkuvwNU4o3yYdtqzaZp/rpyUgM3+h5cvV4vgNiVkbzwyJV8B1Xek
 G9ZlwBqwx6raQkib86dZy3vACL2ZvwLX+LyRTSwUn7lyABH8IKP8QxXSsHkVgC22Zny4
 QntAZUVASxo1wyL6YgqXMmVisH6DjCSYeL/DSQsRr3hhKekLSx2Ffq82XNfJDDYg+tHV
 MEX7Ist9sluDAKvb2lTJmQ358/WGmtR4FPp3mC1N1zpM0pBdV/oKR5309gHNEZeUzuK/
 KhEA==
X-Gm-Message-State: AOJu0YwIe85zu8Kco23HGKbuaqZv2xRwVupr8u+uk5gW41ZDlhmw1KtR
 7h5w56htDj0C0S3Ym1/JZCgkOw==
X-Google-Smtp-Source: AGHT+IHbXqTFASZF9Pt3So9OvTYn+FgWv3Pi+XqIsfiHaLOmxK/IaoO8oRPSYUlieK9SzED+rzMRuQ==
X-Received: by 2002:a05:6512:4894:b0:50a:a9ec:1897 with SMTP id
 eq20-20020a056512489400b0050aa9ec1897mr2523896lfb.35.1700750314699; 
 Thu, 23 Nov 2023 06:38:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a5d5258000000b00332c0aace23sm1817937wrc.105.2023.11.23.06.38.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:38:34 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 2/8] hw/arm/bcm2836: Simplify use of 'reset-cbar'
 property
Date: Thu, 23 Nov 2023 15:38:06 +0100
Message-ID: <20231123143813.42632-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

bcm2836_realize() is called by

 - bcm2836_class_init() which sets:

    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7")

 - bcm2837_class_init() which sets:

    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53")

Both Cortex-A7 / A53 have the ARM_FEATURE_CBAR set. If it isn't,
then this is a programming error: use &error_abort.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 166dc896c0..a1bd1406e1 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -131,10 +131,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-                                     bc->peri_base, errp)) {
-            return;
-        }
+        object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+                                bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
         if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
-- 
2.41.0


