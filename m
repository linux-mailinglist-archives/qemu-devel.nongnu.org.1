Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31B7D85E0
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2AU-0007bu-VW; Thu, 26 Oct 2023 11:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AH-000718-0e
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:55 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AE-0006NV-HS
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:52 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5b9390d6bd3so141891a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333646; x=1698938446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkwlpLYypRxSWiGHgKxtQp1RAJeqYUNkInw/XRm9smE=;
 b=ZOeFnU5WmpTwfjspwRMegpzGScG70SgdcNliSJpKaR+j+bW8/1AVgPQA9415FV9EqF
 WydMee9Ix0M0Cw4l5kXXCawmU4y5/+YNEjWi1BYZBiTfeu/qJBzUrKZ3cWkbrwGCuWwD
 oPui00EwqpOpjbNJL40RLxKDd4V1qQkotMXIuUCC85S+X4s5eRxzCIOB12jr0gof16a8
 hGIgJw57LFtJCJbCGd+DsKFkdMuQ3ZTg/2eNJafQI8585CtwOKz1Obh70K5ReH7Y92pP
 3ytiAe28sR02OuTqOHrCK/ET7nX9jof8uBJLNECRd/RTHbow9Utrgp8gx4NJGOZCCirG
 WsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333646; x=1698938446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkwlpLYypRxSWiGHgKxtQp1RAJeqYUNkInw/XRm9smE=;
 b=H85QJv+9a8skGz6u6rpfZNbVkf7qjyAE3HakK3eSLktA/3XAo48f7Kw+ALTWPw7d9k
 1kCm35NTpR0YwXlmbI7RRBMD3PxB8dPdR6zmot5vLZ4imFc9H2f1dOKH/i4WTQ8U1t5z
 HiNHKv1CQY3CPinX8qqvUUgTwiWuY6E2/rJ52CM1gtYOd7iuK6UkowX88mQgLsVEZRy6
 7eobTrmYZH5t6NteDyQAXmXbROso+dsXxFqU/I2nAksFv+adF8yNJiJmfuqqeR5+ycat
 7sbwzft3lbVyEtQX3NYOKgylMt0QdQGPGGZgwYhxy6Fwe+FfHvX+bGmVRNjWZPimjml7
 s+Zw==
X-Gm-Message-State: AOJu0YxR/UYL85b4pd21E5Ac5KHJ10dwl8gUcrV5NMvgftps/xEP/I4Z
 XpMh7mSc8qKg9sHsm+0kgLEGk1JWRB9sZhoJm/Dh+TeT3pv4yfD94rrJpGdQp5lZT6Dkm5/eE2Y
 12I/rQUZls8jO4kFp7XDE5jBrCHBUrgXnG5bS54ZKB3bfBBRhVIqNvKl2sk/Ht6BtQS1vsZW+tB
 tS
X-Google-Smtp-Source: AGHT+IGyed+0TNJ5I2UdgfuHkrlZXuOSUMwXpdSqYY/ZaWcoYQUE8jPDdK/h7USC2rcDdcUEAwQeOg==
X-Received: by 2002:a17:90b:1c06:b0:27c:f4a9:7e20 with SMTP id
 oc6-20020a17090b1c0600b0027cf4a97e20mr3718993pjb.15.1698333645902; 
 Thu, 26 Oct 2023 08:20:45 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 09/14] target/riscv: Expose Zvks[c|g] extnesion properties
Date: Thu, 26 Oct 2023 23:18:16 +0800
Message-Id: <20231026151828.754279-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x534.google.com
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

Expose the properties of ShangMi Algorithm Suite related extensions
(Zvks, Zvksc, Zvksg).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8eae8d3e59c..1709df76a9b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,7 +133,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
+    ISA_EXT_DATA_ENTRY(zvks, PRIV_VERSION_1_12_0, ext_zvks),
+    ISA_EXT_DATA_ENTRY(zvksc, PRIV_VERSION_1_12_0, ext_zvksc),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
+    ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
@@ -1385,6 +1388,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
     MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
     MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
+    MULTI_EXT_CFG_BOOL("x-zvks", ext_zvks, false),
+    MULTI_EXT_CFG_BOOL("x-zvksc", ext_zvksc, false),
+    MULTI_EXT_CFG_BOOL("x-zvksg", ext_zvksg, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.34.1


