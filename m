Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1677D71AA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvggl-0000rs-9b; Wed, 25 Oct 2023 12:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvggi-0000rQ-Hj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:24:56 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvggf-0000Sb-R7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:24:56 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so928634366b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698251092; x=1698855892; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IbUFEKOfiYNe7QBbq2JR2F4ZZ2+olfAOIqMaPKVEsrQ=;
 b=FQdlr9WLDb/Aw8JMgeYIXGhUduPu+m6DlkUs6Loqwxa+6ojBMSitgH6yP/9X+TE/rZ
 AerNM4j/iqN30KyXv/hDIz2tbZkp6ARBUijvyhEgZ3xSdxFcSfWUweDej0LaYWlhhbFH
 yve2ZayoEcVfKOZpeiu9GdGUBiNFSi+aWmVGlGw9VS3LkHgOhYsZqHTdNeuOWEVK8lEl
 kleABsren2cHDTsAxF8gDoTiyLkTSdSccFPf1fm3wSgVvzqfR3qThUN0Q4z3/J83stnY
 4E59mG8l5s9zB7LCtg59s2Fn7TCDGiCw57Lbh41oys4nEk96wkteCZ/cLvuiGzJ5cSmS
 XDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698251092; x=1698855892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbUFEKOfiYNe7QBbq2JR2F4ZZ2+olfAOIqMaPKVEsrQ=;
 b=YWZd88DncP9BbBEESEHHNO36dsEEvaEdu41ohRGl2JOmPdNOnuyZLYcZ+uwVuw1xH2
 tcjBcHJO4PcOequXkb9NipTxV3D6rD5RraBbZZNw+g1tTuZb5D+pA2q0EykwY+mjrXVB
 J5jsx7wGROmG9DnB9jq4Jkjoh8Xxeir1qtKc5HkyBAA5aeaDBqIUKW3sdeQ1KANJY+ex
 4LYSotsHBZL1uNwaHWXRH6Q30mvltf9zXXgyNSSZoa9R5ncEJf0FA01V9NVbQMI//I5/
 Kqqjly/eslmxggqbOilvBr6q9BKL+REbosPhJBKfzkoqvm0o7v/Wqdkkoib3O+PTpy12
 ElFg==
X-Gm-Message-State: AOJu0YwZTyxghFkbphFm9MBklTChbCahnG8GxbkTgp29hi2kWIAbKRvQ
 4/TuOUOzXv+D3lzrw9pyM/PePQ==
X-Google-Smtp-Source: AGHT+IEc9ZmCY/S/5U8xFsdr4kldYj0/LBr7JshYY1CUbctEYoYAoBobhI3oDbdxH4WaejjElqn/7A==
X-Received: by 2002:a17:907:3d9f:b0:9b2:b152:b0f2 with SMTP id
 he31-20020a1709073d9f00b009b2b152b0f2mr11828467ejc.10.1698251092166; 
 Wed, 25 Oct 2023 09:24:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a1709064b4e00b0099bd1a78ef5sm10204543ejv.74.2023.10.25.09.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:24:51 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:24:50 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 8/9] target/riscv/tcg: honor user choice for G MISA bits
Message-ID: <20231025-be256dcdda482f9226679e8b@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62b.google.com
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

On Wed, Oct 25, 2023 at 10:50:00AM -0300, Daniel Henrique Barboza wrote:
> RVG behaves like a profile: a single flag enables a set of bits. Right
> now we're considering user choice when handling RVG and zicsr/zifencei
> and ignoring user choice on MISA bits.
> 
> We'll add user warnings for profiles when the user disables its
> mandatory extensions in the next patch. We'll do the same thing with RVG
> now to keep consistency between RVG and profile handling.
> 
> First and foremost, create a new RVG only helper to avoid clogging
> riscv_cpu_validate_set_extensions(). We do not want to annoy users with
> RVG warnings like we did in the past (see 9b9741c38f), thus we'll only
> warn if RVG was user set and the user disabled a RVG extension in the
> command line.
> 
> For every RVG MISA bit (IMAFD), zicsr and zifencei, the logic then
> becomes:
> 
> - if enabled, do nothing;
> - if disabled and not user set, enable it;
> - if disabled and user set, throw a warning that it's a RVG mandatory
>   extension.
> 
> This same logic will be used for profiles in the next patch.
> 
> Note that this is a behavior change, where we would error out if the
> user disabled either zicsr or zifencei. As long as users are explicitly
> disabling things in the command line we'll let them have a go at it, at
> least in this step. We'll error out later in the validation if needed.
> 
> Other notable changes from the previous RVG code:
> 
> - use riscv_cpu_write_misa_bit() instead of manually updating both
>   env->misa_ext and env->misa_ext_mask;
> 
> - set zicsr and zifencei directly. We're already checking if they
>   were user set and priv version will never fail for these
>   extensions, making cpu_cfg_ext_auto_update() redundant.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 73 +++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

