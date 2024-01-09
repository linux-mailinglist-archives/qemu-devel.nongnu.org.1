Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04084827BFE
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:28:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzxJ-0001Td-C8; Mon, 08 Jan 2024 19:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxH-0001Su-47
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:55 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxE-0001aT-Er
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:54 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-204f50f305cso1827896fac.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704760009; x=1705364809;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMnZ0K3fI2+fY94GIWe8LOsWCKtmeJVuoaCcNcFECq0=;
 b=Q8cECWHah1eFErbOqMH2Dmss4vDIPnSrGDyHgW+rUpj+Rh/M/GWWerbPds4RgfbIrY
 gfaszcFIhi/hhfWDiHw+sNiueqA2ofq/zs+bJwWj92efQMaGn8A4JnQ4dDnqAZTxw2Bw
 MDCJSCPMaAeBB3aAG43FezHiH38ViE0MBFXb9SCZmIDBu0+YmBl9HfFdNholw+R8C6UJ
 Iw3yzIEa4thsT/gOyWexpaA1K0xtD7GZKOvxo50OEjMF8ewdKkdz9WLgm0zawwu/5VWN
 +nRuO57tBdza5y/Juy7rKjlIU0QNHSvgDndM8elkVI87SCOHcQA+gR7Wc4ITNh57C2fY
 Ae+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704760009; x=1705364809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMnZ0K3fI2+fY94GIWe8LOsWCKtmeJVuoaCcNcFECq0=;
 b=lZmhxNhy/asG4anav8KUpWoemCBV7ntOYLStGS7ch+efFyE6QrA7neh8N3sNIjfKvV
 7bl/ub55le8tkMYILxV851kS5SNztFJw+nTrLl7d67kKGnnLLWv+NdqKY2Labbw6idf2
 3TV6X1UG7tbt4nEhUY3wgU3xM0JnNLaKiIb93A86Md+uGb8UAC/N3cHgEIU9DgOXXHPP
 M7FA6B21iLd+28bTS+h3gMKSa6Dw3SLb+NoimkY+p1ve8d6hiyx4kFORSBeCkqCX/Mgo
 8s7GuxIXnEKvbeWa5eMgmO1HEPe64FHKyelkt0+GqIV22W6aW0b8zW3K6Dehou4WNn3l
 SB8g==
X-Gm-Message-State: AOJu0YzxCkobsHpfD+RtTF2n8++DlWFBiDGanJwS92n8T2QnRZ+LzeTs
 b7wCQsT6eGvR89eAz7xg/D72A4eeJ2Irxg==
X-Google-Smtp-Source: AGHT+IFJDrQC3VVDRNy8V+Tq5gxeqAOO1bb0PVD2Hq7x5+Gmo7FcZK9nlwls6fdZwC7OopBHNq28qg==
X-Received: by 2002:a05:6870:a79f:b0:204:76d:dbe1 with SMTP id
 x31-20020a056870a79f00b00204076ddbe1mr5329798oao.61.1704760009192; 
 Mon, 08 Jan 2024 16:26:49 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 wp12-20020a056871a9cc00b002042cafdc52sm219917oab.2.2024.01.08.16.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 16:26:48 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v4 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
Date: Mon,  8 Jan 2024 16:25:51 -0800
Message-Id: <20240109002554.646572-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109002554.646572-1-atishp@rivosinc.com>
References: <20240109002554.646572-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=atishp@rivosinc.com; helo=mail-oa1-x2b.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for ISA extension smcntrpmf. Patches
implementing it will follow.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 83c7c0cf07be..501ae560ec29 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -144,6 +144,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
@@ -1296,6 +1297,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
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


