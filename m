Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BC7DD72F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvXB-0005PJ-Pt; Tue, 31 Oct 2023 16:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWr-0005Nu-3z
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:40:01 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWp-0007bS-Jt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:40:00 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a81ab75f21so60053807b3.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698784798; x=1699389598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/99uxbyCMoBY+04+yGnIdQYCUvDzLrvn+6ckz9H8Zvw=;
 b=SZcHgpE0oiYJhM1qzJmsGVPUP4ff45j4oZfbzGCblUvbsmSM6InNU5vIYXE5kmlEMa
 8OxDFdQMB9rlRFg3gGzaVe7fNrAK0ByVSTiY019X6tvIvZ+FPukNEsrKqzSHnL95D/+Z
 njDDziz+EMzh/keS8fpNyS/Wsn+in0XEqH14YqVK/F76iZB27/I3xN+US0JM5aeGzERP
 rJ+8KHs3aMsDnxvsz38Kq/bI2ixhlP0v3Qg9NUg6l661hivujCXwbbnGajbs62Gkcy4p
 KdEeU7jnWY5oB6MvDzsF3ARuaE07qZdveabJwyr1Jdmiqsqlca0TQT6Wxb2FkpuB5yXc
 MTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698784798; x=1699389598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/99uxbyCMoBY+04+yGnIdQYCUvDzLrvn+6ckz9H8Zvw=;
 b=Eqbdc8MFeisR+xAJp4S0DpLFFuWxdqW6iaLabQUYNGkeQgTE5FT9PMYAWGcK0Rt2NA
 59VnQwLaFE81RlJ5ewt+BE3/IptRDFU5BwgqDO7Zndyse76UjmSNyk734PYvAnujb6aq
 avjHlQWC3lFpA62Pz7qvGEaE1OC92WpOJQMrlQaRWIhYPSTIdfqgP4k7e+r2NxKCUROS
 +yxFsOvYEkNKD+fgy0TLbyG8JVPoSzu4JgGrYOxEBZ9uwcYeH0wLJwKrLzr4Qs+84MGs
 DO8cJE8lwjslDaVSCHmF7MtChbIu1L9los9MK8dCilokt9DDMhCpUE2iUFiILRPwu3fM
 AZoA==
X-Gm-Message-State: AOJu0YxRoozSTzeB7kp72s6AfaedkPaw8JGE3uDolobPTnFrwBcKSloC
 KQmqWYjFEVTQj4pCMkLgL3jNZw/ReTEPPSYwMwg=
X-Google-Smtp-Source: AGHT+IG5eqSyhfS6qb/jxLtxH1DUwz0ApQtnWsg7ARWfFKisx7wfDMHbBO5CTw1Nvxzl4IbSMzT6bA==
X-Received: by 2002:a81:ac46:0:b0:5a7:c8a9:79e8 with SMTP id
 z6-20020a81ac46000000b005a7c8a979e8mr13521313ywj.4.1698784798234; 
 Tue, 31 Oct 2023 13:39:58 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 k1-20020a81ff01000000b005add997ae53sm1272802ywn.81.2023.10.31.13.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:39:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 12/16] target/riscv/tcg: handle profile MISA bits
Date: Tue, 31 Oct 2023 17:39:12 -0300
Message-ID: <20231031203916.197332-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031203916.197332-1-dbarboza@ventanamicro.com>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112e.google.com
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

The profile support is handling multi-letter extensions only. Let's add
support for MISA bits as well.

We'll go through every known MISA bit. If the profile doesn't declare
the bit as mandatory, ignore it. Otherwise, set the bit in env->misa_ext
and env->misa_ext_mask.

Now that we're setting profile MISA bits, one can use the rv64i CPU to boot
Linux using the following options:

-cpu rv64i,rva22u64=true,s=true,zifencei=true

In the near future, when rva22s64 (where both 's' and 'zifencei' are
mandatory) support is added, rv64i will be able to boot Linux loading
rva22s64 and no additional flags.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b62890e568..4a915acff4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -829,6 +829,27 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if  (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        if (bit == RVI && !profile->enabled) {
+            /*
+             * Disabling profiles will not disable the base
+             * ISA RV64I.
+             */
+            continue;
+        }
+
+        g_hash_table_insert(misa_ext_user_opts,
+                            GUINT_TO_POINTER(bit),
+                            (gpointer)value);
+        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
+    }
+
     for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
         ext_offset = profile->ext_offsets[i];
 
-- 
2.41.0


