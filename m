Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF695B055
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 10:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38I-0005FO-Il; Thu, 22 Aug 2024 04:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38B-00052S-RS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh383-0005vh-9c
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-202376301e6so3957505ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315108; x=1724919908;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=HvCzTul3MHUDTw/DP0P3N1yaceXt8osZ1B5gzx5Qpk4cASS0/B9FgAxrTb23L/ayuE
 +ixmMtfnNEJvpzokenD+DYE/ebyrqnCDmZg05otqgLirDNs6G/4D0v/2bbjK/aIw50/X
 ABdRfIxxwWbD6QQp9+I5QRfYwK+mE852pjFaxG7LR5XwUnUCb2lBqJMODtyMOskxGpOZ
 n77Dd5RpYX7SrdYWVowp/lCmx6sB7ip3NFlB1zlJ/2Wh9SRqAWOv2WzdrXYWz7nwFQU0
 9vgDlgIYfUneIxpyiBZvc3WIZDX1LSjmgiIP8A7hOeovHufV1RaZ+4T/6qhnvugtsqVU
 AlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315108; x=1724919908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=iRNMvxq8JGZVRyohNa+w7niIA7pfTx7zgkt5QjzUJzPlTZrWRZA1X6zdx1BfnIQ2cm
 CPtHeodg0oMY2f9C+rnkAtIY98h2uB632rNpUdmTV2jaqqir9j/XEqsf7nfnz+lSB5ei
 sGbdTW93+kNocpqflFoqt8AV3mFabbYKOh2Jsr2xo0iaYHfkUwpZz5zndWK6YVp/RqtD
 2d8032qdl981gyrhd2mDNKpiOiyazGe6EhVD84b+98j797SYf8WZlVk0jvqBh4MU/jbc
 rev4rT9PmvoIUnrjapRRiR9Nr3+MxGBcKHkocEWm44Iy3FFxhrby/+jsdrbsyjuoyvQI
 gonw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkQZ5ggNOKWyJrIju5Nh6odMe1Gv96bjFfKNC9TLJ9IJ+CKr0Bu1eAwSn+4b/dEdu1aZpqLLh+dXX1@nongnu.org
X-Gm-Message-State: AOJu0YxUd3oW5IhmY+hnwc1fOR4ePiQyI+b7gs38tCM7ZwnkxX8jCA6O
 JznJrkpTFOt9W3xNmBmQ36seX5tGyUMKKZ161BrO8aXA51qjrJuBnY26S9b7FbU=
X-Google-Smtp-Source: AGHT+IFiGTPR8bxSXrGGJ4EVfuSglcYCNVHCeJpNxMjqna//l1sSHytzyqKbfuTvwSyX8lXJyVQUCg==
X-Received: by 2002:a17:902:d502:b0:1fa:fc74:4c04 with SMTP id
 d9443c01a7336-20388250196mr14510885ad.35.1724315108232; 
 Thu, 22 Aug 2024 01:25:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 01/17] target/riscv: Add zicfilp extension
Date: Thu, 22 Aug 2024 01:24:47 -0700
Message-ID: <20240822082504.3979610-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..5dfb3f39ab 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -1472,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 120905a254..88d5defbb5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..ed19586c9d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.44.0


