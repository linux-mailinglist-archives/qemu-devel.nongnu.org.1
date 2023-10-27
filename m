Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AA7D9BF7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0n-00080e-Tn; Fri, 27 Oct 2023 10:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0L-0007Nc-Th
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0E-0008B5-U1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so1494552f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417597; x=1699022397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=md/8boBzovKzRvF7b8BqZz7bG8/Ggz8MPHAVAdGqfbE=;
 b=QexAmBAZlRbpQQjWTTt2OBdf/ENwiFhEwYbiSVDRpUAVVOHshxik7tvwaZuehWm67h
 otiEzVwUwYvwhay3b5YJsdDs+pG94ypu5XaJb2YczFs6OBif3y8Lr9QAaurBzVj473SJ
 nn5M8spE5GdyFvtm62j8hCOeEZETMA3cWFt47JVIEQbGkC8hY+ulFUDdm3u9Fg9j+Tug
 0IRg6X0dwQv3pMxg9OOvo/IQUR9hUVsp4ijbgt6dyfHTHM6o3GL4fUUAWwdsEARLfKNi
 CnIM39yPfL9AAoU3KZRL1x5ZhYv/kKj/7Mse+RPzUvc5c/DvTKT3+zVkfX4ROlVnPvlX
 veRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417597; x=1699022397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=md/8boBzovKzRvF7b8BqZz7bG8/Ggz8MPHAVAdGqfbE=;
 b=GWSo4u1Z+fjQzoHiM5dUjzw9f3K2B8mp/4012THXTCEZ4aohKP7e0dSjRmLjF546U7
 IKaIJAF93m6n2WaGUmmAO4qaSh+wylud7AbVL+5BBvXUi1ZscKiXf2CVhwoEA5jGUf8N
 Jl2RwIHXePs3O0CB1sx2yxyQ6jvHg5WEtOKy4dAj+BBM3t4uPyglpbd24kpWc/9C5bLe
 +fmS9CN4GPCcyIqZ9Sl6qMswCXxvnHUD1cLYtxzbcQxNvS/CPVz3LceP0JGGndTogwSf
 eO8PUFWiGjL0wk+UhtaLbnHc/kataIQqmizalK5qsPCFsqmKBUzo6Jx8cBeBN76yNOJS
 hyug==
X-Gm-Message-State: AOJu0YyeTD0rV49i/OHfxSBQVq+wKv/wVio+uj9uSrZCZat14SeH5v4h
 KHJHX9VD7nWdKW4pLBCQT624iGvJxQbxzrks7ME=
X-Google-Smtp-Source: AGHT+IECC4DY/thr2qUjOLXcgRCqxdszEjDqXwes8Lyzck4ThCVRSKXc6E2wQcnwHXe3xEii1yll8w==
X-Received: by 2002:a5d:6d81:0:b0:32d:14a4:ab3 with SMTP id
 l1-20020a5d6d81000000b0032d14a40ab3mr2802062wrs.24.1698417596868; 
 Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] hw/intc/pxa2xx: Pass CPU reference using QOM link
 property
Date: Fri, 27 Oct 2023 15:39:27 +0100
Message-Id: <20231027143942.3413881-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QOM objects shouldn't access each other internals fields
except using the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20231020130331.50048-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 2eb869a605a..7e180635c22 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
@@ -288,7 +289,8 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
     PXA2xxPICState *s = PXA2XX_PIC(dev);
 
-    s->cpu = cpu;
+    object_property_set_link(OBJECT(dev), "arm-cpu",
+                             OBJECT(cpu), &error_abort);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -321,11 +323,18 @@ static const VMStateDescription vmstate_pxa2xx_pic_regs = {
     },
 };
 
+static Property pxa2xx_pic_properties[] = {
+    DEFINE_PROP_LINK("arm-cpu", PXA2xxPICState, cpu,
+                     TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    device_class_set_props(dc, pxa2xx_pic_properties);
     dc->desc = "PXA2xx PIC";
     dc->vmsd = &vmstate_pxa2xx_pic_regs;
     rc->phases.hold = pxa2xx_pic_reset_hold;
-- 
2.34.1


