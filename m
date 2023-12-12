Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312480F2D0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5er-0001dM-VM; Tue, 12 Dec 2023 11:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eV-0001E6-Pu
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:44 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eT-0007Ne-Rc
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:35 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54dcfca54e0so7615481a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398632; x=1703003432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekMLwFEwN8A8wVtLlfYqHUo8mVDJrO6E1RnF8kOlbaw=;
 b=U/UqdqvJ37PDhenvSeJhM1nXjGSgCqx4kZfsqJmJKzzCEnI7OZQW0mNNXwtIWpM5F9
 I5xWV8xwOZQkR3lWtFKw5yYrWlk6UumekbRw8BvASOrxO4n8LUKMV5i9hotOjK9Ex+ZF
 fHBO7pbyclBAxhvN7efSoLQL6E3s7Y2cAACDXmaoPgX3OAfgmDAw9ztFLXTYdMjpyMTk
 DL44oXin4+27KxAcJ1lO7UBhsDdxR7PXtNtJXaP77DMVRdvTpznydaxbqk8/0EV/Gp1K
 GNAkFsj1TOL731tGl2rPlB+qhLDai0UJKqr1EGtHTUBmiwIJJxXWzxC5ooaDj7u1gZRe
 RU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398632; x=1703003432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekMLwFEwN8A8wVtLlfYqHUo8mVDJrO6E1RnF8kOlbaw=;
 b=ddM+YCPJG/GJYqpOga1c29rm5TMcwVCB+uFfvQ6yLK+LuN3rJJzmThiBh1V/PE3GAF
 Iv2BQ9/5EwX4/DnyhhstC3mZHtK7gmFUassS57AfMWdPqVC/D4oH9Nbcm5rp2nn9g398
 CvjJ8VzJPvQEiQAHYqbiLf1QjnO67HRS9DSHeLqRcSwNsQj78vSs4ToBOf4Cylx5GYeL
 IJazhQG3iXRAG//lR2as3khM7YVM4EwHeA64+d8AWvVBSPnIzBvqzcUZe0+U2/b3lWZl
 R7MP9wkU6Z61MaZfobFDAnWKDhPMmHQgkJyml8U9NfTEnUWiXQChdg3ggM28ItMOaVEO
 nnaw==
X-Gm-Message-State: AOJu0YzeaJH4X7lqZ8wERMj8Z+6OJ6Vg8JvsvAa8BHjcsDf8v0iJuFC0
 u3TlRbvvTES/vqNmHr52f6wyCXnnl1WTiMV0sL4=
X-Google-Smtp-Source: AGHT+IFgJq5DvObeP9enEnn11Zs6PcFGrLfXqca1HfwYKoKlFuI1hXrRP+1xuG2m6bHxslTLww5n1Q==
X-Received: by 2002:a17:907:3d8e:b0:a19:a1ba:da4b with SMTP id
 he14-20020a1709073d8e00b00a19a1bada4bmr4130827ejc.114.1702398632039; 
 Tue, 12 Dec 2023 08:30:32 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vw18-20020a170907059200b00a1712cbddebsm6453045ejb.187.2023.12.12.08.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/33] hw/cpu/arm: Alias 'num-cpu' property on
 TYPE_REALVIEW_MPCORE
Date: Tue, 12 Dec 2023 17:29:07 +0100
Message-ID: <20231212162935.42910-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

No need to duplicate and forward the 'num-cpu' property from
TYPE_ARM11MPCORE_PRIV to TYPE_REALVIEW_MPCORE, alias it with
QOM object_property_add_alias().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/realview_mpcore.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 72c792eef1..7480b38d1a 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -14,7 +14,6 @@
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qom/object.h"
 
 #define TYPE_REALVIEW_MPCORE_RIRQ "realview_mpcore"
@@ -68,7 +67,6 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     int n;
     int i;
 
-    qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), errp)) {
         return;
     }
@@ -100,6 +98,7 @@ static void mpcore_rirq_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "a11priv", &s->priv, TYPE_ARM11MPCORE_PRIV);
+    object_property_add_alias(obj, "num-cpu", OBJECT(&s->priv), "num-cpu");
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
@@ -108,17 +107,11 @@ static void mpcore_rirq_init(Object *obj)
     }
 }
 
-static Property mpcore_rirq_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", mpcore_rirq_state, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = realview_mpcore_realize;
-    device_class_set_props(dc, mpcore_rirq_properties);
 }
 
 static const TypeInfo mpcore_rirq_info = {
-- 
2.41.0


