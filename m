Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 878087D709E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfao-0005UT-4V; Wed, 25 Oct 2023 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfam-0005SW-4M
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaW-0003cJ-Nj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so5563080b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246867; x=1698851667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI8WGG20prU7E7FZ00x7AWMKsXsfCxZVV/R6Dc9ONDI=;
 b=VcYMAce0K0bmO9rXWaYVGsdDU7ZihhW2buB7qVVlTpX/OowLkWfk7M0L+TIYjD3VNZ
 f4Zf5CkPf4Khpu1wDJaw9RhPWMlPEKZm0HO0sre/RyDAV2vI1ofXRf4N77mKqLasLi0D
 XWfV19LBSY47pBkqzo/t6ybrc6EzSa2aTV84PdKNhS/CocoJz+5yJdqlO/7ANqq/a7bk
 eJG1+WP5gvQHp+Cmk4r2D4cX09bvvkZ1YHLutFnbiX1N8t7ZvojKobXlnaiMXzLQgs3D
 lI89kBCIGJb8WUIBLZdfA2c8Ts+NKcQ8heFe8S63CVHUq5OT+W9Zbwl0HiTa/DDtjfB+
 K4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246867; x=1698851667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI8WGG20prU7E7FZ00x7AWMKsXsfCxZVV/R6Dc9ONDI=;
 b=gYyR6QVqkWH63VE3SQAoRmGJ7NM+o91qvL3XqWf6oHxxDgbysgqjBczYWRkdy6v/9D
 s/7KHee1WdZ8n07f958FPu7EfXIrY4ucIGdxltrIXFRHjQzQQqa9jjHT4wmO8MF9pG7c
 g4QMPXZ8ivYF/4ETrWMWpOAHJ4l/2ak+dBVoArql7lXx5oiueu/47dcdMwYK+INuoKUO
 4n8qW+CoFiwspQdwsVj6wmbQ9EJVqD5w7wE3UFGFVpqPfsyWoj9EIJJrVNZDlhq0Zohg
 pQPuRp49HlPzvnPdzuFXmJb0P0jSs16+52c8mewoZLA/PYX7zfwSkYkjEtVn2eoZ8Wdp
 jnhA==
X-Gm-Message-State: AOJu0YwitAy2JVe+04l17b191R31S/W7xphFmpnoZ3PYRz/KOEyKbtCe
 o9Hp7keQf51lwjC1RNu8zS94xuiNmjmciOxh+bMyspI6IGVIUcio3wWvc4+CbUT/xIXIl1Yru0Z
 kEv+fvlfYs/iofa8bRH+DM5gxsRzRqAhH07DidZYwJmGurJg1a6cye3RHt8lYBCiiPVYDCZO2ng
 9s
X-Google-Smtp-Source: AGHT+IF5N5eSPEUxRMLdT8Xy6H6goedVq56M3qTwPXnaE2Egoj03Vwnyz6cGOJbhNooeHpnqzpY16Q==
X-Received: by 2002:a05:6a21:a108:b0:132:ff57:7fab with SMTP id
 aq8-20020a056a21a10800b00132ff577fabmr5508792pzc.2.1698246867037; 
 Wed, 25 Oct 2023 08:14:27 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:26 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 05/14] target/riscv: Expose Zvkb extension property
Date: Wed, 25 Oct 2023 23:13:29 +0800
Message-Id: <20231025151341.725477-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5099c786415..992f8e0f7b0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -125,6 +125,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
@@ -1370,6 +1371,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("x-zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("x-zvbc", ext_zvbc, false),
+    MULTI_EXT_CFG_BOOL("x-zvkb", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("x-zvknha", ext_zvknha, false),
-- 
2.34.1


