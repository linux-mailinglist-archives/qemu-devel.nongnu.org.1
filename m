Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0437DDE53
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:20:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7O2-0008BK-Un; Wed, 01 Nov 2023 05:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7Nv-0008Au-U9
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:19:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7Np-00023M-Sc
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:19:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4072101f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698830367; x=1699435167; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=abM5PwZO1OsUVIy+bXnECh4D0+840LE3UAxhMouMzuM=;
 b=eibBJOSPpPulO0iWWob6k/sgA2NFJpVK7ICdfBQokUEsZ9JOO3HI35wF79W9pi99br
 dp3EiDreFW1Y++DEQ1Ugj4WDuaR39hibyhMLX0rTUu8E3jXiy1vttyVNNtcjSrAcCyga
 cZLLZ1iJdiXK1MIoDyUQ4YaA31J3JNqtSjLFaeMUO2c6G4B3oxFa0tA0hMJqqU5D3dHF
 TsWD3JIkVg2h402mw/FNMb+D46gpXNoYBYHqZkbgmDVbVmmcP/wqTxBe2PE6k88zLh3n
 +fpyPXlXJpRqIVHvtfbqwB8JH0xwU9C6rruyfQpAymDSU4ml7SB65pCRhbKrpBROr3zg
 2pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698830367; x=1699435167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abM5PwZO1OsUVIy+bXnECh4D0+840LE3UAxhMouMzuM=;
 b=v1pWB9sIWTP+mC37TucUGsm0EHKcKfxFCIlDWSkzNxXFNLbxptt3rgF5Pw5GyWRPtd
 D7y7Deri/modUjHo0C0NN/r3dm9ti8NijdW1jKC/Mdk5/9d7DaQ0/gXyxQsPde0oXX66
 PgvRmE9fvgxhHI+L0hUUpnf+Xo1jKfMXeekuz52mGXJunXwWqVM1Ag2Btf+ljSdlFV7c
 rEwHC1trJUPCEu2bTbvnOHKNORgDsTEDOZBVEiPEN5tanqDLVyNaiAUJ6SxXBu7gH08K
 FA3y7+5vKH0oYb2ZDP+YFN03NQAGv+k07n+/mKd9t4RO/Kus1CWUZ9WuY7mEDTexYZ3n
 dtMw==
X-Gm-Message-State: AOJu0YwNXdrztYiuV+vnhIue95XkdLYe7b6fr/DrqiV8wU1FMmJmvYDY
 Kcuf2pfmOZ8C/463pZXKTeESeBzLHxi6MPaG5Rk=
X-Google-Smtp-Source: AGHT+IFOwGPoDC2J9pUonSvlvttH3lvWXE1PhllYzz5JlJlqX7RvQhq7g8xNDFKKO6BWIehYaLmwPQ==
X-Received: by 2002:a5d:4b46:0:b0:32d:8855:138d with SMTP id
 w6-20020a5d4b46000000b0032d8855138dmr11205320wrs.66.1698830367051; 
 Wed, 01 Nov 2023 02:19:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a5d6706000000b003232380ffd7sm3661996wru.102.2023.11.01.02.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:19:26 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:19:25 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 16/16] riscv-qmp-cmds.c: add profile flags in
 cpu-model-expansion
Message-ID: <20231101-7e45796c91beaf0972b55f7d@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-17-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031203916.197332-17-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
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

On Tue, Oct 31, 2023 at 05:39:16PM -0300, Daniel Henrique Barboza wrote:
> Expose all profile flags for all CPUs when executing
> query-cpu-model-expansion. This will allow callers to quickly determine
> if a certain profile is implemented by a given CPU. This includes
> vendor CPUs - the fact that they don't have profile user flags doesn't
> mean that they don't implement the profile.
> 
> After this change it's possible to quickly determine if our stock CPUs
> implement the existing rva22u64 profile. Here's a few examples:
> 
>  $ ./build/qemu-system-riscv64 -S -M virt -display none
> -qmp tcp:localhost:1234,server,wait=off
> 
>  $ ./scripts/qmp/qmp-shell localhost:1234
> Welcome to the QMP low-level shell!
> Connected to QEMU 8.1.50
> 
> - As expected, the 'max' CPU implements the rva22u64 profile.
> 
> (QEMU) query-cpu-model-expansion type=full model={"name":"max"}
>     {"return": {"model":
>         {"name": "rv64", "props": {... "rva22u64": true, ...}}}}
> 
> - rv64 is missing "zba", "zbb", "zbs", "zkt" and "zfhmin":
> 
> query-cpu-model-expansion type=full model={"name":"rv64"}
>     {"return": {"model":
>         {"name": "rv64", "props": {... "rva22u64": false, ...}}}}
> 
> query-cpu-model-expansion type=full model={"name":"rv64",
>     "props":{"zba":true,"zbb":true,"zbs":true,"zkt":true,"zfhmin":true}}
>     {"return": {"model":
>         {"name": "rv64", "props": {... "rva22u64": true, ...}}}}

Nice!

> 
> We have no vendor CPUs that supports rva22u64 (veyron-v1 is the closest
> - it is missing just 'zkt').
> 
> In short, aside from the 'max' CPU, we have no CPUs that supports
> rva22u64 by default.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/riscv-qmp-cmds.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index 5ada279776..205aaabeb9 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -116,6 +116,19 @@ static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
>      }
>  }
>  
> +static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
> +{
> +    RISCVCPUProfile *profile;
> +    QObject *value;
> +
> +    for (int i = 0; riscv_profiles[i] != NULL; i++) {
> +        profile = riscv_profiles[i];
> +        value = QOBJECT(qbool_from_bool(profile->enabled));
> +
> +        qdict_put_obj(qdict_out, profile->name, value);
> +    }
> +}
> +
>  static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
>                                             const QDict *qdict_in,
>                                             Error **errp)
> @@ -220,6 +233,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
>      riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
>      riscv_obj_add_named_feats_qdict(obj, qdict_out);
> +    riscv_obj_add_profiles_qdict(obj, qdict_out);
>  
>      /* Add our CPU boolean options too */
>      riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

