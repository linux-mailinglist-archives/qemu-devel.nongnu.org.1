Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95917CCFEC
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssJ0-0001du-Dz; Tue, 17 Oct 2023 18:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssIx-0001cw-Td
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssIv-0002XH-Fq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so3511841b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697580764; x=1698185564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MNQGvEfEHzx/KxNbakqMdUCKWjRU5l73TxA8cZv8xU=;
 b=HDwghnVHrzacUS/S4txCgiDtZmDftTisZ+ZYWaKY5yazUP8LoPdH4FrSyLS59wRyIU
 F8I4yiC/9/o9MM3pzMn4SeQ+3pq1Wrcgk2mVP/pB4HG3M9VKUh9c6GEghqeVpcEcNMHD
 CAsuoLL65z7tOrLCMIpAxI7x5H37Xit7SQ0Sex8QYQIopIEDDzcJpqNyBtcMWT6OByiJ
 RpQDJ1hbsmRp25vbEEFPGMec283haEF6n0gLjIpVYtjFsel3x4ZC+tIxlkox1Hx689Xt
 foiU9rVDQPJ3Y5JmLBmkU9p1MdVne9G73iW8GnneaGDIwccPS//G/7tZHsLbv2iMcCqT
 FRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697580764; x=1698185564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MNQGvEfEHzx/KxNbakqMdUCKWjRU5l73TxA8cZv8xU=;
 b=wt0eLWhuVNQ4pSYNQtRTtxFwAYJ2nQ57cEzy6U5EobSPjzECv78StKn1L9LhDMKgHa
 yEH4VwT/v1WIo40XF2bHVcrxcQAYsxO7TYmTZQlDrW1Qf/iVFWB8Eqs2wFvcKhS8I3a6
 VDjZWHD87u02TsrlSRDo30t49kSPegeZZPAtMKNWbLRmVplzwGur6/OorUv/Pmn8qvwo
 GwtBOlV2UcX764HAZUBNwKf4dwa6L3vqU9LwgRDZRdt9o1zL8Fl8lGze0eXwE314MaZI
 B9wUVdOlf/MfqNIS9Nst09Ohsonw4OtVJ8lsUXVtn5WL1mikXCqV+hPfHLqJGcZrif5N
 ZNVw==
X-Gm-Message-State: AOJu0Ywk1EhM0kqyc8aa9GAz/nfdFJBqC8MNT0pV4IaDuNFaXA/C0XjE
 G+0lVTy2WFes/4tCyeB4bzJVuEJNwrcxA7oYlF8=
X-Google-Smtp-Source: AGHT+IGC9OH51cLhjyWojWhdj4LYjJ0h5rPPfO0QTzz5pN1LHRM6rzgSa1f8xVMLSBx61rlolrmfLA==
X-Received: by 2002:a05:6a00:17a8:b0:6b8:69fa:8ff with SMTP id
 s40-20020a056a0017a800b006b869fa08ffmr3666403pfg.17.1697580763421; 
 Tue, 17 Oct 2023 15:12:43 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62d14d000000b006be077531aesm2011023pfl.220.2023.10.17.15.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 15:12:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/6] target/riscv/cpu.c: add zihpm extension flag
Date: Tue, 17 Oct 2023 19:12:24 -0300
Message-ID: <20231017221226.136764-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017221226.136764-1-dbarboza@ventanamicro.com>
References: <20231017221226.136764-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

zihpm is the Hardware Performance Counters extension described in
chapter 12 of the unprivileged spec. It describes support for 29
unprivileged performance counters, hpmcounter3-hpmcounter31.

As with zicntr, QEMU already implements zihpm before it was even an
extension. zihpm is also part of the RVA22 profile, so add it to QEMU
to complement the future profile implementation.

Default it to 'true' for all existing CPUs since it was always present
in the code.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 3 +++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f478245254..c64cd726f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -84,6 +84,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -1185,6 +1186,7 @@ static void riscv_cpu_init(Object *obj)
      * users disable them.
      */
     RISCV_CPU(obj)->cfg.ext_zicntr = true;
+    RISCV_CPU(obj)->cfg.ext_zihpm = true;
 }
 
 typedef struct misa_ext_info {
@@ -1274,6 +1276,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
+    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
 
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 3c91b63609..173bd7d910 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -69,6 +69,7 @@ struct RISCVCPUConfig {
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
+    bool ext_zihpm;
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_svadu;
-- 
2.41.0


