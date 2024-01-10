Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437D8295C5
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSc-0002lh-27; Wed, 10 Jan 2024 04:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUST-0002eu-Vn
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:10 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSS-0005LT-1h
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:09 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so3292183a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877266; x=1705482066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2uXWynn6N0F+UvNP0b2mp7dSx1OcBiLsy3KzCT7kHQ=;
 b=hUFce5BgZ8ceTUilPUiFgcqdMBKUYw5ehSO3RqV+rgZooPBcVxIzEIaPibBX7Wv71i
 1sUWWujhGljzWMKtjHyMk57JsQTygNoB3BYtVbFLRWAaJBNXm9FZiT1sPHLhWcjz9a9x
 sG9RIcrMH4hkFgL4/sNnxlLeRaS7bH6OI0AyyB2lpQtYnlbrq95BqcjXj5ZdaFL+jXAl
 J7mdJM4EgORuGQW9XIYLaLaFWCOVECKMei6n3ltkxcrBOmzWNtg+KEpkRzWA2vIou8iP
 LECcw6btsLzPbqngViT0bP4cK9RiaPR6yzgoG0x1TabCodD5khlXP3LgPK1nyxvU9o9c
 aghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877266; x=1705482066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2uXWynn6N0F+UvNP0b2mp7dSx1OcBiLsy3KzCT7kHQ=;
 b=Yk3gYYAzdDj6hykm9JBBHnTP6bRKQJan/lCNbgn1ebM0zzDC+c35fwZfjWqOV4kq9U
 RnhdUVcrdE3ANlP0kXfEt5qEs2ppMSWCsVyurvCAfeAiVLSbriiD7+9MkOuNjTsLzSor
 bGFJTWoAGzlVOybQ15QDlwHGJ4EFFqbBUyUUWZrrf2E0NN6w82etzGj+5eUx6+AyCnSj
 tpwCOK9mJ7rR+C8S5UUKcCVnI1I94mf4wtLuKS2TwvfLW4s0NIaoUDkiDo6igD/TaQnZ
 ZkEwVhXm2p+1SnHyNl+vxO3DzmjYQCal4k/K6R6jiiO8+g9kzCsMIJevpXiqkptPj768
 V9bQ==
X-Gm-Message-State: AOJu0YwCf9XY/B8a3hE2wvbwax/1V7CLREgvzz6fVYQojXgZnDlx2rfb
 YCTtsTTNdVkK0sMYZxbEd53khU8voySEfhUF
X-Google-Smtp-Source: AGHT+IFUTFqvuUjwVkw+li79WZzZhZSRIUAgyQqMUIHG3SxtJ0afgkL9U67wdHgUXIXKvNYYBAtD8A==
X-Received: by 2002:a05:6a21:3d84:b0:197:6bec:42aa with SMTP id
 bj4-20020a056a213d8400b001976bec42aamr1003534pzc.12.1704877266374; 
 Wed, 10 Jan 2024 01:01:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/65] target/riscv: add RVA22S64 profile
Date: Wed, 10 Jan 2024 18:57:21 +1000
Message-ID: <20240110085733.1607526-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-26-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 616b091303..a8f4081922 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1559,8 +1559,40 @@ static RISCVCPUProfile RVA22U64 = {
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
+    .parent = &RVA22U64,
+    .name = "rva22s64",
+    .misa_ext = RVS,
+    .priv_spec = PRIV_VERSION_1_12_0,
+    .satp_mode = VM_1_10_SV39,
+    .ext_offsets = {
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
2.43.0


