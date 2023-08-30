Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9153178D48E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHPG-0007CG-OQ; Wed, 30 Aug 2023 05:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qbHPE-0007Bh-F3
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qbHPA-0006PU-QR
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693387347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSDD31EBMVPdEHUF6VuRlId38qiFuuK3yXUrZuyb/Oo=;
 b=AMikOhp9TXI7W/lx+eQAdmyT8Rxn/mRQgvww3q5NAQG0MuNsAYiEZNkjd964enYwZZ3YMs
 nZvr4V+gd4P56zfcQ0B8qRIY7rlBY3NA1CbOAOKVy1lfD+6xa/FGOYJSIVFgO0qwt/NLou
 wyHh05ZMVJfpL1YWxSRIbMfIDyXblcU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-_NRFVKrnP4qIJHVKIjf8AQ-1; Wed, 30 Aug 2023 05:22:25 -0400
X-MC-Unique: _NRFVKrnP4qIJHVKIjf8AQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso4232635a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693387344; x=1693992144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSDD31EBMVPdEHUF6VuRlId38qiFuuK3yXUrZuyb/Oo=;
 b=BXHsH+5Neh2W8bUCC5NzkLDjDKtDa3eLaoPlTCXiVtyiQQQcksMQpcKryGqcZ9XGmd
 dXHIHWImEi3BBYpJaniEBxfrRj93FIUKy9T7MfjRxDa1RDc4inLrvFuVacar4G0L4fc2
 5LSGRwjW4bwRUImqugnaXJ1GaiLn1sMEH3xkX4gHE9aOnmKt4aEbcfKgKQhjZOqesoe6
 Nz5VZmcK6B0G/tO/cW7U9WL4fRWw02nnZNDL2rSf058eapel1FadpMCy2LOKSMomwAOB
 ays67p+uuAa3qtwdT9qig2u2C+mtvXdN0b0qdFIbn+7z0lHzwLUqKg929JSmmnitn6tm
 FRQQ==
X-Gm-Message-State: AOJu0YwtyU5qVrAPHP57hken8YM09Zebi6k1h3qbv19bls/ruhTSHFVZ
 9VtDGVkqQxrxLKrdnjEw+/nqVz05n6cvdv7FYLW24Bi4fQu4N2EA93XcgnTf5R0GyvKn9h2PIAt
 LyNdq4hn+IJsg084=
X-Received: by 2002:a05:6402:34b:b0:523:1410:b611 with SMTP id
 r11-20020a056402034b00b005231410b611mr1342216edw.25.1693387343877; 
 Wed, 30 Aug 2023 02:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHUQ43h8rxK8djEtQwMLKPdPKGj51HIKpSllneDMUYMZpAj8TlLLbrHOPqWcGCV38oUu7Gdw==
X-Received: by 2002:a05:6402:34b:b0:523:1410:b611 with SMTP id
 r11-20020a056402034b00b005231410b611mr1342205edw.25.1693387343434; 
 Wed, 30 Aug 2023 02:22:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 o8-20020aa7c508000000b00523d2a1626esm6566868edq.6.2023.08.30.02.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 02:22:22 -0700 (PDT)
Date: Wed, 30 Aug 2023 11:22:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Annie.li" <annie.li@oracle.com>
Cc: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org, Eduardo Habkost
 <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
Message-ID: <20230830112221.4f102eac@imammedo.users.ipa.redhat.com>
In-Reply-To: <0050d9bc-f5b3-b8eb-9bc8-6a42e25bf618@oracle.com>
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
 <20170720165957.743ccf1a@nial.brq.redhat.com>
 <1a70f9be-e3ca-7311-a078-f55fe56ad0f3@oracle.com>
 <20210920095316.2dd133be@redhat.com>
 <8581b04d-5e9d-33e6-7918-d5f771dd2836@oracle.com>
 <20230714160419.5c2e1567@imammedo.users.ipa.redhat.com>
 <0050d9bc-f5b3-b8eb-9bc8-6a42e25bf618@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 1 Aug 2023 13:00:02 -0400
"Annie.li" <annie.li@oracle.com> wrote:

> Hi Igor,
>=20
> On 7/14/2023 10:04 AM, Igor Mammedov wrote:
> > On Fri, 7 Jul 2023 13:43:36 -0400
> > "Annie.li" <annie.li@oracle.com> wrote:
> > =20
> >> Hi Igor,
> >>
> >> Revisiting this thread and have more questions, please clarify, thank =
you!
> >>
> >> On 9/20/2021 3:53 AM, Igor Mammedov wrote: =20
> >>> On Fri, 6 Aug 2021 16:18:09 -0400
> >>> "Annie.li" <annie.li@oracle.com> wrote:
> >>>    =20
> >>>> Hello Igor,
> >>>>
> >>>> This is an old patch, but it does what we need.
> >>>> I am getting a little bit lost about not implementing fixed hardware
> >>>> sleep button, can you please clarify? thank you!
> >>>>
> >>>> On 7/20/2017 10:59 AM, Igor Mammedov wrote: =20
> >>>>> On Thu, 20 Jul 2017 11:31:26 +0200
> >>>>> Stefan Fritsch <sf@sfritsch.de> wrote:
> >>>>>       =20
> >>>>>> From: Stefan Fritsch <stefan_fritsch@genua.de>
> >>>>>>
> >>>>>> Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sl=
eep
> >>>>>> button is a so called "fixed hardware feature", which makes it more
> >>>>>> suitable for putting the system to sleep than a laptop lid, for ex=
ample.
> >>>>>>
> >>>>>> The sleep button is disabled by default (Bit 5 in the FACP flags
> >>>>>> register set and no button "device" present in SSDT/DSDT). Clearin=
g said
> >>>>>> bit enables it as a fixed feature device. =20
> >>>>> per spec sleep button is used for both putting system into
> >>>>> sleep and for waking it up.
> >>>>>
> >>>>> Reusing system_wakeup 'button' to behave as per spec would
> >>>>> make this patch significantly smaller. =20
> >> Current 'system_wakeup' sets the WAK_STS bit and PWRBTN_STS to wake up
> >> the system, the system_wakeup 'button' is the power button. So(Correct=
 me
> >> if I am wrong) reusing the system_wakeup 'button' means reusing the po=
wer
> >> button for sleep. See the following code of setting WAK_STS and PWRBTN=
_STS
> >> for 'system_wakeup',
> >>   =C2=A0=C2=A0=C2=A0 case QEMU_WAKEUP_REASON_OTHER:
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ACPI_BITMASK_WAKE_STAT=
US should be set on resume.
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pretend=
 that resume was caused by power button */
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ar->pm1.evt.sts |=3D
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_POWER_BUTTON_STATUS); =20
> > (that's quite ancient code (0bacd1300d) and I couldn't find a reason why
> > power button was chosen.
> >   https://urldefense.com/v3/__https://www.mail-archive.com/kvm@vger.ker=
nel.org/msg05742.html__;!!ACWV5N9M2RV99hQ!PQp9_UyWYc4gTuTwNUiyPgE0Xwinlsi8F=
-J6zWOA8KRLUh0EIv68g01XQQrFzKipeZbe-vhHfpGZBb0$
> > that was tested with WinXP so would be wise to check if SLEEP button
> > works there. (though I'm not sure if we still care for XP being runnabl=
e on QEMU)
> > ) =20
>=20
> don't have WinXP at hand to check for now...
> Microsoft has ended the WinXP support since Apr 8, 2014.
> If someone is still running WinXP, not sure if they care about
> the sleep button.

the only thing I care here is not regressing current state.
I can test WnXP and RHEL6 for you=20

> >
> > it doesn't have to be ACPI_BITMASK_POWER_BUTTON_STATUS,
> > you can convert it to sleep button by using ACPI_BITMASK_SLEEP_BUTTON_S=
TATUS.
> > However you'll have to enable sleep button (which is disabled currently)
> > in FADT (ACPI_FADT_F_SLP_BUTTON), for guest to see the button. =20
> Agree
> Per ACPI spec, SLPBTN_STS -
>=20
> "This optional bit is set when the sleep button is pressed. In the system
> working state, while SLPBTN_EN and SLPBTN_STS are both set, an
> interrupt event is raised. In the sleep or soft-off states a wake event is
> generated when the sleeping button is pressed and the SLPBTN_EN bit
> is set."
>=20
> Using ACPI_BITMASK_SLEEP_BUTTON_STATUS means qemu ends up with
> supporting the sleep button.=C2=A0 With this, implementing the fixed
> hardware sleep button(what this patch does) is one option. The interesting
> topic is whether it should be implemented as General Control sleep button
> or fixed hardware button.
>=20
> > =20
> >>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >>
> >> Per the ACPI spec, the power button can be used in single button model=
, i.e.
> >> it can be used to either shut down the system or put the system into s=
leep.
> >> However, this depends on the software policy and user's setting of the
> >> system.
> >> Sleep/shutdown can not be done through the power button in the same
> >> scenario.
> >> If the system has configured pressing the power button to put the syst=
em
> >> into sleep,
> >> system_sleep will put the system into sleep state through the power
> >> button, as well
> >> as system_powerdown. Pressing the power button will not shut down the
> >> system.
> >> In this case, system_powerdown has its own issue, but this is different
> >> story and
> >> let's just focus on things related to system_sleep here. =20
> > regardless of what button is used OSPM is free to enable or disable it
> > using FOO_EN bits. =20
>=20
> Nod
> The system_powerdown issue I mentioned above is -
> If the guest is configured to go into sleep when the power button is
> pressed, system_powerdown will trigger the guest to go into sleep state.
> However, system_wakeup won't be able to wake up the guest in such case.
> Looks the current qemu doesn't handle this scenario properly.
> >>>> About reusing "system_wakeup", does it mean the following?
> >>>>
> >>>> 1. when guest is in sleep state, "system_wakeup" wakes up the guest
> >>>> 2. when guest is running, "system_wakeup" puts the guest into sleep =
=20
> >>> yes,  it could be something like this
> >>>
> >>>    =20
> >>>> "system_wakeup" sets WAK_STS and then system transitions to the
> >>>> working state. Correspondingly, I suppose both SLPBTN_STS and
> >>>> SLPBTN_EN need to be set for sleeping, and this is what fixed
> >>>> hardware sleep button requires? =20
> >>> yep
> >>>       =20
> >>>> I have combined the sleep and wakeup together, share the
> >>>> code between. But Xen also registers the wakeup notifier, and
> >>>> this makes things more complicated if this notifier is shared
> >>>> between sleep and wakeup. Or this is my misunderstanding?
> >>>> please correct me if I am wrong. =20
> >>> you'd have to fixup xen notifier to handle that
> >>>       =20
> >>>>> If you like idea of separate command/button better, then
> >>>>> I'd go generic control sleep button way instead of fixed
> >>>>> hardware, it would allow us to reuse most of the code in
> >>>>> ARM target, plus I'd avoid notifiers and use acpi device
> >>>>> lookup instead (see: qmp_query_acpi_ospm_status as example) =20
> >     =20
> >> Implementing the generic control sleep button for x86 does align
> >> to the generic control power button implementation in ARM, but
> >> it doesn't align to the current fixed hardware power button for x86.
> >> Should sleep button be implemented as generic control sleep button
> >> to reuse code in ARM or fixed hardware button to align to the fixed
> >> power button for x86? =20
> > sleep control button device was present in ACPI 1.0b so it might be
> > supported by x86 as well (one just need to test it with ancient OS
> > to find out if it were implemented. (WinXP,Vista,some ancient linux...)=
) =20
>=20
> If qemu needs to cover the ancient OS, isn't the fixed sleep hardware
> button more appropriate?

As long as using control method approach doesn't break anything it
should be fine.

> How about qemu uses fixed sleep button for x86(just like what this
> patch does), and share the sleep button for between wake-up and sleep?

Fixed HW button is not supported on HW reduced platforms (arm/virt, microvm=
), so
I'd try control method way 1st (so it could be reused there as well)
and only if that doesn't work out would fallback to fixed hw approach.

PS:
only instead of introducing new system_sleep, I'd suggest to reuse
existing system_wakeup.


> The power button has been implemented as fixed hardware button for x86.

> Thanks
> Annie
>=20
> >>>>>       =20
> >>>> Do you mean the "Control Method Sleep Button" that needs to
> >>>> notify OSPM by event indication 0x80? =20
> >>> yes, in addition to virt-arm machine it could be reused by
> >>> microvm which also uses 'reduced hardware' acpi model
> >>> (i.e. it lacks fixed hardware registers like virt-arm does)
> >>>
> >>> maybe while adding button to pc/q35 you can look into adding
> >>> it to microvm and virt-arm at the same time (should be trivial
> >>> on top of pc/q35 support).
> >>>    =20
> >>>> Thanks
> >>>> Annie =20
> >>>>>> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> >>>>>> ---
> >>>>>>     hmp-commands.hx         | 16 ++++++++++++++++
> >>>>>>     hmp.c                   |  5 +++++
> >>>>>>     hmp.h                   |  1 +
> >>>>>>     hw/acpi/core.c          |  8 ++++++++
> >>>>>>     hw/acpi/ich9.c          | 10 ++++++++++
> >>>>>>     hw/acpi/piix4.c         | 12 ++++++++++++
> >>>>>>     hw/i386/acpi-build.c    |  1 -
> >>>>>>     include/hw/acpi/acpi.h  |  2 ++
> >>>>>>     include/hw/acpi/ich9.h  |  1 +
> >>>>>>     include/sysemu/sysemu.h |  2 ++
> >>>>>>     qapi-schema.json        | 12 ++++++++++++
> >>>>>>     qmp.c                   |  5 +++++
> >>>>>>     tests/test-hmp.c        |  1 +
> >>>>>>     vl.c                    | 29 +++++++++++++++++++++++++++++
> >>>>>>     14 files changed, 104 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
> >>>>>> index 1941e19932..8ba4380883 100644
> >>>>>> --- a/hmp-commands.hx
> >>>>>> +++ b/hmp-commands.hx
> >>>>>> @@ -638,6 +638,22 @@ Reset the system.
> >>>>>>     ETEXI
> >>>>>>    =20
> >>>>>>         {
> >>>>>> +        .name       =3D "system_sleep",
> >>>>>> +        .args_type  =3D "",
> >>>>>> +        .params     =3D "",
> >>>>>> +        .help       =3D "send ACPI sleep event",
> >>>>>> +        .cmd =3D hmp_system_sleep,
> >>>>>> +    },
> >>>>>> +
> >>>>>> +STEXI
> >>>>>> +@item system_sleep
> >>>>>> +@findex system_sleep
> >>>>>> +
> >>>>>> +Push the virtual sleep button; if supported the system will enter
> >>>>>> +an ACPI sleep state.
> >>>>>> +ETEXI
> >>>>>> +
> >>>>>> +    {
> >>>>>>             .name       =3D "system_powerdown",
> >>>>>>             .args_type  =3D "",
> >>>>>>             .params     =3D "",
> >>>>>> diff --git a/hmp.c b/hmp.c
> >>>>>> index bf1de747d5..b4b584016c 100644
> >>>>>> --- a/hmp.c
> >>>>>> +++ b/hmp.c
> >>>>>> @@ -1047,6 +1047,11 @@ void hmp_system_reset(Monitor *mon, const Q=
Dict *qdict)
> >>>>>>         qmp_system_reset(NULL);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
> >>>>>> +{
> >>>>>> +    qmp_system_sleep(NULL);
> >>>>>> +}
> >>>>>> +
> >>>>>>     void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
> >>>>>>     {
> >>>>>>         qmp_system_powerdown(NULL);
> >>>>>> diff --git a/hmp.h b/hmp.h
> >>>>>> index 1ff455295e..15b53de9ed 100644
> >>>>>> --- a/hmp.h
> >>>>>> +++ b/hmp.h
> >>>>>> @@ -45,6 +45,7 @@ void hmp_info_iothreads(Monitor *mon, const QDic=
t *qdict);
> >>>>>>     void hmp_quit(Monitor *mon, const QDict *qdict);
> >>>>>>     void hmp_stop(Monitor *mon, const QDict *qdict);
> >>>>>>     void hmp_system_reset(Monitor *mon, const QDict *qdict);
> >>>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
> >>>>>>     void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
> >>>>>>     void hmp_cpu(Monitor *mon, const QDict *qdict);
> >>>>>>     void hmp_memsave(Monitor *mon, const QDict *qdict);
> >>>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> >>>>>> index 95fcac95a2..2ee64b6878 100644
> >>>>>> --- a/hw/acpi/core.c
> >>>>>> +++ b/hw/acpi/core.c
> >>>>>> @@ -422,6 +422,14 @@ void acpi_pm1_evt_power_down(ACPIREGS *ar)
> >>>>>>         }
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar)
> >>>>>> +{
> >>>>>> +    if (ar->pm1.evt.en & ACPI_BITMASK_SLEEP_BUTTON_ENABLE) {
> >>>>>> +        ar->pm1.evt.sts |=3D ACPI_BITMASK_SLEEP_BUTTON_STATUS;
> >>>>>> +        ar->tmr.update_sci(ar);
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>>     void acpi_pm1_evt_reset(ACPIREGS *ar)
> >>>>>>     {
> >>>>>>         ar->pm1.evt.sts =3D 0;
> >>>>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> >>>>>> index c5d8646abc..3faeab4d2e 100644
> >>>>>> --- a/hw/acpi/ich9.c
> >>>>>> +++ b/hw/acpi/ich9.c
> >>>>>> @@ -260,6 +260,14 @@ static void pm_reset(void *opaque)
> >>>>>>         acpi_update_sci(&pm->acpi_regs, pm->irq);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +static void pm_sleep_req(Notifier *n, void *opaque)
> >>>>>> +{
> >>>>>> +    ICH9LPCPMRegs *pm =3D container_of(n, ICH9LPCPMRegs, sleep_no=
tifier);
> >>>>>> +
> >>>>>> +    acpi_pm1_evt_sleep(&pm->acpi_regs);
> >>>>>> +}
> >>>>>> +
> >>>>>> +
> >>>>>>     static void pm_powerdown_req(Notifier *n, void *opaque)
> >>>>>>     {
> >>>>>>         ICH9LPCPMRegs *pm =3D container_of(n, ICH9LPCPMRegs, power=
down_notifier);
> >>>>>> @@ -299,6 +307,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCP=
MRegs *pm,
> >>>>>>         qemu_register_reset(pm_reset, pm);
> >>>>>>         pm->powerdown_notifier.notify =3D pm_powerdown_req;
> >>>>>>         qemu_register_powerdown_notifier(&pm->powerdown_notifier);
> >>>>>> +    pm->sleep_notifier.notify =3D pm_sleep_req;
> >>>>>> +    qemu_register_sleep_notifier(&pm->sleep_notifier);
> >>>>>>    =20
> >>>>>>         legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
> >>>>>>             OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BAS=
E);
> >>>>>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >>>>>> index f276967365..15e20976c3 100644
> >>>>>> --- a/hw/acpi/piix4.c
> >>>>>> +++ b/hw/acpi/piix4.c
> >>>>>> @@ -79,6 +79,7 @@ typedef struct PIIX4PMState {
> >>>>>>         int smm_enabled;
> >>>>>>         Notifier machine_ready;
> >>>>>>         Notifier powerdown_notifier;
> >>>>>> +    Notifier sleep_notifier;
> >>>>>>    =20
> >>>>>>         AcpiPciHpState acpi_pci_hotplug;
> >>>>>>         bool use_acpi_pci_hotplug;
> >>>>>> @@ -371,6 +372,15 @@ static void piix4_pm_powerdown_req(Notifier *=
n, void *opaque)
> >>>>>>         acpi_pm1_evt_power_down(&s->ar);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +static void piix4_pm_sleep_req(Notifier *n, void *opaque)
> >>>>>> +{
> >>>>>> +    PIIX4PMState *s =3D container_of(n, PIIX4PMState, sleep_notif=
ier);
> >>>>>> +
> >>>>>> +    assert(s !=3D NULL);
> >>>>>> +    acpi_pm1_evt_sleep(&s->ar);
> >>>>>> +}
> >>>>>> +
> >>>>>> +
> >>>>>>     static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
> >>>>>>                                      DeviceState *dev, Error **err=
p)
> >>>>>>     {
> >>>>>> @@ -535,6 +545,8 @@ static void piix4_pm_realize(PCIDevice *dev, E=
rror **errp)
> >>>>>>    =20
> >>>>>>         s->powerdown_notifier.notify =3D piix4_pm_powerdown_req;
> >>>>>>         qemu_register_powerdown_notifier(&s->powerdown_notifier);
> >>>>>> +    s->sleep_notifier.notify =3D piix4_pm_sleep_req;
> >>>>>> +    qemu_register_sleep_notifier(&s->sleep_notifier);
> >>>>>>    =20
> >>>>>>         s->machine_ready.notify =3D piix4_pm_machine_ready;
> >>>>>>         qemu_add_machine_init_done_notifier(&s->machine_ready);
> >>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >>>>>> index 6b7bade183..06b28dacfe 100644
> >>>>>> --- a/hw/i386/acpi-build.c
> >>>>>> +++ b/hw/i386/acpi-build.c
> >>>>>> @@ -294,7 +294,6 @@ static void fadt_setup(AcpiFadtDescriptorRev3 =
*fadt, AcpiPmInfo *pm)
> >>>>>>         fadt->plvl3_lat =3D cpu_to_le16(0xfff); /* C3 state not su=
pported */
> >>>>>>         fadt->flags =3D cpu_to_le32((1 << ACPI_FADT_F_WBINVD) |
> >>>>>>                                   (1 << ACPI_FADT_F_PROC_C1) |
> >>>>>> -                              (1 << ACPI_FADT_F_SLP_BUTTON) |
> >>>>>>                                   (1 << ACPI_FADT_F_RTC_S4));
> >>>>>>         fadt->flags |=3D cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM=
_CLOCK);
> >>>>>>         /* APIC destination mode ("Flat Logical") has an upper lim=
it of 8 CPUs
> >>>>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> >>>>>> index 7b3d93cf0d..51cf901ef6 100644
> >>>>>> --- a/include/hw/acpi/acpi.h
> >>>>>> +++ b/include/hw/acpi/acpi.h
> >>>>>> @@ -78,6 +78,7 @@
> >>>>>>     #define ACPI_BITMASK_PM1_COMMON_ENABLED         ( \
> >>>>>>             ACPI_BITMASK_RT_CLOCK_ENABLE        | \
> >>>>>>             ACPI_BITMASK_POWER_BUTTON_ENABLE    | \
> >>>>>> +        ACPI_BITMASK_SLEEP_BUTTON_ENABLE    | \
> >>>>>>             ACPI_BITMASK_GLOBAL_LOCK_ENABLE     | \
> >>>>>>             ACPI_BITMASK_TIMER_ENABLE)
> >>>>>>    =20
> >>>>>> @@ -148,6 +149,7 @@ void acpi_pm_tmr_reset(ACPIREGS *ar);
> >>>>>>     /* PM1a_EVT: piix and ich9 don't implement PM1b. */
> >>>>>>     uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar);
> >>>>>>     void acpi_pm1_evt_power_down(ACPIREGS *ar);
> >>>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar);
> >>>>>>     void acpi_pm1_evt_reset(ACPIREGS *ar);
> >>>>>>     void acpi_pm1_evt_init(ACPIREGS *ar, acpi_update_sci_fn update=
_sci,
> >>>>>>                            MemoryRegion *parent);
> >>>>>> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> >>>>>> index a352c94fde..2073eec168 100644
> >>>>>> --- a/include/hw/acpi/ich9.h
> >>>>>> +++ b/include/hw/acpi/ich9.h
> >>>>>> @@ -48,6 +48,7 @@ typedef struct ICH9LPCPMRegs {
> >>>>>>    =20
> >>>>>>         uint32_t pm_io_base;
> >>>>>>         Notifier powerdown_notifier;
> >>>>>> +    Notifier sleep_notifier;
> >>>>>>    =20
> >>>>>>         bool cpu_hotplug_legacy;
> >>>>>>         AcpiCpuHotplug gpe_cpu;
> >>>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> >>>>>> index b21369672a..00f54653dc 100644
> >>>>>> --- a/include/sysemu/sysemu.h
> >>>>>> +++ b/include/sysemu/sysemu.h
> >>>>>> @@ -75,6 +75,8 @@ void qemu_register_wakeup_notifier(Notifier *not=
ifier);
> >>>>>>     void qemu_system_shutdown_request(ShutdownCause reason);
> >>>>>>     void qemu_system_powerdown_request(void);
> >>>>>>     void qemu_register_powerdown_notifier(Notifier *notifier);
> >>>>>> +void qemu_system_sleep_request(void);
> >>>>>> +void qemu_register_sleep_notifier(Notifier *notifier);
> >>>>>>     void qemu_system_debug_request(void);
> >>>>>>     void qemu_system_vmstop_request(RunState reason);
> >>>>>>     void qemu_system_vmstop_request_prepare(void);
> >>>>>> diff --git a/qapi-schema.json b/qapi-schema.json
> >>>>>> index 8b015bee2e..c6ccfcd70f 100644
> >>>>>> --- a/qapi-schema.json
> >>>>>> +++ b/qapi-schema.json
> >>>>>> @@ -2314,6 +2314,18 @@
> >>>>>>     { 'command': 'system_reset' }
> >>>>>>    =20
> >>>>>>     ##
> >>>>>> +# @system_sleep:
> >>>>>> +#
> >>>>>> +# Requests that a guest perform a ACPI sleep transition by pushin=
g a virtual
> >>>>>> +# sleep button.
> >>>>>> +#
> >>>>>> +# Notes: A guest may or may not respond to this command.  This co=
mmand
> >>>>>> +#        returning does not indicate that a guest has accepted th=
e request or
> >>>>>> +#        that it has gone to sleep.
> >>>>>> +##
> >>>>>> +{ 'command': 'system_sleep' }
> >>>>>> +
> >>>>>> +##
> >>>>>>     # @system_powerdown:
> >>>>>>     #
> >>>>>>     # Requests that a guest perform a powerdown operation.
> >>>>>> diff --git a/qmp.c b/qmp.c
> >>>>>> index b86201e349..bc1f2e3d7f 100644
> >>>>>> --- a/qmp.c
> >>>>>> +++ b/qmp.c
> >>>>>> @@ -108,6 +108,11 @@ void qmp_system_reset(Error **errp)
> >>>>>>         qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +void qmp_system_sleep(Error **erp)
> >>>>>> +{
> >>>>>> +    qemu_system_sleep_request();
> >>>>>> +}
> >>>>>> +
> >>>>>>     void qmp_system_powerdown(Error **erp)
> >>>>>>     {
> >>>>>>         qemu_system_powerdown_request();
> >>>>>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> >>>>>> index d77b3c8710..3fa850bf1e 100644
> >>>>>> --- a/tests/test-hmp.c
> >>>>>> +++ b/tests/test-hmp.c
> >>>>>> @@ -67,6 +67,7 @@ static const char *hmp_cmds[] =3D {
> >>>>>>         "sum 0 512",
> >>>>>>         "x /8i 0x100",
> >>>>>>         "xp /16x 0",
> >>>>>> +    "system_sleep",
> >>>>>>         NULL
> >>>>>>     };
> >>>>>>    =20
> >>>>>> diff --git a/vl.c b/vl.c
> >>>>>> index fb6b2efafa..6a0f847dcf 100644
> >>>>>> --- a/vl.c
> >>>>>> +++ b/vl.c
> >>>>>> @@ -1608,6 +1608,7 @@ static ShutdownCause reset_requested;
> >>>>>>     static ShutdownCause shutdown_requested;
> >>>>>>     static int shutdown_signal;
> >>>>>>     static pid_t shutdown_pid;
> >>>>>> +static int sleep_requested;
> >>>>>>     static int powerdown_requested;
> >>>>>>     static int debug_requested;
> >>>>>>     static int suspend_requested;
> >>>>>> @@ -1618,6 +1619,8 @@ static NotifierList suspend_notifiers =3D
> >>>>>>         NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
> >>>>>>     static NotifierList wakeup_notifiers =3D
> >>>>>>         NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
> >>>>>> +static NotifierList sleep_notifiers =3D
> >>>>>> +    NOTIFIER_LIST_INITIALIZER(sleep_notifiers);
> >>>>>>     static uint32_t wakeup_reason_mask =3D ~(1 << QEMU_WAKEUP_REAS=
ON_NONE);
> >>>>>>    =20
> >>>>>>     ShutdownCause qemu_shutdown_requested_get(void)
> >>>>>> @@ -1838,6 +1841,24 @@ static void qemu_system_powerdown(void)
> >>>>>>         notifier_list_notify(&powerdown_notifiers, NULL);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +static void qemu_system_sleep(void)
> >>>>>> +{
> >>>>>> +    notifier_list_notify(&sleep_notifiers, NULL);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qemu_sleep_requested(void)
> >>>>>> +{
> >>>>>> +    int r =3D sleep_requested;
> >>>>>> +    sleep_requested =3D 0;
> >>>>>> +    return r;
> >>>>>> +}
> >>>>>> +
> >>>>>> +void qemu_system_sleep_request(void)
> >>>>>> +{
> >>>>>> +    sleep_requested =3D 1;
> >>>>>> +    qemu_notify_event();
> >>>>>> +}
> >>>>>> +
> >>>>>>     void qemu_system_powerdown_request(void)
> >>>>>>     {
> >>>>>>         trace_qemu_system_powerdown_request();
> >>>>>> @@ -1850,6 +1871,11 @@ void qemu_register_powerdown_notifier(Notif=
ier *notifier)
> >>>>>>         notifier_list_add(&powerdown_notifiers, notifier);
> >>>>>>     }
> >>>>>>    =20
> >>>>>> +void qemu_register_sleep_notifier(Notifier *notifier)
> >>>>>> +{
> >>>>>> +    notifier_list_add(&sleep_notifiers, notifier);
> >>>>>> +}
> >>>>>> +
> >>>>>>     void qemu_system_debug_request(void)
> >>>>>>     {
> >>>>>>         debug_requested =3D 1;
> >>>>>> @@ -1899,6 +1925,9 @@ static bool main_loop_should_exit(void)
> >>>>>>         if (qemu_powerdown_requested()) {
> >>>>>>             qemu_system_powerdown();
> >>>>>>         }
> >>>>>> +    if (qemu_sleep_requested()) {
> >>>>>> +        qemu_system_sleep();
> >>>>>> +    }
> >>>>>>         if (qemu_vmstop_requested(&r)) {
> >>>>>>             vm_stop(r);
> >>>>>>         } =20
> >>>    =20
>=20


