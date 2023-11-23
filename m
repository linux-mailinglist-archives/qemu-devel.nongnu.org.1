Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744977F61BA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:41:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Ar0-00020Z-8I; Thu, 23 Nov 2023 09:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqi-0001oO-8t
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:41 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Aqa-0002QM-P6
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:31 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507be298d2aso1193933e87.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750306; x=1701355106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpz6WqSYEj1xbsU7bl0EFtxY0Jdo72CGKjloYLxmr9U=;
 b=aBUIrDKLC3IQK0EYP/p1YT1iG3z/EEKUTBBt8iiZOH8ERfkIFUf3MdNf5EziD5GwOz
 gEH61vlNqPSg2Ksvp8OOQPRbeByn7YGPbcBkt2Zr6xmhpLd8vaP04fNtPw6IVShh4fmR
 bnOhm2Ls4SEDdszKOGnELGzAIc/cQc2BNkUbiLXX+4gIg1ROa1ppErWsh2PtKGhIZcQb
 ngQc9RluMGVOSbSBXkUyUM+ONNOV3m8ENdAwUVEr5MZs8GoPOQTTM697QQdX82KtcbYR
 8HfVyXtmFhei84Pl5/a93N24v7JRKn7t5p5AhSLvYiU+7BX/0VVHkWvnIKM4Y0nykFcQ
 IwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750306; x=1701355106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vpz6WqSYEj1xbsU7bl0EFtxY0Jdo72CGKjloYLxmr9U=;
 b=AOqd56C0lyk7AxXoTnvwGP7g6FiAeG8Eea4S8QAOOmBbEZU8EIbaADaMuIx1yXsp9L
 0ny7VV1iuLu0JAvcsKh3atquMrB3Lq85VszDcAaP4x5iB3svq9/0N7/SWarVFRXNkk1c
 7faTE+kxgjCIb+hHykFKoroSnaZiivqEmgSOfymWem20G22Fp9HOvbAE0cHzKF0GFatc
 19LzKFy0FpU2zYeQxe7cJAcm/VAi1VZ4DJvHBGlsSm/jPk34n6tSug4pbs6PhkTKZy/b
 ny0m2N8sS6tJdI71ldwnN+MKFiHsOklKisvHJcDmcjBwYamb4mhKq1GqzUs5Ph+9Y+Rz
 qAYQ==
X-Gm-Message-State: AOJu0YymVXZEA3R2bGReeRq/5UwCcc9p/GjFtLlXgKb4j3Plz1i59nAp
 g/IPsnkJ/njN37gKDH1q/XBiYQ==
X-Google-Smtp-Source: AGHT+IGz8ls8p48wUH7A0TIP10jvxIAnuZkwb3v8olBLihV4O0vpBX6eDqhfDzSm29WOvrYyT8WFJg==
X-Received: by 2002:ac2:4348:0:b0:509:4c7b:c734 with SMTP id
 o8-20020ac24348000000b005094c7bc734mr3655236lfl.20.1700750306459; 
 Thu, 23 Nov 2023 06:38:26 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a056000100700b00332d32efff5sm1791257wrx.74.2023.11.23.06.38.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:38:25 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 1/8] hw/ppc/spapr_cpu_core: Access QDev properties
 with proper API
Date: Thu, 23 Nov 2023 15:38:05 +0100
Message-ID: <20231123143813.42632-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123143813.42632-1-philmd@linaro.org>
References: <20231123143813.42632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

CPUState::start_powered_off field is part of the internal
implementation of a QDev CPU. It is exposed as the QDev
"start-powered-off" property. External components should
use the qdev properties API to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_cpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 91fae56573..24f759ba26 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -306,7 +306,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
      * All CPUs start halted. CPU0 is unhalted from the machine level reset code
      * and the rest are explicitly started up by the guest using an RTAS call.
      */
-    cs->start_powered_off = true;
+    qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
     cs->cpu_index = cc->core_id + i;
     if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         return NULL;
-- 
2.41.0


