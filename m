Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0CB7F6700
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6FBE-0000FA-7n; Thu, 23 Nov 2023 14:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FBA-0000Dn-HW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:16:00 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FB8-0003ok-Rt
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:16:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cf59c07faeso8925065ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700766957; x=1701371757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xYT9VwJycNlV2FpNWHCSbU8jav1y7pot436k+JUSRk=;
 b=np+6LZ8SSPY+2vspv6DHTV08mebhO5lGyIahCsFqWmnJd+Vl0CxYVe3yjxZFSo2T1Q
 IBDr1A36Q+C3bBpinJgGOMr2EXGjY7kbhF6pfYNBfdLBpWjq3aIMPX8Ctv49/8SXqEoM
 gwUi6kRcdm4WSPQrRB60FnbyHhhm40w2fQTZBDhmiDjuAH6cF6nb9vrK7RMt4TaKL4jJ
 +cbfN8OoVoWs3PRzTsIfKqTaCgmLBIpR3DXD1qoaIuvI9Y8JUOK6QsOZttUtYJgl792/
 WaCJXR13DECd1fMyFk3fYQyXANjCsb/aFIZq9mlnLmZcE8VlWy5/UPZdCoxJqmpqF7Ik
 Rzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700766957; x=1701371757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xYT9VwJycNlV2FpNWHCSbU8jav1y7pot436k+JUSRk=;
 b=HOhrOQYdI4KVmdNs6pcE79gt6WDvqG4oLSb9h0rvkO/yY+QdOiu7mgrgw7/wQ6dwFY
 G04OUu0aKpss5UwDpCnf8s4TqE9hCeHFlPI19JwXQ0TXm3yPuNTBEZY+dT+7FvQ9QKqc
 ZhxinPP7uIl0S7/rF66ml1RH1smTgOZIKRDpPIonqZOoWc8c/xbhfUSqG9K/hIGlN+cD
 oYRv6mR+W0ZkDknKaouetGitvlOiwW+ObhXB2g8YhkVewIxlr2VHEq4mkWl2wKXkotpU
 Ya/ZRMYoEpdfl4C1zm8IGPre9ldTuvhMNa6IaVRdauy5FZKAyPAKNoH+Vi5ozBf7NS1G
 ZX1Q==
X-Gm-Message-State: AOJu0YwXozGu1xpBpo1Q0vwkHowAWoX6Kc0iN3m56HpmnL4AtxZsER8K
 0zcIpwpfeo/MQiJeznmcUzY/jF+memBiz/IVdp0=
X-Google-Smtp-Source: AGHT+IE3FOQblzcwAojZ+32l3sLjWATWAuf1oqViTOUCPAAHEuvT22HPJNA0ZvGrd8fIq4+AnEV6+g==
X-Received: by 2002:a17:902:b487:b0:1cf:8ebd:4eaa with SMTP id
 y7-20020a170902b48700b001cf8ebd4eaamr338689plr.68.1700766957183; 
 Thu, 23 Nov 2023 11:15:57 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902eed500b001bc21222e34sm1680760plb.285.2023.11.23.11.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:15:56 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 6/7] target/riscv: add RVA22S64 profile
Date: Thu, 23 Nov 2023 16:15:31 -0300
Message-ID: <20231123191532.1101644-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The RVA22S64 profile consists of the following:

- all mandatory extensions of RVA22U64;
- priv spec v1.12.0;
- satp mode sv39;
- Ssccptr, a cache related named feature that we're assuming always
  enable since we don't implement a cache;
- Other named features already implemented: Sstvecd, Sstvala,
  Sscounterenw;
- the new Svade named feature that was recently added.

Most of the work is already done, so this patch is enough to implement
the profile.

After this patch, the 'rva22s64' user flag alone can be used with the
rva64i CPU to boot Linux:

-cpu rv64i,rva22s64=true

This is the /proc/cpuinfo with this profile enabled:

 # cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdc_zicbom_zicbop_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zfhmin_zca_zcd_zba_zbb_zbs_zkt_svinval_svpbmt
mmu		: sv39

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a77118549b..d00548d164 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1559,8 +1559,48 @@ static RISCVCPUProfile RVA22U64 = {
     }
 };
 
+/*
+ * As with RVA22U64, RVA22S64 also defines 'named features'.
+ *
+ * Cache related features that we consider enabled since we don't
+ * implement cache: Ssccptr
+ *
+ * Other named features that we already implement: Sstvecd, Sstvala,
+ * Sscounterenw
+ *
+ * Named features that we need to enable: svade
+ *
+ * The remaining features/extensions comes from RVA22U64.
+ */
+static RISCVCPUProfile RVA22S64 = {
+    .name = "rva22s64",
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU | RVS,
+    .priv_spec = PRIV_VERSION_1_12_0,
+    .satp_mode = VM_1_10_SV39,
+    .ext_offsets = {
+        /* rva22u64 exts and features */
+        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
+        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
+        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
+        CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(zic64b),
+
+        /* rva22s64 exts */
+        CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
+        CPU_CFG_OFFSET(ext_svinval),
+
+        /* rva22s64 named features */
+        CPU_CFG_OFFSET(svade),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
+    &RVA22S64,
     NULL,
 };
 
-- 
2.41.0


