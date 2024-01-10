Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F98295AC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSz-00038m-8H; Wed, 10 Jan 2024 04:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSY-0002w8-8B
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:14 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSW-0005Or-DC
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:13 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9b5c4f332so2083716b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877270; x=1705482070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98U4oU6QyYIjFXPReF2BbuPWqRX5URTGZmXI6rweO/Y=;
 b=QF6Z+VlQPdIkTafggLJpn4sd7CwCuXWSHEVKlzapEVNJkMz4glAdafIbegiDHbEwxr
 tUBlabbXcrIyNV6oQX3MHrfkZeSpEvU0IKdcLRKpnVpBEmEgg6jxa2O6TnNK9ieGIhQt
 oMGT0zgZW5WPScpEl/Am4N4nWnMNOfoSkkjoqtQEzIUmRA9oA2bQj3ee5/pJ/iNNivF8
 m+ySgFw+RdFDj2Sy1zJCyg4nBrIUZGM/n88/BAQacGLVrciT6F9pgSQKd7odvntEvG9e
 Wm1aDcFNSv4Zdc5E7iuuXzsRv5ylsPlVw6J8pSrZJOD1WHg7PbKHJ64p6+t6shKUBSPJ
 9O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877270; x=1705482070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98U4oU6QyYIjFXPReF2BbuPWqRX5URTGZmXI6rweO/Y=;
 b=Y4H/q4Jk0RfuZKFbvqEtwLM7dETF7NMLr5fQgqLHcldVQwrjNsWbT+tmsiggpbX9lg
 cg3MIhnwfnQ/YvYHT14Bd+bS9YNL+VPYW9j5nb2UrZVL15nN1GUT220CKPK9bfvd5Eb9
 OGasu/bV1uRV6ZKP79rJERS8Fk6fDtEUXBTPJ/rPyS2+N+PN8IVAzykz0zccDhe03xDQ
 H19vqtqD5ao1HlHYNG+lPOxEFNARK++OH1RnhJLfKjr/1ABjD/W42om5S0A68dR8HWwP
 HeAVZReEzEjxkHmhLa+QTnM62M1z3UhpJCNweLXXuT/C3CU0D4FlYjvkhkEjm4Hq6ZLN
 mj8Q==
X-Gm-Message-State: AOJu0Yxjs97yQGfmLiUT8YcczWYJ09kwhx6aVlQIqluLBeP3ZR9JEWu+
 Wm993Mm/+8uVSlsTjBek7lxSCxpk3FGF5IXJ
X-Google-Smtp-Source: AGHT+IHXel3rGQ+Xzm5xFbzN7GycW+T/jRwF2RWX8s9nRV5XCnxpKnyFKQREp1gWew8lzaVswTJu0Q==
X-Received: by 2002:a05:6a20:244a:b0:19a:2dd3:75df with SMTP id
 t10-20020a056a20244a00b0019a2dd375dfmr171886pzc.8.1704877270566; 
 Wed, 10 Jan 2024 01:01:10 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/65] target/riscv: add rva22s64 cpu
Date: Wed, 10 Jan 2024 18:57:22 +1000
Message-ID: <20240110085733.1607526-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

Add a new profile CPU 'rva22s64' to work as an alias of

-cpu rv64i,rva22s64

Like the existing rva22u64 CPU already does with the RVA22U64 profile.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-27-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h | 1 +
 target/riscv/cpu.c     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 12fe78fc52..9219c2fcc3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -36,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
+#define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a8f4081922..b32681f7f3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1623,6 +1623,13 @@ static void rva22u64_profile_cpu_init(Object *obj)
 
     RVA22U64.enabled = true;
 }
+
+static void rva22s64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA22S64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -1938,6 +1945,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64, rva22s64_profile_cpu_init),
 #endif
 };
 
-- 
2.43.0


