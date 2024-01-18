Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9F831F0A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:21:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQWzr-00041o-Va; Thu, 18 Jan 2024 13:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQWzj-00041D-EU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:20:03 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQWzh-0000dS-4E
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:20:03 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cd928a1d58so68964891fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705601998; x=1706206798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq2vlKDfEIqaV7ZfTV/HL+E2Cg+98tAioOyrWm4qjjc=;
 b=cODKmHTh8f4bEKcWp1VvGOLyxxtCKxrUjBq/na7BJx8Guf6QWoLjMVDtXAa8oo8CGj
 +dttuUMDdfN6B3p+6tg/7kPzLfTmIBtmI5V2lycR6lXlzenu2hNrO/YcYHefQkoMd1lb
 9Li4ywa3dAymudvNPKlP5kxfHuy6uI07+kVnNjWmQMsW3DPNXfgCj8fUcjJs9rdfTNcT
 TnAV/Up3mKYgMgqKFZwPD6YdEzoklH2IfjiV9E7t75j7a+NdaCnG39IObwTyXo4p3oHW
 leWI4JJSjutLfqz17E9Ww6Mp+xavOrG7pszNhzUjC0xUSyyN4zpU559XcBSJk2U7WGqj
 4OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705601998; x=1706206798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cq2vlKDfEIqaV7ZfTV/HL+E2Cg+98tAioOyrWm4qjjc=;
 b=VFsGQz69K/YJcd2TPDsn/qXqHJEvnJZPM25jwAMlM0x27ka3bjBiN80ssb+dy6nfRF
 407CT+j0aI8Zh2B6h32NMBlnaA4/MdySh8LKdTtVpwbGqkSjhkD1DjwhXqahyzUBMxId
 Ya7rlJrXTiQHVuN+5NuqGNHsnYeNKpJKUoZnmLwZT5RcF4ndpVJPzDd+m/9PufZnFwvs
 HXNeXtZcs9NI1S7hNLIncBa852+hpZfLiHe/XbJVSn2jLcJUDClqTaltHgAj+3CeSNpZ
 wLx1lSRKLAw3WcSnQ7EPpPFWcyKuQbGI2N+pISyTx5HdWWebjqIjJb1R5GVq716voWRD
 UaJQ==
X-Gm-Message-State: AOJu0Yz2DPO7aWK2P3rvObKR0BMGLHa/sm8PdEdYEXodXifuY3NfUoAt
 7s1kca0xy7O0c5uBNjcYMYo5EJAOp8htZd/vlwX0ozzCAhaHxfgbogHcDbZZb0L6PQQhcwcqyA5
 uiCLhZQ==
X-Google-Smtp-Source: AGHT+IG5iEAkayYOQMqBWcJJoVB07C62L9teZSopcdBUrmkXjf+79T6aJc4+h9du6Jalhp9b6MSx5Q==
X-Received: by 2002:a2e:9217:0:b0:2cd:7039:e281 with SMTP id
 k23-20020a2e9217000000b002cd7039e281mr782232ljg.8.1705601998060; 
 Thu, 18 Jan 2024 10:19:58 -0800 (PST)
Received: from localhost.localdomain ([77.205.21.235])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056402242200b0055823c2ae17sm9856710eda.64.2024.01.18.10.19.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 10:19:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3] backends/cryptodev: Do not ignore throttle/backends Errors
Date: Thu, 18 Jan 2024 19:19:55 +0100
Message-ID: <20240118181955.19949-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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
can set their Error** argument. Do not ignore them, return early
on failure. Without that, running into another failure trips
error_setv()'s assertion. Use the ERRP_GUARD() macro as suggested
in commit ae7c80a7bd ("error: New macro ERRP_GUARD()").

Cc: qemu-stable@nongnu.org
Fixes: e7a775fd9f ("cryptodev: Account statistics")
Fixes: 2580b452ff ("cryptodev: support QoS")
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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


