Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBE7F3524
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:43:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UkP-0008E4-Fk; Tue, 21 Nov 2023 12:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkN-0008Da-DM
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkK-0001Fv-Pg
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:15 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fdc5be26dso3738824f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588471; x=1701193271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gZmZAr8kYS7gDEfj38KOIHMYLXNb4HUKsj/RIzSduo=;
 b=dVISFH7i4vWRLm5MJo0BMF6C4zd0M6+80ab3QY/OpMuxVRV7GOihYzV4xrz85dNMay
 JaFUIUnKnxQbPEBO90p3AUAXCCYFsJ3+qFKr455/MiEUCIyJ67S4dgDu2PwKEHqpxzLn
 D2vHJfYOcu9Z6BQiCHKO95jE9b/SBsfyY7pHBw1egPvGGr/icfpOnRLESzfRr1eF7wuR
 SdiuByVoQWhZWqneEMvpkGdvUAyIinlJ5vSMOAcIzFvZlmB8Qhn5I7KmvqV8yzHKTjRe
 7K1mF05LBvM4acwNmYLUFDlitCQ8pIsuSlABNoRy0BzQ2e6cYr1vbpfATD7slWCJF7x1
 melg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588471; x=1701193271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gZmZAr8kYS7gDEfj38KOIHMYLXNb4HUKsj/RIzSduo=;
 b=Se3nGK0mTNqKcLE9BY2mxS6TUUaFg6OEzO8dg8Lj+Lqpz2lPwt4Vs1SjmzFzLUB96O
 CjTg1OG8Q7vTRIUBixF5+6Cy7/b4MCHgG6d4Mublv9jLztKdfL5mUf0f5IPGeaaMcQam
 Y66HIXu+WCGNz/5dba1BDUubYBm1PcC+AsjrSySB3QkiajVmrIeAguJrNB4jfAJLjX8B
 C5svoN6yiIn5P4PnmtD/MyWJ0ZRi3QehjdTTLa3J87VRw8S8AhTBLEi0k/oW7wtRzuEv
 ZV/HH919kk3mVBcgCBd1+QuiEYuRVSuNGadlyUDOgmOgIStEfGyV7XWQoWGnFQNOLrnx
 2JVQ==
X-Gm-Message-State: AOJu0YwC+N1/5yUS6zy1V82R9iGeLLL5XxXCLqRYi3A7DsiBer/u8Q86
 Kp1wYM7fzh7UNfHG6FJiWL8X+vWmirfOkOcf+Kg=
X-Google-Smtp-Source: AGHT+IFuKR6qCCBXAcv+2JhWqpj8WFpnTVNl+uGVZmRBHZEc6xCHEwFeF6RkqeBNgcHXda4vx590ag==
X-Received: by 2002:a5d:64ec:0:b0:332:c9e7:3d1a with SMTP id
 g12-20020a5d64ec000000b00332c9e73d1amr4672410wri.62.1700588471330; 
 Tue, 21 Nov 2023 09:41:11 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6a05000000b0032d2489a399sm14777400wru.49.2023.11.21.09.41.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 09:41:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2? 3/6] hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array
 on finalize()
Date: Tue, 21 Nov 2023 18:40:48 +0100
Message-ID: <20231121174051.63038-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121174051.63038-1-philmd@linaro.org>
References: <20231121174051.63038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Commit 0be6bfac62 ("qdev: Implement variable length array properties")
added the DEFINE_PROP_ARRAY() macro with the following comment:

  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.

Commit 4fb013afcc added:

  DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
                    qdev_prop_uint32, uint32_t),

but forgot to free the 'oscclk_reset' array. Do it in the
instance_finalize() handler.

Cc: qemu-stable@nongnu.org
Fixes: 4fb013afcc ("hw/misc/mps2-scc: Support configurable number of OSCCLK values") # v6.0.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mps2-scc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index b3b42a792c..fe5034db14 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -329,6 +329,13 @@ static void mps2_scc_realize(DeviceState *dev, Error **errp)
     s->oscclk = g_new0(uint32_t, s->num_oscclk);
 }
 
+static void mps2_scc_finalize(Object *obj)
+{
+    MPS2SCC *s = MPS2_SCC(obj);
+
+    g_free(s->oscclk_reset);
+}
+
 static const VMStateDescription mps2_scc_vmstate = {
     .name = "mps2-scc",
     .version_id = 3,
@@ -385,6 +392,7 @@ static const TypeInfo mps2_scc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MPS2SCC),
     .instance_init = mps2_scc_init,
+    .instance_finalize = mps2_scc_finalize,
     .class_init = mps2_scc_class_init,
 };
 
-- 
2.41.0


