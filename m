Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0EB7F66BC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:54:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EoH-0000Cb-9f; Thu, 23 Nov 2023 13:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EoB-0008Hz-Ie
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:15 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Eo8-0000Cg-Es
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cf80a7be0aso9452905ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765529; x=1701370329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgcpyo/lx9NHmm9iAX7ut4jSlldFzzfkoTFAHmC7vNw=;
 b=Swws0dvSPqCnf+uzNYP66BGsRFjgIaH3UCCh7ry+mdGdHa/Azo78i2j29p8IojYA9S
 itIahegj+fTRo6yt5l9QiOb/UBUo6YvSmcuM4pBw9FXSkEYqOTehH9jU2cFuaidAWuHr
 R8MmJls9XikW2rRW91PfUL7FvwyvT3Un+Ev9F8nAz+leoHP+oAH8GinS652RIstZZRdv
 s5MehFFEQ7C9aGJVfVLpBOfDH1oSpWf3DivDA2EsZI3LaOMqrUaJ7myuSfv5Llg/amzY
 keBfKE/1ijISDFOBBGTb9Ry7YQ1bEl2VCcXUE1QwKzL/1vpsunh7Agg3Ijx8a/+mez0z
 H6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765529; x=1701370329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgcpyo/lx9NHmm9iAX7ut4jSlldFzzfkoTFAHmC7vNw=;
 b=k8rA1xzvz++KQJ98gyh5JWQJbPbok5g3Q5WJe4HEXV9zTy7iWTJD0UH+IU9MlLTMgB
 DHZiAfgN8PgD5jZaFUEEWyRszzcz6DhgTvIkhFlvZK2sSwXqbQS5DL/jefw/tH0mGdVH
 ADACDM9rovvddZ6LoJo1tOPxc8fHQu8XQJnY9LN0T3YefeYfk5nd/adkuioq2R5ZcOid
 ao4MOg1Z3nX9xrRA8CMWhUAsmzhBYN0qtPB9/j/qi38bgmTuM9rhPn/O1VSmtn0BA8Q5
 ef9yOSmsc8tJqYjwcJe6Ox0o3ZZ+ycRJ+3uVSihySIYYi804KTBSql+7sh56p8SKZ5Rm
 PbNA==
X-Gm-Message-State: AOJu0Yy+YUuknmrlgrPqqNfkvKvDDL5et7M3//96CAp53oeZbdRrAcNa
 fchvApz3SEzM7ND9JrLBI0ucQrg+BspapNUwzhM=
X-Google-Smtp-Source: AGHT+IEFi6oDiKTF4SIEfRx5QoK93CU/xujfRE37LR6TuXOvf1rDTjeIV5oXGEydvCup7JRvfUWATw==
X-Received: by 2002:a17:902:ee52:b0:1ce:5853:1ff2 with SMTP id
 18-20020a170902ee5200b001ce58531ff2mr401943plo.11.1700765529028; 
 Thu, 23 Nov 2023 10:52:09 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:52:08 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 13/18] target/riscv/tcg: handle profile MISA bits
Date: Thu, 23 Nov 2023 15:51:17 -0300
Message-ID: <20231123185122.1100436-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 5f770243d0..092742c2b7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -946,6 +946,27 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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


