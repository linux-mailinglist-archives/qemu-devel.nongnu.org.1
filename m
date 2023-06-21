Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4D737DE3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbP-0001uA-Ts; Wed, 21 Jun 2023 04:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBtbN-0001to-OD
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBtbM-00034o-05
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51a3e6a952aso6813547a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687337645; x=1689929645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vM8YIyESMKhb+DbkG6IkfWnKPU8RjLc9yyayBpyog4M=;
 b=pNk2as+sAygFVMwAhJiZvVUxK27+5cp0ipU/Xw1omnk+56chjBLDyT0MO0KyvOBTyH
 7atCBnwFV4dViJEgufoHC3u/MfXJMFFzvyYxeXRIEd0RGgRbp4EmWQt1VvQZrZJy3q12
 LzJeiH9VUopMQfwR3ak2y+sXDxfw7vK24lSduj1f7TAoy93eLFXFA2TPDPPhKr+nGIwC
 PeMNXHWkpYSuAjA+vxv6qLYp/+GkTO/KKNIkEdZCG726EqQkBlFrob23e0RL9cDF/kY7
 cLwbrmC3M10kjKqXXoRwkI+QiJWzd8F2NQuttZlqbf57W5lGb6xBQzWoMazpFBReUP5l
 WP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687337645; x=1689929645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vM8YIyESMKhb+DbkG6IkfWnKPU8RjLc9yyayBpyog4M=;
 b=IJnzAjCTR0G01Q+kbBSPSGTM7afZFPx2+qw3HpYsPBw4PBuWSzJRtvAocJGYWkEmAG
 GIYR+80NrfM0aPHjZ1vDmLqstWu3QRvd0QPdSRPPuGMfa07xLKq3FjVQTlfF8a06pOiV
 rToDUQwLpyrt7hfc1IiHkynBLjVPnRMr25Ks7a+9B4ucGJ6OK/ZP0BU7TJxbmzVX33Z+
 nH6gC+ru9IH0htd68m853wQ6xEhi7N9GUPPp3T+QS9MPt8waIA8yM4kBN/mJcVSQyXFW
 HkJoFzSmWjtNYcjyO22XnM8sgRr6+y7yuRitK6Fq7JNgMKZX2By9dpnR/BCDi55asbJX
 uWNw==
X-Gm-Message-State: AC+VfDxgQ1YruJ0pcOMimmeykk1tMI6woFkoJpyPWECoGKd2tpXpbHhU
 L6tcSw+oHS248QbwgSzw+yo4gZ+wCyN7qFEzO9ZtMg==
X-Google-Smtp-Source: ACHHUZ6/HMt13QfVsTQthit49v8dSThZG7Q9aA44mkRiZECY2f77mb7SEv4tICkDB7oIirFF38vhVe9r3A2E99j93k0=
X-Received: by 2002:aa7:d9cf:0:b0:516:459d:d913 with SMTP id
 v15-20020aa7d9cf000000b00516459dd913mr10912732eds.37.1687337645630; Wed, 21
 Jun 2023 01:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
 <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
 <87352li6kx.fsf@linaro.org>
In-Reply-To: <87352li6kx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jun 2023 09:53:54 +0100
Message-ID: <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 21 Jun 2023 at 09:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 20 Jun 2023 at 17:56, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> $ make -C build/x86 check-tcg
> >> make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/b=
uild/x86'
> >> [...]
> >>   TEST    munmap-pthread on arm
> >> **
> >> ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
> >> failed: (success)
> >> **
> >> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
> >> failed: (cpu =3D=3D current_cpu)
> >
> > git bisect blames commit d7ee93e2435970:
> >
> >     cputlb: Restrict SavedIOTLB to system emulation
> >
> > I think that commit is not correct, because it means that
> > the size of 'struct CPUState' and also the offset of fields
> > like 'cpu_index' will be different for files which are
> > compile-per-target-for-usermode and files which are
> > compile-once-only. The assert happens here because the
> > code which sets up cpu_index is build-once, but the code
> > in qemu_plugin_vcpu_init_hook() which reads cpu_index is
> > build-per-target and now they don't agree about where in
> > the struct the field is...
>
> Hmm two things from that imply:
>
>   - I suspect the plugin core stuff could be build once (or maybe twice,
>     system and user)

It is already build-once, that's why it goes wrong...

>   - we need to have some guard rails somehow to make sure things don't
>     go out of sync

We do, this is the poison.h stuff. CONFIG_USER_ONLY is a
special case which we don't poison because there would be
too much refactoring required...

-- PMM

