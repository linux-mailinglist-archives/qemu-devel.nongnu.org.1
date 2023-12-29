Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F581FC3E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ12L-0003RF-VG; Thu, 28 Dec 2023 19:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12K-0003QJ-4m
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:40 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12I-0002yO-HF
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:39 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35fea35c432so42915515ab.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810856; x=1704415656;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AVDVq7i2S5ZvAV5+/0uStEZfRYh+joB7RC2I6xYSmWs=;
 b=QcpNufAuIrTEy/yRRaoPJGXDJ4dhh20fycy/yRzr22MLmwkWluF59ExSJII7uqjN0q
 AN6kaX4zC6/B0AzJ1DCpCw6dK4yxo22wNOj3hp2eVwdI5dukijL4JKEOZWjrKINa96Gy
 2qg88koytJGbMfj+XkpjTAeR4WUsWgnMTNkevJ/SZCy/FvPZo06yjFwwQvKMRR7vZENp
 uzfW4bIn/WAkeG89SyQ9Zfib1TqaFyL3lxVwKCd7LJHAPJCB6Yndrn1ZnJheisZ/so+Z
 OrAa//sS8RZygWXIJ6CR9poeS25UP4iWUsN0zt4fbiPPb58Ypr8xXfp2BuYgj7EgfXXF
 AnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810856; x=1704415656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVDVq7i2S5ZvAV5+/0uStEZfRYh+joB7RC2I6xYSmWs=;
 b=J6avN4yr/vryeXsdyLmGAt2PPVJJyl1V+4lzFSD26T0kyBxHet3/TZqdw8AbBvrE+5
 2COi4HMYO0l/89jzIxAi5BF1osx/L5xH3ImxEWe7in3p9AdXJ4EESAoKmPinZqqxiEiD
 jvpOV2oXdggs02QtKf5hwa5J0FZ5gBRalh2n19J+zjeEfkONjrrmUfRNeV6BWN6XYPsc
 KSPpskmsvWXACsaHWv552uGpcWn2Ox7fwpom/F3lDdlkV30cuE92WjfOwuAAyqQl1PhI
 ORfl9CajPbC5O/cgiX9IINNdh3zKxd4EWcQZz3ihhXXf0pK7vFCwEtS3S5S9Zaox1jkq
 b6CQ==
X-Gm-Message-State: AOJu0Yz5d6p0FMtRicjMNWBknRykDdi3E9XIyxyErkhY9zUQVtKjjlCC
 Y+qZg/ng8/hRRl6QiuVWVNnL7cALMOk9g/r9DUpGUqUji1s=
X-Google-Smtp-Source: AGHT+IHkqRzxPcpDiIOyVvaL60M736+G9vz4QgXSMqEif8MZY5enJ1aRoQrhSp+QW0ZcgOWlYUvZQQ==
X-Received: by 2002:a05:6e02:18ca:b0:35f:f819:b2a7 with SMTP id
 s10-20020a056e0218ca00b0035ff819b2a7mr13686302ilu.115.1703810856095; 
 Thu, 28 Dec 2023 16:47:36 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ee0300b001d3561680aasm14393949plb.82.2023.12.28.16.47.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:47:35 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Subject: [v2 2/5] target/riscv: Add cycle & instret privilege mode filtering
 properties
Date: Thu, 28 Dec 2023 16:47:28 -0800
Message-Id: <20231229004731.3841550-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229004731.3841550-1-atishp@rivosinc.com>
References: <20231229004731.3841550-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=atishp@rivosinc.com; helo=mail-il1-x130.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for ISA extension smcntrpmf. Patches
implementing it will follow.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 3 ++-
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 83c7c0cf07be..da3f05cd5373 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -148,6 +148,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1296,6 +1297,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    DEFINE_PROP_BOOL("smcntrpmf", RISCVCPU, cfg.ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
@@ -1308,7 +1310,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
-
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190b9..00c34fdd3209 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -72,6 +72,7 @@ struct RISCVCPUConfig {
     bool ext_zihpm;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcntrpmf;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.34.1


