Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C57825CFF
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:07:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtH9-0002U4-MA; Fri, 05 Jan 2024 18:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGy-0002Sg-6m
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:40 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGw-0002N5-HP
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:39 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so81096b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495996; x=1705100796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXjq2f7VCB4vEnFoEmasWDB5g+04bP15H3rD3ezuSJ0=;
 b=NShzgFaJbHpQ7/PVs14vc3gxVCceDaduCdr/fNND3/PMcZ6WAjl/7hK4VXkTGugwy5
 Mb81sSYX9yi5lJKj4OOZFd6S/Y2v316jjJLhEPHqhvKVtVn2Vv9papV6MOItDlt4NWKx
 gqeS17iK0pDzLtLOAxX0ImnnK4KNekJbsxD6zSpmabOQ7iXvZNKZ1IpowQNZ7SxYjF54
 +KyOUjXY/8yxFRvPpmOS3cooCvtDXUcx56TyIWniHN6UEgVaDYkyw9ciloNLcrSTOoLG
 qGP9GkSj80p5anHd/5acB6EPYOJ4XlrfO3IkPERc3BUM6E1FSx/KOO/2FHXzGqUEE11W
 zZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495996; x=1705100796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXjq2f7VCB4vEnFoEmasWDB5g+04bP15H3rD3ezuSJ0=;
 b=qKBQ2S/RasY8VtD50ZYm2WnqIsUpitA4efK/vs1fI+AHDfRGzZUQy8Rkdn8MBji5Tg
 1IwI3M9PSd62pYNUvzLJ3rQOlBoqBKrge4BRcP6zM4Ot5Q2Fds+vWGq6323/iltdo4/e
 cqmUBX+Qm070zgySB1V8NMM0LBBXI4vKeM136SbEzEN1bdRzKaaMNfxUcVKooGtlY5zw
 GSB502sL97BBwwuLyy4BNUPoaLFL92azopiWvN6dwKuv5IOYHsiTa1RzHD/V/Ae7VgGN
 XbetmuJVhFTVTh2nlPz1EFyM9zqOIvM0GZZ6DgFw693XAXoG2ovYsz3xGKi2g0YOgyt9
 iWUA==
X-Gm-Message-State: AOJu0YylNfkC2ItOkFAHHn+Pc6Kl/DYCmsvl5QmRtI0mujJbfNnVBvp/
 QonzSNNXOLdQLLfz/lAym53QHCbYZ73KUDm8UipC/ZgVgdC7Xg==
X-Google-Smtp-Source: AGHT+IEjs3bT/wLq9+LJr/nFDVQFjYmuTVZD1BL/0Vq114mlSgjk8NoyhnMQcf+eM9TG1ge9/wN8pg==
X-Received: by 2002:a05:6a00:39a6:b0:6d9:c7cf:c1a3 with SMTP id
 fi38-20020a056a0039a600b006d9c7cfc1a3mr85984pfb.18.1704495996479; 
 Fri, 05 Jan 2024 15:06:36 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:36 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 14/17] target/riscv: remove riscv_cpu_options[]
Date: Fri,  5 Jan 2024 20:05:43 -0300
Message-ID: <20240105230546.265053-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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

The array is empty and can be removed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 5 -----
 target/riscv/cpu.h         | 1 -
 target/riscv/kvm/kvm-cpu.c | 9 ---------
 target/riscv/tcg/tcg-cpu.c | 4 ----
 4 files changed, 19 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f84c3fc4a2..9d4243891c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1974,11 +1974,6 @@ static const PropertyInfo prop_cboz_blksize = {
     .set = prop_cboz_blksize_set,
 };
 
-Property riscv_cpu_options[] = {
-
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1c19fa84bb..c0336b8c0d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -791,7 +791,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
-extern Property riscv_cpu_options[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c9b4a6a7e8..8c81049169 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1446,19 +1446,10 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 static void kvm_cpu_instance_init(CPUState *cs)
 {
     Object *obj = OBJECT(RISCV_CPU(cs));
-    DeviceState *dev = DEVICE(obj);
 
     riscv_init_kvm_registers(obj);
 
     kvm_riscv_add_cpu_user_properties(obj);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if we have a specific KVM handler for the option */
-        if (object_property_find(obj, prop->name)) {
-            continue;
-        }
-        qdev_property_add_static(dev, prop);
-    }
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c7c2a28f10..27591ad2f2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1267,10 +1267,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
     riscv_cpu_add_profiles(obj);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(DEVICE(obj), prop);
-    }
 }
 
 /*
-- 
2.43.0


