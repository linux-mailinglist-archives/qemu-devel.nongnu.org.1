Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D214E7CC313
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsj6S-0006Zq-2g; Tue, 17 Oct 2023 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6N-0006Xr-L6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6J-0003ui-Dz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507bd64814fso863976e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545385; x=1698150185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ETA1o9XFiY+ehXIdPxFRChEwkK1zNu0/OcYc52Xsbos=;
 b=kpGR2zSUo+TP8poNQVX5jPs8qi7Qs+rhWPnX4WNclbTbWZqrQHfxohAQ1PX25VB+3d
 ohNwUePZh+0TjGvidaVAW3QivYSd+e36vC6Pl+g25tWSzyXft60m/aCy1/UWIiuA/ttt
 xcrYhOT1L/THKGzkKJ+yoP88IkNBUq4Ygm46bYdkQUI8Fdv+9iyMsh/WcYhxWDLFDBTG
 nRLxM6HDYvU2GFPT9/9OsYXM8z6Lwpuqia1zaDurgu6A4jziLxGcrr7jnXhe5afRpuSW
 JFjBEIZTI6sqjfkMuUgKE+IAh2FUQ8JXldPtP/R6IoZDM35sdXqO7hlC7fFpt3JOoLYT
 xjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545385; x=1698150185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETA1o9XFiY+ehXIdPxFRChEwkK1zNu0/OcYc52Xsbos=;
 b=KPQvG2knwDwbhYvAxRkUp+Swh406MqxV0nPsepwCDomsd7U57AFkb5/wYisQ2pVo2T
 p4qv/OekMAkjYvBK684J65jKc2gnTXXu3mX9qaLbb3voHgUbP97yspSO3cTZuE4JxuXZ
 1auISojWYabyTNzEMA0iQJ/64Q7DyYJ012xqStm138EiL8FyMugBTWt9F7ntZkvq8LnB
 VKQbAdbL2h6yHRyhV0k0H/fcEksvZFg0BmhQybNVagXWteldp01vVdlLlpplYnb38FPt
 0SGHh8/sPnwwWkxHnkLat2Ezo1D/Lj9LS+4YYsQaYEzVyI7MyAMUOSFmdfRMoI4pPLyq
 VmxA==
X-Gm-Message-State: AOJu0YzZjd3lSXz3KUFDtdw/1wvV1cFINvjXmcZNod4rt4OROKTXzg6l
 SrItYoAK/UraF3OiX66oZQzRVA==
X-Google-Smtp-Source: AGHT+IE6SjZ0O37RftJfpRPdQLcvWIZcSPsbQnfCbJ04wep8l7VnHQ+ip9iwlwv6Qf2eywjuBuDo0A==
X-Received: by 2002:ac2:4ac7:0:b0:507:b836:f836 with SMTP id
 m7-20020ac24ac7000000b00507b836f836mr1395686lfp.0.1697545385607; 
 Tue, 17 Oct 2023 05:23:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0032da4c98ab2sm1590905wrs.35.2023.10.17.05.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:23:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/6] qdev: Add qdev_prop_set_array()
Date: Tue, 17 Oct 2023 13:22:59 +0100
Message-Id: <20231017122302.1692902-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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


