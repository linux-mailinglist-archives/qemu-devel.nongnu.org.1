Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB12821F37
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:07:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhGj-0006Hs-7H; Tue, 02 Jan 2024 11:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGQ-0006Dn-J9
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGN-0002bo-1p
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so54593985e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211504; x=1704816304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVl3cttQKDPPU7GqDBLczNEA1v4uR7uW39llQJlVRbI=;
 b=CLftFzGqukIDPysFORoEwcodOyqQQn9lZIVx9iNBxx3upXjybY0KP+wKv0KfLAWI3f
 v4lI3/UqSuV2N+DeZ6UNcAz7rbJRyI0rMf5Lf5FburOMKHHR4c3w/kbAboRh7hMaXfMd
 mMcjG0xI1O86vX1DmItVdP5YyhJNm1pxDXzs7NI7v2yM6zeQJmlwqRU6CDqxtaxABDFt
 daLtTdvRDrjRknzVmr1yRSpg1WfrRfmALKidL2FzLq9y/ZawuwySOA0peBRaqh7iqfm1
 2ECxgPxtEzjAhL6CeYcirmoTz1tNYIb80+2wCKVbr216uVPPJ+XHPPAF09byCxiGqPvO
 0t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211504; x=1704816304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVl3cttQKDPPU7GqDBLczNEA1v4uR7uW39llQJlVRbI=;
 b=TaQHTmoJU4s+GFEdfNHQnAjunMfwK8Wukrln6m8F3/GEQeJd946d0BtmErTbA8hgIL
 PmVxyuybyn1rFunGBjafV08Vqj9hS3C3UFBGmm5ZHvtoYyPmgcxxZ4Gf0yrfICQkl8ra
 Tj3X0i6gk6RJepeztwNLtGT7Zad5F0Iws1AA+TZlDwsmA+VBotYhuG7z68EkHxtpaRsR
 hTGkw6+poL7ER1pcQdl/HRI7QG8Tex0ryoqC1+lop0+mO7mBCbc2/Bcmya3aqQZdwuZR
 xXSfB7CCr6OE9Mc+nqUIjUQRIH8utL/NUjwMk9bKL2FU2HqZje6xNjrTAJfi6L3siq6r
 d/EA==
X-Gm-Message-State: AOJu0YwUgPE43rT3zS9WhMmKoVWoMQAi7tY0yH1biBG7VCzyIMdm5Cpm
 5hRY24uCS+BmTrTmp5VK7Y7vyDj9/toS0kKkRSryPxIPfAQ=
X-Google-Smtp-Source: AGHT+IH+Obc3ne7AAB3LoQIBsTVjLSH2urrV19UtpdDS4OFzucuPmDYGorqkMdUbkefjSu8sXVfrDQ==
X-Received: by 2002:a05:600c:4713:b0:40d:734e:665d with SMTP id
 v19-20020a05600c471300b0040d734e665dmr3139136wmo.41.1704211504678; 
 Tue, 02 Jan 2024 08:05:04 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm45314295wmq.27.2024.01.02.08.05.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:05:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/5] qdev-properties: Add qdev_property_del_static()
Date: Tue,  2 Jan 2024 17:04:50 +0100
Message-ID: <20240102160455.68612-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
References: <20240102160455.68612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

We can add properties with qdev_property_add_static().
Add qdev_property_del_static() to delete them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-properties.h | 2 ++
 hw/core/qdev-properties.c    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e..0e1930177e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -225,6 +225,8 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
  */
 void qdev_property_add_static(DeviceState *dev, Property *prop);
 
+void qdev_property_del_static(DeviceState *dev, Property *prop);
+
 /**
  * qdev_alias_all_properties: Create aliases on source for all target properties
  * @target: Device which has properties to be aliased
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7d6fa726fd..0c17a5de82 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -994,6 +994,13 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
     }
 }
 
+void qdev_property_del_static(DeviceState *dev, Property *prop)
+{
+    Object *obj = OBJECT(dev);
+
+    object_property_del(obj, prop->name);
+}
+
 static void qdev_class_add_property(DeviceClass *klass, const char *name,
                                     Property *prop)
 {
-- 
2.41.0


