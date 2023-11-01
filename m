Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93557DE6D9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI3O-0002xH-R9; Wed, 01 Nov 2023 16:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3N-0002wy-7D
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:43:05 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3K-0000oh-O7
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:43:04 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7c95b8d14so2974687b3.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871381; x=1699476181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52R6Eg8XXxFu2Bm2dvauXbc+AXEa1/gdYft/MoiQmhc=;
 b=deuqh4ds8EmyaJZGvskb+JRBTJhj2mRwNkJeOqyVR2pSI7P6moAWA3rm7IG5YiVPV1
 LG2ntVDcx1HUttO0/peD6TrpcCLnksIkDTd2PUMDP/ZsnR9ioZYvfYtxjCMjEUHEbvAu
 GU/JaSsNJQhHjAjW9/Dqre5M+NNRI6Rbb6Wm0PR8UiXwxvBMkx44+DFmyy91nnXplH6E
 5YEYmUdijsUv8FcbNJN4bDCcYvPfO7pQ78ouZic+aNmxLqqVKx4DJP9J1NSQ2wcjmuBN
 6uiinTIwxzAGvU+WpLE9Yrr6bV58WiJvAc0wCB6lbpa9ou/qNf7L2A4Crf7zK3KtCAKs
 Twvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871381; x=1699476181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52R6Eg8XXxFu2Bm2dvauXbc+AXEa1/gdYft/MoiQmhc=;
 b=VNVgr8AQANLzZKd5N1HflxsaYxVRF445DYw3c3Pf93Mg8a7aNupwjuudXaKj5RemG3
 FXBc5/uhPjFGOQC1HXG03VGnN7Z1xmOGD8DBHPA+EgqkS1bgQ3pjdYi//tPLVr0F2QHX
 e6a5gSR7oFjPuv8CrqQla4XGtniq1uEUkjCskAdu0whog8ZuqXFuLgPjtdcts84YXJB4
 WL+BG9kJM76RTVlV/RVxy8xHOnED1oAJuJiwDFpRp89WzoPqIjo/UVhxvDw7l46R+SpX
 cDfxrC4hNoB7IMML1UklFsid+mk2xd5X7ay9H+Zdv8sWJC1qwOPUag5NBtjR8mtbJyhQ
 M4iQ==
X-Gm-Message-State: AOJu0Yxu0g6v0cIK6+GR1PHtIn4GpVzWRHVZRrLbkFCfuyaw6WsTN7Lk
 zeyER+9DrO/oMccq+w4yOQEA/kuVFsNo0Op0BUA=
X-Google-Smtp-Source: AGHT+IEWhffg4w8FZhoTovVRS1DmqqawUqlKQgWuX7ZmyV6nWKmf8aUAvTvi6XItcPZ1va+MN8Mgxw==
X-Received: by 2002:a05:6902:1892:b0:d9c:cc27:cc4a with SMTP id
 cj18-20020a056902189200b00d9ccc27cc4amr15324195ybb.32.1698871380888; 
 Wed, 01 Nov 2023 13:43:00 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:43:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 19/19] riscv-qmp-cmds.c: add profile flags in
 cpu-model-expansion
Date: Wed,  1 Nov 2023 17:42:04 -0300
Message-ID: <20231101204204.345470-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112b.google.com
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
if a certain profile is implemented by a given CPU. This includes
vendor CPUs - the fact that they don't have profile user flags doesn't
mean that they don't implement the profile.

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


