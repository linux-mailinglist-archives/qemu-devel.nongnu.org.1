Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BA744E83
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzQn-0004sJ-AP; Sun, 02 Jul 2023 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzQF-000431-96
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:55:35 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzQD-0000Id-IF
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:55:34 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2671497a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688313332; x=1690905332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue2dx04GA0MMTMF2nL8iZsmgnBaXiJ8OB2kvZbsFtIY=;
 b=KN3xH9UZQsBWqB4gAlh/vijbgpiZIO1tPy/i5BLomaA+jZT8pN8d7ownBz+95nU9Li
 V7QdsCP7jwKkytPvMIAZvCNf2ZqmbYPa0MsCTuYlccmTtdf5sXaaS5DvoiNkSbK1Zd90
 gLX0Lt78x8BCW47KXD7qTKc+21483ed2cuCaDbNDp1vU5egN7MnQnZNcn//JsNVo6YI5
 cf8KIKWSwGA0vRZidKlypSLAc2HaDoJKKq587hY4CB+5biWTCyFZEXlAWLPa1A6BjFx3
 vu4/YpzEYXy2pj2a+MeY2r3Zqti8f7xEU2/8U5YYhKxDMZeaKZBaWXXu2rlvumDksz69
 pzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688313332; x=1690905332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue2dx04GA0MMTMF2nL8iZsmgnBaXiJ8OB2kvZbsFtIY=;
 b=CNARWE73lsL8UcVDqI74TSv3jPZo24ryRhdpWF+2mVIZIWPiFX8PUyQU4H6t0AhoFW
 8M/JjKtypWTpUm6Ua3oue1DXWCDPSbeatTvmhgZ4r6xZmJEVLuDFXwSOswfPmaihoIGH
 hkyqTePlziUVcqcB4ircgV/xPDUSSBQ4L3w9FiYSZjPkZlzyLQPcDQ12DaF5M/E6L0SX
 Nb5KoO3ED5m1fBOl+j7fQjmP4DuOg/qBC7P4HTyLfTGlIIC2zUihpAaPIrWsncAEvgTt
 KCnR3fjnAhPM1GPdBsQpaaLRgQF5idfyDI9C16X4rxnsYWarW6q0kbZhG1poSAFoQwa1
 HsOw==
X-Gm-Message-State: AC+VfDycJ5tWAZBCXwvF+Ud4B224GzJDxjtEFz5quf1pG266mUL5Wk0T
 2zXerA5BFu7ty6sm4nOw8OYf7xmVowps3YtQuDdCql0/RQS4RjlN3TX0ZSF03wcQfZIW3W6SJmC
 7N/HUXvBGk7Fj4bJGTX3CcS+AImgegFHWi1Lf+/Fm7N4Di/PxRnVyki9declLmcMzMrxUexrSJ1
 raVLc=
X-Google-Smtp-Source: ACHHUZ4JSt57NbLfXAI7CVUzf3qa4Hh5I8M3PBsPsTjma3iFKO3BYQexLJHWDsXiqi0yu/6wykZEFA==
X-Received: by 2002:a05:6a20:511:b0:12c:8871:26dd with SMTP id
 17-20020a056a20051100b0012c887126ddmr8900488pzp.25.1688313331659; 
 Sun, 02 Jul 2023 08:55:31 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b0066f37665a63sm8231969pfn.73.2023.07.02.08.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 08:55:31 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 14/15] crypto: Add SM4 constant parameter CK
Date: Sun,  2 Jul 2023 23:53:48 +0800
Message-Id: <20230702155354.2478495-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702155354.2478495-1-max.chou@sifive.com>
References: <20230702155354.2478495-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x533.google.com
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
2.34.1


