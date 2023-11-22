Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA607F3B45
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 02:26:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5byr-0007Z6-VA; Tue, 21 Nov 2023 20:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5byn-0007YE-S0; Tue, 21 Nov 2023 20:24:37 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5bym-0003Yi-82; Tue, 21 Nov 2023 20:24:37 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-58ceab7daddso617679eaf.3; 
 Tue, 21 Nov 2023 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700616274; x=1701221074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za9Krb7EtNcsfuIYD7sBdWYVNnPqw0lwzQdNqU1pJJg=;
 b=et+ZhzoFWo1+Mu2iimXhQcVdMU/ymk219No62a/FSe5KvmBm/4M5O0PSz6/1cDINys
 SHMD+rc/KFkccON0YEIWpxBPocJGp3DcssuyJ5ua687YnS9MfExHlzGuiau4fBmRqVBj
 ZrFkz5XrWhBKFjKzlMdRIXBXufh9FmSEmShXiqVUlAYT2vz28gj7PPloYhWzZAsWwoqZ
 YN1VHXFs2cumj1SIJBU0K3u9293xKmdPb6JGAXhAC0H3jWCYU6NjDU83nkZukmiruB4j
 n4enbIVXFX21KzdmwaLmXBvpQxzNwkYmYeonztud+QigXMpHrwrSH0CN65RSMfFsS3Zl
 igFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700616274; x=1701221074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=za9Krb7EtNcsfuIYD7sBdWYVNnPqw0lwzQdNqU1pJJg=;
 b=pPfWNkc67TQTlXTmIuMHlyZCCrVwMoHIX/fRulecQO2XK0UYLc6e0wnUrqkc6x46B8
 /q0rEp6a4eVZ0yc/d1lxVECECs5E9Rscpdi9GcOoBZq5bkwIVw0uVmE3i2LknVvh+D2N
 YinoFKaiC+DJxoj8uTxjKjA6/T3NGz/7RAgcBDvw24Uhx6pltxo1UNB3/C/T6jHoYF21
 hMhDSfz0sG9M246IZIC0FTcLZsD6DkBCRKej3Uwc3PmRvIWd3kVk+yCSWq1uCNco8RxO
 gPX7Vbz+LTKOvDUz7ADzB2H6T0uaDxniXxsA3whqqp2OlDiWtyb/CGzUOIxJzqwgtzDZ
 1sOA==
X-Gm-Message-State: AOJu0Yy67svNZCLehfXREKKujj6hSQ8KblrxxV3WrdHRJzMOJZ9i7CM5
 bQo5rISzZ2DIA784pxFqOkZsl5D04Ccc5a7TZpw=
X-Google-Smtp-Source: AGHT+IEH3PD16N9eIRyLoXUrTHvDCWSh+LZw131rVrPiTDwJVa02NBbr9Kfm9A6UKpQu7kF9SnpJWk8xVGAk1znYnto=
X-Received: by 2002:a05:6358:418f:b0:168:e78c:e3a7 with SMTP id
 w15-20020a056358418f00b00168e78ce3a7mr714350rwc.18.1700616274269; Tue, 21 Nov
 2023 17:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
 <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
 <20231120042116-mutt-send-email-mst@kernel.org>
 <9282a606-794a-432c-8b56-fedf6af67768@linaro.org>
 <viiqn6gyn25xitens3ft4mp4lditlcrswstugct42t2kvpw6pi@3ftcrbxmuo3e>
 <CAFXChKKkRRNk72a57xSeJdYtXBss5W7KoEnQqUOVK9_xhc8NfQ@mail.gmail.com>
In-Reply-To: <CAFXChKKkRRNk72a57xSeJdYtXBss5W7KoEnQqUOVK9_xhc8NfQ@mail.gmail.com>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Tue, 21 Nov 2023 19:24:23 -0600
Message-ID: <CAFXChK+OjteJ_rt5G5EWa+wexe8ZzL=8y+Z82mT_r3387h=0RQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dhoff749@gmail.com; helo=mail-oo1-xc2a.google.com
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

From their Discord server in reply to a question about whether such a
patch would be upstreamed: "I suspect this only works in gcc -O0
because of its AST-level "fold", which clang intentionally doesn't
implement. So probably not."

I hope that's enough information to resolve this patch. If any of you
need anything else, please let me know.

On Tue, Nov 21, 2023 at 12:28=E2=80=AFPM Dan Hoffman <dhoff749@gmail.com> w=
rote:
>
> I'm writing a patch to clang's constant folding to address this case
> (doesn't seem too difficult). I'll either follow up with a link to
> some submissions I've made or a bug report on the project describing
> the issue.
>
>
>
> On Tue, Nov 21, 2023 at 10:15=E2=80=AFAM Eric Blake <eblake@redhat.com> w=
rote:
> >
> > On Mon, Nov 20, 2023 at 11:20:52AM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > (Cc'ing Eric)
> > >
> > > On 20/11/23 10:28, Michael S. Tsirkin wrote:
> > > > On Sun, Nov 19, 2023 at 07:34:58PM -0600, Dan Hoffman wrote:
> > > > > As far as I can tell, yes. Any optimization level above O0 does n=
ot have this
> > > > > issue (on this version of Clang, at least)
> > > >
> > > > Aha, this is with -O0. That makes sense.
> > >
> > > But then, why the other cases aren't problematic?
> > >
> > > $ git grep -E ' (&&|\|\|) !?kvm_enabled'
> > > hw/arm/boot.c:1228:    assert(!(info->secure_board_setup && kvm_enabl=
ed()));
> >
> > This one's obvious; no kvm_*() calls in the assert.
> >
> > > hw/i386/microvm.c:270:        (mms->rtc =3D=3D ON_OFF_AUTO_AUTO &&
> > > !kvm_enabled())) {
> >
> > Ones like this require reading context to see whether the if() block
> > guarded any kvm_*() calls for the linker to elide - but still a fairly
> > easy audit.
> >
> > > > >
> > > > >      I'm surprised the order of conditions matters for code elisi=
on...
> > > > >
> > > > >      > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > > > >      > ---
> > > > >      >   hw/i386/x86.c | 15 ++++++++++++---
> > > > >      >   1 file changed, 12 insertions(+), 3 deletions(-)
> > > > >      >
> > > > >      > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > > > >      > index b3d054889bb..2b6291ad8d5 100644
> > > > >      > --- a/hw/i386/x86.c
> > > > >      > +++ b/hw/i386/x86.c
> > > > >      > @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x=
86ms, int
> > > > >      default_cpu_version)
> > > > >      >       /*
> > > > >      >        * Can we support APIC ID 255 or higher?  With KVM, =
that requires
> > > > >      >        * both in-kernel lapic and X2APIC userspace API.
> > > > >      > +     *
> > > > >      > +     * kvm_enabled() must go first to ensure that kvm_* r=
eferences are
> > > > >      > +     * not emitted for the linker to consume (kvm_enabled=
() is
> > > > >      > +     * a literal `0` in configurations where kvm_* aren't=
 defined)
> > > > >      >        */
> > > > >      > -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> > > > >      > +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
> > > > >      >           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic(=
))) {
> >
> > Indeed, if clang -O0 treats 'if (cond1 && 0 && cond2)' differently
> > than 'if (0 && cond1 && cond2)' for purposes of eliding the code for
> > cond2, that seems like a blatant missed optimization that we should be
> > reporting to the clang folks.
> >
> > While this patch may solve the immediate issue, it does not scale - if
> > we ever have two separate guards that can both be independently
> > hard-coded to 0 based on configure-time decisions, but which are both
> > used as guards in the same expression, it will become impossible to
> > avoid a '(cond1 && 0 && cond2)' scenario across all 4 possible
> > configurations of those two guards.
> >
> > I have no objection to the patch, but it would be nice if the commit
> > message could point to a clang bug report, if one has been filed.
> >
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.
> > Virtualization:  qemu.org | libguestfs.org
> >

