Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640E74D5B2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6o-0000Ml-6x; Mon, 10 Jul 2023 08:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6i-0008P4-8b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:12 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6g-0005HT-9s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:11 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a1c162cdfeso3390870b6e.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992508; x=1691584508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdPN0gw/4bafisEkd5f0ShmdKryki4IHo8aQ+VXJXdk=;
 b=jI7l3c3leQvK6K3+HWhuJJUaoaZdnzWNEUA5QPSrkMXnXZHznOt8UWILOzlrYh0IbY
 I1EcsxHukOeBBZmUnh1AWJd/7CVU9FfXW3QxOFh+JPdqSIP6QenVyTOXrMsORnJ8vP3N
 EoGt+WmuJb+jqKAli13gc2andmxtAlNVKkrhuLdem8VhDJ7zDS+p89EOGsaEGvj6LhJS
 E84cPgMlChL4bDzYcrhvP7P8+dRlWEWsz3aiqj9HntvgcExeuuAlf8OonCoEeS3vpYyd
 QXi5Z/TUPmNRnVUuBSLZeGVjBuY/XXra+t8AIwKvcky/kvcON35moZrxKSFHONQd13YG
 vDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992508; x=1691584508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdPN0gw/4bafisEkd5f0ShmdKryki4IHo8aQ+VXJXdk=;
 b=cpeBemR4QBnpZD7xxVOVlXcVNgIvpEtWKHqtzo5Be9RrBXY9SPTkxovulqmxZI19aX
 o/5gEV3w/9LDu/pvMxtABpUvGu+0i7InVZn0xQ1B7pzPbiblCz61cY0i42mqiqTJ8CVs
 YCfkua0bfwHjNwS2WNp6kiRY35nbH0tkIVu+hu87QAxsnPO5g+p0i4dfPtEVZOmby/Y8
 CzUO9JVcIfqbjKwoGBVfPXswLGIcmarGTUaXURbxYb1MGpcd/8jgOVvMmArFIM3dxzCB
 Tlj+m11vuqYjr6uODKwVu9uW53YVzT/Ygp2jFxQf+u8ZweyN7WeFsCs7mbyZjUWH7tdz
 aGvQ==
X-Gm-Message-State: ABy/qLb8h3zVUWTn17lIpsXTK8aJY92Wco4RXFmLT9HfAvslNDUqwuv/
 KKNGdMZ8lItRTnSfB8pyX72v557GSnF3ZA==
X-Google-Smtp-Source: APBJJlElw9IswRVrk1doQCiY0OlNuFE869fD5+NqKXJRR03LrNx5+u7X7mdeEvVrTb4gHqlCcfxGBg==
X-Received: by 2002:a05:6808:6399:b0:398:5d57:3d08 with SMTP id
 ec25-20020a056808639900b003985d573d08mr10717433oib.37.1688992508691; 
 Mon, 10 Jul 2023 05:35:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:35:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/54] target/riscv/cpu.c: remove priv_ver check from
 riscv_isa_string_ext()
Date: Mon, 10 Jul 2023 22:32:00 +1000
Message-Id: <20230710123205.2441106-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x234.google.com
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

riscv_isa_string_ext() is being used by riscv_isa_string(), which is
then used by boards to retrieve the 'riscv,isa' string to be written in
the FDT. All this happens after riscv_cpu_realize(), meaning that we're
already past riscv_cpu_validate_set_extensions() and, more important,
riscv_cpu_disable_priv_spec_isa_exts().

This means that all extensions that needed to be disabled due to
priv_spec mismatch are already disabled. Checking this again during
riscv_isa_string_ext() is unneeded. Remove it.

As a bonus, riscv_isa_string_ext() can now be used with the 'host'
KVM-only CPU type since it doesn't have a env->priv_ver assigned and it
would fail this check for no good reason.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-17-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index deb3c0f035..2acf77949f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2124,8 +2124,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
-            isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.40.1


