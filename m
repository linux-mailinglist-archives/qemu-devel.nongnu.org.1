Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB88F73B40F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdNK-0004h0-To; Fri, 23 Jun 2023 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCdNE-0004gd-Te
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:46:37 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCdNC-0005gk-T9
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:46:36 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9786fc23505so34594866b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687513593; x=1690105593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4/uHvrNm8MtYeDCRWzVfMske8jpmcsjh8p1nzX+pFAM=;
 b=Zuyt/Gygsor4qfYtC7Q6FGjdxoIWQUJx3zyO+tkS+enEaz9rbgg59Chh6vtE2LAEnN
 SopS/eZBkNh3VlNUBxB3H2OD4nyUmNz95EtN4DpKvvJGGiXGy+ebiDtriNtI+d0MSmLx
 9zuawwt/q5hZ7HI2Bk41DpY0A58OOJHeWiGst+5/LWuazvyTWzlu0fdZpiSizzCA1F0n
 IJMohC1m8CQkkONzrJyL/wnRkpkdU2soQAKyQr10P1ZYES+Hf7ab4rN+518/ZEoPfbrQ
 vZ+suwxb/lPPwwsOafDKMDooXBvP+5RMyJTnuVhWID0niX2LXzIxSxxgg9EGxWl9MTwx
 0aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687513593; x=1690105593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/uHvrNm8MtYeDCRWzVfMske8jpmcsjh8p1nzX+pFAM=;
 b=UZxYw2tcD7sDhIFLQH4FSAFVo+5y9BYiRxFmm9xLW02GH/Sgwcer1fjJFpCEgO22iT
 KPqWxPe0+vFtbN98MvxEkTCAYfqzQaC6l1dd6BLvIxPvl221U8OUGqYAb/LdIsrTd8zJ
 AP+pN35clNyNlC5M9E4zM4lYc2+DMVbBfrVIfcZdBrGHtpIQmeUWapB+jyCT9F1x8F5Y
 KBtOhWhQmBfyL1SapyqHIunpgqmSTdrkfNPgCu/4XVz59hamIc2oh7lUAYUp/xyIY8S6
 ubJ359CYZEXkaZsxISBE96okxgs04f2uiJ12qYjRQZEN56JSzlDFaUKyXBB4RsJkMXUe
 keaw==
X-Gm-Message-State: AC+VfDy4oPNA0o7fZ/voheRDKDcth71gZTFv3qxLCK48gc0IiNfeuOdr
 QpCAgYmmEeTmupyTPIRSbsbxCQ==
X-Google-Smtp-Source: ACHHUZ6jm6a7WDgfNBftQxYcH4LGv3jfQ6YZGdQ03bJYI9Jnx4eGL5UTurJIff0taZQc/hoWp79Z9A==
X-Received: by 2002:a17:906:ee83:b0:978:af9d:771d with SMTP id
 wt3-20020a170906ee8300b00978af9d771dmr20199483ejb.17.1687513592988; 
 Fri, 23 Jun 2023 02:46:32 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 la1-20020a170906ad8100b009889f31d094sm5841859ejb.43.2023.06.23.02.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 02:46:32 -0700 (PDT)
Date: Fri, 23 Jun 2023 11:46:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 15/19] target/riscv/cpu.c: remove priv_ver check from
 riscv_isa_string_ext()
Message-ID: <20230623-cceea5c383211d53109bc04b@orel>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-16-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622135700.105383-16-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x636.google.com
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

On Thu, Jun 22, 2023 at 10:56:56AM -0300, Daniel Henrique Barboza wrote:
> riscv_isa_string_ext() is being used by riscv_isa_string(), which is
> then used by boards to retrieve the 'riscv,isa' string to be written in
> the FDT. All this happens after riscv_cpu_realize(), meaning that we're
> already past riscv_cpu_validate_set_extensions() and, more important,
> riscv_cpu_disable_priv_spec_isa_exts().
> 
> This means that all extensions that needed to be disabled due to
> priv_spec mismatch are already disabled. Checking this again during
> riscv_isa_string_ext() is unneeded. Remove it.
> 
> As a bonus, riscv_isa_string_ext() can now be used with the 'host'
> KVM-only CPU type since it doesn't have a env->priv_ver assigned and it
> would fail this check for no good reason.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a50cb1d0b..b65db165cc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2001,8 +2001,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
>      int i;
>  
>      for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
> -        if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
> -            isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
> +        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
>              new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
>              g_free(old);
>              old = new;
> -- 
> 2.41.0
>

Nice!

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

