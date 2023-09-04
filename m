Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB70791B5E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDO-0004TI-0p; Mon, 04 Sep 2023 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDM-0004OI-JZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:12 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDK-0007i8-5d
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c93638322so347288566b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844048; x=1694448848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xxe/gfQOqcpGIg7mgqqlKfLWKMuZRnXp4Q7SG5q4uJI=;
 b=E4V1MaLhlicau1XVWJQjozb5oq1xn1JP8IVn78t3Ao+2LIhvNObyz3WO2FoDYCo9Vy
 QtOtjq2zqfJO524R1quleO1QKWAzSfS07Ui9qRbBqWHsCwRLrysiHYUgXcCeRR7ep42Y
 uLkhBBzjewaiH6IOGs0jzXoTNJURmlfBGeS/v6qzQllJi0Fh6WrK1H3znI3krCEuYc6W
 fLgrZKELwa1NPAy4d0AzCZ2uOo0k+pNkkHwy4B4HBOxx6h5pmfSyC2EfgYnbEzs32eqs
 mO3A74JziLRi+paZ9bDBTg0kBQMRNrNxi5SfnzEyDQjq3r/9td5Xa8U/uei7C6knYe+m
 KSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844048; x=1694448848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xxe/gfQOqcpGIg7mgqqlKfLWKMuZRnXp4Q7SG5q4uJI=;
 b=KURR0I459i71dQD98+02rRMbHiVH3PVKyC+9usqcLuUrb8BKmo+L+CwKOJ+UrIwqQq
 mw0ZCv5Cy+Gu8TDk1TUxhOfUp4+sNqUvBtWIiG4uEy4QZFR23l3cpLTs+UreiMz/Y7dF
 h3+HQ1mr4OI6KHX04bGIJyYEc4euxDMP8l/wCnEflpWPjpaLOpsaawGzgkmhPwcy5HOt
 Eba7VNMJWwe/9pjqGdWOrnZ6qTOKfG8PQA51NOiUDclanAXTj/q4tf8vwmQcJw4WsiCa
 dW04ZZbiKjBwaGv9f325nwoM6tmz9Iq+tkqKAyDDWLAhv/VovMG/A8Kk3IinN3LjfZl+
 aVmQ==
X-Gm-Message-State: AOJu0YynvLKZjubdGK7xI4QLsKd7aOKB6ptMgY/jLLpG+KhyEaWjsQQO
 5ULkP3W636SsAGNgnU5vKuGuj6TZ3kuJhIrhSG4=
X-Google-Smtp-Source: AGHT+IEEswzeghhAgk5GMbEFO2iRWclNeRhdwGuRMIro2A3b+TyG4PE2B3OcUG4L1ODDx8Z7NNy/yg==
X-Received: by 2002:a17:907:7202:b0:9a2:25da:d71e with SMTP id
 dr2-20020a170907720200b009a225dad71emr14241419ejc.0.1693844048790; 
 Mon, 04 Sep 2023 09:14:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a170906951700b0099d0a8ccb5fsm6384460ejx.152.2023.09.04.09.14.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/22] crypto/cipher-gnutls.c: Clean up local variable
 shadowing
Date: Mon,  4 Sep 2023 18:12:28 +0200
Message-ID: <20230904161235.84651-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fix:

  In file included from crypto/cipher.c:140:
  crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_encrypt’:
  crypto/cipher-gnutls.c.inc:116:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
    116 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
        |                 ^~~
  crypto/cipher-gnutls.c.inc:94:9: note: shadowed declaration is here
     94 |     int err;
        |         ^~~
       ---

  crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_decrypt’:
  crypto/cipher-gnutls.c.inc:177:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
    177 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
        |                 ^~~
  crypto/cipher-gnutls.c.inc:154:9: note: shadowed declaration is here
    154 |     int err;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/cipher-gnutls.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc
index 501e4e07a5..d3e231c13c 100644
--- a/crypto/cipher-gnutls.c.inc
+++ b/crypto/cipher-gnutls.c.inc
@@ -113,7 +113,7 @@ qcrypto_gnutls_cipher_encrypt(QCryptoCipher *cipher,
         while (len) {
             gnutls_cipher_hd_t handle;
             gnutls_datum_t gkey = { (unsigned char *)ctx->key, ctx->nkey };
-            int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
+            err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
             if (err != 0) {
                 error_setg(errp, "Cannot initialize cipher: %s",
                            gnutls_strerror(err));
@@ -174,7 +174,7 @@ qcrypto_gnutls_cipher_decrypt(QCryptoCipher *cipher,
         while (len) {
             gnutls_cipher_hd_t handle;
             gnutls_datum_t gkey = { (unsigned char *)ctx->key, ctx->nkey };
-            int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
+            err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
             if (err != 0) {
                 error_setg(errp, "Cannot initialize cipher: %s",
                            gnutls_strerror(err));
-- 
2.41.0


