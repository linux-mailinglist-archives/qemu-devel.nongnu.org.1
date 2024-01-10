Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5B82958F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURr-0006tZ-Sy; Wed, 10 Jan 2024 04:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURI-0005Vq-J5
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:59 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURG-0004Sa-7C
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:55 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so2467237b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877191; x=1705481991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSoRvl4XGNPKXBSy4UlQSsI1DM3kmfBRZBEFpQkHixs=;
 b=HJxWX/8wZciXhcTLnyh3eoPRCbC73WDB3oNUtgsVfkToEHIc49SC0JPEQzYno1ZCZj
 ay1gFqxoLMbMUKrCHVRytMRS9CH5YsI9GPBdywXuz57iROOZyHQCftFSESLMZxJNoTjY
 nvGmcKBRZoOXxf2vHviqEmObocJedlMrXKMKFFlYW6Np3xUyoxgftA6qIZdz/21jc5J+
 rw+gwimngWdONq5cFuefxZ+pWJoQ9T3nZpM/xplU/rsAa8oum4MB7P8R3y5yXI5m1nqJ
 8nJsNNFD0laCTnVBU31CCHMIyCWXpfMydD5ogFsMeKBa2CFIg+zn0JdTuvdM7bSMA8ke
 9HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877191; x=1705481991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSoRvl4XGNPKXBSy4UlQSsI1DM3kmfBRZBEFpQkHixs=;
 b=anpNdd9PfIzXFNfVYXEgWU/DGl6q2XycDxsAT2HjdW7aB5353br6Ae/LUITXr8sg3r
 tejjRxIC94LX7Jc198t/hrUES1oAQT6h95hg3rkJ0TVclUHEWqWqhH+tNmHysBAZGzSX
 WIXUcghRDX8Dyzo/6EvzoBubGQaiYWSBWs8J3Jjd4+gJqygCO9ks1pduV0zvtdI4+QaN
 yHmIJR5K1ELgGc8zPaRGLow7JvW1CPxT2cy4mjwIaptVqk4HEqRi6xa/Ax4VL8ugqQeh
 dwiyg2oiArjLuFw/c0srdIehzTHLXR5WzKFJbGdCnd46Z9SdCUImc6edUXDuLNy76o8N
 Rb5w==
X-Gm-Message-State: AOJu0YybDSJMjnxEgBxAhSJND6MvVrZuPVYtI5xij3CF0O43YwT4mugl
 0eR5DZxbonGWfG81wDYsYm55Jzx31gvjbxXT
X-Google-Smtp-Source: AGHT+IEZ5ZcV6331AdvQrTFUoMS68gtDZuttvSHdy5+1adZHcHtzo2vU4thyyB5c4RQN/Gz0yS43ZA==
X-Received: by 2002:a05:6a00:278d:b0:6d9:bbc9:98d9 with SMTP id
 bd13-20020a056a00278d00b006d9bbc998d9mr766215pfb.8.1704877190694; 
 Wed, 10 Jan 2024 00:59:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:50 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/65] target/riscv: add zicbop extension flag
Date: Wed, 10 Jan 2024 18:57:01 +1000
Message-ID: <20240110085733.1607526-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

QEMU already implements zicbom (Cache Block Management Operations) and
zicboz (Cache Block Zero Operations). Commit 59cb29d6a5 ("target/riscv:
add Zicbop cbo.prefetch{i, r, m} placeholder") added placeholders for
what would be the instructions for zicbop (Cache Block Prefetch
Operations), which are now no-ops.

The RVA22U64 profile mandates zicbop, which means that applications that
run with this profile might expect zicbop to be present in the riscv,isa
DT and might behave badly if it's absent.

Adding zicbop as an extension will make our future RVA22U64
implementation more in line with what userspace expects and, if/when
cache block prefetch operations became relevant to QEMU, we already have
the extension flag to turn then on/off as needed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 hw/riscv/virt.c        | 5 +++++
 target/riscv/cpu.c     | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d516de4a44..2da8ac9582 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -65,6 +65,7 @@ struct RISCVCPUConfig {
     bool ext_zicntr;
     bool ext_zicsr;
     bool ext_zicbom;
+    bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicond;
     bool ext_zihintntl;
@@ -143,6 +144,7 @@ struct RISCVCPUConfig {
     uint16_t vlen;
     uint16_t elen;
     uint16_t cbom_blocksize;
+    uint16_t cbop_blocksize;
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4194ddcef1..f9fd1341fc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -250,6 +250,11 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
                                   cpu_ptr->cfg.cboz_blocksize);
         }
 
+        if (cpu_ptr->cfg.ext_zicbop) {
+            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
+                                  cpu_ptr->cfg.cbop_blocksize);
+        }
+
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
         qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33d25d12a6..ce0a3ded04 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -78,6 +78,7 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
  */
 const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
+    ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
@@ -1375,6 +1376,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
 
     MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
+    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
     MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
 
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
@@ -1509,6 +1511,7 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
+    DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


