Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032247DE9B2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 01:51:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyLvj-0005zo-4t; Wed, 01 Nov 2023 20:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qyLvg-0005ox-5c; Wed, 01 Nov 2023 20:51:24 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qyLve-0000yd-Jn; Wed, 01 Nov 2023 20:51:23 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-457bda4cf32so182161137.3; 
 Wed, 01 Nov 2023 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698886281; x=1699491081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bBIILhXimgskabJlY8xguTIRFbhGqChXx6+axB5mwc=;
 b=Gs1g+YLVURP3SDGZOJPe9XsTwW5j+6nw+1tl2vlpx9FKnIMZ4ZMQ7eCQPOhfxgHnLq
 XWIs6ZSbpwlqezwMzqeatm5fThDxGQsq4gz7VpZeuOYt7dGYX/8fSFzE7GeV8VOwLUux
 ogQVa8sNh4BUxHDDwp3MGwOkewvCzjykmEZTU5VZF1M2zfDpDQc8/OIJnk529m93mgC6
 mCsMS9DrixoLVfjlUa9vGOKlAmEgF1NQkSKWHk9KJJHfgV83mzAUsuLzXXL9AF9S9Bep
 h7qsydE7arat/hP0CimFXLqSr3y5RqekZnKjqR4raMTKLaz22G8ER+yOV8gWokN6pr/0
 HoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698886281; x=1699491081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bBIILhXimgskabJlY8xguTIRFbhGqChXx6+axB5mwc=;
 b=IKmhmvEZdCTSQj3FuM/CNvJlWEXC6K/R+hF09975ILDjgq12B6tkSrR/b9GzYZ9r/Q
 oPPPfg53EHqZgPgZflZ8FF0aYWRvtIRGjiEBB0nHHmK60EWe6x3qkDd4YWYhZF7LvH/t
 7rKfoaoEvENmSO2bBST48sL0dKPcnIEWWYhsJ7DMAa65jndxu6gVSdN5gQW0kHKRqdUz
 AChZ6RVDWYly1UHqHMOW2Fx67kX3rlxLZ1uPAmXBp7rwkUjcGNl1p8t4jEMJ1KUU5xyd
 Jedb5Sx+MxhXGAPqr01R2pffjq9s2lZLsXdkcICHNCUqkJjqghBfm4/icOTZDf8CCnp0
 ijGw==
X-Gm-Message-State: AOJu0YzqS5Vgi/nHSmGx3/DmqtpFHyhXSY/HpPeZKbjXM3XQn8qBAeUY
 nveUJKjVCY41uv/TaP5n4t7o31VKkRn8IDmoc1c=
X-Google-Smtp-Source: AGHT+IEDv3BVIomBhB11eFaKhHDHsmDskj1D1WtMPzvLDw25AEJAPx9odz+Ev4Y6D4H0QevgJrzFbdJ9CDKthWXkUHM=
X-Received: by 2002:a67:c388:0:b0:457:cccf:75eb with SMTP id
 s8-20020a67c388000000b00457cccf75ebmr17339244vsj.16.1698886281524; Wed, 01
 Nov 2023 17:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-10-max.chou@sifive.com>
In-Reply-To: <20231026151828.754279-10-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Nov 2023 10:50:55 +1000
Message-ID: <CAKmqyKP6vB2SP2KxP-qE1vO1_AM08dJ8zPAM=YiCpSrZ80MqzA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] target/riscv: Expose Zvks[c|g] extnesion
 properties
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Fri, Oct 27, 2023 at 1:22=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
>
> Expose the properties of ShangMi Algorithm Suite related extensions
> (Zvks, Zvksc, Zvksg).
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8eae8d3e59c..1709df76a9b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -133,7 +133,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
>      ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
>      ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
> +    ISA_EXT_DATA_ENTRY(zvks, PRIV_VERSION_1_12_0, ext_zvks),
> +    ISA_EXT_DATA_ENTRY(zvksc, PRIV_VERSION_1_12_0, ext_zvksc),
>      ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
> +    ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>      ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> @@ -1385,6 +1388,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental=
_exts[] =3D {
>      MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
>      MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
>      MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
> +    MULTI_EXT_CFG_BOOL("x-zvks", ext_zvks, false),
> +    MULTI_EXT_CFG_BOOL("x-zvksc", ext_zvksc, false),
> +    MULTI_EXT_CFG_BOOL("x-zvksg", ext_zvksg, false),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> --
> 2.34.1
>
>

