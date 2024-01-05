Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51D82574A
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:56:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTQ-0002rg-UH; Fri, 05 Jan 2024 10:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSI-0008MD-Fu
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmSB-0000xb-Ce
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so18127645e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469786; x=1705074586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoxGR8z2iD4/dV7vlDevdlyqaz6yGMvGSLHUDaB/+Ko=;
 b=lS7mHqvQydw9G3Y95Kh+xSnAHmZcPK6Yh8lO6Q5C9+RCv/1NWXRQ4A55nbW9oDf4oQ
 9aSJuVas4MVrsgWiIyEyzqfq+nyNySZfOtIC5N9GM+HXAHyfV/1Lho4v7IPKzpQkYaqr
 egKqoEs5pBlK1/60ZWAnVsBN2S0ysVpzIxlnweC/UHHMq7PIPpCNsERY2FDaavfUtJtP
 4fTGLJ+fesB/gcydoGNKFrRiX3rH8XYdKuDJUZWh43hwFe66wwqDN7QzUPVMpt3zpFZ2
 2kIM3RYtJYkES9osuoVYSZzPSHx2XaQg0UtO6rJ4wRa1uL157YP0fxCdqjJ2TwPoMP1L
 PcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469786; x=1705074586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoxGR8z2iD4/dV7vlDevdlyqaz6yGMvGSLHUDaB/+Ko=;
 b=DhOhgTlhNaCvlWcyaSdzQ6R5HDbxlgvXKE9y9FDlVjgk0QDQ0ey2Bw1kKnz1C1s/TB
 PZqTi/U+w87xkMncPIOlHVhuRp5wxmiFHW1btmQQUoWllRHLdvHl+bh0P5Gf2wMBQbIF
 D/Gm74UTANVHGzxe44MnN8oQRnU/9aCnkLuI67ipoZZU8fP+ohNYG7vpfqmZygczukau
 Xz6LLUWHiJg1HOXZlx6T37/8+onBDS58+INxolkIHOLc57Ts9IMzJcuE+CyrojPFEzBC
 aO7EKwFz5xtliv9nYRQeuQbCcCxAQ2x6LWMrPLYZ6CAifpIcnrJsNCb8Rmqsz/ImfZEY
 TFEQ==
X-Gm-Message-State: AOJu0YwmJG/UnpkKyPxCHsPULCvg3EuE/burt+n+95O4P6LdXGjt1LHo
 I4PmMKIC/ikH4j/h+bw+Xjt/ExG2dNOp0VE6snxOsPcm4vg=
X-Google-Smtp-Source: AGHT+IFwrMeMDJP4oO+XGA1BUGpUIY1yT52Wd8pHgBQFLKSV3AS0DpLDcrNG8K6y3OFW3EgRTkVmXA==
X-Received: by 2002:a05:600c:22d6:b0:40d:5d07:55d3 with SMTP id
 22-20020a05600c22d600b0040d5d0755d3mr819881wmg.177.1704469785886; 
 Fri, 05 Jan 2024 07:49:45 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 b14-20020adff90e000000b003375c072fbcsm896486wrr.100.2024.01.05.07.49.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:49:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gavin Shan <gshan@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 65/71] hw/sparc: Simplify memory_region_init_ram_nomigrate()
 calls
Date: Fri,  5 Jan 2024 16:42:58 +0100
Message-ID: <20240105154307.21385-66-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, errp;
@@
-   memory_region_init_ram_nomigrate(mr, owner, arg3, arg4, &errp);
    if (
-       errp
+       !memory_region_init_ram_nomigrate(mr, owner, arg3, arg4, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-23-philmd@linaro.org>
---
 hw/sparc/sun4m.c   | 21 ++++++---------------
 hw/sparc64/sun4u.c |  7 ++-----
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 64895aebe3..550af01690 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -577,12 +577,9 @@ static void idreg_realize(DeviceState *ds, Error **errp)
 {
     IDRegState *s = MACIO_ID_REGISTER(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
-    Error *local_err = NULL;
 
-    memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
-                                     sizeof(idreg_data), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.idreg",
+                                          sizeof(idreg_data), errp)) {
         return;
     }
 
@@ -631,12 +628,9 @@ static void afx_realize(DeviceState *ds, Error **errp)
 {
     AFXState *s = TCX_AFX(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
-    Error *local_err = NULL;
 
-    memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx", 4,
-                                     &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx",
+                                          4, errp)) {
         return;
     }
 
@@ -715,12 +709,9 @@ static void prom_realize(DeviceState *ds, Error **errp)
 {
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
-    Error *local_err = NULL;
 
-    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
-                                     PROM_SIZE_MAX, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4m.prom",
+                                          PROM_SIZE_MAX, errp)) {
         return;
     }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c871170378..24d53bf5fd 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -454,12 +454,9 @@ static void prom_realize(DeviceState *ds, Error **errp)
 {
     PROMState *s = OPENPROM(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
-    Error *local_err = NULL;
 
-    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
-                                     PROM_SIZE_MAX, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
+                                          PROM_SIZE_MAX, errp)) {
         return;
     }
 
-- 
2.41.0


