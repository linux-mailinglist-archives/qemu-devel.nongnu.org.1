Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB479028B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6w-0007zk-9L; Fri, 01 Sep 2023 15:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6r-0007z4-Ct
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:13 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6p-0003DK-Ab
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:13 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-573429f5874so1343466eaf.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597630; x=1694202430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdvVF2+aoI8lzXMJPBhi2K9SUSXzJrx6SlpvXXkfYMI=;
 b=EJXqm5BtnzzGFa26MQRzUUFpPmi8dIsojvL88kZABJMAElOGAawUWbGv8VuTCAbCld
 TGDTz5/2sbj+WHi/8lcpvsz0Op3FKLxSvs9EY64/CE2l0HanmQVvbOaePNVYAry43Ubu
 622MMOi77j7kvA4/udTqiR9QjRU1GzzcSOFLNMeQLdYMN+Hd7sod+3BF9RxSFO0tPcL6
 XUvkd3F+drmuRRtEvu9+ddG8vX8aCtOkiw/AHcXpCxWRnXV9dKlniCRqqL95WTqoMvjz
 +K5HMjuA2wK8q1Zae8yZ7enXhBDRykZeMCn8+cIioapPzJ6Ox4MgjavleuqHLuUfxFwE
 aI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597630; x=1694202430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdvVF2+aoI8lzXMJPBhi2K9SUSXzJrx6SlpvXXkfYMI=;
 b=XUD/S3pugoEcVz/qfD9vxotA5cn6za98vdNlZvJOUbY0t3jy6I2zzsCeeB2rdOILyy
 nGJe+RJIk2G1Atkw4nDI8lckDNLpYfNRZO0kLT9XpuzGlYqm01XZ4rH9c4yQf58NSxt/
 8EBAb32nviLGuMPXafIwPzw0LfL7hF1trpZMAc1DUjY2nNQm+5QeseN/F4ryGDhHUPp6
 qzJx4Bn1Vt9AG2WgaV8TFAr7hZEkJZn1QjkcglR3+cXlAdAcfGsm7wG4wvomznCgUM1t
 NnhKDMNKaXrLNxnMa8v8fpMXNZgGvkegkNVGVnlIo+dLXh7AhFTLjUiL/qBkmFUCQFDX
 6xPg==
X-Gm-Message-State: AOJu0Yyyp8m8mb84Z+fOpY9zHzmaieyTDyBFBTlTW2tcbfnTZ7+wn3Kj
 kto7t7n++X/xv/INunbsG7o4Y/XUEL0ayKKC7TA=
X-Google-Smtp-Source: AGHT+IHWmG264FFU6WgVYIvcsuT0hR6Wxxu7I87ZmEnHAVafW2sQd9RwpvlYNFx8fz0JQF/QD24l4A==
X-Received: by 2002:a4a:2a14:0:b0:56c:820e:7f02 with SMTP id
 k20-20020a4a2a14000000b0056c820e7f02mr3705195oof.0.1693597629906; 
 Fri, 01 Sep 2023 12:47:09 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:47:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 11/20] avocado, risc-v: add tuxboot tests for 'max' CPU
Date: Fri,  1 Sep 2023 16:46:17 -0300
Message-ID: <20230901194627.1214811-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
adding new frozen/ratified RISC-V extensions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/avocado/tuxrun_baselines.py | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index e12250eabb..c99bea6c0b 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -501,6 +501,38 @@ def test_riscv64(self):
 
         self.common_tuxrun(csums=sums)
 
+    def test_riscv32_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv32
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        :avocado: tags=tuxboot:riscv32
+        """
+        sums = { "Image" :
+                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
+                 "fw_jump.elf" :
+                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
+                 "rootfs.ext4.zst" :
+                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
+
+        self.common_tuxrun(csums=sums)
+
+    def test_riscv64_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        :avocado: tags=tuxboot:riscv64
+        """
+        sums = { "Image" :
+                 "cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e",
+                 "fw_jump.elf" :
+                 "6e3373abcab4305fe151b564a4c71110d833c21f2c0a1753b7935459e36aedcf",
+                 "rootfs.ext4.zst" :
+                 "b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb" }
+
+        self.common_tuxrun(csums=sums)
+
     def test_s390(self):
         """
         :avocado: tags=arch:s390x
-- 
2.41.0


