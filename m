Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B77E8295BB
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUS4-0000H9-Lb; Wed, 10 Jan 2024 04:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUS0-0008L6-Mx
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:40 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURy-00054n-RO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:40 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbc7746812so3577663b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877237; x=1705482037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbT2IXwH5NQg5nIIsEwk+iWKx1uYeg+0DkDdxTaLzwE=;
 b=HmWW3Q7na+xZCmWLrlIacQdTQeLQxuSmbHYOD880mSKP+DpqZHPH7hKwWeyuPFeCgS
 PhaNBl6MTrQYoZN3mTtCUF0RUE4Z8FkbF/OwWMR6JDWjv+JflBqDBusTSChqFAKaiWKf
 ObpXR/uVXBX5LVB/Djnudsq4eLyqu/hcraC0Exk2IDTwazdQtk51wpQZiqFBy/a7vFZP
 VxLg9z0YiiM6HIvslETkxFBhyGKbOxkNQWIDpeLTKGxScdZDn5nkzVV4y2WAr6ydZBTR
 ycAcCzezhrluIBeFuM8KGc4jq97esI6nJFFf170MECyuhu0vaGmHp5v626DqCs+O7fZg
 WZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877237; x=1705482037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbT2IXwH5NQg5nIIsEwk+iWKx1uYeg+0DkDdxTaLzwE=;
 b=gaSNp+C4mOoMXqAAdMwXiESsi4Bg2CjOKOCxLctOxpcpyEXF6/HPFtICb7kcD34C9R
 3GJz8wf34p/kyjLR05yob03zUQ5g8kx4GFZhfscOKVI9sM/CLKHGdlguEfRu34imfpmS
 UCu8RuCQAngjQFotvWeuADUYIsd0jeAvbN9FUJnElCmn7ZZv6GztGtT4nPW49Rj7YqF7
 51snTeAr0JRs3AveADyEgazCt7tr+1r66BHfoB/lPCeg1EzXcfwyXC3k9zXQUP/yKfxG
 tMYYvUPDXwVehxCyGZKBWAXdLgSRIeZxKQtxPZ6VYTphJq1wLrBcPQEbzcevfQyEb8Fr
 VMxw==
X-Gm-Message-State: AOJu0YyJyZuISsLlayGF6Y1Rtn7KlWyRmQilDB+OYswy5zZfMmIWjLAs
 jYxYpE98iKDDJ9meznRzAdSTKHfYKgp82PhG
X-Google-Smtp-Source: AGHT+IHUo8OiriW2CaLZlluK6KdNQIkc9wacDO0w6XnchUG+BGRpch6VDhRs5VBzAaG7cJk+KCApZw==
X-Received: by 2002:a05:6808:3205:b0:3b9:ddbc:621c with SMTP id
 cb5-20020a056808320500b003b9ddbc621cmr850566oib.44.1704877237553; 
 Wed, 10 Jan 2024 01:00:37 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:36 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/65] riscv-qmp-cmds.c: add profile flags in
 cpu-model-expansion
Date: Wed, 10 Jan 2024 18:57:13 +1000
Message-ID: <20240110085733.1607526-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-18-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/riscv-qmp-cmds.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 35f2b21163..c48b9cfa67 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -115,6 +115,19 @@ static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
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
@@ -219,6 +232,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
     riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
     riscv_obj_add_named_feats_qdict(obj, qdict_out);
+    riscv_obj_add_profiles_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
     riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
-- 
2.43.0


