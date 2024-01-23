Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBF839302
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:36:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIoj-0005vm-8t; Tue, 23 Jan 2024 10:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoQ-0005pf-I3
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:42 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoN-0007De-6a
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:42 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55a50649ff6so4849059a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706024135; x=1706628935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyDmVSFodOYjD4FiRaNUUzftXSYkP1NTnuHNRCor0SU=;
 b=CIS43d6FXvqw7jlMOmse29woBUx7amPXUP1qkRWixpqvAJC42nG3PAYiRorIq3WNWB
 XyjNnqybHhgWkLnUZNzjY0N/ktMkM6gjLYAZJ4Q8fZhESiIXTaJEWfyiA9y88W3I5/sx
 JXjzuQAz7AEN8N3MZ9hqNwgmYl5CaWoJHqj5py+anbmvVKno+jGwjXg62RvRAiy7tv6y
 OZj+g9nK1gPylmyYHRwH72kP0F40XuxoDBTprArJL+i+tYeYYySB7aH54f+0Czl5m/VY
 T8SRbaL8IPx24XcBbxb7AaLtOY6nJ9QrSvSh3/m64I2ohjtCzvoVV9M9pnNdKblpJbdX
 w5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706024135; x=1706628935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyDmVSFodOYjD4FiRaNUUzftXSYkP1NTnuHNRCor0SU=;
 b=kQDKObQfuSuE3WRWIaYfq1rioGl5QKG3roPjZJcTH6aA7nP6Rj7VymuFBb9+gqjwbp
 5c78mgPi/0MgW3B4RDaDai8R+o5lwoc12teJt16FbDOEBtrI6EJO+xqiKW70bRKuFWiK
 hqgafUQ7fG6fTSt80DB13DRuH2cnSCQHdG6TSQgxz4RKrurPRlRNuogDJqT9SjkKX6dF
 rzIpZy7sLPHrKzHKM7cJnTXV2c+Db0wqwwCc4KNMEvZNgzw3E2zpnMs/idRMSU2PHocr
 Tspnno7N+A68nWhxUuqa13kqjxL7kWFn+pQVhX2c6HJmdKEHfbBFjY5IHZ+wgVVxhTgc
 Mqsw==
X-Gm-Message-State: AOJu0YwCIgXe8MiViMgfOvoBxkumBC161HN7nBr3Ed0NmoEOhhv7DxCH
 xJDEdZFiVCw+1X0/8ED4tGvTosfEreuBWDf42fBE/BmTXhDsnJ5P1EgYqA7mgnvZb5g6IYbgtQr
 vRHA=
X-Google-Smtp-Source: AGHT+IHC7ijLeFSdFJmKLFx91WgyjZEoJBG8XtPwyBX57dmNybtyc4js6ymQgY0++9kzWUQDGxdn4w==
X-Received: by 2002:aa7:d9c4:0:b0:55a:60ca:fe35 with SMTP id
 v4-20020aa7d9c4000000b0055a60cafe35mr953263eds.56.1706024135520; 
 Tue, 23 Jan 2024 07:35:35 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 cf15-20020a0564020b8f00b0055c903e61easm484663edb.82.2024.01.23.07.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 07:35:35 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 1/2] hw/core/qdev.c: add qdev_get_human_name()
Date: Tue, 23 Jan 2024 17:35:30 +0200
Message-Id: <5fb58797083e7786fd3556d2c247609565b8637d.1706023972.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
References: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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
 hw/core/qdev.c         |  8 ++++++++
 include/hw/qdev-core.h | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c68d0f7c51 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -879,6 +879,14 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+char *qdev_get_human_name(DeviceState *dev)
+{
+    g_assert(dev != NULL);
+
+    return dev->id ?
+           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
+}
+
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..66338f479f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -993,6 +993,20 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_get_human_name() - Return a human-readable name for a device
+ * @dev: The device. Must be a valid and non-NULL pointer.
+ *
+ * .. note::
+ *    This function is intended for user friendly error messages.
+ *
+ * Returns: A newly allocated string containing the device id if not null,
+ * else the object canonical path.
+ *
+ * Use g_free() to free it.
+ */
+char *qdev_get_human_name(DeviceState *dev);
+
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
-- 
γαῖα πυρί μιχθήτω


