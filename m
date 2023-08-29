Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007D78CA0B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb22w-0007KY-Di; Tue, 29 Aug 2023 12:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb22t-0007Eg-SX
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb22p-0003xm-NJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693328301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuE9+IQwVbjOsCvU357yCcBFg9sppyfRV7vfzSmviTY=;
 b=UnPCRsU1SxN3j9E28ctsJ7SEFzuWnXAtRdrmfJkesJKLsRRSDJw8jxlRQGCXeo4+MiQRvN
 poMvz8iZ3UC1vYcmiQzyvZyzAv9RfdmFoOAxY93MCoixw7JYsqcqo08Rt83nCkv0AFA51J
 20H3d3Fvb5FBcSYh9wddZeoKk4R7O8o=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-tCUjy3DVNTqD1mvgdVgqVQ-1; Tue, 29 Aug 2023 12:58:19 -0400
X-MC-Unique: tCUjy3DVNTqD1mvgdVgqVQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44ea3b36cb9so2004976137.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328299; x=1693933099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuE9+IQwVbjOsCvU357yCcBFg9sppyfRV7vfzSmviTY=;
 b=WTcVELToOsO5iCuIf9z3fZUugz0ANPRYJO7uvA3IrQKwQSIFdGXa5jKl7kSnHKTC1D
 qfTFMomw/g8Tdg7vUb5WlXWxYoiwLHha/lWFHdbEN02UlI9pBm5V43hfDVfwqitmwXfm
 BRZiPyQPD97uzEdvYpp7ACZwk/nMKRukf5AV8qdB6vv8m/4PiecrZleG/myHAszD39kT
 uBYr7TmLGJ3yczaP2WjUn3rxGTN0mayKtz+5qvBWCCynVwwhE2aonP91lGua0h0QjBI3
 W5M/cv7qq0GHXe2fCn1VxMigRiF7OtCkM3UGqR7+avyrBxFGeLvCUg48VJtPz6ce0spJ
 OVPA==
X-Gm-Message-State: AOJu0YzOu49MNDJpxy+bIq6e++agA6nBn8RUpZwSw+LxhR6iFfgrRocY
 pi9KtFCMxjPgd8I3nqmf+OnwgC7yk8vScVm9fhTAicg3Kka+6/hcBANasWefG5yvJKryQPQPDsH
 eZGSOTtONTWO2M1vGHa3Wt0rRWSylZw4=
X-Received: by 2002:a05:6102:d3:b0:44e:8ef9:3371 with SMTP id
 u19-20020a05610200d300b0044e8ef93371mr15031825vsp.8.1693328298892; 
 Tue, 29 Aug 2023 09:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgFBU8lxyB4a6jkcZE8LJjvobbScDRo5ZHOfl3LQ9Itu4IX/kR14GvYu18nUkadKo0maJt6ywwH+Bd/uvjEO8=
X-Received: by 2002:a05:6102:d3:b0:44e:8ef9:3371 with SMTP id
 u19-20020a05610200d300b0044e8ef93371mr15031811vsp.8.1693328298614; Tue, 29
 Aug 2023 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829152604.101542-1-pbonzini@redhat.com>
 <20000658-5398-f4d7-0659-1abc248adb84@linaro.org>
In-Reply-To: <20000658-5398-f4d7-0659-1abc248adb84@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Aug 2023 18:58:07 +0200
Message-ID: <CABgObfY43KZdtk4BNG53rKUXZznNhRqe1BNd_0Ww5HxrN4VrcA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: raise FERR interrupt with iothread locked
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 5:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 29/8/23 17:25, Paolo Bonzini wrote:
> > Otherwise tcg_handle_interrupt() triggers an assertion failure:
> >
> >    #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=3D0x555557434cb0=
, mask=3D2) at ../accel/tcg/tcg-accel-ops.c:83
> >    #6  tcg_handle_interrupt (cpu=3D0x555557434cb0, mask=3D2) at ../acce=
l/tcg/tcg-accel-ops.c:81
> >    #7  0x0000555555b4d58b in pic_irq_request (opaque=3D<optimized out>,=
 irq=3D<optimized out>, level=3D1) at ../hw/i386/x86.c:555
> >    #8  0x0000555555b4f218 in gsi_handler (opaque=3D0x5555579423d0, n=3D=
13, level=3D1) at ../hw/i386/x86.c:611
> >    #9  0x00007fffa42bde14 in code_gen_buffer ()
> >    #10 0x0000555555c724bb in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557434=
cb0, itb=3D<optimized out>, tb_exit=3Dtb_exit@entry=3D0x7fffe9bfd658) at ..=
/accel/tcg/cpu-exec.c:457
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
> > Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/sysemu/fpu_helper.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/syse=
mu/fpu_helper.c
> > index 1c3610da3b9..fd8cc72a026 100644
> > --- a/target/i386/tcg/sysemu/fpu_helper.c
> > +++ b/target/i386/tcg/sysemu/fpu_helper.c
> > @@ -31,7 +31,9 @@ void x86_register_ferr_irq(qemu_irq irq)
> >   void fpu_check_raise_ferr_irq(CPUX86State *env)
> >   {
> >       if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
> > +        qemu_mutex_lock_iothread();
> >           qemu_irq_raise(ferr_irq);
> > +        qemu_mutex_unlock_iothread();
> >           return;
> >       }
> >   }
>
> OK, so:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Actually Richard has a better (though also slightly incomplete) patch
in the bug, so I'll send v2.

>   void cpu_set_ignne(void)
>   {
>       CPUX86State *env =3D &X86_CPU(first_cpu)->env;
> +
> +    g_assert(qemu_mutex_iothread_locked());

qemu_irq_lower() is fine because it doesn't result in a call to
tcg_handle_interrupt().

Paolo

> Somehow similar pattern so what about MIPS MTC0?:
>
> mtc0_compare() ->
>    helper_mtc0_compare() ->
>      cpu_mips_store_compare() ->
>        qemu_irq_lower()

Lower is a bit safer


