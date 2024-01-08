Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2345826F0C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:55:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMp8d-0002tw-Ta; Mon, 08 Jan 2024 07:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8c-0002tR-2J
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:53:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8a-0006H4-Ef
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:53:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e43e48a16so13298135e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704718431; x=1705323231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghVWFLUr6713RIktIzJDLwjlFUwvU8dITI3EJerUt6E=;
 b=cE7lqjDIiL85o7NwwIR0GAfIWwo31IejvK/kRERHRmSjrzksbF+toE2N+a4j370YKg
 Qdd+tOKyfFe7rcTYNXnk97z2S2oyX5nL+akdA+Z6Rw1AgyqBhBGeLc8//anhHjdhi+WY
 jW7v4R93E0Y+4ReyGen5N9gpnfF9LAJzPN6jhuvGtkxi3pS6F9dtKJwoshfvniEj31QX
 IXITi/byUXRWi8M5yDhNEuYQnJP4qSmmQPt2nGwgUo7wf6YkQU86n6ECnxylFZ459Q9a
 iEVChatIC3RuNKLpHYJNQ+BiPGzQ16BBdZP2uLhFNs+hLmDzhHnGkO2m8Kb2ntMFCbRF
 gGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718431; x=1705323231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghVWFLUr6713RIktIzJDLwjlFUwvU8dITI3EJerUt6E=;
 b=LjT4MZufjp0o4q7Kq2ZY/fxXW8be6ykS1POskv/ZA2f0dRSUQNFtnR3aerynp7Dcx0
 9lLpGplrICnzDDZRRRFZs226fEgi1dUrdsLkN+GowLq0hMk3nvcQwtSq55neW6xS2EhE
 mUSk7KdMVhDy3GcSnBzY5uUQT4RoNHQfyWfMgtobBw93IVR7weRIUGMHYOiCEszrf4VW
 ic+phndbklzxlycM/8h30b7w4Kk1SzDsByxwdHO3Sc2TzjgmmehI1qPPzt1JM2SDLTQ6
 yBL/mSrZ88cOXCgaAxwHYx8XuAy2kii4Lag+H3O6+QfENAan+0Pd5Y6xBV+1nBe2t+Yb
 egMg==
X-Gm-Message-State: AOJu0YyNawnIQqx8Jbp2cyGtjzoY5Zy0c0IxgEpFHO6tYmd1nUH83dpv
 ySjZBMQpgImx8S6tWgJyxfwJBnwFPjGOsRfbJIikd9HjNFg=
X-Google-Smtp-Source: AGHT+IHaHzN6CWAGOvlzsUccv6ipYmgp8G2SiNCXFYXTQTdg+y28wuhzI5lml/HNmDsY3RypKGEOgA==
X-Received: by 2002:a7b:c4d1:0:b0:40e:4aed:ad27 with SMTP id
 g17-20020a7bc4d1000000b0040e4aedad27mr125789wmk.144.1704718430674; 
 Mon, 08 Jan 2024 04:53:50 -0800 (PST)
Received: from localhost.localdomain ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 l42-20020a05600c1d2a00b004030e8ff964sm11004600wms.34.2024.01.08.04.53.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jan 2024 04:53:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/block/pflash_cfi01: Use the LD/ST API in
 pflash_data_read/write
Date: Mon,  8 Jan 2024 13:53:41 +0100
Message-ID: <20240108125342.48298-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108125342.48298-1-philmd@linaro.org>
References: <20240108125342.48298-1-philmd@linaro.org>
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

Similarly to commit c3d25271b2 ("hw/block/pflash_cfi02: Use the
ldst API in pflash_write") for CFI type 2, use the LD/ST API for
CFI type 1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 63 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3e2dc08bd7..ce63ba43b6 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -225,34 +225,10 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
     uint32_t ret;
 
     p = pfl->storage;
-    switch (width) {
-    case 1:
-        ret = p[offset];
-        break;
-    case 2:
-        if (be) {
-            ret = p[offset] << 8;
-            ret |= p[offset + 1];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            ret = p[offset] << 24;
-            ret |= p[offset + 1] << 16;
-            ret |= p[offset + 2] << 8;
-            ret |= p[offset + 3];
-        } else {
-            ret = p[offset];
-            ret |= p[offset + 1] << 8;
-            ret |= p[offset + 2] << 16;
-            ret |= p[offset + 3] << 24;
-        }
-        break;
-    default:
-        abort();
+    if (be) {
+        ret = ldn_be_p(p, width);
+    } else {
+        ret = ldn_le_p(p, width);
     }
     trace_pflash_data_read(pfl->name, offset, width, ret);
     return ret;
@@ -406,34 +382,11 @@ static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
     uint8_t *p = pfl->storage;
 
     trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
-    switch (width) {
-    case 1:
-        p[offset] = value;
-        break;
-    case 2:
-        if (be) {
-            p[offset] = value >> 8;
-            p[offset + 1] = value;
-        } else {
-            p[offset] = value;
-            p[offset + 1] = value >> 8;
-        }
-        break;
-    case 4:
-        if (be) {
-            p[offset] = value >> 24;
-            p[offset + 1] = value >> 16;
-            p[offset + 2] = value >> 8;
-            p[offset + 3] = value;
-        } else {
-            p[offset] = value;
-            p[offset + 1] = value >> 8;
-            p[offset + 2] = value >> 16;
-            p[offset + 3] = value >> 24;
-        }
-        break;
+    if (be) {
+        stn_be_p(p, width, value);
+    } else {
+        stn_le_p(p, width, value);
     }
-
 }
 
 static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
-- 
2.41.0


