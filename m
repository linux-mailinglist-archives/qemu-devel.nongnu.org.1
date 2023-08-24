Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74160786450
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 02:47:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYyUH-0001c1-Mb; Wed, 23 Aug 2023 20:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYyUF-0001bE-TX
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:46:11 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYyUD-0005UW-E8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:46:11 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so9545424e87.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692837967; x=1693442767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dbnTJp4sfEMMkLHBALWYRtovrkk4Vmgor09QC7kBrc=;
 b=EGKy37kT+K12vDRzIEczJcmYRih5Z63GPG6ZVPPX7qkzWY/oIf8sbEEC3natdW3e9J
 NH05c/wVofB5j3DOLZNc8dx3Z7eGiFafyFlt3l+qe21VKOM+U1gcehkQ8/6Bi3XLuUCe
 vaLfM7GGiiwFyFwjfO7a9ABNjFub31xFwM2Of7TQ8XhJJuyaL9eg9+FCa2rZ6fmOzpgh
 B2Pg4ZPLeUvcR4igBcgFTuFAvu9XhB8o+VElvOh4907SEA9B1J/0MFXMGKlpD1hpUFlE
 SN/Km2NKmso8QCCVc8OKANXA+k2i12dDFmS2OxQ3fO+5/9aipciR7a3zXYbUZJcAIJEA
 nUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692837967; x=1693442767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dbnTJp4sfEMMkLHBALWYRtovrkk4Vmgor09QC7kBrc=;
 b=El88NlKChV/zsRODLcF/TZP+E9TdUHJHG4Q5ae08t/PSmGo2CCFchhNWCPlMlSnFSn
 j5SQvZS/WJ+EFELIuHAvPlTGt5JH1wfyYznyZi8xxfdO6eaw6o85V6BHJpRDcA0/syI4
 3PYUdx0cG1EIaZugKBTDShRkj9ZXada05pZsomsppGEDvkBOSvrFkhbQwDTGsJwJ2au/
 6c4TtgCri/i3ly0nFxwCd6TtJkdQ407jkz1gkS7yiZnGsStKIsojC5sdoQl2gdEhZ3+j
 UWxSSkMm0w/IDtgvj4WIiNO4K1JCgnktB07xqO4zBMVvjWPSGIFQNvRuVMswX+SZgMhd
 xHUg==
X-Gm-Message-State: AOJu0YzdIEjTIOO5t/t9odm791+TrTfBjKXVNYUGlgaoFCCzpAxpdd7H
 G3jfEVnBUpUWvC0RyXpa0p9lYgNZnfeSTIzuPoQ=
X-Google-Smtp-Source: AGHT+IHaa+EW3MP0NdRUCMqUoS3pVVW/D4fHGQg1VZWDJ1oKzydfmZIWnVu563ZNAscAVIvZ+I2c3a98O+170WKcM/8=
X-Received: by 2002:a19:5f19:0:b0:4ff:9f8b:f7ff with SMTP id
 t25-20020a195f19000000b004ff9f8bf7ffmr8649558lfb.43.1692837966626; Wed, 23
 Aug 2023 17:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
 <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
 <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
 <CGME20230823145848eucas1p27f88a6af04a2919d618a844ee5375239@eucas1p2.samsung.com>
 <CAAAx-8+ugwD4a3NEs36afYREKpf8LPj1jUpLNrO7gFugdVs+fg@mail.gmail.com>
 <ZOZVi2FVAmj4qnXV@cormorant.local>
In-Reply-To: <ZOZVi2FVAmj4qnXV@cormorant.local>
From: Sam Li <faithilikerun@gmail.com>
Date: Thu, 24 Aug 2023 08:45:33 +0800
Message-ID: <CAAAx-8K=pKi-42uGboLwWsjo=962AENoOL210cnW8O_ab1+5=Q@mail.gmail.com>
Subject: Re: NVMe ZNS last zone size
To: Klaus Jensen <k.jensen@samsung.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x132.google.com
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

Klaus Jensen <k.jensen@samsung.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Aug 23 22:58, Sam Li wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 22:41=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, 23 Aug 2023 at 10:24, Sam Li <faithilikerun@gmail.com> wrote:
> > > >
> > > > Hi Stefan,
> > > >
> > > > Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=8823=E6=97=A5=E5=91=A8=E4=B8=89 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi Sam and Klaus,
> > > > > Val is adding nvme-io_uring ZNS support to libblkio
> > > > > (https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and a=
sked
> > > > > how to test the size of the last zone when the namespace's total =
size
> > > > > is not a multiple of the zone size.
> > > >
> > > > I think a zone report operation can do the trick. Given zone config=
s,
> > > > the size of last zone should be [size - (nr_zones - 1) * zone_size]=
.
> > > > Reporting last zone on such devices tells whether the value is
> > > > correct.
> > >
> > > In nvme_ns_zoned_check_calc_geometry() the number of zones is rounded=
 down:
> > >
> > >   ns->num_zones =3D le64_to_cpu(ns->id_ns.nsze) / ns->zone_size;
> > >
> > > Afterwards nsze is recalculated as follows:
> > >
> > >   ns->id_ns.nsze =3D cpu_to_le64(ns->num_zones * ns->zone_size);
> > >
> > > I interpret this to mean that when the namespace's total size is not =
a
> > > multiple of the zone size, then the last part will be ignored and not
> > > exposed as a zone.
> >
> > I see. Current ZNS emulation does not support this case.
> >
>
> NVMe Zoned Namespaces requires all zones to be the same size. The
> "trailing zone" is a thing in SMR HDDs.

Thanks! Then qcow2 with ZNS should also ignore the trailing zone.

Sam

