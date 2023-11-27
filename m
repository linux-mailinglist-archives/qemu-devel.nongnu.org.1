Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 209937FA78B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6E-0007WM-7Y; Mon, 27 Nov 2023 12:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f63-0007Sb-JT
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f61-0004dj-9Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b427507b7so12741075e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104911; x=1701709711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VSnQX/38IwFzIkR+hMTwUicJZArqSWcbr4ZMRYvD5BY=;
 b=rhMUlqoEdFFGmU1/to256yLyud9WNgJ7p6ROHKvXALTWU2laNm9oMASpYjSXZMZKyg
 2o/GMmwjdhVoJOOU5+ILTQULb2jRXTa2dqd3/s3YBJZ/JmrssoNyNE2avRZBKvRCW6JE
 tcIxO5NPB3CB24gnzadA2v9JckcWbBTa068lYqZCEk0BaSH7VN3F8RIpQ97OU+59PK+K
 rqaH58IOogSZctUv25yvs8u8X3Yy2CMCXFZN7JJSatXNdZab7i8Ny4WqHMxaglfatsYN
 W1YS088jx15UN0H9LaAE0mI7DVi2PVCMVnjtQjfkwYM95Kiez2LFXiAn/JdZ6v+mte71
 DVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104911; x=1701709711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSnQX/38IwFzIkR+hMTwUicJZArqSWcbr4ZMRYvD5BY=;
 b=CX48ypNMHG0bsKCds01VGNXQFJTJRuSAq/0Wunja3k25uBAsULwKwolF8RMuG6td2G
 LrMMditP1IH39Zxgwjt/CjC9iaOoyJ7AumrQmQXHllY/3aSF3irhH+GUQVuO4lGDCj1v
 lRJFr+7VIQhPc4oAwcQk6BbdSHaCfFStOR59XsAEI+ewOWu+FyQbCJ0F1vEoiIdwBI7G
 OLlaMrXBzhz09vg+AYgCB6bNviUF+pMxq882GTxVQrpEIP43Elmgup3Nw7ZRWpJdWm6W
 HD3sC1CnK8zNsBx/3bYt9eb+jnOCwE2YmhGhW4Q+CUWNy6i+nyCr92ymOSCFlCafiCey
 TaWg==
X-Gm-Message-State: AOJu0YwfD3SNWmGz4DGaRAgIOF+3z5tbXkxZmXJhh4rj8bD0/ntQjPBK
 PGWSS99Qg/jLm+5ifuOSxCptGwQ+FCaP51ypL08=
X-Google-Smtp-Source: AGHT+IEwxhzwsyGSVN7pY2EVQuoIAKsonm2kqCrh/byTAyeszfkdF85ds6vTdQPR8j+Bxx4MlhpceQ==
X-Received: by 2002:a05:600c:4ed0:b0:409:5bd2:aa00 with SMTP id
 g16-20020a05600c4ed000b004095bd2aa00mr10374989wmq.41.1701104911131; 
 Mon, 27 Nov 2023 09:08:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] hw/input/stellaris_gamepad: Free
 StellarisGamepad::keycodes[] array
Date: Mon, 27 Nov 2023 17:08:20 +0000
Message-Id: <20231127170823.589863-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 0be6bfac62 ("qdev: Implement variable length array properties")
added the DEFINE_PROP_ARRAY() macro with the following comment:

  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.

Commit a75f336b97 added:

  DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
                    keycodes, qdev_prop_uint32, uint32_t),

but forgot to free the 'keycodes' array. Do it in the instance_finalize
handler.

Fixes: a75f336b97 ("hw/input/stellaris_input: Convert to qdev")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-7-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/stellaris_gamepad.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 06a0c0ce839..9dfa620e29a 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -63,6 +63,13 @@ static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
     qemu_input_handler_register(dev, &stellaris_gamepad_handler);
 }
 
+static void stellaris_gamepad_finalize(Object *obj)
+{
+    StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
+
+    g_free(s->keycodes);
+}
+
 static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
@@ -92,6 +99,7 @@ static const TypeInfo stellaris_gamepad_info[] = {
         .name = TYPE_STELLARIS_GAMEPAD,
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(StellarisGamepad),
+        .instance_finalize = stellaris_gamepad_finalize,
         .class_init = stellaris_gamepad_class_init,
     },
 };
-- 
2.34.1


