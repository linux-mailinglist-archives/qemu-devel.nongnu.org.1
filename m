Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2487A46CB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBKN-0006JW-Cb; Mon, 18 Sep 2023 06:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBKJ-0006Iq-Tw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBKH-0006ou-DW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso7090895e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695032276; x=1695637076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8I52HFJ7JIIVf6/kc1x9A3KkqjzDotpu4ox1BgoUxm4=;
 b=NO/fDZs9W5HiqDat34WSBqcyUio2okr25QwI6p7cCubnPGxOYMSjJUAt6dy3hh81YH
 21btOA8H3QDOeJMQiOQJrcfVVBbwsabxmWdKnrYBmVjrYbBypTVyT91Reaot9vk5GXE9
 vw2aExYzkuIQf34C+wzcRQeeCm3O+IheKsWK7OKRUFJb9RDyLxW0EWp8HkQ5ONLtT920
 gC8Fgli4TFKpfFdiBzr4JHiYJRegpW5c1CA1LzzRBziKvFoaaTiM7O3WBrCmkuT1njUY
 +jS1BSbqAHIlCMCxQqWpMtCQXsQZgULpDODi8XLKpDRdDBszwsGIYGjPcW8bGSQX7hz3
 FDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695032276; x=1695637076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8I52HFJ7JIIVf6/kc1x9A3KkqjzDotpu4ox1BgoUxm4=;
 b=qP05ST8y5ktED1AoDxBVrZDAdk+2svM4fA1+Yn718h2qTq7dxrh7hcQAEDhNKAP4uk
 XJ6WMIpvpI+jbuAAjSfO0fJcfg2rjbbYGOxigqadZQDXk0x3xm4q7raFF9JrVQrxgunm
 yLenaYpKfR3t0U/Ia96vkaD6ebPYbWAruzGV0JwZIHSf+HvTBKxgcxE9WS/8pqcJ0pGu
 STh5ZlaHkgWrinPin/E4w1n5qg4RA0OgX9M2WwkI/fDXx0ypJJlwzeOY7dgCGs8dbq4H
 fa9TyYIqd+NiO+P2wzuXPG4p+2fNWLFW+AMbCg23aKzXGjWXpA5qZOHWyg9NjCGBCA4e
 5wWA==
X-Gm-Message-State: AOJu0YykxyHCHpATNckaMOQR6oQAQsngWo5yHWN/oJie/Wg0khw6E0YJ
 8taBcqj8bnn5esdOzYeFc2a9T3nCE2WlyNouNCPRpNZh
X-Google-Smtp-Source: AGHT+IH7/y3yF55C3oZAeNYtJqB5yvAg/wEoCbqXe27X2kIcnR9KuYdj/L9rALct7aG27VOWyC58xg==
X-Received: by 2002:a05:600c:2901:b0:401:906b:7e9d with SMTP id
 i1-20020a05600c290100b00401906b7e9dmr7999543wmd.18.1695032275800; 
 Mon, 18 Sep 2023 03:17:55 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0ac400b004030c778396sm14945294wmr.4.2023.09.18.03.17.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:17:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] qdev: Ensure devices are fully realized when calling
 DeviceReset handler
Date: Mon, 18 Sep 2023 12:17:36 +0200
Message-ID: <20230918101736.23905-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918101736.23905-1-philmd@linaro.org>
References: <20230918101736.23905-1-philmd@linaro.org>
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

We shouldn't call a DeviceReset() handler on unrealized device.
In order to enforce that, add an assertion.

CPU devices are a bit particular because we manually reset them
in various places, so corner case them out for now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c51b4c98de 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -252,6 +252,8 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
 
 void device_cold_reset(DeviceState *dev)
 {
+    /* TODO: Also cover CPUs once we removed manual calls to cpu_reset() */
+    assert(object_dynamic_cast(OBJECT(dev), TYPE_CPU) || dev->realized);
     resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
 }
 
@@ -280,6 +282,7 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
     assert(!dev->realized && !dev->parent_bus);
+    assert(!device_is_in_reset(dev));
 
     if (bus) {
         if (!qdev_set_parent_bus(dev, bus, errp)) {
-- 
2.41.0


