Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A16826FB2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMper-0003w3-R9; Mon, 08 Jan 2024 08:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rMpep-0003vg-9U
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:27:11 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rMpen-0006IZ-KQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:27:11 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2a1a584e8bso152105166b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704720428; x=1705325228; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1/S7NO6UwoWL1rC7ZAoUavDZDgBVHGYlMv41dSqoUZ0=;
 b=BO8Z8JviOKxj9vcq2YFyie3mITbBvsCz9WwoH7m5NxoQqTFF7OfDt2rJJU++av1X+S
 6OUNIVnQFi4eAlFY7kbBFoA45Ud25JEDLODqNXj75MBUB6smZukNPdxcV9XBhO5BMeym
 neidDEhLd4T7LeqkjvKoLJna54hL3V5jAw016fvkvBgEzxofMGozB9NedUROVaNAb44O
 RK4AwbB4K0HGs4d/xlO8Q9UZBE3m3KHhuFdIux65Q1Uwe8JE6AH48YuMMoeYga6HBoTc
 xWab/l7VzBk7tF9loDF+Vsqamns8dP4jR20x+3iK9rSh1j314TjzK98W8Tohs5zLiZ+Y
 Blsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704720428; x=1705325228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/S7NO6UwoWL1rC7ZAoUavDZDgBVHGYlMv41dSqoUZ0=;
 b=mnSyHUWiQltOCqZH8wTFCIJc0fFp2uUig9Nhu1AnYGt4usKCRZPxxuLucY/gLkd7xL
 2rJ8+nunmOP1iL4PA9Ap0LNGZhc9dH/0PWxjlBNvsKJeST3mJw4x4faAHnh6XvbpFhO4
 8fWIBhPGpOgPzCXEMfInZ1P+9SZyCmtwD5J4s3oix1Sj8n8aG3nDx/Do3luGjcmfWkTv
 4ulST7kXgeavEwf/IUQ0tZ13jm2CzvllfRHivYER7ukMb33Bc0UumjCxF8cfyLUIOxxk
 5gKHQl+V0fIflWWNvaQTofYJzr96uVhPXOg8YGp9odUEyqs1IBFo61VZTp69QqbdEsAp
 1MUA==
X-Gm-Message-State: AOJu0Yy0ViaZZihP3T5qu39uavlXDYUgoSH8TBZR2n9JPNI7QVbfAcmd
 AuoxQ1SlZtkLezXyyZjUrj4G8Rhin9EOog==
X-Google-Smtp-Source: AGHT+IE4hdAYNNXGz838FbeVHSo3EP6Mc17m6k6mIhwtiI2r+ErfogEGUsJRVovhow1p04sMb9OJbA==
X-Received: by 2002:a17:906:f8c8:b0:a28:fbf4:5944 with SMTP id
 lh8-20020a170906f8c800b00a28fbf45944mr1540863ejb.104.1704720428024; 
 Mon, 08 Jan 2024 05:27:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a1709061e8500b00a19b7362dcfsm3909657ejj.139.2024.01.08.05.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 05:27:07 -0800 (PST)
Date: Mon, 8 Jan 2024 14:27:06 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, qemu-riscv@nongnu.org, 
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: Re: [PATCH v2] riscv: support new isa extension detection
 devicetree properties
Message-ID: <20240108-efa3f83dcd3997dc0af458d7@orel>
References: <20231208-sponge-thickness-c0e9511b1baf@spud>
 <CAKmqyKNmepRv7i43U-2V2LYzkQB1bG9WWvS1PUJdrF3ynX5NmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKNmepRv7i43U-2V2LYzkQB1bG9WWvS1PUJdrF3ynX5NmQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x631.google.com
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

On Mon, Dec 18, 2023 at 02:37:55PM +1000, Alistair Francis wrote:
...
> > +void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
> > +{
> > +    const size_t maxlen = sizeof("rv128i");
> > +    g_autofree char *isa_base = g_new(char, maxlen);
> > +    g_autofree char *riscv_isa;
> > +    char **isa_extensions;
> > +    int count = 0;
> > +
> > +    riscv_isa = riscv_isa_string(cpu);
> > +    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
> > +
> > +    snprintf(isa_base, maxlen, "rv%di", TARGET_LONG_BITS);
> 
> This should dynamically come from misa_mxl_max not the compile time target
>

Need to also fix riscv_isa_string()

Thanks,
drew

