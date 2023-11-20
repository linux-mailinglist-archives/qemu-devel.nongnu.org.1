Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EA7F1F5F
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Byp-0003YA-Mo; Mon, 20 Nov 2023 16:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Byo-0003XQ-14
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Byl-0004gA-Bp
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso17766385e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516330; x=1701121130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LHC78QDU4+0JLufBJAoefD8kTg7PvgbK0ho9KjVegA=;
 b=Qzi0CUJy5vFEW51MbnKXvOnzW1PbT8WAk6OB6U5ziwXRW5LgmhunKmofFAGb4RxRtZ
 Q3bQb3nmPKsPynLun2+eRtuR720M6Y7zwOACVWRQtNXHdaYq5b2o+OAGmHlISyQ+X2Su
 IXJKN950Je2wUUawN2gCFm3uXtu2YLeTJZz8hkClmUNZqGTZj2e10Ql5XAW/LOSlPVrM
 0WF9qsT1SraZ7l3QxumhbgG27g2IvJAcX6n+rVKDPbL7Rc7kQf0HaGhRnqv+xObEAiUm
 bzl6E/xwxOukTNEEc7PhYp8kTz5eVIvCtXZXx38SvMPEIUQzLtOT/4LRJmAJuwztujYD
 2tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516330; x=1701121130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LHC78QDU4+0JLufBJAoefD8kTg7PvgbK0ho9KjVegA=;
 b=ni3DqRwVawUerfGZlSr3PtFLYu60C12Fyf2LdFNEKK3Ob5PRqZ2hqtXCSkSbEZ220H
 3WyoWDdXIpu4HniA41r/cillpFMjaz5DfhGfbRFBVkZjypR82sCqqYgKq6Pzf0aCYA+I
 FI/usT7XSQk/VL8SWc1H5gzdC+Q7kIgIe5BF4R5M0rdhPHX9ryhooOYD/3jtDR4UkujZ
 XIG0g6Oe4FCSNmFQG8Ik0iVz9AXhPjDN9hrqjkw11cGM7/r65Kf3u/3eKCs0IKB3zjSX
 zX8zxhma97SsHMYLf4NbRMV1ZyTHOhhBWCKgUra/IhU1kNeV2zwLk4orC2x6FBDDb9r6
 smlQ==
X-Gm-Message-State: AOJu0Yzg4UHoZBemdzPGKfWLetM/LqfeahHfWAsJf7zQKGPl2Owe3nve
 INk8C2UA41wBEIIgaeb9Rbs7xGJ8k1nLHU6t424=
X-Google-Smtp-Source: AGHT+IGR0AKBLTgs3rHMKqj6CjUak0fqxbSyoUYrHx04Buv84E5ejw85WoeVGxOVQ6/PSqi5hGLnOA==
X-Received: by 2002:a05:600c:2246:b0:408:3975:e225 with SMTP id
 a6-20020a05600c224600b004083975e225mr7404513wmm.40.1700516329774; 
 Mon, 20 Nov 2023 13:38:49 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a1c4c11000000b0040a44179a88sm18670392wmf.42.2023.11.20.13.38.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:38:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-9.0 22/25] hw/sparc: Simplify
 memory_region_init_ram_nomigrate() calls
Date: Mon, 20 Nov 2023 22:32:56 +0100
Message-ID: <20231120213301.24349-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
---
 hw/sparc/sun4m.c   | 20 ++++++--------------
 hw/sparc64/sun4u.c |  7 ++-----
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 17bf5f2879..fcf3782068 100644
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
 
@@ -631,11 +628,9 @@ static void afx_realize(DeviceState *ds, Error **errp)
 {
     AFXState *s = TCX_AFX(ds);
     SysBusDevice *dev = SYS_BUS_DEVICE(ds);
-    Error *local_err = NULL;
 
-    memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx", 4,
-                                     &local_err);
-    if (local_err) {
+    if (!memory_region_init_ram_nomigrate(&s->mem, OBJECT(ds), "sun4m.afx",
+                                          4, errp)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -715,12 +710,9 @@ static void prom_realize(DeviceState *ds, Error **errp)
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


