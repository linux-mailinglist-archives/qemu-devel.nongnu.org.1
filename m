Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E47D85D8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:21:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw29n-0006ep-QH; Thu, 26 Oct 2023 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29m-0006ee-60
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:22 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29k-0006I1-EB
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:21 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d425a2dd0so845892a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333619; x=1698938419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NG6r7b9rhLCBcUYVSJoZtIoBWMqyY2dfwA7ypnvCr4=;
 b=KcEs9g/AzyZ/sYd8v5s/ETBo4EfuEiuoHo9wbRDzj44ehzKvTNEYJDfXB2J19b3k3h
 pjmHig2R/NZDmKe38fYfyYDw3kir39HVKOF/JxVvqxRD3qg7EIPvVdSPtg4PwM9qpZKv
 36VSn/1upmi5m2dHvgY9Mjde3JutkQ4DDhSfd738klcO5gh+3Vr8e2fOyzRVSlrpKufy
 hcDQF03Q+f9Zs8WkXP6HpaEjWlD/YnaDOM3p0qunoZD61YOwG+i/2kkhX7Awnqs9PPVH
 L5zdiLCs3RuGvETigfp704Gs+zhkFykFvkV1ne4cH4RT4VgmV1Ev/peHQjWYCVaqQ8CQ
 vf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333619; x=1698938419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NG6r7b9rhLCBcUYVSJoZtIoBWMqyY2dfwA7ypnvCr4=;
 b=Wpz2rg4uJAHdwsee8qzdGBNJrO9QqXvVJmT2Bm1oUhkNfhUBptMCncSKA6QTWRFwkB
 NxSq/bhM0ONrbHrR5uVOQgyzUHl+346vLkVqOz6qhj1xyUENouzNk07BotLeLXm+chCw
 Ya9zlkQxWbS0s72GNHG0CXXvnw1MZ77kzGHps/ZbyGp2iS0vkRuBwkZsu1XSEspdn/nG
 x7PgHDxBTffWQfvhBvsZMiUwOb7m4ZQJsWCP57I4K32hoRRDuq5Gt4Cdo8POryuiP8e7
 g1nn2XBu6H30r5UFKlC6+Or6IU2cHSDUcVvZzqReXN9F682wPFX3wNuqUvcLDB/uGZQk
 wLrg==
X-Gm-Message-State: AOJu0YzCI2If8XolRoAjvUGzqMI9xxLveHNOkSfq9J1eXfOd7gvSXvKH
 Dcf95YIyloO+tXQtdkUzwkxuvVFH8NGYWK2EVbQvYiQ/uTt/cBpWHzo3Jm1lEKODf19g2NJGjAZ
 N9kUj6rUeagKqfCgR02cpBxfxO7ypuBgD897OtxxpzAH1SJcDMyS2V3HmJn/PkcpVcPdNdJyDzo
 ot
X-Google-Smtp-Source: AGHT+IFGVGWekQlw6U4yViYgA7d+ifsXG/qvMIYAbqsxFAXcKFea0HwIUvE5BViQDYAzhjQsLenGMw==
X-Received: by 2002:a17:90a:f312:b0:27d:2cc3:c805 with SMTP id
 ca18-20020a17090af31200b0027d2cc3c805mr19215767pjb.46.1698333618643; 
 Thu, 26 Oct 2023 08:20:18 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:18 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 02/14] target/riscv: Expose Zvkt extension property
Date: Thu, 26 Oct 2023 23:18:09 +0800
Message-Id: <20231026151828.754279-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2881bfa383..5099c786415 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -131,6 +131,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
+    ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
@@ -1375,6 +1376,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvknhb", ext_zvknhb, false),
     MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
     MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
+    MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.34.1


