Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5305474022E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECVu-0000Un-I5; Tue, 27 Jun 2023 13:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECVs-0000UG-NW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:30:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECVr-0000fC-3h
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:30:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so69077a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687886997; x=1690478997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eM7fMUS/bQ7fR32WgG7Yf2+xFexOx9ylKR4feRvm9IU=;
 b=Plw5uy3y5vy2SeUEnwDZHA7+uHs9rUtLfUhISPvpxLXODvrm1iJEc3GF/9pqRT7CdQ
 sG+KI4TU1rKQA9SN5Nd/ARQNYFqwpzSjD9zLga5av+Y9KYhGPE5jCcC3XFoA99J/mX0O
 UQyRLQSDhOIxKoROQ9xt0Pz9BV73ADS1BaW/dcDTU9n1rS/Hrm4cqrKT/24hkjIqYTbr
 xJOK32BzM7FaSHRblV25u+U9DbBC8+5coyZjzuA6r7QhitnHgepAM9T+uXrPKZOk2+/B
 Sz9cltOKeDByexDNHY76mBDumP9mrCQINyjYLTWpYQHnAd8uqLcPOp+6P7lgiR+5zxWA
 fl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687886997; x=1690478997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eM7fMUS/bQ7fR32WgG7Yf2+xFexOx9ylKR4feRvm9IU=;
 b=CdPmpMKFdJlC43FMfiqEX54gQ0BS9pBbiLyLl3Y1M7mJUgE45s21t6H7XpNxGDBxkx
 nzZVlO84NUSTJu98LSyL2C053qu8O4S52A25gwmLo7+qXZTXn8EZZY495avJ0DmXtA8V
 M8RPM48ASl1IKyVVL9ob3jTeVfhELUlwSvSZ+MS6wEq+0tlnMGddq/oI8BRhnDC4LCyy
 1R1w0tF131AuzxF+CX9X+sYZ67y8CTGeBRi7eE+Q0dT49nB70Msn9YawFzQbLG1nQv7W
 HuOlI3yEMhjfL1octJ+zPV4PW44rEz4IbjWQoLa0TXmW9xq6lE31uikvFhtWkJ5P27pF
 opmA==
X-Gm-Message-State: AC+VfDyvDy7JWUFMqSB3eQxckl3/ux8RW0EvjoocIfdSLbjWxry4hgvT
 iAVwBAYMKd2F3cbVaPaKD3pDCOUyKj07oyVqAevjSun8R95HPmdHYrq6NdKQLw4kyACSxKVpKI7
 eZrqDfBfN31Tug0YqqpN2lG5ng04czJnDwO0BpYIDGXmBVlgYfY2KLx6vqcP/Oh5nzp2C1/fyIJ
 QL3hE=
X-Google-Smtp-Source: ACHHUZ5XCf9r4eRTVb+nfFgNJFXDJ0xGS56Ivi9zcjYaQ4Vw3O6FHRXdMPwTYh8++T4VpqJi54WFQg==
X-Received: by 2002:a17:90a:3d4c:b0:263:3386:9da3 with SMTP id
 o12-20020a17090a3d4c00b0026333869da3mr1024652pjf.17.1687886997511; 
 Tue, 27 Jun 2023 10:29:57 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 z19-20020a17090ad79300b002631f3d36a1sm1461443pju.36.2023.06.27.10.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 10:29:57 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 14/15] crypto: Add SM4 constant parameter CK
Date: Wed, 28 Jun 2023 01:29:04 +0800
Message-Id: <20230627172921.65040-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230627172921.65040-1-max.chou@sifive.com>
References: <20230627172921.65040-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x535.google.com
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

Adds sm4_ck constant for use in sm4 cryptography across different targets.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 crypto/sm4.c         | 10 ++++++++++
 include/crypto/sm4.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/crypto/sm4.c b/crypto/sm4.c
index 9f0cd452c7..2987306cf7 100644
--- a/crypto/sm4.c
+++ b/crypto/sm4.c
@@ -47,3 +47,13 @@ uint8_t const sm4_sbox[] = {
     0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48,
 };
 
+uint32_t const sm4_ck[] = {
+    0x00070e15, 0x1c232a31, 0x383f464d, 0x545b6269,
+    0x70777e85, 0x8c939aa1, 0xa8afb6bd, 0xc4cbd2d9,
+    0xe0e7eef5, 0xfc030a11, 0x181f262d, 0x343b4249,
+    0x50575e65, 0x6c737a81, 0x888f969d, 0xa4abb2b9,
+    0xc0c7ced5, 0xdce3eaf1, 0xf8ff060d, 0x141b2229,
+    0x30373e45, 0x4c535a61, 0x686f767d, 0x848b9299,
+    0xa0a7aeb5, 0xbcc3cad1, 0xd8dfe6ed, 0xf4fb0209,
+    0x10171e25, 0x2c333a41, 0x484f565d, 0x646b7279
+};
diff --git a/include/crypto/sm4.h b/include/crypto/sm4.h
index de8245d8a7..382b26d922 100644
--- a/include/crypto/sm4.h
+++ b/include/crypto/sm4.h
@@ -2,6 +2,7 @@
 #define QEMU_SM4_H
 
 extern const uint8_t sm4_sbox[256];
+extern const uint32_t sm4_ck[32];
 
 static inline uint32_t sm4_subword(uint32_t word)
 {
-- 
2.31.1


