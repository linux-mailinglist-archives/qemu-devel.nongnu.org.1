Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5078BE67
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 08:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qasCn-0005gd-12; Tue, 29 Aug 2023 02:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qasCk-0005WP-6T; Tue, 29 Aug 2023 02:27:58 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qasCh-0007Os-Jo; Tue, 29 Aug 2023 02:27:57 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50078e52537so6137494e87.1; 
 Mon, 28 Aug 2023 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693290473; x=1693895273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHDqDHDStg7TRJUrS/6HYlfJMY3rJsAbBQ05FCnhSv0=;
 b=bXMivHLx08R3cnmOTPpfNc0t4aODvjPr39ohHe+Eotg3+NGp50GNuDXw783U8JGqWB
 POWB6ZUYersNdsGVxwet2vAlmz7LRNVCO8SBOaon/YIL39WN7eigePPZm0/rnAnWjyze
 I13qq0BThM7TcnIeycNeO+qMCpAn6FEq8qmynAo0g0ijitC7xuDCJBsj/DXVTqO/qUPA
 6fuNrft4aqhp7osWor5hS7Gy+CltiHYxAqorrLkOUMHxrWHd1Vgz4uLcllzs4rJViOL9
 ll9MKXPARp255bY60a3jG6YSsaUh+hHSSiSttQ9GVI1FMebyZss9iElK+qvB+njly5sx
 b6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693290473; x=1693895273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHDqDHDStg7TRJUrS/6HYlfJMY3rJsAbBQ05FCnhSv0=;
 b=UmFINFwkAV7u/g8dmIc6UH0r+QHEhDHG1V1hjY39ccYpuB8elPgUtRbaGHcishVHwM
 qXFO7Znu932ZAE83inBdEpYL9TP/KAlnaUHgckh+mGunpI/6opdqoteR5ypv1nZHwdJW
 0nu4J4F+2mBeKdAO6brYVnMIGR4GHnabz9B0vxsnaa08GkDnM1NkyyI1LKv/GMjzmyBm
 +JAkoMefroXy50NeaFCAN/r8TLLiOcJtqsDN9Sijx5w+eriC51ZKVNWa8CSCYa1fBTM5
 nNf4rtsOHWEOGCTDlI7s8eN5nbVQtwJD60B1J+h03XyAj2YushdXKDeN5/9ldu1VQp4B
 WXUg==
X-Gm-Message-State: AOJu0Yz5qx+rxF9p1TZX4SKGeQMpxYCUABbSUEKvsnPTGJtlGRjWGlHS
 WxkbouSfl+MTtMf0bvdgV1L2p5bktTP27h3TxOgKYKjSu83tSRc1lr4=
X-Google-Smtp-Source: AGHT+IEMTNGOgoJIf2MNL5s+SHTmq1FwCO7ZzTWszjYUpClNPJFWECYueYnePyIWzuzvQq3fVV1T4YCi2j605bnLy6Q=
X-Received: by 2002:a05:6512:104c:b0:500:b679:ad3b with SMTP id
 c12-20020a056512104c00b00500b679ad3bmr5723866lfb.53.1693290471895; Mon, 28
 Aug 2023 23:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
 <20230822194814.GB37847@fedora>
 <CAAAx-8KQOBxt3S+nB0MNtOdG_8SZVg1HOud0hp65A+LXUrL-fw@mail.gmail.com>
 <4c167bfe-2b93-358d-8e13-9e4fc1016766@kernel.org>
In-Reply-To: <4c167bfe-2b93-358d-8e13-9e4fc1016766@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 29 Aug 2023 14:27:20 +0800
Message-ID: <CAAAx-8J3TUanrC+-tpTO+xYYXH031S2AeirNAkdDE7wtGrT63g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x12e.google.com
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
=97=A5=E5=91=A8=E4=BA=8C 14:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/28/23 20:55, Sam Li wrote:
> >>> +            /* close one implicitly open zones to make it available =
*/
> >>> +            for (int i =3D s->zoned_header.zone_nr_conv;
> >>> +            i < bs->bl.nr_zones; ++i) {
> >>> +                uint64_t *wp =3D &s->wps->wp[i];
> >>> +                if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> >>> +                    ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOS=
ED);
> >>
> >> I'm wondering if it's correct to store the zone state persistently in
> >> the qcow2 file. If the guest or QEMU crashes, then zones will be left =
in
> >> states like EOPEN. Since the guest software will have forgotten about
> >> explicitly opened zones, the guest would need to recover zone states.
> >> I'm not sure if existing software is designed to do that.
> >>
> >> Damien: Should the zone state be persistent?
>
> Yes and no. Yes you need to preserve/maintain zone states but not as is.
> With a real drive, if you power cycle the device, you get the following s=
tates
> changes:
>
>  Before         | After power cycle
> ----------------+-------------------
>  EMPTY          | EMPTY
>  FULL           | FULL
>  IMP. OPEN      | CLOSED
>  EXP. OPEN      | CLOSED
>  CLOSED         | CLOSED
>  READ=3DONLY      | READ-ONLY
>  OFFLINE        | OFFLINE
>
> So any open (implicit or explicit) zone will show up as closed after powe=
r
> cycle. That is, the number of "active" zones does not change.
> For the qcow2 emulation, as long as you do not also emulate read-only and
> offline zones, you actually do not need to save the zone state in the zon=
e
> metadata. On startup, you can infer the state from the zone write pointer=
:
>
> zone wp =3D=3D zone start -> EMPTY
> zone wp >=3D zone capacity -> FULL
> zone wp > zone start -> CLOSED
>
> And make sure that all closed zones are counted as the initial number of =
active
> zones. The initial number of open zones will always be 0.
>
> So it is easy :)

Thanks for the explanations!

Read-only and offline are device internal events. Does qcow2 emulation
need to emulate that?

Current NVMe ZNS emulation in QEMU has a nvme_offline_zone() function.
Does it suggest keeping the offline state persistent?
https://github.com/qemu/qemu/blob/master/hw/nvme/ctrl.c#L3740

Sam

