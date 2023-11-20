Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E96B27F1694
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55ji-0007cg-3R; Mon, 20 Nov 2023 09:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55ja-0007aY-B5
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:58:46 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55jW-0002yj-Ln
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:58:44 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5094727fa67so6190018e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492320; x=1701097120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+7OtfFGW1qWLlhG1BE/Z/a80m1dNeVizHCqe1pqJMU4=;
 b=epQCtTuWhtmqWFKi/ik5nmf56+438GWuls7uIYUPi+oeMcU6tTuO73cg/kvloWHVq9
 yYSCQWHsh5zdP7Q2+3QzLXN5Z/ub5k8mHc/ASgQTkCwXVM4jHgcnhEDGNqsb9Ins31l8
 WMJCm2m+hHDAHI+HV7IZA1artvDzc7eMiqKOp/K2IjdAJfj+I4RqzXSViYuq6/O4Ja8M
 8wHvT7GxlsOFepbxYjZVJDNQ1bH+xehUzIEZr2Xbczej96bkm2x2u1kz2oiknS9mhYjZ
 me9Ouc0X6oMojxuv6YCY/Av5uQ3gb1lIclHG5zY0nELvf23gE4pFIuT6t9H+Y86jGMr3
 3gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492320; x=1701097120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+7OtfFGW1qWLlhG1BE/Z/a80m1dNeVizHCqe1pqJMU4=;
 b=Qw6Nhk/5SAQj3MXvIOjaEYCJBjQ9V9B/Inuge2eQWwv/n31TdqrdynFkp/cwocvxRk
 QsjuMc04wnhsuVYKXKTUo4rgv9fh5mkAUCNxsRS3Sj/G9XcxnSPrwctyhbaGo12/R75r
 oeBqBF14sjCJtalgFOTBnEuv4SUX+iP1T9bxbOq7lvJ+5B7iSMGAZi3CgxfoK8N2bqlo
 BYND4G1IdinyZa0gwKGes2iS1b/5DgJW8wwONXNJCoG9uuE+/VsK3867nIWpnQMa172d
 k0zhFJZd4k+ff81MjqgTVsrGyUIMV3kSQp5QXh1vS9MPdTfdgh+PP3jQm/YgO41IZ3k2
 ukoA==
X-Gm-Message-State: AOJu0YyX+4/Jg+XadgoPL2VnvdxEzBRb7BI2U9HuE/oscEHmB2sDvH1E
 BRuGy/RJga4gemLF2isHK5S9VKtuKDypH4ITuDg=
X-Google-Smtp-Source: AGHT+IHwBCmA2/dDD+zPWeVc8rMAhkW4RWF1hOwYDn4vKxWVVHx9NmDF76gwoLQHO2PrdmZ1aFuREQ==
X-Received: by 2002:a05:6512:25b:b0:505:73e7:b478 with SMTP id
 b27-20020a056512025b00b0050573e7b478mr5045230lfo.16.1700492320283; 
 Mon, 20 Nov 2023 06:58:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a170906359400b009ffba6f1aafsm617636ejb.109.2023.11.20.06.58.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 06:58:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-8.2] backends/cryptodev: Do not ignore throttle/backends
 Errors
Date: Mon, 20 Nov 2023 15:58:35 +0100
Message-ID: <20231120145835.92030-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Both cryptodev_backend_set_throttle() and CryptoDevBackendClass::init()
can set their Error** argument. Do not ignore them, return early on
failure.

Cc: qemu-stable@nongnu.org
Fixes: e7a775fd9f ("cryptodev: Account statistics")
Fixes: 2580b452ff ("cryptodev: support QoS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index e5006bd215..c0b2abc943 100644
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
+    if (!errp) {
+        return;
+    }
     value = backend->tc.buckets[THROTTLE_BPS_TOTAL].avg;
     cryptodev_backend_set_throttle(backend, THROTTLE_BPS_TOTAL, value, errp);
+    if (!errp) {
+        return;
+    }
 
     if (bc->init) {
         bc->init(backend, errp);
+        if (!errp) {
+            return;
+        }
     }
 
     services = backend->conf.crypto_services;
-- 
2.41.0


