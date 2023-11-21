Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6A7F3523
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:43:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ukb-0008Pl-69; Tue, 21 Nov 2023 12:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkY-0008NQ-Tf
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5UkW-0001Jc-En
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so24118945e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588482; x=1701193282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iW4GbGx1UKeBuWo5IN5MHnetcyTDNo6L05KNntf8yQU=;
 b=NWy8vfgfZBsG0J+ip2DRxRSYOMiWo0btr/4KWGjGCod4LqmqvAdoLFPuQLCGt1KJyH
 LR+qo6ItxhRGYxz4FOdgHOhAYTC+KsB65DwFaoQIQtOWwQLWL9wF++OtRQbnN/3x9lJG
 a7hssCJSxeUoZsneG38NkkM4aVweoln6GMoe3zF3EeACmProssnz2SKUGLIZRkVm7KYo
 msp+Rc6U8bHSzbhD15WpwWwmKCHWLKPUKsUsAKhRbl0Kepsx31oDPUHdICT/XH/9jbKt
 fAKKCkMaNf0WuilBnMqK/TKIOkqAOXHrpIp6VEiMdsleX0o+924SMI7bVrZaRhDUtByd
 np9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588482; x=1701193282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iW4GbGx1UKeBuWo5IN5MHnetcyTDNo6L05KNntf8yQU=;
 b=wj/9LsiQk4rpuKcV2fGj8o0Ny6lo7ShpmVsLf0e2l32t6F4gh/lXU5p93jxuO/IGwl
 Wips1KH/BAvqSjc1EXzXefh+NWxQU2SPBEsWYxMxEXjUOXsM6qI0phUwF7xAwelpIqnU
 8okMplpC9D1BsD5UR2MIaCCZUaq5jjC+/EWXIKYncQI6kK+9x/F3d42Wi59YR3nZdffT
 5nk8K1Gn+9xoxYr7WLpIYWuWWyzR++sPUu+orVgRRAFhkD94+0UldCXDNKuTJNsB5qGy
 83SI+dyVghV6DzsvH72KVvi3qjRy+SFuCKunj+LrvWK7N+F6nIsjVgDAsVkPbAXJ8Ewp
 2dNA==
X-Gm-Message-State: AOJu0Ywy7Ziryv+NGHomQisvvSpXatmtLazW8vt+GtYxJUyndzMS/hCP
 59DZ+pdmeSbtxXDd1fS6bUXbQ2GCJv9kc+drdLs=
X-Google-Smtp-Source: AGHT+IHW0fAcvFPF7LgXXhrbf09snejqukoxr7+XwrR9MZy9hDLv4rujTlAMOa2gwAY3uQ/ZIVVM8A==
X-Received: by 2002:a05:600c:5127:b0:409:79cb:1df6 with SMTP id
 o39-20020a05600c512700b0040979cb1df6mr44139wms.14.1700588482749; 
 Tue, 21 Nov 2023 09:41:22 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c00c300b0040648217f4fsm21512532wmm.39.2023.11.21.09.41.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 09:41:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2? 5/6] hw/nvram/xlnx-efuse-ctrl: Free
 XlnxVersalEFuseCtrl[] "pg0-lock" array
Date: Tue, 21 Nov 2023 18:40:50 +0100
Message-ID: <20231121174051.63038-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121174051.63038-1-philmd@linaro.org>
References: <20231121174051.63038-1-philmd@linaro.org>
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

Commit 9e4aa1fafe added:

  DEFINE_PROP_ARRAY("pg0-lock",
                    XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
                    extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),

but forgot to free the 'extra_pg0_lock_spec' array. Do it in the
instance_finalize() handler.

Cc: qemu-stable@nongnu.org
Fixes: 9e4aa1fafe ("hw/nvram: Xilinx Versal eFuse device") # v6.2.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/xlnx-versal-efuse-ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index beb5661c35..2480af35e1 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -726,6 +726,13 @@ static void efuse_ctrl_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
+static void efuse_ctrl_finalize(Object *obj)
+{
+    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
+
+    g_free(s->extra_pg0_lock_spec);
+}
+
 static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
     .version_id = 1,
@@ -764,6 +771,7 @@ static const TypeInfo efuse_ctrl_info = {
     .instance_size = sizeof(XlnxVersalEFuseCtrl),
     .class_init    = efuse_ctrl_class_init,
     .instance_init = efuse_ctrl_init,
+    .instance_finalize = efuse_ctrl_finalize,
 };
 
 static void efuse_ctrl_register_types(void)
-- 
2.41.0


