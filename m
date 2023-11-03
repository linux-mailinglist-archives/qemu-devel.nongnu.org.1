Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1B7E0402
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:52:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuW4-00029H-56; Fri, 03 Nov 2023 09:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuW1-000281-9l
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:13 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVz-0000xm-Nv
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:13 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ac376d311aso24646417b3.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699019230; x=1699624030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C6CHYh24kH7MoMh0oWp4kFRb4ZW2UxlCtbQUQeF5xE=;
 b=Tleikze2V9FMhfENuZsApPf2PKA7Oq0hZiAY+qbEtoe2vZ01e2WVeaqdymwMdnDPHS
 D/Hbi85LujzqSccY9gbqTjX8B5XKDgkxoCmxoEcDn9l6GKcWnYNRO6j4mV9K8E3HDImA
 bOvP78/m4OIT7tHLlhNpjxqg5VbD6qVwK6+pvXf7zbiLwejWlHzXR1aGad5fHLYJGulR
 0aKxpHLYOmjXw1HRWjVp3eCH4uCRjCbbZ0NhDaBrzEExTm9ATzXsqosiwM4rzTLgv03T
 cGRYb/1bOgsjcR5u0eiIm2PTByU0po5OtL0Npi0DuWL3H9OHOeREy+4+FTliMZOj1dMe
 XtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699019230; x=1699624030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+C6CHYh24kH7MoMh0oWp4kFRb4ZW2UxlCtbQUQeF5xE=;
 b=Pd1nYW1fFMxX4TVjug9i84cbufUrFvg4uLom509UdZqVeE7/Tr6yFW2spRhQFbkLDF
 MPAuJLe+1erk3KtPnioSniF59vOt7hZABbPhN5cYWq+XNAK5cUDDfPDp3Th0l4Rac6ja
 /E7y5Ct5+K299NU4CMU1JeDDfU50oRzfcbxZ/rljUYp/beSDu9Gyfr27fV2IU/Ph2sOO
 kjpJj9TPOulS6jskhB/0C9OoKHo7kUEdsTU8Z4t9ctCdycU+JA/zustB/VENs/BaVXID
 Y9R+YMpLRrg9Me4qaKCqfNESBHJf6QEI5rck2GXWsK/TPukHUxXneOG1s/BX2eZ61JHl
 NcPw==
X-Gm-Message-State: AOJu0Yym2OOu54dWIQghjxjC73ByPAa4uN9NPHDxVSAIAhIBzyAazz0C
 dryeIyPR7ou9C9t13DrmSAB7wm7d00QzaYSI62Q=
X-Google-Smtp-Source: AGHT+IGVL5rTqrwLBiLYJuhG95EYpQ2yFdWxT+NqZyl7J/LjTD1hdKGvAFAvGs5hCJvRR1nOFcD4NQ==
X-Received: by 2002:a81:6043:0:b0:598:5bb5:1801 with SMTP id
 u64-20020a816043000000b005985bb51801mr2352945ywb.50.1699019230449; 
 Fri, 03 Nov 2023 06:47:10 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 j68-20020a0df947000000b00582b239674esm935814ywf.129.2023.11.03.06.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:47:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 13/18] target/riscv/tcg: handle profile MISA bits
Date: Fri,  3 Nov 2023 10:46:24 -0300
Message-ID: <20231103134629.561732-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103134629.561732-1-dbarboza@ventanamicro.com>
References: <20231103134629.561732-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1134.google.com
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

-cpu rv64i,rva22u64=true,rv39=true,s=true,zifencei=true

In the near future, when rva22s64 (where, 's', 'zifencei' and sv39 are
mandatory), is implemented, rv64i will be able to boot Linux loading
rva22s64 and no additional flags.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 87e39f7d19..7ecd95c2e1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -918,6 +918,27 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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


