Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3B816EC8
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:55:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8u-0003JJ-JM; Mon, 18 Dec 2023 07:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8s-0003D9-DG
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8p-0004yj-NX
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:42 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d04c097e34so22056235ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904078; x=1703508878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5m4+O0TgmlHWaj+kVIgX/kQwLsq7mKhJ8aA7Y8kgkc=;
 b=B10WlwsJzA64IDyR7OROLwv7WQUINO+YCRI6WODKiwyVwgCXPDWxp5T6kvY2oOd+1a
 QCX6UqtfVBh81yjzwBxFr9AHTauh25aI2FxMpckBC1U+l+h6U/XqCgAvnyMG8R3C0/Rd
 FovyHOcN5i2pKgMDXeFPOltXfq3tX9QzunGyX/GBR1QRH6+RKT3ZtSaQwAp/PA/vA+Xx
 jcDBNbBUl8GM/pwYWVGXHfobsSkwKoEYKGkmQyGF8QR8DrszJvenvfq0/z+w7YwagqGg
 zavOx9mvxRacqYvn2kN38183zAvX6WjhD2tDl9iOsB5lSAYsywYXMKMkSJsO0ZoBQprQ
 mpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904078; x=1703508878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5m4+O0TgmlHWaj+kVIgX/kQwLsq7mKhJ8aA7Y8kgkc=;
 b=YmVC2zRvn5a6PrVMWIXO5NN9ljaNV6CdzwcE4Y3WR6vvTQPzwo5dJfAK72bxsHPSBy
 uEib/+4hdgHp+Z7UelSkmCcuwm3bXbsVNAXscVdWUCN4XiDkLgBcGlX7b0halnyz9GHd
 rRIeRSfqixznJZRx76clhNW8iRcP0OGUXtDXiGoo2jT7yFuaVqpVEr9wAPDHJ0q4r9h4
 7kudzFelWrHBIUVYvgVwHEB2Faa8brN4eDL166zBJ8BbBShOpermiWqnJO3E2OU3vvK9
 d6vXCUrKc6/ics2/539Go7BonpQFoZdQn6M92yUTqxY5LMw+n72cUT/wtkeV2pLAB7SV
 2vog==
X-Gm-Message-State: AOJu0YzGTDe/MzbSyHBB0wTVu08Bn5hM+LT6Hpctmcq6+mdgdn/UFQ/E
 6bb0FjCJs/1fJbIviRKlPOgA6wP76Taw+LbFGvM=
X-Google-Smtp-Source: AGHT+IHcy1zE7O5ZZOSVcWB9ENhlYMLuK+IORx3VNDZN3suNmEAKooH6Q0SpUewZ2/Mvy/7X1rKlvA==
X-Received: by 2002:a17:903:244c:b0:1cf:cb80:3fa5 with SMTP id
 l12-20020a170903244c00b001cfcb803fa5mr22092309pls.23.1702904078131; 
 Mon, 18 Dec 2023 04:54:38 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 17/26] riscv-qmp-cmds.c: add profile flags in
 cpu-model-expansion
Date: Mon, 18 Dec 2023 09:53:25 -0300
Message-ID: <20231218125334.37184-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
2.43.0


