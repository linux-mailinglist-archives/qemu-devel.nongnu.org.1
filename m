Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57B73FAC2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6X9-0006DK-Iu; Tue, 27 Jun 2023 07:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6X4-0006CR-19
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:06:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE6X2-0002f9-0V
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:06:49 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso5961932e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687864006; x=1690456006;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XIr1XvfCzAJvHJIWLCGqko6CZtRuEbgIH6LMvnWgE8=;
 b=yxjJJKR7xAKLl3Zz+qSvrUlDtuarnHqIowJ7VEw1LEy0nhiTZIbwf3NryXasf0PqNc
 UsMmtH8aOn66+Y7f8YDpMHLBFn5o8W15Cf6J6ZzBalByMyvQnl9BoFJXdt1dBGGJhyaG
 9QfKon8G0Olsm1ZJ+fEal9dxFVplcMtXZ33rpDoR//OV/ho3vmRXDNMzQWRgQHgkXBjJ
 x77UNVvk578kOQG7F9S4sLloe8enjKezNBG/+MDUjHLj1kCQmuN6m8B4H9O1Oij/HdyU
 6Yk4MxXbURf4UeS+vxT2wArUtFzspr86B93j0z8ANgvZHwowocA74Zzr+Sy2zhE2aMnb
 XJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687864006; x=1690456006;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4XIr1XvfCzAJvHJIWLCGqko6CZtRuEbgIH6LMvnWgE8=;
 b=GAKsADNEAyVbCwipfSfbTi8TbSwJMai1vQveSxK944nDYVlWIYLj62ZG9mr2Gl5lq5
 gcS7EANmyXANM8BjYP1L+zOPAxnsdxJp8mxorLO4VWq5IyA8vj8OZ+NA8ZxcoRwYnbaH
 6MHP0dj0PZumrh1KBLp4WKkolR/eNNvMbm26wSW7rJAbKx3vBMhQM5k5vnsVL+8+602r
 rMTGKsBlpzg2tWaqUX05XHIISwE9VD3e6c8RqYx/D3G0cEl21La1GkSDLKSnlriJ0wI4
 LjTLtJ+NLh421Y3tUoK5TXjYf+/DqAkDcRqtZuBP8gz57Sq56v0zYnStRA6H0Ij84/IF
 i8+w==
X-Gm-Message-State: AC+VfDxB4INnX6eafTDc/QrarH6/ZOjfhGgvs4P+K+Qalx5ky0wypCmG
 nvmkZpyOV1Bffw6hfWR/odd8oK30ckn1vYDe6HM=
X-Google-Smtp-Source: ACHHUZ5vXSmx2c4/D70fjj1OXy3Gri0c6hL0CTJtKGvbWNnpeI+Z4gAlrKPBfaMHDGb8bPxTd6OPLg==
X-Received: by 2002:a05:6512:3ca6:b0:4f9:69e9:4fa6 with SMTP id
 h38-20020a0565123ca600b004f969e94fa6mr10914565lfv.23.1687864006016; 
 Tue, 27 Jun 2023 04:06:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b003f9b66a9376sm13412966wmd.42.2023.06.27.04.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:06:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EA0D1FFBB;
 Tue, 27 Jun 2023 12:06:45 +0100 (BST)
References: <20230623181256.2596-1-dark.ryu.550@gmail.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matheus Branco Borella <dark.ryu.550@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] gdbstub: fixes cases where wrong threads were reported
 to GDB on SIGINT
Date: Tue, 27 Jun 2023 11:39:57 +0100
In-reply-to: <20230623181256.2596-1-dark.ryu.550@gmail.com>
Message-ID: <87y1k5yxiy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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


Matheus Branco Borella <dark.ryu.550@gmail.com> writes:

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725
>
> This fix is implemented by having the vCont handler set the value of
> `gdbserver_state.c_cpu` if any threads are to be resumed. The specific CPU
> is picked arbitrarily from the ones to be resumed, but it should be okay,=
 as all
> GDB cares about is that it is a resumed thread.
>
> Keep in mind that because this patch overwrites `c_cpu`, it breaks cases =
where
> $vCont is used together with $Hc, so there might be more work to be
> done here.

That doesn't sound good. Is that a possible case or an invalid one
because we shouldn't see gdbs using both?

> It might also be the case that it breaking this, specifically, isn't of
> consequence, seeing as single stepping with $vCont already overwrites `c_=
cpu`
> anyway, so you could say the implementation already behaves oddly as far =
as
> mixing $vCont and $Hc is concerned.

It would be nice to have some unit tests for this behaviour to defend
it. See the various tests in tests/tcg that call $(GDB_SCRIPT) for
examples.

BTW you are missing a Signed-off-by: tag which we will need to take a
patch submission. See:

  https://qemu.readthedocs.io/en/latest/devel/submitting-a-patch.html


> ---
>  gdbstub/gdbstub.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index be18568d0a..4f7ac5ddfe 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -595,6 +595,15 @@ static int gdb_handle_vcont(const char *p)
>       *  or incorrect parameters passed.
>       */
>      res =3D 0;
> +=20=20=20=20
> +    /*=20
> +     * target_count and last_target keep track of how many CPUs we are g=
oing to
> +     * step or resume, and a pointer to the state structure of one of th=
em,=20
> +     * respectivelly
> +     */
> +    int target_count =3D 0;
> +    CPUState *last_target =3D NULL;
> +
>      while (*p) {
>          if (*p++ !=3D ';') {
>              res =3D -ENOTSUP;
> @@ -639,8 +648,10 @@ static int gdb_handle_vcont(const char *p)
>              while (cpu) {
>                  if (newstates[cpu->cpu_index] =3D=3D 1) {
>                      newstates[cpu->cpu_index] =3D cur_action;
> -                }
>=20=20
> +                    target_count++;
> +                    last_target =3D cpu;
> +                }
>                  cpu =3D gdb_next_attached_cpu(cpu);
>              }
>              break;
> @@ -657,6 +668,9 @@ static int gdb_handle_vcont(const char *p)
>              while (cpu) {
>                  if (newstates[cpu->cpu_index] =3D=3D 1) {
>                      newstates[cpu->cpu_index] =3D cur_action;
> +=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> +                    target_count++;
> +                    last_target =3D cpu;
>                  }
>=20=20
>                  cpu =3D gdb_next_cpu_in_process(cpu);
> @@ -675,10 +689,25 @@ static int gdb_handle_vcont(const char *p)
>              /* only use if no previous match occourred */
>              if (newstates[cpu->cpu_index] =3D=3D 1) {
>                  newstates[cpu->cpu_index] =3D cur_action;
> +
> +                target_count++;
> +                last_target =3D cpu;
>              }
>              break;
>          }
>      }
> +
> +    /*=20
> +     * if we're about to resume a specific set of CPUs/threads, make it =
so that=20
> +     * in case execution gets interrupted, we can send GDB a stop reply =
with a
> +     * correct value. it doesn't really matter which CPU we tell GDB the=
 signal=20
> +     * happened in (VM pauses stop all of them anyway), so long as it is=
 one of
> +     * the ones we resumed/single stepped here.
> +     */
> +    if (target_count > 0) {
> +        gdbserver_state.c_cpu =3D last_target;
> +    }
> +
>      gdbserver_state.signal =3D signal;
>      gdb_continue_partial(newstates);

Looks reasonable at first glance but I would like some tests.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

