Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15707DF8FE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybgg-0005aw-Al; Thu, 02 Nov 2023 13:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0003FO-KL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeS-0002hN-PO
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso9068675e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946719; x=1699551519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gMrisEf6ekgxSDT/iAPpxMfjnEW+8vsNxHXZQ7hNGP8=;
 b=FvhpbQd+xTs/1BjpS6ze/FLivmJHfU3+m2mr5RT9QsaD/oJMgoP1HBwumbepLlXP5N
 a9/xZJXaq4gs+3L12xmjgBlZ3zg4o09eGTpifzsjUW4Nb8/SmEPi/LU0Tv8og2H0Ajm2
 AEntCwtS3QggEprKBuzxwfWzc93R50+91ZjZvWq4znsk9z8N8z+wMVvSwOB0hgjqr3U/
 sTNHzzgQQPR14s7ujasi+rInPjWpgkAY7OpejjWUAY0ZI01+Gso2dGEd3CTp36YbRiTB
 ovTGTFK1q0YAw6aCLqElbZ9NET0BGo6MfE0zM042D4HB4MyKYEGcOKCJ0QDM+WfDQJ2x
 BXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946719; x=1699551519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMrisEf6ekgxSDT/iAPpxMfjnEW+8vsNxHXZQ7hNGP8=;
 b=bAcRPRfbGWpwhl9iq2UNSrm1QeBMzdILXUYREMFQ0GJ249+5Qkrd5cxt7FwNlx3gme
 sDqkI/af6rXwIyBXNXv7co5Nqt6JlAEVT0jlCwg4nWxsIL0dgJt4Fpr8XUF72SztKl2d
 LrSaJTgUvCEi0D7RjUGxnsUcqkynXboSFI68LVmps4dqBftQf6lsBsLQONk+nlWoPrMp
 SmT8t6sMfC74VHi+anL55l+/FOxe9ezkSRjyXOYItBulTOv6PfXgD4ZBjMYD2S6vh+2Z
 /AXZi2A1p1ATw5amErdSZgXAgYFB+gWjAwecAERSI/2nUmzcs01SdmsyPTV+DfxaKtDd
 TaPg==
X-Gm-Message-State: AOJu0YzVrud1V4PZSAKdrKEqvEQP1O90ermAMimjTujRKXM5E6XLBFaT
 eG4liJ/Lh6ZeDo1LBFyl6lVOzgMF+fxJReaGS8Y=
X-Google-Smtp-Source: AGHT+IGwNbc2rRJLouQzPIeptIeuK89w5sgrc4nWOxY8q7PvE8zDA7Yjxc1K5OzTxzvE74HChh+iLw==
X-Received: by 2002:a05:600c:1c9a:b0:401:d803:6243 with SMTP id
 k26-20020a05600c1c9a00b00401d8036243mr15990361wms.32.1698946719347; 
 Thu, 02 Nov 2023 10:38:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] qdev: Add qdev_prop_set_array()
Date: Thu,  2 Nov 2023 17:38:06 +0000
Message-Id: <20231102173835.609985-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-id: 20231030114802.3671871-4-peter.maydell@linaro.org
---
 include/hw/qdev-properties.h |  3 +++
 hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1df08876c6..7fa2fdb7c94 100644
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
index 357b8761b54..950ef48e013 100644
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
2.34.1


