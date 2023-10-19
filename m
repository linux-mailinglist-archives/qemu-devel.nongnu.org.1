Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311A7D03F4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRn-0000nn-2f; Thu, 19 Oct 2023 17:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRk-0000cZ-Cv
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRZ-0005bU-9T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso104055f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750436; x=1698355236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Si0DsDiy36BQtzeYXOqgI06tIdtT+TQj4MXOqeI0hyk=;
 b=kIM5z9uH+FFeJPRWS4gQyanyoY0XCbVJ0EEHAsI0lT5UlTbH2faIkbM4Ld0USmnhZm
 bO47wukreg3HlPGALSgA23rkRaRNC5ggaLtzaqZBYGpBK5pizz6sx0vbmCppQtaW5DhY
 0VkTfBrPSciTVibfJcylciRXotwYZM4NHWegoTyizUuoReN2/AKhiRcA2rIYKXKVNm0E
 lPGIehXo0X2/AuzBmhaDuA74kjK0cNYdQYPkrz3iQ4r6F5balBLAly7xG+aLlyiTMe4S
 KXJKR2f+A+ydWGxI5QPH2IE6Jlng446cGNqJ8eocVrs+K0tLFkOsjcoi3vRGFaeEmXTN
 itbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750436; x=1698355236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Si0DsDiy36BQtzeYXOqgI06tIdtT+TQj4MXOqeI0hyk=;
 b=PR+jM1AKUoD07LnfF2Pp1en3rtDwyqrbUtqwj+wZqCLlseTX6UwmOHU8F4LsWbMsT+
 XvgW6/tAdBuaE+cq7isaVAPxIXS2ACx8tao2SBW8Cads5KJZBWyCbKVw+WIg64rNIKKN
 7NM4PU+8pkUfvxR204rl/JfSNXrEFVLlkkhJL+poTtXDzyRM8xB4KPs+1d5iViDxqMDd
 MlhicmLOMnquDEWq7cS1JvwK19yjuZDWW+3n3tpbnMUgIdK/8cjXKrArseYKY0WsWxai
 hrDuulTTwb5kKEUa78IR0kq97Oam+NmZfSGiqpQkdiCoAPtOjoiq29ihYf2e6xik0WKn
 fp8g==
X-Gm-Message-State: AOJu0YzYdgfcZ+e2FxvKUNy46c22s61xgq0hVpa9quJ5mQ4Fe1Brxid8
 ZNhFx356w+V92MA5v2c+rGx4iWU29bxwOoDsiKTumQ==
X-Google-Smtp-Source: AGHT+IFvITzFiLPMskf/GbGdfoIzC7S+QBjZMzmg1v9ES6bxQ7ClujPkx9nkeKn4zWoPgif7Y1H5jA==
X-Received: by 2002:adf:f190:0:b0:317:50b7:2ce3 with SMTP id
 h16-20020adff190000000b0031750b72ce3mr2485494wro.51.1697750435854; 
 Thu, 19 Oct 2023 14:20:35 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a5d68d1000000b0032d687fd9d0sm228826wrw.19.2023.10.19.14.20.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 21/46] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Date: Thu, 19 Oct 2023 23:17:46 +0200
Message-ID: <20231019211814.30576-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Fix:

  hw/s390x/sclpquiesce.c:90:22: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      QuiesceNotifier *qn = container_of(n, QuiesceNotifier, notifier);
                       ^
  hw/s390x/sclpquiesce.c:86:3: note: previous declaration is here
  } qn;
    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20231010115048.11856-7-philmd@linaro.org>
---
 hw/s390x/sclpquiesce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index ce07b16884..a641089929 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -78,12 +78,10 @@ static const VMStateDescription vmstate_sclpquiesce = {
      }
 };
 
-typedef struct QuiesceNotifier QuiesceNotifier;
-
-static struct QuiesceNotifier {
+typedef struct QuiesceNotifier {
     Notifier notifier;
     SCLPEvent *event;
-} qn;
+} QuiesceNotifier;
 
 static void quiesce_powerdown_req(Notifier *n, void *opaque)
 {
@@ -97,6 +95,8 @@ static void quiesce_powerdown_req(Notifier *n, void *opaque)
 
 static int quiesce_init(SCLPEvent *event)
 {
+    static QuiesceNotifier qn;
+
     qn.notifier.notify = quiesce_powerdown_req;
     qn.event = event;
 
-- 
2.41.0


