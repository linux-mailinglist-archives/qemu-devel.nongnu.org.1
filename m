Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217F7AD43D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhbQ-0001IK-Kt; Mon, 25 Sep 2023 05:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkhbJ-0001Dr-JJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:09:59 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkhbF-0003pH-Pp
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:09:56 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ade5687e97so3641087b6e.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695632992; x=1696237792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6mrOAlwo1p8ahDvSLbCoD8rFWhJis1cZL1M9xDC96A=;
 b=VH6JXDrsOcRzG3+pLf7RYeOEaYNs8a+CTSIqpoNta6DJq5rL4IYJKF7uZ1Iwz0Noip
 VTTqBfUhl2q8Dx2eeay+UpQIIyprmBKbtCFmlwGe5TY0pER2oQKfNTHvzKv7/erHiW45
 IvPToS5CJIqBEXEe8IHrQbuzinH1p0iDbbP+x7NH6UcxirbZOXZ340I5PSB3up4LS3R2
 gM1+cvEy6eA4yxxkyCe83bt3okIo28vanYW7jRjrwEOGvDiaszMwanhNuhZP6aLcSmP7
 /cjNgAXrSjvzkcBFApmIlJxuYzsSovY6XIX7yCvCeL3beCYqegDeXWsM/c4jiCtNAO5F
 eIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695632992; x=1696237792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6mrOAlwo1p8ahDvSLbCoD8rFWhJis1cZL1M9xDC96A=;
 b=bjPeHDW2jvkwrXFY6/7peDBLK8HniAJswg4iJqXIC2dyigzNWIsj8YOjh2VDHikbVs
 ps8MECtPqmtpM1l80y0jNwVhnnEwxz9wv9yeRkSsgqPVtBAPWdsV+PLE614iZXjgC7Di
 WHpk9rWwYwOfUNyhLc+7+W35banRpS7vTGqM+77kGOf1WVnrMSAL5vtSNAXY3u/YTyDL
 3ZabxLCfeC+goKMaEsL0BOuVNaREWv/WQLGQ/4tHh8Ib50MiALX3rc2lxBItIFVphyjO
 bzX8A5r2F9Bx753uDpkJ8I3NdO3X3QmUAnnCGUerNLOsPCnu7/zbndjwZK9hjfZaoAPX
 0kiA==
X-Gm-Message-State: AOJu0YxODdimHPLkhwMu5IBBW/1JDmGUllzn5Knqi1+RIUQp1s24traq
 88gRFSMFuvNt8XmjTvqD33LeSw==
X-Google-Smtp-Source: AGHT+IFQxJu8v9NMqWXBzPh/Npc+NRMXtT9c8mTULaYrAOoLAfRVatx5wdzn6/d9tvW5X30j6ops4A==
X-Received: by 2002:a05:6808:1788:b0:3a7:146d:85b5 with SMTP id
 bg8-20020a056808178800b003a7146d85b5mr8078460oib.52.1695632992350; 
 Mon, 25 Sep 2023 02:09:52 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.42.59])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a62e301000000b0068fb4f5f38fsm7538400pfh.30.2023.09.25.02.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 02:09:52 -0700 (PDT)
Message-ID: <4212ecac-54b5-9ccc-3e92-6f84271cf884@ventanamicro.com>
Date: Mon, 25 Sep 2023 06:09:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] target/riscv: vector_helper: Fixup local variables
 shadowing
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: bmeng.cn@gmail.com, alistair.francis@wdc.com,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, palmer@dabbelt.com,
 liweiwei@iscas.ac.cn, Bin Meng <bin.meng@windriver.com>
References: <20230925043023.71448-1-alistair.francis@wdc.com>
 <20230925043023.71448-4-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230925043023.71448-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/25/23 01:30, Alistair Francis wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
> 
> This patch removes the local variable shadowing. Tested by adding:
> 
>      --extra-cflags='-Wshadow=local -Wno-error=shadow=local -Wno-error=shadow=compatible-local'
> 
> To configure
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 3fb05cc3d6..cba02c1320 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -516,7 +516,7 @@ ProbeSuccess:
>                   k++;
>                   continue;
>               }
> -            target_ulong addr = base + ((i * nf + k) << log2_esz);
> +            addr = base + ((i * nf + k) << log2_esz);
>               ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
>               k++;
>           }
> @@ -4791,9 +4791,10 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
>       uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
> -    target_ulong i_max, i;                                                \
> +    target_ulong i_max, i_min, i;                                         \
>                                                                             \
> -    i_max = MAX(MIN(s1 < vlmax ? vlmax - s1 : 0, vl), env->vstart);       \
> +    i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
> +    i_max = MAX(i_min, env->vstart);                                      \
>       for (i = env->vstart; i < i_max; ++i) {                               \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \

