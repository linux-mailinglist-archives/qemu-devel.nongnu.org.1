Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C67DA655
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwg9i-0000tV-Ta; Sat, 28 Oct 2023 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qwg9g-0000s9-H5
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:02:56 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qwg9Y-0006ev-0f
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:02:54 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so4802013a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698487366; x=1699092166; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x0ethUOQMtbsB7vW2IxvtUgSZM59uUme11O7F8TJxyE=;
 b=PPnx81oONEBdqkw2uFn1FCc/ySgvovy4ztH2CqiuruCnCJzIHIC/Zd5ltG3+NyNlSY
 fX3k2slMSefJFABr7FRbxUiK52EDqodG/nvYim2STaOKYO+6Yty7TZIQTbQphWP5mnQp
 bQGVHZySlztpW7vdRBodl7tr3KziqRL2HuEvf8g5/fzvj0MYxvnDqTYPvZgrsEO6m8yp
 k0gKKbvi1ObsJp8n59t3oRC/KX4NeA9gqiXfXxJt0HmHXeUvpa8TBDd6tkRG8BGMsMu6
 J2MHtbxMuuSctWk1NRLSLwOyUjQc5gvo7VKdhya2eF44J1VKlN8GaEYGm+tZVi4Ytk3x
 KbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698487366; x=1699092166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0ethUOQMtbsB7vW2IxvtUgSZM59uUme11O7F8TJxyE=;
 b=dVwd8Upc62avnSgGH9m5ywi0AgIU8w2LbXomOLBAJ8o3+kG8vFPcgUdJZ8D4y6HTBZ
 6DW+IJBHbqeRZXyhjw8XxdLM0gdS5Yj4rNizFTqeO4fzeivwe8kO2Y4MC10JfQYn2wg4
 dlgxllKuPYWjuo2k8WxqxAiF14Lo9I8nniiqyq7fAJ4XfOQqwc21sCtqoLkC/HpWByej
 8Z7fJWdawLJg/hBwn+0rFq8vr9Bto7tVlI0o3xtkGUVq+nTSSydn47TA7LY5N2+nv/Ky
 o8KBe/p1UPEUUGz8iBTJL5Qu6zQ5BBLm1m8vtOBtVDW4d9l+gZwjRqV31PkbTGwOmRT8
 g2UA==
X-Gm-Message-State: AOJu0YwDgwbALvPoh1i5OoJo1PgC3RP7wuld6da3iZe9F21qzg/vuIjK
 qBTM7+MQyOUVPAGN+SADUas86w==
X-Google-Smtp-Source: AGHT+IHjwZUQVyUkCS072XrlswHtTPxp8Ky1UyyVXV5H/NI7zBxWrj0xmVA9sX+KHNK6kdfCzwgMdg==
X-Received: by 2002:a50:d593:0:b0:53e:3b8f:8ce1 with SMTP id
 v19-20020a50d593000000b0053e3b8f8ce1mr4521662edi.23.1698487365982; 
 Sat, 28 Oct 2023 03:02:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 n27-20020a5099db000000b0053116e45317sm2677996edb.44.2023.10.28.03.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:02:45 -0700 (PDT)
Date: Sat, 28 Oct 2023 12:02:44 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v6 03/12] riscv-qmp-cmds.c: expose named features in
 cpu_model_expansion
Message-ID: <20231028-15f9ef156023d70ac3f2dcd5@orel>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
 <20231028085427.707060-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028085427.707060-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Oct 28, 2023 at 05:54:18AM -0300, Daniel Henrique Barboza wrote:
> Named features (zic64b the sole example at this moment) aren't expose to
> users, thus we need another way to expose them.
> 
> Go through each named feature, get its boolean value, do the needed
> conversions (bool to qbool, qbool to QObject) and add it to output dict.
> 
> Another adjustment is needed: named features are evaluated during
> finalize(), so riscv_cpu_finalize_features() needs to be mandatory
> regardless of whether we have an input dict or not. Otherwise zic64b
> will always return 'false', which is incorrect: the default values of
> cache blocksizes (cbom_blocksize and cboz_blocksize) are set to 64,

and cbop_blocksize

> satisfying the conditions for zic64b.
> 
> Here's an API usage example after this patch:
> 
>  $ ./build/qemu-system-riscv64 -S -M virt -display none
>     -qmp tcp:localhost:1234,server,wait=off
> 
>  $ ./scripts/qmp/qmp-shell localhost:1234
> Welcome to the QMP low-level shell!
> Connected to QEMU 8.1.50
> 
> (QEMU) query-cpu-model-expansion type=full model={"name":"rv64"}
> {"return": {"model":
>     {"name": "rv64", "props": {... "zic64b": true, ...}}}}
> 
> zic64b is set to 'true', as expected, since all cache sizes are 64
> bytes by default.
> 
> If we change one of the cache blocksizes, zic64b is returned as 'false':
> 
> (QEMU) query-cpu-model-expansion type=full model={"name":"rv64","props":{"cbom_blocksize":128}}
> {"return": {"model":
>     {"name": "rv64", "props": {... "zic64b": false, ...}}}}
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/riscv-qmp-cmds.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index 2f2dbae7c8..5ada279776 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -26,6 +26,7 @@
>  
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine-target.h"
> +#include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qobject-input-visitor.h"
> @@ -99,6 +100,22 @@ static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
>      }
>  }
>  
> +static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
> +{
> +    const RISCVCPUMultiExtConfig *named_cfg;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    QObject *value;
> +    bool flag_val;
> +
> +    for (int i = 0; riscv_cpu_named_features[i].name != NULL; i++) {
> +        named_cfg = &riscv_cpu_named_features[i];
> +        flag_val = isa_ext_is_enabled(cpu, named_cfg->offset);
> +        value = QOBJECT(qbool_from_bool(flag_val));
> +
> +        qdict_put_obj(qdict_out, named_cfg->name, value);
> +    }
> +}
> +
>  static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
>                                             const QDict *qdict_in,
>                                             Error **errp)
> @@ -129,11 +146,6 @@ static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
>          goto err;
>      }
>  
> -    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
> -    if (local_err) {
> -        goto err;
> -    }
> -
>      visit_end_struct(visitor, NULL);
>  
>  err:
> @@ -191,6 +203,13 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          }
>      }
>  
> +    riscv_cpu_finalize_features(RISCV_CPU(obj), &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        object_unref(obj);
> +        return NULL;
> +    }
> +
>      expansion_info = g_new0(CpuModelExpansionInfo, 1);
>      expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
>      expansion_info->model->name = g_strdup(model->name);
> @@ -200,6 +219,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>      riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
>      riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
>      riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
> +    riscv_obj_add_named_feats_qdict(obj, qdict_out);
>  
>      /* Add our CPU boolean options too */
>      riscv_obj_add_qdict_prop(obj, qdict_out, "mmu");
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

