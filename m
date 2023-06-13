Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377272E3BE
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93iM-00060Z-Fp; Tue, 13 Jun 2023 09:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q93iJ-000604-E9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q93iF-0004j3-LE
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686661526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VssNfldvckwcHqHqXBF8LRLeEcL/G9RHGMvQizEXA1I=;
 b=AzlD0iiHI3R+u5v9mCQt9ciH/hsT+mfEuAt/pBa1k07KjjU4vjKkcS9Nxo0TpUV5BR8g2H
 4uSn/ctOpDd9Magvo2+qiPuAoxkIIvnzWcBOJS7HkNjurcRX7r/COAulSqlpPoetzooBlc
 aea7HCmvzDfPy/ZdCQ4WFjcsA5Gp/BE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-otlIPvhyOdesacJVcIb0MQ-1; Tue, 13 Jun 2023 09:05:21 -0400
X-MC-Unique: otlIPvhyOdesacJVcIb0MQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f93baa42aaso11624351cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686661506; x=1689253506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VssNfldvckwcHqHqXBF8LRLeEcL/G9RHGMvQizEXA1I=;
 b=VRzZXnTyxjyJadJ9x/5KfAG3+dOKSUckcFJ2kd/5QqHSBJluswzLbQHz0DWlYh2Z87
 ZwvFkY3QOzrctcwR+3oAZGb3t4RXLLVVjTpZ417bYUa0h0w5BXuegBnarsb3NajiqufT
 3OxDM4BO4AGL8Mo8v/fi9xcGpxp8L873svXH/lAIGA/CO/ki60p4QZl3w8GQ009iH633
 5OGiW9T+pJICKgB9Os5rz2v1PWxG5jwwgR4NUBpInzHVJn+fsjVWFBYR9q1LVJg8Lvs/
 hLmr2SKwnhydfRyu/dJ4BHOzJ/q0V5CNVnNBAJQyuGzeFCutuE3RWl9WRYJU8Qq8GfeK
 3QJw==
X-Gm-Message-State: AC+VfDxsrbvTS6+nJ67fOodmpzoUZayTa1mVbX8Jj8Yu0w9h58hf/ok6
 vkfCkT1Q+jUm3vVNAEiMzKlkRDHzughiAflDYtbfjD3i5ntUGGtGiFhMss+i6C92p5qdGe/aeUZ
 IkoH0GqnHJi4hjvU=
X-Received: by 2002:ac8:5b4f:0:b0:3fc:7ef:c9d0 with SMTP id
 n15-20020ac85b4f000000b003fc07efc9d0mr2092092qtw.62.1686661506320; 
 Tue, 13 Jun 2023 06:05:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ycgu75Ymk7u/oTpu6Cfyw6gq2cSmHz9c/+AscUtikQVYWG/eDjT69MoAxzbyONBb1Ch6E3w==
X-Received: by 2002:ac8:5b4f:0:b0:3fc:7ef:c9d0 with SMTP id
 n15-20020ac85b4f000000b003fc07efc9d0mr2092055qtw.62.1686661505999; 
 Tue, 13 Jun 2023 06:05:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com.
 [213.175.37.12]) by smtp.gmail.com with ESMTPSA id
 fy26-20020a05622a5a1a00b003f86bc1753bsm4183704qtb.80.2023.06.13.06.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 06:05:05 -0700 (PDT)
Date: Tue, 13 Jun 2023 15:05:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow
 <shentey@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Message-ID: <20230613150502.74e46018@imammedo.users.ipa.redhat.com>
In-Reply-To: <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
 <20230613044810-mutt-send-email-mst@kernel.org>
 <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
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

On Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Tue, 13 Jun 2023, Michael S. Tsirkin wrote:
> > On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote: =20
> >> On Mon, Jun 12, 2023 at 3:01=E2=80=AFPM Igor Mammedov <imammedo@redhat=
.com> wrote:
> >>
> >>     On Sun, 11 Jun 2023 12:33:59 +0200
> >>     Bernhard Beschow <shentey@gmail.com> wrote:
> >> =20
> >>    > Fixes the following clangd warning (-Winitializer-overrides):
> >>    >
> >>    >=C2=A0 =C2=A0q35.c:297:19: Initializer overrides prior initializat=
ion of this =20
> >>     subobject =20
> >>    >=C2=A0 =C2=A0q35.c:292:19: previous initialization is here
> >>    >
> >>    > Settle on native endian which causes the least overhead. =20
> >>     indeed it doesn't matter which way we read all ones, so that shoul=
d work.
> >>     but does it really matter (I mean the overhead/what workload)?
> >>     If not, I'd prefer explicit LE as it's now to be consistent
> >>     the the rest of memops on Q35.
> >>
> >>
> >> I got a comment from Michael about this in [1], so I've changed it. I =
don't
> >> mind changing it either way.
> >>
> >> Best regards,
> >> Bernhard
> >>
> >> [1] https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/
> >> 20230214131441.101760-3-shentey@gmail.com/#
> >> 20230301164339-mutt-send-email-mst@kernel.org =20
> >
> > Hmm it's not terribly important, and the optimization is trivial,
> > but yes people tend to copy code, good point. Maybe add a comment?
> > /*
> > * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN. This only
> > * works because we don't allow writes and always read all-ones.
> > */ =20
>=20
> Why don't you leave DEVICE_LITTLE_ENDIAN and remove DEVICE_NATIVE_ENDIAN=
=20
> instead? If this only returns all 1s then it does not matter and also=20
> DEVICE_LITTLE_ENDIAN was the last assignment so likely that was effective=
=20
> so far anyway.

I'm in favor of this as well,
the 'optimization' and then piling comments on top to clarify confusion
should be justified by usefulness of it (no perf numbers/usecase were prese=
nt so far).
In absence of above, I'd prefer real hw behavior (LE in this case).

>=20
> Regards,
> BALATON Zoltan
>=20
> >> =20
> >>    >
> >>    > Fixes: bafc90bdc594 ("q35: implement TSEG")
> >>    > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >>    > ---
> >>    >=C2=A0 hw/pci-host/q35.c | 1 -
> >>    >=C2=A0 1 file changed, 1 deletion(-)
> >>    >
> >>    > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> >>    > index fd18920e7f..859c197f25 100644
> >>    > --- a/hw/pci-host/q35.c
> >>    > +++ b/hw/pci-host/q35.c
> >>    > @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops =
=3D {
> >>    >=C2=A0 =C2=A0 =C2=A0 .valid.max_access_size =3D 4,
> >>    >=C2=A0 =C2=A0 =C2=A0 .impl.min_access_size =3D 4,
> >>    >=C2=A0 =C2=A0 =C2=A0 .impl.max_access_size =3D 4,
> >>    > -=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> >>    >=C2=A0 };
> >>    >=C2=A0
> >>    >=C2=A0 /* PCIe MMCFG */ =20
> >>
> >> =20
> >
> >
> > =20


