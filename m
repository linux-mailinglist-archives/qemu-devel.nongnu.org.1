Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C07577BA12
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 15:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVXfp-0003A7-Dv; Mon, 14 Aug 2023 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVXfj-00033K-1J
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:31:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVXfh-000141-74
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 09:31:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so39699785e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692019908; x=1692624708;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs2QjtUGO+bw4EAVkeNm+Yz0kX8uc/v3djpoSR26/1c=;
 b=RmF2seqmbHlodwFCtAGROCdTZpv3AoWhhUPL7i6lO6S+owEMotRFr+V1b9+RIFdBkI
 V3TCXmWddTlONAlB2P7xeEDuZG1OOwzOR2Fe3f654nSuEv4P9URtgYwUyUQV4vE52lxq
 I3ZX7u6cuTwgzU6rYL+Yg2yB8IKCh7izTYHCso16TRd6NFyJb/6lNGTQ3VZsfzECYS35
 E+SnIFbZHVfLTFT6RnfY0YJ2YVKILgUkNMJtLTmvumX6jkGa1NdmhnoX14LMaVnmY7Ss
 Wjg80789bQt+/hVtHmwz/q1kz96OLrKK/gCZl+nD66OAbHwsb8njPdebeCC2y+yzfxTJ
 as+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692019908; x=1692624708;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vs2QjtUGO+bw4EAVkeNm+Yz0kX8uc/v3djpoSR26/1c=;
 b=IUVGY+fY6IJc5n5YSDlGf7BwaEqF40N0aeQ56cWtDl3/9D0VfHOiB8fzMz6fbVKXQ9
 3dG61P7RndD/iQLf6Fk5Vo9PNbzDn3wvmsL0v9/oBZvZcSIL+SulT2BhAxj7qoLWiuPq
 knDOn0K91BxgtplG+GkxY6BvvhLjxLszZFEXonMsNp6ury+eqsMPOMsenaRyBE4/PDbu
 xGYViK1lsStfp040+r6FzRe9sy2/BeDIzLLBp1F5iId1K/bAFlGP2deIdgkcn4szhnzR
 F7Uq6UT/A1+kinWFrete4DzPPy/0u9OF9KgTFoZbOZYyPuYCga4w+5ohXyZyLJVuy9z9
 fJLQ==
X-Gm-Message-State: AOJu0YwF9WkCS/ZOn3acip0n0N2XvqwfeiW2lbqM/PpsMOeAdRvcBMcs
 +Aw5PBplPhTjvM0hiBEH3Pf/6w==
X-Google-Smtp-Source: AGHT+IHlZCtJc47Wtr/r+dgICLJDet6bQQ2diQu5ESIyHRbmUP+FP9tTHF0Uep9z+4/PZGLD59Tw4w==
X-Received: by 2002:a1c:f707:0:b0:3fe:1deb:82 with SMTP id
 v7-20020a1cf707000000b003fe1deb0082mr7656301wmh.7.1692019907733; 
 Mon, 14 Aug 2023 06:31:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a1ce909000000b003fc04d13242sm17368158wmc.0.2023.08.14.06.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 06:31:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3E181FFBB;
 Mon, 14 Aug 2023 14:31:46 +0100 (BST)
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-15-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, Aurelien
 Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Chris Wulff
 <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne
 <shorne@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Max Filippov
 <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 14/24] gdbstub: Add members to identify registers to
 GDBFeature
Date: Mon, 14 Aug 2023 14:30:49 +0100
In-reply-to: <20230731084354.115015-15-akihiko.odaki@daynix.com>
Message-ID: <87bkf9rbr1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> These members will be used to help plugins to identify registers.

I'm wary of exposing gdb'isms directly to plugins. However making stuff
easier for the gdbstub internals is ok. I shall reserve judgement until
I've read the rest of the series.


> The added members in instances of GDBFeature dynamically generated by
> CPUs will be filled in later changes.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/exec/gdbstub.h  |  2 ++
>  scripts/feature_to_c.py | 14 +++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 9b3da5b257..6da4af9612 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -13,6 +13,8 @@
>  typedef struct GDBFeature {
>      const char *xmlname;
>      const char *xml;
> +    const char *name;
> +    const char * const *regs;
>      int num_regs;
>  } GDBFeature;
>=20=20
> diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
> index 8eb8c81cf8..11b1bc05c9 100755
> --- a/scripts/feature_to_c.py
> +++ b/scripts/feature_to_c.py
> @@ -46,7 +46,9 @@ def writeliteral(indent, bytes):
>          sys.stderr.write(f'unexpected start tag: {element.tag}\n')
>          exit(1)
>=20=20
> +    feature_name =3D element.attrib['name']
>      regnum =3D 0
> +    regnames =3D []
>      regnums =3D []
>      tags =3D ['feature']
>      for event, element in events:
> @@ -63,6 +65,7 @@ def writeliteral(indent, bytes):
>                  if 'regnum' in element.attrib:
>                      regnum =3D int(element.attrib['regnum'])
>=20=20
> +                regnames.append(element.attrib['name'])
>                  regnums.append(regnum)
>                  regnum +=3D 1
>=20=20
> @@ -81,6 +84,15 @@ def writeliteral(indent, bytes):
>      writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
>      sys.stdout.write(',\n')
>      writeliteral(8, read)
> -    sys.stdout.write(f',\n        {num_regs},\n    }},\n')
> +    sys.stdout.write(',\n')
> +    writeliteral(8, bytes(feature_name, 'utf-8'))
> +    sys.stdout.write(',\n        (const char * const []) {\n')
> +
> +    for index, regname in enumerate(regnames):
> +        sys.stdout.write(f'            [{regnums[index] - base_reg}] =3D=
\n')
> +        writeliteral(16, bytes(regname, 'utf-8'))
> +        sys.stdout.write(',\n')
> +
> +    sys.stdout.write(f'        }},\n        {num_regs},\n    }},\n')
>=20=20
>  sys.stdout.write('    { NULL }\n};\n')


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

