Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C977D64E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2gV-0005KM-4v; Tue, 15 Aug 2023 18:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2gH-0005AJ-5m
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:38:31 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2gC-0006K3-0u
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:38:27 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a81437be28so903083b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139101; x=1692743901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=M4UOeNlv5GieXNvhJRpvbH6ZW6aDS0epwrw7dPfq1ldFUy7Fv3wCGJmsqIZbd/5yQH
 wXT2ZS2NGvc77Bf+zuwzHzv8r4ESVQlehtwj2hp4miIwbhGLxJdfDzn6fQ5bfvPK4rDR
 09tID2DgwP9dyozRGBy96kEyGKTTz5kwnmmgBKx5fgs942rjIn75DkeK9SzQyYQ6d6Tx
 X+AGkaXyYaFh0wIu7p+VcpbQBfnx25jZsuZrnGc/TCbhWLEsiNMK1sRnockItTZt+pkI
 eb8Kzmp9efkYzauBcAVWtNrt+Qn9AV7J+jpFNaM3lYDTETAj+IxuBbgPQ/AM4V1utDUe
 dvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139101; x=1692743901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=VMWm8Q7YwxQFT+1qIZIfVfmkuuQuLIh/GZ7M4TRZFeiCRUnhzyirS08n2GNw5Lovzq
 h5O+if3+6mXTFjk9NhFEqlA0DmTHU8s9Qe4HRNDkVRzdXQEyy88pzDbmoZbdCyA8jSj9
 HtXVwGTyXwG/UWiWZoRjka6Cu9jQww2dE7FkBlQBZbxvdpa/4iBiYTMVPrPo8r6uERsS
 2U1z8O9ZfXBoqrMM2YgfKQ9ksk350oDH7xGnfTCNk6SZDba8Nb+lmkJeEqROHAu9h4t3
 xuLw7Kl/Fbbj9U4G62RDi828LcR7T2QhpbZgtP9rzwz4wjhyNsopJt8wcYrCLJ6Dpeum
 3d1w==
X-Gm-Message-State: AOJu0YzCIM1q8RFnLhp9lbsnAFjHTol5HgrKfAVUKNzyNuix3nsddc5N
 u0xCtHSOgJiiE6Tg9ofdwZWG6dojCkbXAurmYjw=
X-Google-Smtp-Source: AGHT+IFJfqCpD+nmO5pqP0YuZgapB63Sa+jkOEDreYvO/jea5P75GHm1q0EWcjGEF+tRaX6UI7vJGQ==
X-Received: by 2002:a54:4d06:0:b0:3a5:a78b:f773 with SMTP id
 v6-20020a544d06000000b003a5a78bf773mr61043oix.6.1692139101343; 
 Tue, 15 Aug 2023 15:38:21 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003a40b3fce01sm5903418oib.10.2023.08.15.15.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:38:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 11/12] avocado, risc-v: add opensbi tests for 'max' CPU
Date: Tue, 15 Aug 2023 19:37:40 -0300
Message-ID: <20230815223741.433763-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223741.433763-1-dbarboza@ventanamicro.com>
References: <20230815223741.433763-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new ratified extensions to be enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/riscv_opensbi.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
index bfff9cc3c3..15fd57fe51 100644
--- a/tests/avocado/riscv_opensbi.py
+++ b/tests/avocado/riscv_opensbi.py
@@ -61,3 +61,19 @@ def test_riscv64_virt(self):
         :avocado: tags=machine:virt
         """
         self.boot_opensbi()
+
+    def test_riscv32_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv32
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
+
+    def test_riscv64_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
-- 
2.41.0


