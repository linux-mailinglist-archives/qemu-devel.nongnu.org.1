Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B178ACAA
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZh5-0001w8-68; Mon, 28 Aug 2023 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaZgc-0001S1-42; Mon, 28 Aug 2023 06:41:37 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qaZgV-0005g5-9j; Mon, 28 Aug 2023 06:41:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso3975761a12.3; 
 Mon, 28 Aug 2023 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693219285; x=1693824085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GypzuA3YD/OXvcQrFg816KNUCgucd6snbdNEWAStcWc=;
 b=KgEmGTyOV+OhYMx8Fm4ro7ifxQJABXZBsKBeF/UzaVAV0Oa3VU46TAJcIw0WHvPGYk
 yA7S+TiYXPftCKcnj0uzmnG6f7hVM7fXBjP1Dp45rl22DfSwF/iitq1AJmFYZRXcSpLi
 NM+s9GxY7oQJp1rMoxcNqAsWxrl0BOodePUnv/LfC85Uv3v/lU0Y/y11rOFo3z3/a3Og
 odu+so1UhebbEKtayWUKazgw+5JGvTapUUihh3CiyG04NttKked1Lm41KApyJXZWQaAd
 syDBUdHXHyu3MtFkBrkAJY1/DLl7k0hBarWaiUDw2dYEg/ZI63lukAOuNe2szc89gpM7
 GOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219285; x=1693824085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GypzuA3YD/OXvcQrFg816KNUCgucd6snbdNEWAStcWc=;
 b=j/Qhbt/84WaS9BlBf0lOA5kZUflJ9yIX7hnvohuReSSEi/ydUhfMq5JHF4WnyKNF4b
 pn5EKwfCpkLB3rpJGxYxT33TZIsv6a/xbuSNuGiNl+ZW2zy9jKT+vpPoHMQ2yVGviVzT
 zjKoxasWWgj3yyK873ZOE6hNA1gEz4JQ9QU8Agj8Eo2ydLrMAnGwDCRcUCMQ4NLQkG1J
 hUXlXuCohcGLDEPhSF1wMVKjOyvD400H8o56ng+Dx4i7mnfLyw0dmi0ek5lX6uUzAuYr
 AQe6eZFnLw3p6Jw/GBap1cmPAmBeXvDEqRne2JzLaA/wDSVBvZtAX2k9VZXRN8ZDX0yc
 O+tQ==
X-Gm-Message-State: AOJu0YzbuHwpiKi1tpOz4vbwKq0Cs1II6Fg4c3XDeYG45oflkwA1/CtU
 ciddytCWzMm7HjGs1NYi4vwd+zqtYPAeTODwFqE=
X-Google-Smtp-Source: AGHT+IFC0NKFIkKGotFSqln1RHMYdJq5KqtRUq8p3ijGrEwXqHI6DFTahDyv23XQJXvkcLTgzXk+/b7AGUpZVf5aquQ=
X-Received: by 2002:aa7:da18:0:b0:522:2782:537 with SMTP id
 r24-20020aa7da18000000b0052227820537mr18869190eds.15.1693219284277; Mon, 28
 Aug 2023 03:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
 <20230821133131.GA37847@fedora>
 <CAAAx-8JL1ieece-noWNo3ZJ4fDD-x-Z4u+WOgsO4jnvpoqLqTw@mail.gmail.com>
 <f1144d47-209d-c376-f179-1af2ad2d3f1b@kernel.org>
 <CAAAx-8KHyTNDKL6FvAifZmH6LW46U5ccM+c=Rp0Hf=XpbErczg@mail.gmail.com>
 <aeeeaf19-ce27-a3a2-7be0-9acbae24bb5e@kernel.org>
In-Reply-To: <aeeeaf19-ce27-a3a2-7be0-9acbae24bb5e@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 28 Aug 2023 18:40:55 +0800
Message-ID: <CAAAx-8+r7eowBMOsWDbFZ8PTN2+kSV7M+-tFStz3zenV53VAzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 18:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/28/23 19:18, Sam Li wrote:
> > Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=80 18:13=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 8/28/23 18:22, Sam Li wrote:
> >>> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=80 21:31=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
> >>>>> diff --git a/block/qcow2.h b/block/qcow2.h
> >>>>> index f789ce3ae0..3694c8d217 100644
> >>>>> --- a/block/qcow2.h
> >>>>> +++ b/block/qcow2.h
> >>>>> @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
> >>>>>      uint64_t length;
> >>>>>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> >>>>>
> >>>>> +typedef struct Qcow2ZonedHeaderExtension {
> >>>>> +    /* Zoned device attributes */
> >>>>> +    uint8_t zoned_profile;
> >>>>> +    uint8_t zoned;
> >>>>> +    uint16_t reserved16;
> >>>>> +    uint32_t zone_size;
> >>>>> +    uint32_t zone_capacity;
> >>>>
> >>>> Should zone capacity be stored individually for each zone (alongside=
 the
> >>>> write pointer and other per zone metadata) instead of as a global va=
lue
> >>>> for all zones? My understanding is that NVMe ZNS does not have a glo=
bal
> >>>> value and each zone could have a different zone capacity value.
> >>>
> >>> Though zone capacity is per-zone attribute, it remains same for all
> >>> zones in most cases. Referring to the NVMe ZNS spec, zone capacity
> >>> changes associate to RESET_ZONE op when the variable zone capacity bi=
t
> >>> is '1'. It hasn't specifically tell what it is changed to. Current ZN=
S
> >>> emulation doesn't change zone capacity as well.
> >>>
> >>> If the Variable Zone Capacity bit is cleared to =E2=80=980=E2=80=99 i=
n the Zone
> >>> Operation Characteristics field in the Zoned
> >>> Namespace Command Set specific Identify Namespace data structure, the=
n
> >>> this field does not change without a change to the format of the zone=
d
> >>> namespace.
> >>>
> >>> If the Variable Zone Capacity bit is set to =E2=80=981=E2=80=99 in th=
e Zone Operation
> >>> Characteristics field in the Zoned
> >>> Namespace Command Set specific Identify Namespace data structure, the=
n
> >>> the zone capacity may
> >>> change upon successful completion of a Zone Management Send command
> >>> specifying the Zone Send
> >>> Action of Reset Zone.
> >>
> >> Regardless of the variable zone capacity feature, zone capacity is per=
 zone and
> >> may be different between zones. That is why it is reported per zone in=
 zone
> >> report. The IO path code should not assume that the zone capacity is t=
he same
> >> for all zones.
> >
> > How is zone capacity changed, by devices or commands? Can you give
> > some example please?
>
> If the device does not support variable zone capacity, the zone capacity =
is
> fixed at device manufacturing time and never changes. It is reported per =
zone
> and you have to make things work with whatever value you see. The user ca=
nnot
> change device zone capacity.
>
> For you qcow2 zoned image, the equivalent is to fix the zone capacity whe=
n the
> image is created and not allowing to change it. And for simplicity, the s=
ame
> zone capacity value can be used for all zones, so having the zone capacit=
y
> value in the header is OK.

Thanks!

>
> >
> >>
> >> For this particular case though, given that this is QCow2 emulation, l=
imiting
> >> ourselves to the same zone capacity for all zones is I think fine. But=
 that
> >> should be clearly stated somewhere may be...
> >
> > I see. The qcow2 documentaion can add that.
> >
> >>
> >>>
> >>>>
> >>>>> +    uint32_t nr_zones;
> >>>>
> >>>> Is this field necessary since it can be derived from other image
> >>>> options: nr_zones =3D DIV_ROUND_UP(total_length, zone_capacity)?
> >>>
> >>> It can be dropped. I added this for reducing duplication. Thanks!
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
>
> --
> Damien Le Moal
> Western Digital Research
>

