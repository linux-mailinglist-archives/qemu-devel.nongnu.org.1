Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AF7DBBF5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRJ-0001Oq-DO; Mon, 30 Oct 2023 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRG-0001OC-O9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTR9-0001mf-G7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so33318535e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676808; x=1699281608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6siaLDPN7rSUcCidjmSdujoZ1Clu6ak+uuvWhAfvmw=;
 b=AL6U92Kutol4J+wa3wAIFluDUGyz6apXLR542dFacd/PZZJOOixnspwIBfGo2AjB5V
 PurkAjC4HIFtigzycQz0QslPyOEZKzXorsvn4kWq8bRH14mXrcTqe0KURmLFI14/oPsP
 hFGkRR6ukWPRDAxVsEzx62G8pdlsB2liDsDa15yUTriCVbH7zHtsL/xPczZAJSGJ5waO
 CCIojWqsozvSm8XS+q3feDDJUcVq9eSdTT7kAdOERmQ3PxTjLttpRHhC4ltxi1TaTl2h
 jESlYgVl47RrVrjRh3R+ZSm5Fzpj1FU6nXxyhe9a9MGYsQU6zOi8KTYmN6q1fr1ro6fZ
 sCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676808; x=1699281608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6siaLDPN7rSUcCidjmSdujoZ1Clu6ak+uuvWhAfvmw=;
 b=eb7txxUt/VDapPSllYi8TnNn2h77QUxD4J4mzz+ZI7q83T47CUzdWf6cNYGVe/QwD9
 t2VqHy75/E3aZav/zABjo3pA9z2ZU8jGjETCzHPPXxbQB581RSD1No0XT2qTuDggTY8w
 qgpMDyB4onx1vHz3xsiYSOdaZl7WB7VVowByNbkdFul/9ArhbNRRIrhFpMyMUApqDaRq
 2Huw6TPnJ8qIsOVMgwWfvDckSux99Ei9elQqt0a06r0/7lJ49FX/DM6MW7EkJ7e/b9X8
 LfPTqdWnFoOgOix6M/FHImbQUMxXZg47MWmaOoV5joAJpwGNzpCU6lZrRB3y7K7/TdEY
 QFfA==
X-Gm-Message-State: AOJu0YyQkgvTdyVwofvFM75xnhXVJWlfvXAhYbPiIZIOcTnqjH3Cn2DS
 8nJibboPr4VlYkscxpi54nINOW/gK521UNbeCs4=
X-Google-Smtp-Source: AGHT+IEN1tC7QqL+vvg0htfcj01AzEW/xTlNdfksFtZAlrrQUX0XcOeSfEcP/xGD7BuUuisxF7KARw==
X-Received: by 2002:a05:600c:3b20:b0:407:612b:91fb with SMTP id
 m32-20020a05600c3b2000b00407612b91fbmr8013575wms.30.1698676808504; 
 Mon, 30 Oct 2023 07:40:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 bg9-20020a05600c3c8900b004063cd8105csm13009491wmb.22.2023.10.30.07.40.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] qdev: Add qdev_prop_set_array()
Date: Mon, 30 Oct 2023 15:39:52 +0100
Message-ID: <20231030143957.82988-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Kevin Wolf <kwolf@redhat.com>

Instead of exposing the ugly hack of how we represent arrays in qdev (a
static "foo-len" property and after it is set, dynamically created
"foo[i]" properties) to boards, add an interface that allows setting the
whole array at once.

Once all internal users of devices with array properties have been
converted to use this function, we can change the implementation to move
away from this hack.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231030114802.3671871-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-properties.h |  3 +++
 hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1df08876c..7fa2fdb7c9 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -206,6 +206,9 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
+/* Takes ownership of @values */
+void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
+
 void *object_field_prop_ptr(Object *obj, Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..950ef48e01 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -3,12 +3,14 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
+#include "qom/qom-qobject.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -739,6 +741,25 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
                             &error_abort);
 }
 
+void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
+{
+    const QListEntry *entry;
+    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
+    uint32_t i = 0;
+
+    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
+                            &error_abort);
+
+    QLIST_FOREACH_ENTRY(values, entry) {
+        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
+        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
+                                    &error_abort);
+        i++;
+    }
+
+    qobject_unref(values);
+}
+
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
-- 
2.41.0


