Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E2747012
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeMG-0000cA-V9; Tue, 04 Jul 2023 07:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGeMF-0000c0-EM
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGeMD-0005HA-K0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688470687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0Pd426OgRa1CywF/3IE4HjlIxv03FXKb5kgbrbIcgI=;
 b=OYczWd/kbchRncUD9DE2PWRjDTF87BoKZaWqvoFwrwtGGfjbBjH3jafftFcUQCNswu6OZ/
 hSiWrcO/dipQQg4jnRNAPronijXjyeCr5Z8838J2tVAU19xher76EjaVvrN3op7zGNDxR0
 Tt9c3E46Yvkpni2mQ7C9z+LFeI5J0QI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-zRoKb-5hO5u3wxfiWDhc-g-1; Tue, 04 Jul 2023 07:38:06 -0400
X-MC-Unique: zRoKb-5hO5u3wxfiWDhc-g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-992e6840901so506828566b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688470683; x=1691062683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0Pd426OgRa1CywF/3IE4HjlIxv03FXKb5kgbrbIcgI=;
 b=chrnO8YplgpjjVATzCK7om8e0+58QFm3LfSKGUkLbTeXEbJ193IEGye9u6va7Um04e
 MaZBPGatwwYJHqgtyVzrOs/5MowUliN1I7U7HFJJ0XWZJXURS1gAbMyeDoKG2fuZULKh
 9uIP7DEyYR2tr/QksCgcIWtMyZVTGjFPgIKR1x4aXlVswLqEiD2pdkz/DFEzO65F2zeA
 bXkiqvsRruB90rw5c+y2/A195FLLn/5tvbR/Bt34myFieJG8oTg62/8jBPSTZ5TLrUDB
 5PP6ZYvOffjMZReTLA8CAJDU8N/zQl68xlsaYbceYV+z/rqTqoQ5vWr964K44Il3xzJI
 7hoQ==
X-Gm-Message-State: ABy/qLYCKUAgHxIYjDvmwte1h7C6Ef8C1dFhPF18bf5WIw0LuYBzKWih
 uIhlsMFvyH3TwJNISLFq1RY0IygPCn2u9yb48XOikhxMXt9J8xDspI2Ub7OPQZqWJ8Cem1DMD7O
 Y8PV2RpE3Ua1U19WtBZ/hEH4=
X-Received: by 2002:a17:906:2209:b0:989:1a52:72a1 with SMTP id
 s9-20020a170906220900b009891a5272a1mr12808094ejs.28.1688470683266; 
 Tue, 04 Jul 2023 04:38:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnKi4Rm35L4xke9cuwGTRJr6i1G23kNTwkay0I11CPT6bYumRT7cBwCuTQI8eJCjVBLMxysQ==
X-Received: by 2002:a17:906:2209:b0:989:1a52:72a1 with SMTP id
 s9-20020a170906220900b009891a5272a1mr12808080ejs.28.1688470682966; 
 Tue, 04 Jul 2023 04:38:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 b7-20020a170906660700b009935aba3a9dsm3363095ejp.48.2023.07.04.04.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:38:02 -0700 (PDT)
Date: Tue, 4 Jul 2023 13:38:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into
 only slot 0 of PCIE port
Message-ID: <20230704133801.0423b554@imammedo.users.ipa.redhat.com>
In-Reply-To: <0879ed66-766c-1d3f-dcce-31e1285a7972@daynix.com>
References: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <20230630112611-mutt-send-email-mst@kernel.org>
 <0879ed66-766c-1d3f-dcce-31e1285a7972@daynix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, 1 Jul 2023 16:28:30 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2023/07/01 0:29, Michael S. Tsirkin wrote:
> > On Fri, Jun 30, 2023 at 08:36:38PM +0900, Akihiko Odaki wrote: =20
> >> On 2023/06/30 19:37, Ani Sinha wrote: =20
> >>>
> >>> =20
> >>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >>>>
> >>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote: =20
> >>>>>
> >>>>> =20
> >>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> >>>>>>
> >>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote: =20
> >>>>>>>
> >>>>>>> =20
> >>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote: =20
> >>>>>>>>>>
> >>>>>>>>>> Thus the check for unoccupied function 0 needs to use pci_is_v=
f() instead of checking ARI capability, and that can happen in do_pci_regis=
ter_device().
> >>>>>>>>>> =20
> >>>>>>>>>>> Also where do you propose we move the check? =20
> >>>>>>>>>>
> >>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and befor=
e option ROM loading. =20
> >>>>>>>>>
> >>>>>>>>> Hmm, I tried this. The issue here is something like this would =
be now allowed since the PF has ARI capability:
> >>>>>>>>>
> >>>>>>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0
> >>>>>>>>>
> >>>>>>>>> The above should not be allowed and when used, we do not see th=
e igb ethernet device from the guest OS. =20
> >>>>>>>>
> >>>>>>>> I think it's allowed because it expects you to hotplug function =
0 later, =20
> >>>>>>>
> >>>>>>> This is about the igb device being plugged into the non-zero slot=
 of the pci-root-port. The guest OS ignores it. =20
> >>>>>>
> >>>>>> yes but if you later add a device with ARI and with next field poi=
nting
> >>>>>> slot 2 guest will suddently find both. =20
> >>>>>
> >>>>> Hmm, I tried this:
> >>>>>
> >>>>> -device pcie-root-port,id=3Dp \
> >>>>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
> >>>>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
> >>>>>
> >>>>> The guest only found the second igb device not the first. You can t=
ry too. =20
> >>>>
> >>>> Because next parameter in pcie_ari_init does not match. =20
> >>>
> >>> OK send me a command line that I can test it with. I can=E2=80=99t co=
me up with a case that actually works in practice. =20
> >>
> >> I don't think there is one because the code for PCI multifunction does=
 not
> >> care ARI. In my opinion, we need yet another check to make non-SR-IOV
> >> multifunction and ARI capability mutually exclusive; if a function has=
 the
> >> ARI capability and it is not a VF, an attempt to assign non-zero funct=
ion
> >> number for it should fail. =20

is it stated somewhere in spec(s) that ARI and !SR-IOV are mutually exclusi=
ve?

> >=20
> > Why is that? My understanding is that ARI capable devices should also
> > set the multifunction bit in the header. It's not terribly clear from
> > the spec though. =20
>=20
> Something like the following will not work properly with ARI-capable=20
> device (think of a as an ARI-capable device):
> -device a,addr=3D0x1.0x0,multifunction=3Don -device a,addr=3D0x1.0x1
(I had a crazy idea, to use it like that so we could put more devices
on port without resorting to adding extra bridges)

Can you elaborate some more why it won't work?

> This is because the next function numbers advertised with ARI are not=20
> updated with the multifunction configuration, but they are hardcoded in=20
> the device implementation. In this sense, the traditional (non-SR/IOV)=20
> multifunction mechanism QEMU has will not work with ARI-capable devices.
>=20
> >  =20
> >> But it should be a distinct check as it will need to check the function
> >> number bits.
> >> =20
> >>> =20
> >>>>
> >>>> =20
> >>>>>> =20
> >>>>>>>> no?
> >>>>>>>>
> >>>>>>>> I am quite worried about all this work going into blocking
> >>>>>>>> what we think is disallowed configurations. We should have
> >>>>>>>> maybe blocked them originally, but now that we didn't
> >>>>>>>> there's a non zero chance of regressions, =20
> >>>>>>>
> >>>>>>> Sigh, =20
> >>>>>>
> >>>>>> There's value in patches 1-4 I think - the last patch helped you f=
ind
> >>>>>> these. so there's value in this work.
> >>>>>> =20
> >>>>>>> no medals here for being brave :-) =20
> >>>>>>
> >>>>>> Try removing support for a 3.5mm jack next. Oh wait ... =20
> >>>>>
> >>>>> Indeed. Everyone uses bluetooth these days. I for one is happy that=
 the jack is gone (and they were bold enough to do it while Samsung and oth=
ers still carry the useless port ) :-) =20
> >>
> >> Hello from a guy using a shiny M2 Macbook Air carrying the legacy jack=
 with
> >> a 100-yen earphone. Even people who ported Linux to this machine spent
> >> efforts to get the jack to work on Linux ;)
> >> =20
> >>>>> =20
> >>>>>> =20
> >>>>>>>> and the benefit
> >>>>>>>> is not guaranteed.
> >>>>>>>>
> >>>>>>>> --=20
> >>>>>>>> MST =20
> >>> =20
> >  =20
>=20


