Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C6789D2A
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 13:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaDcM-0002em-JO; Sun, 27 Aug 2023 07:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qaDcK-0002ZW-T9
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 07:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qaDcH-0005PY-JI
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 07:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693134456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXfpdYKIYqW4Mc13sAQrMyTr+Dbh9oBP6jXDHpgQQyU=;
 b=ML0qJUuAjjGCes5ts6A7QfzR4LPP+nFeBieWpB578a79bewRESG2Ropqd/j/L7KpPYKarR
 EEqY9vRoveR2K/zlS9FkUYg3YmOTTGvLDb6uk3BmEFI6d4lsNXDEXdZxf/c6zcwxoJQcqt
 Sw/UJRVXb2yZoTX16KBp8BCRB9WDYfU=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-1ukUzH5sPwGGQN2JTofrDQ-1; Sun, 27 Aug 2023 07:07:33 -0400
X-MC-Unique: 1ukUzH5sPwGGQN2JTofrDQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44d4b63c84cso895262137.3
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 04:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693134452; x=1693739252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXfpdYKIYqW4Mc13sAQrMyTr+Dbh9oBP6jXDHpgQQyU=;
 b=Z3bPtgFX1mLnz3hZ9WsP5JeW+FipabIb4Q6udtGnwp65ZmhK2KZVtkFVNDRZHWqnYc
 itUvWGkHrekoESSUqBH699KV3pLLpT8czdEVHwcTwj+eeQyiO4dzeFUWrWbe4XfXt/io
 LM4B8UHjyvml9UtS3cMA5xHrnjfSbg+wwrhR51KTDMKP8z1FAYbd9cSxGuD0/fQsT6Va
 WA+GApPwkEOJg2vITs1pQ2uI/HCWy26Nh4U+OzxTPAr7gpsd2CeFeNqUhSl4DFbUtZ1O
 LOErfmjqkxWsfa3Y9ghW835cByZy2mF/PVS7RWk6jw6N2e8t+OXZMJLK2RHfKzQ2h8t1
 t/Sw==
X-Gm-Message-State: AOJu0YwWRf5AN4XGA9iWs1xcHO1jsj8Za7n/EFfTWyImXIn1X/N0n5ul
 yN4ZrNnSCvPKYJmchzLkDrjBq7h8/vHG4mmNaHHzqoAbkizwxlTW3G0hAfJRkrUwTNe4/SY/eCd
 WvZjL2YUMOeO0NzMct3RCw56XTu9dSGL3ChZGqs69hA==
X-Received: by 2002:a1f:de04:0:b0:48d:2e3d:2d57 with SMTP id
 v4-20020a1fde04000000b0048d2e3d2d57mr17792406vkg.4.1693134452624; 
 Sun, 27 Aug 2023 04:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETAl3cFaShN9+UTRCrzjw40ySqqIEUgbxgG0DmN1yPEjhPq3hQbZhmFtcwNxb7w5A/VKaJz+b4BXPH+RL2TsI=
X-Received: by 2002:a1f:de04:0:b0:48d:2e3d:2d57 with SMTP id
 v4-20020a1fde04000000b0048d2e3d2d57mr17792398vkg.4.1693134452360; Sun, 27 Aug
 2023 04:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143912.1234427-1-mcascell@redhat.com>
 <CAA8xKjXvhnAyHDH43xcg9_HRqNqf04QhTpcrB2s4ae1d_WWuxw@mail.gmail.com>
In-Reply-To: <CAA8xKjXvhnAyHDH43xcg9_HRqNqf04QhTpcrB2s4ae1d_WWuxw@mail.gmail.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Sun, 27 Aug 2023 13:07:21 +0200
Message-ID: <CAA8xKjVyqbJrkdL-DF0=DsDWFKOkJqqwUa-5kAyn8n+qp2u8iQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rocker: avoid NULL pointer dereference in
 of_dpa_cmd_add_l2_flood
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us, jasowang@redhat.com, arayz_w@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
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

On Sat, Aug 26, 2023 at 4:31=E2=80=AFPM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> On Fri, Jun 24, 2022 at 4:40=E2=80=AFPM Mauro Matteo Cascella
> <mcascell@redhat.com> wrote:
> >
> > rocker_tlv_parse_nested could return early because of no group ids in
> > the group_tlvs. In such case tlvs is NULL; tlvs[i + 1] in the next
> > for-loop will deref the NULL pointer.

Looking at the code once again, tlvs is a pointer to a g_new0
allocated memory, so I don't know how it can be NULL after
rocker_tlv_parse_nested (unless g_new0 returns NULL in the first
place). I do not recall the details of this bug. Arayz?

> Someone somehow reserved a new CVE for this bug, published a few days
> ago here: https://nvd.nist.gov/vuln/detail/CVE-2022-36648.
>
> Not only is this not CVE worthy (rocker code does not fall under the
> KVM virtualization use case [1]) but what's most concerning is that it
> got a CVSS score of 10 :/
>
> I'm going to dispute this CVE. Hopefully, it will be rejected soon. In
> any case, can we get this patch merged?
>
> [1] https://www.qemu.org/docs/master/system/security.html
>
> Thanks,
>
> > Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> > Reported-by: <arayz_w@icloud.com>
> > ---
> >  hw/net/rocker/rocker_of_dpa.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dp=
a.c
> > index b3b8c5bb6d..1611b79227 100644
> > --- a/hw/net/rocker/rocker_of_dpa.c
> > +++ b/hw/net/rocker/rocker_of_dpa.c
> > @@ -2039,6 +2039,11 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa=
, OfDpaGroup *group,
> >      rocker_tlv_parse_nested(tlvs, group->l2_flood.group_count,
> >                              group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
> >
> > +    if (!tlvs) {
> > +        err =3D -ROCKER_EINVAL;
> > +        goto err_out;
> > +    }
> > +
> >      for (i =3D 0; i < group->l2_flood.group_count; i++) {
> >          group->l2_flood.group_ids[i] =3D rocker_tlv_get_le32(tlvs[i + =
1]);
> >      }
> > --
> > 2.35.3
> >
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


