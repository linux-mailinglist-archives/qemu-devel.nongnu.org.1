Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA674F662
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGlT-00050U-Ce; Tue, 11 Jul 2023 13:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGk0-0004As-Kd
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:01:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGjz-0001O4-3k
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:01:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55adfa72d3fso3083415a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689094890; x=1691686890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ow2HOo+QMXtjkHJz2qvxXFVHS1pwzVfj+KbMmuWjec=;
 b=hw697bt/8ePzzk5rmrrgVIb1mgjMi6PhJaY3xXjnB0DGDk6i5bEZQWgsHrCs3RZ7jt
 Ny17gt5ReM75yJgjTFbbdKPPORvLOS1WFhRRsUjJMFttWd/utIp9jsM2BW3BUnyGxKrY
 jduv9H0cga2MzhhlRRaonbeflNqIwPfN1bjOSy5IguYI5+tDdlPUgBFLp6nCptaZKQSU
 8pr0QvaT1/UX5YTPkNtV4IwuCElAO8zgzqZdqeyMLKOlDiTRVVCFFSCR1wcy2m37MDRs
 KGdhKrzg8QvSXXi94KeTPnr1KqTxUHnU45HdV8W7t8vnL8Iuc3X3kvKqN6Pmdmc2LnwS
 MSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094890; x=1691686890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ow2HOo+QMXtjkHJz2qvxXFVHS1pwzVfj+KbMmuWjec=;
 b=HI5Ho/k7va/Pm4armPkKgYJq8rnWS7Oe/B5IW3ErA4ivqg3oyWfHgxjtsoXT5+O6ZJ
 ZQcalv2vV7AbbNcWnuebocQ4rv26YuknKtIeehcOuCiHUhOdKCSSeKxQ4C/ZGfR5vybI
 zSwc6RziE+VRMRUWT4Z3scoB7K1dCBvsWACFjvg4sX4Hulo16reLKxC2t/CHWZtaljBX
 EO/U71R6mMW4Ik8hI/ypFp5oTLBerr3/ql1CNUcPBnrQDBJ40FDD4LbFOwOWK7+2xwew
 gdIbz4KKk2EhRw3ZkPGHuFlZdOq1btxqEnUX0WjwWlvwEEIR0xhuigV6OpoOWuo5Bpij
 kHeg==
X-Gm-Message-State: ABy/qLZkBt4omv/zHP+e7E89nsD1VdqAoSEIkvV23bE3Cl7q7W/mH8bo
 2TnEGC54/a442Rzq9esH5oakucAZU/9LkOrWDq/E9aDQn7hJ1FgkzG0CZo347y1gF/Fc5OurSnH
 YLrC653752VeWCOMJc+JJBl+xdeWTMKpNAgcxkwhzSdNRZAjDtnYtKHZe7KMzIefoXs+uLvZgC7
 OUq9M=
X-Google-Smtp-Source: APBJJlFPc9RZ2TYV7HakHdd7aDeKbmldEi4SPCJhNYNylAijIKu4YqFkx3JCOtlkNZOHAhK4iAIgKQ==
X-Received: by 2002:a17:90b:292:b0:263:528:144a with SMTP id
 az18-20020a17090b029200b002630528144amr14185814pjb.28.1689094889692; 
 Tue, 11 Jul 2023 10:01:29 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 gw10-20020a17090b0a4a00b00262fc84b931sm8381793pjb.44.2023.07.11.10.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 10:01:29 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 Max Chou <max.chou@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 14/15] crypto: Add SM4 constant parameter CK
Date: Wed, 12 Jul 2023 00:59:13 +0800
Message-Id: <20230711165917.2629866-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711165917.2629866-1-max.chou@sifive.com>
References: <20230711165917.2629866-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x534.google.com
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
index 9f0cd452c78..2987306cf7a 100644
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
index de8245d8a71..382b26d9224 100644
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


