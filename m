Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F219282DD8C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:25:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPmM-0005nK-01; Mon, 15 Jan 2024 11:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rPPmI-0005mJ-7M
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:25:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rPPmF-000513-6g
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:25:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e7a9c527dso8673125e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705335929; x=1705940729;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiPxYFkInWxtf4MkjHWSRFqjjhgLITYki68L5zfyr6Q=;
 b=XC8CKU5KVSr2UTsTOYGtDbcZoKpf2TzpZKOxj+TJ5vPI1b94Ym1fcad7iIJkFpRgAs
 fgubsglWmsK2chcFPkrSt2OUotSGLZfl9W+EG2RFIO8y2DDvVvZaix87E05/wj35801I
 gmHCdJCIcakObibENELYxvWg7nx+5Ab0Lwl4rJx3sps1GMKIDjTH90gS3miZrx7y58gR
 72jp5WYSme/gERS2yFeKZpv3hid4+X758l595y1YmpCc7EN1M1WKSYA3YAgkabOeUmJO
 Kfj7jWwN/xvVLV4FurLl2a35lJc4n82E3zSBNZw1mJmu5jJs+0CUMbp6Pa9DI/V2jtdC
 o/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705335929; x=1705940729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiPxYFkInWxtf4MkjHWSRFqjjhgLITYki68L5zfyr6Q=;
 b=JWXn0C9REKoZUljmzPcAJ3jSt4DpJePAOevWDSfUu+6y4/AY9LrzVJAZ8t0Z+cb+iX
 ZuY+9HkabHJSJicRH66Euy/bBw1ADDvE84Df9LXK8ljnw1Cc6HDzrG0YjjKRL1nGwlwP
 i4QE80TwVYuGgySho7LfLY0SMIGyEbWotcBGZ6UO6ScH9EsSIc91PwCxdDHdJxazkad9
 ejSzuzSNVe0LG1foOK0GtVe4iS7d/3JbfQW5ud/aF8gc8NUWg/4G8KTGtaiwnajTPJ2f
 Y5xpPj8S+1eqPoJNVnjjkFL3vmnXy9F0N34y8mcF6D0t6TrnRsP9IKtEGpnFSYA0Ec4E
 6OAA==
X-Gm-Message-State: AOJu0Yz34aG8lYmYtMKJLGU5FZk84LHBdTxYLP8W+4Obe2wGNV6nZR/Z
 qbUMKEm5lUTnWf8/tHvsdVCUvzy3fFqJ4cmpJYwihpWyT9R7qA==
X-Google-Smtp-Source: AGHT+IH4s4zTh1jpv4kWnAfDdd6b7c978O/MNUhzfbvKiec4xUw33RwqrI22cCz2nQCSUdlcvmc/DQ==
X-Received: by 2002:a05:600c:4708:b0:40e:3a6f:9b3e with SMTP id
 v8-20020a05600c470800b0040e3a6f9b3emr1674534wmo.6.1705335928740; 
 Mon, 15 Jan 2024 08:25:28 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c4f9000b0040d62f97e3csm20274444wmq.10.2024.01.15.08.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 08:25:28 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 1/2] target/riscv: Add Zaamo and Zalrsc extensions
Date: Mon, 15 Jan 2024 16:25:24 +0000
Message-ID: <20240115162525.63535-2-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115162525.63535-1-rbradford@rivosinc.com>
References: <20240115162525.63535-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x333.google.com
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

These extensions represent the atomic operations from A (Zaamo) and the
Load-Reserved/Store-Conditional operations from A (Zalrsc)

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
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


