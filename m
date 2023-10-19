Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DA7D03E8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTU-0003qM-HA; Thu, 19 Oct 2023 17:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTS-0003pe-VP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:34 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTR-0000eX-8g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:34 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so1766551fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750551; x=1698355351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiDSBb1U1Y6ntpHTs6MX3TQXj3gIN80QBkiJrswp04U=;
 b=UeTn10uhHgomNxL3kTLEuknBBuI9wRb/rnqKau1RgOeWZd+1BQZN2O2t1brhCNFVgE
 KfQN1/r8P97CShIb0cT2+UKfhti03Z/lSVTGXhGzLfD0PsfkDW103m93xcj2rzKcwZJi
 zudwgENHSEr0PH14WuLOA2GXBDNh9FJj063Ych7oUrIEWsQNuc7zCPdpUXcVl8CnAvqH
 jlwkhl/6+/Cb86+rnp4VdO/uQAwRph67H5XJHBGL293M4TQOrlQn4NCPVTMsxhEydObr
 4NUfP+hzzUCh3y37dFk8O87WniJOoSID58NOvtti7GZHfE4KhZf06dI8jxcxyt02QT+0
 r2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750551; x=1698355351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiDSBb1U1Y6ntpHTs6MX3TQXj3gIN80QBkiJrswp04U=;
 b=vDrag6GwVZfYoD5cw2WrtkrL+N5lVsGo8zjfXa7gkrUKPp3327Mi3W4kuVWjXagGSQ
 lUxVVHKz7OLCwCJyKNSy3AMW256b/Q6zB/SWC/PzqB38PPhm+K//VaipiB19NWnBcYan
 tXwFjxpkJjV+9Lc3S8fj6O5Ca12N4YgSx/PZ7cyuA+6rRi4I4++Bpnn/DIji9Co+xaaa
 nB/xUBNY9Sn4cKwayW/UEI0IkOTUEO21B0gXVU8v0Gm/ozodB5dZ2Zc0d5gQD/I5X8c1
 GrcIqnsc4PxY3ckw+11PNbQ1aRy1TYgdxOdDTx+ciUsLxAZPaynatc9glspANqSranCm
 1bUQ==
X-Gm-Message-State: AOJu0Yzt+GcE9EBYMPITEw+xCPyd3pYo5Cn4cJjkG4UBO09gy577lhXy
 9fKjidFYXrp3/WVxIWiiFOx7KTpu75ydlsWCLz5UXw==
X-Google-Smtp-Source: AGHT+IFKtY9UAbvm34SCmjInNz8CpFolg6bUU4+8eFO3q/fyY1O5B7UZtmoaqADsSCCqJrLwvtDkUA==
X-Received: by 2002:a05:651c:1a29:b0:2b9:ee3e:2412 with SMTP id
 by41-20020a05651c1a2900b002b9ee3e2412mr122813ljb.22.1697750551506; 
 Thu, 19 Oct 2023 14:22:31 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c158900b0040776008abdsm508640wmf.40.2023.10.19.14.22.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 38/46] hw/isa: Realize ISA bridge device before accessing it
Date: Thu, 19 Oct 2023 23:18:03 +0200
Message-ID: <20231019211814.30576-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

qbus_new() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231019071611.98885-9-philmd@linaro.org>
---
 hw/isa/isa-bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index a289eccfb1..f1e0f14007 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -52,18 +52,25 @@ static const TypeInfo isa_bus_info = {
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
                     MemoryRegion *address_space_io, Error **errp)
 {
+    DeviceState *bridge = NULL;
+
     if (isabus) {
         error_setg(errp, "Can't create a second ISA bus");
         return NULL;
     }
     if (!dev) {
-        dev = qdev_new("isabus-bridge");
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        bridge = qdev_new("isabus-bridge");
+        dev = bridge;
     }
 
     isabus = ISA_BUS(qbus_new(TYPE_ISA_BUS, dev, NULL));
     isabus->address_space = address_space;
     isabus->address_space_io = address_space_io;
+
+    if (bridge) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(bridge), &error_fatal);
+    }
+
     return isabus;
 }
 
-- 
2.41.0


