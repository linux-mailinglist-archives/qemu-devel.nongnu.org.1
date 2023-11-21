Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342B7F3522
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:42:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ukg-0008Uc-IA; Tue, 21 Nov 2023 12:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Uke-0008Ty-MW
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Ukc-0001Kn-4l
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083f613272so31617495e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588488; x=1701193288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLvcXpQco99sa0+Z1Qj96SBcGgbn4oS7DYVe2UC+AGE=;
 b=lN9xlfjc+TqtWvYl4GApf6dvwQJ5fKLq8/U8Qh/fqepQD3cKIecXgYv9T0MzOR4rRd
 /qbKPF+D7/kbDdM4vULD8vXkkwa+GSxf9/R3ummYrKO9mOfSHT4HbCzhHvcGC3Nz8J2N
 BiHvmkztAXbBOvADszrT4ZfmGq++SKms7FadSiVG52URDskt7n/zyAWBqysadS/WfaAf
 d/jRn10MfZ9e7K2Q1rRxnZZShShgZGHYOJtGFlmS4T+1fkjzGHbH20zB1XZb6CRusjn9
 fneXW1VpDrKeT3pABhDWEQ99s2Qg56wf6sEj6cY14QWMNKaMUP4m+pcmHhXscGQw+UBh
 agLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588488; x=1701193288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLvcXpQco99sa0+Z1Qj96SBcGgbn4oS7DYVe2UC+AGE=;
 b=JC02pJhZfda6+qgKr6KQb1CAik4ocpqT4lOM9QE/LapRxpU8oH+ecZ33dM2NKIMNra
 L7gQKcDZi+BFOYXon4kZ0KihNqXYKHMvPcaX3ZWM3Zd20UNJFMtShRd3D9M5hC91HSSA
 6z/DSjGUcbW1TNlVNRFIrvcVmE+2J+IoR1zWXSUfQp4eHqTrvoUV63suFDAgzJV77u8B
 tvy1etJx7kOpfSM0hgz7IIJ7+xI0n6bV9C4qRVfMWx6Ra+3Vf3eQNgG1e5YjMwYIkE2Y
 3ZU9RniCi5BL9g5ca5pGXxRcfF+Sc/br4UEH8pEzYENtIFfiqDqyAXpW7mtkmOHJ3BEn
 5UZg==
X-Gm-Message-State: AOJu0YzkAj5vjZSrtHSH8cDKfKY9dEGPeHNOTZaWHAurREwa+2btFQnb
 ydGUDZEvAw6S/JzcDCSNuN+LxV/E8M1JaUmZWzQ=
X-Google-Smtp-Source: AGHT+IGHVGKFxburPV8+OPcDcSlkReHX1Kc9dILYPy0rJ2ALh04RoVy2ObtFGWRbu2+42cJ+mJwMRg==
X-Received: by 2002:a05:600c:35c9:b0:40b:2a20:3d3 with SMTP id
 r9-20020a05600c35c900b0040b2a2003d3mr32186wmq.30.1700588488447; 
 Tue, 21 Nov 2023 09:41:28 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 h18-20020a05600c351200b004063ea92492sm18045128wmq.22.2023.11.21.09.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 09:41:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 6/6] hw/input/stellaris_gamepad: Free
 StellarisGamepad::keycodes[] array
Date: Tue, 21 Nov 2023 18:40:51 +0100
Message-ID: <20231121174051.63038-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121174051.63038-1-philmd@linaro.org>
References: <20231121174051.63038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Commit a75f336b97 added:

  DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
                    keycodes, qdev_prop_uint32, uint32_t),

but forgot to free the 'keycodes' array. Do it in the instance_finalize
handler.

Fixes: a75f336b97 ("hw/input/stellaris_input: Convert to qdev")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/input/stellaris_gamepad.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 06a0c0ce83..9dfa620e29 100644
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
2.41.0


