Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6728328B0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:22:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmwP-0004nD-A3; Fri, 19 Jan 2024 06:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rQmwM-0004mH-69
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:21:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rQmwJ-0008UG-R0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:21:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e9fd483e2so2477835e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705663293; x=1706268093;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meHfwEYbS6E+e0h+odVZXRTQRV6tLtgSbMqCs98rgEc=;
 b=hoaYMOOHSf+FRYLLFspgWf/I9Y3QhrKKCIC0yzaWnIsjEscBldw3GnzwvgKXkkCQ/G
 g66rAeH+dth2kIgMwSINaZgECHwHgU0H3/pXHh8zvDYGrxsjhxrZr1UbzbTKVeJwnnS6
 nMlTsihqCSGE0W84EpvILc2w07EEePB83wdCClYCNgKnxLFSy4O9WfEUINwfM6edpuGv
 VkdgBlrqeJ6U6iFTyTuimkJuIMUDvW19qT90rpgOkhgcrOUlTImaDhgj8kKLJMfnfxQH
 jEiWjuF/VL2JIYkQ3oyF2Cr1yBEI7QTFp5FcSJypDLrM8DU2IzNEcDB/fsa8Gb3Zz5fq
 e4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705663293; x=1706268093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meHfwEYbS6E+e0h+odVZXRTQRV6tLtgSbMqCs98rgEc=;
 b=v0yvZ7xpgbRUDcxPEme0bIWXtsH40T9h2tMGPydJrqLMzvL2oeVr81qZCNAB1Gx/fs
 eQpyJb63H2dTF+HZetKF0B8/tRldpvOb6SX8exCWsY4Fmcg/X1g1p2QNYWae+9yb+9LP
 pc04x3VppPXhXTCQBiknVHH6HwzwE/rGtw9/eKqGxIdSZ9q1Ly5yFbZLwpPEYexobMKD
 0YfqBodxNtrFeqt+ojTrvSIF/qRSYYwXNH/RcprigzPqFBF3+R/bOK39LV26DsmLLrBI
 QIjq3C94x/8WEs+vJiAr4BdVBo4GEFxacneyHyf0TPLNH+envjjryvUAxO+vKH4Czb4H
 kdhA==
X-Gm-Message-State: AOJu0YwZq1e4RlQDwaXk0K2l+C4myPYdBjD7qy5m+zv3QjzLyExGUTlL
 Z7C+F8G0Rc1Z3/3xRu7s07KssGAiPzb5qSqgrxOPuitcVTioYQwZJNKGqKXwqj9U5YPW7hFWS0l
 8fmA=
X-Google-Smtp-Source: AGHT+IHfBCcuhIeSt6bmy9hebd77oXZYfwD5PCJc29IZ4wut0VWkKuB8OFi8MQ4+ivK+Dvw1SkJFRQ==
X-Received: by 2002:a05:600c:2205:b0:40e:8bb2:6bdc with SMTP id
 z5-20020a05600c220500b0040e8bb26bdcmr1449697wml.87.1705663292856; 
 Fri, 19 Jan 2024 03:21:32 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm32428067wmq.44.2024.01.19.03.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:21:31 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v2 1/2] target/riscv: Add Zaamo and Zalrsc extensions
Date: Fri, 19 Jan 2024 11:21:28 +0000
Message-ID: <20240119112129.20067-2-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119112129.20067-1-rbradford@rivosinc.com>
References: <20240119112129.20067-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

These extensions represent the atomic operations from A (Zaamo) and the
Load-Reserved/Store-Conditional operations from A (Zalrsc)

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 5 +++++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8d3ec74a1c..604baf53c8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -103,7 +103,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
+    ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
+    ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
@@ -1491,6 +1493,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
+    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
+
     MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fea14c275f..cc4c30244c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,7 +78,9 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_zdinx;
+    bool ext_zaamo;
     bool ext_zacas;
+    bool ext_zalrsc;
     bool ext_zawrs;
     bool ext_zfa;
     bool ext_zfbfmin;
-- 
2.43.0


