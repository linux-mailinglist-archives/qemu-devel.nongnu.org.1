Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FF7F852B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cjV-0002Oz-Bc; Fri, 24 Nov 2023 15:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cjS-0002JR-2f
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cjQ-0005Oz-CT
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:57 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cf89df1eecso16695165ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857495; x=1701462295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54Kf0rAoudsnnoVt4nlQX6I3ltS6TlxVzrnjj9HiVnE=;
 b=L+is6zLOo7CMiYNa6dG756sebyfOjGxUHsj2sbU0vgXqN+J4TXloZUGSj8nec/UhPr
 K88k9guGCevdvxm0GuAP6GHPmQ2y5ESm8zCYG+VnKigyL9sytENPRRrGvsvcQq2lDchR
 byeJEaKq61g9l/TArHxeghk1sRave/K0gdLJS18ZLR43+WWmq0Qzy+scZWK1O4gVzpUC
 VVNZ16yO4XVNaMGOtjW3sWgScaKxbqU59x+xzpI4OdtTmWPZ/rbsJywXZ6EAzCQ82hB6
 jUVk/l/K20DKkkJDzd7t66ft+LnpBn7e0ZzKoU2CKx9TOA2aO0QTWoEUsDOdzNMqvjWK
 QOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857495; x=1701462295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54Kf0rAoudsnnoVt4nlQX6I3ltS6TlxVzrnjj9HiVnE=;
 b=PFGI84frEp0qbFcSUE8KYfDGPRtLW/mUoE6mPgmi1r4omEp86tJ9R7F0fkrr9ih1gm
 9PbgnzqDyvvIAyShnd49LkS8uAyAH/egVRZBPDcBq2Smbf5FwqJ2HNFRT/eJC51GoGYS
 v7g/jqy5EeiBQbrV0uBUP/FFMuzujSBKqFCMRlwSjmto8OhIV33jYuUwWR2gOtbEkg87
 UNG8ULjEcyDiNUtItINvbjg/EIAk9MnVBR6+dwAq+/GwKX0zHxdSi2BNUJPpe9HaKB6R
 sWQPN6QMS4acIsMTgCvaAF8CsU5/Bp/SlMky5g3n/5QcMBnLpJiMN4dbTdUq4o00Li+g
 oyow==
X-Gm-Message-State: AOJu0YyoKQ93I1vQyEHXERFVI5HZHiEdEm/7rIRV4OIv/FF8SnQ0m3S5
 b93z/c3Do0gtn7pcNqQJv1mXgtlN2DWw5Joozrg=
X-Google-Smtp-Source: AGHT+IFgbLMw7N2IHQqMqQg3j3bdABj+UrudKXwfvuIIdvCQcTZeYTHVcJ0rFqIreO7bxVofCihoSQ==
X-Received: by 2002:a17:902:ea08:b0:1ca:8541:e1ea with SMTP id
 s8-20020a170902ea0800b001ca8541e1eamr4694630plg.0.1700857494820; 
 Fri, 24 Nov 2023 12:24:54 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 17/18] riscv-qmp-cmds.c: add profile flags in
 cpu-model-expansion
Date: Fri, 24 Nov 2023 17:23:52 -0300
Message-ID: <20231124202353.1187814-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
References: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Expose all profile flags for all CPUs when executing
query-cpu-model-expansion. This will allow callers to quickly determine
if a certain profile is implemented by a given CPU. This includes vendor
CPUs - the fact that they don't have profile user flags doesn't mean
that they don't implement the profile.

After this change it's possible to quickly determine if our stock CPUs
implement the existing rva22u64 profile. Here's a few examples:

 $ ./build/qemu-system-riscv64 -S -M virt -display none
-qmp tcp:localhost:1234,server,wait=off

 $ ./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 8.1.50

- As expected, the 'max' CPU implements the rva22u64 profile.

(QEMU) query-cpu-model-expansion type=full model={"name":"max"}
    {"return": {"model":
        {"name": "rv64", "props": {... "rva22u64": true, ...}}}}

- rv64 is missing "zba", "zbb", "zbs", "zkt" and "zfhmin":

query-cpu-model-expansion type=full model={"name":"rv64"}
    {"return": {"model":
        {"name": "rv64", "props": {... "rva22u64": false, ...}}}}

query-cpu-model-expansion type=full model={"name":"rv64",
    "props":{"zba":true,"zbb":true,"zbs":true,"zkt":true,"zfhmin":true}}
    {"return": {"model":
        {"name": "rv64", "props": {... "rva22u64": true, ...}}}}

We have no vendor CPUs that supports rva22u64 (veyron-v1 is the closest
- it is missing just 'zkt').

In short, aside from the 'max' CPU, we have no CPUs that supports
rva22u64 by default.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/riscv-qmp-cmds.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 5ada279776..205aaabeb9 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -116,6 +116,19 @@ static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
     }
 }
 
+static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
+{
+    RISCVCPUProfile *profile;
+    QObject *value;
+
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        profile = riscv_profiles[i];
+        value = QOBJECT(qbool_from_bool(profile->enabled));
+
+        qdict_put_obj(qdict_out, profile->name, value);
+    }
+}
+
 static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
                                            const QDict *qdict_in,
                                            Error **errp)
@@ -220,6 +233,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
     riscv_obj_add_named_feats_qdict(obj, qdict_out);
+    riscv_obj_add_profiles_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
     riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
-- 
2.41.0


