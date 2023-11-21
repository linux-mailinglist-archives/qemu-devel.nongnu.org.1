Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9EA7F3062
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:11:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5RSi-0000ia-9r; Tue, 21 Nov 2023 09:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.shih@sifive.com>)
 id 1r5LE6-0005Ov-3g
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:31:18 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.shih@sifive.com>)
 id 1r5LE2-0007zf-1w
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:31:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cf50cc2f85so23052875ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 23:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1700551871; x=1701156671; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRPBn/BflE4dkZBZDND2XdKcCkvqNu9HIsx7jpMAmPQ=;
 b=EOEzvGHXnWoLzZ/DxI+hd1/4pt5i92yk5dK72Yscvxfu8b2aN6U0uXBQ+TnyGIUZc8
 wGDV2+p2GgLF7B1vM29LU7+4B5xiQ5BhnR4sfZWSV5KluGh8vFBLTAu6AFYoIHvVOg0H
 IttwA4WvDrKYkckv2rSnzf7i/Pw11LcVXRjwpTGmx5Fnd/D3bdAaRQutxEDQmh5T03NC
 QUH0fX3kUQZNgTtttA/ISQy6ti1vA3cnZ4vlCrlmSTk033zj+ZJTQZmNNIlmwb5kUjWB
 J+lsXAmOhPVxhAzzMnj5AHpCWF4HPEx4cZBRMV4MC+2JqZ/6yM4pn5la2SEl/n+gJbaA
 /irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700551871; x=1701156671;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRPBn/BflE4dkZBZDND2XdKcCkvqNu9HIsx7jpMAmPQ=;
 b=sTbl1jCVyEv7HMBfRdwrDwlq2UfImrQPhZGeHef5P6Z2kFgOhnY4Wuy/RE83b8mISZ
 T69FOtvVUpeVT0+AUQE469OEw65Gvt+URITFxmQM9UhaRjvCqMMJ/V3WrZ73neovhNc4
 z9icQoq7Ud51cSkBkY/rCZNfhHCPaMyxXIEGRm8ER+odkNR4ZDV/yNPRx9DzbvBP3nCF
 xoqCONR4n+bTinQ8CuiUm+yUP7Mxs85tXf36fdG64c5aEwtUqUHQdqzAEK7iLIQ5iBVV
 NTFo3yxC6siU3V4Ppqe371l1NPxNKKs/jjEvWUlqMC+oqmgveTX1jm8bZ9tcN+jtcR31
 4DqQ==
X-Gm-Message-State: AOJu0YxnvQAQH4zB5XFqog2s2h5VfeRZYEgu8s9jDey6zVLjsJx2v+qU
 iRPsmnhY0iKcFWuZ4oks8wB4Fw==
X-Google-Smtp-Source: AGHT+IFovYncqjUiIfxyWgaYQDAg1MsFp2X3XfaPlCkPgAKMPY0EGd/KM7XtJi/fKoofYd1BjOhMGg==
X-Received: by 2002:a17:902:720c:b0:1cf:31c4:3a7 with SMTP id
 ba12-20020a170902720c00b001cf31c403a7mr10671321plb.30.1700551870927; 
 Mon, 20 Nov 2023 23:31:10 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5aed:a527:c932:f992:cf2d?
 ([2402:7500:4ce:5aed:a527:c932:f992:cf2d])
 by smtp.gmail.com with ESMTPSA id
 ja14-20020a170902efce00b001cf5d0e7e05sm3423200plb.109.2023.11.20.23.31.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Nov 2023 23:31:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v10 08/18] target/riscv: add rva22u64 profile definition
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231103134629.561732-9-dbarboza@ventanamicro.com>
Date: Tue, 21 Nov 2023 15:31:06 +0800
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6D278C8-C7ED-4C81-B2BE-DA93D0B143E0@sifive.com>
References: <20231103134629.561732-1-dbarboza@ventanamicro.com>
 <20231103134629.561732-9-dbarboza@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
X-Mailer: Apple Mail (2.3445.9.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jerry.shih@sifive.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 21 Nov 2023 09:10:34 -0500
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

On Nov 3, 2023, at 21:46, Daniel Henrique Barboza =
<dbarboza@ventanamicro.com> wrote:
> QEMU implements all possible extensions of this profile. All the so
> called 'synthetic extensions' described in the profile that are cache
> related are ignored/assumed enabled (Za64rs, Zic64b, Ziccif, Ziccrse,
> Ziccamoa, Zicclsm) since we do not implement a cache model.

> +/*
> + * RVA22U64 defines some 'named features' or 'synthetic extensions'
> + * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
> + * and Zicclsm. We do not implement caching in QEMU so we'll consider
> + * all these named features as always enabled.
> + *
> + * There's no riscv,isa update for them (nor for zic64b, despite it
> + * having a cfg offset) at this moment.
> + */
> +static RISCVCPUProfile RVA22U64 =3D {
> +    .name =3D "rva22u64",
> +    .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVU,
> +    .ext_offsets =3D {
> +        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
> +        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
> +        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
> +        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
> +        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
> +        CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),

Hi Daniel,

If the cache related extensions are `ignored/assumed enabled`, why don't
we export them in `riscv,isa`?
If we try to check the RVA22 profile in linux kernel running with qemu, =
the
isa string is not match RVA22 profile.

Thanks,
Jerry=20=

