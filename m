Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FB78BF37
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 09:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qat9C-00040i-Sj; Tue, 29 Aug 2023 03:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qat9B-00040O-3i; Tue, 29 Aug 2023 03:28:21 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qat97-0005mu-5R; Tue, 29 Aug 2023 03:28:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso791512a12.3; 
 Tue, 29 Aug 2023 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693294095; x=1693898895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hip+6z9XYcCba0BNiOoxSdln6gkls1x2hiSBzIveZC4=;
 b=Oqz6xwk1C+16tNW7yEDz7OSaTp6G1AERDLt9CJWhmvKx3Y2/HcFhl47RN23o1XdK6P
 hAwSmG8U8e7WVPOEMrFSaPZK3XtahYCqBTwxTivyG6zwJOUB0J9pXGFaU6HeC51FW75Z
 W/pQmsMQf+dx1M7mGxZOazLK9mq4r6JsmmmF2/qBC0eftgqg61fOBfvjGq/qy8vpltsm
 R/g4ebOWzJizHrxgaPKkiEL5F7ZmbZNmTnbjW8fgw1y6ZPO5RTPVfXnvNcE6cqLutqZN
 FNM0D5Z4N4Pw5aChdG86apqMEgavQd7StX7i06V5hKKBIw0qhMrc1/JaQZ32soL/Gje9
 IXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693294095; x=1693898895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hip+6z9XYcCba0BNiOoxSdln6gkls1x2hiSBzIveZC4=;
 b=FcvKP+Y+br+tsArXjATjHO0waxXlgfIlruQ1Wxo14GO7dJOUSHARTf6/vPGtsfDTQe
 b5Yp7EWERt98ga0Nniwhtw2ECxrLcA1PMwRTLkZHHu6Y4qVchNRo9R7NgBoIKwVGPuPi
 LVFPDAokW1QxqxYuHGtesnfGv2EkECA3J5rhrmAhvbHuxFJtOmipZhLDADV3wnxhC0Fn
 +xAELOzpGfBZ46Xd/tgQI3UIX9KfmNpdivohX/NAjEni4dWDSUxzHYB+Rujq8ZYECMX3
 3lyGxZp1qsqCAygR78VFLI2tmXrDk8hoxGIyoA7ErugvexhIhepiiVzC7+iX5MK/RMkE
 LieQ==
X-Gm-Message-State: AOJu0Yx18eOSekyoEjm5r+nzCOXrEMV+LsntWLZvreGNR8cpl1ebGEQB
 d0YDoNLCRRjpQeBj1pThOjLmTf5Zyd3zIxqkNR0=
X-Google-Smtp-Source: AGHT+IEW5pD/re5nneUeYMhCqX3Xyh6tIkeFJ1cbAxGwq93Gy8D/cq4M6eotWgMxIJJ2SIvn2HOSy1y99fNYN7B5XtI=
X-Received: by 2002:aa7:c98c:0:b0:523:37ff:1170 with SMTP id
 c12-20020aa7c98c000000b0052337ff1170mr21218364edt.16.1693294094071; Tue, 29
 Aug 2023 00:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
 <20230822194814.GB37847@fedora>
 <CAAAx-8KQOBxt3S+nB0MNtOdG_8SZVg1HOud0hp65A+LXUrL-fw@mail.gmail.com>
 <4c167bfe-2b93-358d-8e13-9e4fc1016766@kernel.org>
 <CAAAx-8J3TUanrC+-tpTO+xYYXH031S2AeirNAkdDE7wtGrT63g@mail.gmail.com>
 <1bedb9e9-63f5-9986-ce07-808c8892a1ea@kernel.org>
In-Reply-To: <1bedb9e9-63f5-9986-ce07-808c8892a1ea@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 29 Aug 2023 15:27:42 +0800
Message-ID: <CAAAx-8La8Pfb6hUrJGyZZe=Yik694mFDmq_NyEUgY40tdZeG6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52b.google.com
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

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/29/23 15:27, Sam Li wrote:
> > Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:06=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 8/28/23 20:55, Sam Li wrote:
> >>>>> +            /* close one implicitly open zones to make it availabl=
e */
> >>>>> +            for (int i =3D s->zoned_header.zone_nr_conv;
> >>>>> +            i < bs->bl.nr_zones; ++i) {
> >>>>> +                uint64_t *wp =3D &s->wps->wp[i];
> >>>>> +                if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> >>>>> +                    ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CL=
OSED);
> >>>>
> >>>> I'm wondering if it's correct to store the zone state persistently i=
n
> >>>> the qcow2 file. If the guest or QEMU crashes, then zones will be lef=
t in
> >>>> states like EOPEN. Since the guest software will have forgotten abou=
t
> >>>> explicitly opened zones, the guest would need to recover zone states=
.
> >>>> I'm not sure if existing software is designed to do that.
> >>>>
> >>>> Damien: Should the zone state be persistent?
> >>
> >> Yes and no. Yes you need to preserve/maintain zone states but not as i=
s.
> >> With a real drive, if you power cycle the device, you get the followin=
g states
> >> changes:
> >>
> >>  Before         | After power cycle
> >> ----------------+-------------------
> >>  EMPTY          | EMPTY
> >>  FULL           | FULL
> >>  IMP. OPEN      | CLOSED
> >>  EXP. OPEN      | CLOSED
> >>  CLOSED         | CLOSED
> >>  READ=3DONLY      | READ-ONLY
> >>  OFFLINE        | OFFLINE
> >>
> >> So any open (implicit or explicit) zone will show up as closed after p=
ower
> >> cycle. That is, the number of "active" zones does not change.
> >> For the qcow2 emulation, as long as you do not also emulate read-only =
and
> >> offline zones, you actually do not need to save the zone state in the =
zone
> >> metadata. On startup, you can infer the state from the zone write poin=
ter:
> >>
> >> zone wp =3D=3D zone start -> EMPTY
> >> zone wp >=3D zone capacity -> FULL
> >> zone wp > zone start -> CLOSED
> >>
> >> And make sure that all closed zones are counted as the initial number =
of active
> >> zones. The initial number of open zones will always be 0.
> >>
> >> So it is easy :)
> >
> > Thanks for the explanations!
> >
> > Read-only and offline are device internal events. Does qcow2 emulation
> > need to emulate that?
> >
> > Current NVMe ZNS emulation in QEMU has a nvme_offline_zone() function.
> > Does it suggest keeping the offline state persistent?
> > https://github.com/qemu/qemu/blob/master/hw/nvme/ctrl.c#L3740
>
> The offline state is useful for testing only. If a zone goes offline, it
> generally means that the device is dying...
> At least for now, I do not think it is needed for qcow2. That can always =
be
> added later.

Ok. Then the wps of zoned metadata structure would be almost like
zoned emulation in file-posix. Current wp design can still preserve as
is. Though, it will be only in memory then.

This change will be reflected in v4 (newest v3 for now).

Sam

