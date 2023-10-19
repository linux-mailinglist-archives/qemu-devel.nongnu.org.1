Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800C7CF0FF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNIu-0007Ii-LG; Thu, 19 Oct 2023 03:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNIC-0006Up-W1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:18:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNIA-0003Zj-CT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:18:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso460265e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699880; x=1698304680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aBA8vBsW5oLOBkcrZ5u16EetaBIuQ3o+kIaSqCZQsA=;
 b=T9M48cD9JiFxkMgu8cmwQRS6cx2LxmKubgnGyTIh/91/SsJIqG2i+M4fI6mXejGovU
 TUzrZjYpTTTM2a42ZeOoEqhV139aiC6n0eddNKsDmbuySh5hn92W8cf2xgIL2YpIMMMT
 CJCLXQMw4NgYoTr+G4XxLP+yMg6+bqqUqJzB+WzQiq2csshB8AYz28syQ0CqJeoJhH/k
 Er4twCO2bh7aDfsBdKk5U9ansovplN7a2EMJIWveLTP8rkasajbOtHw5hnLLHuREPiLw
 zuZs1k72OTc30QgP6HGgV5hEYHzcpiEs5Jbp2uK6SzW18niXL+CqICTwiIK1srYNYUf1
 TYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699880; x=1698304680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aBA8vBsW5oLOBkcrZ5u16EetaBIuQ3o+kIaSqCZQsA=;
 b=oOyybOCI4BgCYRXA5ZMRTy9Rx5COe8Ng3X6AMMR3WmiZdV9GoX2neoHXTE+TrpeeF5
 uaVZTH0InuJ/y3eXTOSvTf3kP/Qn4Hnz7VO81kyxx8ccqrbkWIB297E2WY08SmUtWJY8
 0YMXuiD+xyjxbZm9X1mFOhPxPA/9xW9NM1rhwXXQdU7VQ+NPNVD5eJjLH8Yylq90Zr/O
 vU//3qnGZKAJI/w0lAvXV7VlPDlXRJ9T+Uqnv2dMQMhUpWspllX4a2LzR/mARFHh6eN2
 XC3lOnVTH2sbiQpqQ20mIqChZPw+q6OK57lI7NJjjofwHnGVs6P07RWMI2eGInz0IkgZ
 vb4g==
X-Gm-Message-State: AOJu0YyefLiByIanzMueCPtjTi5Qmn37RX8jIWxZgWsVI+/IeQGqmmWq
 OTUSMqRxr5rQscVNIhAeB/q/27UZcIcws7+r8ckyMQ==
X-Google-Smtp-Source: AGHT+IEC+1kDBNVFHUpkBHXCFN7w0UauaweqYoYNxx88kM4Ods7ur6v23ie+MDtu6htyUo59COIIWg==
X-Received: by 2002:a05:600c:474b:b0:408:3d91:8251 with SMTP id
 w11-20020a05600c474b00b004083d918251mr988772wmo.5.1697699880555; 
 Thu, 19 Oct 2023 00:18:00 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c028100b004077219aed5sm3574562wmk.6.2023.10.19.00.17.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:18:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 10/12] hw/qdev: Ensure parent device is not realized before
 adding bus
Date: Thu, 19 Oct 2023 09:16:08 +0200
Message-ID: <20231019071611.98885-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

qbus_new() should not be called on realized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index c7831b5293..c92d07667b 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,6 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/ctype.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler)
@@ -163,6 +164,12 @@ BusState *qbus_new(const char *typename, DeviceState *parent, const char *name)
 {
     BusState *bus;
 
+    if (parent->realized) {
+        error_report("qbus_new(type:%s parent:%s, name:%s) but parent realized",
+                     typename, object_get_typename(OBJECT(parent)), name);
+        abort();
+    }
+
     bus = BUS(object_new(typename));
     qbus_init_internal(bus, parent, name);
 
-- 
2.41.0


