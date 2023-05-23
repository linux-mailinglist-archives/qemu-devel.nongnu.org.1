Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC070D43D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ll6-0001vm-Cu; Tue, 23 May 2023 02:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Ll4-0001vU-UR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Ll0-0002gL-HR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:44:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6094cb26eso5799975e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684824268; x=1687416268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7vD03cErjYangTizc1GQ3mHeqbcUTk0o4KZmb+NjF8=;
 b=SuYjnIFnX41JqKJpNH2XpmiFEmWe04lucvTw8uIgJTkq6ddP0wZ/XAQqP2LKkE0bfk
 WGruo+GEM8DyRk4Vfzr99R4+UtbyEnPJckD2kuq5cHnEwWcqmMg3Z2XOzNEbKWuf2Bf7
 fnV8IlVG0gDOomGjMXCVwqxxv1/YBkHkS/S8mftsw80F6KH8nZSXM/NmChw0JejRUU76
 ukgh+FZiACokvGK38AbOW7yI29quy06JK3CnK4+X5FIP15pE2VyuJqXPFWZjzGtwQRNW
 29xCqmjCJlIWbF8li1JxHXe+rs6RAtAcRpXbba39TWpzYoNJkDezpxsGOPHObW/WGQrG
 PNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684824268; x=1687416268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7vD03cErjYangTizc1GQ3mHeqbcUTk0o4KZmb+NjF8=;
 b=FjZ68h9zPCChmvtxEvgE/wgF0mJ1GscwwKMSXicZ6Q4PAu81+JgEHGMTEfzk5x99mK
 jgXx24YaTvr8w4OicnOOPGqrIySYY3o/UdfexXC+kwZm8+IJZjUTtAMFRyiysOKYfoFh
 FoaMepev5l1bvE5uQG2gq+IMe8xHRhOyIXhXWmisS5OHgSuo7sMGKKF1KaUlHtLwRdcq
 RY4/9+p5VVyfMmM4kwFjVeUPWecbcsjGAgmc7Y2uIJULwV2NdRXbifGJLa3ZBzFAWfJs
 SrHgEqGY3CFbmbQdsHKqtKi73ToDx3J/5eL71noVQeNjWg/G1LkG/S7yN5AoNTguMOGk
 CgfA==
X-Gm-Message-State: AC+VfDx4kVJr3mpXIr5EEHpdoJjynm+pwwARWc2zpBLpbanbg/In3H7E
 16Xf4upeCSgmhOhB/YvU0BiByWosoe2JU1S/yl0=
X-Google-Smtp-Source: ACHHUZ4n9KqItF2fKetcXdOa+c5vTB98XznPEDucM59xAETwR4rAZ34zjz3wzdkKelPG/eOQO9LfDg==
X-Received: by 2002:a1c:f30a:0:b0:3f1:6fb3:ffcc with SMTP id
 q10-20020a1cf30a000000b003f16fb3ffccmr9252466wmq.22.1684824268573; 
 Mon, 22 May 2023 23:44:28 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a7bc389000000b003f60514bdd7sm4915475wmj.4.2023.05.22.23.44.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:44:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 3/3] hw/i2c/pmbus_device: Fix modifying QOM class internals
 from instance
Date: Tue, 23 May 2023 08:44:08 +0200
Message-Id: <20230523064408.57941-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523064408.57941-1-philmd@linaro.org>
References: <20230523064408.57941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

QOM object instance should not modify its class state (because
all other objects instanciated from this class get affected).

Instead of modifying the PMBusDeviceClass 'device_num_pages' field
the first time a instance is initialized (in pmbus_pages_alloc),
introduce a new pmbus_pages_num() helper which returns the page
number from the class without modifying the class state.

The code logic become slighly simplified.

Inspired-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/pmbus_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 44fe4eddbb..8bc9d5108a 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -190,15 +190,18 @@ static void pmbus_quick_cmd(SMBusDevice *smd, uint8_t read)
     }
 }
 
+static uint8_t pmbus_pages_num(PMBusDevice *pmdev)
+{
+    const PMBusDeviceClass *k = PMBUS_DEVICE_GET_CLASS(pmdev);
+
+    /* some PMBus devices don't use the PAGE command, so they get 1 page */
+    return k->device_num_pages ? : 1;
+}
+
 static void pmbus_pages_alloc(PMBusDevice *pmdev)
 {
-    /* some PMBus devices don't use the PAGE command, so they get 1 page */
-    PMBusDeviceClass *k = PMBUS_DEVICE_GET_CLASS(pmdev);
-    if (k->device_num_pages == 0) {
-        k->device_num_pages = 1;
-    }
-    pmdev->num_pages = k->device_num_pages;
-    pmdev->pages = g_new0(PMBusPage, k->device_num_pages);
+    pmdev->num_pages = pmbus_pages_num(pmdev);
+    pmdev->pages = g_new0(PMBusPage, pmdev->num_pages);
 }
 
 void pmbus_check_limits(PMBusDevice *pmdev)
-- 
2.38.1


