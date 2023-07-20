Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E875B588
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXKT-0008WV-6q; Thu, 20 Jul 2023 13:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXKG-00085B-2c
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:29 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXK4-0004oc-GW
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:26 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a4062577c0so1404535b6e.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873609; x=1690478409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=ZRmzzzfwF6gsXbKrJ8642ga2z9t3M920KdSrjWOk/oRvWPfJmuwARTsuNrl+qRjfPf
 nf/d7HKin7/RMIM8o/zyBM1GKQDZiDQDevOtJcsqYaUIu93OG9S/I1TBMrksiAR4HA7a
 pYoqvUv9XFG3jK0VmO+nMPGtcYa7FKxCD5goJy8OHfeHjYooJLMYAnUEDwbGORaxs7x/
 YregULSMemmI0hlPS5WJRvp848W3v7mtDJQRVHw8CApiLmYg2oOTBLn45I0ZLfy8ZYMe
 rt+pU8MRhyPYujWRkxxVFI+zsUJsSPDby1PNia6lEDv/JgDo4wLvMPunELS+Tx2VWg5Y
 ROOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873609; x=1690478409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=cziB+JA5VhjkxjNnJWPdirsKjmV4OT9mowB7tFm6ro/fteDFJaGWyeBAty/hQ0M7Ur
 Qo3HPjUTcXF8/+B19FiwEF3ZG3GQmPX6QbT6Q2zti92Dxd0Esn6bJmx2Qu2FE0Wob7n5
 Us5keeCLVmkWMkEWUDBDfgW0T6AFGHDl2HBXzlQKUEURZRDAKCiBYR8Bgx+AxKeIiIc6
 4Oc1ma7hVv5fFkt2FnLvKr3ccV681pKBvQSH5Wu3Ot3ckNjcrnK9gecR2WmVMAECeRBX
 l9KcRf3Zrsn6Tgt+THyuY393wgH91FydJalMgG0Sen83h1Xk201fQBNSEwCeaBVTTj3c
 VWFw==
X-Gm-Message-State: ABy/qLZBgFSbo3NXFkhnBd5zBVT0IPOU1iPh6DXyQm/YNzY+Hw+pyJhp
 1igyXfG5thbNa0wDvqzjCtasQvHEJAgjjtMRoyqTGg==
X-Google-Smtp-Source: APBJJlGwBh2kFb966wrebfiu4wERvyRCr/UIEGJt4QVaZoCaW1jiepZ/jif5DUHKsk8SIH+/s4hn4A==
X-Received: by 2002:aca:230d:0:b0:3a4:8e62:d9f1 with SMTP id
 e13-20020aca230d000000b003a48e62d9f1mr121486oie.1.1689873608763; 
 Thu, 20 Jul 2023 10:20:08 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:20:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 10/11] avocado,
 risc-v: add opensbi tests for 'max' CPU
Date: Thu, 20 Jul 2023 14:19:32 -0300
Message-ID: <20230720171933.404398-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
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

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new ratified extensions to be enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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


