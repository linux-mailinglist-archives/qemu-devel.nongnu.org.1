Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE9786045
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 21:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYt5D-0008KS-H8; Wed, 23 Aug 2023 15:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYt57-0008Gk-Qk
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:59:53 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYt55-0005Ox-Ke
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:59:53 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-570d0567929so94835eaf.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692817190; x=1693421990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXNO9VfikqJqV5N4Kqnf4E9JRUbOHeQADfWJ4kwaOVI=;
 b=DssVo4BTPCuegL78AcUQ6c7JE1Q/+KBbmKxCIrBzHIrCkMmPKj1+XOUA7vaUHljt2U
 dOfjRxrksqu2V5mIxYmR3UGDYyr+pau3ERILxc7tYjzf7C4Y6DGRiyZC47ONrc0OlJxa
 SzWso/E5fLpdyFn0Shcal1A5sZDJA2ORqkkrgTsI1sb4frVSeTUS9CsQSrrBawlOUiXE
 xiOLjfYpQx0F98IKo2tNEnYaB+/HvgReV+xYjQlfV/o0vUgdNtSWmWh3Zo+o7XzdqhX+
 6shgYN5B0eJiCl7LQNY6QF8wOFfBWP2w6lvfDm1Wq5u+mYpLTJdD2RN/oCkBrgbVWAKX
 aBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692817190; x=1693421990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XXNO9VfikqJqV5N4Kqnf4E9JRUbOHeQADfWJ4kwaOVI=;
 b=I/MAmB4aRxwAkgBeECXFr7X5Ae0efqNL8g/TFh2fmX9oN0g64uMc3pzS5nS+REcdYj
 AbQ5Ylh3A/BYOLTEt7FPWJg2REntFuTeWQ/MhYetvdMqWkTFtJOQK7EMCdbndPLGXMHJ
 KWt1AYZ3tyfN2tHrXmlXtj0AczbYARZzsLGgmSj96n83S4CiUrEjYe3MfNxEuwZEXCqO
 ZXGZfbO7oaOFJyU4EYMFEPK5LMxv/HY4HjL6dPuYUku8x6gbYCSMgccpclpI6hVZOicT
 NC5aZ02mlvn/sn6lhoKBXDghLw4iattB82PiCA/qeuySpfiRpeKFlDuRAz8JCOm3gBOl
 BTAg==
X-Gm-Message-State: AOJu0Yw855fxJu2dC08kIpZckeHk/cSemv7jyxKemlPX/JeD4LceQOcy
 c9jAlRm/mCdcAM+4zfcYzfX1xhrza7R1QbDvNh0=
X-Google-Smtp-Source: AGHT+IFSjmwGy3xb0KLXZMc01rAvI8thqwb/4srJhGzXrAgVktNgjQk/Vte1r2GaXUguqGGlLaIkb/uzHdr1J2nPpD0=
X-Received: by 2002:a4a:d036:0:b0:56c:a9fe:f701 with SMTP id
 w22-20020a4ad036000000b0056ca9fef701mr85261oor.3.1692817190243; Wed, 23 Aug
 2023 11:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
 <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
 <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
 <CGME20230823145848eucas1p27f88a6af04a2919d618a844ee5375239@eucas1p2.samsung.com>
 <CAAAx-8+ugwD4a3NEs36afYREKpf8LPj1jUpLNrO7gFugdVs+fg@mail.gmail.com>
 <ZOZVi2FVAmj4qnXV@cormorant.local>
In-Reply-To: <ZOZVi2FVAmj4qnXV@cormorant.local>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 23 Aug 2023 14:59:38 -0400
Message-ID: <CAJSP0QWX3vAkn=nmCDTiNA6DdUXYnMBkcGeESBXTf4SU=0xQqA@mail.gmail.com>
Subject: Re: NVMe ZNS last zone size
To: Klaus Jensen <k.jensen@samsung.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Wed, 23 Aug 2023 at 14:53, Klaus Jensen <k.jensen@samsung.com> wrote:
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

Thanks for letting me know.

Stefan

