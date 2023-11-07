Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FF57E3FBC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:09:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LpH-0000aB-25; Tue, 07 Nov 2023 08:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0LpF-0000SJ-6D
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:09:01 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0LpA-00078B-GX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:09:00 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso9347240a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699362535; x=1699967335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjVb5feIgOLLxLWvdaFsL34DVmZGoPTAWL8ivwyENP4=;
 b=MXFlvcyQ44DK3l4Gh62ttU7qLi5P+Onw2RYT5zCzdsv/EwxjB6lH6hANnvWyfGddX/
 qCxTvhgakHpM7DGvk7ypVZ7wx3+R5o3SekKuuSJgSPSA6yIKuonjiiIHjQ9FJQmjay6v
 SgU8fvY3mv4zsgRb1rn++APwiPh3exSUVUca4moLatIWO0O1bgJda+3cCpO25PW2FmWq
 ztPpK8p9nWHwa4UP1hw3KrlkS/OdQOki6tIEc+ySXst3dTm09FZms6dEW41YkRL7SdLG
 4sI/ppjzqa/29VTkOlkxE7Fav7R/RXOiI2nqZ8Acrnll003JcosyKSQJR+xYCxVHAlhF
 kihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362535; x=1699967335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjVb5feIgOLLxLWvdaFsL34DVmZGoPTAWL8ivwyENP4=;
 b=G2iPKRHtE051wxndlrmT5shPvwcYy0q02H9pdJGzz/dRQZj8Bp4PVg3AnW4FC9onVs
 qRd3TcVKRPV8FzYvjmfCITHTRf//sZ40i8AUq7zJBvy4HaBGL2nEivP2LBsAG4BJxNrQ
 +Gu9oElNTQcIU0AjAeX25yUMWAOL4v+1mAWzajLZVlMGuMCMOxuJguVZWl722hL41l93
 JtxuGJ4VgcZSJNujZX83gGfebDgnjosDGfj4phVE25FFPPc0sfTrXnS5qVl+vQSr4Rrx
 F6/v8f7rQ3iW135L+8rFbOLeYuSAAnWy2/VitIascTtkwSbThXtLVVMYe8gv++hOgNF2
 OmPw==
X-Gm-Message-State: AOJu0YyJX9fLbe1QxvEBd4IRWVzbAAZ57pWIF7zxilU10YypR9WbSqdL
 9KAJlTBcVp5/QUX1DS6MNMl5/+0AuwhMqHg+KbPJsw==
X-Google-Smtp-Source: AGHT+IE0x7nI19tCSGR/NFUCiTcMXvP9doSPDUPPXJK3Dyz86N3JzlBiPkm9nA88akoJ611/PH+M61kxzm/72tQtR7U=
X-Received: by 2002:a50:9fe9:0:b0:543:714b:535d with SMTP id
 c96-20020a509fe9000000b00543714b535dmr18920879edf.3.1699362534602; Tue, 07
 Nov 2023 05:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-6-alex.bennee@linaro.org>
In-Reply-To: <20231106185112.2755262-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 13:08:43 +0000
Message-ID: <CAFEAcA_Za3-xuuw61EgGyK5c8Fgqz=gKkJQUpZANVvkfKWpp2Q@mail.gmail.com>
Subject: Re: [PATCH 05/22] target/arm: hide aliased MIDR from gdbstub
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 6 Nov 2023 at 18:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This is just a constant alias register with the same value as the
> "other" MIDR so it serves no purpose being presented to gdbstub.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-6-alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 104f9378b4..a681bcba62 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8993,7 +8993,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .type =3D ARM_CP_CONST, .resetvalue =3D cpu->revidr },
>          };
>          ARMCPRegInfo id_v8_midr_alias_cp_reginfo =3D {
> -            .name =3D "MIDR", .type =3D ARM_CP_ALIAS | ARM_CP_CONST,
> +            .name =3D "MIDR", .type =3D ARM_CP_ALIAS | ARM_CP_CONST | AR=
M_CP_NO_GDB,
>              .cp =3D 15, .crn =3D 0, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 4=
,
>              .access =3D PL1_R, .resetvalue =3D cpu->midr
>          };

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

It's a bit weird to hide this one but not the alias in
id_v8_midr_cp_reginfo[], though.

If we want to expose all these things to gdb I wonder
if we should have the ARMCPRegInfo give both the AArch64
and the AArch32 names for the registers, so that the
user sees the register names they expect, rather than
having their names be a random mix of the two.

thanks
-- PMM

