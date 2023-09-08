Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154F798219
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:13:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdc-0001rK-Pl; Fri, 08 Sep 2023 02:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdJ-00014O-GB
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:27 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdH-0005rd-16
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-573c62b3cd2so1343215a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153177; x=1694757977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW3nOVBepNUyjAGvpAdig0q954l70YYp+9BKZ+7kzlc=;
 b=RRpd7eSnAwspvptIILi5AJhRHtlTAXKb5f713qdaiRGrPRRtQ5XnhCwvQdZ/qEvhM+
 bKFYhg5CTyViuXUR8iulMoXMOSfrZzlS9pgC5K+xS5Y7wbjCJLLrT779AW8TinIkfQrK
 xR3HlXuHgmMr8iJ0hg/aN58GLXDzFvj4LfomBOwdJ8EM3DsuKiKY6nrcXm/VajTsakoW
 6z9xDZqBtPyhnXjua5+KuyqQToyw0unmqKTLXfkl8xzUuBAiKbyG5DcB07VvYDUMi+tV
 crhe0jZT3VV++x8DnoixdVLmMXwF5CUeGGzhySiqb071eRB17YInrKh8n/ekXzgXfPMA
 73lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153177; x=1694757977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW3nOVBepNUyjAGvpAdig0q954l70YYp+9BKZ+7kzlc=;
 b=T8iK7FKrW4E33WWygOzTf6chrY4iezSjttQpEJ+A/Ynny2rlrdUgkB6f3g9QQpy16Q
 Zx7f26UPShwfaSYyqO96ACWzCe707YtBtxkn0SKoJxRlZFjbBcGhldNsPouOjT14SmNJ
 qKpLkhRIu5xzIC8qeiQatSEC70eMRR5PR0dmJA6zveM3FtEOgJ0hAS8bg/EqjjSgo+Q3
 w8G6oq/O1N2Nxr9/rLhN73id5UA/EEeu9wcfNpbqtdbp5rPbQpuOobzKWkqxqFU/glMo
 oayZuf74y3OMaisCu8b4DZnHEbgaCrbJF0qMP5BjQRohZ5ENq1CFc7Ff3dZvjMEJtAUj
 KKYQ==
X-Gm-Message-State: AOJu0YxgWE5KEkNj+OQKrbei5ipmdj55Q9DsY7CbBsgvQS38JbKtGrhf
 4Ojr0fvKDPv8+SkQsMsuSn6/Ma4bVZnSSkBZ
X-Google-Smtp-Source: AGHT+IG65z+vSNOeH0pwEWo+KxLVKebo78CFePpx/1Veomr/5qsmAsaaiDJLeALzvSjTvoR9K5XYZw==
X-Received: by 2002:a05:6a20:1442:b0:14c:6397:ac6e with SMTP id
 a2-20020a056a20144200b0014c6397ac6emr2085516pzi.23.1694153177170; 
 Thu, 07 Sep 2023 23:06:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/65] crypto: Add SM4 constant parameter CK
Date: Fri,  8 Sep 2023 16:03:47 +1000
Message-ID: <20230908060431.1903919-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Adds sm4_ck constant for use in sm4 cryptography across different targets.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20230711165917.2629866-15-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/crypto/sm4.h |  1 +
 crypto/sm4.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

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
-- 
2.41.0


