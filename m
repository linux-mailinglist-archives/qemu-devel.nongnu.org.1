Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C827D85DD
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2AU-0007RP-36; Thu, 26 Oct 2023 11:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2A6-0006us-Jy
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:46 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2A4-0006MP-1T
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:42 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso860266a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333638; x=1698938438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28soGqZ4hmvdB2DBr+8fDTCxvQalUe0nHRzFfVeJIWI=;
 b=JkZ0zCmEMX9lEZmGgEw4dcWLbfqqakBeliLBOKaNRibc50tmx6x7Y36NnP+ySs50eW
 yYj6DDn9zeM18lBF+6/1u3PAgW4kY5zclWAAvau8SaCQaI4O+CqKJtS900iKFtamldev
 69XSPsBaMTKx7CNlRUoXmGv/4OV8MTGmVcv2T5b2OjzMdT+LgU6uLLydpW7JJ0O559a3
 qGLMAAFSyP5jHhqKr0X3bA335kDe1L2xAEMm70PhwOp0EDyua+4kouP9W5zc6fUV2P+8
 ubiljFvZzAJ5H8sFmcNDNOcVNw0glpph/5Slvo0fQbMEJa1z1Efu6h/wGPTjyU23BtY6
 bO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333638; x=1698938438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28soGqZ4hmvdB2DBr+8fDTCxvQalUe0nHRzFfVeJIWI=;
 b=eeEUQ7flvR+0tnLHzGFYnXFOIhrLgN224XQYf7NYvKdF6skO1iMcwgNxfM62ZD9N4/
 dBMw8nN0gaLkYLgr6phu8mbxd3XnYJHfMDRSXUAWwzeQwkwA+EZnt3plZiua2wcWEXnb
 l7v1L355JXfTuGb/dpAS5Xs2pHDnJJzZV3Y/c4tB7nexKMg96LDMA0LezCtuIFrmQ1iL
 fJFytepdAtM+WJ2pwHtfG0cahW4/19wyk/7cHc3euIr5XGhtcR8rBVQzmz7FMo2QfqaI
 xIkIz784Io7rESmDTojHrJ9KIZACtZ+pFC+raGIemStm5yDH3jDlR85sRsxgzdzSzet3
 kp8A==
X-Gm-Message-State: AOJu0YzydtXUJ24vGSHBkVv5kq1H5HLplt3apXmtVN/5v5bxJIEjgQga
 Z3X5v+jMg47g8sNRo2LN72kwq+Jrk9WvUbY+4RtivMk14Q5ejZ/Z/1pwDwlkhfAAnOYx8YkU5/r
 F+QEqmizo6bM84yTKYSKm0Xeh6C5aBAwev5pTEF5zK55EQadzORD2D3B9DLfpTjKLLri5yegl0W
 sN
X-Google-Smtp-Source: AGHT+IFOCxJoQWot5jUKFDqwrhyADGiRTVh37uFGmwwQQGizt7DDRK/eF0f4K16X4HLVD7xH0CW9Vw==
X-Received: by 2002:a17:90a:7442:b0:27d:9b67:7fa6 with SMTP id
 o2-20020a17090a744200b0027d9b677fa6mr16672661pjk.3.1698333638290; 
 Thu, 26 Oct 2023 08:20:38 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:38 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 07/14] target/riscv: Expose Zvkn[c|g] extnesion properties
Date: Thu, 26 Oct 2023 23:18:14 +0800
Message-Id: <20231026151828.754279-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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

Expose the properties of NIST Algorithm Suite related extensions (Zvkn,
Zvknc, Zvkng).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 992f8e0f7b0..8eae8d3e59c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,7 +127,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
+    ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
+    ISA_EXT_DATA_ENTRY(zvknc, PRIV_VERSION_1_12_0, ext_zvknc),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
+    ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
@@ -1379,6 +1382,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
     MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
     MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
+    MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
+    MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
+    MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.34.1


