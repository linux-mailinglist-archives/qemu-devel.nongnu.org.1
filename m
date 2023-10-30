Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46C7DB942
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:50:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQkh-0007vq-P7; Mon, 30 Oct 2023 07:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkd-0007rb-2U
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkZ-0007I0-GZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso1886229f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666485; x=1699271285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDC5J/pIZ/iFxlh4YAZWUq7F2Xchn9VZbC5ohU+C9is=;
 b=qokPl5ib17X73BeYe2v3FmQyUQgbI/LoKG/kwrq5D98pYbamGZAq1tjjtu/fjSMcio
 jKOyILx36WqBr0EsIltNVmTE2eYwgk3is57CK6nd945GcZfKpYrzTFV1IGo/5T/yG73m
 /6A5eMk3YsQNyEP2phAoitQTCh0fGa9nCapqph+tcbfpCvAwMdBQMvUnoExL6puHAlxc
 1dwMIANbZuJCBeXKtJyMYnDyJxN2Lc5CO30Akba2xWs1i4DIBh6X09E1yZq/451yL9HK
 3EUV2einoBEm/pxXxiWGf3fCft/N+T9nocGDB0RV+T5eQW0GeqFIHyAulo3rOZ0kGsi2
 pTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666485; x=1699271285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDC5J/pIZ/iFxlh4YAZWUq7F2Xchn9VZbC5ohU+C9is=;
 b=Iqv1p7rI9dRAJBV8lK/Wb5omKDCTVlrx3Z0WXy+snu/DiXCZf0cQDx34cQWj3mEty9
 SZY/EJ2Dxt+EAamQXjiW21IraC4cB9/7o5h3m7lRsHR9vCphs+72KuI3na7j2Qe1gIrk
 3y63tnOVkO+iQUNH073OYls9mM2SjTYl76PWeX/6waE6u8HKeH4RMNqOQP1bddNSlBMK
 1w3zlcrq/WFxrWdlOI4v20yerZRIFdU7z7CvmCdxffMkBqHO1kgAq6O4eC7y/gkurOA3
 ZqEXTq0xgPOLiOtaTL28UlOqIWAWQBBiEtRh5lYKQB1nZvoMbNts/NPI84qqVzkXXY4/
 Amlw==
X-Gm-Message-State: AOJu0YwdlQzss/Re22B96sKXCVzoH+gfZ2GM9yO408PGBH4ZFH2TrKkc
 3bq3xjslWrUOShTAWlexZicL1A==
X-Google-Smtp-Source: AGHT+IHSGi55xeLh3mA2JgpgFcWnDc9zcejcd65wQ06irKwB2XnEf2ndTcuKaaaNWYA2/9fNcY+gRQ==
X-Received: by 2002:a5d:6d0d:0:b0:32f:7d60:d62e with SMTP id
 e13-20020a5d6d0d000000b0032f7d60d62emr6754847wrq.27.1698666485590; 
 Mon, 30 Oct 2023 04:48:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 az30-20020adfe19e000000b0032f7d7ec4adsm5262268wrb.92.2023.10.30.04.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:48:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 3/6] qdev: Add qdev_prop_set_array()
Date: Mon, 30 Oct 2023 11:47:59 +0000
Message-Id: <20231030114802.3671871-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114802.3671871-1-peter.maydell@linaro.org>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


