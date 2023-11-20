Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C97F16AA
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55p7-00045o-L6; Mon, 20 Nov 2023 10:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55p5-00045E-SN
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:04:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55p2-0006cq-Kz
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:04:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40838915cecso16835715e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492663; x=1701097463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d1m4qgp3LT6PkSZWgB9jKarXIzRyOrdJ5ULRTRAQLDM=;
 b=XbP2T6B4jI8N3tA2xNsPDtUjs9xfhS2IhFcCsXYnxy9ADvMt5eFmULey0QI7eaLoUi
 tx609+Nu4w8PQY9wCqumWfC3Zr5Ab8Vm0M6yDPI4jRySHI4PPExFpFDujBXUcRf3GtzU
 SCp11oLsZssz2NTp50MPopsVMcVutXYPvHs9KQxmMgVtJNbUrdQ0XBG6DWtpPYqlFi27
 gLxnGTnUAk7FaeKb7vbYrctvvUGTG3X6y0o/hEaBfi7hW7RJk3c0vgOgNP7YSKp8pfOE
 38PqKZnn8hYRIyo8JuHNebgGLRnb1NCgbnoTcBQzNxgS0YlPgm3Nn9aMjxG23XlNQNeb
 rbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492663; x=1701097463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1m4qgp3LT6PkSZWgB9jKarXIzRyOrdJ5ULRTRAQLDM=;
 b=kNpB87ap9OwDxb9NzNGOixYLRePjOMgK4CbZ5g/sYRWsoFzh969t0DsVSyorXWJD1v
 3Yn04HmZhsAG3dJDcKQm2awsf4MBkoLMsdgGw5diy1DUFr2u9yKO6VZIemba14xmrbV7
 xqxpwkmVOiZINT62JKs1unXwWxjXUp+FErVH3hmGw+PzP0ZnwkmdUmOm7Wac5dJct5xF
 U3T2WmSCZWFLGILdxvdrvLShTeVEFECs7CujU8lTuyPn/rjfOgHTeIgLiOKlR+rZSePx
 MAXaTW1wgkZLs58tdXeaTbLmtDuE1JK6psXQpvXKKtmPrGoPY7E/w1m4XbLEb1myPZ74
 AYIw==
X-Gm-Message-State: AOJu0YxcocGFOO0c42U/GWywqG06UouD0vY8A/9pyENkYnJDC88TUNww
 U6GE20tECdxeAgkxaf+iMOknBz+ROUqTTX8YvtU=
X-Google-Smtp-Source: AGHT+IHz/zqyLjGyUsuXWs+NBSeA2vTnDkKJHxw9pD9e+TYyp2PR1z4FpQvGgDHCcJQS6V24hl6HPA==
X-Received: by 2002:a05:600c:1592:b0:40a:5129:c284 with SMTP id
 r18-20020a05600c159200b0040a5129c284mr5430712wmf.35.1700492662705; 
 Mon, 20 Nov 2023 07:04:22 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c3b1500b003fe61c33df5sm18466972wms.3.2023.11.20.07.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 07:04:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2 v2] backends/cryptodev: Do not ignore
 throttle/backends Errors
Date: Mon, 20 Nov 2023 16:04:18 +0100
Message-ID: <20231120150418.93443-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Both cryptodev_backend_set_throttle() and CryptoDevBackendClass::init()
can set their Error** argument. Do not ignore them, return early on
failure. Use the ERRP_GUARD() macro as suggested in commit ae7c80a7bd
("error: New macro ERRP_GUARD()").

Cc: qemu-stable@nongnu.org
Fixes: e7a775fd9f ("cryptodev: Account statistics")
Fixes: 2580b452ff ("cryptodev: support QoS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index e5006bd215..fff89fd62a 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -398,6 +398,7 @@ static void cryptodev_backend_set_ops(Object *obj, Visitor *v,
 static void
 cryptodev_backend_complete(UserCreatable *uc, Error **errp)
 {
+    ERRP_GUARD();
     CryptoDevBackend *backend = CRYPTODEV_BACKEND(uc);
     CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
     uint32_t services;
@@ -406,11 +407,20 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
     QTAILQ_INIT(&backend->opinfos);
     value = backend->tc.buckets[THROTTLE_OPS_TOTAL].avg;
     cryptodev_backend_set_throttle(backend, THROTTLE_OPS_TOTAL, value, errp);
+    if (*errp) {
+        return;
+    }
     value = backend->tc.buckets[THROTTLE_BPS_TOTAL].avg;
     cryptodev_backend_set_throttle(backend, THROTTLE_BPS_TOTAL, value, errp);
+    if (*errp) {
+        return;
+    }
 
     if (bc->init) {
         bc->init(backend, errp);
+        if (*errp) {
+            return;
+        }
     }
 
     services = backend->conf.crypto_services;
-- 
2.41.0


