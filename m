Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DB7F35E4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:29:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VUD-0006d4-2D; Tue, 21 Nov 2023 13:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5VUB-0006cj-7G; Tue, 21 Nov 2023 13:28:35 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5VU9-0003OP-IG; Tue, 21 Nov 2023 13:28:34 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4219f89ee21so35004661cf.3; 
 Tue, 21 Nov 2023 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700591312; x=1701196112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtIetbocPPQpNl4lGR3J1iZEPa+0KAqVFOMPUkiLUEk=;
 b=MXxZDoYakjJkuGlQNOH7ZIB+2YFaUEBtcDPaNvGSWpNnWmH5dj7K1gzivwO7cuLaCA
 Nd7iRLmEu+FSvVYDTvuX0LCPAM2zCwjCBU0vCXnDARUElSLcLSMIxz7//G1uG0PZAYfz
 RCzYVj051ESqpR9lNEtDdHAmaMaEuqCbw+Vk1Sb7b41x0XT2q7KoAYQh+VgFkDewTy7O
 Z/IpiCwdqXjbRhkB5ESPj6Mm8eXygIh88JDOfgx320zcGsrfgYUiQclBOqfq4TdEBUxg
 OdHxscPkVuvqRWzTo9xBaRGCbwZJH0vrf5H5mtEQRKm+YX75WxN8FRfCm/0i7nc0I2ay
 0UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591312; x=1701196112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtIetbocPPQpNl4lGR3J1iZEPa+0KAqVFOMPUkiLUEk=;
 b=Zw+0dnN1LRQHlMlHXpsLl5henUaBpGtS9PNAigw/EJoxBJdH7/bnTfuPg0Hpx48Zw9
 Mrvvk96JKQTQk5KiOik+yQhAFyZkybnx6JUzrx/jzdaKD3v1wZPLcin1pTz4xBlw8Yrh
 b4FMmD4uPBOrdrLvbBEH1d+Hu2fUdGEvA95c/VmajleAyuJBOOYGMo5kPxCd9Pvm+gSl
 7eCXA+d7n2AliPPXvE8k3GgLHAXx0WhbyUIe20e4fzPRkMeX1rB3uJYQIc7UQ1iukWZ2
 OXDR2JTW/2slntvz4PZwJxOgRCRtp+GnnokmJMzdL7GXVs9W/IYpwLFb4LC4No6lQaDc
 1Gsw==
X-Gm-Message-State: AOJu0YwQwtP6J2Lz+hcdg/qbIHTR43kaI/8vf1STqkLE1s7oB+eGt5kG
 t5j2Yic7ybG3iv6BZgBgy9vmgNFhCJyadHomoUo=
X-Google-Smtp-Source: AGHT+IFgz0o1fOhiZT+aDri0YDzsqXnGOjSJAH1sJkBYIdi8Eidy1W++uKOEM3mjqIz67wUl9/aoRH5gcQnk9sQCrZ4=
X-Received: by 2002:ac8:7201:0:b0:423:7326:515f with SMTP id
 a1-20020ac87201000000b004237326515fmr1888218qtp.11.1700591312023; Tue, 21 Nov
 2023 10:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
 <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
 <20231120042116-mutt-send-email-mst@kernel.org>
 <9282a606-794a-432c-8b56-fedf6af67768@linaro.org>
 <viiqn6gyn25xitens3ft4mp4lditlcrswstugct42t2kvpw6pi@3ftcrbxmuo3e>
In-Reply-To: <viiqn6gyn25xitens3ft4mp4lditlcrswstugct42t2kvpw6pi@3ftcrbxmuo3e>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Tue, 21 Nov 2023 12:28:22 -0600
Message-ID: <CAFXChKKkRRNk72a57xSeJdYtXBss5W7KoEnQqUOVK9_xhc8NfQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=dhoff749@gmail.com; helo=mail-qt1-x82a.google.com
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

I'm writing a patch to clang's constant folding to address this case
(doesn't seem too difficult). I'll either follow up with a link to
some submissions I've made or a bug report on the project describing
the issue.



On Tue, Nov 21, 2023 at 10:15=E2=80=AFAM Eric Blake <eblake@redhat.com> wro=
te:
>
> On Mon, Nov 20, 2023 at 11:20:52AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > (Cc'ing Eric)
> >
> > On 20/11/23 10:28, Michael S. Tsirkin wrote:
> > > On Sun, Nov 19, 2023 at 07:34:58PM -0600, Dan Hoffman wrote:
> > > > As far as I can tell, yes. Any optimization level above O0 does not=
 have this
> > > > issue (on this version of Clang, at least)
> > >
> > > Aha, this is with -O0. That makes sense.
> >
> > But then, why the other cases aren't problematic?
> >
> > $ git grep -E ' (&&|\|\|) !?kvm_enabled'
> > hw/arm/boot.c:1228:    assert(!(info->secure_board_setup && kvm_enabled=
()));
>
> This one's obvious; no kvm_*() calls in the assert.
>
> > hw/i386/microvm.c:270:        (mms->rtc =3D=3D ON_OFF_AUTO_AUTO &&
> > !kvm_enabled())) {
>
> Ones like this require reading context to see whether the if() block
> guarded any kvm_*() calls for the linker to elide - but still a fairly
> easy audit.
>
> > > >
> > > >      I'm surprised the order of conditions matters for code elision=
...
> > > >
> > > >      > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > > >      > ---
> > > >      >   hw/i386/x86.c | 15 ++++++++++++---
> > > >      >   1 file changed, 12 insertions(+), 3 deletions(-)
> > > >      >
> > > >      > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > > >      > index b3d054889bb..2b6291ad8d5 100644
> > > >      > --- a/hw/i386/x86.c
> > > >      > +++ b/hw/i386/x86.c
> > > >      > @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86=
ms, int
> > > >      default_cpu_version)
> > > >      >       /*
> > > >      >        * Can we support APIC ID 255 or higher?  With KVM, th=
at requires
> > > >      >        * both in-kernel lapic and X2APIC userspace API.
> > > >      > +     *
> > > >      > +     * kvm_enabled() must go first to ensure that kvm_* ref=
erences are
> > > >      > +     * not emitted for the linker to consume (kvm_enabled()=
 is
> > > >      > +     * a literal `0` in configurations where kvm_* aren't d=
efined)
> > > >      >        */
> > > >      > -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> > > >      > +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
> > > >      >           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())=
) {
>
> Indeed, if clang -O0 treats 'if (cond1 && 0 && cond2)' differently
> than 'if (0 && cond1 && cond2)' for purposes of eliding the code for
> cond2, that seems like a blatant missed optimization that we should be
> reporting to the clang folks.
>
> While this patch may solve the immediate issue, it does not scale - if
> we ever have two separate guards that can both be independently
> hard-coded to 0 based on configure-time decisions, but which are both
> used as guards in the same expression, it will become impossible to
> avoid a '(cond1 && 0 && cond2)' scenario across all 4 possible
> configurations of those two guards.
>
> I have no objection to the patch, but it would be nice if the commit
> message could point to a clang bug report, if one has been filed.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>

