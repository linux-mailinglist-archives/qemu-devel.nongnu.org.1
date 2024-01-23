Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6183888D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:11:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBqb-0001Ox-M7; Tue, 23 Jan 2024 03:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSBqY-0001Nu-Bc
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:26 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSBqS-0006mg-4M
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:22 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so4647127a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997358; x=1706602158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkmrsuVbgTF+za7ZMeDRDBZqRcm/2ztx9jMk1UJC/m8=;
 b=UiYaIKIB4tO52m8T1dfwXppozp/PGOyvgrNI2fRTrbGHyaSlPRlBikyKQnBAwTLgjg
 MEVrXE46HgxQMOpL+5HY2coSeeVJKFESuwOp6IDFedEDgs5Id1lAf7f4WkuxR9HnT/Bb
 MnDNZMNMKQ5qBJfzyxCjqgA/WP+Xc2FnorWTnkRyVUr174oL++4/yWoFFv+uJveTkSjv
 boIx+79L+YREW1Pcys21HoPcZ99qVn0rC52NYU1dfsStRMM4mA3hQEjiVIlWS5lvNUGV
 MVHsEUCPagnv9S1uHxlnIT9+Xc0aS2FHL/GNkZzJ0ybGE245AXp5EoY3xXQtVefPJD4n
 P2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997358; x=1706602158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkmrsuVbgTF+za7ZMeDRDBZqRcm/2ztx9jMk1UJC/m8=;
 b=rd0plafXzfZwH5H2re+AolCP//yeN4vP+w8QKesDgkOrjEWhL26YU2/n1mT0qRM5gm
 YkUS0N+HBMqn8yJwzy+K0xIAP7OQW1mXtzPWqyaEidFAlA4uvk1+qH834+UBTQO1wvC3
 FAQQV8COH/nOnQ6OKRz4+Tu47R7vU2tP7NFWmtjVrpQytBoQnOnfQWVYb2WXQc4W4aI0
 EcFZQbNvMmNC2QJ6WhbikyKFHJTSv6W8qsya4vrdNvAkhQKdoGg7ESBOEl+MswptycNW
 yYWnbHxB2gEIQxFaF/AxQPyijXiJysacQmTd5GCGwwCOgoeKTD/6MzjvT92bjcVGRlHi
 UjVg==
X-Gm-Message-State: AOJu0Yxs0muL/s6p8g01QHXVp9NbXGfVhNpT9jFYlAevs33xL8JiQ1B1
 Fim5RerOAexwt4AweCFnXvUtVUrEzFaNKZ1egXdZC35c3HMDS8XJUvO8DrW6EbJKg9MvwBFXpCL
 T/Ls=
X-Google-Smtp-Source: AGHT+IGwNQnyGLhF25UbZLdaMt0Q9/tAZqtdtfe62R9H1jtMGBD9Yz8EMeq5zFQ5sRmxMr5h4qcxHg==
X-Received: by 2002:a17:907:6899:b0:a2c:8dba:eb1b with SMTP id
 qy25-20020a170907689900b00a2c8dbaeb1bmr1588204ejc.112.1705997357765; 
 Tue, 23 Jan 2024 00:09:17 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 tb21-20020a1709078b9500b00a2f24da8baasm5794069ejc.39.2024.01.23.00.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 00:09:17 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/2] hw/core/qdev.c: add qdev_get_human_name()
Date: Tue, 23 Jan 2024 10:09:12 +0200
Message-Id: <15b15d6d4f2a1706b5e2d85ab18e25bcb03e72c2.1705938003.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
References: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Add a simple method to return some kind of human readable identifier for
use in error messages.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/core/qdev.c         | 10 ++++++++++
 include/hw/qdev-core.h | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..499f191826 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -879,6 +879,16 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+char *qdev_get_human_name(DeviceState *dev)
+{
+    if (!dev) {
+        return g_strdup("");
+    }
+
+    return dev->id ?
+           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
+}
+
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..a8c742b4a3 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -993,6 +993,21 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_get_human_name() - Return a human-readable name for a device
+ * @dev: The device
+ *
+ * .. note::
+ *    This function is intended for user friendly error messages.
+ *
+ * Returns: A newly allocated string containing the device id if not null,
+ * else the object canonical path if not null. If @dev is NULL, it returns an
+ * allocated empty string.
+ *
+ * Use g_free() to free it.
+ */
+char *qdev_get_human_name(DeviceState *dev);
+
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
-- 
γαῖα πυρί μιχθήτω


