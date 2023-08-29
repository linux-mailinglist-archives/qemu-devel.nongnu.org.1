Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11778CA16
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb266-0001OE-Bo; Tue, 29 Aug 2023 13:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb25f-0001Hy-Al
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:01:21 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb25a-0004gI-TT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:01:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so6170961a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328473; x=1693933273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufmLMVBpklAwhAYCHhvGs3XjWW0imP6z4Wf1zdANu7M=;
 b=nZwLsKXvK9eLrVKPY+RwZHmXRGaoMWS7+eH+PIOt81ftGHhPuocrOf9NmTC91DdwBk
 JcFstLAhoaZuSIdr3hScDKzgSI6nTLFZh4Jj521QbG839ozfqM7QQWvPBRix2PDjXmtW
 70W3rfhclA/3nPyAb1qLZQBjKUJPxCZzM1cE/ZF+AY/ini3Zz5mQcUgTqzFcT5feNZkW
 zpevOwgPkBExqy1af6DzuRwSB8268rYHmogA1hTYIAwV/cvYcJwaVPupfZ4t9j4nLHPd
 yWGQ6NO34pXx+jNlXm+nQ2BJdQ1PXrFn2U8a6aQ2cYM+GGXqn2b6/Xgr9lwH6G1BNINE
 CWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328473; x=1693933273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufmLMVBpklAwhAYCHhvGs3XjWW0imP6z4Wf1zdANu7M=;
 b=dj8sMUl1Y4rH2N+jW4gJUxtofvzFXFi1JMNa+NW0IezLXQZggKnyXgh7q8tm43OYqr
 wDF0ONhs+qHuqi6Qrd+zoY9tEADRBOWewavl3PFGELGM5bzTfuYgl68lKA2iJxaS9xTT
 hUcTtNt3Qtzaah4yxRpqKJQ3+MxPfjyasPH5l+SH1mPCUE+CazTgXH7WZciAdYcKc6sC
 hKMKNQ5ElseNTiSVBWh+efRrtTZA37RpywNiDtPs596ugcjbHGAVKqxzPirUF+FkWOQX
 8H9PWyNASsBr9kyGs9G1jp+s7YszHIzQR3MrRcMQsSci7BjnXrvFshXKlmLcvZSyluUt
 h3NA==
X-Gm-Message-State: AOJu0YyvIVp/EikW3x4HvKFezjCBSFzSE+oLnZG+ShXHx+QLp1M/HXUZ
 7v6Cz6xP2mrA6tLgfoLwbeU1kCGgkpDU/gQWYnQuCw==
X-Google-Smtp-Source: AGHT+IGHBi0XvJvc0Azk9paKZ0bpLN+YHLE611AOBRht9ef2AramAdnKm3xTSDFSW/cVnqbdXiCnYGAa5moXu/PoB1Q=
X-Received: by 2002:aa7:df89:0:b0:525:644f:134b with SMTP id
 b9-20020aa7df89000000b00525644f134bmr22137394edy.25.1693328473403; Tue, 29
 Aug 2023 10:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230829152604.101542-1-pbonzini@redhat.com>
 <20000658-5398-f4d7-0659-1abc248adb84@linaro.org>
 <CABgObfY43KZdtk4BNG53rKUXZznNhRqe1BNd_0Ww5HxrN4VrcA@mail.gmail.com>
In-Reply-To: <CABgObfY43KZdtk4BNG53rKUXZznNhRqe1BNd_0Ww5HxrN4VrcA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 18:01:02 +0100
Message-ID: <CAFEAcA9kFpybEByQi0+ZrcQRC7N2SE3R5u+68KP9n1GNTY4qxA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: raise FERR interrupt with iothread locked
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 29 Aug 2023 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Aug 29, 2023 at 5:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > On 29/8/23 17:25, Paolo Bonzini wrote:
> > > Otherwise tcg_handle_interrupt() triggers an assertion failure:
> > >
> > >    #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=3D0x555557434c=
b0, mask=3D2) at ../accel/tcg/tcg-accel-ops.c:83
> > >    #6  tcg_handle_interrupt (cpu=3D0x555557434cb0, mask=3D2) at ../ac=
cel/tcg/tcg-accel-ops.c:81
> > >    #7  0x0000555555b4d58b in pic_irq_request (opaque=3D<optimized out=
>, irq=3D<optimized out>, level=3D1) at ../hw/i386/x86.c:555
> > >    #8  0x0000555555b4f218 in gsi_handler (opaque=3D0x5555579423d0, n=
=3D13, level=3D1) at ../hw/i386/x86.c:611
> > >    #9  0x00007fffa42bde14 in code_gen_buffer ()
> > >    #10 0x0000555555c724bb in cpu_tb_exec (cpu=3Dcpu@entry=3D0x5555574=
34cb0, itb=3D<optimized out>, tb_exit=3Dtb_exit@entry=3D0x7fffe9bfd658) at =
../accel/tcg/cpu-exec.c:457
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
> > > Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   target/i386/tcg/sysemu/fpu_helper.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sy=
semu/fpu_helper.c
> > > index 1c3610da3b9..fd8cc72a026 100644
> > > --- a/target/i386/tcg/sysemu/fpu_helper.c
> > > +++ b/target/i386/tcg/sysemu/fpu_helper.c
> > > @@ -31,7 +31,9 @@ void x86_register_ferr_irq(qemu_irq irq)
> > >   void fpu_check_raise_ferr_irq(CPUX86State *env)
> > >   {
> > >       if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
> > > +        qemu_mutex_lock_iothread();
> > >           qemu_irq_raise(ferr_irq);
> > > +        qemu_mutex_unlock_iothread();
> > >           return;
> > >       }
> > >   }
> >
> > OK, so:
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Actually Richard has a better (though also slightly incomplete) patch
> in the bug, so I'll send v2.
>
> >   void cpu_set_ignne(void)
> >   {
> >       CPUX86State *env =3D &X86_CPU(first_cpu)->env;
> > +
> > +    g_assert(qemu_mutex_iothread_locked());
>
> qemu_irq_lower() is fine because it doesn't result in a call to
> tcg_handle_interrupt().

It does potentially result in calling code in a device model
that assumes that it is protected by the iothread lock,
though...

-- PMM

