Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460D7BB903
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokmV-00065n-31; Fri, 06 Oct 2023 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmR-00062x-2R
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmO-0003EZ-Qt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2776d882214so1579791a91.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696598527; x=1697203327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y/dBuqHy/oa9m7Jxo7pCMhDxA4Tb2pKxeV4ExkQA0w=;
 b=ZCremqsY0yZ8SI8uLsoYNadJy2yj1rVByZcnAXaYaFD+s8eNZrMWzkSaSN1jZZlyhk
 EvTJoJkDBzQFPfgA+GhCtmSs+bxI2vxWRyOMPwUY2O0ucB1FmVn7bnfGE78lw7OgwSV0
 2kbb3a0pRYd+PJrC2rGUxHCG/RjOrmjXxSAsUHWCJKTT810cL8ELLTMqnOETqcn18fcV
 L0ba9Dk+oHzC/8XpyAM51Qvf2u2QlPJYCW8elM9dOWLAZp4yMgc4FATbUHajOAm7JVXV
 vz2GOZeX6EfbjGCy7NMmiQlt97XCAHdd4ac3MGCligmJ+gRqC3TYlSBY8DXqeM2vSuEL
 lpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696598527; x=1697203327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y/dBuqHy/oa9m7Jxo7pCMhDxA4Tb2pKxeV4ExkQA0w=;
 b=gc2p4i7dlW2XSzqyNchglY9oHwWOzX3ccJTw61TVZhlo8yN1QKDm1A9w1iUrXmNn8G
 /niXgE5MbaJxIgeiS3SmzvDNbJEmEJpDxZmihnJpKdnPlVlTEWVSqwCxuUFcnQujLth2
 iWIRFCZd1Gt9MWTTV0A+of2iW9L3gwUWWro/HbtPNDMyJUhnm2dJtIkglaZl0l2dfTUI
 rbKGYe198D3MiRZliVRMO7Y+bvNC4uSaJlfSZ4kol7vM/7ap/Ws01KEnwgyLIttCPMI/
 01wfDFFEHQqMoJF22HCbW21tItGrUhJyECfGesuTMbiUiWS6GmCihkPIE/0oL0ACSSKF
 VMNw==
X-Gm-Message-State: AOJu0YzEH0ELGVCQTw4YyRTOh10qYyTyCQqZ2H4zpm001T5vWWQilcl8
 tBxWEJ9rJ//1VGMRuhS3J4wrePbu+kAKqDq7H5o=
X-Google-Smtp-Source: AGHT+IGG0G9JtxcE00GjjE2AGRUcbI1bITetQwY3cCO5XFIvmwSFx/6kb5TYjknEcO4xTRUp5Ndidg==
X-Received: by 2002:a17:90b:3907:b0:273:e255:2235 with SMTP id
 ob7-20020a17090b390700b00273e2552235mr6762083pjb.49.1696598527051; 
 Fri, 06 Oct 2023 06:22:07 -0700 (PDT)
Received: from grind.. ([177.94.42.196]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c1cc00b001c60a548331sm3796669plc.304.2023.10.06.06.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 06:22:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/10] target/riscv/tcg: handle MISA bits on profile commit
Date: Fri,  6 Oct 2023 10:21:33 -0300
Message-ID: <20231006132134.1135297-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
References: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The profile support is handling multi-letter extensions only. Let's add
support for MISA bits as well.

We'll go through every known MISA bit. If the user set the bit, doesn't
matter if to 'true' or 'false', ignore it. If the profile doesn't
declare the bit as mandatory, ignore it. Otherwise, set or clear the bit
in env->misa_ext and env->misa_ext_mask depending on whether the profile
was set to 'true' or 'false'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b1e778913c..d7540274f4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,12 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static bool cpu_misa_ext_is_user_set(uint32_t misa_bit)
+{
+    return g_hash_table_contains(misa_ext_user_opts,
+                                 GUINT_TO_POINTER(misa_bit));
+}
+
 static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
                                      bool enabled)
 {
@@ -283,6 +289,20 @@ static void riscv_cpu_commit_profile(RISCVCPU *cpu, RISCVCPUProfile *profile)
 {
     int i;
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if (cpu_misa_ext_is_user_set(bit) || !(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        g_hash_table_insert(misa_ext_user_opts,
+                            GUINT_TO_POINTER(bit),
+                            (gpointer)profile->enabled);
+
+        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
+    }
+
     for (i = 0;; i++) {
         int ext_offset = profile->ext_offsets[i];
 
-- 
2.41.0


