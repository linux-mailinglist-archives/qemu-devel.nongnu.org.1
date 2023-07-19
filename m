Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAF759800
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7zr-0002ve-GX; Wed, 19 Jul 2023 10:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM7zo-0002vT-M9
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:17:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM7zm-0007ki-Ut
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:17:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31454996e06so6532178f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689776257; x=1692368257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NytQGG7tt1aLZMxrexduNjR2Bnwx2xni3VZZ8ELaFXg=;
 b=koDa40c8n5EF1k4GAKrHMJ8c9zotmNYxVzP7miEQjQYBhpgyddl8LOBwx+8wbhjSJ3
 +nV3yP5r2YBd8Watzqw8HedecheI60HIkaqul4Y0yeboRJZpDBl4h7Nw+xauWPfMhn9p
 SMt2HJuUiMtRNBxga7BglKrsR32Dj3nwhBhzzU6oWmYgWqm2SBQxPBl7fF6hJVs+mYxn
 VeLj+flwQ0lJOEm8srhnJu5Ro9WmHjhKwXcKb/PQYCM9pIIfTsvGStoUwE0V36I00EVa
 I+ALa66I1A0wGi6ZlyfUOJW/9euXx/+0U5jjrN5HCu9ap91GSyhowxF5+tePnds48LKL
 JUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689776257; x=1692368257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NytQGG7tt1aLZMxrexduNjR2Bnwx2xni3VZZ8ELaFXg=;
 b=itFjn5GXfvHexzmxVc/v4bpJO1Rlpt+MlsaB9/XYbMT9vgzTKMwpTMEzCovgpahgI4
 fR8az/rpuPqyByOvyxs3wuHNtauGq0uE2vlHBhx/3EtnJF8z0XrRLNM/rqjZvlHAvdTj
 bmyFq7r3pxoaLEaL5zXQcDctHD0Y1Qd9iQlqsx4nXumEn8YX4Z2ndT3yCDarD5ohs5tA
 nvEhSZXc7RXdTTHrLvUlI0x576cjX4eNk7jR/fLJGh7G+VIUC5H+BwSozqNYwt1/gRz0
 xnG5/ftdZlypRrdnVJFAXVhqLKVQqNPobKL8HOatdqxrYyLWKBKC7Qr1K8GzpuksfudS
 6nCw==
X-Gm-Message-State: ABy/qLZEnyNSXNjZy16TkLGmUrDUlFcbXwO7UjnjT7QsQ7QY7p0srNMw
 eNZqnXvcoHR1W2jFiHtLsN7uoN6zpHfr0kD9mHk=
X-Google-Smtp-Source: APBJJlHgk2+EaLybMKyY2ThXNPLmB7Fm3aVsvX2g93zkD9jAuwdCj6BYYzvOb0RsAuz0SIEY9rjeOA==
X-Received: by 2002:a5d:5687:0:b0:314:10d8:b482 with SMTP id
 f7-20020a5d5687000000b0031410d8b482mr14475869wrv.65.1689776257230; 
 Wed, 19 Jul 2023 07:17:37 -0700 (PDT)
Received: from localhost.localdomain ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a5d4534000000b003159d2dabbasm5414532wra.94.2023.07.19.07.17.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jul 2023 07:17:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-8.1] hw/usb/hcd-xhci-pci: Fail if user requested MSIX but
 it can't be used
Date: Wed, 19 Jul 2023 16:17:33 +0200
Message-Id: <20230719141733.35818-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Do not silently ignore the user request of using MSIX.
Remove the TODO. Coverity reported this as CID 1508725.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-pci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 643d4643e4..416656b78c 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -155,11 +155,22 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        ret = msix_init(dev, s->xhci.numintrs,
+                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
+                        &s->xhci.mem, 0, OFF_MSIX_PBA,
+                        0x90, &err);
+        if (ret < 0) {
+            if (s->msi == ON_OFF_AUTO_ON) {
+                /* Can't satisfy user's explicit msi=on request, fail */
+                error_append_hint(&err, "You might have to use msi=auto"
+                                        " (default) or msi=off with this"
+                                        " machine type.\n");
+                error_propagate(errp, err);
+                return;
+            }
+            /* report that msix is not supported, but do not error out */
+            warn_report_err(err);
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.38.1


