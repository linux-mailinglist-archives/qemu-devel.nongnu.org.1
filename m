Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC36777F0E
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9LT-0001BD-7I; Thu, 10 Aug 2023 13:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qU9LQ-0001Av-OZ; Thu, 10 Aug 2023 13:21:08 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qU9LM-0000QX-Oo; Thu, 10 Aug 2023 13:21:08 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-79a2216a2d1so379268241.2; 
 Thu, 10 Aug 2023 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691688063; x=1692292863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+PqcNzz0yw6UhQWc4w5KgLbi1hzu7bznud2Pe+Ttbc=;
 b=BItXE/9F6igFXOX8JtHNqunPjF/lwF0TXpFgGYTnAxjwGLt/v0lwd5vC5gV/Y00Dh3
 yoR/H4JSYMpcZ7jZiizGdrpQanNqj+xTXdrGsrc9jfkbkJpOOV8FZKMWWCzwK3CUmc8A
 i8HDB+j8WAYjP6WOfTjo7/rbl73Yv1H9dvmWywFWOig1frdJknbHSMSlWx9hHcE3t9gA
 uO0OrNYYVNtiQ8KHynKO5xRV4yip/6CPX2I4W40dBd1A9yGzE9vENsC7JZzcdfi6UiMR
 X03YXjQeXVU0onGFWqhqwWJk626zlA9sMvTh9P4XJFfUu9eWDNrXPjPLc7frBxFFJw88
 oY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691688063; x=1692292863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+PqcNzz0yw6UhQWc4w5KgLbi1hzu7bznud2Pe+Ttbc=;
 b=QdF9llgVJow2nFsIlABWeNLfs1qlAZvrU5OGHnLI93kbeRESm8akRuBdMxKWwiUO87
 ZT0y6dF7PT8C9wMUJCMAexHj72tmrUL2zM4kwgF9iEZEbDFhCECa1iunPgH2mJJlcEoE
 Q1BTRC45c8uNtcFaU70H0plR9RlD5AG/K2tKCpkXrgLCFfh1kdlmsEF8nG5LuKYGUUty
 KX8ZV79jPw2Jalg+CkewUKFurZebLS/+EJ08EaUbh6wXcbWChE7FzKGTL+Jo1fssWZ15
 awEIAcrDULR2XxhBEby72EGuJOZGZbnAacuh0etKmNPLA/kxOOblG117L4YUykwU6MNm
 FAdw==
X-Gm-Message-State: AOJu0Yzmzt1yJciBhN9dEd4q9otajfeQoeVVRC/nz5N2rTXpV8aizLxK
 k4jyvevHHYHDjD8V8H+iueAfmANR32dKoAdIIVg=
X-Google-Smtp-Source: AGHT+IGowyyI/UJ/r6Xq+uxT2sl9WiGVP7A+WoJfA+jHMVD9pFA/wsMV3RaZO+Otx6Rve1Y8oCCv0GdoPm0wxJFHG5o=
X-Received: by 2002:a05:6102:3674:b0:443:73ac:896d with SMTP id
 bg20-20020a056102367400b0044373ac896dmr2318607vsb.27.1691688063088; Thu, 10
 Aug 2023 10:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230726074049.19505-1-jason.chien@sifive.com>
 <20230726074049.19505-2-jason.chien@sifive.com>
In-Reply-To: <20230726074049.19505-2-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Aug 2023 13:20:37 -0400
Message-ID: <CAKmqyKMbY2w9pWEAkL1C9F4FXL-mNq9vGKpP7i4b46x7nAKVSw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/1] target/riscv: Add Zihintntl extension ISA
 string to DTS
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 26, 2023 at 3:42=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:
>
> RVA23 Profiles states:
> The RVA23 profiles are intended to be used for 64-bit application
> processors that will run rich OS stacks from standard binary OS
> distributions and with a substantial number of third-party binary user
> applications that will be supported over a considerable length of time
> in the field.
>
> The chapter 4 of the unprivileged spec introduces the Zihintntl extension
> and Zihintntl is a mandatory extension presented in RVA23 Profiles, whose
> purpose is to enable application and operating system portability across
> different implementations. Thus the DTS should contain the Zihintntl ISA
> string in order to pass to software.
>
> The unprivileged spec states:
> Like any HINTs, these instructions may be freely ignored. Hence, although
> they are described in terms of cache-based memory hierarchies, they do no=
t
> mandate the provision of caches.
>
> These instructions are encoded with non-used opcode, e.g. ADD x0, x0, x2,
> which QEMU already supports, and QEMU does not emulate cache. Therefore
> these instructions can be considered as a no-op, and we only need to add
> a new property for the Zihintntl extension.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 921c19e6cd..a49e934b41 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -87,6 +87,7 @@ static const struct isa_ext_data isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
>      ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
> +    ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> @@ -1763,6 +1764,7 @@ static Property riscv_cpu_extensions[] =3D {
>      DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
> +    DEFINE_PROP_BOOL("Zihintntl", RISCVCPU, cfg.ext_zihintntl, true),
>      DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true)=
,
>      DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
>      DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2bd9510ba3..518686eaa3 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -66,6 +66,7 @@ struct RISCVCPUConfig {
>      bool ext_icbom;
>      bool ext_icboz;
>      bool ext_zicond;
> +    bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_smstateen;
>      bool ext_sstc;
> --
> 2.17.1
>
>

