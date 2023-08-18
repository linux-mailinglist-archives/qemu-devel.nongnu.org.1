Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C0780792
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 10:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvHo-0005Uu-L0; Fri, 18 Aug 2023 04:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1qWvHl-0005Uk-6n
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:56:49 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1qWvHi-0005Dv-F5
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:56:48 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff9121fd29so935819e87.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349004; x=1692953804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1e2Uww4gRQpdo8lUST7I+XPJWueSs3M9mFBaTBTD70=;
 b=FKmm0Q2MA7qMQGF4s7qyAY0iQWHgj+OyXW/9Vvt3z7P7eHWkdhr5yagri8oaoR69d6
 A3TNP43KI2zi6a6UcPip1LxPWnp46Ma0bBuFlVTpCkZJzVC8U9k/c9CzxQjir0gmuKlL
 VcNHk0gReqDL1QwLpXrmxYtCX/4VbHIuQ/k0BqCHa/bHIrEn82LJ/zYFC5ybBPaoVZqD
 HXEF2AsK599CqwLHUQ7f/2pX2jJS8p/yp/eaHIdEuxkH3+anI/dYwZLj1B7W/H956uwA
 vgYdEhmDguCFetMXIwd8bcoxv52/VwY035HPze3FQ1RkDYq7zuWuncNC9oCL9tIhJYP+
 KvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349004; x=1692953804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1e2Uww4gRQpdo8lUST7I+XPJWueSs3M9mFBaTBTD70=;
 b=bEOVqjwge772Bz6indE7edbIxfZLRJ4W4Z0fmVXong0TqUPZ9DdgvFgqZMHg3UCb8E
 xine1on39tDBjcNY3uGvfFrpG0pkqk0zOAG6+BiYhBeJxLxmkO6REiDWBlc9cvj32Om8
 XmraMan1JlBWcjb8Vt+IWLq6NStq+YkecGYYVrWaG3/GKRHDteuFhfzDeF8FtO97b7ty
 5hc7NSyWPuQdFrD+zhQmDNphtk+Ur+s1C8eAUujR/0rp37Rs77iKhZ8aGV4aBnQfThT1
 jfIcLUniUJAw/1IH2nGFerCEfIL3o2RB9NYUYcZ/h7UF+T4tFABzD+oIUrJ3WkPXZaqU
 PGSQ==
X-Gm-Message-State: AOJu0YxK0sHx3c1Omh5BG1gkLiUbZTWXT29Zj+thfqK7FufkxO4MrdxV
 TfFfnKwZ5TOrdfG86FISTJVkw07lJjP8Ibbgpws=
X-Google-Smtp-Source: AGHT+IE8pEU/JlnUieR3MUE3XdPpfJjJiciFD932GazYet7599OLvtVUM6DBcQSsaqxz+Mlc02sGGTxuQPwWFw7uP6c=
X-Received: by 2002:a05:6512:324d:b0:4ff:9aaa:6e3e with SMTP id
 c13-20020a056512324d00b004ff9aaa6e3emr1263050lfr.41.1692349003860; Fri, 18
 Aug 2023 01:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-3-gaosong@loongson.cn>
 <05e574af-50e0-e71c-2e88-ab7fafd71155@linaro.org>
In-Reply-To: <05e574af-50e0-e71c-2e88-ab7fafd71155@linaro.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Fri, 18 Aug 2023 16:56:33 +0800
Message-ID: <CABDp7VpC8bryYW+Vm6fWGkajmKZmqeMDU+eUts+qHcz+F3Yt_w@mail.gmail.com>
Subject: Re: [PATCH v3 02/18] target/loongarch: Add new object class for
 loongarch32 cpus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
 richard.henderson@linaro.org, Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org, 
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn, 
 shenjinyang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, Philippe,

On Fri, Aug 18, 2023 at 4:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Jiajie, Song,
>
> (+Huacai)
>
> On 17/8/23 11:31, Song Gao wrote:
> > From: Jiajie Chen <c@jia.je>
> >
> > Add object class for future loongarch32 cpus. It is derived from the
> > loongarch64 object class.
>
> Is it how the architecture design happened? IIUC per [*] it seems
> the arch was designed as a whole then adapted per segment (32/R,64).
> So from a QOM PoV better would be to have a abstract 'common' parent
> objs/classes, then derive 32/64 from it.
> IMHO this matters for the maintainability of target/loongarch/, but
> if this isn't important then I won't object much to this series.
From my point of view, it is more natural to have loongarch32-cpu
together with loongarch64-cpu, not loongarch32-cpu and loongarch-cpu
(only for 64bit).

Huacai
>
> Regards,
>
> Phil.
>
> [*]
> https://lore.kernel.org/linux-arch/20210706041820.1536502-1-chenhuacai@lo=
ongson.cn/
>
> > Signed-off-by: Jiajie Chen <c@jia.je>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Song Gao <gaosong@loongson.cn>
> > ---
> >   target/loongarch/cpu.c | 19 +++++++++++++++++++
> >   target/loongarch/cpu.h |  1 +
> >   2 files changed, 20 insertions(+)
>
>
> > @@ -750,6 +760,15 @@ static const TypeInfo loongarch_cpu_type_infos[] =
=3D {
> >           .class_size =3D sizeof(LoongArchCPUClass),
> >           .class_init =3D loongarch_cpu_class_init,
> >       },
> > +    {
> > +        .name =3D TYPE_LOONGARCH32_CPU,
> > +        .parent =3D TYPE_LOONGARCH_CPU,
> > +        .instance_size =3D sizeof(LoongArchCPU),
> > +
> > +        .abstract =3D true,
> > +        .class_size =3D sizeof(LoongArchCPUClass),
> > +        .class_init =3D loongarch32_cpu_class_init,
> > +    },
> >       DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
> >   };
> >
> > diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> > index 5a71d64a04..2af4c414b0 100644
> > --- a/target/loongarch/cpu.h
> > +++ b/target/loongarch/cpu.h
> > @@ -382,6 +382,7 @@ struct ArchCPU {
> >   };
> >
> >   #define TYPE_LOONGARCH_CPU "loongarch-cpu"
> > +#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
> >
> >   OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
> >                           LOONGARCH_CPU)
>
>


--=20
Huacai Chen

