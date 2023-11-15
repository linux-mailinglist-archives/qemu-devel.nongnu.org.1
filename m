Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6F7ED81A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 00:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3PDQ-0007cF-QF; Wed, 15 Nov 2023 18:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDN-0007bX-0a
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:33 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PDL-0003T0-DK
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:32 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c83ffcdbe3so2446821fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 15:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700090549; x=1700695349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b/fiTOaFIPayjBXev06ScNhrp2HmeigNrv9VMh5ovk=;
 b=kSp+JYLMDgnYLsCdGO7WBL65O7ChFMPwz8VB9cx+lWlsLPMB9Ts3cmKbTSnS+mQSZt
 irk5nrlWHbU52C4lbdrci5G8EPqzxuOkTPbvUTHszKyPWyojkiHIPdwsRO8EKPKO1td7
 G85j8GFXrwcYhKmQ8Kn5HbZaXCGGdkGwwqopTX5nIFFRsy6ZQ2RrlbG4ozVLYbves/7i
 iYJ9yi0OjqakQC3wstKLkRAskBaBXw+UKD2XAgdw3m0oQVdo0m0ebiRibKdx0kvZ/CZ9
 l4n/Py+UL42c/hrdSAbuCR/I4jHmTe4yOpdk1G9wmueufanK2aOpQYWGuXWi2lKaDv7y
 9RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700090549; x=1700695349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2b/fiTOaFIPayjBXev06ScNhrp2HmeigNrv9VMh5ovk=;
 b=dpH2DLMEtiTyuMT+rplgxm9XSLYo+pt3u+Zu8XaDnX5gKy96PPJNsdX85LbfHPoSB8
 OOle0qMH0hBhrXPH5GN/XItmZHmyaOG7PQAIp0NJ1CLdmldlmkVD8tsosnAJLS0OU56m
 mQPYV/FaEp+xqxmSb1WG5aLEsH0z3pjEq76akxYXsPlHysjg/Wgw42rWKHjHPbUrOGYc
 W8VexHlgcGDqQQxGM2y5TXLeFE8IEDsY22z6WmjfSid50LpYq0S9q8BvRcxICrOsBcxk
 fwpk5TSXVHObO6eKSntDkAt6ByngZ/i5MBhFpPbtakFtVUB/FHumImLTggEgurLfBoLY
 sflg==
X-Gm-Message-State: AOJu0YzGfE6u6RtpRur8RzZKT9bI81tCS0YNI65XVpykinUnzW7vbyjd
 qKuqHQvB4o5HW/sGVClpH82LZy10AOZmQP0UAdI=
X-Google-Smtp-Source: AGHT+IHEbeePqx0jQtu88QOZNtD+dZ9Ms5p6Swi3vNEO+Zb/Qjl7zdx+dHncO06iF/Yw51YlPKFDBQ==
X-Received: by 2002:a2e:be28:0:b0:2c0:20e3:990f with SMTP id
 z40-20020a2ebe28000000b002c020e3990fmr5655014ljq.10.1700090549239; 
 Wed, 15 Nov 2023 15:22:29 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a17090611d700b009829d2e892csm7773426eja.15.2023.11.15.15.22.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 15:22:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 5/6] hw/arm/npcm7xx_boards: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Thu, 16 Nov 2023 00:21:52 +0100
Message-ID: <20231115232154.4515-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115232154.4515-1-philmd@linaro.org>
References: <20231115232154.4515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

The npcm7xx Soc is created with a Cortex-A9 core, see in
hw/arm/npcm7xx.c:

  static void npcm7xx_init(Object *obj)
  {
      NPCM7xxState *s = NPCM7XX(obj);

      for (int i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
          object_initialize_child(obj, "cpu[*]", &s->cpu[i],
                                  ARM_CPU_TYPE_NAME("cortex-a9"));
      }

The MachineClass::default_cpu_type field is ignored: delete it.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/npcm7xx_boards.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 2aef579aac..98f9af27e7 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -121,15 +121,8 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
                                         uint32_t hw_straps)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
-    MachineClass *mc = MACHINE_CLASS(nmc);
     Object *obj;
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     obj = object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
                                 &error_abort, NULL);
     object_property_set_uint(obj, "power-on-straps", hw_straps, &error_abort);
@@ -462,13 +455,17 @@ static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
 
 static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = machine_valid_cpu_types;
 }
 
 /*
-- 
2.41.0


