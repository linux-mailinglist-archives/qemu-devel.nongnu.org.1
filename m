Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36D7FE8D7
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 06:54:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Zzi-0007Tb-0U; Thu, 30 Nov 2023 00:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r8Zzf-0007Sk-7N
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 00:53:47 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r8ZzV-0002yz-Mf
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 00:53:39 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-46447559b88so164897137.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 21:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701323616; x=1701928416; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mgq0XUokpMEwm/lyaTuRlVPlG/Ztry5zPvlFvOzXz64=;
 b=PLb3roO3yOhdYWb4eOz6kdZmnn28bkXFY8iAWKS4e+w4SgRj9g2LslsUzMvZOi/Sj2
 r2zvsqSuw7uIf2k3T8JbbnsRwhRw/J/bIsVkda1q8S9pITqkrSQL6m+6WnWF5kWaHr30
 s0IFcSGgceXI3R66TR44RUB9YLcqNOBBROa7roAuXRY7ElmVXeq9PqRbtHGqAOZ/V5x3
 AULBG+3mP5TcYf7Th0iRx6FdtgvmbXpz/HNQBUHFJpZxSgv2s8NSteyHEJ9InZtBDZad
 cuVk5jt6fpJ1AyUK6f49/Ucw3OaL5rrqDiP7RDpaiRr45UrUdYLjMVsrevI3arBm402A
 lUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701323616; x=1701928416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mgq0XUokpMEwm/lyaTuRlVPlG/Ztry5zPvlFvOzXz64=;
 b=NOuGKPod8bnKb6YxCAl+daq325vJh/uK9VIcU6DBo1fHjNtYcYUDpu5rAJVntPgvZT
 iPVAIRHPBEVPVZVrKnusgSfn222wl+zRasJwMZxV3GT+YKgUk6FCK5UBVonSh17c25OT
 XxO5uTn+2r2JlDkDhC7sDCXBxWQieYjB8GYBCAIx2Qmxkpu897kCAaMy8qrJz8Nd2isT
 KohfZ6dQsyUzVNVBfM/t3zHUs16uQhuL6eQP1NAaxfsDlHMAEJgstnh5NG7kvTrLFyEb
 tuoW/Yu7clhbRHijTjHUot8vULIEQTZo8+VS2kAmt84qNLEjlTnmfUCB80asCnP5hGxz
 Ncgg==
X-Gm-Message-State: AOJu0YxtPn5Qf216FvDKeBasfVHjnK4YoegPd9tCn5eTlr6TMiK3pBTb
 DnwE5sH3fvhipMa7wr2YhvJTu0H43+DR3ov+/+3zip9Ne3TARg==
X-Google-Smtp-Source: AGHT+IErKSG7ighF2ltt6mrv2NoRdVrtfHmLSvVkH6T0kAwAhb0ZBswwgJEmW/dnLiO8CAiX182F43CIW91BdTxMrY0=
X-Received: by 2002:a05:6102:3746:b0:462:866e:2f2f with SMTP id
 u6-20020a056102374600b00462866e2f2fmr18151988vst.9.1701323616445; Wed, 29 Nov
 2023 21:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-3-42.hyeyoo@gmail.com>
 <20231127175322.k3zt65vicd4o2ifv@offworld>
 <CAB=+i9RkLLXTcKNKw9j1EAHEu8ixCzeum88vsYj3mYW6MsbVgQ@mail.gmail.com>
 <20231128124611.0000663e@Huawei.com>
In-Reply-To: <20231128124611.0000663e@Huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Thu, 30 Nov 2023 14:53:26 +0900
Message-ID: <CAB=+i9Q_RXst4yMqB6FGo-i9tMLHNd_UMO3zPs5jxdOgHKtPYA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hw/mem/cxl_type3: allocate more vectors for MSI-X
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 28, 2023 at 9:46=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 28 Nov 2023 09:27:28 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> > On Tue, Nov 28, 2023 at 2:53=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.=
net> wrote:
> > >
> > > On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:
> > >
> > > >commit 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background
> > > >completion") enables notifying background command completion via MSI=
-X
> > > >interrupt (vector number 9).
> > > >
> > > >However, the commit uses vector number 9 but the maximum number of
> > > >entries is less thus resulting in error below. Fix it by passing
> > > >nentries =3D 10 when calling msix_init_exclusive_bar().
> > >
> > > Hmm yeah this was already set to 10 in Jonathan's tree, thanks for re=
porting.
> >
> > Oh, yeah, it's based on the mainline tree. I should have checked Jonath=
an's.
> >
> > hmm it's already 10 there but vector number 9 is already being used by =
PCIe DOE.
> > So I think it should change msix_num =3D 11 and use vector number 10 fo=
r
> > background command completion interrupt instead?
> >
> > https://gitlab.com/jic23/qemu/-/commit/2823f19188664a6d48a965ea8170c9ef=
a23cddab
>
> Whilst I clearly messed up a rebase as this wasn't intended, it should be=
 fine
> to have multiple things sharing a vector.

I wasn't 100% sure of that, thanks for confirming.
I'll drop this patch in v2 (assuming it's going to be fixed in the
next PR of your tree)

For my own learning, I would like to give a few questions
(sorry to bother, no pressures):

> On my todo list is making the case of too few vectors being available wor=
k for
> all the cases in which case everything may end up on one vector.

You mean the device needs to support sharing
a vector for different features?

> So we do need to expand the vectors to cover what we are asking for, but
> moving this to 11 is a nice to have rather than required.

May I ask what do you mean by "expand the vectors" to cover what we
are asking for?

Thanks!
--
Hyeonggon

