Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83027C9D3B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 03:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsCli-0004QF-R1; Sun, 15 Oct 2023 21:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qsClh-0004Q3-Pu; Sun, 15 Oct 2023 21:51:41 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qsClg-0003tV-66; Sun, 15 Oct 2023 21:51:41 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-49d8dd34f7bso1647285e0c.3; 
 Sun, 15 Oct 2023 18:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697421098; x=1698025898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26/2ZeaU/1Yg7sWut+7N0TfyvbhDLf8R/acWeWwg1rU=;
 b=VE2l3YKHx5wZ9BxO15US+BQqhd3tT1xJ4Bg/N6efNFfDntazRPI9OQ0aek4rJVPgYH
 LM/lOFERtd9rUbw25fbFsgLfeTzuK8/zIxjVgizpEkHrSuO9KM3inczGlLgwIgm2Q/Cu
 voQLCi37qG4IYRnoUylFHbQS8IU1DECwtbFvDhtGfksrsZ0hXdUPXlGY98lqXvlW03/5
 aVZ8qKhnnOpBDFGcLmufqhw++R8OXtQkkr1WvhtPnYzzRAqyS84ftJK2MebeuAfKq8o5
 t5lomwvUxQ3i8FGkvD0/CUZW/8yobmnfIuSrGCAfkMdQ9znuPpbjbWDFetEl14r+jLgT
 YoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697421098; x=1698025898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26/2ZeaU/1Yg7sWut+7N0TfyvbhDLf8R/acWeWwg1rU=;
 b=CZdazVSGI2UKSkVE0wkE8XtTjImug+5hOWzQUEwEiRyXVH4AozwYzjmkrG+RnNjuL6
 YXTq70P64+O9upx7EvYmKx5JeO/RhYsJ2UPcpMlmcRJB9qufIC3Vx7eHyoT+Y6M6Lwrb
 uQb2RZmbBeDdwu9HxVuNUvTsTJli+2bGJJEGQTL3Rv/Tlro1plQ7/N9pZOQ6O4wC31Xj
 DMzPLWxxhBKvnm5jG9I+fl5klOZJbpGbPRdgwI1DyKQ9eCOf+lzX/VCAbaxNEXDoCx08
 PIcyJh1Dc7KMb3DEHH2MD0sS/MmxgP/nrjpXZ6qO1XY/Tv8ywCej1XYTbdIaQAC5LaZ2
 hCWQ==
X-Gm-Message-State: AOJu0Yy89rSeE4HhQdLAQ2AxNoirc4Wd+L90qJWIwPtGn+TdbKL/+KlE
 HiaZgF2nVA+k69658O0ySbVmyvFy+bszO84Geb8=
X-Google-Smtp-Source: AGHT+IHfiDg0hdLby65x1rJGHvhvWnf1YrazyHSzdjfe0iPVlIF8fVnlYadmPLfFNxaHcVbUO9cGIPjyGBqpJ15rZYQ=
X-Received: by 2002:a1f:5a06:0:b0:4a4:d34:421b with SMTP id
 o6-20020a1f5a06000000b004a40d34421bmr7763217vkb.7.1697421097817; Sun, 15 Oct
 2023 18:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
 <20231014033545.15220-2-akihiko.odaki@daynix.com>
 <597bf4be-207b-400a-be49-bc18900809a0@ventanamicro.com>
In-Reply-To: <597bf4be-207b-400a-be49-bc18900809a0@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Oct 2023 11:51:10 +1000
Message-ID: <CAKmqyKPqk1sURLQNBoH0MeSJVSut72XiN4H0uT=95S953o7Taw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/riscv: Do not allow MXL_RV32 for
 TARGET_RISCV64
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov <a.anenkov@yadro.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Sun, Oct 15, 2023 at 4:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/14/23 00:35, Akihiko Odaki wrote:
> > TARGET_RISCV64 does not have riscv-32bit-cpu.xml so it shouldn't accept
> > MXL_RV32.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
>
> >   target/riscv/tcg/tcg-cpu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index a28918ab30..e0cbc56320 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -161,10 +161,11 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU =
*cpu, Error **errp)
> >       case MXL_RV128:
> >           cc->gdb_core_xml_file =3D "riscv-64bit-cpu.xml";
> >           break;
> > -#endif
> > +#elif defined(TARGET_RISCV32)
> >       case MXL_RV32:
> >           cc->gdb_core_xml_file =3D "riscv-32bit-cpu.xml";
> >           break;
> > +#endif

This isn't the right fix. The idea is that riscv64-softmmu can run
32-bit CPUs, so we instead should include riscv-32bit-cpu.xml

Alistair

> >       default:
> >           g_assert_not_reached();
> >       }
>

