Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ABA7DA6F2
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:25:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiMl-0006Lf-VZ; Sat, 28 Oct 2023 08:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMj-0006Km-Qr; Sat, 28 Oct 2023 08:24:33 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMi-0006la-5o; Sat, 28 Oct 2023 08:24:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso185392166b.1; 
 Sat, 28 Oct 2023 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698495869; x=1699100669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3625XLI1M77/QNI0XDsoa+gao97xuom6mXxW++PFOrI=;
 b=Rw24mKHxFlHKhVNRPzjOcT9CnTTyt8oCFbt2CYJ7esLoJUFHOHpz2g5wXDKm9lOLob
 m3tX7Am9pKNXZKFOM+gne13n+bWHBN2Vn7KW0i93BcbBFAWngJPbNQC+DcjiXzC6VrDR
 zNUAECk2rfwsqKhOXMgChxdgsf9GzuWoAAFUhzQs1nqibj1ZHKzO4zZWzFY3vnBNDKaM
 EKTt5LoQaTsKtDJp4JXDs++Idsk9Bk/kQLL/41n1OcI0/6h26XoJG3byQ+h+8goUj9mY
 HC47n6V9C87frxHA4DC6ubACzJDR5ZflVRjylOahv+ZHFBYIVLyi2Nt11RypIPN4jNww
 0U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698495869; x=1699100669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3625XLI1M77/QNI0XDsoa+gao97xuom6mXxW++PFOrI=;
 b=BEAa/psDC0GcQFygQGiFQGHLAFFRQEdR1a3olsYLxnbxOtWjOxFpLqe3YNfhDXkVfF
 DWq3TtLQfOJbg5AQSWmWxKmR2zpxhRtLomT6ZC/8mtxNcNLOU6n5xvXzgVhfin/Vwc+c
 m9OkkWPM0+sIVCFiP63QEAngKzBjGUQpgo8dLWUdQuYaJRt//M16ogClur0YLmyQSFmO
 BYYMbV5khbcQDDbKTY6oo1LotkCr2TgX6Hz+piwMiHxB2HzDno1cEOOkwoutp3GieMPi
 rQ3et20J7Pdq+u4RB3lYtEQmk122ipeNEJ6XBXQ88DuLJVweHaB850npoujdlaQ2Z82L
 IG2Q==
X-Gm-Message-State: AOJu0Yy1jDqK5r57IRc/PoKIJdL6jZOPVNyvlhXZdZLa/94ZsDhejHHT
 5i3YEhQlzl7tOg/gvJ/yOiu6lb2OStY=
X-Google-Smtp-Source: AGHT+IGLDXI85ZB3XsRKlvG3MpeNmB8vokikH+7LoMalEY8ePS2c2VUj8IpHtRs3eKUonOuQhaRGlg==
X-Received: by 2002:a17:906:c103:b0:9c1:4343:60ab with SMTP id
 do3-20020a170906c10300b009c1434360abmr4574571ejc.10.1698495869191; 
 Sat, 28 Oct 2023 05:24:29 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906190d00b009ae3d711fd9sm2706687eje.69.2023.10.28.05.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 05:24:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/6] hw/watchdog/wdt_imx2: Trace timer activity
Date: Sat, 28 Oct 2023 14:24:11 +0200
Message-ID: <20231028122415.14869-3-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028122415.14869-1-shentey@gmail.com>
References: <20231028122415.14869-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c   | 4 ++++
 hw/watchdog/trace-events | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 885ebd3978..891d7beb2a 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -23,6 +23,8 @@ static void imx2_wdt_interrupt(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
+    trace_imx2_wdt_interrupt();
+
     s->wicr |= IMX2_WDT_WICR_WTIS;
     qemu_set_irq(s->irq, 1);
 }
@@ -31,6 +33,8 @@ static void imx2_wdt_expired(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
+    trace_imx2_wdt_expired();
+
     s->wrsr = IMX2_WDT_WRSR_TOUT;
 
     /* Perform watchdog action if watchdog is enabled */
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index 874968cc06..ad3be1e9bd 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -20,6 +20,8 @@ aspeed_wdt_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " si
 # wdt_imx2.c
 imx2_wdt_read(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] -> 0x%" PRIx16
 imx2_wdt_write(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] <- 0x%" PRIx16
+imx2_wdt_interrupt(void) ""
+imx2_wdt_expired(void) ""
 
 # spapr_watchdog.c
 spapr_watchdog_start(uint64_t flags, uint64_t num, uint64_t timeout) "Flags 0x%" PRIx64 " num=%" PRId64 " %" PRIu64 "ms"
-- 
2.42.0


