Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A861A73A5F3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCN1K-0003hb-8n; Thu, 22 Jun 2023 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN1F-0003Tw-Tk
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN1E-0006An-9Y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b51488ad67so39638655ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687450726; x=1690042726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eM7fMUS/bQ7fR32WgG7Yf2+xFexOx9ylKR4feRvm9IU=;
 b=SqYk/jO4BmTu1pVDOl/xPtyhH4VTMjarNCNOIK064NIuKDXGt/Boxaqp5gnjU4RK53
 BCsSu9qd31XZhs6VxfwdzPYtmQdUdh1pTeSU1u7cJJaS55O58nVKfDuxTF7DYO4Nm5Ri
 3PfVkXRYU0EPTReMa+JRYoFuYV737SN0x16La7u9yGQFXV6z+MCqnoaydL63O4L+IlmU
 BNQazqPPhWKaI6z9YKwC8Rg6i/jVs9Sb+L0kSIfRlNGmaIoF6b2QuWB69RpsH5be1Qva
 4qYYbtJZWnnvatLWfpZ1uWyIgrrSC7gaFMJIS0tc6MNn2NLKf74TBYeaZLQ/493oRigk
 D9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450726; x=1690042726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eM7fMUS/bQ7fR32WgG7Yf2+xFexOx9ylKR4feRvm9IU=;
 b=Giyzp3BgN6uUdFR8f5wc8UWxxuNodMRhXJdVbvQUW6byMaHYfj+93t1QNHDRlQs5dl
 NGDUXPw06PaUF0ZaAjqWXQ+VIFZgqQpMCHsVJi/aSGGIA92SoeOP56KiIfbMVqB5ZRwq
 fJtmKRRqfHn+mWQHaCGoInGX0iTvd3p9xw4Y8Z/Zj0cKlAH/qmi6XWPuqASdhwCwTdwp
 LWeV4bV+QBklRWZwoxf3/oPufxrzimZRqjFHak3MRFXEyssPTfK+IhyZ4vNeGEBQhM+0
 7TXFP127+ywSjvkC68rn4rQFiHa8OJ31QKRb0mGb+oI2WIReFyaEnnAx6+wh+EcUno9s
 1s2g==
X-Gm-Message-State: AC+VfDyhQ4V1BRNTm5b9Ow6ISPakrtkjRhMYcxPEfmwCM8xT2+HSF0y0
 iO1mSS/qB0/D8aVFLoyLP/0ofHQ61472mxQCcWeKgeGfqTmqxQBnDZm3Fu0sMt6cX0LKEovwgaV
 Ai6lbkkjbKsUAtsADYU6yRBilh9Pr7Vzy1zV1087PBEan21Y8405htXFBKkON1dFfE/fefAwv35
 Nj
X-Google-Smtp-Source: ACHHUZ5UVoHWlDclwROU1+WCw2kmw/khG6980sONrxh2/ysbl3ro9h5UEi9FO7GCIBHhWVK8QCsh6g==
X-Received: by 2002:a17:902:6bc1:b0:1b1:9d3c:66c9 with SMTP id
 m1-20020a1709026bc100b001b19d3c66c9mr14441827plt.5.1687450726564; 
 Thu, 22 Jun 2023 09:18:46 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001b3f039f8a8sm5609683plg.61.2023.06.22.09.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:18:46 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 15/17] crypto: Add SM4 constant parameter CK
Date: Fri, 23 Jun 2023 00:16:31 +0800
Message-Id: <20230622161646.32005-16-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230622161646.32005-1-max.chou@sifive.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
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


