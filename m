Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F252878EE53
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:16:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLM-00089R-Jy; Thu, 31 Aug 2023 09:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGz-0004pQ-OA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGu-00065p-IY
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so7216475e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486779; x=1694091579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ur9xi937dzz6Bl2U4bEFfYnHfQ2+6Mk7VLbsIy+yiQY=;
 b=p93qFbrXQ6SN01gFC+mCDwinPT864Vc7iDNXuSaBjHtdOEM6rBKil8dKQMPYY2qjUY
 OtECUlmpp0yZSFIxBJB6tJq/vCr3YSyj+aM8gKaY63Yizrw5i60UeqyprRtf2k/ie+Pi
 hYJ86rk0Vu59s3rdEe3YbLm5746nZv6Wn+DU6nN6tsMEARtzQewj2zH+gG7x706l8ADh
 1di5McuhMV0ZrWI+0aF8QQaq8m2M8XBvqTi2sTkDAaYHIPK/ib4NpVwFh8chxmWXTHOp
 OIO0FiXolg9WGjacQB/aIjGDDUCe/MVhzPzFvOQnGjKUKN7jipPA4ZFZ1WZ/FftdDV9N
 usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486779; x=1694091579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ur9xi937dzz6Bl2U4bEFfYnHfQ2+6Mk7VLbsIy+yiQY=;
 b=Zrz0pVpYdpzEzFx8FuB03/3U8/F8UXFJQjjEXs/AnhMMJRksHslFUKZxUjo1TQWN1r
 vldWIxUYBPQmyQmf7kW30lX/GCdvTON3nOghj9x0ITxSFF0BpEW/kcZJ+UNp01+IPcu/
 bS/8ntlM5n5RVwredHh9Ib1BU0qksx3qROj54gF0ZJMC2eIwV/yHJ26+G9q94K0dl1Q1
 r7+UGKSRcM3aKPChbUuxtl7Wg9f49WdJ1InYJ1hL0fKkCtQheBOOwM02ccxbH4Ql09+h
 BM/udhbxmQL9QKXStDr5AsnP3JnPhcDbFtLJ3l2WvVOoO/eDFrhpdOaXIjDt9mZYjgAP
 lIHw==
X-Gm-Message-State: AOJu0YzB+iksPTWm4Ea9qrUQbYIlcqyL1/DBDMx9XpScOx5qOYdsD8BF
 Wtkty62HPtcTJszzesNeROUPynZwR9WFWfVFDrc=
X-Google-Smtp-Source: AGHT+IFqinXDk2baO7sSaMza/9NPra0g8C/2PjSHejWBb1jQQgc23npbEqzbt534RZO28ZwbkvpYww==
X-Received: by 2002:a05:600c:220d:b0:3fc:92:73d6 with SMTP id
 z13-20020a05600c220d00b003fc009273d6mr3971473wml.11.1693486778822; 
 Thu, 31 Aug 2023 05:59:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adff789000000b003180027d67asm2141739wrp.19.2023.08.31.05.59.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:59:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/41] hw/display: spelling fixes
Date: Thu, 31 Aug 2023 14:56:30 +0200
Message-ID: <20230831125646.67855-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230823065335.1919380-15-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/bochs-display.c | 2 +-
 hw/display/qxl.c           | 2 +-
 hw/display/ssd0303.c       | 2 +-
 hw/display/ssd0323.c       | 2 +-
 hw/display/xlnx_dp.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index e7ec268184..9138e98c3b 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -164,7 +164,7 @@ static int bochs_display_get_mode(BochsDisplayState *s,
     memset(mode, 0, sizeof(*mode));
     switch (vbe[VBE_DISPI_INDEX_BPP]) {
     case 16:
-        /* best effort: support native endianess only */
+        /* best effort: support native endianness only */
         mode->format = PIXMAN_r5g6b5;
         mode->bytepp = 2;
         break;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f1c0eb7dfc..af941fb0c2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1544,7 +1544,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
     }
 }
 
-/* return 1 if surface destoy was initiated (in QXL_ASYNC case) or
+/* return 1 if surface destroy was initiated (in QXL_ASYNC case) or
  * done (in QXL_SYNC case), 0 otherwise. */
 static int qxl_destroy_primary(PCIQXLDevice *d, qxl_async_io async)
 {
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index d67b0ad7b5..32b32a3044 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -8,7 +8,7 @@
  */
 
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
 
 #include "qemu/osdep.h"
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index ab229d32b7..09b1bbed0a 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -8,7 +8,7 @@
  */
 
 /* The controller can support a variety of different displays, but we only
-   implement one.  Most of the commends relating to brightness and geometry
+   implement one.  Most of the commands relating to brightness and geometry
    setup are ignored. */
 
 #include "qemu/osdep.h"
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index b0828d65aa..822355ecc6 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -380,7 +380,7 @@ static inline void xlnx_dp_audio_mix_buffer(XlnxDPState *s)
 static void xlnx_dp_audio_callback(void *opaque, int avail)
 {
     /*
-     * Get some data from the DPDMA and compute these datas.
+     * Get some data from the DPDMA and compute these data.
      * Then wait for QEMU's audio subsystem to call this callback.
      */
     XlnxDPState *s = XLNX_DP(opaque);
-- 
2.41.0


