Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339678D6C3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMg8-0003Y4-GZ; Wed, 30 Aug 2023 11:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMg4-0003Xn-9J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:00:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMfz-0002E6-PB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:00:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso4786856f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407610; x=1694012410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iSn/+nN1G0NOP7wm/QNt8uNHk4rJ74E0bfrkFLGaRc=;
 b=viOrQh/A7sgAx4rShxr5reluJ524zcj7YS8rYewqJotSubn8eMbS8ycFs7mfp6ZXhl
 c7u1PNS5AkRPUSiGvqIbXf9x1v2FgsMhikfO1efFmUKbCawCEFf375WDmgkGMphbSvMi
 FMlTt22jTSIkcWKKi5tD45GK1hBrs7kr1u9ZQ2QuxRZ9SXCg6idPncLVMdLrX2Z4KDQc
 LI1qSt92w82RHvWQV2i/G3NDkgQkE/3FFVH16WbKKsirL0yQs0tfM9aKpkpoDsw3wfPn
 /UqrPTlhQER0TMKJ5H9K9rlkotGYzcquACJNFlBP49MkwbGXCBKGOQRXsV0r+vekUhez
 DwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407610; x=1694012410;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/iSn/+nN1G0NOP7wm/QNt8uNHk4rJ74E0bfrkFLGaRc=;
 b=FJ81soVmjznPxqmAhrk0eJce2EZMqiPvf4sdE7ymqcaoLkqkXqHrQCb4w4mDbEn8nd
 KqJHczTSDw/hJ4b+kcO3kdY4xHp8LPJ9FKhXioWwXPGvjE3S2nNYHutgN/GgI/8Rg3nb
 5rSVpoCycCDIdBG5UnHdTgJkLwgxJGv51PVDgCFLqX5W9b+x23/0jYhuDbk6LHOOOGZE
 61XJIn66Gymv3d62ys/570tuz37WSJF2XOP/t159fMGfXGg2Ir1knEkTf14bEZg24aCZ
 LV9O+NNINFF3HbPZm3LQhG2nlluxqp4T5okquHMWmTRrBazIKhdgRhQdbUzunqvCpHCA
 mOPg==
X-Gm-Message-State: AOJu0Yx2rMZcvt8YZuL48kkjmH6FzsUsxNu7l8e28qwsRrLfdG1VQpxJ
 W94Y/Unn/v7IMmqPDNOJpl0xNGKM88bcrQRYqS8=
X-Google-Smtp-Source: AGHT+IH5CJtImvHb8C9z5rdGptYE/4HA39ZfQaG4SVLMUouhTKsAl+i0kYRroHF5MyiBoxwctd3Z4A==
X-Received: by 2002:a5d:54c8:0:b0:30f:c5b1:23ef with SMTP id
 x8-20020a5d54c8000000b0030fc5b123efmr2029482wrv.41.1693407609952; 
 Wed, 30 Aug 2023 08:00:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a5d4101000000b0031c6ae19e27sm16773821wrp.99.2023.08.30.08.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:00:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0B3481FFBB;
 Wed, 30 Aug 2023 16:00:09 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-13-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH RESEND v5 12/26] gdbstub: Use GDBFeature for
 GDBRegisterState
Date: Wed, 30 Aug 2023 15:59:21 +0100
In-reply-to: <20230818033648.8326-13-akihiko.odaki@daynix.com>
Message-ID: <87v8cwr2x2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

> Simplify GDBRegisterState by replacing num_regs and xml members with
> one member that points to GDBFeature.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  gdbstub/gdbstub.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b62002bc34..ee6b8b98c8 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -47,10 +47,9 @@
>=20=20
>  typedef struct GDBRegisterState {
>      int base_reg;
> -    int num_regs;
>      gdb_get_reg_cb get_reg;
>      gdb_set_reg_cb set_reg;
> -    const char *xml;
> +    const GDBFeature *feature;
>      struct GDBRegisterState *next;
>  } GDBRegisterState;
>=20=20
> @@ -390,7 +389,7 @@ static const char *get_feature_xml(const char *p, con=
st char **newp,
>              pstrcat(buf, buf_sz, "\"/>");
>              for (r =3D cpu->gdb_regs; r; r =3D r->next) {
>                  pstrcat(buf, buf_sz, "<xi:include href=3D\"");
> -                pstrcat(buf, buf_sz, r->xml);
> +                pstrcat(buf, buf_sz, r->feature->xmlname);
>                  pstrcat(buf, buf_sz, "\"/>");
>              }

I should note I've done some cleaning up of the XML code in the gdbstub
so you'll probably want to re-base once the PR has gone in.


>              pstrcat(buf, buf_sz, "</target>");
> @@ -497,7 +496,7 @@ static int gdb_read_register(CPUState *cpu, GByteArra=
y *buf, int reg)
>      }
>=20=20
>      for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> -        if (r->base_reg <=3D reg && reg < r->base_reg + r->num_regs) {
> +        if (r->base_reg <=3D reg && reg < r->base_reg + r->feature->num_=
regs) {
>              return r->get_reg(env, buf, reg - r->base_reg);
>          }
>      }
> @@ -515,7 +514,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t =
*mem_buf, int reg)
>      }
>=20=20
>      for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> -        if (r->base_reg <=3D reg && reg < r->base_reg + r->num_regs) {
> +        if (r->base_reg <=3D reg && reg < r->base_reg + r->feature->num_=
regs) {
>              return r->set_reg(env, mem_buf, reg - r->base_reg);
>          }
>      }
> @@ -538,17 +537,16 @@ void gdb_register_coprocessor(CPUState *cpu,
>      p =3D &cpu->gdb_regs;
>      while (*p) {
>          /* Check for duplicates.  */
> -        if (strcmp((*p)->xml, feature->xmlname) =3D=3D 0)
> +        if ((*p)->feature =3D=3D feature)
>              return;
>          p =3D &(*p)->next;
>      }
>=20=20
>      s =3D g_new0(GDBRegisterState, 1);
>      s->base_reg =3D cpu->gdb_num_regs;
> -    s->num_regs =3D feature->num_regs;
>      s->get_reg =3D get_reg;
>      s->set_reg =3D set_reg;
> -    s->xml =3D feature->xml;
> +    s->feature =3D feature;
>=20=20
>      /* Add to end of list.  */
>      cpu->gdb_num_regs +=3D feature->num_regs;

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

