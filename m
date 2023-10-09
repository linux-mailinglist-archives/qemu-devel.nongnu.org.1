Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9517BD7E7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn7G-0003yC-Pp; Mon, 09 Oct 2023 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn7D-0003oS-TS
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn71-0000HJ-Sh
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so4323708f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845821; x=1697450621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSzCHIdmj0ACDSZfJdt/n9uVk8fHj/Z/ypjnOvyiyyQ=;
 b=VsSpVz3qWINYyFrX77Fht7WUw7EvnZhqvO1AWsKHj+npp/+nYRu33J9Ezl6w9RS18X
 Mcy1gJY5+J82CrV72YFFBltIZ4QR+F5CR8/LR9pc8To5efN4pIFRGGKG7sU9tiwe3E6p
 OjoKTDHvOjKxlefmec8u672hBLwTe+8C4rIYga72LqJ4TSreDITNR/IKnInNqlvEk4h1
 T7Y0pLdyvD+4+3w48Eg/NiHN+uH+TEE1yG8r5q7gNpmLBYIKptA+W8g15bknEysL+Jvt
 A1Gr02BoiA54lWWiuhknD3l54xhFf6gc166QY6okWVH7jmbo9fRJEXjwpd1IWNeKshYW
 YIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845821; x=1697450621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSzCHIdmj0ACDSZfJdt/n9uVk8fHj/Z/ypjnOvyiyyQ=;
 b=nSnqqm0hf8Q7nBO5x4GB5hSF+w5zXQzB4qLa0Z4JIWFwjzg++tQVMFjk5k65h6RpXx
 xGLQplkef9ToiDDor1IXQ0PhXbsOg1U1U02HwMJeMZKMXwRa/8knr0lDjX4eFYWatFME
 DcZWJJ0l1ZimqCHbG6G3Fu7ROjcQshbYVmWKaa1c0hjbt8g/AwZsKe+VJSmGG6v6rYW9
 +gx//6Tmnb4tFye+OzSutaBYMU8yGEGDubesdGl+Lxal30Ki0J9fquH6DdXGtJnj9soy
 ddNfAoT4s1khRzort/qDY6FLcq3jjsEQBVjJ0gs7KhK2Xt/wdzNNC8Fkp9BTfGM6Nvg3
 f69g==
X-Gm-Message-State: AOJu0YzjkFlyp5f/Mi+8fXKP3XH83Lbu4BUk7eLGuX2Zv5kSkfv7emQR
 HJSdc0WQPwL2EZG6pWiIsAXuebyaUVnzNsXnWZA=
X-Google-Smtp-Source: AGHT+IFB2nZB4K5M74QyfHCyq/txcHsLN0nGY1Qm5cF9Q436pg4ZOBegdF0q5DQUFpMzF4ckLHSPmA==
X-Received: by 2002:adf:cc81:0:b0:321:5971:23a5 with SMTP id
 p1-20020adfcc81000000b00321597123a5mr13194274wrj.20.1696845821011; 
 Mon, 09 Oct 2023 03:03:41 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 a11-20020adff7cb000000b00326f0ca3566sm9100072wrq.50.2023.10.09.03.03.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/10] tests/aio: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 12:02:49 +0200
Message-ID: <20231009100251.56019-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Rename the argument to fix:

  tests/unit/test-aio.c:130:44: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void set_event_notifier(AioContext *ctx, EventNotifier *notifier,
                                             ^
  tests/unit/test-aio.c:22:20: note: previous declaration is here
  static AioContext *ctx;
                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 71ed31a4db..337b6e4ea7 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -127,10 +127,10 @@ static void *test_acquire_thread(void *opaque)
     return NULL;
 }
 
-static void set_event_notifier(AioContext *ctx, EventNotifier *notifier,
+static void set_event_notifier(AioContext *nctx, EventNotifier *notifier,
                                EventNotifierHandler *handler)
 {
-    aio_set_event_notifier(ctx, notifier, handler, NULL, NULL);
+    aio_set_event_notifier(nctx, notifier, handler, NULL, NULL);
 }
 
 static void dummy_notifier_read(EventNotifier *n)
-- 
2.41.0


