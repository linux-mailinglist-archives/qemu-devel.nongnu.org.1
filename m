Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBC74717F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:37:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfGz-0005ic-O6; Tue, 04 Jul 2023 08:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGfGx-0005hu-OG
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGfGv-0002y2-RJ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688474205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYAJTMQfYNiY5Q+/WDll52VpCmZP1MOs7WsqGyisaSQ=;
 b=DLXugE+w7bh62RDfJmSsEZJmgvE0VgAecx3sdx0Azi3mVwk6vylh2FSIGLBMN/pxLHp0zf
 /MwT+RL+0h5Q5tiswRHX3kwPIfFKvbTwIPc+OsVuohGpFlU9EP55Q/Hu72lqPNL7FplMqd
 fcaD9mOcYuLWdMlnhXP/Mnlpj1+Uikc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-JM_SBKr4MbaIHFfBMuzucA-1; Tue, 04 Jul 2023 08:36:43 -0400
X-MC-Unique: JM_SBKr4MbaIHFfBMuzucA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so314485066b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688474202; x=1691066202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYAJTMQfYNiY5Q+/WDll52VpCmZP1MOs7WsqGyisaSQ=;
 b=Fr2q6DU1P6DP8BLkbvbkZHZZKu2gKv1ZNJu6S6NMQDxlxruGN8bdOYL0L/cj7PuIFs
 p/spA7iTOhaycJ7E0r+X3krmJwnjsK05rMWNo/Teu8/BqKo38gBCQC10/gIHYzFNH36l
 q+R4AqeJYRO397PG5eIhoovu8rJaBUMf+tRlRL2iv/WItZUqaZEGgyKkEHWpd6LDfl0X
 WSjteSZbePSRUfjtaaD/tZIBcrfacVdaYna9TswBYZPRePVvSXhSZ2n6MYwSi61yHAwA
 QDTtQ7E5XzEc48d0FjP+tAkcfHOHCX3ITeHbV09RHiJBWaHMv6Z4DV4lvvzG/z4LeXHN
 upyw==
X-Gm-Message-State: ABy/qLa2wEkGQ5ehNfeQRBCamuUlolVqmTQfXY0s78LwUGEQ25haihHv
 1O6MXapdnnFkhyFC/ftyYv1kjoxrLWt1f1Fh8VKaSeGhpiqi36wLGWHZhCXKDjVweYBGnOPPEXJ
 iHAURTIiW4elFp5w=
X-Received: by 2002:a17:906:f9d7:b0:988:9621:d855 with SMTP id
 lj23-20020a170906f9d700b009889621d855mr7435332ejb.61.1688474202673; 
 Tue, 04 Jul 2023 05:36:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHP2SaJt1PWo9/J0e2n4fZ7WYg8jtz8By/tenEjX4Y0Lmsf3WhLzT/lF544RlyarZgwRTTgg==
X-Received: by 2002:a17:906:f9d7:b0:988:9621:d855 with SMTP id
 lj23-20020a170906f9d700b009889621d855mr7435326ejb.61.1688474202316; 
 Tue, 04 Jul 2023 05:36:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 sb22-20020a170906edd600b00982a92a849asm13316924ejb.91.2023.07.04.05.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:36:40 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:36:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into
 only slot 0 of PCIE port
Message-ID: <20230704143639.102ad308@imammedo.users.ipa.redhat.com>
In-Reply-To: <a6cf6a37-ae26-1725-f564-bc46b2dc892a@daynix.com>
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
 <20230704133801.0423b554@imammedo.users.ipa.redhat.com>
 <a6cf6a37-ae26-1725-f564-bc46b2dc892a@daynix.com>
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

On Tue, 4 Jul 2023 20:50:49 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2023/07/04 20:38, Igor Mammedov wrote:
> > On Sat, 1 Jul 2023 16:28:30 +0900
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >  =20
> >> On 2023/07/01 0:29, Michael S. Tsirkin wrote: =20
> >>> On Fri, Jun 30, 2023 at 08:36:38PM +0900, Akihiko Odaki wrote: =20
> >>>> On 2023/06/30 19:37, Ani Sinha wrote: =20
> >>>>>
> >>>>>    =20
> >>>>>> On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> >>>>>>
> >>>>>> On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote: =20
> >>>>>>>
> >>>>>>>    =20
> >>>>>>>> On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote: =20
> >>>>>>>>>
> >>>>>>>>>    =20
> >>>>>>>>>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote: =20
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thus the check for unoccupied function 0 needs to use pci_is=
_vf() instead of checking ARI capability, and that can happen in do_pci_reg=
ister_device().
> >>>>>>>>>>>>    =20
> >>>>>>>>>>>>> Also where do you propose we move the check? =20
> >>>>>>>>>>>>
> >>>>>>>>>>>> In pci_qdev_realize(), somewhere after pc->realize() and bef=
ore option ROM loading. =20
> >>>>>>>>>>>
> >>>>>>>>>>> Hmm, I tried this. The issue here is something like this woul=
d be now allowed since the PF has ARI capability:
> >>>>>>>>>>>
> >>>>>>>>>>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.=
0x0
> >>>>>>>>>>>
> >>>>>>>>>>> The above should not be allowed and when used, we do not see =
the igb ethernet device from the guest OS. =20
> >>>>>>>>>>
> >>>>>>>>>> I think it's allowed because it expects you to hotplug functio=
n 0 later, =20
> >>>>>>>>>
> >>>>>>>>> This is about the igb device being plugged into the non-zero sl=
ot of the pci-root-port. The guest OS ignores it. =20
> >>>>>>>>
> >>>>>>>> yes but if you later add a device with ARI and with next field p=
ointing
> >>>>>>>> slot 2 guest will suddently find both. =20
> >>>>>>>
> >>>>>>> Hmm, I tried this:
> >>>>>>>
> >>>>>>> -device pcie-root-port,id=3Dp \
> >>>>>>> -device igb,bus=3Dp,addr=3D0x2.0x0 \
> >>>>>>> -device igb,bus=3Dp,addr=3D0x0.0x0 \
> >>>>>>>
> >>>>>>> The guest only found the second igb device not the first. You can=
 try too. =20
> >>>>>>
> >>>>>> Because next parameter in pcie_ari_init does not match. =20
> >>>>>
> >>>>> OK send me a command line that I can test it with. I can=E2=80=99t =
come up with a case that actually works in practice. =20
> >>>>
> >>>> I don't think there is one because the code for PCI multifunction do=
es not
> >>>> care ARI. In my opinion, we need yet another check to make non-SR-IOV
> >>>> multifunction and ARI capability mutually exclusive; if a function h=
as the
> >>>> ARI capability and it is not a VF, an attempt to assign non-zero fun=
ction
> >>>> number for it should fail. =20
> >=20
> > is it stated somewhere in spec(s) that ARI and !SR-IOV are mutually exc=
lusive?
> >  =20
> >>>
> >>> Why is that? My understanding is that ARI capable devices should also
> >>> set the multifunction bit in the header. It's not terribly clear from
> >>> the spec though. =20
> >>
> >> Something like the following will not work properly with ARI-capable
> >> device (think of a as an ARI-capable device):
> >> -device a,addr=3D0x1.0x0,multifunction=3Don -device a,addr=3D0x1.0x1 =
=20
> > (I had a crazy idea, to use it like that so we could put more devices
> > on port without resorting to adding extra bridges)
> >=20
> > Can you elaborate some more why it won't work? =20
>=20
> It won't work because the ARI next function number field is fixed. In=20
> this case, the field of the Function at 0x1.0x0 should point to 0x1.0x1,=
=20
> but it doesn't. As the result, the Function at 0x1.0x1 won't be recognize=
d.
>=20
> It's more problematic if some of the Functions are ARI-capable but=20
> others are not. In my understanding, all Functions in a ARI-capable=20
> device need to have ARI capability, but that's not enforced.

that doesn't look to me as an real issue but rather as
a QEMU problem that we could fix and handle it properly.

> >> This is because the next function numbers advertised with ARI are not
> >> updated with the multifunction configuration, but they are hardcoded in
> >> the device implementation. In this sense, the traditional (non-SR/IOV)
> >> multifunction mechanism QEMU has will not work with ARI-capable device=
s.
> >> =20
> >>>     =20
> >>>> But it should be a distinct check as it will need to check the funct=
ion
> >>>> number bits.
> >>>>    =20
> >>>>>    =20
> >>>>>>
> >>>>>>    =20
> >>>>>>>>    =20
> >>>>>>>>>> no?
> >>>>>>>>>>
> >>>>>>>>>> I am quite worried about all this work going into blocking
> >>>>>>>>>> what we think is disallowed configurations. We should have
> >>>>>>>>>> maybe blocked them originally, but now that we didn't
> >>>>>>>>>> there's a non zero chance of regressions, =20
> >>>>>>>>>
> >>>>>>>>> Sigh, =20
> >>>>>>>>
> >>>>>>>> There's value in patches 1-4 I think - the last patch helped you=
 find
> >>>>>>>> these. so there's value in this work.
> >>>>>>>>    =20
> >>>>>>>>> no medals here for being brave :-) =20
> >>>>>>>>
> >>>>>>>> Try removing support for a 3.5mm jack next. Oh wait ... =20
> >>>>>>>
> >>>>>>> Indeed. Everyone uses bluetooth these days. I for one is happy th=
at the jack is gone (and they were bold enough to do it while Samsung and o=
thers still carry the useless port ) :-) =20
> >>>>
> >>>> Hello from a guy using a shiny M2 Macbook Air carrying the legacy ja=
ck with
> >>>> a 100-yen earphone. Even people who ported Linux to this machine spe=
nt
> >>>> efforts to get the jack to work on Linux ;)
> >>>>    =20
> >>>>>>>    =20
> >>>>>>>>    =20
> >>>>>>>>>> and the benefit
> >>>>>>>>>> is not guaranteed.
> >>>>>>>>>>
> >>>>>>>>>> --=20
> >>>>>>>>>> MST =20
> >>>>>    =20
> >>>     =20
> >> =20
> >  =20
>=20


